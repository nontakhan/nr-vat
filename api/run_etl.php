<?php
/**
 * Run ETL API - Calls remote ETL Server
 * This file stays on Web Server (10.10.202.61)
 * It calls ETL Server (10.10.202.156) to execute Python scripts
 */

header('Content-Type: application/json; charset=utf-8');
error_reporting(E_ALL);
ini_set('display_errors', 0);

// ETL Server configuration
$ETL_SERVER_URL = 'http://10.10.202.156/etl_runner.php';
$ETL_SECRET_TOKEN = 'nr-vat-etl-2026';

try {
    // Initialize cURL
    $ch = curl_init();
    
    curl_setopt_array($ch, [
        CURLOPT_URL => $ETL_SERVER_URL,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => json_encode(['token' => $ETL_SECRET_TOKEN]),
        CURLOPT_HTTPHEADER => [
            'Content-Type: application/json',
            'Authorization: Bearer ' . $ETL_SECRET_TOKEN
        ],
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT => 300, // 5 minutes timeout for long ETL jobs
        CURLOPT_CONNECTTIMEOUT => 10
    ]);
    
    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $curlError = curl_error($ch);
    
    curl_close($ch);
    
    // Check for cURL errors
    if ($curlError) {
        throw new Exception("ไม่สามารถเชื่อมต่อ ETL Server ได้: " . $curlError);
    }
    
    // Check HTTP response
    if ($httpCode !== 200) {
        $errorMsg = "ETL Server ตอบกลับด้วย HTTP $httpCode";
        if ($response) {
            $decoded = json_decode($response, true);
            if (isset($decoded['message'])) {
                $errorMsg .= ": " . $decoded['message'];
            }
        }
        throw new Exception($errorMsg);
    }
    
    // Parse response
    $result = json_decode($response, true);
    
    if (json_last_error() !== JSON_ERROR_NONE) {
        throw new Exception("Invalid JSON response from ETL Server");
    }
    
    // Add source info
    $result['source'] = [
        'etl_server' => '10.10.202.156',
        'web_server' => '10.10.202.61'
    ];
    
    echo json_encode($result, JSON_UNESCAPED_UNICODE);

} catch (Exception $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => $e->getMessage(),
        'source' => [
            'etl_server' => '10.10.202.156',
            'web_server' => '10.10.202.61'
        ]
    ], JSON_UNESCAPED_UNICODE);
}
?>
