using Microsoft.Data.SqlClient;
using WebApp.Repositories;

var builder = WebApplication.CreateBuilder(args);

// 1. Session ve Memory Cache Kaydý
builder.Services.AddDistributedMemoryCache();
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(30);
    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true;
});

builder.Services.AddRazorPages();

var connectionString = builder.Configuration.GetConnectionString("DeneTechnologyDB");

// 2. Repository Tanýmlamalarý
builder.Services.AddScoped<InvoiceRepository>(provider =>
    new InvoiceRepository(connectionString ?? throw new InvalidOperationException("Connection string not found")));

builder.Services.AddScoped<CustomerRepository>(provider =>
    new CustomerRepository(connectionString ?? throw new InvalidOperationException("Connection string not found")));

builder.Services.AddScoped<ProductRepository>(provider =>
    new ProductRepository(connectionString ?? throw new InvalidOperationException("Connection string not found")));

var app = builder.Build();

if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

// 3. Session Kullanýmý (Routing'den sonra, Authorization'dan önce olmalý)
app.UseSession();

app.UseAuthorization();
app.MapStaticAssets();
app.MapRazorPages().WithStaticAssets();

app.Run();