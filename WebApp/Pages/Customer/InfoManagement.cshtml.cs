using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using WebApp.Models;
using WebApp.Repositories;

namespace WebApp.Pages.Customer
{
    public class InfoManagementModel : PageModel
    {
        private readonly CustomerRepository _customerRepository;
        public InfoManagementModel(CustomerRepository customerRepository) => _customerRepository = customerRepository;

        [BindProperty]
        public WebApp.Models.Customer CurrentCustomer { get; set; } = new();

        public async Task<IActionResult> OnGetAsync()
        {
            var sessionUserId = HttpContext.Session.GetInt32("UserId");
            if (!sessionUserId.HasValue) return RedirectToPage("/Customer/Dashboard");

            var data = await _customerRepository.GetCustomerById(sessionUserId.Value);
            if (data == null)
            {
                HttpContext.Session.Clear();
                return RedirectToPage("/Index");
            }

            CurrentCustomer = data;
            return Page();
        }

        public async Task<IActionResult> OnPostUpdateAsync()
        {
            // Session kontrolü
            var sessionUserId = HttpContext.Session.GetInt32("UserId");
            if (!sessionUserId.HasValue) return RedirectToPage("/Customer/Dashboard");

            // Finansal verileri KORUMAK için önce eski veriyi çekiyoruz
            var existingData = await _customerRepository.GetCustomerInvoiceSummary(); // Özet veriyi çek (Invoices, Spent)
            var userSummary = existingData.FirstOrDefault(x => x.CustomerID == sessionUserId.Value);

            int currentInvoices = userSummary?.TotalInvoices ?? 0;
            decimal currentSpent = userSummary?.TotalSpent ?? 0;

            // Güncelleme iþlemi (Kiþisel bilgiler formdan, Finansal bilgiler veritabanýndan)
            await _customerRepository.UpdateCustomer(
                CurrentCustomer.CustomerID,
                CurrentCustomer.CustomerID, // ID deðiþimi yapmýyoruz
                CurrentCustomer,
                currentInvoices, // Eski fatura sayýsýný koru
                currentSpent     // Eski harcama tutarýný koru
            );

            TempData["SuccessMessage"] = "Information updated successfully!";
            return RedirectToPage("/Customer/Dashboard");
        }

        public async Task<IActionResult> OnPostDeleteAsync(int id)
        {
            await _customerRepository.DeleteCustomer(id);
            HttpContext.Session.Clear(); // Oturumu kapat
            return RedirectToPage("/Index");
        }
    }
}