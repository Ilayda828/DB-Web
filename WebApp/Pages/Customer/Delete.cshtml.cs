using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using WebApp.Models;
using WebApp.Repositories;

namespace WebApp.Pages.Customer
{
    public class DeleteModel : PageModel
    {
        private readonly CustomerRepository _customerRepository;

        public DeleteModel(CustomerRepository customerRepository)
        {
            _customerRepository = customerRepository;
        }

        // Sayfada listelenecek tüm müþteriler
        public List<WebApp.Models.Customer> AllCustomers { get; set; } = new();

        // Silinmek üzere seçilen müþteri bilgisi
        public WebApp.Models.Customer? CustomerToDelete { get; set; }

        // Sayfa ilk yüklendiðinde çalýþýr
        public async Task OnGetAsync(int? customerId)
        {
            // Tüm müþteri listesini doldur (Tablo için)
            AllCustomers = await _customerRepository.GetAllCustomers();

            // Eðer bir ID parametresi gelmiþse (Sil butonuna týklandýysa), o müþteriyi bul
            if (customerId.HasValue)
            {
                CustomerToDelete = await _customerRepository.GetCustomerById(customerId.Value);

                if (CustomerToDelete == null)
                {
                    TempData["ErrorMessage"] = "Customer not found.";
                }
            }
        }

        // Silme formu (Post) gönderildiðinde çalýþýr
        public async Task<IActionResult> OnPostAsync(int customerId)
        {
            try
            {
                // Repository üzerinden SP_DELETE_CUSTOMER prosedürünü çaðýrýr
                await _customerRepository.DeleteCustomer(customerId);

                TempData["SuccessMessage"] = $"Customer (ID: {customerId}) and all related invoices/payments have been deleted successfully.";
            }
            catch (System.Exception ex)
            {
                // Veritabanýndan fýrlatýlan THROW mesajlarýný veya diðer hatalarý yakalar
                TempData["ErrorMessage"] = $"An error occurred during deletion: {ex.Message}";
            }

            // Ýþlem bittikten sonra sayfayý temiz haliyle yeniden yükle
            return RedirectToPage();
        }
    }
}