/**
 * Admin Panel JavaScript
 * Handles CRUD operations for report configuration
 */

$(document).ready(function () {
    // Load configurations
    loadConfigs();

    // Event handlers
    $('#btnAddConfig').on('click', showAddModal);
    $('#btnSaveConfig').on('click', saveConfig);

    // Use event delegation for buttons inside modal
    $(document).on('click', '#btnAddColumn', addColumnRow);

    // Delegate event for remove column buttons
    $(document).on('click', '.remove-column', function () {
        $(this).closest('.column-row').remove();
        updateRemoveButtons();
    });

    // Delegate event for edit and delete buttons in table
    $(document).on('click', '.btn-edit', function () {
        const reportId = $(this).data('id');
        editConfig(reportId);
    });

    $(document).on('click', '.btn-delete', function () {
        const reportId = $(this).data('id');
        const reportName = $(this).closest('tr').find('strong').text();
        deleteConfig(reportId, reportName);
    });


    // Generate SQL Preview button
    $(document).on('click', '#btnGenerateSQL', generateSQLPreview);

    // Auto-generate SQL when switching to preview tab
    $('button[data-bs-target="#preview"]').on('shown.bs.tab', function () {
        generateSQLPreview();
    });

    // Sync ETL Button
    $('#btnSyncETL').on('click', syncETL);

    // Real-time search functionality
    $('#searchInput').on('input', function () {
        const searchTerm = $(this).val().trim();
        filterConfigs(searchTerm);

        // Show/hide clear button
        if (searchTerm.length > 0) {
            $('#clearSearch').show();
        } else {
            $('#clearSearch').hide();
        }
    });

    // Clear search button
    $('#clearSearch').on('click', function () {
        $('#searchInput').val('');
        $(this).hide();
        filterConfigs('');
        $('#searchInput').focus();
    });
});

/**
 * Sync ETL Data
 */
function syncETL() {
    Swal.fire({
        title: 'กำลังประมวลผล...',
        text: 'ระบบกำลังทำงาน 3 Script (Purchase Tax, Other Income, All Transactions)',
        icon: 'info',
        allowOutsideClick: false,
        showConfirmButton: false,
        didOpen: () => {
            Swal.showLoading();
        }
    });

    $.ajax({
        url: '../api/run_etl.php',
        method: 'POST',
        dataType: 'json',
        success: function (response) {
            Swal.close();

            if (response.success) {
                let details = '';
                if (response.results) {
                    details = '<br><small class="text-muted" style="font-size:0.8em">';
                    response.results.forEach(res => {
                        const icon = res.status === 'success' ? '✅' : '❌';
                        details += `${icon} ${res.script}<br>`;
                    });
                    details += '</small>';
                }

                Swal.fire({
                    icon: 'success',
                    title: 'Sync เสร็จสมบูรณ์',
                    html: `รันครบ 3 ไฟล์เรียบร้อยแล้ว${details}`,
                    timer: 3000,
                    showConfirmButton: false
                });
            } else {
                let errorHtml = '<div class="text-start mt-2"><small>';
                if (response.results) {
                    response.results.forEach(res => {
                        if (res.status === 'error') {
                            errorHtml += `<div class="text-danger">❌ ${res.script}:<br>${res.message}</div>`;
                            if (res.output) errorHtml += `<div class="bg-light p-1 border mb-2 text-muted" style="font-size:0.8em">${res.output}</div>`;
                        } else {
                            errorHtml += `<div class="text-success">✅ ${res.script}: OK</div>`;
                        }
                    });
                } else {
                    errorHtml += `<span class="text-danger">${response.message}</span>`;
                }
                errorHtml += '</small></div>';

                Swal.fire({
                    icon: 'warning',
                    title: 'พบข้อผิดพลาด',
                    html: errorHtml,
                    width: '600px'
                });
            }
        },
        error: function (xhr, status, error) {
            Swal.close();
            console.error('ETL Error:', error);
            Swal.fire({
                icon: 'error',
                title: 'เกิดข้อผิดพลาด',
                text: 'ไม่สามารถเรียกใช้งาน API Sync ETL ได้ (โปรดตรวจสอบว่ามีไฟล์ Python อยู่จริง)'
            });
        }
    });
}


/**
 * Load all configurations
 */
