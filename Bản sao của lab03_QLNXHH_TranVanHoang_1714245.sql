/*Học phần: Cơ sở dữ liệu
	Người thực hiện: Trần Văn Hoàng
	MSSV: 1714245
	Ngày:20/3/2019
*/
------------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU------------
CREATE database lab03_QLNXHH
go
use	lab03_QLNXHH
go
-------lenh tao cac bang----------
create table HANGHOA
(
	MAHH	varchar(5)	primary key,
	TENHH	varchar(40)	not null unique,
	DVT	nchar(4)	not null,
	SOLUONGTON	tinyint)
	--drop table HANGHOA
create table DOITAC
(
	MADT	char(5)	primary key,
	TENDT	nvarchar(30)	not null,
	DIACHI	nvarchar(50)	not null,
	DIENTHOAI	char(10)	not null)
	--drop table DOITAC
create table HOADON
(
	SOHD	char(5)	primary key,
	NGAYLABPHD	Datetime,
	MADT	char(5)	references	DOITAC(MADT),
	TONGTG	smallint)
--drop table HOADON
create table KHANANGCC
(
	MADT	char(5)	references	DOITAC(MADT),
	MAHH	varchar(5)	references	HANGHOA(MAHH),
	primary key(MADT,MAHH))
	--drop table KHANANGCC
create table CT_HOADON
(
	SOHD	char(5)	references	HOADON(SOHD),
	MAHH	varchar(5)	references	HANGHOA(MAHH),
	DONGIA	smallint,
	SOLUONG	smallint	check(SOLUONG	between	1	and	10),
	primary	key(SOHD, MAHH,DONGIA))
	
