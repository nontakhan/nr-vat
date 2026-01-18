/**
 * Report Detail JavaScript
 * Handles detail view with DataTables
 */

$(document).ready(function () {
    // Get URL parameters
    const urlParams = new URLSearchParams(window.location.search);
    const reportId = urlParams.get('report_id');
    const reportName = urlParams.get('report_name') || 'รายงาน';
    const startDate = urlParams.get('start_date');
    const endDate = urlParams.get('end_date');

    if (!reportId) {
        Swal.fire({
            icon: 'error',
            title: 'ข้อผิดพลาด',
            text: 'ไม่พบรหัสรายงาน'
        }).then(() => {
            window.location.href = 'index.php';
        });
        return;
    }

    // Set header
    $('#reportNameHeader').text(reportName);

    // Display date range in header if available
    if (startDate && endDate) {
        const displayDate = moment(startDate).format('DD/MM/YYYY') + ' - ' + moment(endDate).format('DD/MM/YYYY');
        $('#reportNameHeader').append(`<br><small style="opacity: 0.9;">${displayDate}</small>`);
    }

    // Load data
    loadReportDetail();

    // Event handlers
    $('#btnExport').on('click', exportToExcel);
});

let dataTable = null;
let reportData = null;

/**
 * Load report detail data
 */
function loadReportDetail() {
    const urlParams = new URLSearchParams(window.location.search);
    const reportId = urlParams.get('report_id');
    const startDate = urlParams.get('start_date') || '';
    const endDate = urlParams.get('end_date') || '';

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
        url: 'api/get_report_detail.php',
        method: 'GET',
        data: {
            report_id: reportId,
            start_date: startDate,
            end_date: endDate,
            per_page: 1000 // Get all for client-side DataTables
        },
        dataType: 'json',
        success: function (response) {
            Swal.close();

            if (response.success) {
                reportData = response;

                // Debug: Show SQL info
                if (response.debug) {
                    console.log('=== SQL DEBUG INFO ===');
                    console.log('Income SQL:', response.debug.income_sql);
                    console.log('Expense SQL:', response.debug.expense_sql);
                    console.log('Money Type Column:', response.debug.money_type_column);
                    console.log('Qualified Column:', response.debug.money_type_column_qualified);
                    console.log('Income Value:', response.debug.income_value);
                    console.log('Expense Value:', response.debug.expense_value);
                    console.log('======================');
                }

                displayReportDetail(response);
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
            console.error('Error loading report detail:', error);
            Swal.fire({
                icon: 'error',
                title: 'เกิดข้อผิดพลาด',
                text: 'ไม่สามารถโหลดข้อมูลรายงานได้'
            });
        }
    });
}

/**
 * Display report detail
 */
