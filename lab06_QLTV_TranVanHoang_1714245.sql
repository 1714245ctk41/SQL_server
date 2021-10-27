
------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU
create database lab06_QLTV
go
use lab06_QLTV
go
----lệnh tạo các bảng---
create table NhaXuatBan
(	MANXB char(4) primary key,
	TenNXB	nvarchar(25) not null unique)
	
create table BanDoc
(
	MaThe char(6) primary key,
	TenBanDoc	nvarchar(20)	not null unique,
	DiaChi		nvarchar(25)	not null,
	SoDT		char(6)			not null unique)
	
create table TheLoai
(
	MATL	char(2)	primary key,
	TENTL	nvarchar(15) not null)

create table Sach
(
	MaSach	char(6) primary key,
	TuaDe	nvarchar(50) not null unique,
	MANXB	char(4)	references	NhaXuatBan(MANXB),
	TacGia	nvarchar(30),
	SoLuong	smallint check(SoLuong>=0),
	NgayNhap	datetime,
	MATL	char(2)	references	TheLoai(MATL))
	
create table MuonSach
(
	MaThe	char(6)	references	BanDoc(MaThe),
	MaSach	char(6)	references	Sach(MaSach),
	NgayMuon	datetime,
	NgayTra		datetime,
	primary key(MaThe, MaSach))
	
	
	/*--drop table MuonSach
	drop table Sach
	drop table TheLoai
	drop table BanDoc
	drop table NhaXuatBan*/
	select * from BanDoc
	select * from NhaXuatBan
	select * from TheLoai
	select * from Sach
	select * from MuonSach
	
	
-----Nhập dũ liệu cho bảng-----
create procedure usp_ThemNhaXuatBan
@MANXB char(4),
@TenNXB nvarchar(25)
as
insert NhaXuatBan values(
	@MANXB,
	@TenNXB)
go
exec	usp_ThemNhaXuatBan	N001,N'Giáo dục'
exec	usp_ThemNhaXuatBan	N002,N'Khoa học kỹ thuật'
exec	usp_ThemNhaXuatBan	N003,N'Thống kê'
----xem dữ liệu NhaXuatBan---
select * from NhaXuatBan
------BanDoc------
create procedure usp_ThemBanDoc
@MaThe	char(6),
@TenBanDoc	nvarchar(20),
@DiaChi		nvarchar(25),
@SoDT		char(6)
as
insert  BanDoc values(
	@MaThe,
	@TenBanDoc,
	@DiaChi,
	@SoDT)
go
exec	usp_ThemBanDoc	'050001',N'Trần Xuân', N'17 Yersin', '858936'
exec	usp_ThemBanDoc	'050002',N'Lê Nam', N'5 Hai Bà Trưng', '845623'
exec	usp_ThemBanDoc	'060001',N'Nguyễn Năm',N'10 Lý Tự Trọng','823456'
exec	usp_ThemBanDoc	'060002',N'Trần Hùng',N'20 Trần Phú', '841256'
------xem bảng BanDoc
-----drop procedure usp_ThemBanDoc
select * from BanDoc
-----bảng Thể loại---
create procedure usp_ThemTheLoai
@MATL	char(2),
@TENTL	nvarchar(15)
as
insert	TheLoai	values(
	@MATL,
	@TENTL)
go
exec	usp_ThemTheLoai	'TH',N'Tin học'
exec	usp_ThemTheLoai	'HH',N'Hóa học'
exec	usp_ThemTheLoai	'KT',N'Kinh tế'
exec	usp_ThemTheLoai	'TN',N'Toán học'
-----xem bảng Thể loại---
select * from TheLoai
------thêm bảng sách-------
create procedure usp_ThemSach
@MaSach char(6),
@TuaDe	nvarchar(50),
@MANXB	char(4),
@TacGia	nvarchar(30),
@SoLuong	smallint,
@NgayNhap	datetime,
@MATL	char(2)
as
insert	Sach	values(
	@MaSach,
	@TuaDe,
	@MANXB,
	@TacGia,
	@SoLuong,
	@NgayNhap,
	@MATL)
go
exec	usp_ThemSach	'TH0001',N'Sử dụng Corel Draw','N002',N'Đậu Quang Tuấn',3,'08/09/2005','TH'
exec	usp_ThemSach	'TH0002',N'Lập trình mạng','N003',N'Phạm Vĩnh Hưng',2,'03/12/2003','TH'
exec	usp_ThemSach	'TH0003',N'Thiết kế mạng chuyện nghiệp','N002',N'Phạm Vĩnh Hưng',5,'04/05/2003','TH'
exec	usp_ThemSach	'TH0004',N'Thực hành mạng','N003',N'Trần Quang',3,'06/05/2004','TH'
exec	usp_ThemSach	'TH0005',N'3D Studio kỹ xảo hoạt hình T1','N001',N'Trương Bình',2,'05/02/2004','TH'
exec	usp_ThemSach	'TH0006',N'3D Studio kỹ xảo hoạt hình T2','N001',N'Trương Bình',3,'05/06/2004','TH'
exec	usp_ThemSach	'TH0007',N'Giáo trình Access 200','N001',N'Thiện Tâm',5,'11/12/2005','TH'
------xem bảng Sach_-----
select * from Sach
--------Thêm mượn sách__------
create procedure usp_ThemMuonSach
@MaThe char(6),
@MaSach char(6),
@NgayMuon	datetime,
@NgayTra	datetime
as
insert into MuonSach	values(
	@MaThe,
	@MaSach,
	@NgayMuon,
	@NgayTra
)
go
set dateformat dmy
go
exec	usp_ThemMuonSach	'050001','TH0006','12/12/2006','01/03/2007'
exec	usp_ThemMuonSach	'050001','TH0007','12/12/2006',	NULL
exec	usp_ThemMuonSach	'050002','TH0001','08/03/2006','15/04/2007'
exec	usp_ThemMuonSach	'050002','TH0004','04/03/2007',	NULL
exec	usp_ThemMuonSach	'050002','TH0002','04/03/2007','04/04/2007'
exec	usp_ThemMuonSach	'050002','TH0003','02/04/2007','15/04/2007'
exec	usp_ThemMuonSach	'060002','TH0001','08/04/2007',	NULL
exec	usp_ThemMuonSach	'060002','TH0007','15/03/2007','15/04/2007'
----------xem table MuonSach---------
-----drop procedure usp_ThemMuonSach
----drop table MuonSach
select * from MuonSach


-----TRUY VẤN------
select	B.MaThe, TenBanDoc,TuaDe, NgayMuon
from	BanDoc A, MuonSach B, Sach C
where	B.MaThe=A.MaThe and B.MaSach=C.MaSach and NgayTra IS NULL

---cau 9:b
select	A.MaThe, TenBanDoc, count(MaSach) AS SOSACHMUON
from	MuonSach A, BanDoc B
where	B.MaThe=A.MaThe
group by	A.MaThe, TenBanDoc
having	COUNT(MaSach)>=all(select count(MaSach) AS SOSACHMUON
						from	MuonSach A, BanDoc B
						where	B.MaThe=A.MaThe
						group by	A.MaThe, TenBanDoc	)
						
---cau 9: c
select	TuaDe
from	Sach A, MuonSach B
where	B.MaSach=A.MaSach and NgayTra IS NULL