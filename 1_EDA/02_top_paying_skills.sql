/*
QUESTION: What are the highest paying skills for data engineers?
- Calculate the median salary for each skill required in data engineer positions.
- Focus on remote positions with specified salaries
- Include skill frequency identify both salary and demand
- Why?
    - Helps identify which skills command the highest compensation while also showing 
    how common those skills are, providing a more complete picture 
    for skill development priorities
    - The median is used instead of the average to reduce the impact of outlier salaries.
*/

SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg), 0) AS median_salary, 
    COUNT(jpf.*) AS demand_count
FROM 
    job_postings_fact AS jpf
INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND
    jpf.job_work_from_home = TRUE
GROUP BY
    sd.skills
HAVING
    demand_count > 100
ORDER BY
    median_salary DESC
LIMIT 25;


/*
Rust pays the most at $210k, about $26k above anyone else, but with only 232 postings it is a niche premium rather than a broad opportunity.

Terraform has the best mix of pay and demand. It offers $184k across 3,248 postings, the same salary as Golang with more than three times the demand.

Airflow and Kubernetes dominate demand (about 10,000 and 4,200 postings), yet pay only around $150k. Their high demand likely means a larger pool of qualified candidates, which holds salaries down.

Infrastructure and backend skills (Terraform, Golang, Spring, GraphQL) generally pay more than frontend or scripting ones (CSS, Ruby, Node, Jupyter).

GDPR at $170k suggests compliance expertise is rewarded like an engineering specialty.

Skills with under about 250 postings, such as Zoom, Crystal and Rust, have noisier medians, so treat their figures as directional.

┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ rust       │      210000.0 │          232 │
│ golang     │      184000.0 │          912 │
│ terraform  │      184000.0 │         3248 │
│ spring     │      175500.0 │          364 │
│ neo4j      │      170000.0 │          277 │
│ gdpr       │      169616.0 │          582 │
│ zoom       │      168438.0 │          127 │
│ graphql    │      167500.0 │          445 │
│ mongo      │      162250.0 │          265 │
│ fastapi    │      157500.0 │          204 │
│ bitbucket  │      155000.0 │          478 │
│ django     │      155000.0 │          265 │
│ crystal    │      154224.0 │          129 │
│ c          │      151500.0 │          444 │
│ atlassian  │      151500.0 │          249 │
│ typescript │      151000.0 │          388 │
│ kubernetes │      150500.0 │         4202 │
│ node       │      150000.0 │          179 │
│ ruby       │      150000.0 │          736 │
│ css        │      150000.0 │          262 │
│ airflow    │      150000.0 │         9996 │
│ redis      │      149000.0 │          605 │
│ vmware     │      148798.0 │          136 │
│ ansible    │      148798.0 │          475 │
│ jupyter    │      147500.0 │          400 │
└────────────┴───────────────┴──────────────┘

*/