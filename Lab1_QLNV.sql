/* Học phần: Cơ sở dữ liệu
   Người thực hiện: ....
   MSSV: .....
   Ngày: .....
*/	
----------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU----------------
CREATE DATABASE lab1_QLNV
go
--lenh su dyng CSDL
use lab1_QLNV
go
--lenh tao cac bang
create table ChiNhanh
(MSCN	char(2) primary key,		 --khai bao MSCN la khoa chinh cua ChiNhanh
TenCN	nvarchar(30) not null unique --khai bao TenCN không được để trống và không được nhập trùng
)
go
create table KyNang
(MSKN	char(2) primary key,
TenKN	nvarchar(30) not null
)
go
create table NhanVien
(
MANV char(4) primary key,
Ho	nvarchar(20) not null,
Ten nvarchar(10)	not null,
Ngaysinh	datetime,
NgayVaoLam	datetime,
MSCN	char(2)	references ChiNhanh(MSCN)--khai báo MSCN là khóa ngoại của bảng NhanVien
)
go
create table NhanVienKyNang
(
MANV char(4) references NhanVien(MANV),
MSKN char(2) references KyNang(MSKN),
MucDo	tinyint check(MucDo between 1 and 9)--check(MucDo>=1 and MucDo<=1)
primary key(MANV,MSKN)--Khai báo NhanVienKyNang có khóa chính gồm 2 thuộc tính (MaNV, MSKN)

)
-------------NHAP DU LIEU CHO CAC BANG-----------
--Nhap du lieu cho cac bang
insert into ChiNhanh values('01',N'Quận 1')
insert into ChiNhanh values('02',N'Quận 5')
insert into ChiNhanh values('03',N'Bình thạnh')
--xem bảng Chi nhanh
select * from ChiNhanh
--Nhap bang Kynang
insert into KyNang values('01',N'Word')
insert into KyNang values('02',N'Excel')
insert into KyNang values('03',N'Access')
insert into KyNang values('04',N'Power Point')
insert into KyNang values('05','SPSS')
--xem bảng KyNang
select * from KyNang
--Nhap bang NhanVien
set dateformat dmy
go
insert into NhanVien values('0001',N'Lê Văn',N'Minh','10/06/1960','02/05/1986','01')
insert into NhanVien values('0002',N'Nguyễn Thị',N'Mai','20/04/1970','04/07/2001','01')
insert into NhanVien values('0003',N'Lê Anh',N'Tuấn','25/06/1975','01/09/1982','02')
insert into NhanVien values('0004',N'Vương Tuấn',N'Vũ','25/03/1975','12/01/1986','02')
insert into NhanVien values('0005',N'Lý Anh',N'Hân','01/12/1980','15/05/2004','02')
insert into NhanVien values('0006',N'Phan Lê',N'Tuấn','04/06/1976','25/10/2002','03')
insert into NhanVien values('0007',N'Lê Tuấn',N'Tú','15/08/1975','15/08/2000','03')
--xem bang nhanvien
select * from NhanVien
--nhap bang nhanvienkynang
insert into NhanVienKyNang values('0001','01',2)
insert into NhanVienKyNang values('0001','02',1)
insert into NhanVienKyNang values('0002','01',2)
insert into NhanVienKyNang values('0002','03',2)
insert into NhanVienKyNang values('0003','02',1)
insert into NhanVienKyNang values('0003','03',2)
insert into NhanVienKyNang values('0004','01',5)
insert into NhanVienKyNang values('0004','02',4)
insert into NhanVienKyNang values('0004','03',1)
insert into NhanVienKyNang values('0005','02',4)
insert into NhanVienKyNang values('0005','04',4)
insert into NhanVienKyNang values('0006','05',4)
insert into NhanVienKyNang values('0006','02',4)
insert into NhanVienKyNang values('0006','03',2)
insert into NhanVienKyNang values('0007','03',4)
insert into NhanVienKyNang values('0007','04',3)

