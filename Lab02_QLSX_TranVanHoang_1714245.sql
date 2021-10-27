/*Học phần: Cơ sở dữ liệu
	Người thực hiện: Trần Văn Hoàng
	MSSV: 1714245
	Ngày:18/3/2019
*/
---------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------
CREATE DATABASE lab02_QLSX
go
use lab02_QLSX
go
--lenh tao cac bang--
create table SanPham
(
	MASP	char(5) primary key,
	TenSP	nvarchar(30) not null unique,
	DVT	nvarchar(15) not null,
	TienCong	int not null
)
--drop table SanPham
create	table	ToSanXuat
(
	MaTSX	char(4)	primary key,
	TenTSX	nvarchar(15)	not null unique
)
create	table	CongNhan
(
	MACN	char(5)	primary key,
	Ho	nvarchar(30)	not null,
	Ten	nvarchar(10)	not null,
	Phai	nvarchar(5)	not null,
	NgaySinh	Datetime,
	MaTSX	char(4)	references	ToSanXuat(MaTSX)
)
create	table	ThanhPham
(
	MACN	char(5)	references	CongNhan(MACN),
	MASP	char(5)	references	SanPham(MASP),
	Ngay	Datetime	not null,
	SoLuong	smallint	not null check(SoLuong>0),
	primary key(MACN, MASP,Ngay))--drop table ThanhPham
-----Nhap du lieu cho cac bang-----
--Nhap bang SanPham
insert	into	SanPham	values('SP001',N'Nồi đất',N'Cái',10000)
insert	into	SanPham	values('SP002',N'Chén',N'Cái',2000)
insert	into	SanPham	values('SP003',N'Bình gốm nhỏ',N'Cái',20000)
insert	into	SanPham	values('SP004',N'Bình gốm lớn',N'Cái',25000)
--Xem bang SanPham--delete from SanPham
select * from SanPham
--Nhap bang ToSanXuat
insert	into	ToSanXuat	values('TS01',N'Tổ 1')
insert	into	ToSanXuat	values('TS02',N'Tổ 2')
--Xem bang ToSanXuat
select * from ToSanXuat
--Nhap ban CongNhan
set dateformat dmy
go
insert	into	CongNhan	values('CN001',N'Nguyễn Trường',N'An','Nam','12/05/1981','TS01')
insert	into	CongNhan	values('CN002',N'Lê Thị Hồng',N'Gấm',N'Nữ','04/06/1980','TS01')
insert	into	CongNhan	values('CN003',N'Nguyễn Công',N'Thành','Nam','04/05/1981','TS02')
insert	into	CongNhan	values('CN004',N'Võ Hữu',N'Hạnh','Nam','15/02/1980','TS02')
insert	into	CongNhan	values('CN005',N'Lý Thành',N'Hân',N'Nữ','03/12/1981','TS01')
--Xem bang CongNhan
select * from CongNhan
--delete from CongNhan
--Nhap ban ThanhPham
set dateformat dmy
go
insert	into	ThanhPham	values('CN001','SP001','01/02/2007',10)
insert	into	ThanhPham	values('CN002','SP001','01/02/2007',5)
insert	into	ThanhPham	values('CN003','SP002','10/01/2007',50)
insert	into	ThanhPham	values('CN004','SP003','12/01/2007',10)
insert	into	ThanhPham	values('CN005','SP002','12/01/2007',100)
insert	into	ThanhPham	values('CN002','SP004','13/02/2007',10)
insert	into	ThanhPham	values('CN001','SP003','14/02/2007',15)
insert	into	ThanhPham	values('CN003','SP001','15/01/2007',20)
insert	into	ThanhPham	values('CN003','SP004','14/02/2007',15)
insert	into	ThanhPham	values('CN004','SP002','30/01/2007',100)
insert	into	ThanhPham	values('CN005','SP003','01/02/2007',50)
insert	into	ThanhPham	values('CN001','SP001','20/02/2007',30)
--Xem bang ThanhPham
select * from ThanhPham
--delete from ThanhPham
---------------------------------
select * from SanPham
select * from ToSanXuat
select * from CongNhan
select * from	ThanhPham
--------------------
-----------------------TRUY VAN DU LIEU-------------------
--cau 1: Liệt kê các công nhân theo tổ sản xuất gồm các thông tin: TenTSX, HoTen,NgaySinh, Phai(xếp thứ tự tăng dần cửa tên tổ sản xuất, Tên của công nhân).
select	TenTSX, Ho+' '+Ten AS HoTen, NgaySinh, Phai
from	CongNhan A,ToSanXuat D
where	A.MaTSX=D.MaTSX 
order by	TenTSX, Ten asc
--cau 2: Liệt kê các thành phẩm mà công nhân 'Nguyễn Trường An' đã làm được gồm các thông tin: TenSP, Ngay, SoLuong, ThanhTien(xếp theo thứ tự tăng dần của ngày)
select	TenSP, Ngay, SoLuong,TienCong*SoLuong AS ThanhTien
from	CongNhan A, ThanhPham B, SanPham C
where	A.MACN=B.MACN and C.MASP=B.MASP and A.Ho=N'Nguyễn Trường' and A.Ten='An'
		