function loadConfigs() {
    $.ajax({
        url: '../api/manage_config.php',
        method: 'GET',
        dataType: 'json',
        success: function (response) {
            if (response.success) {
                displayConfigs(response.data);
            } else {
                showError('ไม่สามารถโหลดข้อมูลได้');
            }
        },
        error: function (xhr, status, error) {
            console.error('Error loading configs:', error);
            showError('เกิดข้อผิดพลาดในการโหลดข้อมูล');
        }
    });
}

/**
 * Display configurations in table
 */
function displayConfigs(configs) {
    if (configs.length === 0) {
        $('#configTableBody').html(`
            <tr>
                <td colspan="8" class="text-center empty-state">
                    <i class="fas fa-inbox"></i>
                    <p class="mt-2">ยังไม่มีการตั้งค่ารายงาน</p>
                </td>
            </tr>
        `);
        return;
    }

    let html = '';
    configs.forEach((config, index) => {
        const statusBadge = config.is_active == 1
            ? '<span class="badge bg-success">เปิดใช้งาน</span>'
            : '<span class="badge bg-secondary">ปิดใช้งาน</span>';

        const colorBadge = `<div class="color-badge" style="background-color: ${config.button_color || '#dc3545'}"></div>`;

        html += `<tr data-id="${config.report_id}">
                <td>${config.sort_order}</td>
                <td><strong>${escapeHtml(config.report_name)}</strong></td>
                <td><code>${escapeHtml(config.main_table)}</code></td>
                <td><code>${escapeHtml(config.join_table || '-')}</code></td>
                <td>
                    <span class="badge ${config.is_active == 1 ? 'bg-success' : 'bg-secondary'}">
                        ${config.is_active == 1 ? 'เปิดใช้งาน' : 'ปิดใช้งาน'}
                    </span>
                </td>
                <td><div style="width:30px;height:30px;background:${escapeHtml(config.button_color)};border-radius:5px;"></div></td>
                <td>
                    <div class="action-buttons">
                        <button class="btn btn-warning btn-sm btn-action btn-edit" data-id="${config.report_id}">
                            <i class="fas fa-edit"></i> แก้ไข
                        </button>
                        <button class="btn btn-danger btn-sm btn-action btn-delete" data-id="${config.report_id}">
                            <i class="fas fa-trash"></i> ลบ
                        </button>
                    </div>
                </td>
            </tr>`;
    });

    $('#configTableBody').html(html);
}

/**
 * Filter configurations based on search term (real-time search)
 */
function filterConfigs(searchTerm) {
    const rows = $('#configTableBody tr');

    if (!searchTerm) {
        // Show all rows
        rows.show();
        return;
    }

    // Convert search term to lowercase for case-insensitive search
    const searchLower = searchTerm.toLowerCase();

    rows.each(function () {
        const $row = $(this);
        const reportName = $row.find('strong').text().toLowerCase();
        const mainTable = $row.find('code').first().text().toLowerCase();
        const joinTable = $row.find('code').eq(1).text().toLowerCase();

        // Check if any field contains the search term
        if (reportName.includes(searchLower) ||
            mainTable.includes(searchLower) ||
            joinTable.includes(searchLower)) {
            $row.show();
        } else {
            $row.hide();
        }
    });

    // Check if no results found
    const visibleRows = rows.filter(':visible');
    if (visibleRows.length === 0) {
        // Remove existing no-results message if any
        $('#configTableBody .no-results-row').remove();

        // Add no results message
        $('#configTableBody').append(`
            <tr class="no-results-row">
                <td colspan="7" class="text-center text-muted py-4">
                    <i class="fas fa-search"></i>
                    <p class="mt-2 mb-0">ไม่พบรายงานที่ตรงกับ "${escapeHtml(searchTerm)}"</p>
                </td>
            </tr>
        `);
    } else {
        // Remove no-results message if visible rows exist
        $('#configTableBody .no-results-row').remove();
    }
}

/**
 * Add column row for display columns
 */
function addColumnRow() {
    const newRow = `
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
                <button type="button" class="btn btn-danger btn-sm remove-column w-100">
                    <i class="fas fa-trash"></i>
                </button>
            </div>
        </div>
    `;
    $('#displayColumnsContainer').append(newRow);
    updateRemoveButtons();
}