select * from NhanVienKyNang
----------------------------------------------------------------------
select * from ChiNhanh
select * from KyNang
select * from NhanVien
select * from NhanVienKyNang
----------------------------------------------------------------------
--------------------TRUY VAN DU LIEU---------------
--Cau 1: lap danh sách các nhân viên ở chi nhánh có mã số '01'
select *
from	NhanVien
where	MSCN='01'
--Cau 2: Liệt kê các nhân viên họ "Lê"
select *
from NhanVien
where Ho like N'Lê%' 
--Cau 3: Liệt kê các nhân viên có năm sinh năm trong phạm vi từ 1970 đến 1980

select *
from NhanVien
where YEAR(ngaysinh) >=1970 and YEAR(ngaysinh)<=1980
select *
from NhanVien
where YEAR(ngaysinh) >1985

--Câu 4: Liệt kê họ tên, ngày sinh, ngày vào làm của nhân viên
select Ho, Ten, Ngaysinh, NgayVaoLam
from nhanvien
--Câu 5: Hiển thị MSNV, HoTen (Ho + Ten as HoTen), số năm làm việc (SoNamLamViec)
select manv, HO+' '+Ten as HoTen, YEAR(getdate())-YEAR(ngayvaolam)as SoNamLamViec
from	nhanvien
--Câu 5: phép tích giữa nhân viên và chi nhánh
select *
from NhanVien, ChiNhanh
--Cau 6: Liệt kê các thông tin về nhân viên: HoTen, NgaySinh, NgayVaoLam, TenCN (sắp xếp theo tên chi nhánh)
select Ho+' '+Ten as HoTen, Ngaysinh, NgayVaoLam, tencn
from NhanVien, ChiNhanh
where NhanVien.MSCN = ChiNhanh.MSCN
order by tencn, Ngaysinh desc
--Câu 7: Liệt kê các thông tin (HoTen, TenKN, MucDo) của những nhân viên biết sử dụng ‘Word’
select Ho+' '+Ten as HoTen, TenKN, MucDo
from NhanVien, NhanVienKyNang, KyNang
where NhanVien.MANV = NhanVienKyNang.MANV and NhanVienKyNang.MSKN=KyNang.MSKN
		and TenKN = 'word'

select Ho+' '+Ten as HoTen, TenKN, MucDo
from NhanVien A, NhanVienKyNang B, KyNang C
where A.MANV = B.MANV and B.MSKN=C.MSKN and TenKN = 'word'
--Câu 8: Liệt kê các kỹ năng (TenKN, MucDo) mà nhân viên ‘Lê Anh Tuấn’ biết sử dụng
select TenKN, MucDo
from NhanVien A, NhanVienKyNang B, KyNang C
where A.Ho = N'Lê Anh' and A.Ten=N'Tuấn' and A.MANV = B.MANV and B.MSKN=C.MSKN 
-- Câu 9: Cho biết số nhân viên của từng chi nhánh
select		TenCN, COUNT(manv) as SoNV
from		NhanVien A, ChiNhanh b
where		A.MSCN = B.MSCN
group by	TenCN

--Câu 10: Cho biết số lượng kỹ năng mỗi nhân viên sử dung được
select		A.MANV, Ho+' '+Ten as HoTen, COUNT(mskn) as SoKN
from		NhanVien A, NhanVienKyNang B
where		A.MaNv = B.MANV
group by	A.MANV,Ho,Ten
--Câu 11: Liệt kê các chi nhánh có từ 3 nhân viên trở lên (có không dưới 3 nhân viên)
select		TenCN, COUNT(manv) as SoNV
from		NhanVien A, ChiNhanh b
where		A.MSCN = B.MSCN
group by	TenCN
having		COUNT(manv) >=3
-- Câu 12: Cho biết các nhân viên sử dụng không quá 2 kỹ năng, sắp xếp theo tên nhân viên
select		A.MANV, Ho+' '+Ten as HoTen, COUNT(mskn) as SoKN
from		NhanVien A, NhanVienKyNang B
where		A.MaNv = B.MANV
group by	A.MANV,Ho,Ten
having		COUNT(mskn) <=2
order by	Ten
---Câu 13: Liệt kê MANV, HoTen, MSCN, TenCN của các nhân viên có mức độ thành thạo về ‘Excel’ cao nhất trong công ty .
select	a.MANV, Ho+' '+Ten as HoTen, a.MSCN, TenCN, TenKN, c.MucDo
from	NhanVien a, ChiNhanh b, NhanVienKyNang c, KyNang d
where	a.MSCN = b.MSCN and a.MANV = c.MANV and c.MSKN = d.MSKN
		and TenKN = 'excel' and c.MucDo =(select MAX(e.mucdo)
											from NhanVienKyNang e, KyNang f
											where e.MSKN=f.MSKN and TenKN='excel')