function displayReportDetail(data) {
    // Update summary
    $('#summaryIncome').text(formatNumber(data.summary.total_income) + ' ฿');
    $('#summaryExpense').text(formatNumber(data.summary.total_expense) + ' ฿');
    $('#summaryNet').text(formatNumber(Math.abs(data.summary.net)) + ' ฿');

    // Update records count
    $('#totalRecords').text(formatNumber(data.pagination.total_records));

    // Destroy existing DataTable
    if (dataTable) {
        dataTable.destroy();
        $('#detailTable').empty();
    }

    // Build table headers
    let headerHtml = '<tr>';
    headerHtml += '<th>#</th>';

    data.columns.forEach(col => {
        headerHtml += `<th>${escapeHtml(col.label)}</th>`;
    });

    headerHtml += '<th class="text-end">รายรับ (฿)</th>';
    headerHtml += '<th class="text-end">รายจ่าย (฿)</th>';
    headerHtml += '</tr>';

    $('#detailTable thead').html(headerHtml);

    // Build table body
    let bodyHtml = '';
    let displayIndex = 0;

    data.data.forEach((row, index) => {
        // Debug: log first row
        if (index === 0) {
            console.log('First row data:', row);
            console.log('debug_money_type:', row.debug_money_type);
        }

        const income = parseFloat(row.income_amount || 0);
        const expense = parseFloat(row.expense_amount || 0);

        // Skip rows where both income and expense are 0
        if (income === 0 && expense === 0) {
            return;
        }

        displayIndex++;
        bodyHtml += '<tr>';
        bodyHtml += `<td>${displayIndex}</td>`;

        data.columns.forEach(col => {
            let value = row[col.label] || '-';

            // Format dates
            if (col.label.includes('วันที่') || col.column.toLowerCase().includes('date')) {
                if (value && value !== '-') {
                    value = moment(value).format('DD/MM/YYYY');
                }
            }

            bodyHtml += `<td>${escapeHtml(String(value))}</td>`;
        });

        bodyHtml += `<td class="text-end ${income > 0 ? 'text-success fw-bold' : ''}">${income > 0 ? formatNumber(income) : '-'}</td>`;
        bodyHtml += `<td class="text-end ${expense > 0 ? 'text-danger fw-bold' : ''}">${expense > 0 ? formatNumber(expense) : '-'}</td>`;
        bodyHtml += '</tr>';
    });

    $('#detailTable tbody').html(bodyHtml);

    // Initialize DataTable
    dataTable = $('#detailTable').DataTable({
        language: {
            url: '//cdn.datatables.net/plug-ins/1.13.7/i18n/th.json'
        },
        pageLength: 25,
        lengthMenu: [[25, 50, 100, -1], [25, 50, 100, "ทั้งหมด"]],
        order: [[0, 'asc']],
        responsive: true,
        dom: '<"row"<"col-sm-12 col-md-6"l><"col-sm-12 col-md-6"f>>rtip'
    });
}

/**
 * Export to Excel
 */
function exportToExcel() {
    if (!reportData || !reportData.data || reportData.data.length === 0) {
        Swal.fire({
            icon: 'warning',
            title: 'ไม่มีข้อมูล',
            text: 'ไม่มีข้อมูลให้ export'
        });
        return;
    }

    // Prepare data for export
    const exportData = [];

    // Headers
    const headers = ['#'];
    reportData.columns.forEach(col => headers.push(col.label));
    headers.push('รายรับ (฿)', 'รายจ่าย (฿)');
    exportData.push(headers);

    // Data rows
    reportData.data.forEach((row, index) => {
        const rowData = [index + 1];

        reportData.columns.forEach(col => {
            let value = row[col.label] || '';

            // Format dates
            if (col.label.includes('วันที่') || col.column.toLowerCase().includes('date')) {
                if (value) {
                    value = moment(value).format('DD/MM/YYYY');
                }
            }

            rowData.push(value);
        });

        rowData.push(parseFloat(row.income_amount || 0));
        rowData.push(parseFloat(row.expense_amount || 0));

        exportData.push(rowData);
    });

    // Add summary row
    exportData.push([]);
    exportData.push(['', 'สรุปรวม', '', '', '', 'รายรับรวม', reportData.summary.total_income]);
    exportData.push(['', '', '', '', '', 'รายจ่ายรวม', reportData.summary.total_expense]);
    exportData.push(['', '', '', '', '', 'สุทธิ', reportData.summary.net]);

    // Create workbook
    const wb = XLSX.utils.book_new();
    const ws = XLSX.utils.aoa_to_sheet(exportData);

    // Add worksheet to workbook
    XLSX.utils.book_append_sheet(wb, ws, 'รายงาน');

    // Generate filename
    const filename = `รายงาน_${reportData.report_name}_${moment().format('YYYYMMDD_HHmmss')}.xlsx`;

    // Save file
    XLSX.writeFile(wb, filename);

    Swal.fire({
        icon: 'success',
        title: 'สำเร็จ!',
        text: 'Export Excel เรียบร้อยแล้ว',
        timer: 1500,
        showConfirmButton: false
    });
}

/**
 * Format number with commas
 */
function formatNumber(num) {
    return parseFloat(num).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
}

/**
 * Escape HTML to prevent XSS
 */
function escapeHtml(text) {
    if (text === null || text === undefined) return '';
    const map = {
        '&': '&amp;',
        '<': '&lt;',
        '>': '&gt;',
        '"': '&quot;',
        "'": '&#039;'
    };
    return String(text).replace(/[&<>"']/g, m => map[m]);
}
