use MyDB
go
/*=============�޸�Լ��==================*/
--����Լ�������Լ�����롾��������ӱ���

alter table PersonInformation with nocheck --with nocheck�Ա����Ѵ��ڵ����ݲ������
	drop constraint DF_PersonAdress,
		 constraint FK_EventID
	
alter table EventInformation with nocheck
	drop constraint UQ_EventMark 

alter table EventInformation --�޸ı����Լ�� ���﷨��Լ���� Լ������ ��
		add constraint UQ_EventMark2 unique(EventMark)

