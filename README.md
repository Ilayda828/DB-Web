# 🛠️ Dene Technology Database Management System (DBMS)

A comprehensive, end-to-end Database Management System developed for **Dene Technology** as part of the **CSE3055 Database Systems** course at Marmara University. This project transforms manual industrial operations into a robust, digital, and secure database-driven web application.

---

## 👥 Project Team
* **İlayda İlhan** 
* **Canan Pazarbaşı**
* **Ömer Ercan Dayan**

---

## 📖 Project Overview & Scope
**Dene Technology** is an engineering firm focused on embedded systems and IT solutions. This project digitizes their production, quality control, and financial cycles.

### **Core Modules**
- **Production & Inventory:** Tracks products, the machines used in their manufacturing, and real-time stock levels.
- **Quality Assurance (QA):** Manages inspection results and automates machine status updates based on test results.
- **Financial Operations:** Handles dynamic tax calculations, automated invoicing, and payment tracking.
- **Stakeholder Management:** Integrated tracking for customers, suppliers, and corporate partners.

---

## 🏗️ Technical Architecture
The application is built with a focus on maintainability, security, and the separation of concerns.

- **Backend:** ASP.NET Core 8.0 (Razor Pages)
- **Database:** Microsoft SQL Server (T-SQL)
- **Pattern:** **Repository Design Pattern** used to decouple data access logic from the business layer.
- **Security:** **Role-Based Access Control (RBAC)** to segregate "Customer" and "Staff" privileges.
- **Dependency Injection:** Centralized service management for database contexts and repositories.

---

## 🗄️ Database Design (Physical Implementation)
The database schema consists of 9 core tables, meticulously designed in **3rd Normal Form (3NF)** to ensure data integrity and eliminate redundancy.

### **Advanced Database Features**
- **Stored Procedures (11 Total):** Optimized for complex operations like safe customer deletion, stock updates, and dashboard reporting.
- **Triggers:** Includes `TR_QC_FAIL_UPDATE_MACHINE` which automatically sets a machine's status to 'Under Maintenance' if a quality check fails.
- **Views (4 Total):** Provides high-performance read access for financial summaries and production logs.
- **Data Integrity:** Strict enforcement of `CHECK`, `UNIQUE`, and `FOREIGN KEY` constraints.

---

## 🚀 Installation & Setup

### **1. Database Configuration**
1. Open **SQL Server Management Studio (SSMS)**.
2. Create a new database named `DeneDB`.
3. Execute the SQL scripts located in the `/Database/Scripts` directory in the following order:
   - `Tables.sql`
   - `Views.sql`
   - `StoredProcedures.sql`
   - `Triggers.sql`

### **2. Application Settings**
Update the connection string in `appsettings.json` to match your local SQL Server instance:
```json
"ConnectionStrings": {
  "DefaultConnection": "Server=YOUR_SERVER_NAME;Database=DeneDB;Trusted_Connection=True;TrustServerCertificate=True;"
}

### **📂 Repository Structure**
├── Documentation/       # Academic reports and ER/EER Diagrams (Step 3 & 4)
├── Database/            # SQL Scripts for DDL, DML, and Automation
├── DeneDBMS.WebApp/     # ASP.NET Core Source Code
│   ├── Models/          # Data Entities
│   ├── Repositories/    # Data Access Layer (SQL logic)
│   ├── Pages/           # UI Components (Razor Pages)
│   └── wwwroot/         # Static assets (CSS, JS, Images)
└── README.md
