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

### 2.1 创建数据库

**关键字：**CREATE DATABASE

**语法：**

```sql
CREATE DATABASE 库名;-- 如果已存在则报错
CREATE DATABASE IF NOT EXISTS 库名;-- 如果已存在则不创建
```



### 2.2 删除数据库

**关键字：**DROP DATABASE

**语法：**

```sql
DROP DATABASE 库名;-- 如果不存在则报错
DROP DATABASE IF EXISTS 库名;-- 如果不存在则不删除
```



### 2.3 修改数据库

> 注意：修改数据库存在很大安全问题，特别是存在记录的数据库，所以尽量不修改、少修改。

- 更改数据库字符集

  ```sql
  ALTER DATABASE 库名 CHARACTER SET 字符集名;
  ```

  示例：

  ```sql
  ALTER DATABASE mydb CHARACTER SET gbk;
  ```

- 修改数据库名称

  如果是 MyISAM 引擎的话，只要修改 DATA 目录下面的那个库名的文件夹的名字就OK了。

  如果是 INNODB 引擎的话，其实是无法修改库名的，网上瞎咧咧的什么RENAME DATABASE或者ALTER DATABASE都是不行的。

  一种方法是比较保守的，直接把老库的内容mysqldump到新库里面。

  还有一种类似上面方法，先 alter table 的存储引擎到 MyISAM，然后改了库目录的名字，然后再改回来INNODB。

  ...

  （参考：https://zhuanlan.zhihu.com/p/60054894）



### 2.4 选中数据库

即改变当前数据库。

**关键字：**USE

**语法：**

```sql
USE 库名;
```



### 2.5 其他

- 显示所有数据库

    ```sql
    SHOW DATABASES;
    ```

- 显示当前库

    ```sql
    SELECT DATABASE();
    ```

- 查看存储引擎

  ```sql
  SHOW ENGINES;
  ```

  

# 3 表相关操作


> 注意：若要操作表，必须先进入某一个库

### 3.1 创建表

**关键字：**CREATE TABLE

**语法：**

```sql
CREATE TABLE 表名(
    字段名1 字段类型1[(长度)] [约束],
    字段名2 字段类型2[(长度)] [约束],
    ...
);
```



### 3.2 删除表

**关键字：**DROP TABLE

**语法：**

```sql
DROP TABLE 表名;
DROP TABLE 表名1, 表名2, ...;-- 删除多个表

DROP TABLE IF EXISTS 表名;-- 如果不存在则不删除
DROP TABLE IF EXISTS 表名1, 表名2, ...;-- 删除多个表
```



### 3.3 修改表

**关键字：**ALTER TABLE

**表的修改包含：**

1. 修改表名
2. 修改列名
3. 修改列的类型或约束
4. 增加列、删除列



#### 3.3.1 修改表名

**关键字：**RENAME 、RENAME TABLE

**方式一：**

```sql
ALTER TABLE 旧表名 rename 新表名; 
```

**方式二：**

```sql
RENAME TABLE 旧表名 TO 新表名;
RENAME TABLE 旧表名 TO 新表名,  旧表名 TO 新表名;-- 支持多个表修改
```



#### 3.3.2 修改列名

**关键字：**CHANGE COLUMN

**语法：**

```sql
ALTER TABLE 表名 CHANGE [COLUMN] 旧列名 新列名 类型[(长度)]; -- [COLUMN]可省略；但类型必须填，否则报错;
```

**注意：**

1. 这个语法修改的既可以是列名，也可以类型，或都修改。



#### 3.3.3 修改列的类型

**关键字：**MODIFY COLUMN

**语法：**

```sql
ALTER TABLE 表名 MODIFY [COLUMN] 列名 新类型[(长度)] 约束; -- [COLUMN]可省略
```

