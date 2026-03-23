using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using WebApp.Models;
using WebApp.Repositories;

namespace WebApp.Pages.Customer
{
    public class PersonalInfoModel : PageModel
    {
        private readonly CustomerRepository _customerRepository;
        public PersonalInfoModel(CustomerRepository customerRepository) => _customerRepository = customerRepository;

        public WebApp.Models.Customer? CurrentCustomer { get; set; }

        public async Task<IActionResult> OnGetAsync()
        {
            // Session'dan ID'yi oku
            var sessionUserId = HttpContext.Session.GetInt32("UserId");

            // Eðer hala ID yoksa (Veritabaný boþsa veya session silindiyse) Dashboard'a at
            // Dashboard oradan tekrar denesin veya kullanýcýya göstersin
            if (!sessionUserId.HasValue)
            {
                return RedirectToPage("/Customer/Dashboard");
            }

            // Veriyi çek
            CurrentCustomer = await _customerRepository.GetCustomerById(sessionUserId.Value);

            // ID var ama Müþteri silinmiþse güvenli çýkýþ yapýp ana sayfaya at
            if (CurrentCustomer == null)
            {
                HttpContext.Session.Clear();
                return RedirectToPage("/Index");
            }

            return Page();
        }
    }
}