/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
DECLARE @start_time DATETIME, @end_time DATETIME , @batch_start_time DATETIME , @batch_end_time DATETIME ;
/*1*/
  BEGIN TRY 
  SET @batch_start_time = GETDATE();
PRINT '===================';
PRINT 'LOADING BRONZE LAYER ';
PRINT '===================='
SET @start_time = GETDATE();
	TRUNCATE TABlE bronze.crm_cust_info ;
	BULK INSERT bronze.crm_cust_info
	FROM 'C:\Users\admin\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\cust_info.csv'
	WITH(
	FIRSTROW = 2 ,
	FIELDTERMINATOR = ',' ,
	TABLOCK
	) ;
SET @end_time = GETDATE();
PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';
 
/*2*/
SET @start_time = GETDATE();
TRUNCATE TABLE bronze.crm_prd_info;
BULK INSERT bronze.crm_prd_info
FROM 'C:\Users\admin\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\prd_info.csv'
WITH(
FIRSTROW = 2 ,
FIELDTERMINATOR = ',',
TABLOCK 
);
SET @end_time = GETDATE();
SET @end_time = GETDATE();
PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';
 
/*3*/
SET @start_time = GETDATE(); 
TRUNCATE TABLE bronze.crm_sales_details;
BULK INSERT bronze.crm_sales_details
FROM 'C:\Users\admin\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_crm\sales_details.csv'
WITH(
FIRSTROW = 2 ,
FIELDTERMINATOR = ',',
TABLOCK 
);
SET @end_time = GETDATE();
PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';
 
/*4*/
SET @start_time = GETDATE() ;
TRUNCATE TABLE bronze.erp_cust_az12;
BULK INSERT bronze.erp_cust_az12
FROM 'C:\Users\admin\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\CUST_AZ12.csv'
WITH(
FIRSTROW = 2 ,
FIELDTERMINATOR = ',',
TABLOCK 
);
SET @end_time = GETDATE() ; 
PRINT '>> Load Duration' + CAST(DATEDIFF(second , @start_time , @end_time) AS NVARCHAR) + 'seconds'
PRINT '>> -------------';
/*5*/
SET @start_time = GETDATE() ;
TRUNCATE TABLE bronze.erp_loc_a101;
BULK INSERT bronze.erp_loc_a101
FROM 'C:\Users\admin\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\LOC_A101.csv'
WITH(
FIRSTROW = 2 ,
FIELDTERMINATOR = ',',
TABLOCK 
);
SET @end_time = GETDATE() ; 
PRINT '>> Load Duration' + CAST(DATEDIFF(second , @start_time , @end_time) AS NVARCHAR) + 'seconds'
PRINT '>> -------------';
 

/*6*/
SET @start_time = GETDATE() ;

TRUNCATE TABLE bronze.erp_px_cat_g1v2;
BULK INSERT bronze.erp_loc_a101
FROM 'C:\Users\admin\Downloads\sql-data-warehouse-project-main\sql-data-warehouse-project-main\datasets\source_erp\PX_CAT_G1V2.csv'
WITH(
FIRSTROW = 2 ,
FIELDTERMINATOR = ',',
TABLOCK 
);
SET @end_time = GETDATE() ; 
PRINT '>> Load Duration' + CAST(DATEDIFF(second , @start_time , @end_time) AS NVARCHAR) + 'seconds'
PRINT '>> -------------';
SET @batch_end_time = GETDATE();
		PRINT '=========================================='
		PRINT 'Loading Bronze Layer is Completed';
        PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '==========================================' ;
END TRY 
BEGIN CATCH
PRINT '=========';
PRINT 'ERROR OCCOURED ';
PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
PRINT 'ERROR NUMBER' + CAST(ERROR_NUMBER() AS NVARCHAR)  ;
PRINT '=========='
END CATCH
END 
