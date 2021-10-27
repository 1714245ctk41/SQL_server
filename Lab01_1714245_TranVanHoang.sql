/* Học phần: Cơ sở dữ liệu
   Người thực hiện: ....
   MSSV: .....
   Ngày: .....
*/	
----------Định NGHĨA CƠ SỞ DỮ LIỆU-----------
CREATE DATABASE lab01_QLNV
go
use lab1_QLNV
go
--lenh tao cac bang
create table ChiNhanh
(MSCN char(2) primary key, 
TenCN nvarchar(30) not null unique
)
go 
create table KyNang
(
MSKN char(2) primary key,
TenKN nvarchar(30) not null unique
)
create table NhanVien
(
MSNV char (2) primary key,
Ho nvarchar(30) not null, 
Ten nvarchar(15) not null, 
NgaySinh Datetime,
NgayVaoLam Datetime,
MSCN char (2) references ChiNhanh(MSCN)
)
create table NhanVienKyNang
(
MSNV char(4) references NhanVien(MANV),
MSKN char (2) references KyNang(MSKN), 
MucDo tinyint check(MucDo between 1 and 9)
primary key(MSNV, MSKN)
)
--------Nhap du lieu cho cac bang------
--Nhap du lieu cho cac bang
insert into ChiNhanh values('01',N'Quận 1')
insert into ChiNhanh values('02',N'Quận 5')
insert into ChiNhanh values('03', N'Bình Thạnh')
--Xem bảng chi nhanh
select * from ChiNhanh
--Nhap bang KyNang
insert into KyNang values('01',N'Word')
insert into KyNang values('02',N'Excel')
insert into KyNang values('03',N'Access')
insert into KyNang values('04','Power Point')
insert into KyNang values('05','SPSS')
--xem bang kynang
select * from KyNang
--nhap bang NhanVien
insert into NhanVien values('0001',N'Lê Văn',N'Ten','10/06/1960','02/05/1986','01')
insert into NhanVien values('0002',N'Nguyễn Thị',N'Mai','20/04/1970','04/07/2001','01')
insert into NhanVien values('0003', N'Lê Anh', N'Tuấn','25/06/1975','01/09/1982','02')
insert into NhanVien values('0004',N'Vương Tuấn', N'Vữ','25/03/1960','12/01/1986','02')
insert into NhanVien values('0005',N'Lý Anh', N'Hân', '01/12/1980','15/05/2004','02')
insert into NhanVien values('0006',N'Phan Lê',N'Tuấn','04/06/1976','25/10/2002','03')
insert into NhanVien values('0007',N'Lê Tuấn',N'Tú','15/08/1975','15/08/2000','03')
--xem bang nhan vien
select * from NhanVien
--Nhap bang Nhanvienkynang
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
--Xem ban nhanvienkynang
select * from NhanVienKyNang
--------------------------------------
select * from ChiNhanh
select * from KyNang
select * from NhanVien
select * from NhanVienKyNang
-----------------------------------------
--------------TRUY VAN DU LIEU------------
--cau 1: Hien thi MSNV, HoTen (Ho+ Ten as HoTen), so nam lam viec(SoNamLamViec).
select	A.MSNV,Ho+' '+Ten AS HoTen, year(getdate())-year(NgayVaoLam) as SoNamLamViec
from	NhanVien A

