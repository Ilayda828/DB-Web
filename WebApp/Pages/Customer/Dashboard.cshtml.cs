using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using WebApp.Repositories;

namespace WebApp.Pages.Customer
{
    public class DashboardModel : PageModel
    {
        private readonly CustomerRepository _customerRepository;
        public DashboardModel(CustomerRepository customerRepository) => _customerRepository = customerRepository;

        public string CustomerName { get; set; } = "";

        public async Task OnGetAsync(int? id)
        {
            // 1. URL'den ID gelirse Session'ý GÜNCELLE (Login iþlemi)
            if (id.HasValue)
            {
                HttpContext.Session.SetInt32("UserId", id.Value);
            }

            // 2. Session'daki ID'yi oku
            var sessionUserId = HttpContext.Session.GetInt32("UserId");

            // 3. Eðer Session doluysa kullanýcý ismini çek
            if (sessionUserId.HasValue)
            {
                var customer = await _customerRepository.GetCustomerById(sessionUserId.Value);
                if (customer != null)
                {
                    CustomerName = customer.Name;
                }
            }
            // NOT: Else durumunda artýk otomatik atama YAPMIYORUZ.
            // Böylece X kiþisi girmek istediðinde sistem zorla 1. kiþiyi atamýyor.
        }

        public IActionResult OnGetLogout()
        {
            HttpContext.Session.Clear();
            return RedirectToPage("/Index");
        }
    }
}