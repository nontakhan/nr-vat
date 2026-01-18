<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ระบบสรุปค่าใช้จ่าย - บริษัทขายก่อสร้าง</title>
    
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
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>
    <!-- Header -->
    <header class="app-header">
        <div class="container" style="max-width: 1400px;">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h1 class="header-title">
                        <i class="fas fa-chart-line"></i>
                        ระบบสรุปค่าใช้จ่าย
                    </h1>
                    <p class="header-subtitle">บริษัทขายอุปกรณ์ก่อสร้างทุกชนิด</p>
                </div>
                <div class="col-md-6 text-end">
                    <a href="admin/config.php" class="btn btn-outline-light">
                        <i class="fas fa-cog"></i> จัดการรายงาน
                    </a>
                </div>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="container mt-4" style="max-width: 1400px;">
        <!-- Filters Section -->
        <div class="card filter-card mb-4">
            <div class="card-body">
                <div class="row align-items-end">
                    <div class="col-md-4">
                        <label class="form-label fw-bold">
                            <i class="fas fa-calendar-alt"></i> เลือกช่วงวันที่
                        </label>
                        <input type="text" id="dateRange" class="form-control form-control-lg" placeholder="เลือกวันที่...">
                    </div>
                    <div class="col-md-3">
                        <button id="btnToday" class="btn btn-outline-primary">
                            <i class="fas fa-calendar-day"></i> วันนี้
                        </button>
                        <button id="btnThisMonth" class="btn btn-outline-primary">
                            <i class="fas fa-calendar-week"></i> เดือนนี้
                        </button>
                    </div>
                    <div class="col-md-5 text-end">
                        <button id="btnReset" class="btn btn-outline-secondary">
                            <i class="fas fa-undo"></i> รีเซ็ต
                        </button>
                    </div>
                </div>
            </div>
        </div>

        <!-- Report Buttons -->
        <div class="card report-buttons-card mb-4">
            <div class="card-header">
                <h5 class="mb-0">
                    <i class="fas fa-list-ul"></i> เลือกรายงาน
                </h5>
            </div>
            <div class="card-body">
                <div id="reportButtons" class="row g-3">
                    <!-- Buttons will be loaded here dynamically -->
                    <div class="col-12 text-center">
                        <div class="spinner-border text-danger" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                        <p class="mt-2 text-muted">กำลังโหลดรายงาน...</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Summary Cards -->
        <div id="summarySection" class="row g-4 mb-4" style="display: none;">
            <div class="col-md-4">
                <div class="summary-card income-card">
                    <div class="card-icon">
                        <i class="fas fa-arrow-up"></i>
                    </div>
                    <div class="card-content">
                        <h6>รายรับ</h6>
                        <h3 id="incomeAmount">0.00</h3>
                        <p class="mb-0"><span id="incomeCount">0</span> รายการ</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="summary-card expense-card">
                    <div class="card-icon">
                        <i class="fas fa-arrow-down"></i>
                    </div>
                    <div class="card-content">
                        <h6>รายจ่าย</h6>
                        <h3 id="expenseAmount">0.00</h3>
                        <p class="mb-0"><span id="expenseCount">0</span> รายการ</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="summary-card net-card">
                    <div class="card-icon">
                        <i class="fas fa-balance-scale"></i>
                    </div>
                    <div class="card-content">
                        <h6>สุทธิ</h6>
                        <h3 id="netAmount">0.00</h3>
                        <p class="mb-0" id="netStatus">-</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Chart Section -->
        <div id="chartSection" class="row mb-4" style="display: none;">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h6 class="mb-0">
                            <i class="fas fa-chart-pie"></i> สัดส่วนรายรับ-รายจ่าย
                        </h6>
                    </div>
                    <div class="card-body">
                        <canvas id="pieChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header">
                        <h6 class="mb-0">
                            <i class="fas fa-chart-bar"></i> เปรียบเทียบ
                        </h6>
                    </div>
                    <div class="card-body">
                        <canvas id="barChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Report Info -->
        <div id="reportInfo" class="alert alert-info" style="display: none;">
            <h6 class="alert-heading">
                <i class="fas fa-info-circle"></i> <span id="reportName">-</span>
            </h6>
            <p class="mb-0">
                ช่วงวันที่: <strong id="dateRangeDisplay">ทั้งหมด</strong>
            </p>
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
                    <p class="mb-0">Powered by Dynamic Report Config</p>
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
    
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    
    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <!-- Custom JS -->
    <script src="assets/js/main.js"></script>
</body>
</html>
