// WebApp/Models/Product.cs

namespace WebApp.Models
{
    public class Product
    {
        public int ProductID { get; set; }
        public string? Name { get; set; }
        public decimal Price { get; set; }
        public int Stock { get; set; }
    }
}
