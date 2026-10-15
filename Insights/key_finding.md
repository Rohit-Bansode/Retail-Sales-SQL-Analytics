
# Key Findings - Retail Sales Analytics

This document summarizes the important business insights obtained from the SQL analysis of the Superstore dataset.

---

## 1. Overall Business Performance

- Total Sales and Total Profit were calculated across all orders.
- The business shows positive overall profit, but margins vary significantly by category and region.

![Overall Sales & Profit](images/01_overall_performance.png)
  
---

## 2. Regional Performance

- **West** and **East** regions generally contribute the highest sales.
- Some regions generate good sales but have lower profit margins.
- Regional performance helps identify where marketing and inventory efforts should be focused.

![Sales by Region](images/02_sales_by_region.png)

---

## 3. Category & Sub-Category Insights

- **Technology** is one of the most profitable categories.
- **Furniture** generates high sales but has lower profit margins in some sub-categories.
- Certain sub-categories are loss-making and need attention (possible over-discounting).

![Sales by Category](images/03_sales_by_category.png)

![Best Sub-Category per Category](images/04_best_subcategory.png)

---

## 4. Customer Insights
- Top 10 customers contribute a significant portion of total sales.
- High-value customers are clearly identifiable using ranking and segmentation (NTILE).
- A group of customers have not placed any order recently and are at risk of churn.

![Top 10 Customers](images/05_top_customers.png)

![Customer Segmentation](images/06_customer_segments.png)

---

## 5. Customers at Risk of Churn

- Customers whose last order was before 2017 are considered inactive.
- These customers can be targeted with re-engagement campaigns (discounts, emails, offers).

![Churn Risk Customers](images/07_churn_customers.png)

---

## 6. Time-based Trends
- Sales show clear monthly and yearly patterns.
- Month-over-Month growth is inconsistent — some months show strong growth while others decline.
- Running total of sales and profit helps track business momentum.

![Monthly Sales Trend](images/08_monthly_sales.png)

![Month-over-Month Growth](images/09_mom_growth.png)

---

## 7. Key Recommendations

1. Focus marketing efforts on high-value customer segments.
2. Investigate loss-making products and review discount strategy.
3. Run re-engagement campaigns for customers at risk of churn.
4. Analyze high-performing regions and replicate successful strategies in weaker regions.
5. Monitor monthly growth more closely to reduce sales fluctuations.

---

## How These Insights Were Generated

All insights were derived using:
- JOINs
- CTEs
- Window Functions (ROW_NUMBER, RANK, LAG, NTILE, SUM OVER)
- Aggregations (SUM, AVG, COUNT)