order by	Ngay asc
--cau 3:Liệt kê các nhân viên không sản xuất sản phẩm 'Bình gốm lớn'
select	Ho + ' ' + Ten as HoTen
from	CongNhan where MACN NOT IN(
						select	E.MACN
						from	SanPham D, ThanhPham E
						where	E.MASP=D.MASP and TenSP=N'Bình gốm lớn'
	)
--cau 4: Liệt kê thông tin các công nhân có sản xuất cả 'Nồi đất' và 'Bình gốm nhỏ'.
select	A.*
from	CongNhan A,SanPham B, ThanhPham C
where	A.MACN=C.MACN and B.MASP=C.MASP and TenSP='Nồi đất'
	and A.MACN IN(
				select	F.MACN
				from	SanPham E, ThanhPham F
				where	E.MASP=F.MASP and TenSP='Bình gốm nhỏ'
	)
--cau 5: Thống kê số lương công nhân theo từng tổ sản xuất
select	TenTSX, count(MACN) AS SoluongCN
from	ToSanXuat A, CongNhan B
where	B.MaTSX = A.MaTSX
group by	TenTSX
--cau 6: Tổng số lượng thành phẩm theo từng loại mà mỗi nhân viên làm được(Họ, Tên, TenSP, TongSLThanhPham, TongThanhTien)
select	Ho, Ten, TenSP, sum(SoLuong) AS TongSLThanhPham, SUM(TienCong*SoLuong) AS TongThanhTien
from	CongNhan A, SanPham B, ThanhPham C
where	C.MACN=A.MACN and C.MASP=B.MASP
GROUP by	Ho, Ten, TenSP
--cau 7: Tổng số tiền công đã trả cho công nhân trong tháng 1 năm 2007
select	 sum(TienCong*SoLuong) AS Tongtiencong
from	ThanhPham A, SanPham B
where	A.MASP=B.MASP and MONTH(Ngay)='01'
GROUP by	month(Ngay)------------------------------------
--cau 8: Cho biết sản phẩm được sản xuất nhiều nhất trong tháng 2/2007
select	TenSP,sum(SoLuong) AS SoLuongTP
from	SanPham A, ThanhPham B
where	A.MASP=B.MASP and MONTH(Ngay)='02'
GROUp by	TenSP
having COUNT(B.MASP)>=all(select	COUNT(C.MASP)
						from	ThanhPham C
						group by	C.SoLuong)
--cau 9: Ch obiet61 công nhân sản xuất được nhiều 'Chén' nhất
select	A.MACN,sum(SoLuong) AS SoLuongChen
from	CongNhan A, SanPham B, ThanhPham C
where	C.MACN=A.MACN and C.MASP=B.MASP and TenSP='Chén'
GROUP by	A.MACN
having sum(SoLuong)>=all(select	sum(SoLuong)
							from	ThanhPham D,SanPham E
							where	D.MASP=E.MASP and TenSP='Chén'
							group by	D.MACN)----------------
--cau 10: Tien cong thang 2/2006 cảu công nhân viên có mã số 'CN002'
select	A.MACN,sum(TienCong*SoLuong) AS Luong
from	ThanhPham A,SanPham B
where	A.MASP=B.MASP and A.MACN='CN002' and MONTH(Ngay)='02'
group by	A.MACN
--cau 11: Liệt kê các công nhân có sản xuất từ 3 loại sản phẩm trở lên
select	A.MACN, Ho+' '+Ten AS HoTen, COUNT(B.MASP) AS SP
from	CongNhan A, ThanhPham B
where	B.MACN=A.MACN 
GROUP by	A.MACN,Ho,Ten
having count(DISTINCT B.MASP)>=3

--cau 12: Cập nhật giá tiên công của các loại bình gốm them 1000
update	SanPham
set		TienCong=TienCong+1000
where	TenSP LIKE N'Bình gốm %'

select * from SanPham
