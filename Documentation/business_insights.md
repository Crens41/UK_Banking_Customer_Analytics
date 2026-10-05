# Business Insights

## Customer Retention & Value Analytics

### Executive Summary

The analysis examined 34,963 customers and 250,000 transaction records
covering activity from January 2023 to August 2026.

The main objective was to understand customer value, engagement and
potential retention risk.

The analysis identified a useful retention population: customers who
have generated at least £50,000 in cumulative transaction value but have
not transacted for 100 or more days.

## Key Insights

### 1. Customer activation

All 34,963 registered customers appear in the transaction dataset.

**Implication:** The dataset contains no meaningful never-activated
customer population. Retention analysis should therefore focus primarily
on customers who previously transacted but have become inactive.

### 2. Customer value

Established customers generated the highest overall transaction value
among the analysed customer segments.

Average transaction values were relatively close across segments,
suggesting that differences in total value are driven more strongly by
transaction activity and customer population than by a dramatic
difference in individual transaction size.

### 3. Retention risk

Using the project definition of 100+ days without a transaction,
approximately 68--70% of customers were classified as churn risk across
several segment and regional analyses.

This is a **rule-based risk classification, not confirmed churn**.

The high rate should be investigated against historical customer
behaviour before the threshold is used operationally.

### 4. Regional risk

Regional analysis showed relatively similar churn-risk percentages
across regions.

**Implication:** The available data does not support assuming that one
region is dramatically worse than another based solely on the current
churn definition.

Retention strategy should therefore consider customer-level
characteristics rather than relying only on geography.

### 5. Segment risk

Growing, Established and New customers also showed relatively similar
churn-risk percentages.

**Implication:** Customer segment alone is not sufficient to identify
retention risk in this dataset.

### 6. High-value customers at risk

The analysis identified **26 customers** who met both criteria:

-   Total spending of at least £50,000
-   100+ days since their latest transaction

These customers represent a potentially valuable retention population
because they combine significant historical value with prolonged
inactivity.

## Recommended Business Actions

### Prioritise high-value inactive customers

Create a retention queue for customers with high historical value and
prolonged inactivity.

### Validate the churn threshold

Compare the 50-day and 100-day rules against historical behaviour,
repeat-purchase patterns and eventual customer reactivation.

### Investigate engagement concentration

Analyse transaction frequency across customers to determine whether a
small group generates a disproportionate share of transaction activity
or value.

### Combine multiple risk signals

A future production model should consider additional variables such as
transaction frequency, recency, monetary value, tenure and product
behaviour rather than relying only on days inactive.

### Monitor retention by segment and region

Although regional and segment churn rates were relatively similar, they
should remain part of the dashboard so changes can be monitored over
time.

## Data & Model Limitations

-   The dataset is synthetic/project-based and should not be treated as
    production banking data.
-   The churn-risk definition is rule-based.
-   A 100-day inactivity threshold has not been statistically validated
    against actual churn outcomes.
-   The dataset contains a broad transaction period from 2023 to 2026.
-   Customer activation cannot be analysed meaningfully because every
    registered customer appears in the transaction dataset.
-   Further modelling would be required to estimate actual churn
    probability.

## Management Takeaway

The strongest immediate retention opportunity identified by this
analysis is the group of high-value customers showing prolonged
inactivity.

The next analytical step should be to combine this SQL model with a
Power BI dashboard and, eventually, historical outcome data to validate
whether inactivity thresholds reliably predict customer churn.