/**
 * Update visibility of remove buttons
 */
function updateRemoveButtons() {
    const rows = $('.column-row');
    if (rows.length === 1) {
        rows.find('.remove-column').hide();
    } else {
        rows.find('.remove-column').show();
    }
}

/**
 * Show add modal
 */
function showAddModal() {
    $('#modalTitle').text('เพิ่มรายงานใหม่');
    $('#configForm')[0].reset();
    $('#report_id').val('');
    $('#button_color').val('#dc3545');
    $('#income_value').val('I');
    $('#expense_value').val('E');
    $('#is_active').val('1');
    $('#sort_order').val('0');

    // Reset display columns
    $('#displayColumnsContainer').html(`
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
    `);

    // Switch to first tab
    const firstTab = new bootstrap.Tab(document.getElementById('basic-tab'));
    firstTab.show();

    const modal = new bootstrap.Modal($('#configModal')[0]);
    modal.show();
}

/**
 * Edit configuration
 */
function editConfig(reportId) {
    // Find config data
    $.ajax({
        url: '../api/manage_config.php',
        method: 'GET',
        dataType: 'json',
        success: function (response) {
            if (response.success) {
                const config = response.data.find(c => c.report_id == reportId);
                if (config) {
                    populateForm(config);
                    $('#modalTitle').text('แก้ไขรายงาน');
                    const modal = new bootstrap.Modal($('#configModal')[0]);
                    modal.show();
                }
            }
        },
        error: function () {
            showError('ไม่สามารถโหลดข้อมูลได้');
        }
    });
}

/**
 * Populate form with config data
 */
function populateForm(config) {
    $('#report_id').val(config.report_id);
    $('#report_name').val(config.report_name);
    $('#sort_order').val(config.sort_order);
    $('#is_active').val(config.is_active);
    $('#button_color').val(config.button_color || '#dc3545');
    $('#button_icon').val(config.button_icon || '');
    $('#main_table').val(config.main_table);
    $('#join_table').val(config.join_table || '');
    $('#join_condition').val(config.join_condition || '');
    $('#money_type_column').val(config.money_type_column);
    $('#income_value').val(config.income_value);
    $('#expense_value').val(config.expense_value);
    $('#special_value').val(config.special_value || '');
    $('#income_column').val(config.income_column || '');
    $('#expense_column').val(config.expense_column || '');
    $('#special_expense_column').val(config.special_expense_column || '');
    $('#base_condition').val(config.base_condition);
    $('#extra_condition').val(config.extra_condition || '');

    // Populate display columns
    $('#displayColumnsContainer').html('');
    if (config.display_columns) {
        try {
            const columns = JSON.parse(config.display_columns);
            if (columns && columns.length > 0) {
                columns.forEach(col => {
                    const row = `
                        <div class="row mb-3 g-2 column-row">
                            <div class="col-md-5">
                                <input type="text" class="form-control column-name" 
                                       value="${escapeHtml(col.column)}" 
                                       placeholder="ชื่อคอลัมน์ (เช่น a.DOCNO)">
                            </div>
                            <div class="col-md-5">
                                <input type="text" class="form-control column-label" 
                                       value="${escapeHtml(col.label)}" 
                                       placeholder="ชื่อที่แสดง (เช่น เลขที่เอกสาร)">
                            </div>
                            <div class="col-md-2">
                                <button type="button" class="btn btn-danger btn-sm remove-column w-100">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </div>
                        </div>
                    `;
                    $('#displayColumnsContainer').append(row);
                });
            }
        } catch (e) {
            console.error('Error parsing display_columns:', e);
        }
    }

    // If no columns, add default row
    if ($('.column-row').length === 0) {
        addColumnRow();
    }

    updateRemoveButtons();
}

/**
 * Save configuration
 */
