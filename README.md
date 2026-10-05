Customer Retention & Value Analytics

SQL Server | Power BI | Financial Services

About the Project

I built this project to explore customer behaviour, transaction activity and retention risk within a financial services dataset.

The dataset contains 34,963 customers and 250,000 transactions covering January 2023 to August 2026.

I used SQL Server to validate the data, analyse customer behaviour and build the main customer-level metrics. I then used Power BI to turn the analysis into a two-page interactive dashboard.

What I Wanted to Find Out:

The main questions I focused on were:

• Who are the most valuable customers?
• Which customers are becoming inactive?
• How does customer behaviour differ across regions and customer segments?
• Are any high-value customers showing signs of disengagement?
• Where should retention efforts be focused?

Dataset

Customers: 34,963
Transactions: 250,000
Earliest transaction: 1 January 2023
Latest transaction: 31 August 2026

Before starting the analysis, I checked the dataset for duplicate customer records, customer uniqueness, transaction coverage and date consistency.

Customer Value Analysis

I created customer-level metrics including total transactions, total spending, average transaction value, customer ranking and customer value category.

Customers were grouped into three categories:

VIP: £90,000 and above
High Value: £50,000 to £89,999.99
Standard: Below £50,000

I also used SQL window functions such as RANK(), DENSE_RANK() and ROW_NUMBER() during the analysis.

Retention Analysis

To analyse customer inactivity, I calculated the number of days since each customer’s most recent transaction.

Customers were then grouped as:

Active: 0–49 days inactive
Need Attention: 50–99 days inactive
Churn Risk: 100+ days inactive

These categories are analytical definitions used for this project and should not be treated as confirmed customer churn.

Key Findings

A few findings stood out during the analysis:

• All 34,963 customers had at least one transaction in the dataset.
• Around 68–70% of customers fell into the churn-risk category using the 100-day inactivity threshold.
• Established customers generated the highest overall transaction value.
• I identified 26 high-value customers who had spent at least £50,000 but had also been inactive for more than 100 days.

The last group was particularly important because they represent customers with strong historical value who may now require retention attention.

Power BI Dashboard

I turned the SQL analysis into a two-page Power BI report.

Page 1 – Executive Overview

This page gives a high-level view of customer KPIs, transaction performance, customer value, regional performance and transaction trends.

Page 2 – Customer Analysis

This page focuses more closely on customer activity, retention risk, customer segments, regional behaviour and high-value customers at risk.

Interactive Dashboard

View the Power BI Dashboard:
(https://app.powerbi.com/groups/me/reports/85bb3650-3fc0-4dd1-9e00-74e0bd91556b?ctid=49a4baf9-983a-440f-8cd1-e4765b528b8e&pbi_source=linkShare)

Recommendations

Based on the analysis, I would recommend:

Prioritising high-value customers who have been inactive for long periods.
Validating the 100-day churn threshold against historical customer behaviour.
Using different retention approaches across customer segments and regions.
Combining customer value, transaction frequency and inactivity when deciding which customers to target.

Tools and Skills Used

SQL Server:
- JOINs 
- CTEs
- Aggregations
- CASE statements
- window functions
- Data validation
- Customer segmentation and retention analysis.

Power BI:
- Power Query
- Data modelling
- DAX, KPI development
- Interactive dashboards
- Slicers, filters
- Geographic analysis and Power BI Service.

Project Structure

Customer-Retention-Value-Analytics

README
SQL
Dashboard
Documentation
Images

Author
Daniel Henshaw Japhet
Data & BI Analyst portfolio project focused on customer analytics, SQL and Power BI.