/*===============������¼��=============*/
use master --ָ��master���ݿ�
create login "Ҷ��ү3" with password = '123' --��������¼��������������
go
use master --ָ��master���ݿ�
drop login "Ҷ��ү3" --��ɾ����¼����������ɾ���û�
go

/*=============�����ݿⴴ���û�===========*/
use MyDB --��MyDB�������û���
create user "Ҷ��ү_3" for login "Ҷ��ү3" --��MyDBӳ�䵽Ҷ��ү3��������Ϊ"Ҷ��ү_3"���û�
go
use MyDB --��MyDB��ɾ���û���
drop user "Ҷ��ү_3" --ɾ����Ϊ"Ҷ��ү_3"���û�
go

/*===============���û�����Ȩ��============*/
use MyDB --��MyDB���û�������Ȩ�ޡ�
grant select,insert,update on Table_1 to "Ҷ��ү_3" --����"Ҷ��ү_3"�û���Table_1��Ĳ�ѯ������͸��µ�Ȩ��
go
use MyDB --��MyDB���û�������Ȩ�ޡ�
revoke insert,update on Table_1 to "Ҷ��ү_3" --����"Ҷ��ү_3"�û���Table_1��Ĳ���͸��µ�Ȩ��

use master --ָ��master���ݿ�
select state_desc from sys.databases where name = 'MyDB'