function saveConfig() {
    // Validate form
    if (!$('#configForm')[0].checkValidity()) {
        $('#configForm')[0].reportValidity();
        return;
    }

    // Gather display columns
    const displayColumns = [];
    $('.column-row').each(function () {
        const column = $(this).find('.column-name').val().trim();
        const label = $(this).find('.column-label').val().trim();

        if (column && label) {
            displayColumns.push({
                column: column,
                label: label
            });
        }
    });

    // Gather form data
    const formData = {
        report_id: $('#report_id').val(),
        report_name: $('#report_name').val(),
        sort_order: $('#sort_order').val(),
        is_active: $('#is_active').val(),
        button_color: $('#button_color').val(),
        button_icon: $('#button_icon').val(),
        main_table: $('#main_table').val(),
        join_table: $('#join_table').val(),
        join_condition: $('#join_condition').val(),
        money_type_column: $('#money_type_column').val(),
        income_value: $('#income_value').val(),
        expense_value: $('#expense_value').val(),
        special_value: $('#special_value').val(),
        income_column: $('#income_column').val(),
        expense_column: $('#expense_column').val(),
        special_expense_column: $('#special_expense_column').val(),
        base_condition: $('#base_condition').val(),
        extra_condition: $('#extra_condition').val(),
        display_columns: JSON.stringify(displayColumns)
    };

    const isEdit = formData.report_id !== '';
    const method = isEdit ? 'PUT' : 'POST';

    // Show loading
    Swal.fire({
        title: 'กำลังบันทึก...',
        allowOutsideClick: false,
        didOpen: () => {
            Swal.showLoading();
        }
    });

    // Send request
    $.ajax({
        url: '../api/manage_config.php',
        method: method,
        contentType: 'application/json',
        data: JSON.stringify(formData),
        dataType: 'json',
        success: function (response) {
            Swal.close();

            if (response.success) {
                Swal.fire({
                    icon: 'success',
                    title: 'สำเร็จ!',
                    text: response.message,
                    timer: 1500,
                    showConfirmButton: false
                });

                // Close modal
                bootstrap.Modal.getInstance($('#configModal')[0]).hide();

                // Reload table
                loadConfigs();
            } else {
                showError(response.message);
            }
        },
        error: function (xhr, status, error) {
            Swal.close();
            console.error('Error saving config:', error);
            showError('เกิดข้อผิดพลาดในการบันทึกข้อมูล');
        }
    });
}

/**
 * Delete configuration
 */
function deleteConfig(reportId, reportName) {
    Swal.fire({
        title: 'ยืนยันการลบ?',
        html: `คุณต้องการลบรายงาน "<strong>${reportName}</strong>" ใช่หรือไม่?`,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#dc3545',
        cancelButtonColor: '#6c757d',
        confirmButtonText: 'ใช่, ลบเลย',
        cancelButtonText: 'ยกเลิก'
    }).then((result) => {
        if (result.isConfirmed) {
            // Show loading
            Swal.fire({
                title: 'กำลังลบ...',
                allowOutsideClick: false,
                didOpen: () => {
                    Swal.showLoading();
                }
            });

            // Send delete request
            $.ajax({
                url: '../api/manage_config.php',
                method: 'DELETE',
                contentType: 'application/json',
                data: JSON.stringify({ report_id: reportId }),
                dataType: 'json',
                success: function (response) {
                    Swal.close();

                    if (response.success) {
                        Swal.fire({
                            icon: 'success',
                            title: 'ลบสำเร็จ!',
                            text: response.message,
                            timer: 1500,
                            showConfirmButton: false
                        });

                        // Reload table
                        loadConfigs();
                    } else {
                        showError(response.message);
                    }
                },
                error: function (xhr, status, error) {
                    Swal.close();
                    console.error('Error deleting config:', error);
                    showError('เกิดข้อผิดพลาดในการลบข้อมูล');
                }
            });
        }
    });
}

/**
 * Show error message
 */
function showError(message) {
    Swal.fire({
        icon: 'error',
        title: 'เกิดข้อผิดพลาด',
        text: message
    });
}

/**
 * Generate SQL Preview
 */
