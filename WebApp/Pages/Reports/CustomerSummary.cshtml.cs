using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using WebApp.Models;
using WebApp.Repositories;

namespace WebApp.Pages.Reports
{
    public class CustomerSummaryModel : PageModel
    {
        private readonly CustomerRepository _customerRepository;
        public CustomerSummaryModel(CustomerRepository customerRepository) => _customerRepository = customerRepository;

        public List<CustomerInvoiceSummary> CustomerSummaries { get; set; } = new();

        [BindProperty(SupportsGet = true)]
        public string CurrentSort { get; set; }

        public async Task OnGetAsync(string sortOrder)
        {
            CurrentSort = sortOrder;
            await LoadData();
        }

        public async Task<PartialViewResult> OnGetTableOnlyAsync(string sortOrder)
        {
            CurrentSort = sortOrder;
            await LoadData();
            return Partial("_CustomerTablePartial", this);
        }

        public async Task<IActionResult> OnPostDeleteCustomerAsync(int id)
        {
            await _customerRepository.DeleteCustomer(id);
            TempData["SuccessMessage"] = "Customer and records deleted successfully.";
            return RedirectToPage();
        }

        public async Task<IActionResult> OnPostUpdateCustomerAsync(int oldId, int newId, string name, int totalInvoices, decimal totalSpent)
        {
            try
            {
                var existing = await _customerRepository.GetCustomerById(oldId);
                if (existing == null) return NotFound();
                existing.Name = name;
                bool result = await _customerRepository.UpdateCustomer(oldId, newId, existing, totalInvoices, totalSpent);
                if (result) TempData["SuccessMessage"] = "Customer information updated.";
            }
            catch (Exception ex) { TempData["ErrorMessage"] = ex.Message; }
            return RedirectToPage();
        }

        private async Task LoadData()
        {
            var data = await _customerRepository.GetCustomerInvoiceSummary();

            // Tüm artan/azalan kombinasyonlarý
            CustomerSummaries = CurrentSort switch
            {
                "id_asc" => data.OrderBy(x => x.CustomerID).ToList(),
                "id_desc" => data.OrderByDescending(x => x.CustomerID).ToList(),
                "name_asc" => data.OrderBy(x => x.CustomerName).ToList(),
                "name_desc" => data.OrderByDescending(x => x.CustomerName).ToList(),
                "inv_asc" => data.OrderBy(x => x.TotalInvoices).ToList(),
                "inv_desc" => data.OrderByDescending(x => x.TotalInvoices).ToList(),
                "spent_asc" => data.OrderBy(x => x.TotalSpent).ToList(),
                "spent_desc" => data.OrderByDescending(x => x.TotalSpent).ToList(),
                _ => data.OrderByDescending(x => x.TotalSpent).ToList() // Varsayýlan: En çok harcayan üstte
            };
        }
    }
}