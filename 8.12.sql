### 查询数据准备###
USE kettle_demo;
CREATE DATABASE  TEST8_12;
# 创建部门表
create table department(
    did int primary key auto_increment,
    dname varchar(20),
    description varchar(255)
) engine = InnoDB default charset utf8;

# 创建员工表
create table employee(
    eid int primary key auto_increment,
    eno varchar(20),
    ename varchar(20),
    eage int,
    egender varchar(10),
    esalary double,
    estation varchar(20),
    eworked_year int,
    eleader varchar(20),
    depart_id int,
    foreign key(depart_id) references department(did)
) engine = InnoDB default charset utf8;

# 添加数据
insert into department(dname,description) values ('研发部','致力于研发公司自研新产品');
insert into department(dname,description) values ('人事部','提升员工凝聚力, 招聘优秀人才');
insert into department(dname,description) values ('财务部','核算公司员工薪酬、奖金等财务相关工作');
insert into department(dname,description) values ('销售部','销售公司数据平台产品, 引导商家入驻公司平台');
insert into department(dname,description) values ('市场部','洞察公司产品市场,做好宣传工作');
insert into department(dname,description) values ('网络部','插网线');

insert into employee(eno, ename, eage, egender, esalary, estation, eworked_year, eleader, depart_id)
values
    ('U34210','东方薇薇',25,'女',13500,'后台开发工程师',2,'金隆泽',1);
insert into employee(eno, ename, eage, egender, esalary, estation, eworked_year, eleader, depart_id)
values
    ('U34211','西门子舟',28,'男',19620,'数据开发工程师',5,'金隆泽',1);
insert into employee(eno, ename, eage, egender, esalary, estation, eworked_year, eleader, depart_id)
values
    ('U34219','金隆泽',34,'男',27000,'数据分析师',6,'金隆泽',1);
insert into employee(eno, ename, eage, egender, esalary, estation, eworked_year, eleader, depart_id)
values
    ('U34234','付小春',22,'女',7500,'UI工程师',1,'金隆泽',1);
insert into employee(eno, ename, eage, egender, esalary, estation, eworked_year, eleader, depart_id)
values
    ('U34256','王展燕',24,'女',9000,'数据开发工程师',2,'金隆泽',1);
insert into employee(eno, ename, eage, egender, esalary, estation, eworked_year, eleader, depart_id)
values
    ('U34223','谢佰',29,'男',25500,'大数据开发工程师',3,'金隆泽',1);
insert into employee(eno, ename, eage, egender, esalary, estation, eworked_year, eleader, depart_id)
values
    ('U34303','周佳佳',19,'女',4800,'人事专员',1,'张小敏',2);
insert into employee(eno, ename, eage, egender, esalary, estation, eworked_year, eleader, depart_id)
values
    ('U34314','张小敏',28,'女',6000,'人事主管',4,'张小敏',2);
insert into employee(eno, ename, eage, egender, esalary, estation, eworked_year, eleader, depart_id)
values
    ('U34326','文宾',24,'男',5300,'行政专员',2,'张小敏',2);
insert into employee(eno, ename, eage, egender, esalary, estation, eworked_year, eleader, depart_id)
values
    ('U34412','马莲莲',27,'女',6500,'财务主管',4,'马莲莲',3);
insert into employee(eno, ename, eage, egender, esalary, estation, eworked_year, eleader, depart_id)
values
    ('U34409','谢莹莹',26,'女',6000,'财务专员',3,'马莲莲',3);
insert into employee(eno, ename, eage, egender, esalary, estation, eworked_year, eleader, depart_id)
values
    ('U34511','黄惠',21,'女',8000,'销售专员',2,'牛芳',4);
insert into employee(eno, ename, eage, egender, esalary, estation, eworked_year, eleader, depart_id)
values
    ('U34517','牛芳',25,'女',8500,'销售经理',5,'牛芳',4);
insert into employee(eno, ename, eage, egender, esalary, estation, eworked_year, eleader, depart_id)
values
    ('U34600','县香梅',27,'女',9000,'渠道经理',4,'县香梅',5);
insert into employee(eno, ename, eage, egender, esalary, estation, eworked_year, eleader, depart_id)
values
    ('U34604','王祥',23,'男',6000,'渠道专员',2,'县香梅',5);
insert into employee(eno, ename, eage, egender, esalary, estation, eworked_year, eleader, depart_id)
values
    ('U34604','王鸿翔',33,'男',60000,'渠道专员',2,null,null);
#1
SELECT ename,dname FROM employee JOIN department ON employee.depart_id = department.did;
#2
SELECT employee.*,department.* FROM employee JOIN department ON employee.depart_id = department.did;
#3
SELECT employee.*,department.* FROM department JOIN employee ON employee.depart_id = department.did;
# 4
SELECT ename,eleader FROM employee;
# 5
SELECT ename,eleader FROM employee;
# 6
SELECT * FROM employee WHERE esalary<5000 AND eworked_year>2;
# 7
SELECT employee.* FROM department JOIN employee ON employee.depart_id = department.did WHERE dname='销售部';
# 8
WITH AGE AS (SELECT eworked_year FROM employee WHERE ename='张小敏')
select * FROM employee,AGE WHERE employee.eworked_year<AGE.eworked_year;
#9
SELECT employee.* FROM department JOIN employee ON employee.depart_id = department.did WHERE dname IN('销售部','市场部');
# 10
WITH  S_1 AS (SELECT did FROM department WHERE dname='财务部'),
    S_S AS (SELECT MAX(esalary) ES FROM employee,S_1 WHERE S_1.did=depart_id )
select * from employee,S_S WHERE esalary>S_S.ES;
#11
WITH XY AS (SELECT estation,esalary FROM employee WHERE ename='谢莹莹')
SELECT * FROM employee,XY WHERE employee.estation=XY.esalary AND employee.esalary=XY.estation;