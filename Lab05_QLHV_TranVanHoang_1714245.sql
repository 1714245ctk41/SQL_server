/*Học phần: Cơ sở dữ liệu
	Người thực hiện: Trần Văn Hoàng
	MSSV: 1714245
	Ngày: 26/3/1997
	*/
--------ĐỊNH NGHĨA CƠ SỞ DỮ LIỆU---------
create database lab05_QLHV
go
use	lab05_QLHV
go
--------Lệnh tạo các bảng----------
create table CaHoc
(
	Ca	tinyint primary key,
	GioBatDau	Datetime,
	GioKetThuc	Datetime,
	check (GioBatDau<GioKetThuc))

create table GiaoVien
(
	MSGV	char(4)	primary key,
	HoGV	nvarchar(20)	not null ,
	TenGV	nvarchar(10)	not null,
	DienThoai	char(6)	not null)
	
create table Lop
(
	MaLop	char(4)	primary key,
	TenLop	varchar(15)	not null	unique,
	NgayKG	Datetime,
	HocPhi	int,
	Ca	tinyint	references	CaHoc(Ca),
	SoTiet	smallint,
	SoHV	tinyint,
	MSGV	char(4)	references	GiaoVien(MSGV),
)
	
create table HocVien
(
	MSHV	char(6)	primary key,
	Ho		nvarchar(20)	not null,
	Ten		nvarchar(10)	not null,
	NgaySinh	Datetime,
	Phai	nvarchar(4),
	MaLop	char(4)	references	Lop(MaLop))
	
create table HocPhi
(
	SoBL	char(5)	primary key,
	MSHV	char(6)	references	HocVien(MSHV),
	NgayThu	Datetime,
	SoTien	int,
	NoiDung	char(20)	not null,
	NguoiThu	nvarchar(8),
)

	/*drop table CaHoc
	drop table GiaoVien
	drop table Lop
	drop table HocVien
	drop table HocPhi*/
	
------Nhập dữ liệu cho bảng-----------
-------Nhập dữ liệu cho bảng CaHoc---------
create procedure usp_ThemCaHoc
@Ca	tinyint ,
@GioBatDau	Datetime,
@GioKetThuc	Datetime
as
insert CaHoc values(
	@Ca,
	@GioBatDau,
	@GioKetThuc)
go
exec usp_ThemCaHoc 1,'7:30', '10:45'
exec usp_ThemCaHoc 2,'13:30','16:45'
exec usp_ThemCaHoc 3, '17:30', '20:45'
----xem dữ liệu bảng CaHoc--------
select * from CaHoc
---------Nhập dữ liệu bảng GiaoVien--------
create procedure usp_ThemGiaoVien
@MSGV	char(4),
@HoGV	nvarchar(20),
@TenGV	nvarchar(10),
@DienThoai	char(6)
as
insert into GiaoVien values(
	@MSGV,@HoGV, @TenGV,	@DienThoai)
go
exec	usp_ThemGiaoVien	'G001',N'Lê Hoàng',N'Anh','858936'
exec	usp_ThemGiaoVien	'G002',N'Nguyễn Ngọc',N'Lan','845623'
exec	usp_ThemGiaoVien	'G003',N'Trần Minh',N'Hùng','823456'
exec	usp_ThemGiaoVien	'G004',N'Võ Thanh',N'Trung','841256'
-----Xem dữ liệu bảng GiaoVien-----------
select * from GiaoVien
---------Nhập dữ liệu bảng Lop--------

create procedure usp_ThemLop
@MaLop	char(4)	,
@TenLop	varchar(15)	,
@NgayKG	Datetime,
@HocPhi	int,
@Ca	tinyint	,
@SoTiet	smallint,
@SoHV	tinyint,
@MSGV	char(4)
AS
	insert	into	Lop		values(
	@MaLop		,
	@TenLop	,
	@NgayKG	,
	@HocPhi	,
	@Ca	,
	@SoTiet,
	@SoHV,
	@MSGV)

