// WebApp/Models/InvoiceInputModel.cs

using System.ComponentModel.DataAnnotations;

namespace WebApp.Models
{
    public class InvoiceInputModel
    {
        [Required(ErrorMessage = "Customer ID is required.")]
        [Range(1, int.MaxValue, ErrorMessage = "Customer ID must be a positive number.")]
        public int CustomerID { get; set; }

        [Required(ErrorMessage = "Product ID is required.")]
        [Range(1, int.MaxValue, ErrorMessage = "Product ID must be a positive number.")]
        public int ProductID { get; set; }

        [Required(ErrorMessage = "Total Amount is required.")]
        [Range(0.01, (double)decimal.MaxValue, ErrorMessage = "Amount must be greater than 0.")]
        public decimal TotalAmount { get; set; }

        public string? TaxOfficeNumber { get; set; }
        public string? InvoicingParty { get; set; }
        public string? InvoicedParty { get; set; }
    }
}