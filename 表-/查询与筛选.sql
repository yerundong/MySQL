use BCRM
select * from Activity_Plan --��ѯ������

--select Theme from Activity_Plan --��ѯTheme�����

--select Theme,Kind from Activity_Plan --��ѯTheme,Kind��

select distinct Theme,Kind from Activity_Plan --����Theme,Kind��Ψһ��ͬ��ֵ,����ظ���ֻ����һ����

select top 10 * from Activity_Plan --����ǰ10��

--��where����ɸѡ�����˼�¼��
select * from Activity_Plan where ID = 2 --��ѯID = 2����

--��or,and,between...and...��
select Theme,ID from Activity_Plan where ID >=2 and ID <=5 or ID>=28 --AND��OR��������ڻ���һ�����ϵ������Լ�¼���й��ˡ�

select Theme,ID from Activity_Plan where ID between 3 and 5 --����ֵ3<=id<=5֮�䣬ֵ���������֡��ı������ڡ���Ǯ

select Theme,ID from Activity_Plan where ID not between 3 and 5 --������3,5֮��

--��order by ������������Լ�¼��������
select * from Activity_Plan order by Month ASC --ASC����DESC����

--��likeģ����ѯ��
select * from Activity_Plan where Theme like '%����%'  --��ѯ����������У�%���0�����ַ�

select * from Activity_Plan where Theme not like '%��%' --��ѯ�������������  

--��ͨ�����
select * from Activity_Plan where Theme like '%��%'  --%���0�����ַ�

select * from Activity_Plan where Theme like '_��%'  --_���1���ַ�

select * from Activity_Plan where Theme like '���˽ڻ'  --��Theme = '���˽ڻ'һ��

--��inѡȡ�ض���ֵ��
select * from Activity_Plan where ID in(1,3,5,6,9,10) 



