function generateSQLPreview() {
    const mainTable = $('#main_table').val();
    const joinTable = $('#join_table').val();
    const joinCondition = $('#join_condition').val();
    const moneyTypeColumn = $('#money_type_column').val();
    const incomeValue = $('#income_value').val();
    const expenseValue = $('#expense_value').val();
    const incomeColumn = $('#income_column').val();
    const expenseColumn = $('#expense_column').val();
    const baseCondition = $('#base_condition').val();
    const extraCondition = $('#extra_condition').val();

    if (!mainTable || !moneyTypeColumn || !baseCondition) {
        $('#sqlPreviewSummary').html('<code class="sql-comment">-- กรุณากรอกข้อมูลในแท็บ "การตั้งค่า SQL" ก่อน</code>');
        $('#sqlPreviewDetail').html('<code class="sql-comment">-- กรุณากรอกข้อมูลในแท็บ "การตั้งค่า SQL" ก่อน</code>');
        return;
    }

    // Determine date column
    let dateColumn = 'a.DOCDATE';
    if (mainTable === 'other_income_expense' || mainTable === 'purchase_tax') {
        dateColumn = 'a.docdate';
    }

    // Build Summary SQL
    let summarySql = `<code><span class="sql-keyword">SELECT</span>\n`;

    if (incomeColumn) {
        summarySql += `    <span class="sql-keyword">SUM</span>(<span class="sql-keyword">CASE WHEN</span> ${escapeHtml(moneyTypeColumn)} = <span class="sql-string">'${escapeHtml(incomeValue)}'</span> <span class="sql-keyword">THEN</span> ${escapeHtml(incomeColumn)} <span class="sql-keyword">ELSE</span> 0 <span class="sql-keyword">END</span>) <span class="sql-keyword">AS</span> total_income`;
    } else {
        summarySql += `    0 <span class="sql-keyword">AS</span> total_income`;
    }

    summarySql += `,\n`;

    if (expenseColumn) {
        summarySql += `    <span class="sql-keyword">SUM</span>(<span class="sql-keyword">CASE WHEN</span> ${escapeHtml(moneyTypeColumn)} = <span class="sql-string">'${escapeHtml(expenseValue)}'</span> <span class="sql-keyword">THEN</span> ${escapeHtml(expenseColumn)} <span class="sql-keyword">ELSE</span> 0 <span class="sql-keyword">END</span>) <span class="sql-keyword">AS</span> total_expense`;
    } else {
        summarySql += `    0 <span class="sql-keyword">AS</span> total_expense`;
    }

    summarySql += `\n<span class="sql-keyword">FROM</span> ${escapeHtml(mainTable)} a`;

    if (joinTable && joinCondition) {
        summarySql += `\n<span class="sql-keyword">LEFT JOIN</span> ${escapeHtml(joinTable)} b <span class="sql-keyword">ON</span> ${escapeHtml(joinCondition)}`;
    }

    summarySql += `\n<span class="sql-keyword">WHERE</span> ${escapeHtml(baseCondition)}`;
    summarySql += `\n  <span class="sql-keyword">AND</span> ${escapeHtml(dateColumn)} >= <span class="sql-string">'2026-01-01'</span>`;
    summarySql += `\n  <span class="sql-keyword">AND</span> ${escapeHtml(dateColumn)} <= <span class="sql-string">'2026-01-31'</span>`;

    if (extraCondition) {
        summarySql += `\n  <span class="sql-keyword">AND</span> ${escapeHtml(extraCondition)}`;
    }

    summarySql += `;</code>`;

    // Build Detail SQL
    const displayColumns = [];
    $('.column-row').each(function () {
        const column = $(this).find('.column-name').val().trim();
        const label = $(this).find('.column-label').val().trim();
        if (column && label) {
            displayColumns.push({ column, label });
        }
    });

    let detailSql = `<code><span class="sql-keyword">SELECT</span>\n`;

    if (displayColumns.length > 0) {
        displayColumns.forEach((col, index) => {
            detailSql += `    ${escapeHtml(col.column)} <span class="sql-keyword">AS</span> <span class="sql-string">'${escapeHtml(col.label)}'</span>`;
            if (index < displayColumns.length - 1) detailSql += `,\n`;
        });
    } else {
        detailSql += `    a.*`;
    }

    detailSql += `,\n`;

    if (incomeColumn) {
        detailSql += `    <span class="sql-keyword">CASE WHEN</span> ${escapeHtml(moneyTypeColumn)} = <span class="sql-string">'${escapeHtml(incomeValue)}'</span> <span class="sql-keyword">THEN</span> ${escapeHtml(incomeColumn)} <span class="sql-keyword">ELSE</span> 0 <span class="sql-keyword">END</span> <span class="sql-keyword">AS</span> income_amount`;
    } else {
        detailSql += `    0 <span class="sql-keyword">AS</span> income_amount`;
    }

    detailSql += `,\n`;

    if (expenseColumn) {
        detailSql += `    <span class="sql-keyword">CASE WHEN</span> ${escapeHtml(moneyTypeColumn)} = <span class="sql-string">'${escapeHtml(expenseValue)}'</span> <span class="sql-keyword">THEN</span> ${escapeHtml(expenseColumn)} <span class="sql-keyword">ELSE</span> 0 <span class="sql-keyword">END</span> <span class="sql-keyword">AS</span> expense_amount`;
    } else {
        detailSql += `    0 <span class="sql-keyword">AS</span> expense_amount`;
    }

    detailSql += `\n<span class="sql-keyword">FROM</span> ${escapeHtml(mainTable)} a`;

    if (joinTable && joinCondition) {
        detailSql += `\n<span class="sql-keyword">LEFT JOIN</span> ${escapeHtml(joinTable)} b <span class="sql-keyword">ON</span> ${escapeHtml(joinCondition)}`;
    }

    detailSql += `\n<span class="sql-keyword">WHERE</span> ${escapeHtml(baseCondition)}`;
    detailSql += `\n  <span class="sql-keyword">AND</span> ${escapeHtml(dateColumn)} >= <span class="sql-string">'2026-01-01'</span>`;
    detailSql += `\n  <span class="sql-keyword">AND</span> ${escapeHtml(dateColumn)} <= <span class="sql-string">'2026-01-31'</span>`;

    if (extraCondition) {
        detailSql += `\n  <span class="sql-keyword">AND</span> ${escapeHtml(extraCondition)}`;
    }

    detailSql += `\n<span class="sql-keyword">ORDER BY</span> ${escapeHtml(dateColumn)} <span class="sql-keyword">DESC</span>`;
    detailSql += `\n<span class="sql-keyword">LIMIT</span> 50;</code>`;

    $('#sqlPreviewSummary').html(summarySql);
    $('#sqlPreviewDetail').html(detailSql);
}

