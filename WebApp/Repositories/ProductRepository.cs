// WebApp/Repositories/ProductRepository.cs

using Microsoft.Data.SqlClient;
using System.Data;
using WebApp.Models;

namespace WebApp.Repositories
{
    public class ProductRepository
    {
        private readonly string _connectionString;

        public ProductRepository(string connectionString)
        {
            _connectionString = connectionString ?? throw new ArgumentNullException(nameof(connectionString));
        }

        // SELECT: Tüm ürünleri listele
        public async Task<List<Product>> GetAllProducts()
        {
            var products = new List<Product>();

            using var connection = new SqlConnection(_connectionString);
            await connection.OpenAsync();

            // Gerçek sütun isimlerini kullan: ProductName ve UnitPrice
            using var command = new SqlCommand("SELECT ProductID, ProductName, UnitPrice, Stock FROM dbo.Product", connection);
            using var reader = await command.ExecuteReaderAsync();
            
            while (await reader.ReadAsync())
            {
                products.Add(new Product
                {
                    ProductID = reader.GetInt32(0),
                    Name = reader.IsDBNull(1) ? null : reader.GetString(1),
                    Price = reader.GetDecimal(2),
                    Stock = reader.GetInt32(3)
                });
            }

            return products;
        }

        // SELECT: ID'ye göre ürün getir
        public async Task<Product?> GetProductById(int productId)
        {
            using var connection = new SqlConnection(_connectionString);
            await connection.OpenAsync();

            using var command = new SqlCommand("SELECT ProductID, ProductName, UnitPrice, Stock FROM dbo.Product WHERE ProductID = @ProductID", connection);
            command.Parameters.AddWithValue("@ProductID", productId);

            using var reader = await command.ExecuteReaderAsync();
            
            if (await reader.ReadAsync())
            {
                return new Product
                {
                    ProductID = reader.GetInt32(0),
                    Name = reader.IsDBNull(1) ? null : reader.GetString(1),
                    Price = reader.GetDecimal(2),
                    Stock = reader.GetInt32(3)
                };
            }

            return null;
        }

        // UPDATE: Stok güncelle (SP_UPDATE_PRODUCT_STOCK)
        public async Task UpdateProductStock(int productId, int newStock)
        {
            using var connection = new SqlConnection(_connectionString);
            await connection.OpenAsync();

            using var command = new SqlCommand("SP_UPDATE_PRODUCT_STOCK", connection);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@ProductID", productId);
            command.Parameters.AddWithValue("@NewStock", newStock);

            await command.ExecuteNonQueryAsync();
        }
    }
}
