<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>รายละเอียดรายงาน - ระบบสรุปค่าใช้จ่าย</title>
    
    <!-- Google Fonts - Sarabun -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Sarabun:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    
    <!-- Bootstrap 5.3 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Date Range Picker -->
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
    
    <!-- DataTables -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.7/css/dataTables.bootstrap5.min.css">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="assets/css/style.css">
    
    <style>
        .detail-table-container {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 8px 32px rgba(230, 57, 70, 0.15);
            border: 1px solid rgba(255, 255, 255, 0.8);
        }
        
        .table-responsive {
            margin-top: 1rem;
        }
        
        table.dataTable {
            font-size: 0.95rem;
        }
        
        table.dataTable thead th {
            background: linear-gradient(135deg, var(--dark-red) 0%, var(--primary-red) 100%);
            color: white;
            font-weight: 700;
            border: none;
        }
        
        table.dataTable tbody tr:hover {
            background-color: rgba(230, 57, 70, 0.05);
        }
        
        .summary-bar {
            background: linear-gradient(135deg, rgba(230, 57, 70, 0.08) 0%, rgba(247, 37, 133, 0.08) 100%);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
        }
        
        .summary-item {
            text-align: center;
        }
        
        .summary-item .label {
            font-size: 0.9rem;
            color: #6b7280;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .summary-item .value {
            font-size: 1.8rem;
            font-weight: 800;
            margin-top: 0.5rem;
        }
        
        .summary-item.income .value {
            color: #10b981;
        }
        
        .summary-item.expense .value {
            color: var(--primary-red);
        }
        
        .summary-item.net .value {
            color: #3b82f6;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="app-header">
        <div class="container" style="max-width: 1400px;">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h1 class="header-title">
                        <i class="fas fa-file-invoice"></i>
                        รายละเอียดรายงาน
                    </h1>
                    <p class="header-subtitle" id="reportNameHeader">-</p>
                </div>
                <div class="col-md-6 text-end">
                    <a href="index.php" class="btn btn-outline-light me-2">
                        <i class="fas fa-arrow-left"></i> กลับหน้าหลัก
                    </a>
                    <button id="btnExport" class="btn btn-outline-light">
                        <i class="fas fa-download"></i> Export Excel
                    </button>
                </div>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="container mt-4" style="max-width: 1400px;">
        <!-- Summary Bar -->
        <div class="summary-bar">
            <div class="row">
                <div class="col-md-4 summary-item income">
                    <div class="label">รายรับรวม</div>
                    <div class="value" id="summaryIncome">0.00 ฿</div>
                </div>
                <div class="col-md-4 summary-item expense">
                    <div class="label">รายจ่ายรวม</div>
                    <div class="value" id="summaryExpense">0.00 ฿</div>
                </div>
                <div class="col-md-4 summary-item net">
                    <div class="label">สุทธิ</div>
                    <div class="value" id="summaryNet">0.00 ฿</div>
                </div>
            </div>
        </div>

        <!-- Data Table -->
        <div class="detail-table-container">
            <h5 class="mb-3">
                <i class="fas fa-list"></i> รายการทั้งหมด
                <span class="badge bg-danger ms-2" id="totalRecords">0</span> รายการ
            </h5>
            
            <div class="table-responsive">
                <table id="detailTable" class="table table-hover table-striped" style="width:100%">
                    <thead>
                        <!-- Columns will be generated dynamically -->
                    </thead>
                    <tbody>
                        <!-- Data will be loaded via AJAX -->
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="app-footer mt-5">
        <div class="container" style="max-width: 1400px;">
            <div class="row">
                <div class="col-md-6">
                    <p class="mb-0">&copy; 2026 ระบบสรุปค่าใช้จ่าย</p>
                </div>
                <div class="col-md-6 text-end">
                    <p class="mb-0">รายละเอียดรายงาน</p>
                </div>
            </div>
        </div>
    </footer>

    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
    
    <!-- Bootstrap -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Moment.js -->
    <script src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
    <script src="https://cdn.jsdelivr.net/momentjs/latest/locale/th.js"></script>
    
    <!-- Date Range Picker -->
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
    
    <!-- DataTables -->
    <script src="https://cdn.datatables.net/1.13.7/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.7/js/dataTables.bootstrap5.min.js"></script>
    
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <!-- SheetJS for Excel Export -->
    <script src="https://cdn.sheetjs.com/xlsx-0.20.1/package/dist/xlsx.full.min.js"></script>
    
    <!-- Custom JS -->
    <script src="assets/js/report_detail.js"></script>
</body>
</html>