/*drop table CT_HOADON
drop table HANGHOA
drop table DOITAC
drop table HOADON
drop table KHANANGCC
drop table CT_HOADON*/
------------NHẬP DỮ LIỆU CHO CÁC BẢNG---------------
----Nhập dữ liệu cho bảng HANGHOA-----------
insert	into	HANGHOA	values('CPU01','CPU INTEL,CELERON 600 BOX','CÁI',5)
insert	into	HANGHOA	values('CPU02','CPU INTEL,PHI 700','CÁI',10)
insert	into	HANGHOA	values('CPU03','CPU AMD K7 ATHL,ON 600','CÁI',8)
insert	into	HANGHOA	values('HDD01','HDD 10.2 GB QUANTUM','CÁI',10)
insert	into	HANGHOA	values('HDD02','HDD 13.6 GB SEAGATE','CÁI',15)
insert	into	HANGHOA values('HDD03','HDD 20 GB QUANTUM','CÁI',6)
insert	into	HANGHOA	values('KB01','KS GENIUS','CÁI',12)
insert	into	HANGHOA	values('KB02','KB MITSUMIMI','CÁI',5)
insert	into	HANGHOA	values('MB01','GIGABYTEC CHIPSET VIA','CÁI',10)
insert	into	HANGHOA	values('MB02','ACOPR BX CHIPSET VIA','CÁI',10)
insert	into	HANGHOA	values('MB03','INTEL PHI CHIPSET INTEL','CÁI',10)
insert	into	HANGHOA	values('MB04','ECS CHIPSET SIS','CÁI',10)
insert	into	HANGHOA	values('MB05','ECS CHIPSET VIA','CÁI',10)
insert	into	HANGHOA	values('MNT01','SAMSUNG 14" SYNCMASTER','CÁI',5)
insert	into	HANGHOA	values('MNT02','LG 14"','CÁI',5)
insert	into	HANGHOA	values('MNT03','ACER 14"','CÁI',8)
insert	into	HANGHOA	values('MNT04','PHILIPS 14"','CÁI',6)
insert	into	HANGHOA	values('MNT05','VIEWSONIC 14"','CÁI',7)
---xem bảng HANGHOA
select * from HANGHOA
---Nhap dữ liệu bảng DOITAC
insert	into	DOITAC	values('CC001','Cty TNC','176 BTX Q1 - TP.HCM','08.8250259')
insert	into	DOITAC	values('CC002',N'Cty Hoàng Long','15A TT Q1 - TP.HCM','08.8250898')
insert	into	DOITAC	values('CC003',N'Cty Hợp Nhất','152 BTX Q1 - TP.HCM','08.8252376')
insert	into	DOITAC	values('K0001',N'Nguyễn Minh Hải',N'91 Nguyễn Văn Trỗi Tp. Đà Lạt','063.831129')
insert	into	DOITAC	values('K0002',N'Như Quỳnh',N'21 Điện Biên Phủ. N.Trang','058590270')
insert	into	DOITAC	values('K0003',N'Trần Nhật Duật',N'Lê Lợi TP. Huế','054.848376')
insert	into	DOITAC	values('K0004',N'Phan Nguyễn Hùng Anh',N'11 Nam Kỳ Khởi Nghĩa- TP. Đà Lạt','063.823409')
---xem bảng DOITAC
select * from DOITAC
---Nhap dữ liệu bảng HOADON
set dateformat dmy
go
insert	into	HOADON	values('N0001','25/01/2006','CC001',NULL)
insert	into	HOADON	values('N0002','01/05/2006','CC002',NULL)
insert	into	HOADON	values('X0001','12/05/2006','K0001',NULL)
insert	into	HOADON	values('X0002','16/06/2006','K0002',NULL)
insert	into	HOADON	values('X0003','20/04/2006','K0001',NULL)
--Xem bảng HOADON
select * from HOADON
--Nhập dữ liệu KHANANGCC
insert	into	KHANANGCC	values('CC001','CPU01')
insert	into	KHANANGCC	values('CC001','HDD03')
insert	into	KHANANGCC	values('CC001','KB01')
insert	into	KHANANGCC	values('CC001','MB02')
insert	into	KHANANGCC	values('CC001','MB04')
insert	into	KHANANGCC	values('CC001','MNT01')
insert	into	KHANANGCC	values('CC002','CPU01')
insert	into	KHANANGCC	values('CC002','CPU02')
insert	into	KHANANGCC	values('CC002','CPU03')
insert	into	KHANANGCC	values('CC002','KB02')
insert	into	KHANANGCC	values('CC002','MB01')
insert	into	KHANANGCC	values('CC002','MB05')
insert	into	KHANANGCC	values('CC002','MNT03')
insert	into	KHANANGCC	values('CC003','HDD01')
insert	into	KHANANGCC	values('CC003','HDD02')
insert	into	KHANANGCC	values('CC003','HDD03')
insert	into	KHANANGCC	values('CC003','MB03')
--Xem bảng KHANANGCC
select * from KHANANGCC
--Nhập dữ liệu bảng CT_HOADON
insert	into	CT_HOADON	values('N0001','CPU01',63,10)
insert	into	CT_HOADON	values('N0001','HDD03',97,7)
insert	into	CT_HOADON	values('N0001','KB01',3,5)
insert	into	CT_HOADON	values('N0001','MB02',57,5)
insert	into	CT_HOADON	values('N0001','MNT01',112,3)
insert	into	CT_HOADON	values('N0002','CPU02',115,3)
insert	into	CT_HOADON	values('N0002','KB02',5,7)
insert	into	CT_HOADON	values('N0002','MNT03',111,5)
insert	into	CT_HOADON	values('X0001','CPU01',67,2)
insert	into	CT_HOADON	values('X0001','HDD03',100,2)
insert	into	CT_HOADON	values('X0001','KB01',5,2)
insert	into	CT_HOADON	values('X0001','MB02',62,1)
insert	into	CT_HOADON	values('X0002','CPU01',67,1)
insert	into	CT_HOADON	values('X0002','KB02',7,3)
insert	into	CT_HOADON	values('X0002','MNT01',115,2)
insert	into	CT_HOADON	values('X0003','CPU01',67,1)
insert	into	CT_HOADON	values('X0003','MNT03',115,2)
--Xem bảng CT_HOADON
select * from CT_HOADON
--------------------------------------------
select * from	HANGHOA
select * from	DOITAC
select * from	KHANANGCC
select * from	HOADON
select * from	CT_HOADON
--------------------------
--------------TRUY VAN DU LIEU----------------------
--cau 1: Liệt kê các mặt hàng thuộc loại đĩa cứng.
select	*
from	HANGHOA A
where	A.MAHH LIKE 'HDD0_'
--cau 2: liệt kê các mặt hàng có số lượng tồn trên 10
select	*
from	HANGHOA
where	SOLUONGTON>10
--cau 3: Cho biết thông tin về các nhà cung cấp ở Thành phố hồ Chí Minh
select	*
from	DOITAC
where	DIACHI LIKE	'%TP.HCM'
--cau 4: Liệt kê các hóa đơn nhập hàng trong tháng 5/2006, thông tin hiển thị gồm: sohd;ngaylaphd; ten, diachi, va dien thoai cua nhà cung cấp; số mặt hàng
select	A.SOHD, convert(char(10),NGAYLABPHD,103),TENDT,DIACHI,DIENTHOAI, count(C.MAHH) AS SOMATHANG
from	HOADON A,DOITAC B, KHANANGCC C,CT_HOADON D
where	month(NGAYLABPHD)='05' and D.SOHD=A.SOHD and D.MAHH=C.MAHH and C.MADT=B.MADT
group by	A.SOHD, convert(char(10),NGAYLABPHD,103),TENDT,DIACHI,DIENTHOAI

