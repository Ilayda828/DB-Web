using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace WebApp.Pages.Invoice
{
    public class DetailsModel : PageModel
    {
        public int InvoiceId { get; set; }

        public IActionResult OnGet(int? id)
        {
            if (id == null || id <= 0)
            {
                return RedirectToPage("/Index");
            }

            InvoiceId = id.Value;
            return Page();
        }
    }
}
