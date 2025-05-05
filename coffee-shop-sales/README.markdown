# Coffee Shop Sales Dashboard

This project analyses sales data from a coffee shop chain to uncover performance trends and identify top-selling products. The process involves data cleaning, database setup, SQL analysis, and visualisation through an interactive dashboard on Metabase. The aim of this project was to replicate similar work I have done for clients with public data. The project showcases skills in data normalisation, efficient SQL imports, and actionable dashboard design.


## Objective
Analyse coffee shop sales to:
- Identify top-selling products by revenue and quantity.
- Evaluate product category performance and underperforming items.
- Assess sales variation by hour and day type (weekday vs. weekend).
- Understand customer behavior through average transaction values.

## Tools
- **Excel**: Data cleaning and preparation.
- **MySQL**: Database setup and SQL analysis.
- **Metabase**: Interactive dashboard creation.
- **Kaggle**: Source of the coffee sales dataset.

## Data
The dataset, sourced from [Kaggle](https://www.kaggle.com/datasets/ahmedabbas757/coffee-sales), includes 149,000 transactions with details on products, stores, and sales. I normalised it into four tables: `transactions`, `stores`, `products`, and `product_category` for more efficient relational database queries. The cleaned CSVs are in the `data/` folder.

## Process
1. **Data Acquisition**: Downloaded the dataset from Kaggle (`coffee_sales.csv`).
2. **Data Cleaning**:
   - Split the single table into normalised tables: `transactions`, `stores`, `products`, `product_category`.
   - Removed duplicates in Excel using **Remove Duplicates**.
   - Linked tables with `XLOOKUP` (e.g., added `product_category_id` to `products`).
   - Reassigned `store_id` to auto-incrementing IDs.
   - Combined `transaction_date` and `transaction_time` into `transaction_datetime` for MySQL compatibility.
   - Standardised column names (e.g., `store_location` to `store_name`).
   - Exported tables as CSVs.
3. **Database Setup** (`Coffee_shop_documentationv3.docx`):
   - Designed a MySQL schema for the `coffee_shop` database with `InnoDB` engine, primary keys, foreign key constraints, and appropriate data types (e.g., `unit_price` as `DECIMAL(10,2)` see `database_creation_full.sql`).
   - Imported CSVs using `LOAD DATA INFILE`, achieving a 4.12-second import for 149,000 rows (vs. 20+ minutes with MySQL Workbench GUI).
   - Validated data with queries (`data_validation.sql`).
4. **SQL Analysis**:
   - **Sales Performance** (`sales_performance_draft.sql`): Identified top products by revenue (e.g., Barista Espresso) and quantity (e.g., Brewed Chai tea), and analysed sales by hour and day (JOIN, GROUP BY, ORDER BY, WHERE, DAYNAME, HOUR, RANK() OVER) 
   - **Product Mix** (`revenue_share.sql`, `revenue_contribution.sql`): Calculated revenue share by category and flagged underperforming products (e.g., Clothing at 6.2k revenue) (e.g. JOIN, GROUP BY, ORDER BY, CTE)
   - **Customer Behavior** (`Customer_behaviour.sql`): Computed average transaction values by product category (e.g. WITH, ROUND, CTE)
   - **Seasonal Trends** (`seasonal_trends.sql`): Compared weekday vs. weekend sales, identifying unusually high/low periods (e.g. CASE, WITH, CTE, AVG, ROUND)
5. **Visualisation**: Built a Metabase dashboard (see `images/`) to display:
   - Total revenue (700,779.74) and revenue by store.
   - Top 5 products by revenue and quantity.
   - Top categories by revenue and quantity.
   - Revenue share by category.
   - Underperforming products.
   - Sales trends by hour of day.

## Folder Structure
```
coffee-shop-sales/
├── data/
│   ├── transactions.csv
│   ├── stores.csv
│   ├── products.csv
│   └── product_category.csv
├── images/
│   └── dashboard-image-1.png
│   └── dashboard-image-2.png
│   └── dashboard-image-3.png
├── scripts/
│   ├── database_creation_full.sql
|   |── data_validation.sql
│   ├── sales_performance_draft.sql
│   ├── revenue_contribution.sql
│   ├── revenue_share.sql
│   ├── Customer_behaviour.sql
│   └── seasonal_trends.sql
└── README.md
```

## Setup
1. **Dependencies**:
   - MySQL: Set up a local server and create the `coffee_shop` database.
   - Metabase for visualisations (docker hosted).
2. **Database**:
   - Create tables in MySQL following the schema in `Coffee_shop_documentationv3.docx`.
   - Import CSVs using `LOAD DATA INFILE` (see documentation for commands).
3. **Analysis**:
   - Run SQL scripts (`scripts/`) in MySQL to analyse data.
   - Import data into Metabase and recreate the dashboard using the layout in `images/coffee_shop_dashboard.png`.

## Results
- **Total Revenue**: 700,779.74, with Hell’s Kitchen (33%), Astoria (32%), and Lower Manhattan (30%) contributing evenly.
- **Top Products**: Barista Espresso (92,290 revenue), Brewed Chai tea (26.8k units sold).
- **Revenue Share**: Coffee (38.65%), Tea (28.03%), Bakery (11.76%) dominate; Coffee beans (5.85%) underperform.
- **Underperforming Products**: Clothing (6.2k revenue), House blend beans (3.3k), Black tea (2.7k).
- **Sales Trends**: Peak sales at 10 AM (85.9k revenue); weekdays generally outperform weekends.

## Insights
- Coffee and tea drive revenue, suggesting a focus on these categories for promotions.
- Underperforming products like Clothing and House blend beans may need reevaluation or marketing adjustments.
- Morning hours (8 AM–10 AM) are peak times, ideal for targeting high-traffic promotions.

## Recommendations
- Increase staffing during 8–10 AM to reduce customer wait times.
- Adjust inventory to prioritise top-selling products (Coffee and Tea), reducing waste from unsold items (e.g. Clothing and House blend beans).

## Future Work
- Analyse customer loyalty patterns if data becomes available.
- Explore seasonal trends (e.g., monthly sales) for deeper insights.
- Add interactive filters to the dashboard for real-time analysis by store or product.
- Explore heatmapping in Tableau or Python for better seasonal trend visualisation.