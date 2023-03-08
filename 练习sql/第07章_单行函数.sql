#第07章_单行函数

#1.数值函数
#基本的操作
SELECT ABS(-123), ABS(32), SIGN(-23), PI(), CEIL(32.32), CEILING(-43.23), FLOOR(32.32),
	FLOOR(-43.23), MOD(12, 5)
FROM DUAL;

#取随机数
SELECT RAND(), RAND(), RAND(10), RAND(10), RAND(-1), RAND(-1)
FROM DUAL;

#四舍五入，截断操作
SELECT ROUND(123.556), ROUND(123.456, 0), ROUND(123.456, 1), ROUND(123.456, 2),
	ROUND(123.456, -1), ROUND(153.456, -2)
FROM DUAL;

SELECT TRUNCATE(123.456, 0), TRUNCATE(123.496, 1), TRUNCATE(129.45, -1)
FROM DUAL;

#单行函数可以嵌套
SELECT TRUNCATE(ROUND(123.456, 2), 0)
FROM DUAL;

#开方
SELECT SQRT(16), SQRT(12), SQRT(12.34)
FROM DUAL;

#角度与弧度的互换
SELECT RADIANS(30), RADIANS(45), RADIANS(60), RADIANS(90),
	DEGREES(2 * PI()), DEGREES(RADIANS(60))
FROM DUAL;

#三角函数
SELECT SIN(RADIANS(30)), DEGREES(ASIN(1)), TAN(RADIANS(45)), DEGREES(ATAN(1))
FROM DUAL;

#指数与对数
SELECT POW(2, 5), POW(2, 4), EXP(2)
FROM DUAL;

SELECT LN(EXP(2)), LOG(EXP(2)), LOG10(10), LOG2(4)
FROM DUAL;

#进制间的转换
SELECT BIN(10), HEX(10), OCT(10), CONV(10, 10, 8)
FROM DUAL;


#2.字符串函数

SELECT ASCII('abc'), CHAR_LENGTH('hello'), CHAR_LENGTH('我们'),
	LENGTH('hello'), LENGTH('我们')
FROM DUAL;

# xxx worked for yyy
SELECT CONCAT(emp.last_name, ' worked for ', mgr.last_name) "details"
FROM employees emp
JOIN employees mgr
ON emp.manager_id = mgr.employee_id;

SELECT CONCAT_WS('-', 'hello', 'world', 'hello', 'beijing')
FROM DUAL;
#字符串的索引是从1开始的!
SELECT INSERT('helloword', 2, 3, 'aaaaa'), REPLACE('hello', 'lol', 'mmm')
FROM DUAL;

SELECT UPPER('hello'), LOWER('HelLo')
FROM DUAL;

SELECT last_name, salary
FROM employees
WHERE LOWER(last_name) = 'King';

SELECT LEFT('hello', 2), RIGHT('hello', 3), RIGHT('hello', 13)
FROM DUAL;

# LPAD：实现右对齐效果
# RPAD：实现左对齐效果
SELECT employee_id, last_name, LPAD(salary, 10, ' ')
FROM employees;

SELECT TRIM('        h  el   lo    '), LTRIM('        h  el   lo    '),
	TRIM('o' FROM 'ooheollo'), TRIM(LEADING 'o' FROM 'ooheollo'), TRIM(TRAILING 'o' FROM 'ooheollo')
FROM DUAL;

SELECT REPEAT('hello', 4), LENGTH(SPACE(5)), STRCMP('abc', 'abd')
FROM DUAL;

SELECT SUBSTR('hello', 2, 2), LOCATE('ll', 'hello')
FROM DUAL;

SELECT ELT(2, 'a', 'b', 'c', 'd'), FIELD('mm', 'gg', 'jj', 'mm', 'dd', 'mm'),
	FIND_IN_SET('mm', 'gg,mmm,jj,dd,mm,gg')
FROM DUAL;

SELECT employee_id, NULLIF(LENGTH(first_name), LENGTH(last_name)) "compare"
FROM employees;

#3.日期和时间函数