--cau 2: Liet ke cac thong tin ve nhan vien: HoTen, NgaySinh, NgayVaoLam,TenCN(sap xep theo ten chi nhanh
select	Ho+' '+Ten AS HoTen,Ngaysinh,NgayVaoLam,TenCN
from NhanVien A,ChiNhanh
where A.MSCN=ChiNhanh.MSCN
order by TenCN,Ngaysinh desc

--cau 3: Liet ket cac nhan vien (HoTen, TenKN, MucDo) ma nhan vien  biết sử dụng 'Word'.
select	Ho+' '+Ten AS HoTen, TenKN,MucDo
from	NhanVien A,KyNang B,NhanVienKyNang C
where	A.MSNV=C.MSNV and C.MSKN=B.MSKN and TenKN='Word'

--cau 4: Liet ke cac ky nang(TenKN, MucDo) ma nhan vien 'Le6 Anh Tuan' biet su dung
select TenKN,MucDo
from KyNang A, NhanVienKyNang B,NhanVien C
where A.MSKN=B.MSKN and C.Ho=N'Lê Anh' and C.Ten=N'Tuấn' and B.MSNV=C.MSNV

--2. truy van long
--cau a: Liet ke MSNV, HoTen, MSCN, TenCN cua cac nhan vien co muc do thanh thao ve 'Excel' cao nhat trong cong ty
select A.MSNV,Ho+' '+Ten AS HoTen,D.MSCN,TenCN
from NhanVien A, KyNang B, NhanVienKyNang C,ChiNhanh D
where A.MSNV=C.MSNV and B.MSKN=C.MSKN and B.TenKN='Excel' and C.MucDo=(select MAX(E.MucDo)
																		from NhanVienKyNang E
																		where E.MSKN=B.MSKN)
--cau b: Lien ke MSNV, HoTen, TenCN cua cac nhan vien vua biet "Word vua biet "Excel"(dung truy van long)
select	A.MSNV, Ho+' '+Ten AS HoTen, TenCN
from	NhanVien A, KyNang B, ChiNhanh C, NhanVienKyNang D
where	A.MSNV=D.MSNV and B.MSKN=D.MSKN and TenKN='Word' and A.MSNV IN(select	F.MSNV
													from	KyNang E,NhanVienKyNang F
													where	E.MSKN=F.MSKN and TenKN='Excel')
--Cau c: voi tung ky nang, hay liet ke cac thong tin (MSNV, HoTen, TenCN, TenKN, MucDo) cua nhung nhan vien thanh thao ky nang do nhat
select	A.MSNV, Ho+' '+Ten AS HoTen, TenCN, TenKN, MucDo
from	NhanVien A, NhanVienKyNang B, ChiNhanh D, KyNang C
where	A.MSNV=B.MSNV and B.MSKN=C.MSKN and B.MucDo=(select	MAX(MucDo)
													from	NhanVienKyNang E
													where	E.MSKN=C.MSKN)
--cau d: liet ke cac ch inahn (MSCN, TenCN) ma moi nhan vien trong chi nhanh deu biet word
select	A.MSCN,TenCN
from	ChiNhanh A, NhanVien B, NhanVienKyNang C, KyNang D
where	B.MSNV=C.MSNV and C.MSKN=D.MSKN and A.MSCN=B.MSCN and A.MSNV=(select	E.MSNV
																	from	NhanVienKyNang E
																	where	E.MucDo=1)
--cau 3: truy van nhom du lieu----
--cau a: voi moi chi nhanh, hay cho biet cac thong tin sau TenCN, SoNV(so nhan vien cua ten chi nhanh)
select	TenCN, COUNT(MSNV) AS SoNV
from	ChiNhanh A, NhanVien B
where	A.MSCN=B.MSCN
group by	TenCN
--cau b: Voi moi ky nang, hay cho biet TenKN, SoNguoiDung(so nhan vien biet su dung ky nang do)
select	TenKN, count(*) AS SoNguoiDung
from	KyNang A, NhanVien B, NhanVienKyNang C
where	A.MSKN=C.MSKN and B.MSNV=C.MSNV
group by	TenKN
--cau c: Cho biet TenKn co tu 3 nhan vien trong cong ty su dung tro len
select	TenKN, count(B.MSNV) as SoNV
from	KyNang A, NhanVien B, NhanVienKyNang C
where	A.MSKN=C.MSKN and C.MSNV=B.MSNV
group by	TenKN
having	COUNT(B.MSNV)>=3
--cau d: Cho biet TenCN co nhieu nhan vien nhat
select	TenCN, count(MSNV) AS SoNV
from	ChiNhanh A, NhanVien B.
where	A.MSCN=B.MSCN
group by	TenCN
having	count(MSNV)>=all(select	COUNT(MSNV)
						from	NhanVien C,
						group by MSCN)
--cau e: voi moi nhan vien, hay cho biet so ky nang tin hoc ma nhan vien do su dung duoc
select	A.MSNV,Ho+' '+Ten AS HoTen,count(MSKN) AS SOKN
from	NhanVien A, KyNang B, NhanVienKyNang C
where	A.MSNV=C.MSNV and B.MSKN=C.MSKN
group by	A.MSNV,Ho,Ten
--cau f: Cho biet TenCN co it nhan vien nhat
select	TenCN, COUNT(MSNV) AS SoNV
from	NhanVien A, ChiNhanh B
where	A.MSCN=B.MSCN
group by	TenCN
having count(MSNV)<=all(select	count(MSNV)
						from	NhanVien
						group by MSCN)
--cau g: cho biet HoTen, TenCN cua nhan vien biet su dung nhieu ky nang nhat
select	Ho+' '+Ten AS HoTen, TenCN, count(MSKN) AS SOKN
from	NhanVien A, ChiNhanh B,NhanVienKyNang C
where	A.MSCN=B.MSCN and A.MSNV=C.MSNV
group by	A.MSNV, Ho, Ten
having	count(MSKN)>=all(select	count(MSKN)
						from	NhanVienKyNang
						group by	MSNV)
