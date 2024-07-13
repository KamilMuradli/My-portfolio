--Analyzing Unicorn Companies
WITH top_industries AS
(
    SELECT i.industry, 
        COUNT(i.*)
    FROM industries AS i
    INNER JOIN dates AS d
        ON i.company_id = d.company_id
    WHERE EXTRACT(year FROM d.date_joined) in ('2019', '2020', '2021')
    GROUP BY industry
    ORDER BY count DESC
    LIMIT 3
),

yearly_rankings AS 
(
    SELECT COUNT(i.*) AS num_unicorns,
        i.industry,
        EXTRACT(year FROM d.date_joined) AS year,
        AVG(f.valuation) AS average_valuation
    FROM industries AS i
    INNER JOIN dates AS d
        ON i.company_id = d.company_id
    INNER JOIN funding AS f
        ON d.company_id = f.company_id
    GROUP BY industry, year
)

SELECT industry,
    year,
    num_unicorns,
    ROUND(AVG(average_valuation / 1000000000), 2) AS average_valuation_billions
FROM yearly_rankings
WHERE year in ('2019', '2020', '2021')
    AND industry in (SELECT industry
                    FROM top_industries)
GROUP BY industry, num_unicorns, year
ORDER BY year DESC, num_unicorns DESC;

--Analyzing motorcycle part sales
SELECT product_line,CASE WHEN EXTRACT(month FROM date)=6
THEN 'June'
WHEN EXTRACT(month FROM date)=7 THEN 'July'
WHEN EXTRACT(month FROM date)=8 THEN 'August'
END AS month,warehouse,
SUM(total)-SUM(payment_fee) AS net_revenue
FROM sales
WHERE client_type='Wholesale'
GROUP BY product_line,month,warehouse
ORDER BY product_line,month,net_revenue

--Analyzing student's mental health
select stay,count(*) as count_int,ROUND(AVG(todep),2) as average_phq,ROUND(AVG(tosc),2) as average_scs,ROUND(AVG(toas),2) AS average_as
from public.students
WHERE stay is not null
AND inter_dom='Inter'
group by stay
order by stay DESC;
