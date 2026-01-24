<?php
/**
 * API: ดึงข้อมูลรายละเอียดรายงาน (Detail View)
 * แสดงรายการทั้งหมดแทนที่จะเป็นแค่สรุป
 */

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');

require_once __DIR__ . '/../config/database.php';

// ตรวจสอบ parameters
$report_id = isset($_GET['report_id']) ? intval($_GET['report_id']) : 0;
$start_date = isset($_GET['start_date']) ? $_GET['start_date'] : '';
$end_date = isset($_GET['end_date']) ? $_GET['end_date'] : '';
$page = isset($_GET['page']) ? max(1, intval($_GET['page'])) : 1;
$per_page = isset($_GET['per_page']) ? min(100, max(10, intval($_GET['per_page']))) : 50;

if ($report_id <= 0) {
    http_response_code(400);
    echo json_encode([
        'success' => false,
        'message' => 'กรุณาระบุ report_id'
    ], JSON_UNESCAPED_UNICODE);
    exit;
}

try {
    $database = new Database();
    $db = $database->getConnection();

    // ดึงข้อมูล config
    $config_query = "SELECT * FROM report_config WHERE report_id = :report_id AND is_active = 1";
    $config_stmt = $db->prepare($config_query);
    $config_stmt->bindParam(':report_id', $report_id);
    $config_stmt->execute();
    
    $config = $config_stmt->fetch();
    
    if (!$config) {
        throw new Exception('ไม่พบการตั้งค่ารายงาน');
    }

    // Whitelist ตารางที่อนุญาต (security)
    $allowed_tables = ['all_transactions', 'other_income_expense', 'purchase_tax'];
    $allowed_join_tables = ['docgroup_type', 'other_income_type'];
    
    if (!in_array($config['main_table'], $allowed_tables)) {
        throw new Exception('ตารางไม่ได้รับอนุญาต');
    }
    
    if ($config['join_table'] && !in_array($config['join_table'], $allowed_join_tables)) {
        throw new Exception('ตาราง join ไม่ได้รับอนุญาต');
    }

    // Get main table name first for default columns
    $main_table = $config['main_table'];

    // Parse display columns
    $display_columns = $config['display_columns'] ? json_decode($config['display_columns'], true) : [];
    if (empty($display_columns)) {
        // Default columns ตาม main_table
        switch ($main_table) {
            case 'purchase_tax':
                $display_columns = [
                    ['column' => 'a.docno', 'label' => 'เลขที่เอกสาร'],
                    ['column' => 'a.docdate', 'label' => 'วันที่'],
                    ['column' => 'a.CUSTNAME', 'label' => 'ชื่อลูกค้า/ผู้ขาย'],
                    ['column' => 'a.lname', 'label' => 'ประเภท'],
                    ['column' => 'a.sumamount1b', 'label' => 'ยอดก่อนภาษี'],
                    ['column' => 'a.taxamount', 'label' => 'ภาษี']
                ];
                break;
            case 'other_income_expense':
                $display_columns = [
                    ['column' => 'a.docno', 'label' => 'เลขที่เอกสาร'],
                    ['column' => 'a.docdate', 'label' => 'วันที่'],
                    ['column' => 'a.custname', 'label' => 'ชื่อลูกค้า'],
                    ['column' => 'a.productname', 'label' => 'รายการ'],
                    ['column' => 'a.NETAMOUNT', 'label' => 'ยอดเงิน']
                ];
                break;
            default: // all_transactions
                $display_columns = [
                    ['column' => 'a.DOCNO', 'label' => 'เลขที่เอกสาร'],
                    ['column' => 'a.DOCDATE', 'label' => 'วันที่'],
                    ['column' => 'a.CUSTNAME', 'label' => 'ชื่อลูกค้า'],
                    ['column' => 'a.NETAMOUNT', 'label' => 'ยอดเงิน']
                ];
        }
    }

    // สร้าง SQL query แบบ dynamic (main_table already defined above)
    $join_table = $config['join_table'];
    $join_condition = $config['join_condition'];
    $money_type_column = $config['money_type_column'];
    $income_value = $config['income_value'];
    $expense_value = $config['expense_value'];
    $income_column = $config['income_column'];
    $expense_column = $config['expense_column'];
    $base_condition = $config['base_condition'];
    $extra_condition = $config['extra_condition'];

    // กำหนด date column ตามตารางหลัก
    $date_column = '';
    switch ($main_table) {
        case 'all_transactions':
            $date_column = 'a.DOCDATE';
            break;
        case 'other_income_expense':
            $date_column = 'a.docdate';
            break;
        case 'purchase_tax':
            $date_column = 'a.docdate';
            break;
    }

    // สร้าง SELECT columns
    $select_columns = [];
    foreach ($display_columns as $col) {
        $select_columns[] = $col['column'] . ' as `' . $col['label'] . '`';
    }
    
    // Add table prefix for money_type_column if needed
    $money_type_column_qualified = $money_type_column;
    if ($money_type_column && $join_table) {
        // If column doesn't have a prefix (a. or b.), add b. prefix (from join table)
        if (strpos($money_type_column, '.') === false) {
            $money_type_column_qualified = 'b.' . $money_type_column;
        }
    }
    
    // เพิ่ม income และ expense columns
    if ($income_column) {
        $select_columns[] = "CASE WHEN {$money_type_column_qualified} = '{$income_value}' THEN {$income_column} ELSE 0 END as income_amount";
    } else {
        $select_columns[] = "0 as income_amount";
    }
    
    if ($expense_column) {
        $select_columns[] = "CASE WHEN {$money_type_column_qualified} = '{$expense_value}' THEN {$expense_column} ELSE 0 END as expense_amount";
    } else {
        $select_columns[] = "0 as expense_amount";
    }
    
    // Add debug column to see actual money_type value
    if ($money_type_column_qualified) {
        $select_columns[] = "{$money_type_column_qualified} as debug_money_type";
    }
    
    $select_clause = implode(', ', $select_columns);

    // Debug mode - add to response
    $debug_info = [
        'income_sql' => "CASE WHEN {$money_type_column_qualified} = '{$income_value}' THEN {$income_column} ELSE 0 END",
        'expense_sql' => "CASE WHEN {$money_type_column_qualified} = '{$expense_value}' THEN {$expense_column} ELSE 0 END",
        'money_type_column' => $money_type_column,
        'money_type_column_qualified' => $money_type_column_qualified,
        'join_table' => $join_table,
        'income_value' => $income_value,
        'expense_value' => $expense_value
    ];

    // Count total records
    $count_query = "SELECT COUNT(*) as total FROM {$main_table} a";
    if ($join_table) {
        $count_query .= " LEFT JOIN {$join_table} b ON {$join_condition}";
    }
    $count_query .= " WHERE {$base_condition}";
    
    if ($date_column && $start_date) {
        $count_query .= " AND {$date_column} >= :start_date_count";
    }
    if ($date_column && $end_date) {
        $count_query .= " AND {$date_column} <= :end_date_count";
    }
    if ($extra_condition) {
        $count_query .= " AND {$extra_condition}";
    }

    $count_stmt = $db->prepare($count_query);
    if ($date_column && $start_date) {
        $count_stmt->bindParam(':start_date_count', $start_date);
    }
    if ($date_column && $end_date) {
        $count_stmt->bindParam(':end_date_count', $end_date);
    }
    $count_stmt->execute();
    $total_records = $count_stmt->fetch()['total'];
    $total_pages = ceil($total_records / $per_page);

    // Get detail records with pagination
    $offset = ($page - 1) * $per_page;
    
    $detail_query = "SELECT {$select_clause} FROM {$main_table} a";
    if ($join_table) {
        $detail_query .= " LEFT JOIN {$join_table} b ON {$join_condition}";
    }
    $detail_query .= " WHERE {$base_condition}";
    
    if ($date_column && $start_date) {
        $detail_query .= " AND {$date_column} >= :start_date";
    }
    if ($date_column && $end_date) {
        $detail_query .= " AND {$date_column} <= :end_date";
    }
    if ($extra_condition) {
        $detail_query .= " AND {$extra_condition}";
    }
    
    $detail_query .= " ORDER BY " . ($date_column ?: "1") . " DESC";
    $detail_query .= " LIMIT :limit OFFSET :offset";

    $detail_stmt = $db->prepare($detail_query);
    if ($date_column && $start_date) {
        $detail_stmt->bindParam(':start_date', $start_date);
    }
    if ($date_column && $end_date) {
        $detail_stmt->bindParam(':end_date', $end_date);
    }
    $detail_stmt->bindParam(':limit', $per_page, PDO::PARAM_INT);
    $detail_stmt->bindParam(':offset', $offset, PDO::PARAM_INT);
    
    $detail_stmt->execute();
    $records = $detail_stmt->fetchAll();

    // คำนวณสรุปยอด
    $total_income = 0;
    $total_expense = 0;
    foreach ($records as $record) {
        $total_income += floatval($record['income_amount'] ?? 0);
        $total_expense += floatval($record['expense_amount'] ?? 0);
    }

    // ส่งผลลัพธ์
    echo json_encode([
        'success' => true,
        'report_name' => $config['report_name'],
        'date_range' => [
            'start' => $start_date ?: 'ทั้งหมด',
            'end' => $end_date ?: 'ทั้งหมด'
        ],
        'columns' => $display_columns,
        'data' => $records,
        'pagination' => [
            'current_page' => $page,
            'per_page' => $per_page,
            'total_records' => intval($total_records),
            'total_pages' => $total_pages
        ],
        'summary' => [
            'total_income' => $total_income,
            'total_expense' => $total_expense,
            'net' => $total_income - $total_expense
        ],
        'debug' => $debug_info
    ], JSON_UNESCAPED_UNICODE);

} catch(Exception $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'เกิดข้อผิดพลาด: ' . $e->getMessage()
    ], JSON_UNESCAPED_UNICODE);
}
