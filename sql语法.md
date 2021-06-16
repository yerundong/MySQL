**停止/启动MySQL服务（需要管理员身份运行cmd）**

```cmd
net stop/start [serverName]
```

或者打开windows服务界面，手动开启。

**查看数据库版本**

```cmd
mysql --version
mysql --V
```

**登录MySQL服务**

- 第一种方式：使用MySql Command Line Client，直接打开，输入密码，但只限root用户

- 第二种方式：使用cmd

  格式：`mysql -h[hostName] -P[port] -u[userName] -p[password]`

  注：

  -h：host主机名；-P：port端口号；-u：user用户名；-p：密码； 

  [password]可以省略，执行使用暗文输入；

  如果是本机登录，可省略 -h[hostName] -P[port]，如：mysql -u[userName] -p[password]

  示例：

  ```cmd
  mysql -hlocalhost -P3306 -uroot -p
  mysql -uroot -p
  ```



> ### 以下是登录MySQL服务之后的命令操作，每条命令以“;”或“/g”结尾



**退出MySQL服务**

```cmd
EXIT
```

## SQL语法规范

- 每条命令以“;”或“/g”结尾，建议用分号，图形界面不写也可以

- sql语句不区分大小写。通常关键字使用大写，库、表、列名使用小写

  ### 引号

  - 若库、表、列名与关键字重复，可用反引号（着重号）``包住，用于区分；若不重复，可不写反引号
  - 在标准 SQL中，字符串使用的是单引号
  - 双引号的用法和单引号有所类似，大部分数据库都支持单引号和双引号的互换



## 注释

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

- 选中某个数据库进行操作，改变当前活动数据库

```sql
USE dbName;
```

- 显示当前活动库，函数

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

- SELECT：

  从表中查询数据，结果被存储在一个结果表中（称为结果集），结果表是一个虚拟的表格。
  
  fieldName可以是字段名、常量值、表达式、函数

```sql
SELECT fieldName FROM tableName; -- 查询单个字段
SELECT fieldName1, fieldName2... FROM tableName; -- 查询多个字段
SELECT * FROM tableName; -- 查询所有字段

SELECT 100; -- 常量值
SELECT 'Tom'; -- 常量值
SELECT 100*99; -- 表达式
SELECT VERSION(); -- 函数

SELECT fieldName AS alias; -- 给字段起别名
SELECT fieldName alias; -- 给字段起别名省略AS

SELECT DISTINCT fieldName FROM tableName;-- 去除重复的值
SELECT TOP 10 * FROM tableName -- 返回前10个
```

