// WebApp/Repositories/InvoiceRepository.cs

using Microsoft.Data.SqlClient;
using System.Data;
using WebApp.Models;

namespace WebApp.Repositories
{
    public class InvoiceRepository
    {
        private readonly string _connectionString;

        public InvoiceRepository(string connectionString)
        {
            _connectionString = connectionString ?? throw new ArgumentNullException(nameof(connectionString));
        }

        // CREATE: Fatura oluþtur
        public async Task<int> CreateInvoice(InvoiceInputModel model)
        {
            using var connection = new SqlConnection(_connectionString);
            await connection.OpenAsync();

            using var command = new SqlCommand("SP_CREATE_INVOICE", connection);
            command.CommandType = CommandType.StoredProcedure;

            // Zorunlu parametreler
            command.Parameters.AddWithValue("@CustomerID", model.CustomerID);
            command.Parameters.AddWithValue("@ProductID", model.ProductID);
            command.Parameters.AddWithValue("@TotalAmount", model.TotalAmount);

            // Varsayýlan parametreler
            command.Parameters.AddWithValue("@TaxRate", 20.0m);
            command.Parameters.AddWithValue("@InvoiceType", "Sales");

            // Opsiyonel parametreler (null olabilir)
            command.Parameters.AddWithValue("@TaxOfficeNumber", 
                (object?)model.TaxOfficeNumber ?? DBNull.Value);
            command.Parameters.AddWithValue("@InvoicingParty", 
                (object?)model.InvoicingParty ?? DBNull.Value);
            command.Parameters.AddWithValue("@InvoicedParty", 
                (object?)model.InvoicedParty ?? DBNull.Value);

            // Çýktý parametresi (@NewInvoiceID)
            var outputParam = new SqlParameter("@NewInvoiceID", SqlDbType.Int)
            {
                Direction = ParameterDirection.Output
            };
            command.Parameters.Add(outputParam);

            // Saklý yordamý çalýþtýr
            await command.ExecuteNonQueryAsync();

            // Çýktý parametresini oku ve döndür
            return (int)outputParam.Value;
        }

        // DELETE: Fatura sil (C# Transaction ile FK çatýþmasýný çöz)
        public async Task DeleteInvoiceAsync(int invoiceId)
        {
            using var connection = new SqlConnection(_connectionString);
            await connection.OpenAsync();

            // Transaction baþlat
            using var transaction = connection.BeginTransaction();

            try
            {
                // ADIM 1: Önce Payment kayýtlarýný sil (FK_Payment_Invoice)
                using (var deletePaymentsCmd = new SqlCommand(
                    "DELETE FROM dbo.Payment WHERE InvoiceID = @InvoiceID", 
                    connection, 
                    transaction))
                {
                    deletePaymentsCmd.Parameters.AddWithValue("@InvoiceID", invoiceId);
                    await deletePaymentsCmd.ExecuteNonQueryAsync();
                }

                // ADIM 2: Sonra Invoice'ý sil
                using (var deleteInvoiceCmd = new SqlCommand(
                    "DELETE FROM dbo.Invoice WHERE InvoiceID = @InvoiceID", 
                    connection, 
                    transaction))
                {
                    deleteInvoiceCmd.Parameters.AddWithValue("@InvoiceID", invoiceId);
                    int rowsAffected = await deleteInvoiceCmd.ExecuteNonQueryAsync();

                    if (rowsAffected == 0)
                    {
                        throw new InvalidOperationException($"Invoice with ID {invoiceId} not found.");
                    }
                }

                // Transaction'ý commit et
                await transaction.CommitAsync();
            }
            catch
            {
                // Hata durumunda rollback
                await transaction.RollbackAsync();
                throw;
            }
        }

        // SELECT: Tüm faturalarý listele
        public async Task<List<Invoice>> GetAllInvoices()
        {
            var invoices = new List<Invoice>();

            using var connection = new SqlConnection(_connectionString);
            await connection.OpenAsync();

            using var command = new SqlCommand(
                "SELECT InvoiceID, CustomerID, ProductID, TotalAmount, TotalWithTax, InvoiceDate FROM dbo.Invoice ORDER BY InvoiceDate DESC", 
                connection);
            using var reader = await command.ExecuteReaderAsync();

            while (await reader.ReadAsync())
            {
                invoices.Add(new Invoice
                {
                    InvoiceID = reader.GetInt32(0),
                    CustomerID = reader.GetInt32(1),
                    ProductID = reader.GetInt32(2),
                    TotalAmount = reader.GetDecimal(3),
                    TotalWithTax = reader.GetDecimal(4),
                    InvoiceDate = reader.GetDateTime(5)
                });
            }

            return invoices;
        }

        // SELECT: ID'ye göre fatura getir
        public async Task<Invoice?> GetInvoiceById(int invoiceId)
        {
            using var connection = new SqlConnection(_connectionString);
            await connection.OpenAsync();

            using var command = new SqlCommand(
                "SELECT InvoiceID, CustomerID, ProductID, TotalAmount, TotalWithTax, InvoiceDate FROM dbo.Invoice WHERE InvoiceID = @InvoiceID", 
                connection);
            command.Parameters.AddWithValue("@InvoiceID", invoiceId);

            using var reader = await command.ExecuteReaderAsync();

            if (await reader.ReadAsync())
            {
                return new Invoice
                {
                    InvoiceID = reader.GetInt32(0),
                    CustomerID = reader.GetInt32(1),
                    ProductID = reader.GetInt32(2),
                    TotalAmount = reader.GetDecimal(3),
                    TotalWithTax = reader.GetDecimal(4),
                    InvoiceDate = reader.GetDateTime(5)
                };
            }

            return null;
        }
    }
}
