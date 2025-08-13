SELECT PNAME,pgender,pjob,post_salary FROM tb_person;
SELECT pname,AVG(pfirst_salary),AVG(post_salary) FROM tb_person;
SELECT COUNT(1) FROM tb_person;
SELECT * FROM tb_person WHERE province='广东省';
SELECT pname,pfirst_salary FROM tb_person WHERE pfirst_salary IN ('6000','7000','8000','9000');
SELECT tb_person.* FROM tb_person  WHERE post_salary-pfirst_salary>10000;
SELECT pname,pfirst_salary,post_salary FROM tb_person WHERE post_salary-pfirst_salary<0;
SELECT * FROM tb_person WHERE pname LIKE  '%伟%' OR '%梅%'OR '%香%'OR '%亮%'
SELECT MAX(post_salary),MIN(post_salary),AVG(post_salary),SUM(post_salary) FROM tb_person;
SELECT *FROM tb_person WHERE post_salary>(SELECT AVG(post_salary)FROM tb_person );
SELECT * FROM tb_person WHERE post_salary>20000;
SELECT * FROM tb_person WHERE post_salary BETWEEN 3000 AND 25000;
