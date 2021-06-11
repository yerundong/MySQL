/*====创建新的数据库，主、辅文件组，主、辅、日志文件====*/
use master --指向master数据库
if exists(select * from sysdatabases where name= 'MyDB') --判断是否该数据库已存在
drop database MyDB --已存在则进行删除
go --批处理标志
create database MyDB --创建名为MyDB的数据库，默认创建primary组和一个主文件（名与数据库名同：MyDB），和一个日志文件（MyDB_log）
on primary --创建主文件组primary(固定的)，至少创建一个主文件，不可为空组
	--主文件1信息
(
	name = 'MyDB_data1', --主文件逻辑文件名【必填】（逻辑文件名与物理文件名最好一样，以免混乱）
	filename = "D:\数据库\MyDB\MyDB_data1.mdf", --主文件物理文件名（地址）【必填】
	size = 10mb, --主文件初始大小【必填】
	maxsize = 500mb, --主文件增长的最大值（默认为不限制）【选填】
	filegrowth = 15% --主文件增长率（默认为1mb）【选填】
), --主文件组结束
filegroup FG --创建辅文件组FG（可自定义），至少创建一个辅文件，不可为空组
	--辅文件1信息
(
	name = 'MyDB_data_fg1', --辅文件逻辑文件名
	filename = "D:\数据库\MyDB\MyDB_data_fg1.ldf",--辅文件物理文件名（地址）
	size = 10mb, --辅文件初始大小
	maxsize = 500mb, --辅文件增长的最大值（若未启用自增长，则无意义）
	filegrowth = 0 --未启用增长率（所以也可不用设置文件最大值maxsize）
),
	--辅文件2信息
(
	name = 'MyDB_data_fg2',
	filename = "D:\数据库\MyDB\MyDB_data_fg2.ldf",
	size = 10mb, 
	filegrowth = 0
),
filegroup FT --创建辅文件组FT（可自定义），至少创建一个辅文件，不可为空组
	--辅文件3信息
(
	name = 'MyDB_data_ft1',
	filename = "D:\数据库\MyDB\MyDB_data_ft1.ldf",
	size = 10mb, 
	filegrowth = 0
)

log on --日志文件(日志文件不属于任何文件组)
	--日志1信息
(
	name = "MyDB_log1", --日志文件逻辑文件名
	filename = "D:\数据库\log\MyDB_log1.ldf",--日志文件物理文件名（地址）
	size = 5mb, --日志文件初始大小
	filegrowth = 0 --日志文件增长率
),
	--日志2信息
(
	name = "MyDB_log2",
	filename = "D:\数据库\log\MyDB_log2.ldf",
	size = 5mb,
	filegrowth = 0 
)	
go

select * from sysdatabases --从master库中的系统表sysdatabases中可以查到已创建的数据库MyDB的信息