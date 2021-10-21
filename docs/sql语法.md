## 目录

- [1 SQL语法规范](#1 SQL语法规范)

- [2 库相关操作](#2 库相关操作)

- [3 表相关操作](#3 表相关操作)

- [4 查询](#4 查询)
- [5 函数](#5 函数)

- [6 运算符](#6 运算符)



# 1 SQL语法规范

- sql语句以“;”或“/g”结尾，建议用分号

- sql语句不区分大小写。通常关键字使用大写，库、表、列名使用小写

- 转义符号：\，自定义指定的转义符，比如自定义为$： ESCAPE '$';

- sql索引是从1开始，并非从0开始

  
  
## 1.1  引号

  - 若库、表、列名与关键字重复，可用反引号（着重号）``包住，用于区分；若不重复，可省略反引号
  
  - 在标准 SQL中，字符串使用的是单引号包裹
  
  - 大部分数据库都支持单引号和双引号的互换，但双引号不是标准不建议你使用，比如在Oracle中不支持双引号




##  1.2 注释

	- 单行注释
	
	  ```sql
	  #单行注释
	  -- 单行注释，空格不能丢
	  ```
	
	- 多行注释
	
	  ```sql
	  /*
	  多行注释
	  多行注释
	  多行注释
	  */
	  ```



# 2 库相关操作

- 创建数据库

    ```sql
    CREATE DATABASE dbName;-- 创建数据库，如果已存在则报错
    CREATE DATABASE IF NOT EXISTS dbName;-- 创建数据库，如果已存在则不创建
    ```
    
- 选中数据库，改变当前数据库

    ```sql
    USE dbName;
    ```
    
- 删除数据库

    ```sql
    DROP DATABASE dbName;
    ```

- 显示所有数据库

    ```sql
    SHOW DATABASES;
    ```

- 显示当前库

    ```sql
    SELECT DATABASE();
    ```



# 3 表相关操作


> 注意：若要操作表，必须先进入选中库


- 显示某个库的所有表

    ```sql
    SHOW TABLES; -- 默认当前库
    SHOW TABLES FROM dbName; -- 若未进入任何库，不得省略from后面的
    ```

- 创建表

    ```sql
    CREATE TABLE tableName(
        字段名 字段类型,
        字段名 字段类型,
        ...
    );
    ```

- 删除表

    
  
- 查看表结构

    ```sql
    DESC tableName;
    DESCRIBE tableName;
    ```



# 4 查询

## 4.1 简单查询

    查询使用SELECT关键字。从表中查询数据，结果被存储在一个结果表中（称为结果集），结果表是一个虚拟的表格。
    
    SELECT只会查询，不会影响原表
    
    SELECT后面可以是字段名、常量值、表达式、函数
    
    ```sql
    SELECT fieldName FROM tableName; -- 查询单个字段
    SELECT fieldName1, fieldName2... FROM tableName; -- 查询多个字段
    SELECT * FROM tableName; -- 查询所有字段，效率低，不建议使用
    
    SELECT 100; -- 常量值
    SELECT 'Tom'; -- 常量值
    SELECT 100*99; -- 表达式
    SELECT VERSION(); -- 函数
    
    SELECT fieldName AS alias; -- 给字段起别名
    SELECT fieldName alias; -- 省略AS，不建议
    
    SELECT fieldName FROM tableName AS alias;-- 给表起别名
    SELECT fieldName FROM tableName alias;-- 省略AS，不建议
    
    #SELECT TOP 10 * FROM tableName -- 返回前10个
    ```

## 4.2 去重查询

```sql
SELECT DISTINCT fieldName FROM tableName;-- 去除重复的值
```

## 4.3 条件查询

```sql
SELECT fieldName FROM tableName WHERE conditions;
```

conditions由一个或多个condition组成，condition之间使用or或and连接，一个condition由字段、运算符、值组成。

**condition：**

```sql
fieldName = 1000
fieldName >= 1000
fieldName IS NULL
```

**conditions：**

```sql
(fieldName > 1000 or fieldName < 2000) and fieldName != 1024
```

**配合条件查询的操作符：**

- `=`  等于，后面不能接null

- `<=>`  安全等于，与=的区别：后面可以接普通类型的值和null

- `<> `或 `!=` 不等于

- `<` 小于

- `<=` 小于等于

- `>` 大于

- `>=` 大于等于

- `not` 非

- `and` 且

- `or` 或

- `between a and b` 在两者之间，[a,b]之间，等同于`<= ... && ... >=`配合使用

- `not between a and b`	不在两者之间

  ```sql
  fieldName BETWEEN 9500 AND 10000;
  fieldName NOT BETWEEN 9500 AND 10000;
  ```

- `is null/is not null`  为空 / 不为空	`注意：sql中null不能使用=或!=来运算，需要使用is或is not，并且其他类型的数值不能使用is来判断`

- `in` 在多个值之中，是这些值之一即可满足条件	`注意：in不能使用通配符，且括号内部的数据类型需一致或兼容`

  ```sql
  fieldName IN (10000,11000,12000); -- fieldName是10000或11000或12000
  ```

- `not in` 不在多个值中，不是这些值之一

  ```sql
  fieldName NOT IN (10000,11000,12000);
  ```

- `like` 模糊查询，一般和通配符配合使用

- %：通配符，代表任意数量个字符，包括0个

- _：通配符，代表任意一个字符

  ```sql
  fieldName LIKE pattern;
  如：fieldName LIKE '_a%';
  ```

  

**注意：**

1. 数据库中的null不能使用=进行衡量，只能使用is或is not，因为数据库中的null代表什么也没有，而不是一个值的类型

2. and的优先级大于or，若要or先执行，需要加小括号()

3. WHERE 关键字无法与分组函数一起使用。



## 4.4 数据排序

**关键字：**ORDER BY字句

对查询结构进行排序输出，ORDER BY字句一般放在查询语句的最后面

```sql
 SELECT fieldName FROM tableName ORDER BY orderField ASC/DESC;
```

orderField：可以是字段名称，表达式、别名、列的序数（不建议），以此来指定排序项

ASC/DESC：升序\降序，默认是升序，ASC可省略

**按多个字段排序：**

```sql
 SELECT fieldName FROM tableName ORDER BY orderField1 ASC/DESC, orderField2 ASC/DESC;
```

先按orderField1排序，orderField1相同，再按orderField2排序。

条件查询与排序组合使用时，这时条件查询先写，排序后写，顺序不能反，否则报错。

执行顺序是：执行条件查询，对查询结果排序（排序总是在最后做的）

```sql
 SELECT fieldName FROM tableName WHERE ... ORDER BY ...
```

**注意：**

MySQL中，ORDER BY子句支持别名

ORDER BY总是最后执行，所以总是对最终的数据源进行排序



## 4.5 分组查询

**关键字：**GROUP BY

根据一个或多个列对结果集进行分组，**需要与分组函数配合使用**。放在条件子句后面，排序子句前面。

**执行顺序：**执行条件查询，执行分组，每组数据执行分组函数，对查询结果排序

```sql
 SELECT 分组函数(...) FROM tableName WHERE ... GROUP BY fieldName ORDER BY ...
 SELECT 分组函数(...) FROM tableName WHERE ... GROUP BY fieldName HAVING CONDITIONS ORDER BY ...
 SELECT 分组函数(...) as alias FROM tableName WHERE ... GROUP BY alias HAVING alias... ORDER BY ...
 SELECT 分组函数(...) FROM tableName WHERE ... GROUP BY fieldName1,fieldName2 -- 多个字段分组
```

**注意：**

1. HAVING子句与WHERE类似，WHERE用于筛选分组之前的数据，HAVING用于筛选分组之后的数据，筛选的数据源不同

2. MySQL中，GROUP BY子句和HAVING子句支持别名

3. 支持单个、多个字段分组（所有字段都一样才能归纳在一个组里）



## 4.6 连接查询（又称多表查询、多表连接）

从一张表中单独查询，称为**单表查询**。从多个表中查询字段，这种跨表查询，多张表联合起来查询数据，被称为连接查询。

如果a、b两张表进行连接查询没有任何条件限制，则a表的每一条数据会匹配b表的所有数据，若a、b表各有m、n条数据，最终会查询出m×n条数据。这种现象在数学中叫做**笛卡尔积现象**。

连接查询时加上限制条件（CONDITION），可以避免笛卡尔积现象。

```SQL
#SQL92语法（不推荐）
SELECT a.field1, b.field2 FROM 表1 AS a, 表2 AS b WHERE 连接条件

#SQL99语法（推荐）
SELECT a.field1, b.field2 FROM 表1 AS a JOIN 表2 AS b ON 连接条件
```

**注意：**

- 在多表查询中，给表起别名可以起到书写简洁的目的，**但注意，一旦给表取了别名，就不能再用表的原名限定本句中的其他地方的字段**
- 在多表查询中，最好给查询字段前加上表名或别名（a.field1, b.field2），避免造成歧义报错，并提高查询效率
- 加上限制条件之后，表的匹配次数并没有减少，而是把不符合限制条件的数据去除了，但是减少了表的连接次数
- n表连接查询，需要n-1个限制条件
- SQL92语法的限制条件占用了WHERE子句，与条件筛选糅杂一起，使得结构不清晰，所以更推荐SQL99语法

**根据连接方式分类，连接查询可分为：**

```
- 内连接
  - 等值连接
  - 非等值连接
  - 自连接
- 外连接
  - 左外连接
  - 右外连接
  - 全外连接
- 交叉连接
```

### 4.6.1 内连接

内连接是指所有查询出的结果都是能够在连接的表中有对应记录的。

**关键字：**（inner join），“inner”可以省略。

**内连接查询结果 = 主表和从表都有的记录**

#### 4.6.1.1 等值连接

**概念：**在连接条件中使用等于号（=）运算符，其查询结果中列出被连接表中的所有列，包括其中的重复列。

**示例：**

```sql
SELECT CONCAT(a.first_name, '.', a.last_name) AS 'name', b.department_name  
FROM `employees` AS a JOIN `departments` AS b
ON a.department_id = b.department_id;
```

#### 4.6.1.2 非等值连接

**概念：**在连接条件中使用除等于号之外运算符（>、<、<>、>=、<=、!>和!<等）

**示例：**

```sql
SELECT CONCAT(first_name, '.', last_name) '姓名', `salary` '工资',  `grade_level` '工资等级' 
FROM `employees` e, `job_grades` j
WHERE `salary` BETWEEN `lowest_sal` AND `highest_sal`
ORDER BY `salary`
```

#### 4.6.1.3 自连接

**示例：**

```sql
SELECT e.`first_name` '员工', m.`first_name` '领导', 
FROM `employees` e, `employees` m
WHERE e.`manager_id` = m.`employee_id`
```

### 4.6.2 外连接

用于查询一个表中有，另一个表中没有的记录。

#### 4.6.2.1 左外连接

**关键字：** LEFT JOIN

**左（右）连接查询结果 = 主表和从表都有的记录 + 主表有但从表没有的记录**

**特点：**

1. 外连接查询的结果为主表中的所有记录
2. 如果从表中有和它匹配的，则显示匹配的值
3. 如果从表中没有和它匹配的，则显示null（所有从表字段都为null，一般使用主键=null来判定是否非匹配记录）

示例：

```sql
# departments为主表，employees为从表
SELECT d.`department_id`, d.`department_name`, e.`first_name` 
FROM `departments` AS d
LEFT JOIN `employees` AS e
ON e.`department_id` = d.`department_id`
```

#### 4.6.2.2 右外连接

效果和左外连接一样，只是主从表位置不同

**关键字：** RIGHT JOIN

**示例：**

```sql
SELECT d.`department_id`, d.`department_name`, e.`first_name` 
FROM `employees` AS e
RIGHT JOIN `departments` AS d
ON e.`department_id` = d.`department_id`
```

####  4.6.2.3 全外连接

**概念：**返回左表和右表中的所有行。当某行在另一表中没有匹配行，则另一表中的列返回空值。

**关键字：** FULL JOIN

**全外连接查询结果 = 主表和从表都有的记录 + 主表有但从表没有的记录+ 从表有但主表没有的记录**

**注意：**

- MySql不支持全外连接



### 4.6.3 交叉连接

关键字 CROSS JOIN

概念：不带WHERE条件子句，它将会返回被连接的两个表的笛卡尔积，返回结果的 行数等于两个表行数的乘积

### 4.7 子查询

**分类：**

- 按子查询出现的位置：
  - select后面：仅仅支持标量子查询
  - where或having后面：✩
    - 标量子查询✩
    - 列子查询✩
    - 行子查询
  - exists后面（相关子查询）
    - 表子查询
- 按结果集的行列数不同：
  - 标量子查询（结果集只有一行一列）
  - 列子查询（结果集只有一列多行）
  - 行子查询（结果集只有一行多列）
  - 表子查询（结果集一般为多行多列）


# 5 函数

## 5.1 单行函数

将一组逻辑语句封装在方法体中，对外暴露方法名

SQL单行函数根据数据类型分为字符函数、数学函数、日期函数、流程控制函数，以及其他函数。



### 5.1.2 字符函数：

- `UPPER()`  将查询的字符串小写转换为大写 

- `LOWER()`  将查询的字符串大写转换为小写

- `INITCAP()`  将查询的字符串首字母大写

- `CONCAT(field1, field2...)` 字符串连接函数，参数可以是字段或常量，如：

  ```sql
  SELECT CONCAT(`first_name`, '.',`last_name`, '-', `salary`) AS 'name' FROM `employees`;
  ```

- `SUBSTR/SUBSTRING(string, start, count)` 字符串截取函数，start是截取起始索引，count是截取个数

- `INSTR(string, subString)`     寻找子字符串的第一次出现的索引，找不到返回0

- `LENGTH()` 获取字符串字节数函数，utf8中汉字3个字节，字母一个字节

- `LPAD(string, length, pattern)`  左填充函数，length是填充完的总长度，pattern是用来填充的字符串，如果length大于string长度，string将从左边开始截取，其余丢弃

- `RPAD(string, length, pattern)`  右填充函数，length是填充完的总长度，pattern是用来填充的字符串 ，如果length大于string长度，string将从y左边开始截取，其余丢弃

- `TRIM()`	清除字符串前后空格

- `TRIM(pattern FROM string)`	若字符串前后是pattern，则清除

- `REPLACE(string, from, to)`	替换，将字符串中的from全部替换成to



### 5.1.3 数学函数：

- `ROUND(number[, precision])`	四舍五入，precision为精确度，不传默认为0；若precision>0，保留小数位；若precision<0，保留整数位，如-1是保留到十位；
- `CEIL(number)` 向上取整
- `FOORL(number)` 向下取整
- `TRUNCATE(number, precision)`	舍去位数，precision为精确度；若precision>0，舍去小数位；若precision<0，舍去整数位；
- `TRUNC(number, precision)`	Oracle用法
- `MOD(m, n)`	取模
- `RAND()`	生成随机数，[0,1)



### 5.1.4 日期函数：

MySQL 使用下列数据类型在数据库中存储日期或日期/时间值：

```
DATE - 格式 YYYY-MM-DD
DATETIME - 格式: YYYY-MM-DD HH:MM:SS
TIMESTAMP - 格式: YYYY-MM-DD HH:MM:SS
YEAR - 格式 YYYY 或 YY
```



**注意：**

以下date须是日期对象，或合法格式的时间字符串

- `NOW()`  获取系统的当前日期和时间，返回日期时间类型数据

- `SYSDATE`  跟 now() 类似，不同之处在于：now() 在执行开始时值就得到了， sysdate() 在函数执行时动态得到值

- `CURDATE()`  获取系统的当前日期

- `CURTIME()`  获取系统的当前时间

- `CURRENT_TIMESTAMP/CURRENT_TIMESTAMP()`  获得当前时间戳函数

- `YEAR(date)`   获取传入日期对象的年份

- `MONTH(date)`   获取传入日期对象的月份

- `DAY(date)`   获取传入日期对象的日

- `HOUR(date)`   获取传入日期对象的时

- `MINUTE(date)`   获取传入日期对象的分

- `SECOND(date)`   获取传入日期对象的秒

- `MONTHNAME  `  获取传入日期对象的月份的英文名称，date必须是合法格式的日期或时间字符串

- `STR_TO_DATE(string, format)`  string转date类型，format是string类型的格式符，如'%Y-%m-%d'

- `DATE_FORMAT(date, format)`  date转string类型，format是string类型的格式符，如'%Y-%m-%d'

- `DATEDIFF(date1, date2)`  返回两个日期之间的天数，一般date2<date1。

  ![](..\images\日期格式符.png)

  

### 5.1.5 转换函数：
SQL中可以进行两种数据类型的转换，即隐式转换和显示转换。



### 5.1.6 流程控制函数

- IF函数

  类似于三元运算

  `IF(exp1, epx2, exp3)`  如果exp1为true，返回epx2，为false，返回exp3

  
  
- CASE函数

    枚举用法:

  ```sql
  CASE filedName
  	WHEN value1
  	THEN result1
  	WHEN value2
  	THEN result2
  	...
  	ELSE resultN
  END
  ```

  判断用法，类似于if...else，只会返回第一个符合条件的值，其他case被忽略：

  ```sql
  CASE 
    WHEN condition1
    THEN result1;
    WHEN condition2
    THEN result2;
    ...
    ELSE resultN
  END
  ```

### 5.1.7 其他函数：

- `IFNULL(exp1, exp2)`	如果exp1为null，返回exp2，如果不为null，返回exp1

- `ISNULL(exp)`	如果exp为null，返回1，如果不为null，返回0

- `NULLIF(exp1, exp2)`	如果exp1 = exp2，返回null，否则返回exp1

- `DATABASE()`  查询当前库

- `VERSION()`  查询数据库管理系统版本

- `USER()`   查询当前登录用户

  

## 5.2 分组函数

（又称为统计函数、聚合函数、组函数）

分组函函数是指多行数据经过函数处理，返回一行结果，并且可以通过不同的分组条件进行结果集的分组。

**注意：**

1. SUM、AVG函数专用于处理数字类型的数据，对于非数字类型的数据，虽然不会报错，但没有任何意义
2. MAX、MIN、COUNT可以处理任何类型的数据
3. 如果函数参数为字段名，所有的函数都会忽略为NULL的数据
4. 分组函数与单行函数一起查询字段，虽然不会报错，但毫无意义，除非是分组查询



**分组函数归纳：**

- `COUNT(fieldName)`	计算该字段共有多少条非空数据，统计所有行数

  统计总行数：

  ```sql
  COUNT(*) -- 只要这一行有一个值不为null就会被统计，一般被用来统计所有行数
  COUNT(1)
  COUNT(主键字段)
  注意：COUNT(*)和COUNT(1)执行效率一样，这两者效率都好于COUNT(字段)，因为字段需要判断。统计总行数推荐使用COUNT(*)
  ```

- `SUM(fieldName)`   求某个字段内的数据之和

- `MAX(fieldName)`   求某个字段的最大值，可以通过条件求取不同组内的最大值。

- `MIN(fieldName)`   求某个字段的最小值，可以通过条件求取不同组内的最小值。

- `AVG(fieldName)`   求某个字段的平均值

  

# 6 运算符

**分类：**

- 算数运算符：+、-、*、/、%

- 赋值运算符：= 

- 逻辑运算符：and（&&）、or（||）、not（!） 	`注意：优先级：not > and > or；sql中建议使用英文逻辑运算符`

- 比较运算符：>、<、=、>=、<=、<>、!=	`注意：!=非sql92标准` 

- 连接运算符：+	

- 其他：like、between...and...、in、is null、is not null 

  

**注意：**

  - null参与的任何数学运算，结果都为null
  - 不合数学规律的运算，结果都为null，如100/0

