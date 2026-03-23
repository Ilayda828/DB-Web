using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using WebApp.Models;
using WebApp.Repositories;
using Microsoft.Data.SqlClient;

namespace WebApp.Pages.Invoice
{
    public class DeleteInvoiceModel : PageModel
    {
        private readonly InvoiceRepository _invoiceRepository;

        public WebApp.Models.Invoice? InvoiceToDelete { get; set; }
        public List<WebApp.Models.Invoice> AllInvoices { get; set; } = new List<WebApp.Models.Invoice>();

        public DeleteInvoiceModel(InvoiceRepository invoiceRepository)
        {
            _invoiceRepository = invoiceRepository;
        }

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            // List all invoices
            AllInvoices = await _invoiceRepository.GetAllInvoices();

            // If ID is provided, show confirmation page
            if (id.HasValue)
            {
                InvoiceToDelete = await _invoiceRepository.GetInvoiceById(id.Value);
                if (InvoiceToDelete == null)
                {
                    TempData["ErrorMessage"] = $"Invoice ID {id} not found.";
                    return RedirectToPage("/Invoice/DeleteInvoice");
                }
            }

            return Page();
        }

        public async Task<IActionResult> OnPostAsync(int invoiceId)
        {
            try
            {
                // Call C# Transaction-based delete method
                await _invoiceRepository.DeleteInvoiceAsync(invoiceId);

                TempData["SuccessMessage"] = $"Invoice ID {invoiceId} has been successfully deleted!";
                return RedirectToPage("/Invoice/DeleteInvoice");
            }
            catch (SqlException ex)
            {
                TempData["ErrorMessage"] = $"Database error: {ex.Message}";
                return RedirectToPage("/Invoice/DeleteInvoice");
            }
            catch (InvalidOperationException ex)
            {
                TempData["ErrorMessage"] = ex.Message;
                return RedirectToPage("/Invoice/DeleteInvoice");
            }
            catch (Exception ex)
            {
                TempData["ErrorMessage"] = $"An error occurred: {ex.Message}";
                return RedirectToPage("/Invoice/DeleteInvoice");
            }
        }
    }
}
