-- This goes against EF Core!!!
BEGIN TRY
    BEGIN TRANSACTION 
       ALTER TABLE dbo.Invoice ADD ExpireDate DATE NOT NULL DEFAULT(GETDATE());
    COMMIT
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRAN

        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY()
        DECLARE @ErrorState INT = ERROR_STATE()

    RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
END CATCH