/**
 * Copy SQL to clipboard
 */
function copySQL(type) {
    const element = type === 'summary' ? $('#sqlPreviewSummary') : $('#sqlPreviewDetail');
    const text = element.text();

    // Try modern Clipboard API first (HTTPS/localhost only)
    if (navigator.clipboard && window.isSecureContext) {
        navigator.clipboard.writeText(text).then(() => {
            Swal.fire({
                icon: 'success',
                title: 'คัดลอกแล้ว!',
                text: 'SQL ถูกคัดลอกไปยังคลิปบอร์ดแล้ว',
                timer: 1500,
                showConfirmButton: false
            });
        }).catch(() => {
            fallbackCopyToClipboard(text);
        });
    } else {
        // Fallback for HTTP (non-secure contexts)
        fallbackCopyToClipboard(text);
    }
}

/**
 * Fallback copy method for HTTP/non-secure contexts
 */
function fallbackCopyToClipboard(text) {
    // Create temporary textarea
    const textarea = document.createElement('textarea');
    textarea.value = text;
    textarea.style.position = 'fixed';
    textarea.style.left = '-9999px';
    textarea.style.top = '-9999px';
    document.body.appendChild(textarea);

    // Select and copy
    textarea.select();
    textarea.setSelectionRange(0, 99999); // For mobile devices

    try {
        const successful = document.execCommand('copy');
        if (successful) {
            Swal.fire({
                icon: 'success',
                title: 'คัดลอกแล้ว!',
                text: 'SQL ถูกคัดลอกไปยังคลิปบอร์ดแล้ว',
                timer: 1500,
                showConfirmButton: false
            });
        } else {
            throw new Error('Copy failed');
        }
    } catch (err) {
        Swal.fire({
            icon: 'error',
            title: 'ไม่สามารถคัดลอกได้',
            text: 'กรุณาคัดลอกด้วยตนเอง'
        });
    } finally {
        document.body.removeChild(textarea);
    }
}

/**
 * Escape HTML to prevent XSS
 */
function escapeHtml(text) {
    if (!text) return '';
    const map = {
        '&': '&amp;',
        '<': '&lt;',
        '>': '&gt;',
        '"': '&quot;',
        "'": '&#039;'
    };
    return text.replace(/[&<>"']/g, m => map[m]);
}
