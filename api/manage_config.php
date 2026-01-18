<?php
/**
 * API: จัดการ Report Configuration (CRUD)
 */

header('Content-Type: application/json; charset=utf-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

require_once '../config/database.php';

$method = $_SERVER['REQUEST_METHOD'];

try {
    $database = new Database();
    $db = $database->getConnection();

    switch ($method) {
        case 'GET':
            // ดึงรายการทั้งหมด (รวม inactive)
            $query = "SELECT * FROM report_config ORDER BY sort_order ASC, report_id ASC";
            $stmt = $db->prepare($query);
            $stmt->execute();
            $configs = $stmt->fetchAll();

            echo json_encode([
                'success' => true,
                'data' => $configs
            ], JSON_UNESCAPED_UNICODE);
            break;

        case 'POST':
            // เพิ่ม config ใหม่
            $data = json_decode(file_get_contents('php://input'), true);
            
            // Validation
            if (empty($data['report_name']) || empty($data['main_table'])) {
                throw new Exception('กรุณากรอกข้อมูลให้ครบถ้วน');
            }

            // หา sort_order ถัดไป
            $max_query = "SELECT COALESCE(MAX(sort_order), 0) + 1 as next_order FROM report_config";
            $max_stmt = $db->prepare($max_query);
            $max_stmt->execute();
            $next_order = $max_stmt->fetch()['next_order'];

            $insert_query = "INSERT INTO report_config (
                report_name, is_active, sort_order, button_color, button_icon,
                main_table, join_table, join_condition, money_type_column,
                income_value, expense_value, special_value,
                income_column, expense_column, special_expense_column,
                base_condition, extra_condition, display_columns
            ) VALUES (
                :report_name, :is_active, :sort_order, :button_color, :button_icon,
                :main_table, :join_table, :join_condition, :money_type_column,
                :income_value, :expense_value, :special_value,
                :income_column, :expense_column, :special_expense_column,
                :base_condition, :extra_condition, :display_columns
            )";

            $stmt = $db->prepare($insert_query);
            $stmt->bindParam(':report_name', $data['report_name']);
            $stmt->bindValue(':is_active', $data['is_active'] ?? 1);
            $stmt->bindValue(':sort_order', $data['sort_order'] ?? $next_order);
            $stmt->bindValue(':button_color', $data['button_color'] ?? '#dc3545');
            $stmt->bindValue(':button_icon', $data['button_icon'] ?? null);
            $stmt->bindParam(':main_table', $data['main_table']);
            $stmt->bindValue(':join_table', $data['join_table'] ?? null);
            $stmt->bindValue(':join_condition', $data['join_condition'] ?? null);
            $stmt->bindParam(':money_type_column', $data['money_type_column']);
            $stmt->bindValue(':income_value', $data['income_value'] ?? 'I');
            $stmt->bindValue(':expense_value', $data['expense_value'] ?? 'E');
            $stmt->bindValue(':special_value', $data['special_value'] ?? null);
            $stmt->bindValue(':income_column', $data['income_column'] ?? null);
            $stmt->bindValue(':expense_column', $data['expense_column'] ?? null);
            $stmt->bindValue(':special_expense_column', $data['special_expense_column'] ?? null);
            $stmt->bindValue(':base_condition', $data['base_condition'] ?? '1=1');
            $stmt->bindValue(':extra_condition', $data['extra_condition'] ?? null);
            $stmt->bindValue(':display_columns', $data['display_columns'] ?? null);

            $stmt->execute();

            echo json_encode([
                'success' => true,
                'message' => 'เพิ่มการตั้งค่าสำเร็จ',
                'report_id' => $db->lastInsertId()
            ], JSON_UNESCAPED_UNICODE);
            break;

        case 'PUT':
            // แก้ไข config
            $data = json_decode(file_get_contents('php://input'), true);
            
            if (empty($data['report_id'])) {
                throw new Exception('กรุณาระบุ report_id');
            }

            $update_query = "UPDATE report_config SET
                report_name = :report_name,
                is_active = :is_active,
                sort_order = :sort_order,
                button_color = :button_color,
                button_icon = :button_icon,
                main_table = :main_table,
                join_table = :join_table,
                join_condition = :join_condition,
                money_type_column = :money_type_column,
                income_value = :income_value,
                expense_value = :expense_value,
                special_value = :special_value,
                income_column = :income_column,
                expense_column = :expense_column,
                special_expense_column = :special_expense_column,
                base_condition = :base_condition,
                extra_condition = :extra_condition,
                display_columns = :display_columns
            WHERE report_id = :report_id";

            $stmt = $db->prepare($update_query);
            $stmt->bindParam(':report_id', $data['report_id']);
            $stmt->bindParam(':report_name', $data['report_name']);
            $stmt->bindParam(':is_active', $data['is_active']);
            $stmt->bindParam(':sort_order', $data['sort_order']);
            $stmt->bindParam(':button_color', $data['button_color']);
            $stmt->bindValue(':button_icon', $data['button_icon'] ?? null);
            $stmt->bindParam(':main_table', $data['main_table']);
            $stmt->bindValue(':join_table', $data['join_table'] ?? null);
            $stmt->bindValue(':join_condition', $data['join_condition'] ?? null);
            $stmt->bindParam(':money_type_column', $data['money_type_column']);
            $stmt->bindParam(':income_value', $data['income_value']);
            $stmt->bindParam(':expense_value', $data['expense_value']);
            $stmt->bindValue(':special_value', $data['special_value'] ?? null);
            $stmt->bindValue(':income_column', $data['income_column'] ?? null);
            $stmt->bindValue(':expense_column', $data['expense_column'] ?? null);
            $stmt->bindValue(':special_expense_column', $data['special_expense_column'] ?? null);
            $stmt->bindParam(':base_condition', $data['base_condition']);
            $stmt->bindValue(':extra_condition', $data['extra_condition'] ?? null);
            $stmt->bindValue(':display_columns', $data['display_columns'] ?? null);

            $stmt->execute();

            echo json_encode([
                'success' => true,
                'message' => 'แก้ไขการตั้งค่าสำเร็จ'
            ], JSON_UNESCAPED_UNICODE);
            break;

        case 'DELETE':
            // ลบ config
            $data = json_decode(file_get_contents('php://input'), true);
            
            if (empty($data['report_id'])) {
                throw new Exception('กรุณาระบุ report_id');
            }

            $delete_query = "DELETE FROM report_config WHERE report_id = :report_id";
            $stmt = $db->prepare($delete_query);
            $stmt->bindParam(':report_id', $data['report_id']);
            $stmt->execute();

            echo json_encode([
                'success' => true,
                'message' => 'ลบการตั้งค่าสำเร็จ'
            ], JSON_UNESCAPED_UNICODE);
            break;

        default:
            throw new Exception('Method not allowed');
    }

} catch(Exception $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'เกิดข้อผิดพลาด: ' . $e->getMessage()
    ], JSON_UNESCAPED_UNICODE);
}