--cau 5: Cho biết tên các nhà cung cấp có cung cấp đĩa cứng
select	TENDT, TENHH
from	DOITAC A, HANGHOA B, KHANANGCC C
where	B.MAHH LIKE 'HDD0_' and C.MADT=A.MADT and C.MAHH=B.MAHH

--cau 6: Cho biết tên các nhà cung cấp có thể cung cấp tất cả các loại đĩa cứng
select	TENDT
from	DOITAC A, HANGHOA B, KHANANGCC C
where	C.MADT=A.MADT and C.MAHH=B.MAHH and C.MAHH LIKE 'HDD0_'
group by	TENDT
having COUNT(C.MaHH) = (select COUNT(maHH)
						from HANGHOA
						where MAHH like'HDD%')
-- nhà cung cấp có thể cung cấp bao nhiêu đĩa cứng so sánh với số đĩa cứng trong kho

--cau 7: Cho biết tên nhà cung cấp không cung cấp đĩa cứng
select	 TENDT AS DTKHONGCCDIACUNG
from	DOITAC A, KHANANGCC B
where	A.MADT=B.MADT and B.MADT NOT IN(
										select	C.MADT
										from	KHANANGCC C
										where	C.MAHH LIKE 'HDD0_')
group by	A.MADT,TENDT
--cau 8: Cho biết thông tin của mặt hàng chưa bán được
select	A.MAHH
from	HANGHOA A
where	 A.MAHH NOT IN (select distinct	C.MAHH
										from	CT_HOADON C)
--cau 9: Cho biết tên và tổng số lượng bán của mặt hàng bán chạy nhất(tính theo số lương)
select	A.MAHH, TENHH, sum(SOLUONG) AS TONGSOLUONGBAN
from	CT_HOADON A, HANGHOA B
where	A.MAHH=B.MAHH
group by A.MAHH, TENHH
having sum(SOLUONG)>=all(select	sum(SOLUONG)
							from	CT_HOADON C
							group by	MAHH)
--cau 10: Cho biết tên và tổng số lượng của mặt hàng nhập về ít nhất
select	TENHH, count(SOLUONG) AS TONGSOLUONGMIN
from	CT_HOADON A, HANGHOA B
where	A.MAHH=B.MAHH
group by	TENHH
having	sum(SOLUONG)<=all(select	sum(SOLUONG)
							from	CT_HOADON
							group by	MAHH)

