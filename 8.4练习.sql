DROP DATABASE IF EXISTS library_db;
CREATE DATABASE IF NOT EXISTS library_db CHARACTER SET UTF8;
use library_db;
create TABLE books(
  book_id int primary key AUTO_INCREMENT,
  title varchar (50) NOT NULL,
  author varchar (50) NOT NULL,
  publisher varchar(50),
  price decimal(10,2),
  publish_date date DEFAULT '2020-01-01',
  status varchar(10) default '可惜'
);
CREATE TABLE readers(
  reader_id int PRIMARY KEY,
  name      varchar(20) NOT NULL,
  gender    varchar(5)  NOT NULL DEFAULT '男',
  phone     varchar(20) UNIQUE,
  join_date  date        NOT NULL
);
ALTER TABLE books CHANGE status book_status varchar(20);
ALTER TABLE readers DROP join_date;
drop table library_readers;
RENAME TABLE readers to library_readers;
insert into books (book_id, title, author,  price, publish_date, book_status) VALUE (1, '三体', '刘慈欣', 45.90, '2008-01-01', '可借')
,(2, '活着', '余华', 30.50, '1993-01-01', '可借')
,(3, '红楼梦', '曹雪芹', 88.00, '1791-01-01', '借出')
,(4, '百年孤独', '马尔克斯', 55.00, '1967-01-01', '可借');
insert into library_readers (reader_id, name, gender, phone, join_date) VALUE(101, '张三','男','13811112222','2023-01-01')
,(102, '李四','女','13900001111','2023-02-01')
,(103, '王五', '男', '13722223333',
'2023-03-01');
UPDATE books SET price=35.00 where title='活着';
UPDATE library_readers SET name='王小五'WHERE phone='13722223333';
delete from books where title='百年孤独';
DELETE FROM library_readers WHERE reader_id=103;
TRUNCATE TABLE books;
DELETE FROM library_readers;