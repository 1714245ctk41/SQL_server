/*Học phần: Cơ sở dữ liệu
	Người thực hiện: Trần Văn Hoàng
	MSSV: 1714245
	Ngày: 22/3/1997
	*/
------------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU-------
create database	lab04_QLDB
go
use lab04_QLDB
go
-------Lenh tao cac bang-----------
create table BAO_TCHI
(
	MA_BAO_TC	char(4)	primary key,
	TEN			nvarchar(30)	not null,
	DINHKY		nvarchar(20)	not null,
	SOLUONG		int,
	GIABAN		int)

create table PHATHANH_BAO
(
	MA_BAO_TC	char(4)	references	BAO_TCHI(MA_BAO_TC),
	SO_BAO_TC	int	primary key ,
	NGAY_PH		Datetime)

create table KH_HANG
(
	MAKH	char(4)	primary key,
	TENKH	nvarchar(10)	not null unique,
	DC_KH	nvarchar(10)	not null)

create table DATBAO
(
	MAKH	char(4)	references	KH_HANG(MAKH),
	MA_BAO_TC	char(4)	references	BAO_TCHI(MA_BAO_TC),
	SL_MUA	int ,
	NGAY_DM	datetime,
	primary key(MAKH,MA_BAO_TC))

	/*drop table BAO_TCHI
	drop table PHATHANH_BAO
	drop table KH_HANG
	drop table DATBAO*/

-------	nhập dữ liệu cho bảng------------
------nhập dữ liệu cho bảng BAO_TCHI----------
insert	into	BAO_TCHI	values('TT01',N'Tuổi trẻ', N'Nhật ký',1000,1500)
insert	into	BAO_TCHI	values('KT01',N'Kiến thức ngày nay',N'Bán nguyệt san',3000,6000)
insert	into	BAO_TCHI	values('TN01',N'Thanh niên',N'Nhật báo',1000,2000)
insert	into	BAO_TCHI	values('PN01',N'Phụ nữ',N'Tuần báo',2000,4000)
insert	into	BAO_TCHI	values('PN02',N'Phụ nữ',N'Nhật báo',1000,2000)
--xem dữ liệu BAO_TCHI
select * from BAO_TCHI

-----Nhập dữ liệu bảng PHATHANH_BAO
set dateformat	dmy
go
insert	into	PHATHANH_BAO	values('TT01',123,'15/12/2005')
insert	into	PHATHANH_BAO	values('KT01',70,'15/12/2005')
insert	into	PHATHANH_BAO	values('TT01',124,'16/12/2005')
insert	into	PHATHANH_BAO	values('TN01',256,'17/12/2005')
insert	into	PHATHANH_BAO	values('PN01',45,'23/12/2005')
insert	into	PHATHANH_BAO	values('PN02',111,'18/12/2005')
insert	into	PHATHANH_BAO	values('PN02',112,'19/12/2005')
insert	into	PHATHANH_BAO	values('TT01',125,'17/12/2005')
insert	into	PHATHANH_BAO	values('PN01',46,'30/12/2005')
-----xem bảng PHATHANH_BAO
select * from PHATHANH_BAO

---------Nhập dữ liệu bảng KH_HANG
insert	into	KH_HANG		values('KH01','LAN','2 NCT')
insert	into	KH_HANG		values('KH02','NAM',N'32 THĐ')
insert	into	KH_HANG		values('KH03',N'NGỌC','16 LHP')
----xem bảng KH_HANG
select * from KH_HANG

--------nhập dữ liệu bảng DATBAO
set dateformat dmy
go
insert	into	DATBAO	values('KH01','TT01',100,'12/01/2000')
insert	into	DATBAO	values('KH02','TN01',150,'01/05/2001')
insert	into	DATBAO	values('KH01','PN01',200,'25/06/2001')
insert	into	DATBAO	values('KH03','KT01',50,'17/03/2002')
insert	into	DATBAO	values('KH03','PN02',200,'26/08/2003')
insert	into	DATBAO	values('KH02','TT01',250,'15/01/2004')
insert	into	DATBAO	values('KH01','KT01',300,'14/10/2004')
--------xem bảng DATBAO
select* from DATBAO
-------------------------------
-----------------TRUY VẤN DỮ LIỆU---------------
--cau 1: Cho biết các tờ báo, tạp chí(MABAOTC, TEN, GIABAN) có định kỳ phát hành hàng tuần (Tuần báo).
select	MA_BAO_TC, TEN, GIABAN
from	BAO_TCHI
where	DINHKY=N'Tuần báo'

--cau 2: Cho biết thông tin về các tờ báo thuộc loại báo phụ nữ ( mã báo tạp chí bắt đầu bằng PN).
select	A.*
from	BAO_TCHI A
where	MA_BAO_TC LIKE 'PN__'
--cau 3: Cho biết tên các khách hàng có đặt mua báo phụ nữ (mã báo tạp chí bắt đầu bằng PN), không liệt kê khách hàng trùng.
select	distinct A.MAKH, A.TENKH
from	KH_HANG A, DATBAO B
where	B.MAKH=A.MAKH  and B.MA_BAO_TC LIKE 'PN%'

