// WebApp/Models/Invoice.cs

namespace WebApp.Models
{
    public class Invoice
    {
        public int InvoiceID { get; set; }
        public int CustomerID { get; set; }
        public int ProductID { get; set; }
        public decimal TotalAmount { get; set; }
        public decimal TotalWithTax { get; set; }
        public DateTime InvoiceDate { get; set; }
    }
}
