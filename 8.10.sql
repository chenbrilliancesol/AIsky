SELECT FORMAT(RAND()*1000,3)+
       FORMAT(RAND()*1000,3);
select date_format(now(),'%Y应该是年%m好像是月%d是日 %H:%i:%s') 时间;
SELECT CURRENT_DATE();
SELECT  YEAR(NOW());
SELECT DATE_ADD(NOW(),INTERVAL 1 DAY );
SELECT TIMESTAMP (NOW(),'10:10:10');
SELECT IF(1=1,NOW(),NULL);
CREATE DATABASE TEST_8_9;
USE TEST_8_9;
Create table If Not Exists Logins (user_id int, time_stamp datetime);
Truncate table Logins;
insert into Logins (user_id, time_stamp) values ('6', '2020-06-30 15:06:07');
insert into Logins (user_id, time_stamp) values ('6', '2021-04-21 14:06:06');
insert into Logins (user_id, time_stamp) values ('6', '2019-03-07 00:18:15');
insert into Logins (user_id, time_stamp) values ('8', '2020-02-01 05:10:53');
insert into Logins (user_id, time_stamp) values ('8', '2020-12-30 00:46:50');
insert into Logins (user_id, time_stamp) values ('2', '2020-01-16 02:49:50');
insert into Logins (user_id, time_stamp) values ('2', '2019-08-25 07:59:08');
insert into Logins (user_id, time_stamp) values ('14', '2019-07-14 09:00:00');
insert into Logins (user_id, time_stamp) values ('14', '2021-01-06 11:59:59');
-- select * from logins where time_stamp > '2020-01-01' and time_stamp < '2020-12-31';


SELECT ROW_NUMBER(time_stamp) OVER (PARTITION BY user_id ORDER BY time_stamp)FROM Logins;

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department_id INT,
    hire_date DATE,
    salary DECIMAL(10,2)
);

-- 创建部门表
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- 创建销售表
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    employee_id INT,
    sale_date DATE,
    amount DECIMAL(10,2),
    region VARCHAR(50)
);

-- 插入部门数据
INSERT INTO departments VALUES
(1, '销售部'),
(2, '技术部'),
(3, '人力资源部'),
(4, '财务部');

-- 插入员工数据
INSERT INTO employees VALUES
(101, 'zhang', 'wei', 1, '2020-05-15', 8500.18),
(102, 'wang', 'fang', 1, '2019-11-20', 9200.55),
(103, 'li', 'na', 2, '2021-03-10', 10500.66),
(104, 'zhao', 'ming', 2, '2018-07-22', 12500.30),
(105, 'liu', 'qiang', 3, '2022-01-05', 7800.45),
(106, 'chen', 'jing', 4, '2020-09-30', 9500.92),
(107, 'yang', 'guang', 1, '2021-12-15', 8800.14),
(108, 'zhou', 'hong', 2, '2019-06-18', 11000.45),
(109, 'wu', 'gang', 3, '2022-02-28', 8000.05),
(110, 'huang', 'li', 4, '2021-08-10', 10200.57);

-- 插入销售数据
INSERT INTO sales VALUES
(1001, 101, '2023-01-15', 15000.00, '华东'),
(1002, 102, '2023-01-20', 22000.00, '华北'),
(1003, 101, '2023-02-05', 18000.00, '华东'),
(1004, 102, '2023-02-10', 12000.00, '华南'),
(1005, 102, '2023-03-15', 25000.00, '华北'),
(1006, 101, '2023-03-20', 19000.00, '华东'),
(1007, 102, '2023-04-05', 13000.00, '华南'),
(1008, 101, '2023-04-10', 23000.00, '华北'),
(1009, 102, '2023-05-15', 14000.00, '华南'),
(1010, 101, '2023-05-20', 20000.00, '华东');

SELECT UPPER(first_name),LOWER(last_name) FROM employees;

SELECT hire_date FROM employees;

