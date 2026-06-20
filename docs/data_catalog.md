# Reference Guide for the Gold Layer

## Summary
The Gold Layer represents data at the business level, organized to power reporting and analytics needs. It contains **dimension tables** and **fact tables** built around particular business measures.

---

### 1. **gold.dim_customers**
- **What it's for:** Holds customer profiles enriched with demographic and geographic details.
- **Fields:**

| Field Name       | Type          | Notes                                                                                          |
|------------------|---------------|--------------------------------------------------------------------------------------------------|
| customer_key     | INT           | An internally generated key that uniquely tags each row in the customer dimension table.        |
| customer_id      | INT           | A distinct numeric ID given to every customer.                                                  |
| customer_number  | NVARCHAR(50)  | A letter-and-number code used to identify and track a given customer.                           |
| first_name       | NVARCHAR(50)  | The given name of the customer, as stored in the system.                                        |
| last_name        | NVARCHAR(50)  | The customer's surname or family name.                                                          |
| country          | NVARCHAR(50)  | The nation where the customer resides (for example, 'Australia').                               |
| marital_status   | NVARCHAR(50)  | Whether the customer is married, single, etc. (e.g., 'Married', 'Single').                       |
| gender           | NVARCHAR(50)  | The customer's gender (e.g., 'Male', 'Female', 'n/a').                                          |
| birthdate        | DATE          | Customer's birth date, in YYYY-MM-DD format (e.g., 1971-10-06).                                 |
| create_date      | DATE          | Timestamp marking when the customer entry was first added to the system.                        |

---

### 2. **gold.dim_products**
- **What it's for:** Holds details about products and their characteristics.
- **Fields:**

| Field Name           | Type          | Notes                                                                                           |
|----------------------|---------------|---------------------------------------------------------------------------------------------------|
| product_key          | INT           | An internally generated key that uniquely tags each row in the product dimension table.          |
| product_id           | INT           | A unique ID used internally to track and reference the product.                                  |
| product_number       | NVARCHAR(50)  | A formatted alphanumeric code, often applied for inventory or categorization purposes.            |
| product_name         | NVARCHAR(50)  | The product's display name, capturing details like type, color, and size.                        |
| category_id          | NVARCHAR(50)  | A distinct ID tying the product to its top-level category.                                       |
| category             | NVARCHAR(50)  | The high-level grouping the product falls under (e.g., Bikes, Components).                        |
| subcategory          | NVARCHAR(50)  | A finer-grained classification within the category, indicating the specific product type.         |
| maintenance_required | NVARCHAR(50)  | Flags whether the product needs upkeep (e.g., 'Yes', 'No').                                       |
| cost                 | INT           | The product's base price or cost, expressed in currency units.                                    |
| product_line         | NVARCHAR(50)  | The series or line the product is part of (e.g., Road, Mountain).                                 |
| start_date           | DATE          | The date the product first became available for purchase or use.                                  |

---

### 3. **gold.fact_sales**
- **What it's for:** Captures transaction-level sales data for analysis.
- **Fields:**

| Field Name      | Type          | Notes                                                                                           |
|-----------------|---------------|----------------------------------------------------------------------------------------------------|
| order_number    | NVARCHAR(50)  | A one-of-a-kind alphanumeric code assigned to each sales order (e.g., 'SO54496').                  |
| product_key     | INT           | Foreign key connecting the order line to the product dimension table.                             |
| customer_key    | INT           | Foreign key connecting the order line to the customer dimension table.                            |
| order_date      | DATE          | The date on which the order was made.                                                              |
| shipping_date   | DATE          | The date the order was dispatched to the customer.                                                |
| due_date        | DATE          | The date by which payment for the order was expected.                                              |
| sales_amount    | INT           | The full monetary amount of the line item's sale, in whole currency units (e.g., 25).             |
| quantity        | INT           | How many units of the product were ordered on this line (e.g., 1).                                |
| price           | INT           | The per-unit price charged for the product on this line (e.g., 25).                               |