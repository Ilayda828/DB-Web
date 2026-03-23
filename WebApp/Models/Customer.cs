// WebApp/Models/Customer.cs
using System;

namespace WebApp.Models
{
    public class Customer
    {
        public int CustomerID { get; set; }
        public string? Name { get; set; }
        public string? Email { get; set; }

        // Veritabanýnda PhoneNumber, ama kodda Phone olarak map'ledik.Tutarlýlýk ve yapý düzeni için bu þekilde aldým 
        public string? Phone { get; set; }

        public string? Address { get; set; }
        public string? CustomerType { get; set; }
        public DateTime RegistrationDate { get; set; }
    }
}