/**
 * Main JavaScript for Expense Summary System
 * Handles dynamic report loading and data visualization
 */

$(document).ready(function () {
    // Global variables
    let selectedReportId = null;
    let pieChart = null;
    let barChart = null;

    // Initialize date range picker
    initDateRangePicker();

    // Load report buttons
    loadReportButtons();

    // Event handlers
    $('#btnToday').on('click', setToday);
    $('#btnThisMonth').on('click', setThisMonth);
    $('#btnReset').on('click', resetFilters);
});

/**
 * Initialize Date Range Picker
 */
function initDateRangePicker() {
    moment.locale('th');

    // Set default to current month
    const startOfMonth = moment().startOf('month');
    const endOfMonth = moment().endOf('month');

    $('#dateRange').daterangepicker({
        startDate: startOfMonth,
        endDate: endOfMonth,
        autoUpdateInput: true,
        locale: {
            cancelLabel: 'ล้าง',
            applyLabel: 'ตกลง',
            format: 'DD/MM/YYYY',
            customRangeLabel: 'กำหนดเอง',
            daysOfWeek: ['อา', 'จ', 'อ', 'พ', 'พฤ', 'ศ', 'ส'],
            monthNames: [
                'มกราคม', 'กุมภาพันธ์', 'มีนาคม', 'เมษายน', 'พฤษภาคม', 'มิถุนายน',
                'กรกฎาคม', 'สิงหาคม', 'กันยายน', 'ตุลาคม', 'พฤศจิกายน', 'ธันวาคม'
            ],
            firstDay: 0
        },
        ranges: {
            'วันนี้': [moment(), moment()],
            'เมื่อวาน': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            '7 วันล่าสุด': [moment().subtract(6, 'days'), moment()],
            '30 วันล่าสุด': [moment().subtract(29, 'days'), moment()],
            'เดือนนี้': [moment().startOf('month'), moment().endOf('month')],
            'เดือนที่แล้ว': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        }
    });

    $('#dateRange').on('apply.daterangepicker', function (ev, picker) {
        $(this).val(picker.startDate.format('DD/MM/YYYY') + ' - ' + picker.endDate.format('DD/MM/YYYY'));

        if (selectedReportId) {
            loadReportData(selectedReportId);
        }
    });

    $('#dateRange').on('cancel.daterangepicker', function (ev, picker) {
        // Reset to current month when cancelled
        const resetStart = moment().startOf('month');
        const resetEnd = moment().endOf('month');
        picker.setStartDate(resetStart);
        picker.setEndDate(resetEnd);
        $(this).val(resetStart.format('DD/MM/YYYY') + ' - ' + resetEnd.format('DD/MM/YYYY'));

        if (selectedReportId) {
            loadReportData(selectedReportId);
        }
    });

    // Set initial display value
    $('#dateRange').val(startOfMonth.format('DD/MM/YYYY') + ' - ' + endOfMonth.format('DD/MM/YYYY'));
}

/**
 * Set date range to today
 */
function setToday() {
    const today = moment();
    $('#dateRange').data('daterangepicker').setStartDate(today);
    $('#dateRange').data('daterangepicker').setEndDate(today);
    $('#dateRange').val(today.format('DD/MM/YYYY') + ' - ' + today.format('DD/MM/YYYY'));

    // Reload report buttons with new date range
    loadReportButtons();

    if (selectedReportId) {
        loadReportData(selectedReportId);
    }
}

/**
 * Set date range to this month
 */
function setThisMonth() {
    const startOfMonth = moment().startOf('month');
    const endOfMonth = moment().endOf('month');
    $('#dateRange').data('daterangepicker').setStartDate(startOfMonth);
    $('#dateRange').data('daterangepicker').setEndDate(endOfMonth);
    $('#dateRange').val(startOfMonth.format('DD/MM/YYYY') + ' - ' + endOfMonth.format('DD/MM/YYYY'));

    // Reload report buttons with new date range
    loadReportButtons();

    if (selectedReportId) {
        loadReportData(selectedReportId);
    }
}

/**
 * Reset all filters
 */
function resetFilters() {
    $('#dateRange').val('');
    selectedReportId = null;

    // Hide summary and charts
    $('#summarySection').hide();
    $('#chartSection').hide();
    $('#reportInfo').hide();

    // Reset active state on buttons
    $('.report-btn').removeClass('active');

    Swal.fire({
        icon: 'success',
        title: 'รีเซ็ตสำเร็จ',
        text: 'กรุณาเลือกรายงานใหม่',
        timer: 1500,
        showConfirmButton: false
    });
}

/**
 * Load report configuration buttons
 */