go
set dateformat dmy
go
exec usp_ThemLop 'E114', 'Excel 3-5-7', '02/01/2008', 120000, 1, 45, 3, 'G003'
exec usp_ThemLop 'E115', 'Excel 2-4-6', '22/01/2008', 120000, 3, 45, 0, 'G001'
exec usp_ThemLop 'W123', 'Word 2-4-6', '18/02/2008', 100000, 3, 30, 1, 'G001'
exec usp_ThemLop 'W124', 'Word 3-5-7', '01/03/2008', 100000, 1, 30, 0, 'G002'
exec usp_ThemLop 'A075', 'Access 2-4-6', '18/12/2008', 150000, 3, 60, 3, 'G003'
select * from Lop


--cau 4: e. Xóa một lớp học cho trước nếu lớp học này không có học viên.
declare @SoHV int;
select @SoHV=SoHV from Lop;
if @SoHV=0
begin
	delete from Lop where SoHV=0;
	end
else
	print N'Không có lớp không có học viên'
--cau 4: c. Cập nhật thông tin của một lớp học cho trước.
set dateformat dmy
go
exec usp_ThemLop 'W124', 'Word 3-5-7', '01/03/2008', 100000, 1, 30, 0, 'G002'
exec usp_ThemLop 'E115', 'Excel 2-4-6', '22/01/2008', 120000, 3, 45, 0, 'G001'



--cau 4: f. Lập danh sách học viên của một lớp cho truoc
create procedure usp_DSHOCVIENLOP
@MaLop char(4)
as
select * from HocVien where MaLop=@MaLop
go





---tạo procedure cho Them hocvien----
create procedure usp_ThemHocVien
	@MSHV	char(6),
	@Ho		nvarchar(20),
	@Ten		nvarchar(10),	
	@NgaySinh	Datetime,
	@Phai	nvarchar(4),
	@MaLop	char(4)

As
	insert into HocVien	values(
	@MSHV,
	@Ho,@Ten,
	@NgaySinh,
	@Phai,
	@MaLop)
	update Lop 
	set		SoHV=SoHV+1
	where	MaLop=@MaLop
go

set dateformat dmy
go
exec	usp_ThemHocVien	'A07501', N'Lê Văn', 'Minh', '10/06/1998', 'Nam', 'A075'
exec	usp_ThemHocVien	'A07502', N'Nguyễn Thị', 'Mai', '20/04/1998', N'Nữ', 'A075'
exec	usp_ThemHocVien	'A07503', N'Lê Ngọc', N'Tuấn', '10/06/1994', 'Nam', 'A075'
exec	usp_ThemHocVien	'E11401', N'Vương Tuấn', N'Vũ', '25/03/1999', 'Nam', 'E114'
exec	usp_ThemHocVien	'E11402', N'Lý Ngọc', N'Hân', '01/12/1995', N'Nữ', 'E114'
exec	usp_ThemHocVien	'E11403', N'Trần Mai', 'Linh', '04/06/1990', N'Nữ', 'E114'
exec	usp_ThemHocVien	'W12301', N'Nguyễn Ngọc', N'Tuyết', '12/05/1996', N'Nữ', 'W123'

select * from HocVien
--cau 4: f. Lập danh sách các học viên của 1 lớp cho trước.
create procedure usp_danhsachloporder
	@MSHV char(6),
	@MaLop char(4),
	@SoHV int=0 output
AS
	select @SoHV=SoHV from Lop where  MaLop=@MaLop 
	if @SoHV<=30
	begin
		insert into HocVien(MSHV,MaLop)
		values(@MSHV, @MaLop)
		set @SoHV=@SoHV+1
		return 1
	end
	return 0
	go
	-- drop procedure usp_danhsachloporder
	declare @SoHV int, @kq int
exec @kq=usp_danhsachloporder 'A90890','E115',@SoHV output



