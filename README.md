# 🏭 Supply Chain Analytics & Performance Optimization

![Python](https://img.shields.io/badge/Python-3.10-blue)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue)
![PowerBI](https://img.shields.io/badge/PowerBI-Dashboard-yellow)
![Excel](https://img.shields.io/badge/Excel-Reporting-green)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

## 📌 Project Overview
An end-to-end supply chain analytics solution built on 180,519 records 
across 5 global markets (2015–2018). This project covers the full 
analytics pipeline from raw data ingestion to executive dashboard.

---

## 🧠 Business Problem
A retail supply chain company wants to:
- Reduce shipping delays affecting 57.3% of all orders
- Improve operational efficiency across global markets
- Analyze profitability across products and regions
- Optimize shipping mode strategy

---

## 🛠️ Tech Stack
| Tool | Purpose |
|---|---|
| Python (Pandas, NumPy) | ETL Pipeline & EDA |
| PostgreSQL | Data Warehouse & SQL Analysis |
| Excel | Business Reporting & Pivot Tables |
| Power BI | Executive Dashboard |
| GitHub | Portfolio Presentation |

---

## 🔄 ETL Pipeline
- Loaded 180,519 raw supply chain records
- Cleaned nulls, duplicates and standardized text fields
- Converted date columns to datetime format
- Engineered 9 new features:
  - `delivery_delay_days`
  - `delay_flag`
  - `delay_category`
  - `profit_margin`
  - `shipping_efficiency`
  - `order_year`, `order_month`, `order_quarter`
- Created star schema with 1 fact + 4 dimension tables
- Exported cleaned CSVs and loaded into PostgreSQL

---

## 🗄️ Data Model (Star Schema)
- fact_orders (180,519 rows)
- ├── dim_products (118 rows)
- ├── dim_customers (20,652 rows)
- ├── dim_shipping (65,752 rows)
- └── dim_geography (3,772 rows)
---

## 📊 SQL Analysis
- 6 KPI queries (Total Sales, Profit, Orders, Delay)
- Operational analysis (Delay by Region, Shipping Mode)
- Profitability analysis (Category, Market, Department)
- Advanced SQL using:
  - CTEs
  - Window Functions (RANK, DENSE_RANK)
  - CASE Statements
  - Subqueries

---

## 📈 Power BI Dashboard

### Page 1 — Executive Overview
<img width="1152" height="652" alt="Screenshot 2026-06-11 172633" src="https://github.com/user-attachments/assets/c0fd3bf7-76e7-4308-bb01-bd3a178978a1" />

### Page 2 — Delivery Performance
<img width="1164" height="635" alt="Screenshot 2026-06-11 172658" src="https://github.com/user-attachments/assets/b7659ad7-a92e-40eb-b22f-ea5ca99b283d" />

### Page 3 — Product & Profitability
<img width="1156" height="655" alt="Screenshot 2026-06-11 172726" src="https://github.com/user-attachments/assets/2923ff9d-7379-4deb-aa5a-c62fca9f618b" />

### Page 4 — Geographic Insights
<img width="1157" height="657" alt="Screenshot 2026-06-11 172743" src="https://github.com/user-attachments/assets/d25a2d2c-2559-4cdf-a539-e32640eda8ce" />

### Page 5 — Recommendations
<img width="1158" height="674" alt="Screenshot 2026-06-11 093127" src="https://github.com/user-attachments/assets/c68bb734-d575-452a-a9d6-b3a531587cae" />


---

## 🔍 Key Insights
- **57.3%** of all orders are delayed
- **Second Class** shipping has highest avg delay of **1.99 days**
- **First Class** shipping has **100% late delivery rate**
- **Standard Class** is most reliable with **0.00 avg delay**
- **Fishing** category generates highest profit — **$756K**
- **Europe** is most profitable market — **$1.17M profit**
- **Fan Shop** department dominates with **$1.83M profit**
- **Consumer** segment contributes **51.91%** of total sales

---

## 💡 Business Recommendations
1. Replace First Class shipping with Standard Class for time-sensitive orders
2. Investigate logistics infrastructure in Central Asia (highest delay region)
3. Increase inventory for Fishing & Cleats categories (highest profit)
4. Audit PAYMENT_REVIEW status orders causing operational delays
5. Review pricing strategy for 3 loss-making products

---

## 📂 Dataset
- **Source:** DataCo Smart Supply Chain Dataset
- **Link:** [Kaggle Dataset](https://www.kaggle.com/datasets/shashwatwork/dataco-smart-supply-chain-for-big-data-analysis)
- **Size:** 180,519 rows × 53 columns

---

## 👤 Author
**Tazeem Sajid**

