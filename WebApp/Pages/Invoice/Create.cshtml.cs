using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using WebApp.Models;
using WebApp.Repositories;
using Microsoft.Data.SqlClient;

namespace WebApp.Pages.Invoice
{
    public class CreateModel : PageModel
    {
        private readonly InvoiceRepository _invoiceRepository;

        [BindProperty]
        public InvoiceInputModel InvoiceInput { get; set; } = new InvoiceInputModel();

        public CreateModel(InvoiceRepository invoiceRepository)
        {
            _invoiceRepository = invoiceRepository;
        }

        public void OnGet() { }

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                return Page();
            }

            try
            {
                // SP_CREATE_INVOICE Saklý yordamýný çaðýrýr
                int newInvoiceId = await _invoiceRepository.CreateInvoice(InvoiceInput);

                // Ýþlem baþarýlýysa ana sayfaya veya listeye yönlendir
                TempData["SuccessMessage"] = $"Invoice #{newInvoiceId} created successfully!";
                return RedirectToPage("/Index");
            }
            catch (SqlException ex)
            {
                // SQL tarafýndaki THROW hata mesajlarýný yakalar (Örn: Customer not found)
                ModelState.AddModelError(string.Empty, $"Database error: {ex.Message}");
                return Page();
            }
            catch (Exception ex)
            {
                ModelState.AddModelError(string.Empty, $"An unexpected error occurred: {ex.Message}");
                return Page();
            }
        }
    }
}