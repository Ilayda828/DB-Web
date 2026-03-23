// WebApp/Models/CustomerInvoiceSummary.cs

namespace WebApp.Models
{
    public class CustomerInvoiceSummary
    {
        public int CustomerID { get; set; }
        public string? CustomerName { get; set; }
        public int TotalInvoices { get; set; }
        public decimal TotalSpent { get; set; }
    }
}
