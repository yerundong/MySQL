#《数运算符：+、-、*、/、%》

SELECT 1+2;

SELECT '1'+2;-- 先将两边转成数字，再运算

SELECT '1'+'2';-- 先将两边转成数字，再运算

SELECT 'tom'+2;-- 字符串无法转换成数字，如果转换失败，则默认转为0

SELECT 'tom'+'go';-- 0

SELECT LENGTH('tom')+2;

SELECT LENGTH(`first_name`)+2 FROM `employees`; 

SELECT 1/2;

SELECT 1%2;

#null与任何值运算结果都为null
SELECT NULL+2; 
SELECT NULL-2;
SELECT NULL/2;
SELECT NULL%2;
SELECT NULL%NULL;

#分母为0，结果为null
SELECT 1/0;