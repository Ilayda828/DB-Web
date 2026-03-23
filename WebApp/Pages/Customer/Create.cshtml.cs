using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using WebApp.Models;
using WebApp.Repositories;

namespace WebApp.Pages.Customer
{
    public class CreateModel : PageModel
    {
        private readonly CustomerRepository _customerRepository;

        [BindProperty]
        public WebApp.Models.Customer NewCustomer { get; set; } = new();

        public CreateModel(CustomerRepository customerRepository)
        {
            _customerRepository = customerRepository;
        }

        public void OnGet() { }

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid) return Page();

            // Modeli güncellediğimiz için AddCustomer artık Address ve Type parametrelerini de gönderecek
            await _customerRepository.AddCustomer(NewCustomer);

            return RedirectToPage("/Employee/Dashboard");
        }
    }
}