---Câu 14: Với từng kỹ năng, liệt kê MANV, HoTen, MSCN, TenCN của các nhân viên có mức độ thành thạo nhất trong công ty .
select	TenKN, c.MucDo, a.MANV, Ho+' '+Ten as HoTen, a.MSCN, TenCN 
from	NhanVien a, ChiNhanh b, NhanVienKyNang c, KyNang d
where	a.MSCN = b.MSCN and a.MANV = c.MANV and c.MSKN = d.MSKN
		and c.MucDo =(select MAX(e.mucdo)
						from NhanVienKyNang e
						where e.MSKN=d.MSKN)
order by TenKN, Ten,Ho
----Câu 15: Cho biết chi nhánh có nhiều nhân viên nhất
select	TenCN, COUNT(manv) as SoNV
from	ChiNhanh A, NhanVien B
where	A.MSCN = B.MSCN
group by TenCN
having COUNT(manv) >=all (select COUNT(manv)
							from NhanVien
							group by MSCN)
----Câu 16: Cho biết chi nhánh có ít nhân viên nhất
select	TenCN, COUNT(manv) as SoNV
from	ChiNhanh A, NhanVien B
where	A.MSCN = B.MSCN
group by TenCN
having COUNT(manv) <=all (select COUNT(manv)
							from NhanVien
							group by MSCN)
--- 
----Câu 17: Cho biết nhân viên sử dụng được nhiều kỹ năng nhất
---phương án của Hân
select	A.manv,Ho, Ten, COUNT(mskn) as SoKN
from	NhanVien A, NhanVienKyNang B
where	A.MANV = B.MANV
group by A.manv, Ho, Ten
having COUNT(mskn) >=all (select COUNT(mskn)
							from NhanVienKyNang
							group by manv)
				
----Câu 18: Cho biết kỹ năng có nhiều nhân viên sử dụng nhất
select	TenKN, COUNT(manv) As SoNguoiDung
from	KyNang a, NhanVienKyNang b
where	a.MSKN = b.MSKN
group by TenKN
having COUNT(manv) >=all (select COUNT(manv)
							from	NhanVienKyNang 
							group by mskn)
---Câu 19: Liệt kê MANV, HoTen, TenCN của các nhân viên vừa biết ‘Word’ vừa biết ‘Excel’ (dùng truy vấn lồng).

select	a.MANV, Ho+' '+Ten as HoTen,TenCN
from	NhanVien a, ChiNhanh b, NhanVienKyNang c, KyNang d
where	a.MSCN = b.MSCN and a.MANV = c.MANV and c.MSKN = d.MSKN
		and TenKN = 'excel'  
		and a.MANV IN (select e.manv
						from NhanVienKyNang e, KyNang f
						where e.MSKN = f.MSKN and TenKN = 'word')
---Câu 20: cho biết những nhân viên của công ty không sử dung 'SPSS'
--Cách 1: dùng NOT IN
select	a.MANV, Ho+' '+Ten as HoTen,TenCN
from	NhanVien a, ChiNhanh b
where	a.MSCN = b.MSCN 
		and a.MANV NOT In (select c.manv
							from NhanVienKyNang c, KyNang d
							where c.MSKN = d.MSKN and TenKN = 'spss') 
--Cách 2: sử dụng phép nối ngoài
select	NhanVien.MANV, Ho+' '+Ten as HoTen
from	NhanVien left join (select c.manv, c.mskn
							from NhanVienKyNang c, KyNang d
							where c.MSKN = d.MSKN and TenKN = 'spss')as R on NhanVien.MANV = R.MANV
							
where R.mskn is NULL