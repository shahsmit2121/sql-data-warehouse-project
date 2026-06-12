/*
===============================================================================
Stored Procedure: Load Data into Bronze Tables
===============================================================================
Script Purpose:
    This script creates a stored procedure to load data into the 'bronze' schema tables.
	It performs the following tasks:
    - Truncate tables if any of them exist.
    - Load data into each table using 'BULK INSERT' from csv files to bronze tables.

Parameters:
    None.
        This stored procedure does not accept any parameters nor does it return any values.

Usage Example:
    EXEC bronze.load_data
===============================================================================
*/



CREATE OR ALTER PROCEDURE bronze.load_data AS 
BEGIN
    DECLARE @load_start_time DATETIME, @load_end_time DATETIME, @start_time DATETIME, @end_time DATETIME, @row_count INT;
    BEGIN TRY
        SET @load_start_time = GETDATE();
        PRINT '===========================================';
        PRINT 'Starting data load...';
        PRINT '===========================================';
        PRINT ' ';
        SET @start_time = GETDATE();
        PRINT '>>>> Truncating bronze.crm_cust_info <<<<';
        TRUNCATE TABLE bronze.crm_cust_info;
        PRINT '>>>> Loading bronze.crm_cust_info <<<<';
        BULK INSERT bronze.crm_cust_info
        FROM 'D:\Data With Baraa\Project\datasets\source_crm\cust_info.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        SET @row_count = (SELECT COUNT(*) FROM bronze.crm_cust_info);
        PRINT '>>>> Loaded' +  CAST(@row_count AS NVARCHAR) + ' records <<<<';
        PRINT '>>>> Load time: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds <<<<';
        PRINT '>>>> -------------------- <<<<';
        PRINT ' ';


        SET @start_time = GETDATE();
        PRINT '>>>> Truncating bronze.crm_prd_info <<<<';
        TRUNCATE TABLE bronze.crm_prd_info;
        PRINT '>>>> Loading bronze.crm_prd_info <<<<';
        BULK INSERT bronze.crm_prd_info
        FROM 'D:\Data With Baraa\Project\datasets\source_crm\prd_info.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        SET @row_count = (SELECT COUNT(*) FROM bronze.crm_prd_info);
        PRINT '>>>> Loaded' +  CAST(@row_count AS NVARCHAR) + ' records <<<<';
        PRINT '>>>> Load time: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds <<<<';        
        PRINT '>>>> -------------------- <<<<'
        PRINT ' ';


        SET @start_time = GETDATE();
        PRINT '>>>> Truncating bronze.crm_sales_details <<<<';
        TRUNCATE TABLE bronze.crm_sales_details;
        PRINT '>>>> Loading bronze.crm_sales_details <<<<';
        BULK INSERT bronze.crm_sales_details
        FROM 'D:\Data With Baraa\Project\datasets\source_crm\sales_details.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        SET @row_count = (SELECT COUNT(*) FROM bronze.crm_sales_details);
        PRINT '>>>> Loaded' +  CAST(@row_count AS NVARCHAR) + ' records <<<<';
        PRINT '>>>> Load time: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds <<<<';        
        PRINT '>>>> -------------------- <<<<'      
        PRINT ' ';


        SET @start_time = GETDATE();
        PRINT '>>>> Truncating bronze.erp_cust_az12 <<<<';
        TRUNCATE TABLE bronze.erp_cust_az12;
        PRINT '>>>> Loading bronze.erp_cust_az12 <<<<';
        BULK INSERT bronze.erp_cust_az12
        FROM 'D:\Data With Baraa\Project\datasets\source_erp\CUST_AZ12.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        SET @row_count = (SELECT COUNT(*) FROM bronze.erp_cust_az12);
        PRINT '>>>> Loaded' +  CAST(@row_count AS NVARCHAR) + ' records <<<<';
        PRINT '>>>> Load time: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds <<<<';        
        PRINT '>>>> -------------------- <<<<'      
        PRINT ' ';

             
        SET @start_time = GETDATE();
        PRINT '>>>> Truncating bronze.erp_loc_a101 <<<<';
        TRUNCATE TABLE bronze.erp_loc_a101;
        PRINT '>>>> Loading bronze.erp_loc_a101 <<<<';        
        BULK INSERT bronze.erp_loc_a101
        FROM 'D:\Data With Baraa\Project\datasets\source_erp\LOC_A101.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        SET @row_count = (SELECT COUNT(*) FROM bronze.erp_loc_a101);
        PRINT '>>>> Loaded' +  CAST(@row_count AS NVARCHAR) + ' records <<<<';
        PRINT '>>>> Load time: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds <<<<';        
        PRINT '>>>> -------------------- <<<<'    
        PRINT ' ';


        SET @start_time = GETDATE();
        PRINT '>>>> Truncating bronze.erp_px_cat_g1v2 <<<<';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        PRINT '>>>> Loading bronze.erp_px_cat_g1v2 <<<<'; 
        BULK INSERT bronze.erp_px_cat_g1v2
        FROM 'D:\Data With Baraa\Project\datasets\source_erp\PX_CAT_G1V2.csv'
        WITH(
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        SET @row_count = (SELECT COUNT(*) FROM bronze.erp_px_cat_g1v2);
        PRINT '>>>> Loaded' +  CAST(@row_count AS NVARCHAR) + ' records <<<<';
        PRINT '>>>> Load time: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds <<<<';        
        PRINT '>>>> -------------------- <<<<'    

		SET @load_end_time = GETDATE();
		PRINT '=========================================='
		PRINT 'Loading Bronze Layer is Completed';
        PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @load_start_time, @load_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=========================================='
    END TRY
    BEGIN CATCH
		PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Number' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error State' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
    END CATCH
END         