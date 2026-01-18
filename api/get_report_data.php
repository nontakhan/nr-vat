<?php
/**
 * API: ดึงข้อมูลรายงานตาม Configuration
 * สร้าง SQL query แบบ dynamic จาก report_config
 */

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');

require_once __DIR__ . '/../config/database.php';

// ตรวจสอบ parameters
$report_id = isset($_GET['report_id']) ? intval($_GET['report_id']) : 0;
$start_date = isset($_GET['start_date']) ? $_GET['start_date'] : '';
$end_date = isset($_GET['end_date']) ? $_GET['end_date'] : '';

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

    // สร้าง SQL query แบบ dynamic
    $main_table = $config['main_table'];
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

    // สร้าง query สำหรับรายรับ
    $income_query = "SELECT 
                        '$income_value' as type,
                        'รายรับ' as type_name,
                        COUNT(*) as transaction_count,
                        COALESCE(SUM(" . ($income_column ?: "0") . "), 0) as total_amount
                     FROM {$main_table} a";
    
    if ($join_table) {
        $income_query .= " LEFT JOIN {$join_table} b ON {$join_condition}";
    }
    
    $income_query .= " WHERE {$base_condition}";
    
    if ($money_type_column) {
        $income_query .= " AND {$money_type_column} = '{$income_value}'";
    }
    
    if ($date_column && $start_date) {
        $income_query .= " AND {$date_column} >= :start_date_income";
    }
    
    if ($date_column && $end_date) {
        $income_query .= " AND {$date_column} <= :end_date_income";
    }
    
    if ($extra_condition) {
        $income_query .= " AND {$extra_condition}";
    }

    // สร้าง query สำหรับรายจ่าย
    $expense_query = "SELECT 
                        '$expense_value' as type,
                        'รายจ่าย' as type_name,
                        COUNT(*) as transaction_count,
                        COALESCE(SUM(" . ($expense_column ?: "0") . "), 0) as total_amount
                      FROM {$main_table} a";
    
    if ($join_table) {
        $expense_query .= " LEFT JOIN {$join_table} b ON {$join_condition}";
    }
    
    $expense_query .= " WHERE {$base_condition}";
    
    if ($money_type_column) {
        $expense_query .= " AND {$money_type_column} = '{$expense_value}'";
    }
    
    if ($date_column && $start_date) {
        $expense_query .= " AND {$date_column} >= :start_date_expense";
    }
    
    if ($date_column && $end_date) {
        $expense_query .= " AND {$date_column} <= :end_date_expense";
    }
    
    if ($extra_condition) {
        $expense_query .= " AND {$extra_condition}";
    }

    // Execute queries
    $income_stmt = $db->prepare($income_query);
    if ($date_column && $start_date) {
        $income_stmt->bindParam(':start_date_income', $start_date);
    }
    if ($date_column && $end_date) {
        $income_stmt->bindParam(':end_date_income', $end_date);
    }
    $income_stmt->execute();
    $income_data = $income_stmt->fetch();

    $expense_stmt = $db->prepare($expense_query);
    if ($date_column && $start_date) {
        $expense_stmt->bindParam(':start_date_expense', $start_date);
    }
    if ($date_column && $end_date) {
        $expense_stmt->bindParam(':end_date_expense', $end_date);
    }
    $expense_stmt->execute();
    $expense_data = $expense_stmt->fetch();

    // คำนวณยอดรวม
    $income_total = floatval($income_data['total_amount'] ?? 0);
    $expense_total = floatval($expense_data['total_amount'] ?? 0);
    $net_total = $income_total - $expense_total;

    // ส่งผลลัพธ์
    echo json_encode([
        'success' => true,
        'report_name' => $config['report_name'],
        'date_range' => [
            'start' => $start_date ?: 'ทั้งหมด',
            'end' => $end_date ?: 'ทั้งหมด'
        ],
        'summary' => [
            'income' => [
                'amount' => $income_total,
                'count' => intval($income_data['transaction_count'] ?? 0)
            ],
            'expense' => [
                'amount' => $expense_total,
                'count' => intval($expense_data['transaction_count'] ?? 0)
            ],
            'net' => $net_total
        ]
    ], JSON_UNESCAPED_UNICODE);

} catch(Exception $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'เกิดข้อผิดพลาด: ' . $e->getMessage()
    ], JSON_UNESCAPED_UNICODE);
}