#3.1 获取日期和时间
SELECT CURDATE(), CURRENT_DATE(), CURTIME(), CURRENT_TIME(), NOW(), SYSDATE(),
	UTC_DATE(), UTC_TIME()
FROM DUAL;

SELECT CURDATE(), CURDATE() + 0, CURTIME() + 0, NOW() + 0
FROM DUAL;

#3.2 日期与时间戳的转换
SELECT UNIX_TIMESTAMP(), UNIX_TIMESTAMP("2022-03-20 22:12:32"),
	FROM_UNIXTIME(1647786707), FROM_UNIXTIME(1647785552)
FROM DUAL;

#3.3 获取月份、星期、星期数、天数等函数
SELECT YEAR(CURDATE()), MONTH(CURDATE()), DAY(CURDATE()),
	HOUR(CURTIME()), MINUTE(NOW()), SECOND(SYSDATE())
FROM DUAL;

SELECT MONTHNAME('2022-03-21'), DAYNAME('2022-03-21'), WEEKDAY('2022-03-21'),
	QUARTER(CURDATE()), WEEK(CURDATE(), DAYOFYEAR(NOW())),
	DAYOFMONTH(NOW()), DAYOFWEEK(NOW())
FROM DUAL;

#3.4 日期的操作函数
SELECT EXTRACT(SECOND FROM NOW()), EXTRACT(DAY FROM NOW()),
	EXTRACT(HOUR_MINUTE FROM NOW()), EXTRACT(QUARTER FROM NOW()), EXTRACT(QUARTER FROM '2022-05-21')
FROM DUAL;

#3.5 时间和秒钟转换的函数
SELECT TIME_TO_SEC(CURTIME()), SEC_TO_TIME(82696)
FROM DUAL;

#3.6 计算日期和时间的函数

SELECT NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR),
	DATE_ADD(NOW(), INTERVAL -1 YEAR), DATE_SUB(NOW(), INTERVAL 1 YEAR)
FROM DUAL;

SELECT DATE_ADD(NOW(), INTERVAL 1 DAY) AS col1, DATE_ADD('2022-03-21 12:09:12', INTERVAL 1 SECOND) AS col2,
	ADDDATE('2022-03-21 12:09:12', INTERVAL 1 SECOND) AS col3,
	DATE_ADD('2022-03-21 12:09:12', INTERVAL '1_1' MINUTE_SECOND) AS col4,
	DATE_ADD(NOW(), INTERVAL -1 YEAR) AS col5, #可以是负数
	DATE_ADD(NOW(), INTERVAL '1_1' YEAR_MONTH) AS col6 #需要单引号
FROM DUAL;

SELECT ADDTIME(NOW(), 20), SUBTIME(NOW(), 30), SUBTIME(NOW(), '1:1:3'), DATEDIFF(NOW(), '2021-10-01'),
	TIMEDIFF(NOW(), '2022-03-25 12:17:10'), FROM_DAYS(366), TO_DAYS('0000-12-25'),
	LAST_DAY(NOW()), MAKEDATE(YEAR(NOW()), 12), MAKETIME(10, 21, 23), PERIOD_ADD(20200101010101, 10)
FROM DUAL;

#3.7 日期的格式化与解析
# 格式化：日期 ---> 字符串
# 解析：字符串 ---> 日期

#此时我们谈的是日期的显式格式化和解析

#之前，我们接触过隐式的格式化解析
SELECT *
FROM employees
WHERE hire_date = '1993-01-13';

#格式化：
SELECT DATE_FORMAT(CURDATE(), '%Y-%M-%D'), DATE_FORMAT(NOW(), '%Y-%m-%d'),
	TIME_FORMAT(CURTIME(), '%h:%i:%S'),
	DATE_FORMAT(NOW(), '%Y-%M-%D %h:%i:%S %W %w %T %r')
FROM DUAL;

#解析：格式化的逆过程
SELECT STR_TO_DATE('2022-March-21st 12:42:34 Monday 1 12:42:34 12:42:34 PM', '%Y-%M-%D %h:%i:%S %W %w %T %r')
FROM DUAL;

SELECT GET_FORMAT(DATE, 'USA')
FROM DUAL;