# 2?
SELECT first_name,last_name,date_format(DATEDIFF(CURRENT_DATE(),hire_date),'%Y年%m月')FROM employees;
SELECT YEAR(NOW());
SELECT MONTH(NOW());
SELECT first_name,
    last_name,
    DATEDIFF(current_date(),hire_date) as h_n,
    FLOOR((DATEDIFF(current_date(),hire_date))/365) YEAR,
       FLOOR(((DATEDIFF(current_date(),hire_date))%365)/30) MOENT,
    concat(FLOOR((DATEDIFF(current_date(),hire_date))/365),'年',FLOOR(((DATEDIFF(current_date(),hire_date))%365)/30),'月') 差值
FROM employees;
SELECT
    first_name,
    last_name,
    CONCAT(
        TIMESTAMPDIFF(YEAR, hire_date, '2025-08-10'), '年',
        TIMESTAMPDIFF(MONTH, hire_date, '2025-08-10') % 12, '个月'
    ) AS work_experience
FROM employees;
# 查资料得出的结果


SELECT round(salary),CEIL(salary),FLOOR(salary)FROM employees;

SELECT first_name,last_name,salary ,department_id,RANK() OVER(PARTITION BY department_id ORDER BY salary DESC )FROM employees;


#5？

SELECT
        DISTINCT
        department_id,
        sum(salary)OVER (PARTITION BY department_id),
        AVG(salary) OVER (PARTITION BY department_id),
        (sum(salary)OVER (PARTITION BY department_id) - AVG(salary) OVER (PARTITION BY department_id) )as '差值'
FROM   employees AS e;

#6？
WITH DM AS (SELECT department_id FROM departments WHERE department_name='销售部')
WITH SL AS(SELECT AVG(amount)FROM sales GROUP BY sale_id )
SELECT first_name ,last_name,

FROM employees;

-- 先汇总每人每月销售额
WITH monthly_sales AS (
    SELECT
        employee_id,
        DATE_FORMAT(sale_date, '%Y-%m') AS sale_month,
        SUM(amount) AS monthly_amount
    FROM sales
    GROUP BY sales.employee_id, DATE_FORMAT(sale_date, '%Y-%m')
)
SELECT
distinct
    monthly_sales.employee_id,
    first_name,
    last_name,
    sale_month,
    monthly_amount,
    AVG(monthly_amount) OVER (
        PARTITION BY monthly_sales.employee_id
        ORDER BY sale_month
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS moving_avg_3months
FROM monthly_sales join employees on employees.employee_id=monthly_sales.employee_id;
# 查的
WITH T1 AS (SELECT SUM(amount)OVER(PARTITION BY region)  FROM sales)
SELECT region, SUM(amount),T1  FROM sales;

SELECT
    region,
    SUM(amount) ,
    ROUND(SUM(amount) * 100.0 / SUM(SUM(amount)) OVER (), 2)
FROM sales
GROUP BY region;
# ?为什么不能引用窗口让它分组？
with  sale_amont AS (
SELECT employee_id,SUM(amount) as SALE
FROM sales GROUP BY employee_id)

SELECT DISTINCT
       first_name,
       last_name,
        SALE,
       RANK()OVER (PARTITION BY sale_amont.SALE)
        FROM sale_amont LEFT JOIN employees ON employees.employee_id=sale_amont.employee_id
;
WITH emp_sales AS (
  SELECT employee_id,
         SUM(amount) AS total_sales
  FROM   sales
  GROUP  BY employee_id
)
SELECT es.employee_id,
       e.department_id,
       es.total_sales,
       RANK() OVER (ORDER BY es.total_sales DESC)          AS company_rank,
       RANK() OVER (PARTITION BY e.department_id
                    ORDER BY es.total_sales DESC)          AS dept_rank
FROM   emp_sales es
JOIN   employees e ON e.employee_id = es.employee_id
ORDER  BY es.total_sales DESC;
# 查的
WITH T1 AS (
SELECT ROUND(AVG(salary)) AS A_S
FROM employees GROUP BY department_id)
SELECT first_name,last_name ,salary,A_S FROM employees,T1 WHERE salary>A_S;