function loadReportButtons() {
    // Get current date range
    let startDate = '';
    let endDate = '';
    const dateRangeVal = $('#dateRange').val();
    if (dateRangeVal) {
        const dates = dateRangeVal.split(' - ');
        startDate = moment(dates[0], 'DD/MM/YYYY').format('YYYY-MM-DD');
        endDate = moment(dates[1], 'DD/MM/YYYY').format('YYYY-MM-DD');
    } else {
        // Default to current month
        startDate = moment().startOf('month').format('YYYY-MM-DD');
        endDate = moment().endOf('month').format('YYYY-MM-DD');
    }

    $.ajax({
        url: 'api/get_configs.php',
        method: 'GET',
        data: {
            start_date: startDate,
            end_date: endDate
        },
        dataType: 'json',
        success: function (response) {
            if (response.success && response.data.length > 0) {
                displayReportButtons(response.data);
            } else {
                $('#reportButtons').html(`
                    <div class="col-12 text-center">
                        <p class="text-muted">ไม่พบการตั้งค่ารายงาน</p>
                        <a href="admin/config.php" class="btn btn-danger">
                            <i class="fas fa-plus"></i> เพิ่มรายงาน
                        </a>
                    </div>
                `);
            }
        },
        error: function (xhr, status, error) {
            console.error('Error loading configs:', error);
            Swal.fire({
                icon: 'error',
                title: 'เกิดข้อผิดพลาด',
                text: 'ไม่สามารถโหลดรายการรายงานได้'
            });
        }
    });
}

/**
 * Display report buttons dynamically
 */
function displayReportButtons(configs) {
    let html = '';

    configs.forEach(config => {
        const color = config.button_color || '#dc3545';
        const icon = config.button_icon || 'fa-file-alt';

        // Get summary data
        const income = config.summary?.income || 0;
        const expense = config.summary?.expense || 0;
        const net = config.summary?.net || 0;

        // Format net amount
        const netFormatted = formatNumber(Math.abs(net));
        const netClass = net >= 0 ? 'text-success' : 'text-danger';
        const netIcon = net >= 0 ? 'fa-arrow-up' : 'fa-arrow-down';

        // Show summary only if net is not zero
        const showSummary = net !== 0;

        html += `
            <div class="col-md-3 col-sm-6 fade-in">
                <button class="report-btn" 
                        style="background: linear-gradient(135deg, ${color} 0%, ${adjustColor(color, -20)} 100%);"
                        onclick="selectReport(${config.report_id}, '${escapeHtml(config.report_name)}')">
                    <div class="report-btn-content">
                        <div class="report-title">
                            <i class="fas ${icon}"></i>
                            <span>${escapeHtml(config.report_name)}</span>
                        </div>
                        ${showSummary ? `<div class="report-summary">
                            <i class="fas ${netIcon}"></i>
                            <span>${netFormatted} ฿</span>
                        </div>` : ''}
                    </div>
                </button>
            </div>
        `;
    });

    $('#reportButtons').html(html);
}

/**
 * Select and redirect to detail page
 */
function selectReport(reportId, reportName) {
    // Get date range from picker, or use default (this month)
    let startDate = '';
    let endDate = '';

    const dateRangeVal = $('#dateRange').val();
    if (dateRangeVal) {
        const dates = dateRangeVal.split(' - ');
        startDate = moment(dates[0], 'DD/MM/YYYY').format('YYYY-MM-DD');
        endDate = moment(dates[1], 'DD/MM/YYYY').format('YYYY-MM-DD');
    } else {
        // Default to current month
        startDate = moment().startOf('month').format('YYYY-MM-DD');
        endDate = moment().endOf('month').format('YYYY-MM-DD');
    }

    // Build URL with parameters
    let url = 'report_detail.php?report_id=' + reportId + '&report_name=' + encodeURIComponent(reportName);
    url += '&start_date=' + startDate + '&end_date=' + endDate;

    // Redirect to detail page
    window.location.href = url;
}

/**
 * Load report data from API
 */
function loadReportData(reportId, reportName = '') {
    // Get date range
    let startDate = '';
    let endDate = '';

    const dateRangeVal = $('#dateRange').val();
    if (dateRangeVal) {
        const dates = dateRangeVal.split(' - ');
        startDate = moment(dates[0], 'DD/MM/YYYY').format('YYYY-MM-DD');
        endDate = moment(dates[1], 'DD/MM/YYYY').format('YYYY-MM-DD');
    }

    // Show loading
    Swal.fire({
        title: 'กำลังโหลดข้อมูล...',
        allowOutsideClick: false,
        didOpen: () => {
            Swal.showLoading();
        }
    });

    // Call API
    $.ajax({
        url: 'api/get_report_data.php',
        method: 'GET',
        data: {
            report_id: reportId,
            start_date: startDate,
            end_date: endDate
        },
        dataType: 'json',
        success: function (response) {
            Swal.close();

            if (response.success) {
                displayReportData(response);
            } else {
                Swal.fire({
                    icon: 'error',
                    title: 'ข้อผิดพลาด',
                    text: response.message || 'ไม่สามารถโหลดข้อมูลได้'
                });
            }
        },
        error: function (xhr, status, error) {
            Swal.close();
            console.error('Error loading report:', error);
            Swal.fire({
                icon: 'error',
                title: 'เกิดข้อผิดพลาด',
                text: 'ไม่สามารถโหลดข้อมูลรายงานได้'
            });
        }
    });
}

/**
 * Display report data
 */
