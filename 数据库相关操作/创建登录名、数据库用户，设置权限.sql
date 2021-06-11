/*===============创建登录名=============*/
use master --指向master数据库
create login "叶大爷3" with password = '123' --【创建登录名】，设置密码
go
use master --指向master数据库
drop login "叶大爷3" --【删除登录名】，但不删除用户
go

/*=============给数据库创建用户===========*/
use MyDB --给MyDB【创建用户】
create user "叶大爷_3" for login "叶大爷3" --将MyDB映射到叶大爷3，创建名为"叶大爷_3"的用户
go
use MyDB --给MyDB【删除用户】
drop user "叶大爷_3" --删除名为"叶大爷_3"的用户
go

/*===============对用户设置权限============*/
use MyDB --给MyDB的用户【授予权限】
grant select,insert,update on Table_1 to "叶大爷_3" --授予"叶大爷_3"用户对Table_1表的查询，插入和更新的权限
go
use MyDB --给MyDB的用户【撤回权限】
revoke insert,update on Table_1 to "叶大爷_3" --撤回"叶大爷_3"用户对Table_1表的插入和更新的权限

use master --指向master数据库
select state_desc from sys.databases where name = 'MyDB'