--cau 11: Cho biết hóa đơn nhập nhiều mặt hàng nhất
select	SOHD,count(MAHH) AS SOLUONGHANGHOA
from	CT_HOADON A
group by	SOHD
having	count(A.MAHH)>=all(select	count(MAHH)
						from	CT_HOADON
						group by	SOHD)
--cau 12: Cho biết các mặt hàng không được nhập hàng trong tháng 1/2006
select	TENHH
from	HOADON A, CT_HOADON B, HANGHOA C
where	B.SOHD=A.SOHD and B.MAHH=C.MAHH and C.MAHH NOT IN
												(select	D.MAHH
												from	CT_HOADON D, HOADON E
												where	D.SOHD=E.SOHD  and month(NGAYLABPHD)='01')
group by	TENHH
--cau 13: Cho biết tên các mặt hàng không bán được trong tháng 6/2006
select	C.MAHH,TENHH
from	 HANGHOA C
where	 C.MAHH NOT IN(select	distinct	E.MAHH
						from	CT_HOADON E, HANGHOA F, HOADON H
						where	F.MAHH=E.MAHH and E.SOHD=H.SOHD and month(NGAYLABPHD)='06')	
group by	C.MAHH,TENHH

--cau 14: Cho biết cửa hàng bán bao nhiêu mặt hàng
select	count(MAHH) AS SOMATHANG
from	HANGHOA

--cau 15: Cho biết số mặt hàng mà từng nhà cung cấp có khả năng cung cấp
select	A.MADT, TENDT,count(A.MAHH) AS SOMATHANG
from	KHANANGCC A, HANGHOA B,DOITAC C
where	A.MADT=C.MADT and A.MAHH=B.MAHH 
group by	A.MADT, TENDT

--cau 16: Cho biết thông tin của khách hàng có giao dịch với cửa hàng nhiều nhất
select	C.MADT, TENDT
from	DOITAC A, HOADON C
where	C.MADT=A.MADT and c.MADT LIKE 'K%'
group by	C.MADT, TENDT
having	 count(C.MADT) >=all(select	count(D.MADT)
							from	HOADON D
							group by	MADT)

-- cau 17: Tính tổng doanh thu năm 2006
select	sum(DONGIA*SOLUONG) AS TONGDOANHTHU
from	CT_HOADON
--cau 18: Cho biết loại mặt hàng bán chạy nhất
select	B.MAHH, TENHH, sum(SOLUONG) AS SOLUONGBAN
from	HANGHOA A, CT_HOADON B
where	B.MAHH=A.MAHH
group by	B.MAHH, TENHH
having	sum(SOLUONG)>=all(select	sum(SOLUONG)
							from	CT_HOADON
							group by	MAHH)

--cau 19: Liệt kê thông tin bán hàng của tháng 5/2006 bao gồm: mahh, tenhh, dvt, tong so luong, tong thanh tien
select	C.MAHH, TENHH, DVT, sum(SOLUONG) AS TONGSOLUONG, sum(SOLUONG*DONGIA) AS TONGTHANHTIEN
from	HANGHOA A, HOADON B, CT_HOADON C
where	C.MAHH=A.MAHH and C.SOHD=B.SOHD and month(NGAYLABPHD)='05'
group by	C.MAHH, TENHH, DVT

--cau 20: Liệt kê thông tin của mặt hàng có nhiều người mua nhất
select	B.MAHH, count(SOHD) AS SONGUOIMUA
from	HANGHOA A, CT_HOADON B
where	B.MAHH=A.MAHH 
group by	B.MAHH
having	count(SOHD)>=all(select	count(SOHD)
						from	CT_HOADON C
						group by	C.MAHH)

--cau 21: Tinh va cap nhat tong gia tri cua cac hoa don

update HOADON
set	TONGTG=(select	sum(DONGIA*SOLUONG)
			from	CT_HOADON B
			where	HOADON.SOHD =  B.SOHD)

select * from HOADON

------------------?