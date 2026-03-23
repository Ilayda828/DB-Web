using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using System.ComponentModel.DataAnnotations;
using WebApp.Models;
using WebApp.Repositories;

namespace WebApp.Pages.Customer
{
    public class RegisterModel : PageModel
    {
        private readonly CustomerRepository _customerRepository;

        public RegisterModel(CustomerRepository customerRepository)
        {
            _customerRepository = customerRepository;
        }

        [BindProperty]
        public CustomerRegistrationInput Input { get; set; } = new();

        public class CustomerRegistrationInput
        {
            [Required(ErrorMessage = "Ad Soyad alanı zorunludur.")]
            [StringLength(100, MinimumLength = 3, ErrorMessage = "İsim 3 ile 100 karakter arasında olmalıdır.")]
            public string Name { get; set; } = string.Empty;

            [Required(ErrorMessage = "E-posta adresi zorunludur.")]
            [EmailAddress(ErrorMessage = "Geçerli bir e-posta adresi giriniz.")]
            public string Email { get; set; } = string.Empty;

            [Required(ErrorMessage = "Telefon numarası zorunludur.")]
            [RegularExpression(@"^\d{10,11}$", ErrorMessage = "Telefon 10 veya 11 haneli rakam olmalıdır.")]
            public string PhoneNumber { get; set; } = string.Empty;

            [Required(ErrorMessage = "Adres alanı zorunludur.")]
            public string Address { get; set; } = string.Empty;

            [Required(ErrorMessage = "Lütfen müşteri tipini seçiniz.")]
            public string CustomerType { get; set; } = "Individual";
        }

        public void OnGet() { }

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid) return Page();

            var newCustomer = new Models.Customer
            {
                Name = Input.Name,
                Email = Input.Email,
                Phone = Input.PhoneNumber,
                Address = Input.Address,
                CustomerType = Input.CustomerType
            };

            try
            {
                await _customerRepository.AddCustomer(newCustomer);
                TempData["SuccessMessage"] = "Kayıt başarıyla tamamlandı! Giriş yapabilirsiniz.";
                return RedirectToPage("/Index");
            }
            catch (Exception ex)
            {
                ModelState.AddModelError(string.Empty, "E-posta zaten kullanımda veya bir hata oluştu.");
                return Page();
            }
        }
    }
}