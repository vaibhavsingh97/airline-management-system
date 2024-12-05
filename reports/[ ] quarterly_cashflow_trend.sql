/*================================================
‼️ THIS FILE SHOULD BE RUN BY DEVELOPER ONLY ‼️
================================================*/

SELECT 
    TO_CHAR(period_start, 'YYYY') AS year,
    TO_CHAR(period_start, 'Q') AS quarter,
    total_cashflow,
    LAG(total_cashflow) OVER (ORDER BY period_start) AS prev_quarter_cashflow,
    ROUND((total_cashflow - LAG(total_cashflow) OVER (ORDER BY period_start)) / NVL(LAG(total_cashflow) OVER (ORDER BY period_start), 0),2) * 100 AS quarter_over_quarter_growth_percent
FROM Incoming_Cashflow
WHERE time_period = 'Quarterly'
ORDER BY period_start;