/*
 Navicat Premium Data Transfer

 Source Server         : csmile_api
 Source Server Type    : MariaDB
 Source Server Version : 101113
 Source Host           : 10.10.202.156:3306
 Source Schema         : vat_db

 Target Server Type    : MariaDB
 Target Server Version : 101113
 File Encoding         : 65001

 Date: 17/01/2026 21:09:46
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for all_transactions
-- ----------------------------
DROP TABLE IF EXISTS `all_transactions`;
CREATE TABLE `all_transactions`  (
  `bill` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `DOCGROUP` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `LNAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `DOCNO` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `DOCDATE` date NULL DEFAULT NULL,
  `CUSTNAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `paysub_docno` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `SUMAMOUNT1` decimal(18, 2) NULL DEFAULT NULL,
  `NETAMOUNT` decimal(18, 2) NULL DEFAULT NULL,
  `DISCAMOUNT_VAT` decimal(18, 2) NULL DEFAULT NULL,
  `DISCAMOUNT_BEFORE_VAT` decimal(18, 2) NULL DEFAULT NULL,
  `DISCAMOUNT` decimal(18, 2) NULL DEFAULT NULL,
  `DEBTAMOUNT` decimal(18, 2) NULL DEFAULT NULL,
  `BEFORETAX` decimal(18, 2) NULL DEFAULT NULL,
  `SUMAMOUNT1B` decimal(18, 2) NULL DEFAULT NULL COMMENT '/3.7  sumamount มาผิด',
  `TAXAMOUNT` decimal(18, 2) NULL DEFAULT NULL,
  `DEPOSIT` decimal(18, 2) NULL DEFAULT NULL,
  `DEPOSIT_VAT` decimal(18, 2) NULL DEFAULT NULL,
  `DEPOSIT_BEFORE_VAT` decimal(18, 2) NULL DEFAULT NULL,
  `CASHAMOUNT` decimal(18, 2) NULL DEFAULT NULL,
  `BANKAMOUNT` decimal(18, 2) NULL DEFAULT NULL,
  `BOOKNO` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CREDITAMOUNT` decimal(18, 2) NULL DEFAULT NULL,
  `CSCRPASSSUB_DOCNO` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CSCRPASSSUB_BOOKNO_PASS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CSCRPASSSUB_NETAMOUNT` decimal(18, 2) NULL DEFAULT NULL,
  `CHEQUEAMOUNT` decimal(18, 2) NULL DEFAULT NULL,
  `CSCHQINPASSSUB_DOCNO` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CSCHQINPASSSUB_BOOKNO_PASS` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `CHQAMOUNT` decimal(18, 2) NULL DEFAULT NULL,
  `last_sync_timestamp` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  `INCOMEID` int(11) NULL DEFAULT NULL COMMENT 'รหัสประเภทรายรับ (ถ้ามี)',
  `INCOMEAMOUNT` decimal(18, 2) NULL DEFAULT 0.00 COMMENT 'ยอดรายรับเพิ่มเติม (อาจเป็นค่าติดลบ)',
  `EXPENDID` int(11) NULL DEFAULT NULL COMMENT 'รหัสประเภทรายจ่าย (ถ้ามี)',
  `EXPENDAMOUNT` decimal(18, 2) NULL DEFAULT 0.00 COMMENT 'ยอดรายจ่ายเพิ่มเติม (อาจเป็นค่าติดลบ)',
  `BANKEXPEND` decimal(18, 2) NULL DEFAULT 0.00 COMMENT 'ค่าธรรมเนียมธนาคารหรือรายจ่ายที่เกี่ยวกับธนาคาร',
  PRIMARY KEY (`bill`, `DOCNO`) USING BTREE,
  INDEX `idx_all_tran_docdate_docgroup`(`DOCDATE`, `DOCGROUP`) USING BTREE,
  INDEX `idx_all_tran_docdate_docno`(`DOCDATE`, `DOCNO`) USING BTREE,
  INDEX `idx_all_tran_paysub_docno`(`paysub_docno`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of all_transactions
-- ----------------------------
INSERT INTO `all_transactions` VALUES ('AR-CN', '210', 'ใบลดหนี้อื่นๆ (ท่าสาป)', 'SSV56901-0001', '2026-01-03', 'นาย มูฮำหมัด แวซู (พนง)', 'REV26901-0001', 934.58, 0.00, 0.00, 0.00, 0.00, 1000.00, 0.00, 934.58, 65.42, 0.00, 0.00, 0.00, 0.00, 0.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, '2026-01-03 17:30:28', 0, 0.00, 0, 0.00, 0.00);
INSERT INTO `all_transactions` VALUES ('DEP', '100', 'รับเงินมัดจำ - เชื่อ (สนง.ใหญ่)', 'AEV26901-0001', '2026-01-03', 'นาย มูฮำหมัด แวซู (พนง)', NULL, 0.00, 0.00, 0.00, 0.00, 0.00, 1000.00, 934.58, 0.00, 65.42, 0.00, 0.00, 0.00, 0.00, 1000.00, '01-061-228-4819', 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, '2026-01-03 17:30:28', -1, 0.00, -1, 0.00, 0.00);
INSERT INTO `all_transactions` VALUES ('DEP', '100', 'รับเงินมัดจำ - เชื่อ (สนง.ใหญ่)', 'AEV26901-0002', '2026-01-03', 'นาย มูฮำหมัด แวซู (พนง)', NULL, 0.00, 0.00, 0.00, 0.00, 0.00, 1500.00, 1401.87, 0.00, 98.13, 0.00, 0.00, 0.00, 1500.00, 0.00, '', 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, '2026-01-03 17:30:28', -1, 0.00, -1, 0.00, 0.00);
INSERT INTO `all_transactions` VALUES ('H-I', '112', 'ขายสด (หน้าตลาด)', 'H1V6901-0001', '2026-01-01', 'นาย มูฮำหมัด แวซู (พนง)', NULL, 800.00, 747.66, 0.00, 0.00, 0.00, 800.00, 747.66, 747.66, 52.34, 0.00, 0.00, 0.00, 800.00, 0.00, '', 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, '2026-01-04 11:33:08', -1, 0.00, -1, 0.00, 0.00);
INSERT INTO `all_transactions` VALUES ('H-I', '113', 'ขายสด (สำนักงานใหญ่)', 'H2V6901-0001', '2026-01-03', 'สด ลูกค้าไม่ต้องการใบกำกับภาษี', NULL, 500.00, 467.29, 0.00, 0.00, 0.00, 500.00, 467.29, 467.29, 32.71, 0.00, 0.00, 0.00, 500.00, 0.00, '', 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, '2026-01-03 17:30:28', -1, 0.00, -1, 0.00, 0.00);
INSERT INTO `all_transactions` VALUES ('H-I', '113', 'ขายสด (สำนักงานใหญ่)', 'H2V6901-0002', '2026-01-03', 'สด ลูกค้าไม่ต้องการใบกำกับภาษี', NULL, 1000.00, 934.58, 0.00, 0.00, 0.00, 1000.00, 934.58, 934.58, 65.42, 0.00, 0.00, 0.00, 0.00, 1000.00, '508-297-1293', 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, '2026-01-03 17:30:28', -1, 0.00, -1, 0.00, 0.00);
INSERT INTO `all_transactions` VALUES ('H-I', '113', 'ขายสด (สำนักงานใหญ่)', 'H2V6901-0003', '2026-01-03', 'สด ลูกค้าไม่ต้องการใบกำกับภาษี', NULL, 1500.00, 1401.87, 0.00, 0.00, 0.00, 1500.00, 1401.87, 1401.87, 98.13, 0.00, 0.00, 0.00, 0.00, 0.00, '', 1500.00, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, '2026-01-03 17:30:28', -1, 0.00, -1, 0.00, 0.00);
INSERT INTO `all_transactions` VALUES ('H-I', '113', 'ขายสด (สำนักงานใหญ่)', 'H2V6901-0004', '2026-01-03', 'สด ลูกค้าไม่ต้องการใบกำกับภาษี', NULL, 2000.00, 1869.16, 0.00, 0.00, 0.00, 2000.00, 1869.16, 1869.16, 130.84, 0.00, 0.00, 0.00, 0.00, 0.00, '', 0.00, NULL, NULL, NULL, 2000.00, NULL, NULL, NULL, '2026-01-03 17:30:28', -1, 0.00, -1, 0.00, 0.00);
INSERT INTO `all_transactions` VALUES ('H-I', '113', 'ขายสด (สำนักงานใหญ่)', 'H2V6901-0005', '2026-01-03', 'นาย มูฮำหมัด แวซู (พนง)', NULL, 1500.00, 1401.87, 0.00, 0.00, 0.00, 0.00, 0.00, 1401.87, 0.00, 1401.87, 91.71, 1310.16, 0.00, 0.00, '', 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, '2026-01-03 17:30:28', -1, 0.00, -1, 0.00, 0.00);
INSERT INTO `all_transactions` VALUES ('H-I', '113', 'ขายสด (สำนักงานใหญ่)', 'H2V6901-0006', '2026-01-04', 'นาย มูฮำหมัด แวซู (พนง)', NULL, 500.00, 467.29, 0.00, 0.00, 0.00, 500.00, 467.29, 467.29, 32.71, 0.00, 0.00, 0.00, 500.00, 0.00, '', 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, '2026-01-04 11:40:39', -1, 0.00, -1, 0.00, 0.00);
INSERT INTO `all_transactions` VALUES ('H-I', '113', 'ขายสด (สำนักงานใหญ่)', 'H2V6901-0007', '2026-01-04', 'นางสาว นิมัสรา แวซู', NULL, 90.00, 84.11, 0.00, 0.00, 0.00, 90.00, 84.11, 84.11, 5.89, 0.00, 0.00, 0.00, 90.70, 0.00, '', 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, '2026-01-04 12:14:45', 26086, 0.70, -1, 0.00, 0.00);
INSERT INTO `all_transactions` VALUES ('H-I', '113', 'ขายสด (สำนักงานใหญ่)', 'H2V6901-0008', '2026-01-04', 'นาย มูฮำหมัด แวซู (พนง)', NULL, 2588.00, 2418.69, 0.00, 0.00, 0.00, 2588.00, 2418.69, 2418.69, 169.31, 0.00, 0.00, 0.00, 0.00, 2283.00, '05-024-186-6362', 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, '2026-01-04 12:14:45', -1, 0.00, 16378, 300.00, 5.00);
INSERT INTO `all_transactions` VALUES ('H-I', '113', 'ขายสด (สำนักงานใหญ่)', 'H2V6901-0009', '2026-01-05', 'นาย มูฮำหมัด แวซู (พนง)', NULL, 50000.00, 46728.97, 0.00, 0.00, 0.00, 50000.00, 46728.97, 46728.97, 3271.03, 0.00, 0.00, 0.00, 50000.00, 0.00, '', 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, '2026-01-05 19:00:01', -1, 0.00, -1, 0.00, 0.00);
INSERT INTO `all_transactions` VALUES ('H-I', '113', 'ขายสด (สำนักงานใหญ่)', 'H2V6901-0010', '2026-01-05', 'ร้าน การค้าวัสดุ-ธารโต', NULL, 10000.00, 9345.79, 0.00, 0.00, 0.00, 10000.00, 9345.79, 9345.79, 654.21, 0.00, 0.00, 0.00, 10000.00, 0.00, '', 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, '2026-01-05 19:00:01', -1, 0.00, -1, 0.00, 0.00);
INSERT INTO `all_transactions` VALUES ('H-I', '114', 'ขายสด (ตลาดเก่า)', 'H3V6901-0001', '2026-01-04', 'นาย อะห์มัด แวซู', NULL, 100.00, 93.46, 0.00, 0.00, 0.00, 100.00, 93.46, 93.46, 6.54, 0.00, 0.00, 0.00, 99.44, 0.00, '', 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, '2026-01-04 12:14:45', -1, 0.00, 26100, 0.56, 0.00);
INSERT INTO `all_transactions` VALUES ('H-I', '115', 'ขายสด (ท่าสาป)', 'H5V6901-0001', '2026-01-03', 'นาย มูฮำหมัด แวซู (พนง)', NULL, 1500.00, 1308.41, 6.54, 93.46, 100.00, 1400.00, 1308.41, 1401.87, 91.59, 0.00, 0.00, 0.00, 0.00, 1395.00, '508-297-1293', 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, '2026-01-03 17:34:01', -1, 0.00, -1, 0.00, 5.00);
INSERT INTO `all_transactions` VALUES ('H-I', '117', 'ขายเชื่อ (สำนักงานใหญ่)', 'I2V6901-0001', '2026-01-03', 'นาย มูฮำหมัด แวซู (พนง)', 'REV26901-0001', 105.00, 93.46, 0.33, 4.67, 5.00, 100.00, 93.46, 98.13, 6.54, 0.00, 0.00, 0.00, 0.00, 0.00, '', 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, '2026-01-03 17:30:28', -1, 0.00, -1, 0.00, 0.00);
INSERT INTO `all_transactions` VALUES ('H-I', '117', 'ขายเชื่อ (สำนักงานใหญ่)', 'I2V6901-0002', '2026-01-03', 'นาย มูฮำหมัด แวซู (พนง)', NULL, 3000.00, 2803.74, 0.00, 0.00, 0.00, 3000.00, 2803.74, 2803.74, 196.26, 0.00, 0.00, 0.00, 0.00, 0.00, '', 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, '2026-01-03 17:30:28', -1, 0.00, -1, 0.00, 0.00);
INSERT INTO `all_transactions` VALUES ('H-I', '117', 'ขายเชื่อ (สำนักงานใหญ่)', 'I2V6901-0003', '2026-01-03', 'นาย มูฮำหมัด แวซู (พนง)', 'REV26901-0001', 1500.00, 1401.87, 0.00, 0.00, 0.00, 1500.00, 1401.87, 1401.87, 98.13, 0.00, 0.00, 0.00, 0.00, 0.00, '', 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, '2026-01-03 17:30:28', -1, 0.00, -1, 0.00, 0.00);
INSERT INTO `all_transactions` VALUES ('H-I', '118', 'ขายเชื่อ (ตลาดเก่า)', 'I3V6901-0001', '2026-01-03', 'นาย มูฮำหมัด แวซู (พนง)', 'REV26901-0001', 5000.00, 4672.90, 0.00, 0.00, 0.00, 5000.00, 4672.90, 4672.90, 327.10, 0.00, 0.00, 0.00, 0.00, 0.00, '', 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, '2026-01-03 17:30:28', -1, 0.00, -1, 0.00, 0.00);
INSERT INTO `all_transactions` VALUES ('PAY', '129', 'รับชำระหนี้ (สนง.ใหญ่)', 'REV26901-0001', '2026-01-03', 'นาย มูฮำหมัด แวซู (พนง)', NULL, 4600.00, 0.00, 0.00, 0.00, 0.00, 4600.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 4650.00, '05-024-186-6362', 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, '2026-01-03 17:30:28', 15064, 50.00, -1, 0.00, 0.00);
INSERT INTO `all_transactions` VALUES ('RET', '244', 'รับคืนสินค้า-สด (สนง.ใหญ่)', 'CNV26901-0001', '2026-01-03', 'นาย มูฮำหมัด แวซู (พนง)', NULL, 105.00, 93.46, 0.33, 4.67, 5.00, 100.00, 98.13, 93.46, 6.54, 0.00, 0.00, 0.00, 100.00, 0.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, '2026-01-04 10:40:10', -1, 0.00, -1, 0.00, 0.00);
INSERT INTO `all_transactions` VALUES ('RET', '247', 'รับคืนสินค้า-เชื่อ (สนง.ใหญ่)', 'SRV26901-0001', '2026-01-03', 'นาย มูฮำหมัด แวซู (พนง)', 'REV26901-0001', 1000.00, 934.58, 0.00, 0.00, 0.00, 1000.00, 934.58, 934.58, 65.42, 0.00, 0.00, 0.00, 0.00, 0.00, NULL, 0.00, NULL, NULL, NULL, 0.00, NULL, NULL, NULL, '2026-01-04 10:40:10', -1, 0.00, -1, 0.00, 0.00);

-- ----------------------------
-- Table structure for bank_accounts
-- ----------------------------
DROP TABLE IF EXISTS `bank_accounts`;
CREATE TABLE `bank_accounts`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID อัตโนมัติ',
  `bank_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ชื่อธนาคาร',
  `account_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'เลขที่บัญชี',
  `account_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'ชื่อบัญชี',
  `account_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'ประเภทบัญชี (ออมทรัพย์, กระแสรายวัน)',
  `branch` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'สาขา',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_account_no`(`account_no`) USING BTREE COMMENT 'เลขที่บัญชีต้องไม่ซ้ำกัน'
) ENGINE = InnoDB AUTO_INCREMENT = 38 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'ตารางเก็บข้อมูลบัญชีธนาคาร' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of bank_accounts
-- ----------------------------
INSERT INTO `bank_accounts` VALUES (1, 'ธนาคารกรุงเทพ จำกัด', '7888-9999-8', 'NAMRUNG YALA', 'กระแสรายวัน', 'ยะลา');
INSERT INTO `bank_accounts` VALUES (4, 'ธนาคารเพื่อการเกษตรและสหกรณ์', '01-061-228-4819', 'น.ส.อัจนา ยิ่งชนม์เจริญ', 'ออมทรัพย์', 'ยะลา/ยะลา');
INSERT INTO `bank_accounts` VALUES (5, 'ธนาคารเพื่อการเกษตรและสหกรณ์', '01-061-246-7247', 'บจก.ยะลานำรุ่ง', 'ออมทรัพย์', 'ยะลา/ยะลา');
INSERT INTO `bank_accounts` VALUES (7, 'ธนาคารออมสิน', '05-024-141-5756', 'น.ส.อัจนา ยิ่งชนม์เจริญ', 'ออมทรัพย์', 'ยะลา/ยะลา');
INSERT INTO `bank_accounts` VALUES (8, 'ธนาคารออมสิน', '05-024-186-6362', 'บจก.ยะลานำรุ่ง', 'ออมทรัพย์', 'ยะลา/ยะลา');
INSERT INTO `bank_accounts` VALUES (9, 'ธนาคารกรุงศรีอยุธยา จำกัด', '073-0-01483-7', 'บริษัท ยะลานำรุ่ง จำกัด', 'กระแสรายวัน', 'ยะลา/ยะลา');
INSERT INTO `bank_accounts` VALUES (10, 'ธนาคารกรุงศรีอยุธยา จำกัด', '073-1-24618-3', 'น.ส.อัจนา ยิ่งชนม์เจริญ', 'ออมทรัพย์', 'ยะลา/ยะลา');
INSERT INTO `bank_accounts` VALUES (11, 'ธนาคารกรุงศรีอยุธยา จำกัด', '073-1-56532-3', 'บจก.ยะลานำรุ่ง', 'ออมทรัพย์', 'ยะลา/ยะลา');
INSERT INTO `bank_accounts` VALUES (12, 'ธนาคารกสิกรไทย จำกัด', '256-241-7411', 'บจก.ยะลานำรุ่ง', 'ออมทรัพย์', 'ยะลา/ยะลา');
INSERT INTO `bank_accounts` VALUES (13, 'ธนาคารกสิกรไทย จำกัด', '256-254-5037', 'น.ส.อัจนา ยิ่งชนม์เจริญ', 'ออมทรัพย์', 'ยะลา/ยะลา');
INSERT INTO `bank_accounts` VALUES (14, 'ธนาคารกรุงเทพ จำกัด', '266-062-1935', 'บจก.ยะลานำรุ่ง', 'ออมทรัพย์', 'ยะลา/ยะลา');
INSERT INTO `bank_accounts` VALUES (15, 'ธนาคารกรุงเทพ จำกัด', '266-085-1631', 'น.ส.อัจนา ยิ่งชนม์เจริญ', 'ออมทรัพย์', 'ยะลา/ยะลา');
INSERT INTO `bank_accounts` VALUES (16, 'ธนาคารกรุงเทพ จำกัด', '266-303-8285', 'บจก.ยะลานำรุ่ง', 'กระแสรายวัน', 'ยะลา/ยะลา');
INSERT INTO `bank_accounts` VALUES (17, 'ธนาคารทหารไทยธนชาต จำกัด', '962-201-0255', 'น.ส.อัจนา ยิ่งชนม์เจริญ', 'ออมทรัพย์', 'ยะลา/ยะลา');
INSERT INTO `bank_accounts` VALUES (18, 'ธนาคารทหารไทยธนชาต จำกัด', '399-107-3846', 'น.ส.อัจนา ยิ่งชนม์เจริญ', 'กระแสรายวัน', 'ยะลา/ยะลา');
INSERT INTO `bank_accounts` VALUES (19, 'ธนาคารทหารไทยธนชาต จำกัด', '399-233-5756', 'บจก.ยะลานำรุ่ง', 'ออมทรัพย์', 'ยะลา/ยะลา');
INSERT INTO `bank_accounts` VALUES (21, 'ธนาคารไทยพาณิชย์ จำกัด', '508-222-8860', 'น.ส.อัจนา ยิ่งชนม์เจริญ', 'ออมทรัพย์', 'ยะลา/ยะลา');
INSERT INTO `bank_accounts` VALUES (22, 'ธนาคารไทยพาณิชย์ จำกัด', '508-302-2982', 'บจก.ยะลานำรุ่ง', 'กระแสรายวัน', 'ยะลา/ยะลา');
INSERT INTO `bank_accounts` VALUES (25, 'ธนาคารยูโอบี', '711-119-4010', 'บจก.ยะลานำรุ่ง', 'ออมทรัพย์', 'ยะลา/ยะลา');
INSERT INTO `bank_accounts` VALUES (26, 'ธนาคารยูโอบี', '711-163-3146', 'บจก.ยะลานำรุ่ง', 'ออมทรัพย์', 'ยะลา/ยะลา');
INSERT INTO `bank_accounts` VALUES (27, 'ธนาคารยูโอบี', '711-166-5501', 'น.ส.อัจนา ยิ่งชนม์เจริญ', 'ออมทรัพย์', 'ยะลา/ยะลา');
INSERT INTO `bank_accounts` VALUES (28, 'ธนาคารยูโอบี', '711-300-5231', 'บจก.ยะลานำรุ่ง', 'กระแสรายวัน', 'ยะลา/ยะลา');
INSERT INTO `bank_accounts` VALUES (29, 'ธนาคารยูโอบี', '711-311-9040', 'น.ส.อัจนา ยิ่งชนม์เจริญ', 'ออมทรัพย์', 'ยะลา/ยะลา');
INSERT INTO `bank_accounts` VALUES (30, 'ธนาคารกรุงไทย จำกัด', '909-157-1721', 'น.ส.อัจนา ยิ่งชนม์เจริญ', 'ออมทรัพย์', 'ยะลา/ยะลา');
INSERT INTO `bank_accounts` VALUES (31, 'ธนาคารกรุงไทย จำกัด', '909-171-6487', 'บจก.ยะลานำรุ่ง', 'ออมทรัพย์', 'ยะลา/ยะลา');
INSERT INTO `bank_accounts` VALUES (32, 'ธนาคารกรุงไทย จำกัด', '932-137-5996', 'บจก.ยะลานำรุ่ง', 'ออมทรัพย์', 'สิโรรส/สิโรรส');
INSERT INTO `bank_accounts` VALUES (33, 'ธนาคารกรุงไทย จำกัด', '932-147-5931', 'น.ส.อัจนา ยิ่งชนม์เจริญ', 'ออมทรัพย์', 'สิโรรส/สิโรรส');
INSERT INTO `bank_accounts` VALUES (34, 'ธนาคารทหารไทยธนชาต จำกัด', '399-256-1336', 'น.ส.อัจนา ยิ่งชนม์เจริญ', 'ออมทรัพย์', 'ยะลา');
INSERT INTO `bank_accounts` VALUES (35, 'ธนาคารไทยพาณิชย์ จำกัด', '508-297-1293', 'บจก.ยะลานำรุ่ง', 'ออมทรัพย์', 'ยะลา');
INSERT INTO `bank_accounts` VALUES (36, '999', '999-999-9999', 'บจก.นำรุ่งเคหะภัณฑ์/บจก.นำรุ่งคอนกรีต', 'ออมทรัพย์', 'ยะลา');
INSERT INTO `bank_accounts` VALUES (37, 'ธนาคารยูโอบี', '711-111-868-3', 'นส. อัจนา ยิ่งชนม์เจริญ', 'ออมทรัพย์', 'ยะลา');

-- ----------------------------
-- Table structure for docgroup_type
-- ----------------------------
DROP TABLE IF EXISTS `docgroup_type`;
CREATE TABLE `docgroup_type`  (
  `docgroup` int(11) NULL DEFAULT NULL,
  `CS_table` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `docno_head` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `docgroup_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `docgroup_type_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'รูปแบบเงิน',
  `R_cash` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'เงินสด',
  `R_bank` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'โอน',
  `R_credit` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'เครดิต',
  `R_chq_non` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'เช็คคงค้าง',
  `R_income` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'รายได้จากการขาย',
  `R_incomevat` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ภาษี  /beforetax',
  `R_income_cradet` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'หมุ่นเวียน',
  `R_income_cradetnon` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ไม่หมุ่นเวียน',
  `R_disincome` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ส่วนลดก่อนภาษี',
  `R_deppay` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'มัดจำรับ / sumamunt',
  `R_cn` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'รับคืน',
  `R_chq` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'เช็ครับ',
  `R_income_lg` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'รายได้จากการขาย ค่าขนส่งยอดเต็ม',
  `R_chq_tern` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'เช็คทำคืนล้วงหน้า',
  `R_serve` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'รายได้จากค่าบริการ',
  `R_dispay` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ส่วนลดจ่าย',
  `R_buy` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ซื้อสินค้า',
  `R_buytax` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ภาษีซื้อ',
  `R_cradet_tax` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'เจ้าหนี้การค้า',
  `R_disbuy` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ส่วนลดรับ',
  `R_deppay_buy` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'เงินมัดจำจ่ายล่วงหน้า',
  `R_cradetnontax` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'เจ้าหนี้การค้าไม่หมุ่นเวียน',
  `R_cn_buy` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ส่งคืน',
  `R_chq_buy` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'เช็คจ่าย',
  `I_income_coin` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'รายได้จากปัดเศษสตางค์ all',
  `E_expenses_coin` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ค่าใช้จ่ายจากปัดเศษสตางค์ all',
  `R_logistec` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'รายได้จากค่าขนส่ง',
  `R_service` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'รายได้จากค่าบริการ',
  `R_bankexpend` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ค่าธรรมเนียน',
  `E_wth` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'หัก ณ ที่ จ่าย',
  `E_wth_buy` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ภาษีเงินได้หัก ณ ที่จ่ายค้างจ่าย',
  UNIQUE INDEX `idx_docgroup_type_docgroup`(`docgroup`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of docgroup_type
-- ----------------------------
INSERT INTO `docgroup_type` VALUES (255, 'CSSALERET', 'SMV2', 'ลดหนี้(ราคาอย่างเดียว)-เชื่อ (สนง.ใหญ่)', 'E', 'E', 'E', 'E', NULL, NULL, 'E', 'E', NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (278, 'CSARDEPOSIT', 'AIV5', 'รับเงินมัดจำ - สด (ท่าสาป)', 'I', 'I', 'I', 'I', NULL, 'I', 'I', NULL, NULL, NULL, 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (198, 'CSGI', '002', 'ใบกำกับภาษีอย่างเต็ม', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (202, 'CSAPCNDEPOSIT', 'RPS', 'รับคืนเงินมัดจำ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (214, 'CSSTKCHKRES', '001', 'ผลการตรวจนับ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (295, 'CSSALE', 'D5V', 'สด ท่าสาป ลูกค้าทั่วไป (ใช้เฉพาะท่าสาปเท่านั้น)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (266, 'CSPHRET', 'GE', 'ลดหนี้ (ลดหนี้อย่างเดียว NO VAT)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (299, 'CSSALERET', 'CD3V', 'ลดหนี้เฉพาะ D3V', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (249, 'CSSALERET', 'SRV5', 'รับคืนสินค้า-เชื่อ (ท่าสาป)', 'E', 'E', 'E', 'E', NULL, NULL, 'E', 'E', NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (243, 'CSGLTR', '001', 'บันทึกภาษีซื้อสินค้าไม่เข้าสต๊อค', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (245, 'CSSALERET', 'CNV3', 'รับคืนสินค้า-สด (ตลาดเก่า)', 'E', 'E', 'E', 'E', NULL, NULL, 'E', NULL, NULL, 'I', NULL, 'E', NULL, NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (275, 'CSARDEPOSIT', 'AEV5', 'รับเงินมัดจำ - เชื่อ (ท่าสาป)', 'I', 'I', 'I', 'I', NULL, 'I', 'I', NULL, NULL, NULL, 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (250, 'CSSALERET', 'CNV1', 'รับคืนสินค้า-สด (หน้าตลาด)', 'E', 'E', 'E', 'E', NULL, NULL, 'E', NULL, NULL, 'I', NULL, 'E', NULL, NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (297, 'CSSALERET', 'CM5V', 'ลดราคาอย่างเดียวเฉพาะ D5V', 'E', 'E', 'E', 'E', NULL, NULL, 'E', NULL, NULL, 'I', NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (251, 'CSSALERET', 'CMV2', 'ลดหนี้(ราคาอย่างเดียว)-สด (สนง.ใหญ่)', 'E', 'E', 'E', 'E', NULL, NULL, 'E', NULL, NULL, 'I', NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (252, 'CSSALERET', 'CMV3', 'ลดหนี้(ราคาอย่างเดียว)-สด (ตลาดเก่า)', 'E', 'E', 'E', 'E', NULL, NULL, 'E', NULL, NULL, 'I', NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (253, 'CSSALERET', 'CMV5', 'ลดหนี้(ราคาอย่างเดียว)-สด (ท่าสาป)', 'E', 'E', 'E', 'E', NULL, NULL, 'E', NULL, NULL, 'I', NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (254, 'CSSALERET', 'SMV1', 'ลดหนี้(ราคาอย่างเดียว)-เชื่อ (หน้าตลาด)', 'E', 'E', 'E', 'E', NULL, NULL, 'E', 'E', NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (256, 'CSSALERET', 'SMV3', 'ลดหนี้(ราคาอย่างเดียว)-เชื่อ (ตลาดเก่า)', 'E', 'E', 'E', 'E', NULL, NULL, 'E', 'E', NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (257, 'CSSALERET', 'SMV5', 'ลดหนี้(ราคาอย่างเดียว)-เชื่อ (ท่าสาป)', 'E', 'E', 'E', 'E', NULL, NULL, 'E', 'E', NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (258, 'CSPHRET', 'GMV', 'ลดหนี้อย่างเดียว', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (259, 'CSAPOTHDEBT', 'OE', 'บันทึกค่าใช้จ่าย (NO VAT)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (222, 'CSUSER', '001', 'AA', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (304, 'CSStkAdjOut', 'JมV05', 'ปรับสต๊อกประจำปี (คลัง05)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (320, 'CSARDEBTB', 'BB', 'BB', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (319, 'CSAPCNB', 'BB', 'BB', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (321, 'CSARCNB', 'BB', 'BB', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (322, 'CSSTKOUT', 'BB', 'BB', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (196, 'CSGD', '006', 'POS2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (285, 'CSARCNDEPOSIT', 'DIV3', 'ใบคืนเงินมัดจำ - สด (ตลาดเก่า)', 'E', 'E', 'E', 'E', NULL, NULL, 'E', NULL, NULL, NULL, 'F', NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (213, 'CSSTKCHKREQ', '001', 'ใบขอตรวจนับ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (291, 'CSSALE', 'D2V', 'สด สนญ. ลูกค้าทั่วไป (ใช้เฉพาะสำนักงานใหญ่เท่านั้น', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (99, 'CSPO', 'POV', 'ใบสั่งซื้อทั่วไป', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (100, 'CSARDEPOSIT', 'AEV2', 'รับเงินมัดจำ - เชื่อ (สนง.ใหญ่)', 'I', 'I', 'I', 'I', NULL, 'I', 'I', NULL, NULL, NULL, 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (101, 'CSARDEPOSIT', 'AIV2', 'รับเงินมัดจำ - สด (สนง.ใหญ่)', 'I', 'I', 'I', 'I', NULL, 'I', 'I', NULL, NULL, NULL, 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (102, 'CSPO', 'BJV', 'ใบสั่งซื้อในเครือบริษัท', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (103, 'CSGR', 'RIV', 'บันทึกรับสินค้า', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'I', 'E');
INSERT INTO `docgroup_type` VALUES (104, 'CSIR', 'IRV', 'บันทึกตั้งหนี้จากการซื้อ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'E', 'E', 'E', 'I', 'I', 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (105, 'CSPH', 'RRV', 'ซื้อเชื่อ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'E', 'E', 'E', 'I', 'I', 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (106, 'CSPHRET', 'GRV', 'ส่งคืนและลดหนี้', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (107, 'CSAPDEPOSIT', 'DPV', 'จ่ายเงินมัดจำ - สด', 'E', 'E', 'E', 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (108, 'CSAPDEPOSIT', 'DSV', 'จ่ายเงินมัดจำ - เชื่อ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'I', NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (109, 'CSAPOTHDEBT', 'OEV', 'บันทึกค่าใช้จ่ายอื่นๆ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (110, 'CSQUOT', 'GTV', 'ใบเสนอราคา', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (111, 'CSSO', 'ROV', 'ใบรับซ่อม', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (296, 'CSSALERET', 'CD5V', 'ลดหนี้เฉพาะ D5V', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (112, 'CSSALE', 'H1V', 'ขายสด (หน้าตลาด)', 'I', 'I', 'I', 'I', 'I', 'I', 'I', NULL, NULL, 'E', 'E', NULL, 'I', 'I', NULL, 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'E', NULL, NULL);
INSERT INTO `docgroup_type` VALUES (162, 'CSSTKADJIN', '017', 'ปรับสต๊อกสินค้าชำรุด (JชV11)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (164, 'CSSTKADJIN', '014', 'ปรับสต๊อกสินค้าชำรุด (JชV011)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (151, 'CSSTKADJIN', '001', 'ปรับสต๊อกทั่วไป (JนV01)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (154, 'CSSTKADJIN', '010', 'ปรับสต๊อกทั่วไป (JนV03)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (157, 'CSSTKADJIN', '018', 'ปรับสต๊อกสินค้าชำรุด (JชV02)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (160, 'CSSTKADJIN', '021', 'ปรับสต๊อกสินค้าชำรุด (JชV12)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (113, 'CSSALE', 'H2V', 'ขายสด (สำนักงานใหญ่)', 'I', 'I', 'I', 'I', 'I', 'I', 'I', NULL, NULL, 'E', 'E', NULL, 'I', 'I', NULL, 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'E', NULL, NULL);
INSERT INTO `docgroup_type` VALUES (137, 'CSCRPASS', '001', 'ขึ้นเงินบัตรเครดิต', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (146, 'CSSTKADJIN', '009', 'ปรับสต๊อกทั่วไป (JนV12)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (166, 'CSSTKADJIN', '022', 'ปรับสต๊อกสินค้าชำรุด (JชV03)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (168, 'CSSTKADJIN', '024', 'ปรับสต๊อกสินค้าชำรุด (JชV05)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (170, 'CSStkAdjOut', '007', 'ปรับสต๊อกทั่วไป (JนV023)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (182, 'CSStkAdjOut', '019', 'ปรับสต๊อกสินค้าชำรุด (Jช023)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (184, 'CSStkAdjOut', '021', 'ปรับสต๊อกสินค้าชำรุด (Jช12)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (186, 'CSStkAdjOut', '017', 'ปรับสต๊อกสินค้าชำรุด (Jช11)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (188, 'CSStkAdjOut', '014', 'ปรับสต๊อกสินค้าชำรุด (Jช011)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (178, 'CSStkAdjOut', '010', 'ปรับสต๊อกทั่วไป (JนV03)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (180, 'CSStkAdjOut', '012', 'ปรับสต๊อกทั่วไป (JนV05)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (172, 'CSStkAdjOut', '009', 'ปรับสต๊อกทั่วไป (JนV12)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (174, 'CSStkAdjOut', '005', 'ปรับสต๊อกทั่วไป (JนV11)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (176, 'CSStkAdjOut', '002', 'ปรับสต๊อกทั่วไป (JนV011)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (190, 'CSStkAdjOut', '022', 'ปรับสต๊อกสินค้าชำรุด (Jช03)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (192, 'CSStkAdjOut', '024', 'ปรับสต๊อกสินค้าชำรุด (Jช05)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (194, 'CSGD', '001', 'ใบส่งสินค้า GDV1', NULL, NULL, NULL, NULL, NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (158, 'CSSTKADJIN', '019', 'ปรับสต๊อกสินค้าชำรุด (JชV023)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (161, 'CSSTKADJIN', '016', 'ปรับสต๊อกสินค้าชำรุด (JชV09)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (163, 'CSSTKADJIN', '013', 'ปรับสต๊อกสินค้าชำรุด (JชV01)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (165, 'CSSTKADJIN', '015', 'ปรับสต๊อกสินค้าชำรุด (JชV012)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (152, 'CSSTKADJIN', '002', 'ปรับสต๊อกทั่วไป (JนV011)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (155, 'CSSTKADJIN', '011', 'ปรับสต๊อกทั่วไป (JนV031)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (114, 'CSSALE', 'H3V', 'ขายสด (ตลาดเก่า)', 'I', 'I', 'I', 'I', 'I', 'I', 'I', NULL, NULL, 'E', 'E', NULL, 'I', 'I', NULL, 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'E', NULL, NULL);
INSERT INTO `docgroup_type` VALUES (138, 'CSBANKINC', '001', 'เงินได้ธนาคาร', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (147, 'CSSTKADJIN', '004', 'ปรับสต๊อกทั่วไป (JนV09)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (167, 'CSSTKADJIN', '023', 'ปรับสต๊อกสินค้าชำรุด (JชV031)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (169, 'CSStkAdjOut', '006', 'ปรับสต๊อกทั่วไป (JนV02)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (171, 'CSStkAdjOut', '008', 'ปรับสต๊อกทั่วไป (JนV024)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (183, 'CSStkAdjOut', '020', 'ปรับสต๊อกสินค้าชำรุด (Jช024)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (185, 'CSStkAdjOut', '016', 'ปรับสต๊อกสินค้าชำรุด (Jช09)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (187, 'CSStkAdjOut', '013', 'ปรับสต๊อกสินค้าชำรุด (Jช01)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (189, 'CSStkAdjOut', '015', 'ปรับสต๊อกสินค้าชำรุด (Jช012)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (179, 'CSStkAdjOut', '011', 'ปรับสต๊อกทั่วไป (JนV031)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (181, 'CSStkAdjOut', '018', 'ปรับสต๊อกสินค้าชำรุด (Jช02)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (173, 'CSStkAdjOut', '004', 'ปรับสต๊อกทั่วไป (JนV09)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (175, 'CSStkAdjOut', '001', 'ปรับสต๊อกทั่วไป (JนV01)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (177, 'CSStkAdjOut', '003', 'ปรับสต๊อกทั่วไป (JนV012)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (191, 'CSStkAdjOut', '023', 'ปรับสต๊อกสินค้าชำรุด (Jช031)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (193, 'CSWCOST', '001', 'ต้นทุนแฝง', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (195, 'CSGD', '005', 'POS1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (115, 'CSSALE', 'H5V', 'ขายสด (ท่าสาป)', 'I', 'I', 'I', 'I', 'I', 'I', 'I', NULL, NULL, 'E', 'E', NULL, 'I', 'I', NULL, 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'E', NULL, NULL);
INSERT INTO `docgroup_type` VALUES (116, 'CSSALE', 'I1V', 'ขายเชื่อ (หน้าตลาด)', 'I', 'I', 'I', 'I', NULL, 'I', 'I', 'I', 'E', 'E', 'E', NULL, NULL, 'I', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (156, 'CSSTKADJIN', '012', 'ปรับสต๊อกทั่วไป (JนV05)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (159, 'CSSTKADJIN', '020', 'ปรับสต๊อกสินค้าชำรุด (JชV024)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (267, 'CSGD', 'PB', 'พักบิล', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (139, 'CSBANKEXP', '001', 'เงินหักธนาคาร', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (117, 'CSSALE', 'I2V', 'ขายเชื่อ (สำนักงานใหญ่)', 'I', 'I', 'I', 'I', NULL, 'I', 'I', 'I', 'E', 'E', 'E', NULL, NULL, 'I', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (118, 'CSSALE', 'I3V', 'ขายเชื่อ (ตลาดเก่า)', 'I', 'I', 'I', 'I', NULL, 'I', 'I', 'I', 'E', 'E', 'E', NULL, NULL, 'I', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (119, 'CSSALE', 'I5V', 'ขายเชื่อ (ท่าสาป)', 'I', 'I', 'I', 'I', NULL, 'I', 'I', 'I', 'E', 'E', 'E', NULL, NULL, 'I', NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (298, 'CSSALE', 'D3V', 'สด ตลาดเก่า ลูกค้าทั่วไป (ใช้เฉพาะตลาดเก่าเท่านั้น', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (120, 'CSSALERET', 'CMV1', 'ลดหนี้(ราคาอย่างเดียว)-สด (หน้าตลาด)', 'E', 'E', 'E', 'E', NULL, NULL, 'E', NULL, NULL, 'I', NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (121, 'CSSALERET', 'SRV1', 'รับคืนสินค้า-เชื่อ (หน้าตลาด)', 'E', 'E', 'E', 'E', NULL, NULL, 'E', 'E', NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (140, 'CSBANKTF', '001', 'โอนเงินระหว่างบัญชี', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (122, 'CSSTKOUT', 'TEV2', 'ใบเบิกวัสดุใช้งาน', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (233, 'CSGD', '004', 'ใบส่งสินค้า GDV5', NULL, NULL, NULL, NULL, NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (123, 'CSSTKOUT', 'TEV1', 'ใบเบิกวัสดุใช้งาน', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (141, 'CSBANKCASHIN', '001', 'ฝากเงินสดเข้าบัญชี', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (311, 'CSSTKIN', '003', 'ใบรับของแถม', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (124, 'CSSTKOUT', 'TEV3', 'ใบเบิกวัสดุใช้งาน', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (125, 'CSSTKOUT', 'TEV5', 'ใบเบิกวัสดุใช้งาน', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (126, 'CSAPPAYBILL', 'AAV', 'ใบรับวางบิล', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (127, 'CSAPPAY', 'PSV', 'จ่ายชำระหนี้', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (128, 'CSARPAYBILL', 'BIV', 'ใบวางบิล', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (129, 'CSARPAY', 'REV2', 'รับชำระหนี้ (สนง.ใหญ่)', 'I', 'I', 'I', 'I', NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'I', 'E');
INSERT INTO `docgroup_type` VALUES (130, 'CSCHQINPASS', '001', 'เช็ครับผ่าน', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (277, 'CSARDEPOSIT', 'AIV3', 'รับเงินมัดจำ - สด (ตลาดเก่า)', 'I', 'I', 'I', 'I', NULL, 'I', 'I', NULL, NULL, NULL, 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (286, 'CSARCNDEPOSIT', 'DIV5', 'ใบคืนเงินมัดจำ - สด (ท่าสาป)', 'E', 'E', 'E', 'E', NULL, NULL, 'E', NULL, NULL, NULL, 'F', NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (287, 'CSGI', 'IN', 'ล้าง GDV', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (148, 'CSSTKADJIN', '005', 'ปรับสต๊อกทั่วไป (JนV11)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (131, 'CSSTKOUT', '001', 'ใบจ่าย', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (218, 'CSGD', 'POS1', 'POS1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (142, 'CSBANKCASHOUT', '001', 'ถอนเงินสดจากบัญชี', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (143, 'CSSTKTF', 'RLV', 'ใบเบิก (ต่างสาขา)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (313, 'CSPHRET', 'GD', 'ลดหนี้ (ส่งคืนและลดหนี้ ON VAT)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (314, 'CSBom', '001', 'ผสมสินค้า', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (317, 'CSAPWTAXH', '001', 'a', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (318, 'CSAPDEBTB', 'BB', 'BB', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (324, 'CSSTKADJIN', 'BB', 'BB', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (144, 'CSSTKIN', '001', 'ใบรับ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (149, 'CSSTKADJIN', '006', 'ปรับสต๊อกทั่วไป (JนV02)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (153, 'CSSTKADJIN', '003', 'ปรับสต๊อกทั่วไป (JนV012)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (326, 'CSPOREQ', 'PR', 'PR (ใบขอสั่งซื้อ)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (327, 'CSPHADJ', 'DNV', 'ใบเพิ่มหนี้-เพิ่มหนี้อย่างเดียว', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (328, 'CSPO', 'POV2', 'ใบสั่งซื้อ-สำนักงานใหญ่', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (329, 'CSPO', 'POV1', 'ใบสั่งซื้อ-หน้าร้าน', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (330, 'CSPO', 'POV3', 'ใบสั่งซื้อ-ตลาดเก่า', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (331, 'CSPO', 'POV5', 'ใบสั่งซื้อ-ท่าสาป', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (332, 'CSSTKTF', 'TSV', 'ท่าสาป สโตร์ 051-052', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (333, 'CSAPPAY', 'PS', 'จ่ายชำระหนี้ (NO VAT)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (132, 'CSCHQINRET', '001', 'คืนเช็ครับ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (227, 'CSSTKTF', 'TBV', 'หน้าตลาด สโตร์ ชั้น 2  (เครื่องมือ)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (228, 'CSSTKTF', 'TCV', 'สำนักงานใหญ่ สโตร์ ชั้น 3', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (229, 'CSSTKTF', 'TDV', 'สำนักงานใหญ่ สโตร์ ชั้น 4', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (306, 'CSStkAdjOut', 'JอV02', 'ปรับสต๊อกสินค้าชำรุด (ACC)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (309, 'CSBARREQ', '002', 'Barcode', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (310, 'CSSTKOUT', 'TEVFOC', 'ใบเบิกของแถม', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (226, 'CSSTKTF', 'TAV', 'หน้าตลาด สโตร์ ชั้น 2', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (223, 'csadjprice', 'CHP', 'ปรับราคาขาย ล่วงหน้า', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (224, 'CSSTKOUT', '002', 'รวมประกอบสินค้า', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (225, 'CSSTKIN', '002', 'แปรงรหัส', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (300, 'CSSALERET', 'CM3V', 'ลดราคาอย่างเดียวเฉพาะ D3V', 'E', 'E', 'E', 'E', NULL, NULL, 'E', NULL, NULL, 'I', NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (301, 'CSStkAdjOut', 'JมV01', 'ปรับสต๊อกประจำปี (คลัง01)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (302, 'CSStkAdjOut', 'JมV02', 'ปรับสต๊อกประจำปี (คลัง02)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (303, 'CSStkAdjOut', 'JมV03', 'ปรับสต๊อกประจำปี (คลัง03)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (248, 'CSSALERET', 'SRV3', 'รับคืนสินค้า-เชื่อ (ตลาดเก่า)', 'E', 'E', 'E', 'E', NULL, NULL, 'E', 'E', NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (274, 'CSARDEPOSIT', 'AEV3', 'รับเงินมัดจำ - เชื่อ (ตลาดเก่า)', 'I', 'I', 'I', 'I', NULL, 'I', 'I', NULL, NULL, NULL, 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (261, 'CSSALERET', 'ZR', 'ลดหนี้', 'E', 'E', 'E', 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (334, 'HWHPROAMNT', '001', '1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (247, 'CSSALERET', 'SRV2', 'รับคืนสินค้า-เชื่อ (สนง.ใหญ่)', 'E', 'E', 'E', 'E', NULL, NULL, 'E', 'E', NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (276, 'CSARDEPOSIT', 'AIV1', 'รับเงินมัดจำ - สด (หน้าตลาด)', 'I', 'I', 'I', 'I', NULL, 'I', 'I', NULL, NULL, NULL, 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (289, '', '', '', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (292, 'CSSALERET', 'CD2V', 'ลดหนี้เฉพาะ D2V', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (294, 'CSSALERET', 'CM2V', 'ลดราคาอย่างเดียวเฉพาะ D2V', 'E', 'E', 'E', 'E', NULL, '', 'E', NULL, NULL, 'I', NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (133, 'CSCHQINCHNG', '001', 'เปลี่ยนเช็ครับ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (197, 'CSGI', 'IV', 'ใบกำกับภาษีขาย', NULL, NULL, NULL, NULL, NULL, 'I', 'I', 'I', 'E', NULL, 'E', NULL, NULL, 'l', NULL, 'l', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (199, 'CSSALERETREQ', '001', 'ใบขอรับคืนสินค้า', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (200, 'CSSALEADJ', '001', 'ใบเพิ่มหนี้', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (201, 'CSSHIP', '001', 'ใบวางแผนการจัดส่ง', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (203, 'CSAPOTHREQ', '001', 'ใบขอเบิกค่าใช้จ่าย', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (204, 'CSAPOTHCN', '001', 'ใบลดหนี้อื่นๆ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (288, 'CSAPDEPOSIT', 'DS', 'จ่ายเงินมัดจำ (ON VAT)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (234, 'CSSALE', 'VH1', 'ขายสด (หน้าตลาด)', 'I', 'I', 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (235, 'CSSALE', 'VH2', 'ขายสด (สำนักงานใหญ่)', 'I', 'I', 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (236, 'CSSALE', 'VH3', 'ขายสด (ตลาดเก่า)', 'I', 'I', 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (237, 'CSSALE', 'VH5', 'ขายสด (ท่าสาป)', 'I', 'I', 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (238, 'CSSALE', 'VI1', 'ขายเชื่อ (หน้าตลาด)', 'I', 'I', 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (239, 'CSSALE', 'VI2', 'ขายเชื่อ (สำนักงานใหญ่)', 'I', 'I', 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (240, 'CSSALE', 'VI3', 'ขายเชื่อ (ตลาดเก่า)', 'I', 'I', 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (260, 'CSIR', 'IR', 'บันทึกตั้งหนี้', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'E', 'E', 'E', 'I', 'I', 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (244, 'CSSALERET', 'CNV2', 'รับคืนสินค้า-สด (สนง.ใหญ่)', 'E', 'E', 'E', 'E', NULL, NULL, 'E', NULL, NULL, 'I', NULL, 'E', NULL, NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (98, 'CSPH', 'HPV', 'ซื้อสด', 'I', 'I', 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'I', NULL, 'I', NULL, 'E', 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (230, 'CSSTKTF', 'TFV', 'ตลาดเก่า สโตร์ ชั้น1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (215, 'CSSTKCHKADJ', '001', 'ปรับปรุงผลการตรวจนับ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (219, 'CSGD', 'PU1', 'พักบิล1', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (232, 'CSGD', '003', 'ใบส่งสินค้า GDV3', NULL, NULL, NULL, NULL, NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (217, 'CSPremuim', '001', 'โปรโมชั่น', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (221, 'CSGI', '003', 'สรุปเอกสารสรุปยอดขาย', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (231, 'CSGD', '002', 'ใบส่งสินค้า GDV2', NULL, NULL, NULL, NULL, NULL, 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (216, 'CSCHQBOOK', '001', 'สมุดเช็ค', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (220, 'CSGD', 'PU2', 'พักบิล', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (268, 'CSARPAY', 'REV1', 'รับชำระหนี้ (หน้าตลาด)', 'I', 'I', 'I', 'I', NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'I', 'E');
INSERT INTO `docgroup_type` VALUES (269, 'CSARPAY', 'REV3', 'รับชำระหนี้ (ตลาดเก่า)', 'I', 'I', 'I', 'I', NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'I', 'E');
INSERT INTO `docgroup_type` VALUES (270, 'CSARPAY', 'REV5', 'รับชำระหนี้ (ท่าสาป)', 'I', 'I', 'I', 'I', NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'I', 'E');
INSERT INTO `docgroup_type` VALUES (272, 'CSBARREQ', '001', 'M', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (273, 'CSARDEPOSIT', 'AEV1', 'รับเงินมัดจำ - เชื่อ (หน้าตลาด)', 'I', 'I', 'I', 'I', NULL, 'I', 'I', NULL, NULL, NULL, 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (145, 'CSSTKADJIN', '008', 'ปรับสต๊อกทั่วไป (JนV024)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (323, 'CSSTKIN', 'BB', 'BB', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (150, 'CSSTKADJIN', '007', 'ปรับสต๊อกทั่วไป (JนV023)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (246, 'CSSALERET', 'CNV5', 'รับคืนสินค้า-สด (ท่าสาป)', 'E', 'E', 'E', 'E', NULL, NULL, 'E', NULL, NULL, 'I', NULL, 'E', NULL, NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (134, 'CSCHQOUTPASS', '001', 'เช็คจ่ายผ่าน', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (135, 'CSCHQOUTRET', '001', 'คืนเช็คจ่าย', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (205, 'CSAPOTHCN', '002', 'ใบลดหนี้ไม่มีภาษี', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (206, 'CSAPPREBILL', '001', 'ใบเตรียมจ่าย', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (207, 'CSARCNDEPOSIT', 'DEV1', 'ใบคืนเงินมัดจำ - เชื่อ (หน้าตลาด)', 'E', 'E', 'E', 'E', NULL, NULL, 'E', NULL, NULL, NULL, 'F', NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (208, 'CSAROTHDEBT', '001', 'รายได้อื่นๆ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (209, 'CSAROTHDEBT', '002', 'ใบตั้งหนี้อื่นๆ', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (210, 'CSAROTHCN', 'SSV5', 'ใบลดหนี้อื่นๆ (ท่าสาป)', 'E', 'E', 'E', 'E', NULL, NULL, 'E', 'E', NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (211, 'CSSTKTFREQ', '001', 'ใบขอโอนสินค้า', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (212, 'CSSTKOUTREQ', '001', 'ใบขอเบิกใช้สินค้า', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (283, 'CSARCNDEPOSIT', 'DIV1', 'ใบคืนเงินมัดจำ - สด (หน้าตลาด)', 'E', 'E', 'E', 'E', NULL, NULL, 'E', NULL, NULL, NULL, 'F', NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (241, 'CSSALE', 'VI5', 'ขายเชื่อ (ท่าสาป)', 'I', 'I', 'I', 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'I', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (280, 'CSARCNDEPOSIT', 'DEV2', 'ใบคืนเงินมัดจำ - เชื่อ (สนง.ใหญ่)', 'E', 'E', 'E', 'E', NULL, NULL, 'E', NULL, NULL, NULL, 'F', NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (279, 'CSARPAY', 'RE', 'รับชำระหนี้ (NO VAT)', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (281, 'CSARCNDEPOSIT', 'DEV3', 'ใบคืนเงินมัดจำ - เชื่อ (ตลาดเก่า)', 'E', 'E', 'E', 'E', NULL, NULL, 'E', NULL, NULL, NULL, 'F', NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (282, 'CSARCNDEPOSIT', 'DEV5', 'ใบคืนเงินมัดจำ - เชื่อ (ท่าสาป)', 'E', 'E', 'E', 'E', NULL, NULL, 'E', NULL, NULL, NULL, 'F', NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (325, 'CSStkAdjOut', 'BB', 'BB', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (284, 'CSARCNDEPOSIT', 'DIV2', 'ใบคืนเงินมัดจำ - สด (สนง.ใหญ่)', 'E', 'E', 'E', 'E', NULL, NULL, 'E', NULL, NULL, NULL, 'F', NULL, NULL, NULL, 'E', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `docgroup_type` VALUES (136, 'CSCHQOUTCHNG', '001', 'เปลี่ยนเช็คจ่าย', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for other_income_expense
-- ----------------------------
DROP TABLE IF EXISTS `other_income_expense`;
CREATE TABLE `other_income_expense`  (
  `bill` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `docgroup` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'docgroup',
  `LNAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `docdate` date NULL DEFAULT NULL COMMENT 'วันที่เอกสาร',
  `docno` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'เลขที่เอกสาร (Primary Key)',
  `custname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'ชื่อลูกค้า',
  `productid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'รหัสสินค้า',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `productname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'ชื่อสินค้า',
  `income_before_vat` decimal(18, 2) NULL DEFAULT NULL COMMENT 'ยอดสุทธิ',
  `income_vat` decimal(18, 2) NULL DEFAULT NULL COMMENT 'ยอดเพิ่มเติม/ส่วนขยาย',
  `NETAMOUNT` decimal(10, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`docno`, `productid`) USING BTREE,
  INDEX `idx_docdate`(`docdate`) USING BTREE,
  INDEX `idx_productid`(`productid`) USING BTREE,
  INDEX `idx_custname`(`custname`) USING BTREE,
  INDEX `idx_other_income_expense_docdate_docno`(`docdate`, `docno`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'ตารางเก็บข้อมูลรายได้ค่าขนส่ง' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of other_income_expense
-- ----------------------------
INSERT INTO `other_income_expense` VALUES ('CSSALE 3.5', '112', 'ขายสด (หน้าตลาด)', '2026-01-01', 'H1V6901-0001', 'นาย มูฮำหมัด แวซู (พนง)', '15075', '4112', 'ค่าขนส่ง', 280.37, 19.63, 300.00);
INSERT INTO `other_income_expense` VALUES ('CSSALE 3.5', '112', 'ขายสด (หน้าตลาด)', '2026-01-01', 'H1V6901-0001', 'นาย มูฮำหมัด แวซู (พนง)', '16681', '4101', 'ค่าบริการ', 467.29, 32.71, 500.00);
INSERT INTO `other_income_expense` VALUES ('CSSALE 3.5', '113', 'ขายสด (สำนักงานใหญ่)', '2026-01-04', 'H2V6901-0006', 'นาย มูฮำหมัด แวซู (พนง)', '15075', '4112', 'ค่าขนส่ง', 0.00, 0.00, 0.00);
INSERT INTO `other_income_expense` VALUES ('CSSALE 3.5', '113', 'ขายสด (สำนักงานใหญ่)', '2026-01-04', 'H2V6901-0006', 'นาย มูฮำหมัด แวซู (พนง)', '16681', '4101', 'ค่าบริการ', 467.29, 32.71, 500.00);
INSERT INTO `other_income_expense` VALUES ('CSSALE 3.5', '115', 'ขายสด (ท่าสาป)', '2026-01-03', 'H5V6901-0001', 'นาย มูฮำหมัด แวซู (พนง)', '15075', '4112', 'ค่าขนส่ง', 467.29, 32.71, 500.00);
INSERT INTO `other_income_expense` VALUES ('CSAPOTHDEBTSUB4.5', '109', 'บันทึกค่าใช้จ่ายอื่นๆ', '2026-01-04', 'OEV6901-0001', 'บริษัท ยะลานำรุ่ง จำกัด (สาขา 1)', '15092', '55040', 'ค่าน้ำมัน', 467.29, 32.71, 500.00);
INSERT INTO `other_income_expense` VALUES ('CSAPOTHDEBTSUB4.5', '109', 'บันทึกค่าใช้จ่ายอื่นๆ', '2026-01-04', 'OEV6901-0001', 'บริษัท ยะลานำรุ่ง จำกัด (สาขา 1)', '15779', '55060', 'ค่าซ่อมรถ - 80-4841 ยล.', 1869.16, 130.84, 2000.00);
INSERT INTO `other_income_expense` VALUES ('CSAPOTHDEBTSUB4.5', '109', 'บันทึกค่าใช้จ่ายอื่นๆ', '2026-01-04', 'OEV6901-0002', 'บริษัท ยะลานำรุ่ง จำกัด (สาขา 1)', '15779', '55060', 'ค่าซ่อมรถ - 80-4841 ยล.', 2803.74, 196.26, 3000.00);
INSERT INTO `other_income_expense` VALUES ('CSAPOTHDEBTSUB4.5', '109', 'บันทึกค่าใช้จ่ายอื่นๆ', '2026-01-04', 'OEV6901-0002', 'บริษัท ยะลานำรุ่ง จำกัด (สาขา 1)', '15780', '55061', 'ค่าซ่อมรถ - 80-4590 ยล.', 934.58, 65.42, 1000.00);
INSERT INTO `other_income_expense` VALUES ('CSAPOTHDEBTSUB4.5', '109', 'บันทึกค่าใช้จ่ายอื่นๆ', '2026-01-04', 'OEV6901-0002', 'บริษัท ยะลานำรุ่ง จำกัด (สาขา 1)', '15781', '55062', 'ค่าซ่อมรถ - 80-2640 ยล.', 1869.16, 130.84, 2000.00);
INSERT INTO `other_income_expense` VALUES ('CSAPOTHDEBTSUB4.5', '109', 'บันทึกค่าใช้จ่ายอื่นๆ', '2026-01-04', 'OEV6901-0002', 'บริษัท ยะลานำรุ่ง จำกัด (สาขา 1)', '15782', '55063', 'ค่าซ่อมรถ - 80-2724 ยล.', 934.58, 65.42, 1000.00);
INSERT INTO `other_income_expense` VALUES ('CSAPOTHDEBTSUB4.5', '109', 'บันทึกค่าใช้จ่ายอื่นๆ', '2026-01-04', 'OEV6901-0003', 'บริษัท นำรุ่งเคหะภัณฑ์ จำกัด (เบตง)', '15903', '55055', 'ค่าโทรศัพท์', 794.39, 55.61, 850.00);
INSERT INTO `other_income_expense` VALUES ('CSAPOTHDEBTSUB4.5', '109', 'บันทึกค่าใช้จ่ายอื่นๆ', '2026-01-04', 'OEV6901-0003', 'บริษัท นำรุ่งเคหะภัณฑ์ จำกัด (เบตง)', '15905', '55056', 'ค่าอินเตอร์เน็ต', 654.21, 45.79, 700.00);
INSERT INTO `other_income_expense` VALUES ('CSAROTHCN 3.8', '210', 'ใบลดหนี้อื่นๆ (ท่าสาป)', '2026-01-03', 'SSV56901-0001', 'นาย มูฮำหมัด แวซู (พนง)', '25890', '4123', 'ส่วนลด (ลูกหนี้)', 934.58, 65.42, 1000.00);

-- ----------------------------
-- Table structure for other_income_type
-- ----------------------------
DROP TABLE IF EXISTS `other_income_type`;
CREATE TABLE `other_income_type`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'รหัสอัตโนมัติ (Primary Key)',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'รหัสอ้างอิง',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ชื่อรายการ',
  `income_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ประเภท (I=รายได้, E=รายจ่าย)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_code`(`code`) USING BTREE COMMENT 'รหัสห้ามซ้ำกัน',
  INDEX `idx_income_type`(`income_type`) USING BTREE COMMENT 'ดัชนีสำหรับค้นหาตามประเภท'
) ENGINE = InnoDB AUTO_INCREMENT = 26956 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'ตารางประเภทรายได้และรายจ่าย' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of other_income_type
-- ----------------------------
INSERT INTO `other_income_type` VALUES (15064, '4117', 'หัก ณ ที่จ่าย', 'I');
INSERT INTO `other_income_type` VALUES (15065, '4102', 'ค่าตัดเจาะ', 'I');
INSERT INTO `other_income_type` VALUES (15066, '4103', 'ค่าอะไหล่+ซ่อม', 'I');
INSERT INTO `other_income_type` VALUES (15067, '4104', 'รายได้อื่นๆ', 'I');
INSERT INTO `other_income_type` VALUES (15068, '4105', 'ค่าบริการคลัง', 'I');
INSERT INTO `other_income_type` VALUES (15069, '4106', 'บัญชีพักตั้งรายได้', 'I');
INSERT INTO `other_income_type` VALUES (15070, '4107', 'S-VAT', 'I');
INSERT INTO `other_income_type` VALUES (15071, '4108', 'ค่าบริการตรวจเช็ค (ทูล)', 'I');
INSERT INTO `other_income_type` VALUES (15072, '4109', 'สินค้าชำรุด (ระบุรายการที่ขายด้วย)', 'I');
INSERT INTO `other_income_type` VALUES (15073, '4110', 'รายได้ส่งเสริมการขายปูน', 'I');
INSERT INTO `other_income_type` VALUES (15074, '4111', 'รายได้ส่งเสริมการขายกระเบื้อง', 'I');
INSERT INTO `other_income_type` VALUES (15075, '4112', 'ค่าขนส่ง', 'I');
INSERT INTO `other_income_type` VALUES (15076, '4113', 'ส่วนลดสติ๊กเกอร์ เหรียญฝาสี', 'I');
INSERT INTO `other_income_type` VALUES (15077, '4114', 'ค่าบรรทุกขี้เลื่อย', 'I');
INSERT INTO `other_income_type` VALUES (15078, '4115', 'ค่าบริการเครื่องถ่าย', 'I');
INSERT INTO `other_income_type` VALUES (15079, '4116', 'ค่าบริการตรวจเช็ค (หน้าร้าน)', 'I');
INSERT INTO `other_income_type` VALUES (15080, '5501', 'ค่าอะไหล่งานซ่อม', 'E');
INSERT INTO `other_income_type` VALUES (15081, '5502', 'ค่าขนส่งจ่าย', 'E');
INSERT INTO `other_income_type` VALUES (15082, '5503', 'ค่าใช้จ่ายเบ็ดเตล็ด', 'E');
INSERT INTO `other_income_type` VALUES (15083, '55031', 'ส่วนลดจ่าย เก่าแลกใหม่ 300 (แลกซื้อบ๊อชกลุ่มอื่นฯ)', 'E');
INSERT INTO `other_income_type` VALUES (15084, '55032', 'ส่วนลดจ่าย เก่าแลกใหม่ 700 (แลกซื้อบ๊อชกลุ่มโรตารี่)', 'E');
INSERT INTO `other_income_type` VALUES (15085, '55033', 'ส่วนลดคืนคูปอง/ใบปลิวงาน (ด้านเครื่องมือ)', 'E');
INSERT INTO `other_income_type` VALUES (15086, '55034', 'ค่าขอใบอนุญาตประกอบกิจการ', 'E');
INSERT INTO `other_income_type` VALUES (15087, '55035', 'ค่าข้าวสาร', 'E');
INSERT INTO `other_income_type` VALUES (15088, '55036', 'ค่าน้ำขวด ตราบริษัท', 'E');
INSERT INTO `other_income_type` VALUES (15089, '55037', 'โปรโมชั่น', 'E');
INSERT INTO `other_income_type` VALUES (15090, '55038', 'ค่าแผ่นพับ', 'E');
INSERT INTO `other_income_type` VALUES (15091, '55039', 'ค่าโฆษณา', 'E');
INSERT INTO `other_income_type` VALUES (15092, '55040', 'ค่าน้ำมัน', 'E');
INSERT INTO `other_income_type` VALUES (15093, '55120', 'ภาษีสังคม', 'E');
INSERT INTO `other_income_type` VALUES (15094, '55042', 'ค่าทำบัญชี', 'E');
INSERT INTO `other_income_type` VALUES (15096, '55044', 'ค่าประกัน+พรบ.', 'E');
INSERT INTO `other_income_type` VALUES (15097, '55045', 'ค่าเช่า', 'E');
INSERT INTO `other_income_type` VALUES (15098, '55046', 'ค่าภาษี', 'E');
INSERT INTO `other_income_type` VALUES (15099, '55047', 'เงินกู้พนักงาน', 'E');
INSERT INTO `other_income_type` VALUES (15100, '55048', 'ค่าน้ำบาดาล', 'E');
INSERT INTO `other_income_type` VALUES (15101, '55049', 'วัสดุสำนักงาน', 'E');
INSERT INTO `other_income_type` VALUES (15102, '55050', 'ค่าบำรุงรักษาตู้สาขา', 'E');
INSERT INTO `other_income_type` VALUES (15103, '55051', 'ส่วนลดโปรโมชั่น', 'E');
INSERT INTO `other_income_type` VALUES (15104, '55052', 'ค่าที่ดิน', 'E');
INSERT INTO `other_income_type` VALUES (15535, '5504', 'ค่าบริการจตรวจเช็ค (ทูล)', 'E');
INSERT INTO `other_income_type` VALUES (15541, '5506', 'ค่าซ่อมรถ', 'E');
INSERT INTO `other_income_type` VALUES (15779, '55060', 'ค่าซ่อมรถ - 80-4841 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15780, '55061', 'ค่าซ่อมรถ - 80-4590 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15781, '55062', 'ค่าซ่อมรถ - 80-2640 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15782, '55063', 'ค่าซ่อมรถ - 80-2724 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15783, '55064', 'ค่าซ่อมรถ - 80-5593 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15784, '55065', 'ค่าซ่อมรถ - 80-2101 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15786, '55066', 'ค่าซ่อมรถ - 80-5326 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15787, '55067', 'ค่าซ่อมรถ - 80-2763 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15789, '55068', 'ค่าซ่อมรถ - 80-7571 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15790, '55069', 'ค่าซ่อมรถ - 80-7572 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15791, '55070', 'ค่าซ่อมรถ - 80-7573 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15792, '55071', 'ค่าซ่อมรถ - 80-7574 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15793, '55072', 'ค่าซ่อมรถ - 80-7802 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15794, '55073', 'ค่าซ่อมรถ - 80-7172 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15795, '55074', 'ค่าซ่อมรถ - 80-5868-5869 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15796, '55075', 'ค่าซ่อมรถ - 80-6030-6031 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15797, '55076', 'ค่าซ่อมรถ - 80-5936-5937 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15798, '55077', 'ค่าซ่อมรถ - 80-5843-5844 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15799, '55078', 'ค่าซ่อมรถ - 80-5854-5855 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15800, '55079', 'ค่าซ่อมรถ - 80-6222-6223 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15801, '55080', 'ค่าซ่อมรถ - 80-6731-6732 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15802, '55081', 'ค่าซ่อมรถ - 80-6684-6685 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15803, '55082', 'ค่าซ่อมรถ - บจ-1885 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15804, '55083', 'ค่าซ่อมรถ - บฉ-9945 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15805, '55084', 'ค่าซ่อมรถ - บฉ-270 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15806, '55085', 'ค่าซ่อมรถ - บฉ-1538 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15807, '55086', 'ค่าซ่อมรถ - บต-1215 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15808, '55087', 'ค่าซ่อมรถ - บต-215 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15809, '55088', 'ค่าซ่อมรถ - บฉ-3745 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15810, '55089', 'ค่าซ่อมรถ - บฉ-3713 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15811, '55090', 'ค่าซ่อมรถ - กท-9313 สข.', 'E');
INSERT INTO `other_income_type` VALUES (15812, '55091', 'ค่าซ่อมรถ - บฉ-9857 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15813, '55092', 'ค่าซ่อมรถ - บฉ-9923 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15814, '55093', 'ค่าซ่อมรถ - บฉ-9859 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15815, '55094', 'ค่าซ่อมรถ - บฉ-9937 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15816, '55095', 'ค่าซ่อมรถ - บต-4212 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15817, '55096', 'ค่าซ่อมรถ - บต-4340 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15818, '55097', 'ค่าซ่อมรถ - บต-898 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15819, '55098', 'ค่าซ่อมรถ - บต-6247 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15820, '55099', 'ค่าซ่อมรถ - บต-8084 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15821, '55100', 'ค่าซ่อมรถ - บต-8091 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15822, '55101', 'ค่าซ่อมรถ - บต-7564 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (15823, '55102', 'ค่าซ่อมรถ - 80-7548-49 ยล. รถเต้า', 'E');
INSERT INTO `other_income_type` VALUES (15863, '55103', 'ค่าซ่อมรถ - โฟล์คลิฟท์ NR 03 (FL 4)', 'E');
INSERT INTO `other_income_type` VALUES (15864, '55104', 'ค่าซ่อมรถ -โฟล์คลิฟท์ NR 04 (FL 3)', 'E');
INSERT INTO `other_income_type` VALUES (15865, '55105', 'ค่าซ่อมรถ - โฟล์คลิฟท์ NRTS 03 (FL 10)', 'E');
INSERT INTO `other_income_type` VALUES (15866, '55106', 'ค่าซ่อมรถ - โฟล์คลิฟท์ NRTS 10 (#12)', 'E');
INSERT INTO `other_income_type` VALUES (15867, '55107', 'ค่าซ่อมรถ - โฟล์คลิฟท์ NR 01 (F16)', 'E');
INSERT INTO `other_income_type` VALUES (15868, '55108', 'ค่าซ่อมรถ - 32-8FG30 FL 16 โฟล์คลิฟท์', 'E');
INSERT INTO `other_income_type` VALUES (15869, '55109', 'ค่าซ่อมรถ - โฟล์คลิฟท์ NR 02 (FL 17)', 'E');
INSERT INTO `other_income_type` VALUES (15874, '55053', 'ค่าประกันสังคม', 'E');
INSERT INTO `other_income_type` VALUES (15881, '55110', 'ค่าซ่อมรถ - ผท-257 สข.', 'E');
INSERT INTO `other_income_type` VALUES (15900, '55054', 'ส่วนลด (ลูกหนี้)', 'E');
INSERT INTO `other_income_type` VALUES (15902, '5505', 'ค่าไฟฟ้า', 'E');
INSERT INTO `other_income_type` VALUES (15903, '55055', 'ค่าโทรศัพท์', 'E');
INSERT INTO `other_income_type` VALUES (15905, '55056', 'ค่าอินเตอร์เน็ต', 'E');
INSERT INTO `other_income_type` VALUES (15910, '4118', 'ค่าขนส่ง (เทลเลอร์)', 'I');
INSERT INTO `other_income_type` VALUES (16071, '55111', 'ค่าซ่อมรถ - โฟล์คลิฟท์ NRTS 02 (FD18 FL 1)', 'E');
INSERT INTO `other_income_type` VALUES (16083, '55112', 'ค่าซ่อมรถ - โฟล์คลิฟท์ NRTS 08 (FL 9)', 'E');
INSERT INTO `other_income_type` VALUES (16084, '55113', 'ค่าซ่อมรถ - โฟล์คลิฟท์ NRTS 07 (#11)', 'E');
INSERT INTO `other_income_type` VALUES (16085, '55114', 'ค่าซ่อมรถ - โฟล์คลิฟท์ NRTS 01 (#15)', 'E');
INSERT INTO `other_income_type` VALUES (16272, '55115', 'ค่าซ่อมรถ - บท 7743 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (16378, '55057', 'ภาษีเงินได้ถูกหัก ณ ที่จ่าย', 'E');
INSERT INTO `other_income_type` VALUES (16490, '55116', 'ค่าซ่อมรถ - 80-7472 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (16491, '55117', 'ค่าซ่อมรถ - โฟล์คลิฟท์ NRTS 12 (#14)', 'E');
INSERT INTO `other_income_type` VALUES (16493, '55118', 'ค่าซ่อมรถ - บต-2821 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (16681, '4101', 'ค่าบริการ', 'I');
INSERT INTO `other_income_type` VALUES (16734, '55119', 'ค่าซ่อมรถ - โฟล์คลิฟท์ NRตลาดเก่า 02 (FL5)', 'E');
INSERT INTO `other_income_type` VALUES (16982, '4119', 'ส่วนลดคูปอง', 'I');
INSERT INTO `other_income_type` VALUES (17133, '55000', 'ไม่ได้รับเงินจริง / ล้างเอกสาร', 'E');
INSERT INTO `other_income_type` VALUES (17198, '55030', 'ค่าใช้จ่ายยกเว้นภาษี', 'E');
INSERT INTO `other_income_type` VALUES (17359, '55121', 'ค่าซ่อมรถ - โฟล์คลิฟท์ NRTS 05 (FL 07)', 'E');
INSERT INTO `other_income_type` VALUES (17360, '55122', 'ค่าซ่อมรถ - 62-8FD30 FL 13 โฟล์คลิฟท์', 'E');
INSERT INTO `other_income_type` VALUES (17361, '55123', 'ค่าซ่อมรถ - โฟล์คลิฟท์ NRTS 04 (#18)', 'E');
INSERT INTO `other_income_type` VALUES (18781, '55124', 'ค่าซ่อมรถ - โฟล์คลิฟท์ NRTS 09 พลิกปูน', 'E');
INSERT INTO `other_income_type` VALUES (18972, '55041', 'ค่าบริการแตกมัด', 'E');
INSERT INTO `other_income_type` VALUES (19123, '55125', 'ค่าซ่อมรถ - บท-7273', 'E');
INSERT INTO `other_income_type` VALUES (19124, '55126', 'ค่าซ่อมรถ - บท-7267', 'E');
INSERT INTO `other_income_type` VALUES (19125, '55127', 'ค่าซ่อมรถ - บท-7292', 'E');
INSERT INTO `other_income_type` VALUES (19626, '55128', 'ค่าซ่อมรถ - บท-6241', 'E');
INSERT INTO `other_income_type` VALUES (19789, '55129', 'ค่าซ่อมรถ - 2ฒพ-4035 กทม', 'E');
INSERT INTO `other_income_type` VALUES (19790, '55130', 'ค่าซ่อมรถ - ขค-7415 (ตั้ม)', 'E');
INSERT INTO `other_income_type` VALUES (20482, '55131', 'ค่าซ่อมรถ - ฒม-4243', 'E');
INSERT INTO `other_income_type` VALUES (20484, '55132', 'ค่าซ่อมรถ - บท-7983', 'E');
INSERT INTO `other_income_type` VALUES (20731, '4121', 'ส่วนลดเงินสด (NO VAT)', 'I');
INSERT INTO `other_income_type` VALUES (21112, '55133', 'ค่าซ่อมรถ - โฟล์คลิฟท์ NRตลาดเก่า 01 (FL20)', 'E');
INSERT INTO `other_income_type` VALUES (21349, '55134', 'ค่าซ่อมรถ - 80-8127', 'E');
INSERT INTO `other_income_type` VALUES (21372, '55021', 'ค่าขนส่ง(ยกเว้น)', 'E');
INSERT INTO `other_income_type` VALUES (22023, '55135', 'ค่าซ่อมรถ - โฟล์คลิฟท์ NRTS 11 (นูวา)', 'E');
INSERT INTO `other_income_type` VALUES (22134, '55136', 'ค่าซ่อมรถ - กท-5381 (อนันต์) เก่า กย.67', 'E');
INSERT INTO `other_income_type` VALUES (23662, '55058', 'เงินเดือน', 'E');
INSERT INTO `other_income_type` VALUES (23693, '4122', 'ค่าขนส่ง (ส่งฟรี)', 'I');
INSERT INTO `other_income_type` VALUES (24271, '55137', 'ค่าซ่อมรถ - บธ-916 (ซื้อคืนจาก ธกิจ)', 'E');
INSERT INTO `other_income_type` VALUES (25492, '55138', 'ค่าซ่อมรถ - 80-8525 ยล.', 'E');
INSERT INTO `other_income_type` VALUES (25890, '4123', 'ส่วนลด (ลูกหนี้)', 'I');
INSERT INTO `other_income_type` VALUES (25891, '55139', 'ตัดยอดระหว่างกัน', 'E');
INSERT INTO `other_income_type` VALUES (25900, '55140', 'คืนเงินมัดจำรับ', 'E');
INSERT INTO `other_income_type` VALUES (25908, '4124', 'ตัดยอดระหว่างกัน', 'I');
INSERT INTO `other_income_type` VALUES (25993, '4125', 'เงินมัดจำรับ', 'I');
INSERT INTO `other_income_type` VALUES (26028, '55141', 'เงินมัดจำจ่าย', 'E');
INSERT INTO `other_income_type` VALUES (26084, '4126', 'ส่วนลด (เจ้าหนี้)', 'I');
INSERT INTO `other_income_type` VALUES (26085, '55142', 'ส่วนลด (เจ้าหนี้)', 'E');
INSERT INTO `other_income_type` VALUES (26086, '4127', 'รายได้ ปัดเศษสตางค์', 'I');
INSERT INTO `other_income_type` VALUES (26100, '55143', 'คชจ.ปัดเศษสตางค์', 'E');
INSERT INTO `other_income_type` VALUES (26955, '4128', 'รับคืนเงินมัดจำจ่าย (RPS)', 'I');

-- ----------------------------
-- Table structure for purchase_tax
-- ----------------------------
DROP TABLE IF EXISTS `purchase_tax`;
CREATE TABLE `purchase_tax`  (
  `bill` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `docgroup` int(11) NULL DEFAULT NULL,
  `lname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `docno` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `docdate` date NOT NULL,
  `CUSTNAME` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `refno_docno` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `sumamount1` decimal(18, 2) NULL DEFAULT NULL,
  `sumamount1b` decimal(18, 2) NULL DEFAULT NULL,
  `beforetax` decimal(18, 2) NULL DEFAULT NULL,
  `taxamount` decimal(18, 2) NULL DEFAULT NULL,
  `debtamount` decimal(18, 2) NULL DEFAULT NULL,
  `discamount_vat` decimal(18, 2) NULL DEFAULT NULL,
  `discamount_before_vat` decimal(18, 2) NULL DEFAULT NULL,
  `discamount` decimal(18, 2) NULL DEFAULT NULL,
  `discamountb` decimal(18, 2) NULL DEFAULT NULL,
  `deposit_vat` decimal(18, 2) NULL DEFAULT NULL,
  `deposit_before_vat` decimal(18, 2) NULL DEFAULT NULL,
  `deposit` decimal(18, 2) NOT NULL,
  `cashamount` decimal(18, 2) NULL DEFAULT NULL,
  `bookno` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `bankamount` decimal(18, 2) NULL DEFAULT NULL,
  `chequeamount` decimal(18, 2) NULL DEFAULT NULL,
  `cschqoutpasssub_docno` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `cschqoutpasssub_bookno_pass` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `chqamount` decimal(18, 2) NULL DEFAULT NULL,
  `incomeid` int(11) NULL DEFAULT NULL,
  `incomeamount` decimal(18, 2) NULL DEFAULT NULL,
  `expendid` int(11) NULL DEFAULT NULL,
  `expendamount` decimal(18, 2) NULL DEFAULT NULL,
  `bankexpend` decimal(18, 2) NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`bill`, `docno`) USING BTREE,
  INDEX `idx_docdate`(`docdate`) USING BTREE,
  INDEX `idx_bill`(`bill`) USING BTREE,
  INDEX `idx_docno`(`docno`) USING BTREE,
  INDEX `idx_purchase_tax_docdate`(`docdate`) USING BTREE,
  INDEX `idx_purchase_tax_bill`(`bill`) USING BTREE,
  INDEX `idx_purchase_tax_docno`(`docno`) USING BTREE,
  INDEX `idx_purchase_tax_vendor`(`CUSTNAME`) USING BTREE,
  INDEX `idx_purchase_tax_refno`(`refno_docno`) USING BTREE,
  INDEX `idx_purchase_tax_docdate_bill`(`docdate`, `bill`) USING BTREE,
  INDEX `idx_purchase_tax_docno_docdate`(`docno`, `docdate`) USING BTREE,
  INDEX `idx_purchase_tax_chq_docno`(`cschqoutpasssub_docno`) USING BTREE,
  INDEX `idx_purchase_tax_bookno`(`bookno`) USING BTREE,
  INDEX `idx_purchase_tax_taxamount`(`taxamount`) USING BTREE,
  INDEX `idx_purchase_tax_refno_docno`(`refno_docno`) USING BTREE,
  INDEX `idx_purchase_tax_docdate_docgroup`(`docdate`, `docgroup`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of purchase_tax
-- ----------------------------
INSERT INTO `purchase_tax` VALUES ('2.5.2 IRV', 104, 'บันทึกตั้งหนี้จากการซื้อ', 'IRV6901-0001', '2026-01-03', 'GREEN', NULL, 60000.00, 56074.77, 53271.03, 3728.97, 57000.00, 196.26, 2803.74, 3000.00, 2803.74, NULL, NULL, 0.00, 0.00, '', 0.00, 0.00, NULL, NULL, NULL, -1, 0.00, -1, 0.00, 0.00, '2026-01-03 17:11:21');
INSERT INTO `purchase_tax` VALUES ('2.6 HPV-RRV', 105, 'ซื้อเชื่อ', 'RRV6901-00001', '2026-01-03', 'บริษัท นำรุ่งเคหะภัณฑ์ จำกัด (สำนักงานใหญ่)', 'PSV6901-0001', 1000.00, 934.58, 934.58, 65.42, 1000.00, 0.00, 0.00, 0.00, 0.00, NULL, NULL, 0.00, 0.00, '', 0.00, 0.00, NULL, NULL, NULL, -1, 0.00, -1, 0.00, 0.00, '2026-01-03 17:11:21');
INSERT INTO `purchase_tax` VALUES ('2.6 HPV-RRV', 105, 'ซื้อเชื่อ', 'RRV6901-00002', '2026-01-03', 'บริษัท นำรุ่งเคหะภัณฑ์ จำกัด (เบตง)', NULL, 5000.00, 4672.90, 4672.90, 327.10, 5000.00, 0.00, 0.00, 0.00, 0.00, NULL, NULL, 0.00, 0.00, '', 0.00, 0.00, NULL, NULL, NULL, -1, 0.00, -1, 0.00, 0.00, '2026-01-03 17:11:21');
INSERT INTO `purchase_tax` VALUES ('2.7 GMV', 266, 'ลดหนี้ (ลดหนี้อย่างเดียว NO VAT)', 'GE6808-0001', '2025-08-16', 'บริษัท ปูนซีเมนต์นครหลวง จำกัด (มหาชน) (สำนักงานใหญ่)', NULL, 10472.12, 10472.12, 0.00, 0.00, 10472.12, 0.00, 0.00, 0.00, 0.00, NULL, NULL, 0.00, 0.00, '', 0.00, 0.00, NULL, NULL, NULL, -1, 0.00, -1, 0.00, 0.00, '2026-01-03 17:11:21');
INSERT INTO `purchase_tax` VALUES ('4.5 OEV-OE', 109, 'บันทึกค่าใช้จ่ายอื่นๆ', 'OEV6901-0001', '2026-01-04', 'บริษัท ยะลานำรุ่ง จำกัด (สาขา 1)', NULL, 2336.45, 2336.45, 2336.45, 163.55, 2500.00, 0.00, 0.00, 0.00, 0.00, NULL, NULL, 0.00, 2500.00, '', 0.00, 0.00, NULL, NULL, NULL, -1, 0.00, -1, 0.00, 0.00, '2026-01-04 11:59:07');
INSERT INTO `purchase_tax` VALUES ('4.5 OEV-OE', 109, 'บันทึกค่าใช้จ่ายอื่นๆ', 'OEV6901-0002', '2026-01-04', 'บริษัท ยะลานำรุ่ง จำกัด (สาขา 1)', NULL, 6542.06, 6542.06, 6542.06, 457.94, 7000.00, 0.00, 0.00, 0.00, 0.00, NULL, NULL, 0.00, 0.00, '', 0.00, 7000.00, NULL, NULL, NULL, -1, 0.00, -1, 0.00, 0.00, '2026-01-04 11:59:07');
INSERT INTO `purchase_tax` VALUES ('4.5 OEV-OE', 109, 'บันทึกค่าใช้จ่ายอื่นๆ', 'OEV6901-0003', '2026-01-04', 'บริษัท นำรุ่งเคหะภัณฑ์ จำกัด (เบตง)', NULL, 1448.60, 1448.60, 1448.60, 101.40, 1550.00, 0.00, 0.00, 0.00, 0.00, NULL, NULL, 0.00, 0.00, '', 0.00, 0.00, NULL, NULL, NULL, -1, 0.00, -1, 0.00, 0.00, '2026-01-04 11:59:07');
INSERT INTO `purchase_tax` VALUES ('4.9 PSV', 127, 'จ่ายชำระหนี้', 'PSV6901-0001', '2026-01-03', 'บริษัท นำรุ่งเคหะภัณฑ์ จำกัด (สำนักงานใหญ่)', NULL, 1000.00, NULL, NULL, NULL, NULL, 0.00, 0.00, 0.00, 0.00, NULL, NULL, 0.00, 0.00, '01-061-246-7247', 1005.00, 0.00, NULL, NULL, NULL, -1, 0.00, -1, 0.00, 5.00, '2026-01-03 17:20:14');

-- ----------------------------
-- Table structure for report_config
-- ----------------------------
DROP TABLE IF EXISTS `report_config`;
CREATE TABLE `report_config`  (
  `report_id` int(11) NOT NULL AUTO_INCREMENT,
  `report_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `is_active` tinyint(1) NULL DEFAULT 1,
  `sort_order` int(11) NULL DEFAULT 0,
  `button_color` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `button_icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `main_table` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `join_table` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `join_condition` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `money_type_column` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `income_value` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'I',
  `expense_value` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'E',
  `special_value` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `income_column` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `expense_column` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `special_expense_column` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `base_condition` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `extra_condition` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`report_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of report_config
-- ----------------------------
INSERT INTO `report_config` VALUES (1, 'รายได้จากการขาย', 1, 1, '#0d6efd', NULL, 'all_transactions', 'docgroup_type', 'a.docgroup = b.docgroup', 'R_income', 'I', 'E', NULL, 'a.beforetax', 'a.beforetax', NULL, 'b.R_income <> \'\' and b.R_income is not null', NULL, '2026-01-04 14:25:01', '2026-01-04 17:37:01');
INSERT INTO `report_config` VALUES (2, 'ค่าขนส่ง', 1, 18, '#ae3eea', NULL, 'other_income_expense', 'other_income_type', 'a.code = b.code', 'b.income_type', 'I', 'E', NULL, 'a.income_before_vat', NULL, NULL, 'a.code = \'4112\'', NULL, '2026-01-04 14:30:30', '2026-01-04 15:12:46');
INSERT INTO `report_config` VALUES (3, 'ภาษี', 1, 2, '#0d6efd', NULL, 'all_transactions', 'docgroup_type', 'a.docgroup = b.docgroup', 'R_incomevat', 'I', 'E', NULL, 'a.taxamount', 'a.taxamount', NULL, 'R_incomevat <> \'\' and R_incomevat is not null', NULL, '2026-01-04 14:32:23', '2026-01-04 15:18:09');
INSERT INTO `report_config` VALUES (4, 'รายได้จากปัดเศษสตางค์ 26086	/ 4127', 1, 21, '#d7811d', NULL, 'all_transactions', 'other_income_type', 'a.incomeid = b.id', 'b.income_type', 'I', 'E', NULL, 'a.incomeamount', NULL, NULL, 'b.id = \'26086\'', NULL, '2026-01-04 14:37:14', '2026-01-04 14:45:11');
INSERT INTO `report_config` VALUES (5, '2121000 / คชจ.ปัดเศษสตางค์ 26100/55143', 1, 20, '#d7811d', NULL, 'all_transactions', 'other_income_type', 'a.expendid= b.id', 'b.income_type', 'I', 'E', NULL, NULL, 'a.expendamount', NULL, 'b.id = \'26100\'', NULL, '2026-01-04 14:42:52', '2026-01-04 15:26:15');
INSERT INTO `report_config` VALUES (6, 'มัดจำรับ', 1, 5, '#0d6efd', NULL, 'all_transactions', 'docgroup_type', 'a.docgroup = b.docgroup', 'R_deppay', 'I', 'E', NULL, 'a.beforetax', 'a.deposit', NULL, 'R_deppay<> \'\' and R_deppay is not null', NULL, '2026-01-04 14:48:50', '2026-01-04 15:18:09');
INSERT INTO `report_config` VALUES (7, 'ส่วนลด', 1, 4, '#0d6efd', NULL, 'all_transactions', 'docgroup_type', 'a.docgroup = b.docgroup', 'R_disincome', 'I', 'E', NULL, 'a.discamount_before_vat', 'a.discamount_before_vat', NULL, 'R_disincome<> \'\' and R_disincome is not null', NULL, '2026-01-04 14:50:50', '2026-01-04 15:18:09');
INSERT INTO `report_config` VALUES (8, '4113100 / รับคืน-สินค้า', 1, 7, '#0d6efd', NULL, 'all_transactions', 'docgroup_type', 'a.docgroup = b.docgroup', 'R_cn', 'I', 'E', NULL, NULL, 'a.beforetax', NULL, 'R_cn<> \'\' and R_cn is not null', NULL, '2026-01-04 14:53:07', '2026-01-04 14:53:07');
INSERT INTO `report_config` VALUES (9, '1151000 / ลูกหนี้การค้าหมุนเวียน', 1, 3, '#0d6efd', NULL, 'all_transactions', 'docgroup_type', 'a.docgroup = b.docgroup', 'R_income_cradet', 'I', 'E', NULL, 'a.debtamount', 'a.debtamount', NULL, 'R_income_cradet<> \'\' and R_income_cradet is not null', NULL, '2026-01-04 14:55:08', '2026-01-04 15:18:09');
INSERT INTO `report_config` VALUES (10, '1151100 / ลูกหนี้การค้าไม่หมุ่นเวียน', 1, 6, '#0d6efd', NULL, 'all_transactions', 'docgroup_type', 'a.docgroup = b.docgroup', 'R_income_cradetnon', 'I', 'E', NULL, 'a.debtamount', 'a.debtamount', NULL, 'R_income_cradetnon <> \'\' and R_income_cradetnon is not null', 'a.paysub_docno is null', '2026-01-04 14:57:26', '2026-01-04 15:18:09');
INSERT INTO `report_config` VALUES (11, '1141000 / เช็ครับล่วงหน้า', 1, 8, '#0d6efd', NULL, 'all_transactions', 'docgroup_type', 'a.docgroup = b.docgroup', 'R_chq', 'I', 'E', NULL, 'a.CHEQUEAMOUNT', 'a.CHQAMOUNT', NULL, 'R_chq <> \'\' and R_chq is not null', NULL, '2026-01-04 14:59:03', '2026-01-04 14:59:40');
INSERT INTO `report_config` VALUES (12, 'ซื้อสินค้า', 1, 9, '#fd0d0d', NULL, 'purchase_tax', 'docgroup_type', 'a.docgroup = b.docgroup', 'R_buy', 'I', 'E', NULL, NULL, 'a.sumamount1b', NULL, 'R_buy<> \'\' and R_buy is not null', NULL, '2026-01-04 15:01:11', '2026-01-04 15:02:49');
INSERT INTO `report_config` VALUES (13, '1233010 / ภาษีซื้อ', 1, 10, '#fd0d0d', NULL, 'purchase_tax', 'docgroup_type', 'a.docgroup = b.docgroup', 'R_buytax', 'I', 'E', NULL, 'a.beforetax', 'a.taxamount', NULL, 'R_buytax<> \'\' and R_buytax is not null', NULL, '2026-01-04 15:04:41', '2026-01-04 15:04:41');
INSERT INTO `report_config` VALUES (14, '2131000 / เจ้าหนี้การค้า', 1, 11, '#fd0d0d', NULL, 'purchase_tax', 'docgroup_type', 'a.docgroup = b.docgroup', 'R_cradet_tax', 'I', 'E', NULL, 'a.sumamount1', 'a.debtamount', NULL, 'R_cradet_tax<> \'\' and R_cradet_tax is not null', NULL, '2026-01-04 15:06:31', '2026-01-04 15:06:31');
INSERT INTO `report_config` VALUES (15, 'ส่วนลดรับ', 1, 12, '#fd0d0d', NULL, 'purchase_tax', 'docgroup_type', 'a.docgroup = b.docgroup', 'R_disbuy', 'I', 'E', NULL, NULL, 'a.discamount_before_vat', NULL, 'R_disbuy<> \'\' and R_disbuy is not null', NULL, '2026-01-04 15:07:54', '2026-01-04 15:40:42');
INSERT INTO `report_config` VALUES (16, 'เงินมัดจำจ่ายล่วงหน้า', 1, 13, '#fd0d0d', NULL, 'purchase_tax', 'docgroup_type', 'a.docgroup = b.docgroup', 'R_deppay_buy', 'I', 'E', NULL, 'a.deposit', 'a.beforetax', NULL, 'R_deppay_buy <> \'\' and R_deppay_buy is not null', NULL, '2026-01-04 15:10:58', '2026-01-04 15:11:08');
INSERT INTO `report_config` VALUES (17, 'ส่งคืน', 1, 14, '#fd0d0d', NULL, 'purchase_tax', 'docgroup_type', 'a.docgroup = b.docgroup', 'R_cn_buy', 'I', 'E', NULL, 'a.debtamount', NULL, NULL, 'R_cn_buy <> \'\' and R_cn_buy is not null', NULL, '2026-01-04 15:12:11', '2026-01-04 15:12:35');
INSERT INTO `report_config` VALUES (18, 'เช็คจ่ายล่วงหน้า', 1, 15, '#fd0d0d', NULL, 'purchase_tax', 'docgroup_type', 'a.docgroup = b.docgroup', 'R_chq_buy', 'I', 'E', NULL, NULL, 'a.beforetax', NULL, 'R_chq_buy<> \'\' and R_chq_buy is not null', NULL, '2026-01-04 15:13:51', '2026-01-04 15:14:06');
INSERT INTO `report_config` VALUES (19, '2212100 / ภาษีเงินได้หัก ณ ที่จ่ายค้างจ่าย 16378/55057', 1, 22, '#d7811d', NULL, 'all_transactions', 'other_income_type', 'a.expendid= b.id', 'b.income_type', 'I', 'E', NULL, NULL, 'a.expendamount', NULL, 'b.id = \'16378\'', NULL, '2026-01-04 15:24:20', '2026-01-04 15:25:01');
INSERT INTO `report_config` VALUES (20, 'ค่าซ่อม', 1, 19, '#ae3eea', NULL, 'other_income_expense', 'other_income_type', 'a.code = b.code', 'b.income_type', 'I', 'E', NULL, NULL, 'a.netamount', NULL, 'a.code in (\'55060\',\'55061\',\'55062\',\'55063\')', NULL, '2026-01-04 14:30:30', '2026-01-04 15:36:24');
INSERT INTO `report_config` VALUES (22, 'ค่าบริการ', 1, 17, '#ae3eea', NULL, 'other_income_expense', 'other_income_type', 'a.code = b.code', 'b.income_type', 'I', 'E', NULL, 'a.netamount', NULL, NULL, 'a.code = \'4101\'', NULL, '2026-01-04 14:30:30', '2026-01-04 16:20:07');
INSERT INTO `report_config` VALUES (24, 'ค่าธรรมเนียน', 1, 23, '#0d6efd', NULL, 'all_transactions', 'docgroup_type', 'a.docgroup = b.docgroup', 'R_bankexpend', 'I', 'E', NULL, NULL, 'a.bankexpend', NULL, 'R_bankexpend <>  \'\' and R_bankexpend is not null', NULL, '2026-01-04 16:46:01', '2026-01-04 16:46:01');

-- ----------------------------
-- Table structure for transportation_income
-- ----------------------------
DROP TABLE IF EXISTS `transportation_income`;
CREATE TABLE `transportation_income`  (
  `docno` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'เลขที่เอกสาร (Primary Key)',
  `docdate` date NULL DEFAULT NULL COMMENT 'วันที่เอกสาร',
  `docgroup` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'docgroup',
  `productid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'รหัสสินค้า',
  `productname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'ชื่อสินค้า',
  `custname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'ชื่อลูกค้า',
  `netamount` decimal(18, 2) NULL DEFAULT NULL COMMENT 'ยอดสุทธิ',
  `extamountb` decimal(18, 2) NULL DEFAULT NULL COMMENT 'ยอดเพิ่มเติม/ส่วนขยาย',
  PRIMARY KEY (`docno`) USING BTREE,
  INDEX `idx_docdate`(`docdate`) USING BTREE,
  INDEX `idx_productid`(`productid`) USING BTREE,
  INDEX `idx_custname`(`custname`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = 'ตารางเก็บข้อมูลรายได้ค่าขนส่ง' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of transportation_income
-- ----------------------------
INSERT INTO `transportation_income` VALUES ('', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `transportation_income` VALUES ('H5V6901-0001', '2026-01-03', '115', '15075', 'ค่าขนส่ง', 'นาย มูฮำหมัด แวซู (พนง)', 500.00, 467.29);

SET FOREIGN_KEY_CHECKS = 1;
