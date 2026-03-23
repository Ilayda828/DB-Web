using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using WebApp.Models;
using WebApp.Repositories;
using Microsoft.Data.SqlClient;

namespace WebApp.Pages.Product
{
    public class UpdateStockModel : PageModel
    {
        private readonly ProductRepository _productRepository;

        [BindProperty]
        public int ProductID { get; set; }

        [BindProperty]
        public int StockValue { get; set; } // Kullanýcýnýn girdiði miktar

        [BindProperty]
        public string UpdateType { get; set; } = "set"; // "set" veya "add"

        public WebApp.Models.Product? CurrentProduct { get; set; }
        public List<WebApp.Models.Product> AllProducts { get; set; } = new List<WebApp.Models.Product>();
        public string CurrentSort { get; set; }

        public UpdateStockModel(ProductRepository productRepository)
        {
            _productRepository = productRepository;
        }

        public async Task OnGetAsync(string sortOrder)
        {
            await LoadData(sortOrder);
        }

        // AJAX: Sadece tabloyu döndüren handler
        public async Task<PartialViewResult> OnGetTableOnlyAsync(string sortOrder)
        {
            await LoadData(sortOrder);
            return Partial("_ProductTablePartial", this);
        }

        private async Task LoadData(string sortOrder)
        {
            var data = await _productRepository.GetAllProducts();
            CurrentSort = sortOrder;

            AllProducts = sortOrder switch
            {
                "id_asc" => data.OrderBy(p => p.ProductID).ToList(),
                "id_desc" => data.OrderByDescending(p => p.ProductID).ToList(),
                "name_asc" => data.OrderBy(p => p.Name).ToList(),
                "name_desc" => data.OrderByDescending(p => p.Name).ToList(),
                "price_asc" => data.OrderBy(p => p.Price).ToList(),
                "price_desc" => data.OrderByDescending(p => p.Price).ToList(),
                "stock_asc" => data.OrderBy(p => p.Stock).ToList(),
                "stock_desc" => data.OrderByDescending(p => p.Stock).ToList(),
                _ => data.OrderBy(p => p.ProductID).ToList()
            };
        }

        public async Task<IActionResult> OnPostAsync()
        {
            try
            {
                int finalStock = StockValue;

                if (UpdateType == "add")
                {
                    var product = await _productRepository.GetProductById(ProductID);
                    if (product != null)
                    {
                        finalStock = product.Stock + StockValue;
                    }
                }

                if (finalStock < 0) finalStock = 0;

                await _productRepository.UpdateProductStock(ProductID, finalStock);
                TempData["SuccessMessage"] = $"Stock for Product ID {ProductID} updated successfully!";

                return RedirectToPage("/Product/UpdateStock");
            }
            catch (Exception ex)
            {
                ModelState.AddModelError(string.Empty, $"Error: {ex.Message}");
                await LoadData(null);
                return Page();
            }
        }
    }
}