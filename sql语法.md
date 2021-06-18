## 目录

- [SQL语法规范](##SQL语法规范)
- [库相关操作](##库相关操作)
- [表相关操作](##表相关操作)
- [数据相关操作](##数据相关操作)
- [函数](##函数)



## SQL语法规范

- sql语句以“;”或“/g”结尾，建议用分号

- sql语句不区分大小写。通常关键字使用大写，库、表、列名使用小写

- 转义符号：\

- sql索引是从1开始，并非从0开始

  
  
- ###  引号
  
	- 若库、表、列名与关键字重复，可用反引号（着重号）``包住，用于区分；若不重复，可不写反引号

	- 在标准 SQL中，字符串使用的是单引号包裹

	- 大部分数据库都支持单引号和双引号的互换，但双引号不是标准不建议你使用，比如在Oracle中不支持双引号



- ### 	注释

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



## 无归纳操作

- **退出MySQL服务**

	```sql
	EXIT;
	```

- **查看数据库管理系统版本，函数**

	```sql
	select version();
	```



## 库相关操作

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

- 显示当前库，函数

    ```sql
    SELECT DATABASE();
    ```



## 表相关操作


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



##　数据相关操作

- #### 查询

  - **简单查询**

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
  
    SELECT DISTINCT fieldName FROM tableName;-- 去除重复的值
    #SELECT TOP 10 * FROM tableName -- 返回前10个
    ```

  - **条件查询**

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

    **条件查询配合运算符：**

    `=`  等于

    `<> `或 `!=` 不等于

    `<` 小于

    `<=` 小于等于

    `>` 大于

    `>=` 大于等于

    `between a and b` 在两者之间，[a,b]之间

    ```sql
    fieldName BETWEEN 9500 AND 10000;
    ```

    `not` 取非，可以与is和in配合

    `is null `  为空

    `is not null` 不为空

    `and` 并且

    `or` 或者

    `in` 在多个值之中，是这些值之一即可满足条件

    ```sql
    fieldName IN (10000,11000,12000); -- fieldName是10000或11000或12000
    ```

    `not in` 不在多个值中，不是这些值之一

    ```sql
    fieldName NOT IN (10000,11000,12000);
    ```

    `like` 模糊查询

    %：代表任意数量个字符，包括0个

    _：代表任意一个字符

    ```sql
    fieldName LIKE pattern;
    如：fieldName LIKE '_a%';
    ```

    **注意：**

    - 数据库中的null不能使用=进行衡量，只能使用is或is not，因为数据库中的null代表什么也没有，而不是一个值得类型

    - and的优先级大于or，若要or先执行，需要加小括号()

    

  - **数据排序**

    对查询结构进行排序输出

    ```sql
     SELECT fieldName FROM tableName ORDER BY orderField ASC/DESC;
    ```

    orderField：字段名称，或者列的序数（不建议），代表以该字段排序

    ASC/DESC：升序\降序，默认是升序，ASC可省略

    

    多个字段排序：

    ```sql
     SELECT fieldName FROM tableName ORDER BY orderField1 ASC/DESC, orderField2 ASC/DESC;
    ```

    先按orderField1排序，orderField1相同，再按orderField2排序。

    

  - 组合查询

    组合查询是指条件查询与排序组合使用，这时条件查询先写，排序后写，顺序不能反，否则报错。

    执行顺序是：先执行条件查询，后对查询结果排序。排序总是在最后做得。

    ```sql
     SELECT fieldName FROM tableName WHERE ... ORDER BY ...
    ```




## 函数

- #### **单行函数**

  SQL单行函数根据数据类型分为字符函数、数字函数、日期函数、转换函数，另外还有一些别的函数。

  

  - **字符函数**：

    - `UPPER()`  将查询的字符串小写转换为大写 

    - `LOWER()`  将查询的字符串大写转换为小写

    - `INITCAP()`  将查询的字符串首字母大写

    - `CONCAT(field1, field2...)` 字符串连接函数，参数可以是字段或常量，如：

      ```sql
      SELECT CONCAT(`first_name`, '.',`last_name`, '-', `salary`) AS 'name' FROM `employees`;
      ```

    - `SUBSTR(string, start, count)` 字符串截取函数，start是截取起始索引，count是截取个数
    - `LENGTH()` 字符串长度函数
    - `LPAD(string, length, pattern)`  左填充函数，length是填充完的总长度，pattern是用来填充的字符串
    - `RPAD(string, length, pattern)  右填充函数，length是填充完的总长度，pattern是用来填充的字符串 `
    - ``TRIM()`	清除字符串前后空格
    - `TRIM(pattern FROM string)`	若字符串前后是pattern，则清除
    - `REPLACE(string, from, to)`	替换，将字符串中的from全部替换成to

  

  - **数字函数：**

      

      - `round(number[, precision])`	四舍五入，precision为精确度，不传默认为0；若precision>0，保留小数位；若precision<0，保留整数位，如-1是保留到十位；
      - `TRUNCATE(number, precision)`	舍去位数，precision为精确度；若precision>0，舍去小数位；若precision<0，舍去整数位；
      - `TRUNC(number, precision)`	Oracle用法
      - `MOD(m, n)`	取模
      - `RAND()`	生成随机数，[0,1)

      

  - **日期函数：**

      

  - **转换函数：**
      SQL中可以进行两种数据类型的转换，即隐式转换和显示转换。

      

  - **通用函数：**
    - `IFNULL(exp1, exp2)`	如果exp1为null，返回exp2，如果不为null，返回exp1

    - `ISNULL(exp)`	如果exp为null，返回1，如果不为null，返回0

    - `NULLIF(exp1, exp2)`	如果exp1 = ,exp2，返回null，否则返回exp1

      

  - **流程控制函数**	

    - `case ...`
    
        枚举用法:
    
      ```sql
      CASE filedName
      	WHEN value1
      	THEN result1
      	WHEN value2
      	THEN result2
      	...
      	ELSE result
      END
      ```
    
        判断用法，类似于if...else，只会返回第一个符合条件的值，其他case被忽略：
    
      ```sql
      CASE 
        WHEN condition1
        THEN result1
        WHEN condition2
        THEN result2
        ...
      	ELSE result
      END
      ```

- ### 分组函数（多行函数）

  分组函函数是指多行数据经过函数处理，返回一行结果，并且可以通过不同的分组条件进行结果集的分组。

  - `COUNT(fieldName)`	计算该字段共有多少条数据，但是在查询中，并不会记录为null的数据
  - `SUM(fieldName)`   求某个字段内的数据之和
  - `MAX(fieldName)`   求某个字段的最大值，可以通过条件求取不同组内的最大值。
  - `MIN(fieldName)`   求某个字段的最小值，可以通过条件求取不同组内的最小值。
  - `AVG(fieldName)`   求某个字段的平均值
  - 

## 运算符

- 算数运算符：+、-、*、/、%

- 赋值运算符：= 

- 逻辑运算符：and、or、not 	`注意：优先级：not > and > or`

- 比较运算符：>、<、=、>=、<=、<>、!= 	`注意：!=非sql92标准` 

- 连接运算符：+	

  

  **注意：**

  - null参与的任何数学运算，结果都为null
  - 不合数学规律的运算，结果都为null，如100/0

