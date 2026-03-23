using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using WebApp.Repositories;

namespace WebApp.Pages
{
    public class IndexModel : PageModel
    {
        private readonly CustomerRepository _customerRepo;

        public IndexModel(CustomerRepository customerRepo)
        {
            _customerRepo = customerRepo;
        }

        public void OnGet() { }

        public async Task<IActionResult> OnPostLoginAsync(string userName, string password, string userType)
        {
            if (string.IsNullOrEmpty(userName) || string.IsNullOrEmpty(password))
            {
                TempData["ErrorMessage"] = "Username and Password are required.";
                return Page();
            }

            if (userType == "customer")
            {
                // 1. ADIM: Sadece var mý diye bakmak yerine (Any), o kiþiyi BULUP GETÝRÝYORUZ (FirstOrDefault)
                var customers = await _customerRepo.GetAllCustomers();

                // Ýsim eþleþmesi (Büyük/küçük harf duyarsýz)
                var foundCustomer = customers.FirstOrDefault(c => c.Name?.Trim().ToLower() == userName.Trim().ToLower());

                // 2. ADIM: Kiþi bulunduysa VE þifresi '123' ise
                if (foundCustomer != null && password == "123")
                {
                    // 3. ADIM (Eksik Olan Kýsým): Bulunan kiþinin ID'sini hafýzaya (Session) yazýyoruz.
                    // Artýk Dashboard sayfasý bu 'UserId' deðerini okuyup ismi ve bilgileri gösterebilecek.
                    HttpContext.Session.SetInt32("UserId", foundCustomer.CustomerID);

                    return RedirectToPage("/Customer/Dashboard");
                }
            }
            else if (userType == "employee")
            {
                // Employee kontrolleri (Mevcut haliyle býrakýldý)
                if ((userName.ToLower() == "admin" && password == "admin") ||
                    (userName.ToLower() == "employee" && password == "employee"))
                {
                    // Ýsterseniz çalýþan için de session ekleyebilirsiniz ama þu an customer odaklýyýz
                    // HttpContext.Session.SetString("UserRole", "Employee");
                    return RedirectToPage("/Employee/Dashboard");
                }
            }

            TempData["ErrorMessage"] = "Access denied. Invalid username or password.";
            return Page();
        }
    }
}