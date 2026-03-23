using Microsoft.Data.SqlClient;
using System.Data;
using WebApp.Models;

namespace WebApp.Repositories
{
    public class CustomerRepository
    {
        private readonly string _connectionString;

        public CustomerRepository(string connectionString)
        {
            _connectionString = connectionString ?? throw new ArgumentNullException(nameof(connectionString));
        }

        // SELECT: Tüm müþterileri listele
        public async Task<List<Customer>> GetAllCustomers()
        {
            var customers = new List<Customer>();
            using var connection = new SqlConnection(_connectionString);
            await connection.OpenAsync();
            using var command = new SqlCommand("SELECT CustomerID, Name, Email, PhoneNumber FROM dbo.Customer", connection);
            using var reader = await command.ExecuteReaderAsync();
            while (await reader.ReadAsync())
            {
                customers.Add(new Customer
                {
                    CustomerID = reader.GetInt32(0),
                    Name = reader.IsDBNull(1) ? null : reader.GetString(1),
                    Email = reader.IsDBNull(2) ? null : reader.GetString(2),
                    Phone = reader.IsDBNull(3) ? null : reader.GetString(3)
                });
            }
            return customers;
        }

        // SELECT: ID'ye göre müþteri getir
        public async Task<Customer?> GetCustomerById(int customerId)
        {
            using var connection = new SqlConnection(_connectionString);
            await connection.OpenAsync();
            // image_ff3161.png hatasýný çözmek için gerekli olan adres ve tip alanlarý eklendi
            using var command = new SqlCommand("SELECT CustomerID, Name, Email, PhoneNumber, Address, CustomerType FROM dbo.Customer WHERE CustomerID = @CustomerID", connection);
            command.Parameters.AddWithValue("@CustomerID", customerId);
            using var reader = await command.ExecuteReaderAsync();
            if (await reader.ReadAsync())
            {
                return new Customer
                {
                    CustomerID = reader.GetInt32(0),
                    Name = reader.IsDBNull(1) ? null : reader.GetString(1),
                    Email = reader.IsDBNull(2) ? null : reader.GetString(2),
                    Phone = reader.IsDBNull(3) ? null : reader.GetString(3),
                    Address = reader.IsDBNull(4) ? null : reader.GetString(4),
                    CustomerType = reader.IsDBNull(5) ? null : reader.GetString(5)
                };
            }
            return null;
        }

        // DELETE: Müþteri sil (SP_DELETE_CUSTOMER)
        public async Task DeleteCustomer(int customerId)
        {
            using var connection = new SqlConnection(_connectionString);
            await connection.OpenAsync();
            using var command = new SqlCommand("SP_DELETE_CUSTOMER", connection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@CustomerID", customerId);
            await command.ExecuteNonQueryAsync();
        }

        // YENÝ EKLENEN UPDATE METODU (Orijinal yapýya uygun)
        public async Task<bool> UpdateCustomer(int oldId, int newId, Customer customer, int totalInvoices, decimal totalSpent)
        {
            using var connection = new SqlConnection(_connectionString);
            await connection.OpenAsync();
            using var command = new SqlCommand("SP_UPDATE_CUSTOMER", connection);
            command.CommandType = CommandType.StoredProcedure;

            command.Parameters.AddWithValue("@OldCustomerID", oldId);
            command.Parameters.AddWithValue("@NewCustomerID", newId);
            command.Parameters.AddWithValue("@Name", customer.Name ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@Address", customer.Address ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@PhoneNumber", customer.Phone ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@Email", customer.Email ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@CustomerType", customer.CustomerType ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@TotalInvoices", totalInvoices);
            command.Parameters.AddWithValue("@TotalSpent", totalSpent);

            using var reader = await command.ExecuteReaderAsync();
            if (await reader.ReadAsync())
            {
                return reader.GetInt32(0) == 1; // SQL'den dönen ResultCode
            }
            return false;
        }

        // SELECT: Customer Invoice Summary
        public async Task<List<CustomerInvoiceSummary>> GetCustomerInvoiceSummary()
        {
            var summaries = new List<CustomerInvoiceSummary>();
            using var connection = new SqlConnection(_connectionString);
            await connection.OpenAsync();
            using var command = new SqlCommand(@"
                SELECT c.CustomerID, c.Name AS CustomerName, COUNT(i.InvoiceID) AS TotalInvoices, ISNULL(SUM(i.TotalWithTax), 0) AS TotalSpent
                FROM dbo.Customer c LEFT JOIN dbo.Invoice i ON c.CustomerID = i.CustomerID
                GROUP BY c.CustomerID, c.Name ORDER BY TotalSpent DESC", connection);
            using var reader = await command.ExecuteReaderAsync();
            while (await reader.ReadAsync())
            {
                summaries.Add(new CustomerInvoiceSummary
                {
                    CustomerID = reader.GetInt32(0),
                    CustomerName = reader.IsDBNull(1) ? null : reader.GetString(1),
                    TotalInvoices = reader.GetInt32(2),
                    TotalSpent = reader.GetDecimal(3)
                });
            }
            return summaries;
        }

        // ADD: Müþteri ekle (SP_ADD_CUSTOMER)
        public async Task<int> AddCustomer(Customer customer)
        {
            using var connection = new SqlConnection(_connectionString);
            await connection.OpenAsync();
            using var command = new SqlCommand("SP_ADD_CUSTOMER", connection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@Name", customer.Name ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@Address", customer.Address ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@PhoneNumber", customer.Phone ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@Email", customer.Email ?? (object)DBNull.Value);
            command.Parameters.AddWithValue("@CustomerType", customer.CustomerType ?? (object)DBNull.Value);

            var outputId = new SqlParameter("@NewCustomerID", SqlDbType.Int) { Direction = ParameterDirection.Output };
            command.Parameters.Add(outputId);
            await command.ExecuteNonQueryAsync();
            return (int)outputId.Value;
        }
    }
}