<?php
/**
 * ETL Runner API for Remote Execution
 * Deploy this file to ETL Server: 10.10.202.156
 * Path: /var/www/html/etl_runner.php
 */

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

// Handle preflight request
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    http_response_code(200);
    exit;
}

// Simple security token (change this!)
$SECRET_TOKEN = 'nr-vat-etl-2026';

// Verify token
$headers = getallheaders();
$authHeader = isset($headers['Authorization']) ? $headers['Authorization'] : '';
$providedToken = str_replace('Bearer ', '', $authHeader);

// Also accept token from POST body or query string
if (empty($providedToken)) {
    $input = json_decode(file_get_contents('php://input'), true);
    $providedToken = isset($input['token']) ? $input['token'] : '';
}
if (empty($providedToken)) {
    $providedToken = isset($_GET['token']) ? $_GET['token'] : '';
}

if ($providedToken !== $SECRET_TOKEN) {
    http_response_code(401);
    echo json_encode(['success' => false, 'message' => 'Unauthorized']);
    exit;
}

try {
    // ETL scripts location
    $etlDir = '/root/etl';
    
    $scripts = [
        'mssql_to_purchase_tax.py',
        'mssql_to_vat.py',
        'mssql_to_vat_income.py'
    ];

    $results = [];
    $totalSuccess = 0;
    $hasError = false;

    // Detect Python executable
    $pythonCmd = 'python3';
    $checkPython3 = shell_exec('which python3 2>/dev/null');
    if (empty(trim($checkPython3))) {
        $pythonCmd = 'python';
    }

    // Check if ETL directory exists
    if (!is_dir($etlDir)) {
        throw new Exception("ETL directory not found: $etlDir");
    }

    foreach ($scripts as $script) {
        $filePath = $etlDir . '/' . $script;
        
        if (!file_exists($filePath)) {
            $results[] = [
                'script' => $script,
                'status' => 'error',
                'message' => 'File not found: ' . $filePath
            ];
            $hasError = true;
            continue;
        }

        // Execute script
        $command = escapeshellcmd("$pythonCmd $filePath") . " 2>&1";
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
        'message' => $hasError ? 'Some scripts failed' : 'All scripts executed successfully',
        'results' => $results,
        'details' => [
            'total' => count($scripts),
            'success_count' => $totalSuccess,
            'python_cmd' => $pythonCmd,
            'etl_dir' => $etlDir,
            'server' => gethostname()
        ]
    ], JSON_UNESCAPED_UNICODE);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => $e->getMessage()
    ], JSON_UNESCAPED_UNICODE);
}
?>