create procedure usp_ThemHocPhi
	@SoBL	char(5),
	@MSHV	char(6),
	@NgayThu	Datetime,
	@SoTien	int,
	@NoiDung	char(20),
	@NguoiThu	nvarchar(8)

As
insert into HocPhi values(
@SoBL,
@MSHV,
@NgayThu,@SoTien,@NoiDung, @NguoiThu)
go
set dateformat dmy
go
exec usp_ThemHocPhi	'0001', 'E11401', '02/01/2008', 120000, 'HP Excel 3-5-7', N'Vân'
exec usp_ThemHocPhi	'0002', 'E11402', '02/01/2008', 120000, 'HP Excel 3-5-7', N'Vân'
exec usp_ThemHocPhi '0003', 'E11403', '02/01/2008', 80000, 'HP Excel 3-5-7', N'Vân'
exec usp_ThemHocPhi '0004', 'W12301', '18/02/2008', 100000, 'HP Word 2-4-6', 'Lan'
exec usp_ThemHocPhi '0005', 'A07501', '16/12/2008', 150000, 'HP Access 2-4-6', 'Lan'
exec usp_ThemHocPhi '0006', 'A07502', '16/12/2008', 100000, 'HP Access 2-4-6', 'Lan'
exec usp_ThemHocPhi '0007', 'A07503', '18/12/2008', 150000, 'HP Access 2-4-6', N'Vân'
exec usp_ThemHocPhi '0008', 'A07502', '15/01/2009', 50000, 'HP Access 2-4-6', N'Vân'
 select * from HocPhi

--cau 4: c. Xóa một hoc viên cho trước--

------cau 5: Cài đặt hàm(Function) sau:
---cau a: Tính tổng số học phí đã thu được của một lớp khi biết mã lớp
create function sumhocphi
(@MaLop char(4)) returns int
as
begin
	declare @sum int;
	while exists(select A.MaLop 
				from	Lop A, HocPhi B,HocVien C
				where	C.MaLop=A.MaLop and C.MSHV=B.MSHV and A.MaLop=@MaLop
				group by A.MaLop)

		set @sum= sum(SoTien)
					from	Lop A, HocPhi B,HocVien C
					where	C.MaLop=A.MaLop and C.MSHV=B.MSHV and A.MaLop=@MaLop
					group by A.MaLop;

return @sum
end
--------drop function sumhocphi
go
select sumhocphi('E114')

			select	 sum(SoTien) AS DaThu
			from	Lop A, HocPhi B,HocVien C
			where	C.MaLop=A.MaLop and C.MSHV=B.MSHV and A.MaLop='A075'
			group by A.MaLop

--cau b: Tính tổng học phí thu được trong một khoảng thời gian cho trước
create function hocphi_time
(@ngaykt Datetime,
@ngaybd datetime) returns int
as
begin
	declare @sum int;
	declare @SoTien int;
	
	select	@sum = SUM(SoTien)
				from		HocPhi 
				where		NgayThu between @ngaybd and @ngaykt
			

return @sum
end
-----drop function hocphi_time
select dbo.hocphi_time('18/12/2008' , '16/12/2008')
-----truy vấn dữ liệu------
select		NgayThu, sum(SoTien) AS THUDUOC
from		HocPhi A
group by	Ngaythu


---câu 4: Cài đặt ràng buộc toàn vên---
---câu 4: a. "Giờ kết thúc của một ca học không được trước giờ bắt đầu ca học đó.
create trigger 
--câu 4: b.
create trigger inc_SoHV_upd_Ngay
on	Lop	for insert, update
as
if UPDATE(MaLop) or UPDATE(SoHV)
	if exists(select * from inserted i, Lop d
				where	i.MaLop=d.MaLop
				and i.SoHV=d.SoHV and i.SoHV<=30)
	begin 
		raiserror (N' sĩ số lớp SoHV của một lớp không quá 30 học viên và đúng bằng số học viên thuộc lớp đó',15,1)
		rollback tran
	end
go
