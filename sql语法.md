> ### 以下是登录MySQL服务之后的命令操作




## SQL语法规范

- 每条命令以“;”或“/g”结尾，建议用分号，图形界面不写也可以

- sql语句不区分大小写。通常关键字使用大写，库、表、列名使用小写

- 转义符号：\

  ### 引号

  - 若库、表、列名与关键字重复，可用反引号（着重号）``包住，用于区分；若不重复，可不写反引号
  - 在标准 SQL中，字符串使用的是单引号包裹
  - 大部分数据库都支持单引号和双引号的互换，但双引号不是标准不建议你使用，比如在Oracle中不支持双引号



## 注释

- 单行注释

    ```sql
    #单行注释
    -- 单行注释，空格不能丢
    ```

- 多行注释

      /*
      多行注释
      多行注释
      多行注释
      */
  
  

**退出MySQL服务**

```sql
EXIT;
```



**查看数据库版本，函数**

```sql
select version();
```

## 库相关命令

- 创建数据库

    ```sql
    CREATE DATABASE dbName;
    ```

- 删除数据库

    ```sql
    DROP DATABASE dbName;
    ```

- 显示所有数据库

    ```sql
    SHOW DATABASE;
    ```

- 选中某个数据库进行操作，改变当前数据库

    ```sql
    USE dbName;
    ```

- 显示当前库，函数

    ```sql
    SELECT DATABASE();
    ```

## 表相关命令


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

- 查看表结构

    ```sql
    DESC tableName;
    DESCRIBE tableName;
    ```

- 查询

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
    SELECT fieldName alias; -- 给字段起别名省略AS

    SELECT DISTINCT fieldName FROM tableName;-- 去除重复的值
    #SELECT TOP 10 * FROM tableName -- 返回前10个
    ```

- 条件查询
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
  
  **运算符：**
  
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
  fieldName like '%a%';
  fieldName like '_a%';
  ```
  
  **注意：**
  
  - 数据库中的null不能使用=进行衡量，只能使用is或is not，因为数据库中的null代表什么也没有，而不是一个值得类型
  
  - and的优先级大于or，若要or先执行，需要加小括号()
  
    
  
- 数据排序

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

  执行顺序是：先执行条件查询，后对查询结果排序。排序总是在最后的。

  ```sql
   SELECT fieldName FROM tableName WHERE ... ORDER BY ...
  ```

  