> 注意：这里的”约束“是指列级约束，若要修改表级约束请查看[约束](#8 约束)。



#### 3.3.4 修改列的约束

修改列级约束请查看[修改列的类型](#3.3.3 修改列的类型)，修改表级约束请查看[约束](#8 约束)。



#### 3.3.5 增加列

**关键字：**ADD COLUMN

**语法：**

```sql
ALTER TABLE 表名 ADD [COLUMN] 新列名 新类型[(长度)] 约束; -- [COLUMN]可省略
```



#### 3.3.6 删除列

**关键字：**DROP COLUMN

**语法：**

```sql
ALTER TABLE 表名 DROP [COLUMN] 列名; -- [COLUMN]可省略
ALTER TABLE 表名 DROP 列名1, DROP 列名2; -- 删除多列
```



### 3.4 复制表

**关键字：**CREATE TABLE LIKE、CREATE TABLE AS



**方式一：**

```sql
CREATE TABLE 新表名 LIKE 源表名;
```

作用：使用源表的结构（包括索引和主键），重新建一个空表；即**复制表结构**。

**注意：**

1. 若需要复制数据则可以用 INSERT INTO 语句复制进去：`INSERT INTO 新表名 SELECT * FROM 源表名;`
2. 只支持复制全部的表结构，不能只复制部分结构（部分列）。



**方式二：**

```sql
CREATE TABLE 新表名 [AS] 子查询;
```

作用：先查到子查询的结果集虚拟表，复制表结构，然后把表数据插入该表；即**复制表结构 + 数据**。

**注意：**

1. 支持复制部分列和部分数据（通过筛选条件）。
2. 若想通过 CREATE TABLE AS 来**复制表结构，但不复制数据**，可以通过设置筛选条件为**恒假**（WHERE FALSE），把所有数据过滤掉，即可达到。



### 3.5 其他


- 显示某个库的所有表

    ```sql
    SHOW TABLES; -- 显示当前库所有表
    SHOW TABLES FROM 库名; -- 若未进入任何库，不得省略FROM后面的
    ```

    

- 查看表结构

    ```sql
    DESC 表名;
    DESCRIBE 表名;
    ```



- 查看表索引

  ```sql
  SHOW INDEX FROM 表名;
  ```

  ​	

- 查看表创建语句

  ```sql
  SHOW CREATE TABLE 表名;
  ```

  

# 4 记录相关操作

## 4.1 插入记录

即向表中插入新记录。

**关键字：**INSERT INTO、VALUES、SET

**方式一：**

- 插入特定列：

  - 单行插入：

    ```sql
    INSERT INTO 表名 (列1, 列2, ...) VALUES (值1, 值2, ....);
    ```

  - 多行插入：

    ```sql
    INSERT INTO 表名 (列1, 列2, ...) VALUES (值1, 值2, ....), (值1, 值2, ....), ...;
    ```

  - 子查询插入：

    ```sql
    INSERT INTO 表名 (列1, 列2, ...) 子查询;
    ```

    

- 插入全部列（即省略列名）：

  - 单行插入：

    ```sql
    INSERT INTO 表名 VALUES (值1, 值2, ...);
    ```

  - 多行插入：

    ```sql
    INSERT INTO 表名 VALUES (值1, 值2, ...), (值1, 值2, ...), ...;
    ```

  - 子查询插入：

    ```sql
    INSERT INTO 表名 子查询;
    ```

    

**方式一特性：**

1. 要求列名与值数量必须一致，一一对应，顺序不一定需要按照表的顺序
2. 若前有某列名，后必有值对应，即使是可空或有默认值，也需要填 NULL 或 DEFAULT
3. 若前无某列名，后值必不能填，可空为空，默认为默认
4. 支持**多行**插入
6. 支持子查询，要求子查询的列和插入的列一一对应



**方式二：**

```sql
INSERT INTO 表名 (列1, 列2, ...) SET 列名1 = 值1, 列名2 = 值2, ...;
```

**方式二特性：**

1. 不支持**多行**插入



**注意：**

1. 所有插入方式，插入值都需要与列类型一致或兼容



## 4.2 删除记录

即删除表中的记录。

**关键字：**DELETE、TRUNCATE TABLE



**DELETE 语句：**

- 删除单表记录：

  ```sql
  DELETE [表名/别名] 
  FROM 表名 AS 别名 
  WHERE 筛选条件; -- 删除单表记录时，[表名/别名]可以省略
  
  # 即
  DELETE FROM 表名 WHERE 筛选条件;
  ```

- 删除多表关联记录：

  ```sql
  DELETE 别名1 
  FROM 表1 别名1 
  JOIN 表2 别名2 
  ON 连接条件 
  WHERE 筛选条件;
  ```

**TRUNCATE TABLE 语句：**

```sql
TRUNCATE TABLE 表名;
```

TRUNCATE TABLE 是清空表中所有记录，不能加筛选条件。



**您可以在不删除表的情况下，删除表中所有的行。这意味着表结构、属性、索引将保持不变：**

```sql
TRUNCATE TABLE 表名;-- 效率高，推荐
# 或
DELETE FROM 表名;
```



**注意：**

1. 执行没有 WHERE 子句过滤的删除语句会把所有记录都删除，所以要**慎重，再慎重！**
2. TRUNCATE TABLE 语句执行效率高于 DELETE 语句
3. DELETE 语句删除后，再插入数据，自增长列从断点处开始；TRUNCATE TABLE 清空表后，自增长列从1开始；
4. TRUNCATE TABLE 删除没有返回值，DELETE 删除有返回值
5. TRUNCATE TABLE 删除后【不能回滚】，DELETE 删除【可以回滚】



## 4.3 修改记录

即修改表中现有的记录

**关键字：**UPDATE、SET

**语法：**

- 修改单表记录：

  ```sql
  UPDATE 表名 
  SET 列1 = 值1, 列2 = 值2, ... 
  WHERE 筛选条件;
  ```



- 修改多表关联记录：

  ```sql
  UPDATE 表1 AS 别名1 
  JOIN 表2 AS 别名1 
  ON 连接条件 
  SET 列1 = 值1, 列2 = 值2, ... 
  WHERE 筛选条件;
  ```

  

**注意：**

1. 执行没有 WHERE 子句过滤的 UPDATE 语句会把所有记录都更新，所以要**慎重，再慎重！**
2. 在 MySQL 中可以通过设置 **sql_safe_updates** 这个自带的参数来解决，当该参数开启的情况下，你必须在 UPDATE 语句后携带 WHERE 条件，否则就会报错。
3. MySQL 的 update 语句，更新的表不能在 SET 和 WHERE 中用于**子查询**，否则报错



# 5 查询

## 5.1 基础查询

**关键字：**SELECT

从表中查询数据，结果被存储在一个结果表中（称为结果集），结果表是一个虚拟的表格。

SELECT只会查询，不会影响原表

SELECT后面可以是字段名、常量值、表达式、函数



**书写顺序：**

SELECT > FROM > JOIN > ON > WHERE > GROUP BY > HAVING > ORDER BY > LIMIT

**执行顺序：**

FROM > JOIN > ON > WHERE > GROUP BY > HAVING > SELECT > ORDER BY > LIMIT



**示例：**

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

SELECT TOP 10 * FROM tableName -- 返回前10个

SELECT DISTINCT fieldName FROM tableName;-- 去重查询，去除重复的值
```




## 5.2 条件查询

```sql
SELECT fieldName FROM tableName WHERE conditions;
```

conditions由一个或多个condition组成，condition之间使用OR或AND连接，一个condition由字段、运算符、值组成。



**condition：**

```sql
fieldName = 1000;
fieldName >= 1000;
fieldName IS NULL;
...
```

**conditions：**

```sql
(fieldName > 1000 OR fieldName < 2000) AND fieldName != 1024;
...
```



**示例：**

```sql
SELECT * FROM `user` WHERE `user_id` = 5;
# 说明：设【无条件】的查询的结果集为m，依次循环m，设当前条设为c，则此处的`user_id`的所属为c
 
SELECT * FROM `user` AS u WHERE u.`user_id` = 5;
# 说明：此处的别名u代表是当前条数据，而非整个结果集
```



**注意：**

3. WHERE 关键字无法与分组函数一起使用。
2. 执行顺序：会先查询【无条件】的查询语句，再一条一条的去执行 WHERE 后面的条件把不符合的数据过滤掉



## 5.3 数据排序

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



## 5.4 分组查询

**关键字：**GROUP BY、HAVING

根据一个或多个列对结果集进行分组，**需要与分组函数配合使用**。放在条件子句后面，排序子句前面。

**执行顺序：**执行条件查询，执行分组，每组数据执行分组函数，对查询结果排序

```sql
 SELECT 分组函数(...) FROM tableName WHERE ... GROUP BY fieldName ORDER BY ...
 SELECT 分组函数(...) FROM tableName WHERE ... GROUP BY fieldName HAVING CONDITIONS ORDER BY ...
 SELECT 分组函数(...) AS alias FROM tableName WHERE ... GROUP BY alias HAVING alias... ORDER BY ...
 SELECT 分组函数(...) FROM tableName WHERE ... GROUP BY fieldName1,fieldName2 -- 多个字段分组
```

**注意：**

1. HAVING子句与WHERE类似，WHERE用于筛选分组之前的数据，HAVING用于筛选分组之后的数据，筛选的数据源不同

2. MySQL中，GROUP BY子句和HAVING子句支持别名

3. 支持单个、多个字段分组（所有字段都一样才能归纳在一个组里）



## 5.5 连接查询

又称多表查询、多表连接

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

### 5.5.1 内连接

内连接是指所有查询出的结果都是能够在连接的表中有对应记录的。

**关键字：**INNER JOIN，“INNER ”可以省略。

**内连接查询结果 = 主表和从表都有的记录**



#### 5.5.1.1 等值连接

**概念：**在连接条件中使用等于号（=）运算符，其查询结果中列出被连接表中的所有列，包括其中的重复列。

**示例：**

```sql
SELECT CONCAT(a.first_name, '.', a.last_name) AS 'name', b.department_name  
FROM `employees` AS a 
JOIN `departments` AS b
ON a.department_id = b.department_id;
```



#### 5.5.1.2 非等值连接

**概念：**在连接条件中使用除等于号之外运算符（>、<、<>、>=、<=、!>和!<等）

**示例：**

```sql
SELECT CONCAT(first_name, '.', last_name) '姓名', `salary` '工资',  `grade_level` '工资等级' 
FROM `employees` AS `e` 
JOIN `job_grades` AS `j`
ON `e`.`salary` BETWEEN `j`.`lowest_sal` AND `j`.`highest_sal`
```



#### 5.5.1.3 自连接

**示例：**

```sql
SELECT e.`first_name` '员工', m.`first_name` '领导', 
FROM `employees` e, `employees` m
WHERE e.`manager_id` = m.`employee_id`
```



### 5.5.2 外连接

用于查询一个表中有，另一个表中没有的记录。



#### 5.5.2.1 左外连接

**关键字：** LEFT JOIN

**左（右）连接查询结果 = 主表和从表都有的记录 + 主表有但从表没有的记录**

**特点：**

1. 外连接查询的结果为主表中的所有记录
2. 如果从表中有和它匹配的，则显示匹配的值
3. 如果从表中没有和它匹配的，则显示NULL（所有从表字段都为NULL，一般使用主键等于NULL来判定是否非匹配记录）
4. 必须有 ON 条件，否则报错



示例：

```sql
# departments为主表，employees为从表
SELECT d.`department_id`, d.`department_name`, e.`first_name` 
FROM `departments` AS d
LEFT JOIN `employees` AS e
ON e.`department_id` = d.`department_id`
```



#### 5.5.2.2 右外连接

效果和左外连接一样，只是主从表位置不同

**关键字：** RIGHT JOIN

**示例：**

```sql
SELECT d.`department_id`, d.`department_name`, e.`first_name` 
FROM `employees` AS e
RIGHT JOIN `departments` AS d
ON e.`department_id` = d.`department_id`
```



####  5.5.2.3 全外连接

**概念：**返回左表和右表中的所有行。当某行在另一表中没有匹配行，则另一表中的列返回空值。

**关键字：** FULL JOIN

**全外连接查询结果 = 主表和从表都有的记录 + 主表有但从表没有的记录+ 从表有但主表没有的记录**

**注意：**

- MySQL不支持全外连接



### 5.5.3 交叉连接

**关键字：** CROSS JOIN

**概念：**它将会返回被连接的两个表的笛卡尔积，返回结果的行数等于两个表行数的乘积。其实就是笛卡尔积的99语法写法。

**注意：**

1. 交叉连接不带ON条件子句



### 5.6 子查询

**分类：**

- 按子查询出现的位置：
  - SELECT后面：仅仅支持标量子查询
  - FROM后面
  - JOIN/LEFT JOIN等后面
  - WHERE或HAVING后面：✩
    - 标量子查询✩
    - 列子查询✩
    - 行子查询
  - EXISTS后面
    - 表子查询
- 按结果集的行列数不同：
  - 标量子查询（结果集为一行一列）
  
  - 列子查询（结果集为一列多行）
  
  - 行子查询（结果集为一行多列或多行多列）
  
  - 表子查询（结果集一般为多行多列）
  
    

**标量子查询搭配的操作符：**>、<、>=、<=、<>……

**列子查询搭配的操作符：**IN、NOT IN、ANY/SOME、ALL



**关联子查询（correlated subquery）：** 

关联子查询和普通子查询的区别在于：

1. 关联子查询引用了外部查询的列。 
2. 执行顺序不同。对于**普通子查询，先执行子查询，再执行父查询**；而对于关联子查询，**先执行父查询，然后对所有通过过滤条件的记录执行内层子查询**。



**注意：**

1. 放在FROM后的子查询必需取别名，否则找不到该表，导致报错



### 5.7 分页查询

**关键字：**LIMIT

**语法：**`LIMIT firstIndex, pageSize`，如果 firstIndex 是0，可以省略：`LIMIT pageSize`

firstIndex 代表起始索引（**从0开始**），pageSize 代表分页数



**注意：**

1. LIMIT 关键字总是放置在最后，执行顺序也是最后



### 5.8 联合查询

**关键字：**UNION、UNION ALL

**概念：**把两次或多次查询结果合并起来，支持把多个表的查询结果集合并起来。

**注意：**

1. UNION 用于合并两个或多个SELECT 语句的结果集，并消去表中任何重复行。
2. UNION 内部的 SELECT 语句必须拥有相同数量的列，列也必须拥有相似的数据类型，列的顺序必须相同。
3. UNION 内部的 SELECT 语句列的数量不同会导致报错，列的字段名、类型、顺序不一致不会导致报错，但要避免这样做
4. UNION ALL不会消去重复行




# 6 函数

## 6.1 单行函数

将一组逻辑语句封装在方法体中，对外暴露方法名

SQL单行函数根据数据类型分为字符函数、数学函数、日期函数、流程控制函数，以及其他函数。



### 6.1.2 字符函数

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

- `TRIM(pattern from string)`	若字符串前后是pattern，则清除

- `REPLACE(string, from, to)`	替换，将字符串中的from全部替换成to



### 6.1.3 数学函数

- `ROUND(number[, precision])`	四舍五入，precision为精确度，不传默认为0；若precision>0，保留小数位；若precision<0，保留整数位，如-1是保留到十位；
- `CEIL(number)` 向上取整
- `FOORL(number)` 向下取整
- `TRUNCATE(number, precision)`	舍去位数，precision为精确度；若precision>0，舍去小数位；若precision<0，舍去整数位；
- `TRUNC(number, precision)`	Oracle用法
- `MOD(m, n)`	取模
- `RAND()`	生成随机数，[0,1)



### 6.1.4 日期函数

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

- `SYSDATE`  跟 NOW() 类似，不同之处在于：NOW() 在执行开始时值就得到了， SYSDATE() 在函数执行时动态得到值

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

  

### 6.1.5 转换函数
SQL中可以进行两种数据类型的转换，即隐式转换和显示转换。



### 6.1.6 流程控制函数

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

### 6.1.7 其他函数

- `IFNULL(exp1, exp2)`	如果exp1为NULL，返回exp2，如果不为NULL，返回exp1

- `ISNULL(exp)`	如果exp为NULL，返回1，如果不为NULL，返回0

- `NULLIF(exp1, exp2)`	如果exp1 = exp2，返回NULL，否则返回exp1

- `DATABASE()`  查询当前库

- `VERSION()`  查询数据库管理系统版本

- `USER()`   查询当前登录用户

  

## 6.2 分组函数

（又称为统计函数、聚合函数、组函数）

分组函函数是指多行数据经过函数处理，返回一行结果，并且可以通过不同的分组条件进行结果集的分组。

**注意：**

1. SUM、AVG函数专用于处理数字类型的数据，对于非数字类型的数据，虽然不会报错，但没有任何意义
2. MAX、MIN、COUNT可以处理任何类型的数据
3. 如果函数参数为字段名，所有的函数都会忽略为NULL的数据
4. 分组函数与单行函数一起查询字段，虽然不会报错，但毫无意义，除非是分组查询



**分组函数归纳：**

- `COUNT(fieldName)`	计算该字段共有多少条非空数据，统计所有行数。

  统计总行数：

  ```sql
  COUNT(*) -- 只要这一行有一个值不为NULL就会被统计，一般被用来统计所有行数
  COUNT(1)
  COUNT(主键字段)
  注意：COUNT(*)和COUNT(1)执行效率一样，这两者效率都好于COUNT(字段)，因为字段需要判断。统计总行数推荐使用COUNT(*)
  ```

- `SUM(fieldName)`   求某个字段内的数据之和

- `MAX(fieldName)`   求某个字段的最大值，可以通过条件求取不同组内的最大值。

- `MIN(fieldName)`   求某个字段的最小值，可以通过条件求取不同组内的最小值。

- `AVG(fieldName)`   求某个字段的平均值。

  

# 7 数据类型

## 7.1 数值类型

| 类型                    | 大小                                     | 范围（有符号）                                               | 范围（无符号）                                               | 用途                 |
| :---------------------- | :--------------------------------------- | :----------------------------------------------------------- | :----------------------------------------------------------- | :------------------- |
| TINYINT                 | 1 Bytes                                  | (-128，127)                                                  | (0，255)                                                     | 小整数值             |
| SMALLINT                | 2 Bytes                                  | (-32 768，32 767)                                            | (0，65 535)                                                  | 大整数值             |
| MEDIUMINT               | 3 Bytes                                  | (-8 388 608，8 388 607)                                      | (0，16 777 215)                                              | 大整数值             |
| INT或INTEGER            | 4 Bytes                                  | (-2 147 483 648，2 147 483 647)                              | (0，4 294 967 295)                                           | 大整数值             |
| BIGINT                  | 8 Bytes                                  | (-9,223,372,036,854,775,808，9 223 372 036 854 775 807)      | (0，18 446 744 073 709 551 615)                              | 极大整数值           |
| FLOAT                   | 4 Bytes                                  | (-3.402 823 466 E+38，-1.175 494 351 E-38)，0，(1.175 494 351 E-38，3.402 823 466 351 E+38) | 0，(1.175 494 351 E-38，3.402 823 466 E+38)                  | 单精度      浮点数值 |
| DOUBLE                  | 8 Bytes                                  | (-1.797 693 134 862 315 7 E+308，-2.225 073 858 507 201 4 E-308)，0，(2.225 073 858 507 201 4 E-308，1.797 693 134 862 315 7 E+308) | 0，(2.225 073 858 507 201 4 E-308，1.797 693 134 862 315 7 E+308) | 双精度     浮点数值  |
| DEC(M,D) / DECIMAL(M,D) | 对DECIMAL(M,D) ，如果M>D，为M+2否则为D+2 | 依赖于M和D的值                                               | 依赖于M和D的值                                               | 小数值               |

以下M代表总长度（整数位+小数位），D代表小数位长度。D超出范围则四舍五入，M位超出则报错

- FLOAT(M,D)  / DOUBLE(M,D)：(M,D)可省略，省略表示无限制
- DECIMAL(M,D)：(M,D)可省略，省略后自动为默认值：(10, 0)



**注意：**

1. 建表时，若不设置有无符号，则默认为有符号；若想要设置为无符号，则需要追加 UNSIGNED 关键字
2. 若插入的数据超出类型范围，则运行报错
3. 建表时，整数型的类型后若不写长度，则会有默认长度；长度不是限制数值范围的（数值范围只由类型决定），而是显示的长度，需要追加 ZEROFILL 关键字才能体现



## 7.2 字符串类型

| 类型       | 大小                  | 用途                   |
| :--------- | :-------------------- | :--------------------- |
| CHAR       | 0-255 bytes           | 定长字符串             |
| VARCHAR    | 0-6,5535 bytes        | 变长字符串             |
| BINARY     | 0-255 bytes           | 定长二进制字符串       |
| VARBINARY  | 0-6,5535 bytes        | 变长二进制字符串       |
| TINYBLOB   | 0-255 bytes           | 二进制字符串           |
| TINYTEXT   | 0-255 bytes           | 短文本字符串           |
| BLOB       | 0-6,5535 bytes        | 二进制长文本字符串     |
| TEXT       | 0-6,5535 bytes        | 长文本字符串           |
| MEDIUMBLOB | 0-1677,7215 bytes     | 二进制中等长文本字符串 |
| MEDIUMTEXT | 0-1677,7215 bytes     | 中等长文本字符串       |
| LONGBLOB   | 0-4 2,9496,7295 bytes | 二进制极长文本字符串   |
| LONGTEXT   | 0-4 2,9496,7295 bytes | 极长文本字符串         |

**CHAR 和 VARCHAR 对比：**

1. 写法：CHAR(M)、VARCHAR(M)，M 代表最大字符长度。CHAR 的 M 可以省略，默认为1；VARCHAR 的 M 不能省略。
2. CHAR 用于储存【固定长度的字符串】，VARCHAR用于储存【可变长度的字符串】
3. CHAR 比较耗费空间，VARCHAR 比较节省空间
4. CHAR 性能比较好些，VARCHAR 较为差些



## 7.3 日期和时间类型

|   类型    | 大小 ( bytes) | 范围                                                         | 格式                |                  用途                  |
| :-------: | :-----------: | :----------------------------------------------------------- | :------------------ | :------------------------------------: |
|   DATE    |       3       | 1000-01-01 ~ 9999-12-31                                      | YYYY-MM-DD          |                 日期值                 |
|   TIME    |       3       | -838:59:59 ~ 838:59:59                                       | HH:MM:SS            |            时间值或持续时间            |
|   YEAR    |       1       | 1901 ~ 2155                                                  | YYYY                |                 年份值                 |
| DATETIME  |       8       | 1000-01-01 00:00:00 ~ 9999-12-31 23:59:59                    | YYYY-MM-DD HH:MM:SS |    混合日期和时间值（不受时区影响）    |
| TIMESTAMP |       4       | 1970-01-01 00:00:00 ~ 2038，结束时间是第 **2147483647** 秒，北京时间 **2038-1-19 11:14:07**，格林尼治时间 2038年1月19日 凌晨 03:14:07 | YYYYMMDD HHMMSS     | 混合日期和时间值，时间戳（受时区影响） |





## 7.4 其他

UNSIGNED 、ZEROFILL ？？？



# 8 约束

在 MySQL 中，约束是指对表中数据的一种约束，能够帮助数据库管理员更好地管理数据库，并且能够确保数据库中数据的正确性和有效性。

在 MySQL 中，主要支持以下 约束：主键约束、外键约束、唯一约束、检查约束、非空约束、非空约束、默认值约束、自增约束（标识列）。

SQL中的key有三种：PRIMARY KEY、UNIQUE KEY、 FOREIGN KEY



**分类：**

- 列级约束

  支持所有约束。

  

- 表级约束

  支持四种：主键、外键、唯一、检查。

  

**区别：**

- 定义方式不同

  列级约束是定义在列属性中的，直接跟在该列的其他定义之后，用空格分隔。
  表级约束与列级定义相互独立，不包括在列定义中，基本语法格式为：

  `[ CONSTRAINT <约束名> ] <约束类型>`

  > 约束名：约束不指定名称时，系统会给定一个默认名称。



- 约束范围不一样

  列级约束针对的是某一个特定列，表级约束针对的是涉及多个列的约束，面向的是表。



## 8.1 主键约束

**关键字：**PRIMARY KEY



主键是表的一个特殊字段，该字段能**唯一标识**该表中的每条信息。

在设计数据表时，一般情况下，都会要求表中设置一个主键。

例如，学生信息表中的学号是唯一的。



**分类：**

- 单字段主键
- 多字段复合主键（联合主键）



**复合主键：**在某些表中，单个列本身不足以唯一地标识一行，无法使用单一字段作为主键。这时我们可以将多个字段设置为复合主键，由复合主键标识唯一性。只要不是复合主键的每个值都重复，就不算重复。值得注意的是——复合主键的单个主键的值允许重复，这时候就需要追加一个唯一约束。



**原则：**最少性和唯一性。尽量用最少的主键字段来保证记录的唯一性。



> 注意：MySQL 中主键无法使用 CONSTRAINT 命名**约束名**，约束名固定为`PRIMARY`。



**建表时设置：**

- 方式一

  ```sql
  CREATE TABLE 表名                
  (               
  	主键字段 类型 PRIMARY KEY,                
   	...     
  );        
  ```

- 方式二（推荐）

  ```sql
  CREATE TABLE 表名                
  (               
  	主键字段 类型,                
   	...
      [CONSTRAINT 约束名] PRIMARY KEY(主键字段1, 主键字段2, ...)
  );-- MySQL中[CONSTRAINT 约束名]可以省略，用了也不起效     
  ```



**修改表时设置：**

```sql
ALTER TABLE 表名 ADD [CONSTRAINT 约束名] PRIMARY KEY(主键字段1, 主键字段2, ...); -- MySQL中[CONSTRAINT 约束名]可以省略，用了也不起效   
```



> 注意：修改表时设置主键，需要确保表中无记录，或已存在的记录必须符合主键条件，否则报错。



**删除约束：**

- MySQL

  ```sql
  ALTER TABLE 表名 DROP PRIMARY KEY;      
  ```



- 通用语法（推荐）

  ```sql
  ALTER TABLE 表名 DROP CONSTRAINT 约束名;-- MySQL中约束名固定为`PRIMARY`
  ```

  

**特点：**

1. 主键字段的值必须是唯一
2. 主键字段的值不可为空（NULL），所以设置主键的字段会自动加上非空约束
3. 每个表都应该有一个主键，并且每个表只能有一个主键



## 8.2 外键约束
**关键字：**FOREIGN KEY



外键用来建立主表与从表的关联关系，为两个表的数据建立连接，约束两个表中数据的一致性和完整性。

对于两个具有关联关系的表而言，被引用的表是**主表（父表）**，外键所在的表就是**从表（子表）**。

> 注意：外键可以引用主表中任何定义为唯一的字段，一般是主键，也可以是唯一键、外键。



**建表时设置：**

- 方式一

  ```sql
  CREATE TABLE 表名                
  (               
  	外键字段 类型 FOREIGN KEY REFERENCES 主表名(主键字段),                
   	...     
  );-- MySQL不支持此写法        
  ```

- 方式二（推荐）

  ```sql
  CREATE TABLE 表名                
  (               
  	外键字段 类型,                
   	...     
      [CONSTRAINT 约束名] FOREIGN KEY (外键字段1, 外键字段2, ...) REFERENCES 主表名(主键字段1, 主键字段2, ...) 
  );-- MySQL中[CONSTRAINT 约束名]可以省略           
  ```



**修改表时设置：**

```sql
ALTER TABLE 表名 ADD [CONSTRAINT 约束名] FOREIGN KEY (外键字段1, 外键字段2, ...) REFERENCES 主表名(主键字段1, 主键字段2, ...); --  MySQL中[CONSTRAINT 约束名]可省略
```



**删除约束：**

- MySQL

  ```sql
  ALTER TABLE 表名 DROP FOREIGN KEY 约束名;
  ```



* 通用语法（推荐）

  ```sql
  ALTER TABLE 表名 DROP CONSTRAINT 约束名;    
  ```



**特点：**

1. 一个表可以有一个或多个外键，但外键必须是另外一个表的主键；若多个外键字段都来自同一张主表，则主表的主键必须是这多个字段的联合主键
2. 外键可以为空值，若不为空值，则每一个外键的值必须等于主表中主键的某个值
3. 外键中列的数据类型必须和主表主键中对应列的数据类型相同
4. 外键中列的数目必须和主表的主键中列的数目相同
5. 创建外键时，必须已存在所引用的主表，且主表存在被引用的键
6. 删除主表时，必须先解除对应的所有主从表关系，或先删除对应的所有从表
7. 删除主表某记录时，必须先删除对应的从表记录，或先解除对应的所有主从表关系，或先删除对应的所有从表



## 8.3 唯一约束
**关键字：**UNIQUE



唯一约束与主键约束有一个相似的地方，就是它们都能够确保列的唯一性。

例如，在用户信息表中，要避免表中的用户名重名，就可以把用户名列设置为唯一约束。



**分类：**

- 单列唯一约束
- 多列联合唯一约束



**联合唯一约束：**只要不是联合唯一约束的每个值都重复，就不算重复。



**建表时设置：**

- 方式一：

  ```sql
  CREATE TABLE 表名                
  (               
  	字段 类型 UNIQUE,                
   	...     
  );   
  ```



- 方式二：

  ```sql
  CREATE TABLE 表名                
  (               
  	字段 类型 UNIQUE,                
   	...     
      [CONSTRAINT 约束名] UNIQUE (字段名1, 字段名2, ...)
  ); -- MySQL中[CONSTRAINT 约束名]可以省略
  ```



**修改表时设置：**

```sql
ALTER TABLE 表名 ADD [CONSTRAINT 约束名] UNIQUE(字段1, 字段2, ...); -- MySQL中[CONSTRAINT 约束名]可以省略
```



**删除约束：**

- MySQL

  ```sql
  ALTER TABLE Persons 表名 INDEX 约束名;
  ```



- 通用语法（推荐）

  ```sql
  ALTER TABLE 表名 DROP CONSTRAINT 约束名;   
  ```

  

**特点：**

1. 唯一约束字段的值必须是唯一
2. 唯一约束字段的值可为空（NULL），虽然只能有一个空值
3. 一个表允许有多个唯一约束字段



## 8.4 检查约束
**关键字：**CHECK



检查约束是用来检查数据表中，字段值是否有效的一个手段。

例如，学生信息表中的年龄字段是没有负数的，并且数值也是有限制的。如果是大学生，年龄一般应该在 18~30 岁之间。在设置字段的检查约束时要根据实际情况进行设置，这样能够减少无效数据的输入。



**建表时设置：**

- 方式一：

  ```sql
  CREATE TABLE 表名                
  (               
  	字段 类型 CHECK(表达式),                
   	...     
  );   
  ```

- 方式二：

  ```sql
  CREATE TABLE 表名                
  (               
  	字段 类型,                
   	...   
      [CONSTRAINT 约束名] CHECK(表达式) -- MySQL中[CONSTRAINT 约束名]可以省略
  );   
  ```



**修改表时设置：**

```sql
ALTER TABLE 表名 ADD [CONSTRAINT 约束名] CHECK (表达式);
```



**删除约束：**

- MySQL

  ```sql
  ALTER TABLE 表名 DROP CHECK 约束名;
  ```

- 通用语法（推荐）

  ```sql
  ALTER TABLE 表名 DROP CONSTRAINT 约束名;
  ```

  

## 8.5 非空约束
**关键字：**NOT NULL



非空约束用来约束表中的字段不能为空。例如，在学生信息表中，如果不添加学生姓名，那么这条记录是没有用的。



**建表时设置：**

```sql
CREATE TABLE 表名                
(               
	字段 类型 NOT NULL,                
 	...     
);   
```



**修改表时设置：**

```sql
ALTER TABLE 表名 MODIFY [COLUMN] 字段 类型 NOT NULL;
```



**删除约束：**

```sql
ALTER TABLE 表名 MODIFY [COLUMN] 字段 类型;
```





## 8.6 默认值约束
**关键字：**DEFAULT

默认值约束用来约束当数据表中某个字段不输入值时，自动为其添加一个已经设置好的值。

**建表时设置：**

```sql
CREATE TABLE 表名                
(               
	字段 类型 DEFAULT 默认值,                
 	...     
);   
```



**修改表时设置：**

- MySQL

  ```sql
  ALTER TABLE 表名 ALTER 字段 SET DEFAULT 默认值;
  ```

- 通用语法（推荐）

  ```sql
  ALTER TABLE 表名 MODIFY [COLUMN] 列名 类型 DEFAULT 默认值;
  ```

  

**删除约束：**

- MySQL

  ```sql
  ALTER TABLE 表名 ALTER 字段 DROP DEFAULT;
  ```

- 通用语法（推荐）：

  ```sql
  ALTER TABLE 表名 MODIFY [COLUMN] 列名 类型 DEFAULT NULL;
  ```

  

**特点：**

1. 未设置默认值约束，则默认为 DEFAULT NULL。



## 8.7 自增约束

**关键字：**AUTO_INCREMENT

我们通常希望在每次插入新记录时自动创建主键字段的值。我们可以在表中创建一个自动增量（auto-increment）字段。Auto-increment 会在新记录插入表中时生成一个唯一的数字。

自增长列也叫标识列。



**建表时设置：**

```sql
CREATE TABLE 表名                
(               
	字段 类型 AUTO_INCREMENT,                
 	...     
);   
```

**修改表时设置：**

```sql
ALTER TABLE 表名 MODIFY [COLUMN] 列名 类型 DEFAULT 默认值;
```

**设置自增初始值：**

```sql
ALTER TABLE 表名 AUTO_INCREMENT = 初始值;
```

> 自增初始值默认为1

**删除约束：**

```sql
ALTER TABLE 表名 MODIFY [COLUMN] 列名 类型;
```



**特点：**

1. 标识列插入值时，插入 NULL 或 DEFAULT 会自动默认自增生成唯一值
2. 标识列必须是一个key列（主键、唯一键、外键之一），具有唯一性
3. 一个表只能有一个标识列
4. 标识列的类型只能是数值型（整数、小数都可以），一般来说是整数

# 9 运算符

**分类：**

- 算数运算符：+、-、*、/、%

- 赋值运算符：= 

- 逻辑运算符：AND（&&）、OR（||）、NOT（!） 

- 比较运算符：>、<、=、>=、<=、<>、!=	**注意：!=非sql92标准**

- 连接运算符：+	

- 其他：like、BETWEEN...AND...、IN、IS NULL、IS NOT NULL 




**运算符：**

- `=` ：等于，后面不能接NULL

- `<=>`：安全等于，与=的区别：后面可以接普通类型的值和NULL

- `<> 或 !=`：不等于

- `<`：小于

- `<=`：小于等于

- `>`：大于

- `>=`：大于等于

- `NOT`：非，搭配有：NOT IN、NOT BETWEEN、NOT LIKE、NOT EXISTS……

- `AND`：且

- `OR`：或

- `BETWEEN a AND b`：在两者之间，[a, b]之间，等同于`SOME >= a && SOME <= b`

- `NOT BETWEEN a AND b`：不在两者之间，等同于`SOME < a OR SOME > b`

  ```sql
  fieldName BETWEEN 9500 AND 10000;
  fieldName NOT BETWEEN 9500 AND 10000;
  ```

- `IS NULL 或 IS NOT NULL` ：为空 / 不为空	

- `IN`：用法：`IN (value1, value2, value3 ...) / IN (子查询)`，表示在多个值之中，是这些值之一即可满足条件	**注意：IN不能使用通配符，且括号内部的数据类型需一致或兼容**

  ```sql
  fieldName IN (10000, 11000, 12000); -- fieldName是10000或11000或12000
  ```

- `NOT IN`： 用法：`NOT IN (value1, value2, value3 ...) / NOT IN (子查询)`，表示不在多个值中，不是这些值之一

  ```sql
  fieldName NOT IN (10000,11000,12000);
  ```

- `LIKE`：模糊查询，一般配合通配符使用

  - `%`：通配符，代表任意数量个字符，包括0个

  - `_`：通配符，代表任意一个字符

  ```sql
  fieldName LIKE pattern;
  如：fieldName LIKE '_a%';
  ```

- `ANY 或 SOME`：用于子查询，用法：`ANY(子查询)`，表示：父查询中的结果集【较胜于】子查询中任意一个结果集中的值，则为真，较胜于可以为大于、小于
- `ALL`：用于子查询，用法：`ALL(子查询)`，表示：父查询中的结果集【较胜于】子查询中每一个结果集中的值，则为真，较胜于可以为大于、小于
- `EXISTS`：用于子查询，用法：`EXISTS(子查询)`，表示：检查是否子查询的结果集存在值，有值返回1, 没值返回0
- `NOT EXISTS`：不存在，与`EXISTS`相反

**注意：**

  - NULL 参与的任何数学运算，结果都为 NULL
  - 不合数学规律的运算，结果都为 NULL，如100/0
  - 数据库中的 NULL 不能使用=进行衡量，只能使用 IS 或IS NOT（因为数据库中的 NULL 代表什么也没有，而不是一个值的类型），并且其他类型的数值不能使用 IS  或 IS NOT 来判断
- AND 的优先级大于 OR，若要 OR 先执行，需要加小括号()
- 优先级：NOT > AND > OR；sql 中建议使用英文逻辑运算符

# 10 事务

​	事务（ Transaction）由一次或者多次基本操作构成，或者说，事务由一条或者多条 SQL 语句构成。
在数据库中，我们将一条 SQL 语句称为一次基本的操作。将若干条 SQL 语句“打包”在一起，共同执行一个完整的任务，这就是事务。
事务有一个最显著的特征，就是它包含的所有 SQL 语句作为一个整体向数据库提交，只有所有的 SQL 语句都执行完成，整个事务才算成功，一旦某个 SQL 语句
执行失败，整个事务就失败了。事务失败后需要回滚所有的 SQL 语句。
事务中的所有 SQL 语句是一个整体，共同进退，不可分割，要么全部执行成功，要么全部执行失败。

​	其实我们平时使用数据库时，就已经在使用事务了，只不过这种事务只包含一条 SQL 语句，并且由数据库引擎自动封装和提交。这意味着，对于任何一条 SQL 语句，要么执行成功，要么执行失败，不能成功一部分，失败一部分。

## 10.1 事务的属性

一般来说，事务具有四个标准属性，分别是原子性（Atomicity，或称不可分割性）、一致性（Consistency）、隔离性（Isolation，又称独立性）、持久性（Durability），简称 **ACID**。具体说明如下：

1) **原子性**
一个事务中的所有 SQL 语句，要么全部执行成功，要么全部执行失败，不会结束在中间的某个环节。事务在执行过程中发生错误，会被回滚（Rollback）到事务开始前的状态，就像这个事务从来没有执行过一样。
2) **一致性**
    在事务开始之前和事务结束以后，数据库的完整性没有被破坏。这表示写入的数据必须完全符合所有的预设规则，其中包含数据的精确度、串联性以及后续数据库可以自发性地完成预定的工作。
3) **隔离性**
    数据库允许多个并发事务同时对其数据进行读写和修改的能力，隔离性可以防止多个事务并发执行时由于交叉执行而导致数据的不一致。事务隔离分为不同级别，包括读未提交（Read uncommitted）、读提交（read committed）、可重复读（repeatable read）和串行化（Serializable）。
4) **持久性**
    事务处理结束后，对数据的修改就是永久的，即便系统故障也不会丢失。



## 10.2 事务执行流程

各种数据库对事务的支持细节不尽相同，本教程以 MySQL 数据库为例进行讲解，MySQL 使用标准 SQL 来支持事务。

与事务控制有关的 SQL 命令包括：

- 开始事务

  ```sql
  START TRANSACTION;
  # 或
  BEGIN; 
  ```

- 提交事务；

  ```sql
  COMMIT;
  ```

- 在事务内部设置回滚标记点

  ```sql
  SAVEPOINT 标记点名;
  ```

- 删除回滚标记点

  ```sql
  RELEASE SAVEPOINT 标记点名;
  ```

- 回滚事务

  ```sql
  ROLLBACK;
  ROLLBACK TO 标记点名;-- 将事务回滚到标记点
  ```

一个事务**要么提交（Commit），要么回滚（Rollback）**，提交意味着成功，回滚意味着失败。COMMIT 和 ROLLBACK 对应事务的两种状态，只能出现一个。

编写事务代码时，以 BEGIN 命令开头，后跟一条或者多条 SQL 语句，最后书写 COMMIT 或者 ROLLBACK 命令。

事务控制命令仅能与 DML 类别的 SQL 命令一起使用，包括 **INSERT、UPDATE、DELETE 和 SELECT**，在创建或者删除表时不能使用事务，因为这些操作在数据库中是自动提交的。



## 10.3 AutoCommit

MySQL还有一个特性就是AutoCommit（隐藏/自动事务），即默认情况下，MySQL是开启事务的。这就表示除非显式地开始一个事务，否则每个查询都被当做一个单独的事务自动执行。我们可以通过设置AutoCommit的值改变是否是自动提交AutoCommit模式。

**查询AutoCommit状态：**

```sql
SHOW VARIABLES LIKE 'autocommit';
```

**用 SET 来改变AutoCommit状态:**

-  禁止自动提交

  ```sql
  SET autocommit = 0;-- 同时会开启事务
  ```

- 开启自动提交

  ```sql
  SET autocommit = 1;
  ```



## 10.4 事务的隔离级别

参考：https://zhuanlan.zhihu.com/p/76743929

数据库事务的隔离级别有4个，由低到高依次为Read uncommitted(未授权读取、读未提交)、Read committed（授权读取、读提交）、Repeatable read（可重复读取）、Serializable（序列化），这四个级别可以逐个解决脏读、不可重复读、幻象读这几类问题。



- **Read uncommitted(未授权读取、读未提交)：** 
  在该隔离级别，所有事务都可以看到其他未提交事务的执行结果。如果一个事务已经开始写数据，则另外一个事务则不允许同时进行写操作，但允许其他事务读此行数据。该隔离级别可以通过“排他写锁”实现。这样就避免了更新丢失，却可能出现脏读。也就是说事务B读取到了事务A未提交的数据。读取未提交的数据，也被称之为脏读（Dirty Read）。本隔离级别很少用于实际应用，因为它的性能也不比其他级别好多少。

- **Read committed（授权读取、读提交）：** 
  读取数据的事务允许其他事务继续访问该行数据，但是未提交的写事务将会禁止其他事务访问该行。该隔离级别避免了脏读，但是却可能出现不可重复读。事务A事先读取了数据，事务B紧接了更新了数据，并提交了事务，而事务A再次读取该数据时，数据已经发生了改变。

- **Repeatable read（可重复读取）：** 
  可重复读是指在一个事务内，多次读同一数据。在这个事务还没有结束时，另外一个事务也访问该同一数据。那么，在第一个事务中的两次读数据之间，即使第二个事务对数据进行修改，第一个事务两次读到的的数据是一样的。这样就发生了在一个事务内两次读到的数据是一样的，因此称为是可重复读。读取数据的事务将会禁止写事务（但允许读事务），写事务则禁止任何其他事务。这样避免了不可重复读取和脏读，但是有时可能出现幻象读。（读取数据的事务）这可以通过“共享读锁”和“排他写锁”实现。

  这是MySQL的默认事务隔离级别，它确保同一事务的多个实例在并发读取数据时，会看到同样的数据行。不过理论上，这会导致另一个棘手的问题：幻读 （Phantom Read）。
  简单的说，幻读指当用户读取某一范围的数据行时，另一个事务又在该范围内插入了新行，当用户再读取该范围的数据行时，会发现有新的“幻影” 行。InnoDB和Falcon存储引擎通过多版本并发控制（MVCC，Multiversion Concurrency Control）机制解决了该问题。

- **Serializable（序列化）：** 
  提供严格的事务隔离。它要求事务序列化执行，事务只能一个接着一个地执行，但不能并发执行。如果仅仅通过“行级锁”是无法实现事务序列化的，必须通过其他机制保证新插入的数据不会被刚执行查询操作的事务访问到。<u>序列化是最高的事务隔离级别，同时代价也花费最高，性能很低，一般很少使用</u>，在该级别下，事务顺序执行，不仅可以避免脏读、不可重复读，还避免了幻像读。 

  这是最高的隔离级别，它通过强制事务排序，使之不可能相互冲突，从而解决幻读问题。简言之，它是在每个读的数据行上加上**共享锁**。在这个级别，可能导致大量的**超时现象和锁竞争**。

![这里写图片描述](E:\Desktop\myDataBase\images\事务的隔离级别.png)

<u>隔离级别越高，越能保证数据的完整性和一致性，但是对并发性能的影响也越大。</u>对于多数应用程序，可以优先考虑把数据库系统的隔离级别设为Read Committed。它能够避免脏读取，而且具有较好的并发性能。尽管它会导致不可重复读、幻读和第二类丢失更新这些并发问题，在可能出现这类问题的个别场合，可以由应用程序采用悲观锁或乐观锁来控制。<u>大多数数据库的默认级别就是Read committed，比如Sql Server , Oracle。MySQL的默认隔离级别就是Repeatable read。</u>



**查看当前事务隔离级别：**

```sql
SHOW VARIABLES LIKE '%isolation%';
```



## 10.5 悲观锁和乐观锁

# 11 视图

视图无非就是存储在数据库中并具有名字的 SQL 语句，或者说是以预定义的 SQL 查询的形式存在的数据表的成分。

视图可以包含表中的所有列，或者仅包含选定的列。视图可以创建自一个或者多个表，这取决于创建该视图的 SQL 语句的写法。

视图，一种虚拟的表，允许用户执行以下操作：

- 以用户或者某些类型的用户感觉自然或者直观的方式来组织数据；
- 限制对数据的访问，从而使得用户仅能够看到或者修改（某些情况下）他们需要的数据；
- 从多个表中汇总数据，以产生报表。



## 11.1 创建视图

```sql
CREATE VIEW 视图名 AS 查询语句;
```



## 11.2 更新视图

```sql
# 方式一：
CREATE OR REPLACE VIEW 视图名 AS 查询语句;-- 若无存在视图，则创建；若有则替换
# 方式二：
ALTER VIEW 视图名 AS 查询语句;-- 将已有的视图替换
```



## 11.3 修改视图及视图记录

与操作表和操作表记录一样，修改视图最终更新的还是原始数据表，只是其结果反应在了视图上。不建议直接修改视图数据，不安全，所以一般会给视图加上只读的权限。

**修改视图需要一定条件，在特定的情况下修改：**

- SELECT 子句不能包含 DISTINCT 关键字

- SELECT 子句不能包含任何分组函数(max、avg...)

- SELECT 子句不能包含任何集合函数（set functions）

- SELECT 子句不能包含任何集合运算符（set operators）

- SELECT 子句不能包含 ORDER BY 子句

- 视图不能包含连接操作符（join、left join...）

- 视图不能包含伪列或表达式

- FROM 子句中不能有多个数据表

- WHERE 子句不能包含子查询（subquery）

- 查询语句中不能有 GROUP BY 或者 HAVING

- 计算得出的列不能更新

- 视图必须包含原始数据表中所有的 NOT NULL 列，从而使 INSERT 查询生效。

  

## 11.3 删除视图

```sql
DROP VIEW 视图名;
DROP VIEW 视图名1, 视图名2, ...;-- 删除多个
DROP VIEW IF EXISTS 视图名;
DROP VIEW IF EXISTS 视图名1, 视图名2, ...;
```



## 11.4 其他

- 查看视图结构

  ```sql
  DESC 视图名;
  DESCRIBE 视图名;
  ```

- 查看视图创建语句

  ```sql
  SHOW CREATE VIEW 视图名;
  ```




# 12 变量

**分类：**

- 系统变量
  - 会话
  - 全局
- 自定义
  - 全局
  - 局部



## 12.1 系统变量

### 12.1.1全局系统变量

**作用域：**服务器每次重启都会给全局变量赋予初始值，针对所有会话（连接）都有效，但不能跨重启。

```sql
# SHOW
SHOW GLOBAL VARIABLES;
SHOW GLOBAL VARIABLES LIKE pattern;-- 模糊查询

# SELECT
SELECT @@GLOBAL.变量名;

# 设置
SET GLOBAL 变量名 = 值;
SET @@GLOBAL.变量名 = 值;
```



### 12.1.2 会话系统变量

**作用域：**仅仅针对当前会话（连接）有效。

```sql
# SHOW
SHOW [SESSION] VARIABLES;-- [SESSION]可省略
SHOW VARIABLES LIKE pattern;-- 模糊查询

# SELECT
SELECT @@[SESSION.]变量名;

# 设置
SET [SESSION] 变量名 = 值;
SET @@[SESSION.]变量名 = 值;
```



## 12.2 自定义变量

## 12.2.1 用户变量

**作用域：**仅仅针对当前会话（连接）有效，和会话系统变量作用域一样。



**声明并初始化：**

```sql
# 方式一
SET @变量名 = 值;

# 方式二
SET/SELECT @变量名 := 值;

# 方式三
SELECT 字段 INTO @变量名 FROM 表;-- 将查询的字段值（必须保证只有一个值）赋值给一个变量
```

> 注意：sql中给变量赋值的操作同上。



**查看变量：**

```sql
SELECT @变量名;
```



## 12.2.2 局部变量

**作用域：**仅仅在BEGIN、END之间。



**声明：**

```sql
DECLARE 变量名 类型;
DECLARE 变量名 类型 DEFAULT 默认值;
```



**赋值：**

```sql
# 方式一
SET 变量名 = 值;

# 方式二
SET/SELECT 变量名 := 值;

# 方式三
SELECT 字段 INTO @变量名 FROM 表;-- 将查询的字段值（必须保证只有一个值，且类型与变量类型兼容）赋值给一个变量
```

> 注意：除了方式一与方式二变量名不用加”@“，其他与用户变量的赋值操作一致。



**查看变量：**

```sql
SELECT 变量名;
```



# 13 存储过程

# 14 函数

# 15 流程控制

