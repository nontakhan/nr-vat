<?php
/**
 * API: Get Report Configurations with Summary Data
 * Returns all active report configurations with income/expense summary
 */

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');

require_once '../config/database.php';

try {
    $database = new Database();
    $db = $database->getConnection();
    
    // Get start and end date from query params (default to current month)
    $startDate = isset($_GET['start_date']) ? $_GET['start_date'] : date('Y-m-01');
    $endDate = isset($_GET['end_date']) ? $_GET['end_date'] : date('Y-m-t');
    
    // Get all active configurations
    $query = "SELECT * FROM report_config WHERE is_active = 1 ORDER BY sort_order ASC, report_id ASC";
    $stmt = $db->prepare($query);
    $stmt->execute();
    
    $configs = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    // Whitelist of allowed tables
    $allowedTables = ['all_transactions', 'other_income_expense', 'purchase_tax'];
    $allowedJoinTables = ['docgroup_type', 'other_income_type'];
    
    // Add summary data for each config
    foreach ($configs as &$config) {
        // Validate table names
        if (!in_array($config['main_table'], $allowedTables)) {
            $config['summary'] = ['income' => 0, 'expense' => 0, 'net' => 0];
            continue;
        }
        
        if ($config['join_table'] && !in_array($config['join_table'], $allowedJoinTables)) {
            $config['summary'] = ['income' => 0, 'expense' => 0, 'net' => 0];
            continue;
        }
        
        // Determine date column based on table
        $dateColumn = 'a.DOCDATE';
        if ($config['main_table'] === 'other_income_expense' || $config['main_table'] === 'purchase_tax') {
            $dateColumn = 'a.docdate';
        }
        
        // Add table prefix for money_type_column if needed
        $moneyTypeColumnQualified = $config['money_type_column'];
        if ($config['money_type_column'] && $config['join_table']) {
            // If column doesn't have a prefix (a. or b.), add b. prefix (from join table)
            if (strpos($config['money_type_column'], '.') === false) {
                $moneyTypeColumnQualified = 'b.' . $config['money_type_column'];
            }
        }
        
        // Build INCOME query
        $incomeSQL = "SELECT COALESCE(SUM(" . ($config['income_column'] ?: "0") . "), 0) as total_income ";
        $incomeSQL .= "FROM {$config['main_table']} a ";
        
        if (!empty($config['join_table']) && !empty($config['join_condition'])) {
            $incomeSQL .= "LEFT JOIN {$config['join_table']} b ON {$config['join_condition']} ";
        }
        
        $incomeSQL .= "WHERE {$config['base_condition']} ";
        
        if (!empty($moneyTypeColumnQualified) && !empty($config['income_value'])) {
            $incomeSQL .= "AND {$moneyTypeColumnQualified} = :income_value ";
        }
        
        $incomeSQL .= "AND {$dateColumn} >= :start_date_income ";
        $incomeSQL .= "AND {$dateColumn} <= :end_date_income ";
        
        if (!empty($config['extra_condition'])) {
            $incomeSQL .= "AND {$config['extra_condition']} ";
        }
        
        // Build EXPENSE query
        $expenseSQL = "SELECT COALESCE(SUM(" . ($config['expense_column'] ?: "0") . "), 0) as total_expense ";
        $expenseSQL .= "FROM {$config['main_table']} a ";
        
        if (!empty($config['join_table']) && !empty($config['join_condition'])) {
            $expenseSQL .= "LEFT JOIN {$config['join_table']} b ON {$config['join_condition']} ";
        }
        
        $expenseSQL .= "WHERE {$config['base_condition']} ";
        
        if (!empty($moneyTypeColumnQualified) && !empty($config['expense_value'])) {
            $expenseSQL .= "AND {$moneyTypeColumnQualified} = :expense_value ";
        }
        
        $expenseSQL .= "AND {$dateColumn} >= :start_date_expense ";
        $expenseSQL .= "AND {$dateColumn} <= :end_date_expense ";
        
        if (!empty($config['extra_condition'])) {
            $expenseSQL .= "AND {$config['extra_condition']} ";
        }
        
        try {
            // Execute income query
            $incomeStmt = $db->prepare($incomeSQL);
            if (!empty($config['income_value'])) {
                $incomeStmt->bindParam(':income_value', $config['income_value']);
            }
            $incomeStmt->bindParam(':start_date_income', $startDate);
            $incomeStmt->bindParam(':end_date_income', $endDate);
            $incomeStmt->execute();
            $incomeResult = $incomeStmt->fetch(PDO::FETCH_ASSOC);
            
            // Execute expense query
            $expenseStmt = $db->prepare($expenseSQL);
            if (!empty($config['expense_value'])) {
                $expenseStmt->bindParam(':expense_value', $config['expense_value']);
            }
            $expenseStmt->bindParam(':start_date_expense', $startDate);
            $expenseStmt->bindParam(':end_date_expense', $endDate);
            $expenseStmt->execute();
            $expenseResult = $expenseStmt->fetch(PDO::FETCH_ASSOC);
            
            $income = floatval($incomeResult['total_income'] ?? 0);
            $expense = floatval($expenseResult['total_expense'] ?? 0);
            $net = $income - $expense;
            
            $config['summary'] = [
                'income' => $income,
                'expense' => $expense,
                'net' => $net
            ];
        } catch (PDOException $e) {
            // If query fails, set summary to zero
            $config['summary'] = ['income' => 0, 'expense' => 0, 'net' => 0];
        }
    }
    
    echo json_encode([
        'success' => true,
        'data' => $configs,
        'count' => count($configs),
        'date_range' => [
            'start' => $startDate,
            'end' => $endDate
        ]
    ], JSON_UNESCAPED_UNICODE);
    
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'เกิดข้อผิดพลาด: ' . $e->getMessage()
    ], JSON_UNESCAPED_UNICODE);
}
