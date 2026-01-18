ALTER TABLE `report_config` 
ADD COLUMN `display_columns` TEXT NULL COMMENT 'JSON array of columns to display in detail view' AFTER `extra_condition`;
