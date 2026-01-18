<?php
header('Content-Type: application/json; charset=utf-8');
error_reporting(E_ALL);
ini_set('display_errors', 0);

try {
    // Define ETL scripts
    $baseDir = dirname(__DIR__); // Root directory
    $etlDir = $baseDir . '/etl';
    
    $scripts = [
        'etl_vat_purchase_tax.py',
        'etl_vat_other_income.py',
        'etl_vat_all_transection.py'
    ];

    $results = [];
    $totalSuccess = 0;
    $hasError = false;

    // Detect Python executable
    // Try 'python3' first (Linux/Mac), then 'python' (Windows)
    $pythonCmd = 'python';
    if (strtoupper(substr(PHP_OS, 0, 3)) !== 'WIN') {
        $checkPython3 = shell_exec('which python3');
        if (!empty($checkPython3)) {
            $pythonCmd = 'python3';
        }
    }

    // Check if ETL directory exists
    if (!is_dir($etlDir)) {
        throw new Exception("ไม่พบโฟลเดอร์ ETL ($etlDir)");
    }

    foreach ($scripts as $script) {
        $filePath = $etlDir . '/' . $script;
        
        if (!file_exists($filePath)) {
            $results[] = [
                'script' => $script,
                'status' => 'error',
                'message' => 'File not found'
            ];
            $hasError = true;
            continue;
        }

        // Execute script
        $command = escapeshellcmd("$pythonCmd \"$filePath\"") . " 2>&1";
        $output = [];
        $returnVar = 0;
        
        exec($command, $output, $returnVar);

        $outputStr = implode("\n", $output);
        
        if ($returnVar === 0) {
            $results[] = [
                'script' => $script,
                'status' => 'success',
                'message' => 'Executed successfully',
                'output' => $outputStr
            ];
            $totalSuccess++;
        } else {
            $results[] = [
                'script' => $script,
                'status' => 'error',
                'message' => "Execution failed (Code: $returnVar)",
                'output' => $outputStr
            ];
            $hasError = true;
        }
    }

    echo json_encode([
        'success' => !$hasError,
        'message' => $hasError ? 'บางสคริปต์ทำงานไม่สำเร็จ' : 'ประมวลผลข้อมูลเสร็จสมบูรณ์',
        'results' => $results,
        'details' => [
            'total' => count($scripts),
            'success_count' => $totalSuccess,
            'python_cmd' => $pythonCmd
        ]
    ]);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => $e->getMessage()
    ]);
}
?>