SELECT DATE_FORMAT(CURDATE(), GET_FORMAT(DATE, 'USA'))
FROM DUAL;


#4.流程控制函数
#4.1 IF(VALUE, VALUE1, VALUE2)

SELECT last_name, salary, IF(salary >= 6000, '高工资', '低工资') "details"
FROM employees;

SELECT last_name, commission_pct, IF(commission_pct IS NOT NULL, commission_pct, 0) "details",
	salary * 12 * (1 + IF(commission_pct IS NOT NULL, commission_pct, 0)) "annual_sal"
FROM employees;

#4.2 IFNULL(VALUE1, VALUE2)：看作是IF(VALUE, VALUE1, VALUE2)的特殊情况
SELECT last_name, commission_pct, IFNULL(commission_pct, 0) "details"
FROM employees;

#4.3 CASE WHEN ... THEN ... WHEN ... THEN ... ELSE ... END
# 类似于java的if ... else if ... else if ...
SELECT last_name, salary,
CASE WHEN salary >= 15000 THEN '白骨精'
		 WHEN salary >= 10000 THEN '潜力股'
		 WHEN salary >= 8000 THEN '小屌丝'
		 ELSE '草根'
		 END "details"
FROM  employees;

#4.4 CASE ... WHEN  ... THEN ... WHEN ... THEN ... ELSE ... END
#类似于java的switch ... case ...
/*
#练习1
查询部门号为10, 20, 30的员工信息，若部门号为10，则打印其工资的1.1倍，20号部门，则打印其工资的1.2倍，
30号部门，打印其工资的1.3倍数，其他部门，打印其工资的1.4倍
*/
SELECT employee_id, last_name, department_id, salary,
CASE department_id WHEN 10 THEN salary * 1.1
									 WHEN 20 THEN salary * 1.2
									 WHEN 30 THEN salary * 1.3
									 ELSE salary * 1.4
									 END "details"
FROM employees;

/*
#练习2
查询部门号为10, 20, 30的员工信息，若部门号为10，则打印其工资的1.1倍，20号部门，则打印其工资的1.2倍，
30号部门打印其工资的1.3倍数。
*/
SELECT employee_id, last_name, department_id, salary,
CASE department_id WHEN 10 THEN salary * 1.1
									 WHEN 20 THEN salary * 1.2
									 WHEN 30 THEN salary * 1.3
									 END "details"
FROM employees
WHERE department_id IN (10, 20, 30);


#5. 加密与解密的函数
#MySQL8.0的PASSWORD()被弃用
SELECT PASSWORD('mysql')
FROM DUAL;

SELECT MD5('mysql'), SHA('mysql'), MD5(MD5('mysql'))
FROM DUAL;

#ENCODE() \ DECODE() 在MySQL8.0中弃用
SELECT ENCODE('atguigu', 'mysql'), DECODE(ENCODE('atguigu', 'mysql'), 'mysql')
FROM DUAL;

# 6.MySQL信息函数
SELECT VERSION(), CONNECTION_ID(), DATABASE(), SCHEMA(), USER(), CURRENT_USER(),
SYSTEM_USER(), SESSION_USER(), CHARSET('尚硅谷'), COLLATION('尚硅谷')
FROM DUAL;

#7. 其他函数
#如果n的值小于或等于0，则只保留整数部分
SELECT FORMAT(123.125, 2), FORMAT(123.125, 0), FORMAT(123.125, -3)
FROM DUAL;

SELECT CONV(16, 10, 2), CONV(8888, 10, 16), CONV(NULL, 10, 2)
FROM DUAL;
#以'192.168.1.100'为例，计算方式为192乘以156的3次方，加上168乘以256的2次方，加上1乘以256，再加上100
SELECT INET_ATON('192.168.1.100'), INET_NTOA(3232235876);
FROM DUAL;

#BENCHMARK()用于测试表达式的执行效率
SELECT BENCHMARK(100000, MD5('mysq'))
FROM DUAL;

#CONVERT()：可以实现字符集的转换
SELECT CHARSET('atguigu'), CHARSET(CONVERT('atguigu' USING 'gbk'))
FROM DUAL;