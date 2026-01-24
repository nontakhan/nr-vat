<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>จัดการตั้งค่ารายงาน - Admin Panel</title>
    
    <!-- Google Fonts - Sarabun -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Sarabun:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <!-- Bootstrap 5.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="../assets/css/style.css">
    <link rel="stylesheet" href="../assets/css/admin.css">
</head>
<body>
    <!-- Header -->
    <header class="app-header">
        <div class="container" style="max-width: 1400px;">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h1 class="header-title">
                        <i class="fas fa-cog"></i>
                        จัดการตั้งค่ารายงาน
                    </h1>
                    <p class="header-subtitle">Admin Panel</p>
                </div>
                <div class="col-md-6 text-end">
                    <a href="../index.php" class="btn btn-outline-light">
                        <i class="fas fa-arrow-left"></i> กลับหน้าหลัก
                    </a>
                </div>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="container mt-4" style="max-width: 1400px;">
        <!-- Action Buttons -->
        <div class="row mb-4">
            <div class="col-12 d-flex gap-2">
                <button id="btnAddConfig" class="btn btn-danger btn-lg">
                    <i class="fas fa-plus-circle"></i> เพิ่มรายงานใหม่
                </button>
                <button id="btnSyncETL" class="btn btn-primary btn-lg">
                    <i class="fas fa-sync"></i> Sync ETL
                </button>
            </div>
        </div>

        <!-- Config Table -->
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0">
                    <i class="fas fa-list"></i> รายการตั้งค่ารายงาน
                </h5>
                <div class="search-box">
                    <div class="input-group" style="width: 300px;">
                        <span class="input-group-text bg-white border-end-0">
                            <i class="fas fa-search text-muted"></i>
                        </span>
                        <input type="text" class="form-control border-start-0" id="searchInput" 
                               placeholder="ค้นหาชื่อรายงาน..." autocomplete="off">
                        <button class="btn btn-outline-secondary" type="button" id="clearSearch" style="display: none;">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover" id="configTable">
                        <thead class="table-dark">
                            <tr>
                                <th width="80">ลำดับ</th>
                                <th>ชื่อรายงาน</th>
                                <th>ตารางหลัก</th>
                                <th>ตาราง Join</th>
                                <th width="100">สถานะ</th>
                                <th width="100">สี</th>
                                <th width="150">จัดการ</th>
                            </tr>
                        </thead>
                        <tbody id="configTableBody">
                            <tr>
                                <td colspan="7" class="text-center">
                                    <div class="spinner-border text-danger" role="status">
                                        <span class="visually-hidden">Loading...</span>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>

    <!-- Modal: Add/Edit Config -->
    <div class="modal fade" id="configModal" tabindex="-1">
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title">
                        <i class="fas fa-edit"></i> 
                        <span id="modalTitle">เพิ่มรายงานใหม่</span>
                    </h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="configForm">
                        <input type="hidden" id="report_id" name="report_id">
                        
                        <!-- Nav Tabs -->
                        <ul class="nav nav-tabs mb-4" id="configTabs" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="basic-tab" data-bs-toggle="tab" data-bs-target="#basic" type="button" role="tab">
                                    <i class="fas fa-info-circle"></i> ข้อมูลพื้นฐาน
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="sql-tab" data-bs-toggle="tab" data-bs-target="#sql" type="button" role="tab">
                                    <i class="fas fa-database"></i> การตั้งค่า SQL
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="columns-tab" data-bs-toggle="tab" data-bs-target="#columns" type="button" role="tab">
                                    <i class="fas fa-columns"></i> คอลัมน์ที่แสดง
                                </button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="preview-tab" data-bs-toggle="tab" data-bs-target="#preview" type="button" role="tab">
                                    <i class="fas fa-eye"></i> SQL Preview
                                </button>
                            </li>
                        </ul>

                        <!-- Tab Content -->
                        <div class="tab-content" id="configTabContent">
                            <!-- Tab 1: Basic Info -->
                            <div class="tab-pane fade show active" id="basic" role="tabpanel">
                                <div class="row g-3">
                                    <div class="col-md-8">
                                        <label class="form-label fw-bold">
                                            <i class="fas fa-tag"></i> ชื่อรายงาน <span class="text-danger">*</span>
                                        </label>
                                        <input type="text" class="form-control" id="report_name" name="report_name" required>
                                    </div>
                                    <div class="col-md-2">
                                        <label class="form-label fw-bold">
                                            <i class="fas fa-sort-numeric-up"></i> ลำดับ
                                        </label>
                                        <input type="number" class="form-control" id="sort_order" name="sort_order" value="0">
                                    </div>
                                    <div class="col-md-2">
                                        <label class="form-label fw-bold">
                                            <i class="fas fa-toggle-on"></i> สถานะ
                                        </label>
                                        <select class="form-select" id="is_active" name="is_active">
                                            <option value="1">เปิดใช้งาน</option>
                                            <option value="0">ปิดใช้งาน</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="row g-3 mt-3">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">
                                            <i class="fas fa-palette"></i> สีปุ่ม
                                        </label>
                                        <input type="color" class="form-control form-control-color w-100" id="button_color" name="button_color" value="#dc3545">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">
                                            <i class="fas fa-icons"></i> ไอคอน (Font Awesome)
                                        </label>
                                        <input type="text" class="form-control" id="button_icon" name="button_icon" placeholder="fa-chart-line">
                                        <small class="text-muted">ตัวอย่าง: fa-chart-line, fa-money-bill-wave</small>
                                    </div>
                                </div>
                            </div>

                            <!-- Tab 2: SQL Configuration -->
                            <div class="tab-pane fade" id="sql" role="tabpanel">
                                <!-- Tables Section -->
                                <div class="config-section">
                                    <h6 class="section-title">
                                        <i class="fas fa-table"></i> ตารางข้อมูล
                                    </h6>
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label fw-bold">ตารางหลัก <span class="text-danger">*</span></label>
                                            <select class="form-select" id="main_table" name="main_table" required>
                                                <option value="">-- เลือกตาราง --</option>
                                                <option value="all_transactions">all_transactions</option>
                                                <option value="other_income_expense">other_income_expense</option>
                                                <option value="purchase_tax">purchase_tax</option>
                                            </select>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label fw-bold">ตาราง Join</label>
                                            <select class="form-select" id="join_table" name="join_table">
                                                <option value="">-- ไม่มี --</option>
                                                <option value="docgroup_type">docgroup_type</option>
                                                <option value="other_income_type">other_income_type</option>
                                            </select>
                                        </div>
                                        <div class="col-12">
                                            <label class="form-label fw-bold">เงื่อนไข Join</label>
                                            <input type="text" class="form-control" id="join_condition" name="join_condition" 
                                                   placeholder="a.docgroup = b.docgroup">
                                            <small class="text-muted">ใช้ a. สำหรับตารางหลัก, b. สำหรับตาราง join</small>
                                        </div>
                                    </div>
                                </div>

                                <!-- Money Type Section -->
                                <div class="config-section mt-4">
                                    <h6 class="section-title">
                                        <i class="fas fa-coins"></i> ประเภทเงิน
                                    </h6>
                                    <div class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label fw-bold">คอลัมน์ประเภทเงิน <span class="text-danger">*</span></label>
                                            <input type="text" class="form-control" id="money_type_column" name="money_type_column" required
                                                   placeholder="b.income_type">
                                            <small class="text-muted">คอลัมน์ที่บอกว่าเป็นรายรับหรือรายจ่าย</small>
                                        </div>
                                        <div class="col-md-2">
                                            <label class="form-label fw-bold">ค่ารายรับ</label>
                                            <input type="text" class="form-control" id="income_value" name="income_value" value="I">
                                        </div>
                                        <div class="col-md-2">
                                            <label class="form-label fw-bold">ค่ารายจ่าย</label>
                                            <input type="text" class="form-control" id="expense_value" name="expense_value" value="E">
                                        </div>
                                        <div class="col-md-2">
                                            <label class="form-label fw-bold">ค่าพิเศษ</label>
                                            <input type="text" class="form-control" id="special_value" name="special_value">
                                        </div>
                                    </div>
                                </div>

                                <!-- Amount Columns Section -->
                                <div class="config-section mt-4">
                                    <h6 class="section-title">
                                        <i class="fas fa-dollar-sign"></i> คอลัมน์ยอดเงิน
                                    </h6>
                                    <div class="row g-3">
                                        <div class="col-md-4">
                                            <label class="form-label fw-bold">คอลัมน์รายรับ</label>
                                            <input type="text" class="form-control" id="income_column" name="income_column"
                                                   placeholder="a.beforetax">
                                        </div>
                                        <div class="col-md-4">
                                            <label class="form-label fw-bold">คอลัมน์รายจ่าย</label>
                                            <input type="text" class="form-control" id="expense_column" name="expense_column"
                                                   placeholder="a.beforetax">
                                        </div>
                                        <div class="col-md-4">
                                            <label class="form-label fw-bold">คอลัมน์รายจ่ายพิเศษ</label>
                                            <input type="text" class="form-control" id="special_expense_column" name="special_expense_column">
                                        </div>
                                    </div>
                                </div>

                                <!-- Conditions Section -->
                                <div class="config-section mt-4">
                                    <h6 class="section-title">
                                        <i class="fas fa-filter"></i> เงื่อนไขการกรอง
                                    </h6>
                                    <div class="row g-3">
                                        <div class="col-12">
                                            <label class="form-label fw-bold">เงื่อนไขพื้นฐาน <span class="text-danger">*</span></label>
                                            <textarea class="form-control" id="base_condition" name="base_condition" rows="2" required
                                                      placeholder="b.R_income <> '' and b.R_income is not null"></textarea>
                                            <small class="text-muted">เงื่อนไขหลักในการกรองข้อมูล</small>
                                        </div>
                                        <div class="col-12">
                                            <label class="form-label fw-bold">เงื่อนไขเพิ่มเติม</label>
                                            <textarea class="form-control" id="extra_condition" name="extra_condition" rows="2"
                                                      placeholder="a.paysub_docno is null"></textarea>
                                            <small class="text-muted">เงื่อนไขเสริม (ถ้ามี)</small>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Tab 3: Display Columns -->
                            <div class="tab-pane fade" id="columns" role="tabpanel">
                                <div class="alert alert-info">
                                    <i class="fas fa-info-circle"></i>
                                    <strong>คำแนะนำ:</strong> กำหนดฟิลด์ที่ต้องการแสดงในตารางรายละเอียด
                                    <br><small>ใช้ a. สำหรับตารางหลัก และ b. สำหรับตาราง join</small>
                                </div>

                                <div id="displayColumnsContainer" class="columns-container">
                                    <div class="row mb-3 g-2 column-row">
                                        <div class="col-md-5">
                                            <input type="text" class="form-control column-name" 
                                                   placeholder="ชื่อคอลัมน์ (เช่น a.DOCNO)">
                                        </div>
                                        <div class="col-md-5">
                                            <input type="text" class="form-control column-label" 
                                                   placeholder="ชื่อที่แสดง (เช่น เลขที่เอกสาร)">
                                        </div>
                                        <div class="col-md-2">
                                            <button type="button" class="btn btn-danger btn-sm remove-column w-100" style="display:none;">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                
                                <button type="button" class="btn btn-success btn-sm" id="btnAddColumn">
                                    <i class="fas fa-plus"></i> เพิ่มคอลัมน์
                                </button>
                                
                                <div class="alert alert-light mt-3 border">
                                    <strong>ตัวอย่าง:</strong>
                                    <table class="table table-sm mt-2 mb-0">
                                        <thead>
                                            <tr>
                                                <th>คอลัมน์</th>
                                                <th>ชื่อที่แสดง</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td><code>a.DOCNO</code></td>
                                                <td>เลขที่เอกสาร</td>
                                            </tr>
                                            <tr>
                                                <td><code>a.DOCDATE</code></td>
                                                <td>วันที่</td>
                                            </tr>
                                            <tr>
                                                <td><code>a.CUSTNAME</code></td>
                                                <td>ชื่อลูกค้า</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                            <!-- Tab 4: SQL Preview -->
                            <div class="tab-pane fade" id="preview" role="tabpanel">
                                <div class="alert alert-info">
                                    <i class="fas fa-info-circle"></i>
                                    <strong>คำแนะนำ:</strong> นี่คือ SQL query ที่จะถูกใช้จริงในการดึงข้อมูล
                                    <br><small>คุณสามารถคัดลอกไปทดสอบใน phpMyAdmin หรือ MySQL Workbench ได้</small>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">
                                        <i class="fas fa-code"></i> SQL Query (สรุปยอด)
                                    </label>
                                    <pre id="sqlPreviewSummary" class="sql-preview"><code>-- กรุณากรอกข้อมูลในแท็บอื่นก่อน</code></pre>
                                    <button type="button" class="btn btn-sm btn-secondary" onclick="copySQL('summary')">
                                        <i class="fas fa-copy"></i> คัดลอก
                                    </button>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">
                                        <i class="fas fa-list"></i> SQL Query (รายละเอียด)
                                    </label>
                                    <pre id="sqlPreviewDetail" class="sql-preview"><code>-- กรุณากรอกข้อมูลในแท็บอื่นก่อน</code></pre>
                                    <button type="button" class="btn btn-sm btn-secondary" onclick="copySQL('detail')">
                                        <i class="fas fa-copy"></i> คัดลอก
                                    </button>
                                </div>

                                <div class="alert alert-warning">
                                    <i class="fas fa-exclamation-triangle"></i>
                                    <strong>หมายเหตุ:</strong>
                                    <ul class="mb-0 mt-2">
                                        <li>SQL นี้เป็นตัวอย่างสำหรับทดสอบเท่านั้น</li>
                                        <li>ค่า date จะถูกแทนที่ด้วย :start_date และ :end_date ตอนรันจริง</li>
                                        <li>ควรทดสอบใน database ก่อนบันทึก</li>
                                    </ul>
                                </div>

                                <button type="button" class="btn btn-primary" id="btnGenerateSQL">
                                    <i class="fas fa-sync"></i> สร้าง SQL ใหม่
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times"></i> ยกเลิก
                    </button>
                    <button type="button" class="btn btn-danger" id="btnSaveConfig">
                        <i class="fas fa-save"></i> บันทึก
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="app-footer mt-5">
        <div class="container" style="max-width: 1400px;">
            <div class="row">
                <div class="col-md-6">
                    <p class="mb-0">&copy; 2026 Admin Panel</p>
                </div>
                <div class="col-md-6 text-end">
                    <p class="mb-0">จัดการระบบรายงาน</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    
    <!-- Bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <!-- Custom JS -->
    <script src="../assets/js/admin.js"></script>
</body>
</html>
