use MyDB
/*===================���¼�¼=======================*/
--UPDATE ������ڸ��±����Ѵ��ڵļ�¼��
--���ʡ����WHERE �Ӿ�,��������е�����
--�޷�����[��ʶ��],���µ�������Ҫ���ϸ��е�[Լ������]
update BuyersList set  BuyerName = '��ǡ��ǡǡ��', Score = default where  BuyerID = 10001 and CommodityID = 1001


/*===================ɾ����¼=======================*/
--[��һ��:deleteɾ��]
--ɾ����¼��,��ʶ��Ż������������,��[����ӱ�ʶ���ӿ�ʼ����]
delete BuyersList where BuyerID = 10008
--ɾ����¼������ɾ���ӱ��й���������,��ɾ�������еĸü�¼
delete BuyersList where CommodityID = 1008
delete CommodityList where CommodityID = 1008
/*
insert into BuyersList2
values('qwe',1009,1,'2017-6-9')
*/ 
--[�ڶ���:truncate table �ض�ɾ��]
--ɾ����¼��,��ʶ���[�ӱ�ʶ���ӿ�ʼ����]
--��ձ��¼,�൱��û��whereɸѡ��deleted table
--�޷��ضϴ������������õı�,�������������ӱ���ɾ��(�����ӱ���ռ�¼Ҳ����,������ɾ��)
drop table BuyersList --��ɾ���ӱ�
--truncate table BuyersList3
truncate table CommodityList

go

--select * from BuyersList

select * from BuyersList3

select * from CommodityList