--cau 4: Cho biết tên các khách hàng có đặt mua tất cả báo phụ nữ( mã báo tạp chí bắt đầu bằng PN)
select	A.MAKH,TENKH
from	KH_HANG A, DATBAO B
where	B.MAKH=A.MAKH and B.MA_BAO_TC LIKE 'PN%'
group by	A.MAKH,TENKH
having	count(B.MA_BAO_TC)= (select	COUNT(MA_BAO_TC)
									from	BAO_TCHI
									where	MA_BAO_TC='PN%')
					--????
									
--cạu 5: Cho biết các khách hàng không đặt mua báo thanh niên
select	A.MAKH, TENKH, DC_KH
from	DATBAO A, KH_HANG B
where	A.MAKH=B.MAKH and B.MAKH NOT IN (	select	C.MAKH
												from	DATBAO C
												where	C.MA_BAO_TC LIKE 'TN%')
group by	A.MAKH, TENKH, DC_KH
--cau 6: Cho biết số tờ báo mà mỗi khách hàng đã đặt mua
select	A.MAKH,sum(SL_MUA) AS SOTOBAO
from	DATBAO A, KH_HANG B
where	A.MAKH=B.MAKH
group by	A.MAKH

--cau 7: Cho biết số khách hàng đặt mua báo trong năm 2004
select	count(A.MAKH) AS SOKHACHHANG_2004
from	DATBAO A
where	year(NGAY_DM)='2004'

--cau 8: Cho biết thông tin đặt mua báo của các khách hàng (TENKH, TEN, DINH_KY, SL_MUA, SOTIEN)
--trong đó SOTIEN=SL_MUA*DONGIA.
select	TENKH,TEN,DINHKY,SL_MUA, SL_MUA*GIABAN AS SOTIEN
from	DATBAO A, BAO_TCHI B,KH_HANG C
where	A.MA_BAO_TC=B.MA_BAO_TC and A.MAKH=C.MAKH

--cau 9:Cho biết các tờ báo, tập chí (TEN, DINHKY) và tổng số lượng đặt mua của các khách
--hàng đối với tờ báo, tạp chí đó.
select	TEN, DINHKY, SUM(SL_MUA)
from	DATBAO A, BAO_TCHI B
where	A.MA_BAO_TC=B.MA_BAO_TC
group by	TEN, DINHKY

--cau 10: Cho biết tên các tờ báo dành cho học sinh, sinh viên( mã báo tạp chí bắt đầu bằn HS).
select	TEN
from	BAO_TCHI
where	MA_BAO_TC LIKE 'TT%'

--cau 11: Cho biết những tờ báo không có người đặt mua.
select	B.MA_BAO_TC,TEN
from	DATBAO A,BAO_TCHI B
where	A.MA_BAO_TC=B.MA_BAO_TC and A.MA_BAO_TC NOT IN (select	C.MA_BAO_TC
														from	DATBAO C
														group by	C.MA_BAO_TC)
GROUP by		B.MA_BAO_TC,TEN

--cau 12: Cho biết tên, định kỳ của những tờ báo có nhiue62 người đặt mua nhất.
select	TEN, DINHKY
from	BAO_TCHI A, DATBAO B
where	B.MA_BAO_TC=A.MA_BAO_TC
group by	TEN, DINHKY
having COUNT(B.MA_BAO_TC) >=all (select	count(C.MA_BAO_TC)
								from	DATBAO C
								group by	C.MA_BAO_TC)

--cau 13: Cho biết khách hàng đặt mua nhiều báo, tạp chí nhất.
select	B.MAKH,TENKH, DC_KH, COUNT(SL_MUA) AS SL
from	DATBAO A,KH_HANG B
where	A.MAKH=B.MAKH
group by	B.MAKH,TENKH, DC_KH
having	COUNT(SL_MUA)>= all (select	count(SL_MUA)
						from	DATBAO C
						group by	C.MAKH)

--cau 14: Cho biết các tờ báo phát hành định kỳ một tháng 2 lần.
select	B.MA_BAO_TC, TEN, DINHKY,GIABAN
from	PHATHANH_BAO A, BAO_TCHI B
where	A.MA_BAO_TC=B.MA_BAO_TC and DINHKY=N'Bán nguyệt san'
group by	B.MA_BAO_TC, TEN, DINHKY,GIABAN


--cau 15: Cho biết các tờ báo, tạp chí có từ 3 khách hàng đặt mua trở lên.
select	B.MA_BAO_TC, TEN,DINHKY,SOLUONG,GIABAN
from	BAO_TCHI A, DATBAO B
where	B.MA_BAO_TC=A.MA_BAO_TC
group by	B.MA_BAO_TC, TEN,DINHKY,SOLUONG,GIABAN
having	COUNT(B.MAKH)>=3