function displayReportData(data) {
    // Update summary cards
    const income = data.summary.income.amount;
    const expense = data.summary.expense.amount;
    const net = data.summary.net;

    $('#incomeAmount').text(formatNumber(income) + ' ฿');
    $('#incomeCount').text(formatNumber(data.summary.income.count));

    $('#expenseAmount').text(formatNumber(expense) + ' ฿');
    $('#expenseCount').text(formatNumber(data.summary.expense.count));

    $('#netAmount').text(formatNumber(Math.abs(net)) + ' ฿');

    if (net > 0) {
        $('#netStatus').html('<i class="fas fa-arrow-up text-success"></i> กำไร');
        $('.net-card .card-content h3').removeClass('text-danger').addClass('text-success');
    } else if (net < 0) {
        $('#netStatus').html('<i class="fas fa-arrow-down text-danger"></i> ขาดทุน');
        $('.net-card .card-content h3').removeClass('text-success').addClass('text-danger');
    } else {
        $('#netStatus').html('<i class="fas fa-minus text-secondary"></i> คงที่');
        $('.net-card .card-content h3').removeClass('text-success text-danger');
    }

    // Update report info
    $('#reportName').text(data.report_name);
    const dateDisplay = data.date_range.start === 'ทั้งหมด'
        ? 'ทั้งหมด'
        : `${moment(data.date_range.start).format('DD/MM/YYYY')} - ${moment(data.date_range.end).format('DD/MM/YYYY')}`;
    $('#dateRangeDisplay').text(dateDisplay);

    // Show sections
    $('#summarySection').fadeIn();
    $('#chartSection').fadeIn();
    $('#reportInfo').fadeIn();

    // Update charts
    updateCharts(income, expense);

    // Scroll to summary
    $('html, body').animate({
        scrollTop: $('#summarySection').offset().top - 100
    }, 500);
}

/**
 * Update charts
 */
function updateCharts(income, expense) {
    // Pie Chart
    const pieCtx = document.getElementById('pieChart').getContext('2d');

    if (pieChart) {
        pieChart.destroy();
    }

    pieChart = new Chart(pieCtx, {
        type: 'pie',
        data: {
            labels: ['รายรับ', 'รายจ่าย'],
            datasets: [{
                data: [income, expense],
                backgroundColor: [
                    'rgba(40, 167, 69, 0.8)',
                    'rgba(220, 20, 60, 0.8)'
                ],
                borderColor: [
                    'rgba(40, 167, 69, 1)',
                    'rgba(220, 20, 60, 1)'
                ],
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            plugins: {
                legend: {
                    position: 'bottom'
                },
                tooltip: {
                    callbacks: {
                        label: function (context) {
                            const label = context.label || '';
                            const value = formatNumber(context.parsed);
                            return label + ': ' + value + ' ฿';
                        }
                    }
                }
            }
        }
    });

    // Bar Chart
    const barCtx = document.getElementById('barChart').getContext('2d');

    if (barChart) {
        barChart.destroy();
    }

    barChart = new Chart(barCtx, {
        type: 'bar',
        data: {
            labels: ['รายรับ', 'รายจ่าย', 'สุทธิ'],
            datasets: [{
                label: 'จำนวนเงิน (บาท)',
                data: [income, expense, Math.abs(income - expense)],
                backgroundColor: [
                    'rgba(40, 167, 69, 0.8)',
                    'rgba(220, 20, 60, 0.8)',
                    'rgba(0, 123, 255, 0.8)'
                ],
                borderColor: [
                    'rgba(40, 167, 69, 1)',
                    'rgba(220, 20, 60, 1)',
                    'rgba(0, 123, 255, 1)'
                ],
                borderWidth: 2
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: true,
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: function (value) {
                            return formatNumber(value) + ' ฿';
                        }
                    }
                }
            },
            plugins: {
                legend: {
                    display: false
                },
                tooltip: {
                    callbacks: {
                        label: function (context) {
                            return formatNumber(context.parsed.y) + ' ฿';
                        }
                    }
                }
            }
        }
    });
}

/**
 * Format number with commas
 */
function formatNumber(num) {
    return parseFloat(num).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
}

/**
 * Adjust color brightness
 */
function adjustColor(color, amount) {
    const usePound = color[0] === '#';
    let col = usePound ? color.slice(1) : color;

    let num = parseInt(col, 16);
    let r = (num >> 16) + amount;
    let g = ((num >> 8) & 0x00FF) + amount;
    let b = (num & 0x0000FF) + amount;

    r = Math.max(Math.min(255, r), 0);
    g = Math.max(Math.min(255, g), 0);
    b = Math.max(Math.min(255, b), 0);

    return (usePound ? '#' : '') + ((r << 16) | (g << 8) | b).toString(16).padStart(6, '0');
}

/**
 * Escape HTML to prevent XSS
 */
function escapeHtml(text) {
    const map = {
        '&': '&amp;',
        '<': '&lt;',
        '>': '&gt;',
        '"': '&quot;',
        "'": '&#039;'
    };
    return text.replace(/[&<>"']/g, m => map[m]);
}
