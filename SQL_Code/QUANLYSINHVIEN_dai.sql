-- ============================================
-- DATABASE: Quản lý sinh viên - Đăng kí môn học 
-- Author: Trần Lê Quốc Đại - 23110201
-- Ngày: 02/09/2025
-- ============================================

-- ============================================
-- CÁC QUY ĐỊNH ĐẶT TÊN
-- NonP_ : Non-Parameter Stored Procedure: thủ tục không có tham số 
-- HasP_ : Has Parameter Stored Procedure: thủ tục có tham số
-- Re_ : Return / Result / with checks: nhóm thủ tục có trả về. Có tham số, thường có transaction, kiểm tra điều kiện, RAISERROR, RETURN
-- RNO_ : Return Number (One value): nhóm hàm trả về một giá trị (scalar function)
-- RTO_ : Return Table (One statement): nhóm trả về một bảng có một câu lệnh (inline table-valued function)
-- RTM_ : Return Table (Multi-statement): nhóm trả về một bảng có nhiều câu lệnh
-- ============================================


-- ============================================
/* NOTE */
-- 1. Chưa xét đến yếu tố của các lớp mà bị trùng giờ khi đăng kí
-- ============================================
CREATE DATABASE QUANLYSINHVIEN
GO 

USE QUANLYSINHVIEN
GO
-- 1. Tài khoản
CREATE TABLE TAIKHOAN(
	TenDangNhap NVARCHAR(20) NOT NULL,
	MatKhau NVARCHAR(20) NOT NULL,
	VaiTro NVARCHAR(20) NOT NULL,
	CONSTRAINT PK_TAIKHOAN PRIMARY KEY (TenDangNhap)
);
GO

-- 2. Khoa - Ngành
CREATE TABLE KHOA (
	MaKhoa NVARCHAR(20) NOT NULL,
	TenKhoa NVARCHAR(100) NOT NULL,
	CONSTRAINT PK_KHOA PRIMARY KEY (MaKhoa)
);
GO

CREATE TABLE NGANH (
	MaNganh NVARCHAR(20) NOT NULL,
	TenNganh NVARCHAR(100) NOT NULL,
	MaKhoa NVARCHAR(20),
	CONSTRAINT PK_NGANH PRIMARY KEY (MaNganh),
	CONSTRAINT FK_NGANH_KHOA FOREIGN KEY (MaKhoa) REFERENCES KHOA(MaKhoa) ON DELETE SET NULL ON UPDATE CASCADE -- không xóa dữ liệu con, cập nhật đồng bộ
);

-- 3. Quản lý - Giảng viên
CREATE TABLE QUANLY (
	MaQL NVARCHAR(20) NOT NULL,
	TenQL NVARCHAR(100) NOT NULL,
	CONSTRAINT PK_QUANLY PRIMARY KEY (MaQL),
	CONSTRAINT TaiKhoanQL FOREIGN KEY (MaQL) REFERENCES TAIKHOAN(TenDangNhap) ON DELETE CASCADE
);
GO

CREATE TABLE GIANGVIEN (
	MaGV NVARCHAR(20) NOT NULL,
	HoTenGV NVARCHAR(100) NOT NULL,
	MaKhoa NVARCHAR(20) NOT NULL,
	CONSTRAINT PK_GIANGVIEN PRIMARY KEY (MaGV),
	CONSTRAINT TaiKhoanGV FOREIGN KEY (MaGV) REFERENCES TAIKHOAN(TenDangNhap) ON DELETE CASCADE,
	CONSTRAINT FK_GIANGVIEN_KHOA FOREIGN KEY (MaKhoa) REFERENCES KHOA(MaKhoa) ON UPDATE CASCADE
)
-- 4. Chương trình đào tạo
CREATE TABLE CTDAOTAO (
	MaCTDT NVARCHAR(20) NOT NULL,
	TenCTDT NVARCHAR(100) NOT NULL,
	HinhThucDT NVARCHAR(50) NOT NULL,
	NgonNguDT NVARCHAR(50) NOT NULL,
	TrinhDoDaoTao NVARCHAR(50) NOT NULL,
	CONSTRAINT PK_CTDAOTAO PRIMARY KEY (MaCTDT)
);
GO

-- 5. Lớp - Sinh viên
CREATE TABLE LOP (
	MaLop NVARCHAR(20) NOT NULL,
	TenLop NVARCHAR(100) NOT NULL,
	MaNganh NVARCHAR(20),
	MaCTDT NVARCHAR(20),
	CONSTRAINT PK_LOP PRIMARY KEY (MaLop),
	CONSTRAINT FK_LOP_NGANH FOREIGN KEY (MaNganh) REFERENCES NGANH(MaNganh) ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT FK_LOP_CTDAOTAO FOREIGN KEY (MaCTDT) REFERENCES CTDAOTAO(MaCTDT) ON DELETE SET NULL ON UPDATE CASCADE
);
GO

CREATE TABLE SINHVIEN (
	MaSV NVARCHAR(20) NOT NULL,
	HoTenSV NVARCHAR(100) NOT NULL,
	GioiTinh NVARCHAR(10) NOT NULL,
	NgaySinh DATE NOT NULL,
	MaLop NVARCHAR(20),
	CONSTRAINT PK_SINHVIEN PRIMARY KEY (MaSV),
	CONSTRAINT FK_SINHVIEN_LOP FOREIGN KEY (MaLop) REFERENCES LOP(MaLop) ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT TaiKhoanSV FOREIGN KEY (MaSV) REFERENCES TAIKHOAN(TenDangNhap) ON DELETE CASCADE ON UPDATE CASCADE
	CONSTRAINT CK_SV_GioiTinh CHECK (GioiTinh IN (N'Nam', N'Nữ', N'Khác'))
);
GO

-- 6. Môn học + Môn trong CTĐT
CREATE TABLE MONHOC (
	MaMH NVARCHAR(20) NOT NULL,
	TenMH NVARCHAR(100) NOT NULL,
	SoTinChi INT NOT NULL,
	MaKhoaPhuTrach NVARCHAR(20) NOT NULL,
	CONSTRAINT PK_MONHOC PRIMARY KEY (MaMH),
	CONSTRAINT CK_SoTinChi CHECK (SoTinChi > 0),
    CONSTRAINT FK_MONHOC_KHOA FOREIGN KEY (MaKhoaPhuTrach) REFERENCES KHOA(MaKhoa)
);


CREATE TABLE MONHOC_DAOTAO (
	MaMHDT NVARCHAR(20) NOT NULL,
	MaMH NVARCHAR(20) NOT NULL,
	MaCTDT NVARCHAR(20) NOT NULL,
	MaNganh NVARCHAR(20) NOT NULL,
	CONSTRAINT PK_MONHOC_DAOTAO PRIMARY KEY (MaMHDT),
	CONSTRAINT UQ_MONHOC_DAOTAO UNIQUE (MaCTDT, MaMH, MaNganh), -- chống bị trùng
	CONSTRAINT FK_MHDT_MONHOC FOREIGN KEY (MaMH) REFERENCES MONHOC(MaMH) ON DELETE CASCADE,
	CONSTRAINT FK_MHDT_CTDT FOREIGN KEY (MaCTDT) REFERENCES CTDAOTAO(MaCTDT) ON DELETE CASCADE,
	CONSTRAINT FK_MHDT_NGANH FOREIGN KEY (MaNganh) REFERENCES NGANH(MaNganh) ON DELETE CASCADE
);
GO


-- 7. Lớp học phần & đăng ký
CREATE TABLE LOPHOC (
	MaLopHoc NVARCHAR(20) NOT NULL,
	MaMHDT NVARCHAR(20) NOT NULL,
	MaGV NVARCHAR(20),
	SoLuong INT NOT NULL,
	TenPhong NVARCHAR(20) NOT NULL,
	Thu NVARCHAR(20) NOT NULL,
	TietBatDau INT NOT NULL, 
	TietKetThuc INT NOT NULL,
	ThoiGianBatDau DATE NOT NULL,
	ThoiGianKetThuc DATE NOT NULL,
	HocKy NVARCHAR(5) NOT NULL,
	Nam INT NOT NULL,
	CONSTRAINT PK_LOPHOC PRIMARY KEY (MaLopHoc),
	CONSTRAINT FK_LOPHOC_MHDT FOREIGN KEY (MaMHDT) REFERENCES MONHOC_DAOTAO (MaMHDT) ON DELETE CASCADE,
	CONSTRAINT FK_LOPHOC_GIANGVIEN FOREIGN KEY (MaGV) REFERENCES GIANGVIEN (MaGV) ON DELETE SET NULL,
	CONSTRAINT CK_LH_Tiet CHECK (TietBatDau >= 1 AND TietKetThuc > TietBatDau),
	CONSTRAINT CK_LH_ThoiGian CHECK (ThoiGianBatDau <= ThoiGianKetThuc),
	CONSTRAINT CK_LH_SoLuong CHECK (SoLuong BETWEEN 10 AND 100),
	CONSTRAINT CK_LH_Hocky CHECK (HocKy IN (N'HK1', N'HK2', N'HK3'))
);
GO


CREATE TABLE DANGKY (
	MaSV NVARCHAR(20) NOT NULL,
	MaLopHoc NVARCHAR(20) NOT NULL,
	CONSTRAINT PK_DANGKY PRIMARY KEY (MaSV, MaLopHoc),
	CONSTRAINT FK_DANGKY_SINHVIEN FOREIGN KEY (MaSV) REFERENCES SINHVIEN(MaSV) ON DELETE CASCADE,
	CONSTRAINT FK_DANGKY_LOPHOC FOREIGN KEY (MaLopHoc) REFERENCES LOPHOC(MaLopHoc) ON DELETE CASCADE
);
GO

-- 8. Điều kiện môn học
CREATE TABLE DIEUKIEN_MON (
    MaMon NVARCHAR(20) NOT NULL,            -- môn chính
    MaMonDieuKien NVARCHAR(20) NOT NULL,    -- môn điều kiện
    Loai NVARCHAR(20) NOT NULL CHECK (Loai IN (N'Tiên quyết', N'Song hành')),
    CONSTRAINT PK_DKM PRIMARY KEY (MaMon, MaMonDieuKien, Loai),
    CONSTRAINT FK_DKM_Mon FOREIGN KEY (MaMon) REFERENCES MONHOC(MaMH),
    CONSTRAINT FK_DKM_MonDK FOREIGN KEY (MaMonDieuKien) REFERENCES MONHOC(MaMH),
    CONSTRAINT CK_DKM_NoSelf CHECK (MaMon <> MaMonDieuKien)
);
GO

/* Nhập dữ liệu */
INSERT INTO KHOA(MaKhoa, TenKhoa) VALUES
('01', N'Khoa Chính trị Luật'),
('02', N'Khoa Cơ khí Chế tạo máy'),
('03', N'Khoa Cơ khí Động lực'),
('04', N'Khoa Công nghệ Hóa học và Thực phẩm'),
('05', N'Khoa Công nghệ Thông tin'),
('06', N'Khoa Điện – Điện tử'),
('07', N'Khoa In và Truyền thông'),
('08', N'Khoa Học Ứng dụng'),
('09', N'Khoa Kinh tế'),
('10', N'Khoa Ngoại ngữ'),
('11', N'Khoa Thời trang và Du lịch'),
('12', N'Khoa Ngoại ngữ'),
('13', N'Khoa Xây dựng'),
('14', N'Viện Sư phạm Kỹ thuật'),
('15', N'Trung tâm GDQP và An ninh'),
('16', N'Trung tâm Giáo dục thể chất')
GO

INSERT INTO NGANH(MaNganh, TenNganh, MaKhoa) VALUES
('GEN-CTPL', N'Nhóm môn Chính trị & Pháp luật', '01'),
('GEN-KHUD', N'Nhóm môn Toán & Vật lý', '08'),
('GEN-EEE', N'Nhóm môn Điện – Điện tử cơ bản', '06'),
('GEN-GDQP', N'Nhóm môn Giáo dục Quốc phòng', '15'),
('GEN-GDTC', N'Nhóm môn Giáo dục Thể chất', '16'),
('7480201', N'Công nghệ thông tin', '05'),
('7480202', N'An toàn thông tin', '05'),
('7480203', N'Kỹ thuật dữ liệu', '05')
GO
INSERT INTO NGANH(MaNganh, TenNganh, MaKhoa) VALUES
('7510605', N'Logistics và Quản lý Chuỗi Cung ứng', '09'),
('7340120', N'Kinh doanh quốc tế', '09'),
('7140231', N'Ngôn ngữ Anh', '10');
GO

INSERT INTO CTDAOTAO(MaCTDT, TenCTDT, HinhThucDT, NgonNguDT, TrinhDoDaoTao) VALUES
('CTDT1', N'Đại trà', N'Chính Quy', N'Tiếng Việt', N'Đại học'),
('CTDT2', N'CLC', N'Chính Quy', N'Tiếng Việt', N'Đại học'),
('CTDT3', N'CLC', N'Chính Quy', N'Tiếng Anh', N'Đại học'),
('CTDT4', N'CLC', N'Chính Quy', N'Tiếng Nhật', N'Đại học')
GO

INSERT INTO LOP(MaLop, TenLop, MaNganh, MaCTDT) VALUES
('231101A', N'Công nghệ thông tin', '7480201', 'CTDT1'),
('231101B', N'Công nghệ thông tin', '7480201', 'CTDT1'),
('231102A', N'Công nghệ thông tin', '7480201', 'CTDT1'),
('231102B', N'Công nghệ thông tin', '7480201', 'CTDT1'),
('23161A', N'An toàn thông tin', '7480202', 'CTDT1'),
('23162B', N'An toàn thông tin', '7480202', 'CTDT1'),
('231321A', N'Logistics và Quản lý Chuỗi Cung ứng', '7510605', 'CTDT1'),
('23131BE3', N'Ngôn ngữ Anh', '7140231', 'CTDT1');
GO

INSERT INTO TAIKHOAN(TenDangNhap, MatKhau, VaiTro) VALUES
('2006', '123456', N'Giảng Viên'),
('1996', '123456', N'Giảng Viên'),
('1997', '123456', N'Giảng Viên'),
('1998', '123456', N'Giảng Viên'),
('1999', '123456', N'Giảng Viên'),

('1990', '123456', N'Giảng Viên'),
('1991', '123456', N'Giảng Viên'),
('1992', '123456', N'Giảng Viên'),
('1993', '123456', N'Giảng Viên'),
('1994', '123456', N'Giảng Viên'),
('1995', '123456', N'Giảng Viên'),

('23110201', '123456', N'Sinh Viên'),
('23110244', '123456', N'Sinh Viên'),

('2005', '123456', N'Giảng Viên'),

('2500', '123456', N'Quản Lý')
GO

INSERT INTO SINHVIEN(MaSV, HoTenSV, GioiTinh, NgaySinh, MaLop) VALUES
('23110201', N'Trần Lê Quốc Đại', N'Nam', '2005-04-27', '231101A'),
('23110244', N'Đoàn Quang Khôi', N'Nam', '2005-01-08', '231101A')
GO
/* ====== TÀI KHOẢN ====== */
INSERT INTO TAIKHOAN (TenDangNhap, MatKhau, VaiTro) VALUES
-- CNTT (05)
('23110101', '123456', N'Sinh Viên'),
('23110102', '123456', N'Sinh Viên'),
('23110203', '123456', N'Sinh Viên'),
('23110204', '123456', N'Sinh Viên'),
('23110105', '123456', N'Sinh Viên'),
('23110206', '123456', N'Sinh Viên'),

-- ATTT (05)
('23162001', '123456', N'Sinh Viên'),
('23162002', '123456', N'Sinh Viên'),
('23162103', '123456', N'Sinh Viên'),
('23162104', '123456', N'Sinh Viên'),
('23162005', '123456', N'Sinh Viên'),

-- Ngôn ngữ Anh (10)
('23131001', '123456', N'Sinh Viên'),
('23131002', '123456', N'Sinh Viên'),
('23131003', '123456', N'Sinh Viên'),

-- Logistics (09)
('23132101', '123456', N'Sinh Viên'),
('23132102', '123456', N'Sinh Viên');
GO

/* ====== SINH VIÊN ====== */
/* Lưu ý: GioiTinh phải thuộc ('Nam','Nữ','Khác') theo CHECK constraint */
INSERT INTO SINHVIEN (MaSV, HoTenSV, GioiTinh, NgaySinh, MaLop) VALUES
-- CNTT (Khoa 05) - lớp 231101A / 231102A
('23110101', N'Nguyễn Minh An', N'Nam', '2005-03-11', '231101A'),
('23110102', N'Trần Thị Bích Ngọc', N'Nữ', '2005-06-22', '231101A'),
('23110203', N'Phạm Quốc Huy', N'Nam', '2005-01-19', '231102A'),
('23110204', N'Lê Nhật Linh', N'Nữ', '2005-09-05', '231102A'),
('23110105', N'Võ Hữu Nghĩa', N'Nam', '2005-12-01', '231101A'),
('23110206', N'Đặng Quỳnh Anh', N'Nữ', '2005-07-14', '231102A'),

-- ATTT (Khoa 05) - lớp 23161A / 23162B
('23162001', N'Hoàng Gia Bảo', N'Nam', '2005-02-08', '23161A'),
('23162002', N'Đoàn Ngọc Châu', N'Nữ', '2005-10-17', '23161A'),
('23162103', N'Lý Thanh Duy', N'Nam', '2005-04-25', '23162B'),
('23162104', N'Ngô Phương Hà', N'Nữ', '2005-08-30', '23162B'),
('23162005', N'Bùi Đức Khánh', N'Nam', '2005-11-09', '23161A'),

-- Ngôn ngữ Anh (Khoa 10) - lớp 23131BE3
('23131001', N'Phan Thùy Linh', N'Nữ', '2005-05-03', '23131BE3'),
('23131002', N'Vũ Đức Mạnh', N'Nam', '2005-02-21', '23131BE3'),
('23131003', N'Nguyễn Tuyết Nhi', N'Nữ', '2005-07-27', '23131BE3'),

-- Logistics & QL Chuỗi Cung ứng (Khoa 09) - lớp 231321A
('23132101', N'Lâm Anh Khoa', N'Nam', '2005-03-28', '231321A'),
('23132102', N'Phạm Ngọc Yến', N'Nữ', '2005-01-31', '231321A');
GO


INSERT INTO GIANGVIEN(MaGV, HoTenGV, MaKhoa) VALUES
('2006', N'Nguyễn Lê Vân Thanh', '08'),
-- khoa công nghệ thông tin
('2003', N'Phan Thị Huyền Trang', '05'),
('1996', N'Từ Tuyết Hồng', '05'),
('1997', N'Đinh Công Đoan', '05'),
('1998', N'Nguyễn Hữu Trung', '05'),
('1999', N'Tạ Anh Dũng', '05'),
-- khoa chính trị luật
('1990', N'Đỗ Thị Ngọc Lệ', '01'),
('1991', N'Lê Quang Chung', '01'),
('1992', N'Nguyễn Thị Như Thúy', '01'),
('1993', N'Hồ Ngọc Khương', '01'),
-- khoa GDTC
('1994', N'Hàng Long Nhựt', '16'),
('1995', N'Tống Viết Long', '16'),
-- khoa KHUD
('2001', N'Trần Minh Hiền', '05'),
('2002', N'Lai Văn Phút', '05'),
-- khoa công nghệ thông tin 
('2004', N'Hoàng Công Trình', '05'),
('2005', N'Nguyễn Thành Sơn', '05')

GO


INSERT INTO QUANLY(MaQL, TenQL) VALUES
('2500', N'Nguyễn Thị Việt Hà')
GO

INSERT INTO MONHOC(MaMH, TenMH, SoTinChi, MaKhoaPhuTrach) VALUES
-- Chính trị (Khoa 01)
('LLCT130105', N'Triết học Mác - Lênin', 3, '01'),
('GELA220405', N'Pháp luật đại cương', 2, '01'),
('LLCT120205', N'Kinh tế chính trị Mác - Lênin', 2, '01'),
('LLCT120314', N'Tư tưởng Hồ Chí Minh', 2, '01'),
('LLCT220514', N'Lịch sử Đảng CSVN', 2, '01'),

-- Toán - Lý (Khoa 08)
('MATH132401', N'Toán 1', 3, '08'),
('MATH132501', N'Toán 2', 3, '08'),
('MATH132901', N'Xác suất thống kê ứng dụng', 3, '08'),
('PHYS130902', N'Vật lý 1', 3, '08'),
('PHYS111202', N'Thí nghiệm Vật lý 1 (Thực hành)', 1, '08'),

-- Điện tử căn bản (Khoa 06)
('EEEN234162', N'Điện tử căn bản (CTT)', 3, '06'),
('PRBE214262', N'Thực tập điện tử căn bản (Thực hành)', 1, '06'),

-- Giáo dục thể chất (Khoa 16)
('PHED110513', N'Giáo dục thể chất 1', 1, '16'),
('BASK112330', N'Bóng rổ', 1, '16'),
('PICK112330', N'Pickleball', 3, '16'),

-- Giáo dục quốc phòng (Khoa 15)
('GDQP008031', N'Giáo dục quốc phòng 1(ĐH)', 1, '15'),
('GDQP008032', N'Giáo dục quốc phòng 2(ĐH)', 1, '15'),
('GDQP008033', N'Giáo dục quốc phòng 3(ĐH)', 2, '15'),

-- Cơ sở ngành CNTT (Khoa 05)
('INPR140285', N'Nhập môn lập trình', 4, '05'),
('INIT130185', N'Nhập môn ngành CNTT', 3, '05'),
('PRTE230385', N'Kỹ thuật lập trình', 3, '05'),
('DIGR240485', N'Toán rời rạc và lý thuyết đồ thị', 4, '05'),
('DASA230179', N'Cấu trúc dữ liệu và giải thuật', 3, '05'),
('CAAL230180', N'Kiến trúc máy tính và hợp ngữ', 3, '05'),
('IPPA233277', N'Lập Trình Python', 3, '05'),
('DBSY240184', N'Cơ sở dữ liệu', 4, '05'),
('DBMS330284', N'Hệ quản trị cơ sở dữ liệu', 3, '05'),

-- Chuyên ngành CNTT (Khoa 05)
('ARIN330585', N'Trí tuệ nhân tạo', 3, '05'),
('SOEN330679', N'Công nghệ phần mềm', 3, '05'),
('WEPR330479', N'Lập trình Web', 3, '05');
GO


INSERT INTO MONHOC_DAOTAO(MaMHDT, MaMH, MaCTDT, MaNganh) VALUES
-- Môn chính trị
('MHDT001', 'LLCT130105', 'CTDT1', 'GEN-CTPL'),
('MHDT002', 'LLCT130105', 'CTDT2', 'GEN-CTPL'),
('MHDT003', 'LLCT130105', 'CTDT3', 'GEN-CTPL'),
('MHDT004', 'GELA220405', 'CTDT1', 'GEN-CTPL'),
('MHDT005', 'GELA220405', 'CTDT3', 'GEN-CTPL'),
('MHDT006', 'LLCT120205', 'CTDT1', 'GEN-CTPL'),
('MHDT007', 'LLCT120314', 'CTDT1', 'GEN-CTPL'),
('MHDT008', 'LLCT220514', 'CTDT1', 'GEN-CTPL'),
-- Thể chất
('MHDT009', 'PHED110513', 'CTDT1', 'GEN-GDTC'),
('MHDT010', 'PHED110513', 'CTDT2', 'GEN-GDTC'),
('MHDT011', 'BASK112330', 'CTDT1', 'GEN-GDTC'),
-- Toán-Lý
('MHDT012', 'MATH132401', 'CTDT1', 'GEN-KHUD'),
('MHDT013', 'MATH132401', 'CTDT2', 'GEN-KHUD'),
('MHDT014', 'MATH132401', 'CTDT3', 'GEN-KHUD'),
('MHDT015', 'MATH132501', 'CTDT1', 'GEN-KHUD'),
('MHDT016', 'MATH132501', 'CTDT2', 'GEN-KHUD'),
('MHDT017', 'PHYS130902', 'CTDT1', 'GEN-KHUD'),
('MHDT018', 'PHYS130902', 'CTDT3', 'GEN-KHUD'),
('MHDT019', 'MATH132901', 'CTDT1', 'GEN-KHUD'),
('MHDT020', 'MATH132901', 'CTDT3', 'GEN-KHUD'),
-- CNTT
('MHDT021', 'INPR140285', 'CTDT1', '7480201'),
('MHDT022', 'INPR140285', 'CTDT2', '7480201'),
('MHDT023', 'INPR140285', 'CTDT3', '7480201'),
('MHDT024', 'PRTE230385', 'CTDT1', '7480201'),
('MHDT025', 'PRTE230385', 'CTDT3', '7480201'),
('MHDT026', 'DIGR240485', 'CTDT1', '7480201'),
('MHDT027', 'DIGR240485', 'CTDT3', '7480201'),
('MHDT028', 'DASA230179', 'CTDT1', '7480201'),
('MHDT029', 'DASA230179', 'CTDT3', '7480201'),
('MHDT030', 'DASA230179', 'CTDT2', '7480201'),
('MHDT031', 'CAAL230180', 'CTDT1', '7480201'),
('MHDT032', 'CAAL230180', 'CTDT3', '7480201'),
('MHDT033', 'IPPA233277', 'CTDT1', '7480201'),
('MHDT034', 'IPPA233277', 'CTDT2', '7480201'),
('MHDT035', 'IPPA233277', 'CTDT3', '7480201'),
('MHDT036', 'DBSY240184', 'CTDT1', '7480201'),
('MHDT037', 'DBSY240184', 'CTDT3', '7480201'),
('MHDT038', 'DBMS330284', 'CTDT1', '7480201'),
('MHDT039', 'DBMS330284', 'CTDT3', '7480201'),
('MHDT040', 'WEPR330479', 'CTDT3', '7480201')
GO

INSERT INTO LOPHOC(MaLopHoc, MaMHDT, MaGV, SoLuong, TenPhong, Thu, TietBatDau, TietKetThuc, ThoiGianBatDau, ThoiGianKetThuc, HocKy, Nam) VALUES
-- các lớp chính trị
('LLCT130105_01', 'MHDT001', '1993', 75, N'A111', N'Thứ 2', 1, 3, '2025-08-18', '2025-11-03', 'HK1', '2025'),
('LLCT130105_02', 'MHDT001', '1993', 75, N'A112', N'Thứ 2', 7, 9, '2025-08-18', '2025-11-03', 'HK1', '2025'),
('GELA220405_01', 'MHDT004', '1992', 100, N'A211', N'Thứ 2', 2, 4, '2025-08-18', '2025-11-03', 'HK1', '2025'),
('GELA220405_02', 'MHDT004', '1991', 60, N'A121', N'Thứ 3', 7, 9, '2025-08-19', '2025-11-03', 'HK1', '2025'),
('LLCT120205_01', 'MHDT006', '1990', 75, N'A301', N'Thứ 3', 1, 3, '2025-08-19', '2025-11-03', 'HK1', '2025'),
('LLCT120205_02', 'MHDT006', '1991', 75, N'A103', N'Thứ 3', 10, 12, '2025-08-19', '2025-11-03', 'HK1', '2025'),
-- các lớp thể chất
('PHED110513_01', 'MHDT009', '1994', 60, N'05SVD9', N'Thứ 2', 1, 2, '2025-08-18', '2025-11-03', 'HK1', '2025'),
('PHED110513_02', 'MHDT009', '1995', 60, N'05SVD1', N'Thứ 3', 3, 4, '2025-08-19', '2025-11-03', 'HK1', '2025'),
('PHED110513_03', 'MHDT009', '1995', 75, N'05SVD3', N'Thứ 4', 11, 12, '2025-08-20', '2025-11-03', 'HK1', '2025'),
('PHED110513_04', 'MHDT009', '1994', 75, N'05SVD9', N'Thứ 4', 1, 2, '2025-08-20', '2025-11-03', 'HK1', '2025'),
-- các lớp toán lý
-- môn vật lý 1
('PHYS130902_08', 'MHDT017', '2006', 75, N'V305', N'Thứ 6', 4, 6, '2025-08-22', '2025-11-03', 'HK1', '2025'),
('PHYS130902_09', 'MHDT017', '2006', 50, N'V404', N'Thứ 3', 8, 10, '2025-08-19', '2025-11-03', 'HK1', '2025'),
-- môn toán 1 + 2
('MATH132401_01', 'MHDT012', '2001', 75, N'V302', N'Thứ 7', 1, 3, '2025-08-23', '2025-11-03', 'HK1', '2025'),
('MATH132401_03', 'MHDT012', '2001', 50, N'V401', N'Thứ 5', 8, 10, '2025-08-21', '2025-11-03', 'HK1', '2025'),
('MATH132501_05', 'MHDT015', '2002', 75, N'V303', N'Thứ 6', 4, 6, '2025-08-22', '2025-11-03', 'HK1', '2025'),
('MATH132501_07', 'MHDT015', '2002', 50, N'V204', N'Thứ 5', 3, 5, '2025-08-21', '2025-11-03', 'HK1', '2025'),

-- các lớp công nghệ thông tin
('INPR140285_02', 'MHDT021', '1999', 40, N'A5-203', N'Thứ 5', 1, 5, '2025-08-21', '2025-11-03', 'HK1', '2025'),
('INPR140285_04', 'MHDT021', '1996', 100, N'B309', N'Thứ 2', 7, 11, '2025-08-18', '2025-11-03', 'HK1', '2025'),
('PRTE230385_25', 'MHDT024', '2004', 75, N'A303', N'Thứ 5', 7, 10, '2025-08-21', '2025-11-03', 'HK1', '2025'),
('PRTE230385_26', 'MHDT024', '1999', 75, N'A110', N'Thứ 3', 2, 5, '2025-08-19', '2025-11-03', 'HK1', '2025'),
('DIGR240485_09', 'MHDT026', '1996', 100, N'A111', N'Thứ 7', 7, 11, '2025-08-23', '2025-11-03', 'HK1', '2025'),

('DBSY240184_01', 'MHDT036', '2005', 75, N'A204', N'Thứ 4', 7, 11, '2025-08-20', '2025-11-03', 'HK1', '2025'),
('DBSY240184_02', 'MHDT036', '2005', 75, N'A203', N'Thứ 2', 1, 5, '2025-08-18', '2025-11-03', 'HK1', '2025'),
('DBMS330284_03', 'MHDT038', '2005', 75, N'A5-204', N'Thứ 4', 1, 4, '2025-08-20', '2025-11-03', 'HK1', '2025'),
('DBMS330284_04', 'MHDT038', '2005', 75, N'A5-203', N'Thứ 5', 7, 11, '2025-08-21', '2025-11-03', 'HK1', '2025'),
('IPPA233277_01', 'MHDT033', '2003', 100, N'A111', N'Thứ 6', 7, 10, '2025-08-22', '2025-11-03', 'HK1', '2025')
GO

/*VIEW*/
-- View 1: Danh sách sinh viên đăng kí môn học
CREATE VIEW View_DanhSachDKMH
AS
	SELECT sv.MaSV, sv.HoTenSV, NGANH.TenNganh
	FROM SINHVIEN sv
	JOIN LOP ON LOP.MaLop = sv.MaLop
	JOIN NGANH ON NGANH.MaNganh = LOP.MaNganh
GO
-- Thực hiện: SELECT * FROM View_DanhSachDKMH

-- View 2: Danh sách môn học đào tạo 
CREATE VIEW View_DanhSachMHDT
AS
	SELECT mhdt.MaMHDT, mh.TenMH, mh.SoTinChi, ctdt.TenCTDT, ctdt.NgonNguDT, ng.TenNganh
	FROM MONHOC_DAOTAO mhdt
	JOIN NGANH ng ON ng.MaNganh = mhdt.MaNganh
	JOIN MONHOC mh ON mh.MaMH = mhdt.MaMH
	JOIN CTDAOTAO ctdt ON ctdt.MaCTDT = mhdt.MaCTDT
GO
-- Thực hiện: SELECT * FROM View_DanhSachMHDT

-- View 3: Tổng số tín chỉ của sinh viên 
CREATE VIEW View_TongSoTinChi (HocKy, Nam, MaSV, TenSV, TongSoTinChi)
AS
	SELECT lh.HocKy, lh.Nam, sv.MaSV, sv.HoTenSV, sum(mh.SoTinChi)
	FROM SINHVIEN sv
	JOIN DANGKY dk ON sv.MaSV = dk.MaSV
	JOIN LOPHOC lh ON dk.MaLopHoc = lh.MaLopHoc
	JOIN MONHOC_DAOTAO mhdt ON lh.MaMHDT = mhdt.MaMHDT
	JOIN MONHOC mh ON mhdt.MaMH = mh.MaMH
	GROUP BY lh.HocKy, lh.Nam, sv.MaSV, sv.HoTenSV
GO
--select * from View_TongSoTinChi

-- View 4: số lượng sinh viên của lớp học 
CREATE VIEW View_SoLuongSVLop (MaLopHoc, SoLuong)
AS
	SELECT lh.MaLopHoc, COUNT (dk.MaSV)
	FROM LOPHOC lh 
	LEFT JOIN DANGKY dk ON lh.MaLopHoc = dk.MaLopHoc -- dùng left join để lớp nào chưa đăng kí thì là 0
	GROUP BY lh.MaLopHoc
GO


/*=====================TRIGGER=====================*/
-- Trigger 1: Không cho phép đăng ký trùng lịch học
CREATE TRIGGER TRG_DANGKY_CheckTrung_AI
ON DANGKY
AFTER INSERT
AS
BEGIN
	IF EXISTS (
		SELECT 1
		FROM inserted i
		JOIN LOPHOC lh_new ON lh_new.MaLopHoc = i.MaLopHoc
		JOIN DANGKY dk_old ON dk_old.MaSV = i.MaSV
		JOIN LOPHOC lh_old ON lh_old.MaLopHoc = dk_old.MaLopHoc
		WHERE
			-- cùng thứ (chuẩn hóa khoảng trắng)
			LTRIM(RTRIM(lh_new.Thu)) = LTRIM(RTRIM(lh_old.Thu))
			AND lh_new.ThoiGianBatDau <= lh_old.ThoiGianKetThuc
			AND lh_old.ThoiGianBatDau <= lh_new.ThoiGianKetThuc
			AND NOT (lh_new.TietKetThuc < lh_old.TietBatDau OR lh_old.TietKetThuc < lh_new.TietBatDau)
			AND lh_new.MaLopHoc <> lh_old.MaLopHoc
	)
	BEGIN 
		RAISERROR (N'Trùng lịch với lớp đã đăng ký.', 16, 1);
        ROLLBACK;
        RETURN;
	END
END
GO

-- Trigger: Không cho phép đăng ký vượt qua giới hạn của lớp 
CREATE TRIGGER TRG_DANGKY_CheckSoLuongSV_AI
ON DANGKY 
AFTER INSERT
AS
BEGIN
	IF EXISTS (
		SELECT 1
		FROM inserted i
		JOIN LOPHOC lh ON lh.MaLopHoc = i.MaLopHoc
		JOIN (SELECT MaLopHoc, count(*) AS SL
			FROM DANGKY
			GROUP BY MaLopHoc
		) dk ON dk.MaLopHoc = i.MaLopHoc
		WHERE dk.SL > lh.SoLuong
	)
	BEGIN
        RAISERROR (N'Lớp đã đầy, không thể đăng ký thêm.', 16, 1)
        ROLLBACK
        RETURN
    END
END
GO

-- Trigger: Không cho phép đăng ký trùng môn (một học phần mà đăng ký nhiều lớp)
CREATE TRIGGER TRG_DANGKY_CheckTrungMon_AI
ON DANGKY
AFTER INSERT
AS
	BEGIN
		IF EXISTS (
			SELECT 1
			FROM inserted i
			JOIN LOPHOC lh_new ON lh_new.MaLopHoc = i.MaLopHoc
			JOIN MONHOC_DAOTAO mhdt_new ON mhdt_new.MaMHDT = lh_new.MaMHDT
			JOIN DANGKY dk_old ON dk_old.MaSV = i.MaSV
			JOIN LOPHOC lh_old ON lh_old.MaLopHoc = dk_old.MaLopHoc
			JOIN MONHOC_DAOTAO mhdt_old ON mhdt_old.MaMHDT = lh_old.MaMHDT
			WHERE mhdt_new.MaMH = mhdt_old.MaMH and lh_new.MaLopHoc <> lh_old.MaLopHoc
		)
		 BEGIN
			RAISERROR (N'Bạn đã đăng ký môn này rồi (ở lớp khác).', 16, 1);
			ROLLBACK;
			RETURN;
		END
	END
GO



/*=====================THỦ TỤC KHÔNG CÓ THAM SỐ=====================*/
--Thủ tục 1: Lấy danh sách tài khoản
CREATE PROC NonP_DSTaiKhoan
AS
	SELECT * FROM TAIKHOAN
GO
-- Thực hiện: EXEC NonP_DSTaiKhoan

--Thủ tục 2: Lấy danh sách sinh viên được đăng ký môn học
CREATE PROC NonP_DanhSachDKMH
AS
	SELECT * FROM View_DanhSachDKMH
GO
-- Thực hiện: EXEC NonP_DanhSachDKMH

--Thủ tục 3: Lấy danh sách cụ thể các môn học đào tạo
CREATE PROC NonP_DanhSachMHDT
AS
	SELECT * FROM View_DanhSachMHDT
go
-- Thực hiện: EXEC NonP_DanhSachMHDT

-- Thủ tục 4: Lấy danh sách các môn học
CREATE PROC NonP_DanhSachMH
AS
	SELECT * FROM MONHOC
GO
-- Thực hiện: EXEC NonP_DanhSachMH

-- Thủ tục 5: Lấy danh sách chương trình đào tạo
CREATE PROC NonP_DanhSachCTDT
AS
	SELECT * FROM CTDAOTAO
GO
-- Thực hiện: EXEC NonP_DanhSachCTDT

-- Thủ tục 6: Lấy danh sách lớp 
CREATE PROC NonP_DanhSachLop
AS
	SELECT lop.MaLop, lop.TenLop, ng.TenNganh, ctdt.TenCTDT
	FROM LOP lop 
	JOIN NGANH ng ON ng.MaNganh = lop.MaNganh
	JOIN CTDAOTAO ctdt ON ctdt.MaCTDT = lop.MaCTDT
GO
-- Thực hiện: EXEC NonP_DanhSachLop

--Thủ tục: Danh sách giảng viên
CREATE PROC NonP_DanhSachGV
AS
	SELECT gv.MaGV, gv.HoTenGV, kh.TenKhoa
	FROM GIANGVIEN gv
	JOIN KHOA kh ON kh.MaKhoa = gv.MaKhoa
GO

-- Thủ tục: Tìm kiếm lớp học 
CREATE PROC HasP_TimKiemLop @MaLH nvarchar(20)
AS
	SELECT * FROM LOPHOC WHERE MaLopHoc LIKE N'%' + @MaLH + N'%';
GO

/*=====================THỦ TỤC CÓ TRẢ VỀ=====================*/
-- PROC đổi mật khẩu
CREATE PROC Re_DoiMatKhau
	@MatKhau nvarchar (20), 
	@TenDangNhap nvarchar(20)
AS
BEGIN TRANSACTION
	IF (@MatKhau IS NULL OR @TenDangNhap IS NULL)
	BEGIN 
		RAISERROR(N'Không được để trống!', 16, 1)
		ROLLBACK
		RETURN
	END

	UPDATE TAIKHOAN SET MatKhau = @MatKhau where TenDangNhap = @TenDangNhap
	IF (@@ERROR <> 0)
	BEGIN
		RAISERROR(N'Có lỗi!', 16, 1)
		ROLLBACK
		RETURN
	END
COMMIT TRANSACTION
GO
-- Thực hiện: EXEC Re_DoiMatKhau '111111', '23110201'

-- Thủ tục: Thêm sinh viên 
CREATE PROC Re_ThemSV (@TenDangNhap nvarchar(20), @MatKhau nvarchar(20), @HoTenSV nvarchar(100), @GioiTinh nvarchar(10), @NgaySinh date, @MaLop nvarchar(20))
AS
	BEGIN TRANSACTION 
	IF (@TenDangNhap IS NULL OR @MatKhau IS NULL OR @HoTenSV IS NULL OR @GioiTinh IS NULL OR @NgaySinh IS NULL OR @MaLop IS NULL)
	BEGIN
		RAISERROR('Các trường không được để trống!', 16, 1);
		ROLLBACK
		RETURN
	END
	INSERT INTO TAIKHOAN VALUES (@TenDangNhap, @MatKhau, 'Sinh Viên')
	INSERT INTO SINHVIEN VALUES (@TenDangNhap, @HoTenSV, @GioiTinh, @NgaySinh, @MaLop)
	IF (@@ERROR <> 0)
	BEGIN 
		RAISERROR('Có lỗi!', 16, 1);
		ROLLBACK
		RETURN
	END
	COMMIT TRANSACTION
GO
-- Thực hiện: EXEC Re_ThemSV '23110353', '123456', N'Vũ Quốc Trung', N'Nam', '2005-01-29', '231101A'


-- Thủ tục: Cập nhật sinh viên 
CREATE PROC Re_CapNhatSV (@TenDangNhap nvarchar(20), @HoTenSV nvarchar(100)=null, @GioiTinh nvarchar(10)=null, @NgaySinh date=null, @MaLop nvarchar(20)=null, @NewMaSV nvarchar(20)=null)
AS
	BEGIN TRAN
	BEGIN 
		DECLARE @olHoTenSV nvarchar(100), @olGioiTinh nvarchar(10), @olNgaySinh date, @olMaLop nvarchar(20)
		SELECT @olHoTenSV = sv.HoTenSV, @olGioiTinh = sv.GioiTinh, @olNgaySinh = sv.NgaySinh, @olMaLop = sv.MaLop
		FROM SINHVIEN sv WHERE sv.MaSV = @TenDangNhap

		IF @HoTenSV IS NULL SET @HoTenSV = @olHoTenSV
		IF @GioiTinh IS NULL SET @GioiTinh = @olGioiTinh
		IF @NgaySinh IS NULL SET @NgaySinh = @olNgaySinh
		IF @MaLop IS NULL SET @MaLop = @olMaLop
		IF @NewMaSV IS NULL SET @NewMaSV = @TenDangNhap

		-- B1: Update MSSV ở bảng TAIKHOAN trước
        IF @NewMaSV <> @TenDangNhap
        BEGIN
            UPDATE TAIKHOAN
            SET TenDangNhap = @NewMaSV
            WHERE TenDangNhap = @TenDangNhap;
        END

		-- B2: Update các thông tin khác trong SINHVIEN
        UPDATE SINHVIEN
        SET HoTenSV = @HoTenSV,
            GioiTinh = @GioiTinh,
            NgaySinh = @NgaySinh,
            MaLop = @MaLop
        WHERE MaSV = @NewMaSV;
	END
	IF (@@ERROR <> 0)
	BEGIN	
		RAISERROR('Có lỗi!', 16, 1);
		ROLLBACK
		RETURN
	END
	COMMIT TRAN
GO
-- Thực hiện: EXEC Re_CapNhatSV '231102248', null, N'Nữ', null, null, '23110248';
-- drop proc Re_CapNhatSV

EXEC sp_helpconstraint 'dbo.SINHVIEN';

-- Thủ tục: Xóa sinh viên 
CREATE PROC Re_XoaSV (@MaSV nvarchar(20))
AS
	BEGIN TRAN
	DELETE SINHVIEN where SINHVIEN.MaSV = @MaSV
	DELETE TAIKHOAN where TAIKHOAN.TenDangNhap = @MaSV
	IF (@@ERROR <> 0)
	BEGIN	
		RAISERROR('Có lỗi!', 16, 1);
		ROLLBACK
		RETURN
	END
	COMMIT TRAN
GO
-- Thực hiện: EXEC Re_XoaSV '23110353'

-- Thủ tục: Thêm môn học
CREATE PROC Re_ThemMH (@MaMH nvarchar(20), @TenMH nvarchar(100), @SoTinChi int, @MaKhoaPhuTrach nvarchar(20))
AS
	BEGIN TRAN
		IF (@MaMH IS NULL OR @TenMH IS NULL OR @SoTinChi IS NULL OR @MaKhoaPhuTrach IS NULL)
		BEGIN
			RAISERROR(N'Các trường không được để trống!', 16, 1);
			ROLLBACK
			RETURN
		END
		INSERT INTO MONHOC VALUES (@MaMH, @TenMH, @SoTinChi, @MaKhoaPhuTrach)
		IF (@@ERROR <> 0)
		BEGIN
			RAISERROR (N'Có lỗi', 16, 1)
			ROLLBACK
			RETURN
		END
	COMMIT TRAN
GO

-- Thủ tục: Xóa môn học 
CREATE PROC Re_XoaMH(@MaMH nvarchar(20))
AS
	BEGIN TRAN
	DELETE MONHOC WHERE MONHOC.MaMH = @MaMH
	IF (@@ERROR <> 0)
	BEGIN
		RAISERROR(N'Có lỗi!', 16, 1);
		ROLLBACK
		RETURN
	END
	COMMIT TRAN
GO
-- Thực hiện: EXEC Re_XoaMH 'PICK112330'
SELECT * FROM MONHOC_DAOTAO

-- Thủ tục: Thêm môn học - đào tạo
CREATE PROC Re_ThemMHDT (@MaMHDT nvarchar(20), @MaMH nvarchar(20), @MaCTDT nvarchar(20), @MaNganh nvarchar(20))
AS
	BEGIN TRAN
	IF (@MaMHDT IS NULL OR @MaMH IS NULL OR @MaCTDT IS NULL OR @MaNganh IS NULL)
	BEGIN
		RAISERROR(N'Các trường không được để trống!', 16, 1)
		ROLLBACK
		RETURN
	END
	INSERT INTO MONHOC_DAOTAO VALUES (@MaMHDT, @MaMH, @MaCTDT, @MaNganh)
	IF (@@ERROR <> 0)
	BEGIN
		RAISERROR (N'Có lỗi!', 16, 1)
		ROLLBACK 
		RETURN
	END
	COMMIT TRAN
GO
-- Thực hiện: EXEC Re_ThemMHDT 'MHDT31', 'WEPR330479', 'CTDT4', '7480201'

-- Thủ tục: Xóa môn học - đào tạo
CREATE PROC Re_XoaMHDT (@MaMHDT nvarchar(20))
AS
	BEGIN TRAN
	IF (@MaMHDT IS NULL)
	BEGIN 
		RAISERROR(N'Các trường không được để trống!', 16, 1)
		ROLLBACK
		RETURN
	END
	DELETE FROM MONHOC_DAOTAO WHERE MaMHDT = @MaMHDT
	IF (@@ERROR <> 0)
	BEGIN
		RAISERROR (N'Có lỗi!', 16, 1)
		ROLLBACK 
		RETURN
	END
	COMMIT TRAN
GO
-- Thực hiện: EXEC Re_XoaMHDT 'MHDT31'

-- Hàm: Thêm khoa 
CREATE PROC Re_ThemKhoa(@MaKhoa nvarchar(20), @TenKhoa nvarchar(100))
AS
	BEGIN TRAN
	IF (@MaKhoa IS NULL OR @TenKhoa IS NULL)
	BEGIN
		RAISERROR(N'Các trường không được để trống!', 16, 1)
		ROLLBACK
		RETURN
	END
	INSERT INTO KHOA VALUES (@MaKhoa, @TenKhoa)
	IF (@@ERROR <> 0)
	BEGIN
		RAISERROR (N'Có lỗi!', 16, 1)
		ROLLBACK 
		RETURN
	END
	COMMIT TRAN
GO
-- EXEC Re_ThemKhoa '2704', N'Chứng khoán'

-- Hàm: Xóa khoa
CREATE PROC Re_XoaKhoa(@MaKhoa nvarchar(20))
AS
	BEGIN TRAN
	IF (@MaKhoa IS NULL)
	BEGIN
		RAISERROR(N'Các trường không được để trống!', 16, 1)
		ROLLBACK
		RETURN
	END
	DELETE FROM KHOA WHERE KHOa.MaKhoa = @MaKhoa
	IF (@@ERROR <> 0)
	BEGIN
		RAISERROR (N'Có lỗi!', 16, 1)
		ROLLBACK 
		RETURN
	END
	COMMIT TRAN
GO
-- EXEC Re_XoaKhoa '2704'

-- Hàm: Thêm lớp
CREATE PROC Re_ThemLop(@MaLop nvarchar(20), @TenLop nvarchar(100), @MaNganh nvarchar(20), @MaCTDT nvarchar(20))
AS
	BEGIN TRAN
	IF (@MaLop IS NULL OR @TenLop IS NULL OR @MaNganh IS NULL OR @MaCTDT IS NULL)
	BEGIN 
		RAISERROR(N'Các trường không được để trống!', 16, 1)
		ROLLBACK
		RETURN
	END
	INSERT INTO LOP VALUES (@MaLop, @TenLop, @MaNganh, @MaCTDT)
	IF (@@ERROR <> 0)
	BEGIN
		RAISERROR (N'Có lỗi!', 16, 1)
		ROLLBACK 
		RETURN
	END
	COMMIT TRAN
GO
-- Hàm: Xóa lớp
CREATE PROC Re_XoaLop(@MaLop nvarchar(20))
AS
	BEGIN TRAN
	IF (@MaLop IS NULL)
	BEGIN 
		RAISERROR(N'Các trường không được để trống!', 16, 1)
		ROLLBACK
		RETURN
	END
	DELETE FROM LOP WHERE LOP.MaLop = @MaLop
	IF (@@ERROR <> 0)
	BEGIN
		RAISERROR (N'Có lỗi!', 16, 1)
		ROLLBACK 
		RETURN
	END
	COMMIT TRAN
GO

-- Hàm: Thêm ngành 
CREATE PROC Re_ThemNganh(@MaNganh nvarchar(20), @TenNganh nvarchar(100), @MaKhoa nvarchar(20))
AS
	BEGIN TRAN
	IF (@MaNganh IS NULL OR @TenNganh IS NULL OR @MaKhoa IS NULL)
	BEGIN 
		RAISERROR(N'Các trường không được để trống!', 16, 1)
		ROLLBACK
		RETURN
	END
	INSERT INTO NGANH VALUES (@MaNganh, @TenNganh, @MaKhoa)
	IF (@@ERROR <> 0)
	BEGIN 
		RAISERROR (N'Có lỗi!', 16, 1)
		ROLLBACK 
		RETURN
	END
	COMMIT TRAN
GO
-- Hàm: Xóa ngành
CREATE PROC Re_XoaNganh(@MaNganh nvarchar(20))
AS
	BEGIN TRAN
	IF (@MaNganh IS NULL)
	BEGIN 
		RAISERROR(N'Các trường không được để trống!', 16, 1)
		ROLLBACK
		RETURN
	END
	DELETE FROM NGANH WHERE NGANH.MaNganh = @MaNganh
	IF (@@ERROR <> 0)
	BEGIN 
		RAISERROR (N'Có lỗi!', 16, 1)
		ROLLBACK 
		RETURN
	END
	COMMIT TRAN
GO

-- Hàm: Thêm giảng viên 
CREATE PROC Re_ThemGV(@TenDangNhap nvarchar(20), @MatKhau nvarchar(20), @HoTenGV nvarchar(100), @MaKhoa nvarchar(20))
AS
	BEGIN TRAN
	IF (@TenDangNhap IS NULL OR @MatKhau IS NULL OR @HoTenGV IS NULL OR @MaKhoa IS NULL)
	BEGIN 
		RAISERROR(N'Các trường không được để trống!', 16, 1)
		ROLLBACK
		RETURN
	END
	INSERT INTO TAIKHOAN VALUES (@TenDangNhap, @MatKhau, N'Giảng Viên')
	INSERT INTO GIANGVIEN VALUES (@TenDangNhap, @HoTenGV, @MaKhoa)
	IF (@@ERROR <> 0)
	BEGIN 
		RAISERROR (N'Có lỗi!', 16, 1)
		ROLLBACK 
		RETURN
	END
	COMMIT TRAN
GO
-- Hàm: Xóa giảng viên 
CREATE PROC Re_XoaGV(@MaGV nvarchar(20))
AS
	BEGIN TRAN
	IF (@MaGV IS NULL)
	DELETE FROM TAIKHOAN WHERE TAIKHOAN.TenDangNhap = @MaGV
	DELETE FROM GIANGVIEN WHERE GIANGVIEN.MaGV = @MaGV
	IF (@@ERROR <> 0)
	BEGIN 
		RAISERROR (N'Có lỗi!', 16, 1)
		ROLLBACK 
		RETURN
	END
	COMMIT TRAN
GO

-- Hàm: Thêm lớp học
CREATE PROC Re_ThemLH (@MaLopHoc nvarchar(20), @MaMHDT nvarchar(20), @MaGV nvarchar(20), @SoLuong int, @Phong nvarchar(20), @Thu nvarchar(20), @TietBatDau int, @TietKetThuc int, @ThoiGianBatDau date, @ThoiGianKetThuc date, @HocKy nvarchar(5), @Nam int)
AS
	BEGIN TRAN
	IF (@MaLopHoc is null or @MaMHDT is null or @MaGV  is null or @SoLuong is null or @Phong is null or @Thu is null or @TietBatDau is null or @TietKetThuc is null or @ThoiGianBatDau is null or @HocKy is null or @Nam is null)
	BEGIN
		RAISERROR(N'Các trường không được để trống!', 16, 1);
		ROLLBACK
		RETURN
	END

	INSERT INTO LOPHOC VALUES (@MaLopHoc, @MaMHDT, @MaGV, @SoLuong, @Phong, @Thu, @TietBatDau, @TietKetThuc, @ThoiGianBatDau, @ThoiGianKetThuc, @HocKy, @Nam)
	IF (@@ERROR <> 0)
	BEGIN 
		RAISERROR (N'Có lỗi!', 16, 1)
		ROLLBACK 
		RETURN
	END
	COMMIT TRAN
GO

CREATE PROC Re_XoaLH (@MaLopHoc nvarchar(20))
AS
	BEGIN TRAN
	IF (@MaLopHoc is null)
	BEGIN 
		RAISERROR(N'Các trường không được để trống!', 16, 1)
		ROLLBACK
		RETURN
	END
	DELETE FROM LOPHOC where LOPHOC.MaLopHoc = @MaLopHoc
	IF (@@ERROR <> 0)
	BEGIN 
		RAISERROR (N'Có lỗi!', 16, 1)
		ROLLBACK 
		RETURN
	END
	COMMIT TRAN
GO

-- Thủ tục: đăng ký môn học
CREATE PROC Re_DangKyLH (@MaLopHoc nvarchar(20), @MaSV nvarchar(20))
AS
	BEGIN TRAN
	IF (@MaLopHoc IS NULL OR @MaSV IS NULL)
	BEGIN 
		RAISERROR(N'Các trường không được để trống!', 16, 1)
		ROLLBACK
		RETURN
	END

	INSERT INTO DANGKY VALUES (@MaSV, @MaLopHoc)
	IF (@@ERROR <> 0)
	BEGIN 
		RAISERROR (N'Có lỗi!', 16, 1)
		ROLLBACK 
		RETURN
	END
	COMMIT TRAN
GO

-- Thủ tục: xóa đăng ký môn học
CREATE PROC Re_XoaDangKyLH (@MaLopHoc nvarchar(20), @MaSV nvarchar(20))
AS
	BEGIN TRAN
	IF (@MaLopHoc IS NULL OR @MaSV IS NULL)
	BEGIN 
		RAISERROR(N'Các trường không được để trống!', 16, 1)
		ROLLBACK
		RETURN
	END

	DELETE FROM DANGKY WHERE MaLopHoc = @MaLopHoc and MaSV = @MaSV
	IF (@@ERROR <> 0)
	BEGIN 
		RAISERROR (N'Có lỗi!', 16, 1)
		ROLLBACK 
		RETURN
	END
	COMMIT TRAN
GO


/*=====================HÀM TRẢ VỀ MỘT GIÁ TRỊ=====================*/

-- Hàm: Tổng sinh viên của khoa
CREATE FUNCTION RNO_TongSVKhoa (@khoa nvarchar(100)) RETURNS INT
AS
BEGIN 
	DECLARE @SL INT
	SELECT @SL = COUNT(*)
	FROM SINHVIEN sv 
	JOIN LOP lop ON lop.MaLop = sv.MaLop
	JOIN NGANH ng ON ng.MaNganh = lop.MaNganh
	JOIN KHOA kh ON kh.MaKhoa = ng.MaKhoa
	WHERE kh.TenKhoa like '%' + @khoa + '%' OR kh.MaKhoa = @khoa
	
	RETURN @SL
END
GO
-- Thực hiện: SELECT dbo.RNO_TongSVKhoa(N'Công nghệ Thông tin')
-- Thực hiện: SELECT dbo.RNO_TongSVKhoa('05')
-- drop function RNO_TongSVKhoa

-- Hàm: Tổng sinh viên của ngành
CREATE FUNCTION RNO_TongSVNganh (@nganh nvarchar(100)) RETURNS INT
AS
BEGIN
	DECLARE @SL INT 
	SELECT @SL = COUNT(*)
	FROM SINHVIEN sv
	JOIN LOP lop ON LOP.MaLop = sv.MaLop
	JOIN NGANH ng ON ng.MaNganh = lop.MaNganh
	WHERE ng.TenNganh like '%' + @nganh + '%' OR ng.MaNganh = @nganh
	RETURN @SL
END
GO
-- Thực hiện: SELECT dbo.RNO_TongSVNganh(N'Công nghệ Thông tin')
-- Thực hiện: SELECT dbo.RNO_TongSVNganh('7480201')
-- drop function RNO_TongSVNganh

-- Hàm: Tổng sinh viên của lớp học
CREATE FUNCTION RNO_TongSVLopHoc(@MaLH nvarchar(20)) RETURNS INT
AS
BEGIN	
	DECLARE @SL INT 
	SELECT @SL = COUNT(*)
	FROM LOPHOC lh
	JOIN DANGKY dk ON dk.MaLopHoc = lh.MaLopHoc
	WHERE lh.MaLopHoc = @MaLH
	RETURN @SL
END
GO

/*=====================HÀM TRẢ VỀ MỘT BẢNG CÓ MỘT CÂU LỆNH=====================*/

-- Hàm: Đăng nhập 
CREATE FUNCTION RTO_DangNhap(@ma nvarchar(20), @matkhau nvarchar(20)) RETURNS TABLE
AS
	RETURN (SELECT * FROM TAIKHOAN tk where tk.TenDangNhap = @ma and tk.MatKhau = @matkhau)
GO
--Thực hiện: SELECT * FROM dbo.RTO_DangNhap('23110201', '123456')
--Xóa bảng: DROP FUNCTION RTO_DangNhap

-- Hàm : Lấy thông tin của sinh viên
CREATE FUNCTION RTO_ThongTinSV(@masv nvarchar(20)) RETURNS TABLE
AS
	RETURN (SELECT sv.MaSV, sv.HoTenSV, sv.GioiTinh, sv.NgaySinh, sv.MaLop FROM SINHVIEN sv WHERE sv.MaSV LIKE '%' + @masv + '%')
GO
-- Thực hiện: SELECT * FROM dbo.RTO_ThongTinSV('23110244')
-- Xóa hàm: DROP FUNCTION RTO_ThongTinSV

-- Hàm: Lấy thông tin của quản lý
CREATE FUNCTION RTO_ThongTinQL(@maql nvarchar(20)) RETURNS TABLE
AS 
	RETURN (SELECT ql.MaQL, ql.TenQL FROM QUANLY ql WHERE ql.MaQL = @maql)
GO
-- Thực hiện: SELECT * FROM dbo.RTO_ThongTinQL('2500')
-- Xóa hàm: DROP FUNCTION RTO_ThongTinQL

-- Hàm: Lấy thông tin sinh viên của lớp
CREATE FUNCTION RTO_ThongTinSVLop(@MaLop nvarchar(20)) RETURNS TABLE
AS
	RETURN (SELECT sv.MaSV, sv.HoTenSV, sv.GioiTinh, sv.NgaySinh, sv.MaSV
	FROM SINHVIEN sv
	JOIN LOP lop ON lop.MaLop = sv.MaLop
	WHERE lop.MaLop LIKE '%' + @MaLop + '%')
GO
-- Thực hiện: select * from dbo.RTO_ThongTinSVLop('23')
-- drop function RTO_ThongTinSVLop

-- Hàm lấy thông tin của giảng viên
CREATE FUNCTION RTO_ThongTinGV(@magv nvarchar(20)) RETURNS TABLE
AS 
	RETURN (SELECT gv.MaGV, gv.HoTenGV, khoa.TenKhoa FROM GIANGVIEN gv, KHOA khoa WHERE gv.MaKhoa = khoa.MaKhoa AND gv.MaGV = @magv )
GO
-- Thực hiện: SELECT * FROM dbo.RTO_ThongTinGV('2005')
-- Xóa hàm: DROP FUNCTION RTO_ThongTinGV

--Hàm: Tìm kiếm môn học
CREATE FUNCTION RTO_TimKiemMonHoc(@MaMH nvarchar(20)) RETURNS TABLE
AS
	RETURN (SELECT * FROM MONHOC WHERE MONHOC.MaMH LIKE '%' + @MaMH + '%')
GO
-- Thực hiện SELECT * FROM RTO_TimKiemMonHoc('PICK')
-- drop function RTO_TimKiemMonHoc

--Hàm: Tìm kiếm môn học đào tạo
CREATE FUNCTION RTO_TimKiemMHDT(@MaMHDT nvarchar(20)) RETURNS TABLE
AS
	RETURN (SELECT * FROM View_DanhSachMHDT WHERE MaMHDT = @MaMHDT)
GO
--Thực hiện: select * from dbo.RTO_TimKiemMHDT('MHDT002')
--drop function RTO_TimKiemMHDT

-- Hàm: Danh sách khoa
CREATE FUNCTION RTO_DanhSachKhoa() RETURNS TABLE
AS
	RETURN (SELECT * FROM KHOA)
GO
--Thực hiện: select * from dbo.RTO_DanhSachKhoa()
--drop function RTO_DanhSachKhoa

-- Hàm: Tìm kiếm khoa
CREATE FUNCTION RTO_TimKiemKhoa(@MaKhoa nvarchar(20)) RETURNS TABLE
AS
	RETURN (SELECT * FROM KHOA WHERE KHOA.MaKhoa = @MaKhoa)
GO
--Thực hiện: select * from dbo.RTO_TimKiemKhoa('05')
--drop function RTO_TimKiemKhoa

-- Hàm: Danh sách ngành 
CREATE FUNCTION RTO_DanhSachNganh() RETURNS TABLE
AS
	RETURN (SELECT ng.MaNganh, ng.TenNganh, kh.TenKhoa
	FROM NGANH ng 
	JOIN KHOA kh ON kh.MaKhoa = ng.MaKhoa)
GO
--Thực hiện: select * from dbo.RTO_DanhSachNganh()

-- Hàm: Tìm kiếm ngành 
CREATE FUNCTION RTO_TimKiemNganh(@MaNganh nvarchar(20)) RETURNS TABLE
AS
	RETURN (SELECT ng.MaNganh, ng.TenNganh, kh.TenKhoa
	FROM NGANH ng
	JOIN KHOA kh ON kh.MaKhoa = ng.MaKhoa
	WHERE ng.MaNganh = @MaNganh)
GO
--Thực hiện: select * from dbo.RTO_TimKiemNganh('7480201')

-- Hàm: Danh sách sinh viên của một lớp học
CREATE FUNCTION RTO_DanhSachSVLopHoc(@MaLH nvarchar(20)) RETURNS TABLE
AS
	RETURN (
		SELECT sv.MaSV, sv.HoTenSV, sv.GioiTinh, sv.NgaySinh, sv.MaLop
		FROM SINHVIEN sv
		JOIN DANGKY dk ON dk.MaSV = sv.MaSV
		WHERE dk.MaLopHoc = @MaLH
	)
GO

/*=====================HÀM TRẢ VỀ MỘT BẢNG CÓ NHIỀU CÂU LỆNH=====================*/

--Hàm: Danh sách các học phần trong chương trình đào tạo của sinh viên
CREATE FUNCTION RTM_HocPhanCTDTSV (@MaSV nvarchar(20))
RETURNS @table TABLE (MaMH nvarchar(20), TenMH nvarchar(100), SoTinChi int, SoLHP int) 
AS
BEGIN 
	INSERT @table 
	SELECT DISTINCT mh.MaMH, mh.TenMH, mh.SoTinChi, COUNT(lh.MaLopHoc) AS SoLHP
	FROM SINHVIEN sv
	JOIN LOP lop ON LOP.MaLop = sv.MaLop
	JOIN MONHOC_DAOTAO mhdt ON mhdt.MaCTDT = lop.MaCTDT 
		AND (mhdt.MaNganh = lop.MaNganh OR mhdt.MaNganh IN ('GEN-CTPL','GEN-KHUD','GEN-EEE','GEN-GDTC','GEN-GDQP'))
	JOIN MONHOC mh on MH.MaMH = mhdt.MaMH
	LEFT JOIN LOPHOC lh ON lh.MaMHDT = mhdt.MaMHDT
	WHERE sv.MaSV = @MaSV
	GROUP BY mh.MaMH, mh.TenMH, mh.SoTinChi
	HAVING COUNT(lh.MaLopHoc) > 0; 

	RETURN;
END
GO
-- Thực hiện: SELECT * FROM RTM_HocPhanCTDTSV ('23110201')
-- Xóa: DROP FUNCTION RTM_HocPhanCTDTSV

-- Hàm: Danh sách sinh viên của khoa
CREATE FUNCTION RTM_DsSVKhoa(@khoa nvarchar(100))
RETURNS @table TABLE (MaSV nvarchar(20), HoTenSV nvarchar(100), GioiTinh nvarchar(10), NgaySinh date, MaLop nvarchar(20))
AS
BEGIN
	INSERT @table
	SELECT sv.MaSV, sv.HoTenSV, sv.GioiTinh, sv.NgaySinh, sv.MaLop
	FROM SINHVIEN sv
	JOIN LOP lop ON LOP.MaLop = sv.MaLop
	JOIN NGANH ng ON ng.MaNganh = lop.MaNganh
	JOIN KHOA kh ON kh.MaKhoa = ng.MaKhoa
	WHERE kh.TenKhoa like '%' + @khoa + '%' or kh.MaKhoa = @khoa
	RETURN
END
GO
--select * from dbo.RTM_DsSVKhoa('05')
--select * from dbo.RTM_DsSVKhoa(N'công nghệ')
--drop function RTM_DsSVKhoa

-- Hàm: Danh sách sinh viên của ngành 
CREATE FUNCTION RTM_DsSVNganh(@nganh nvarchar(100))
RETURNS @table TABLE(MaSV nvarchar(20), HoTenSV nvarchar(100), GioiTinh nvarchar(10), NgaySinh date, MaLop nvarchar(20))
AS
BEGIN
	INSERT @table
	SELECT sv.MaSV, sv.HoTenSV, sv.GioiTinh, sv.NgaySinh, sv.MaLop
	FROM SINHVIEN sv
	JOIN LOP lop ON lop.MaLop = sv.MaLop
	JOIN NGANH ng ON ng.MaNganh = lop.MaNganh
	WHERE ng.TenNganh like '%' + @nganh + '%' OR ng.MaNganh = @nganh
	RETURN
END
GO

-- Hàm: Tìm kiếm lớp học
CREATE FUNCTION RTM_TimKiemLopHocTheoMon (@Monhoc nvarchar(100))
RETURNS @table TABLE (MaLopHoc nvarchar(20), TenMH nvarchar(100) ,TenGV nvarchar(100), SoLuong int, TenPhong nvarchar(20), Thu nvarchar(20), TietBatDau int, TietKetThuc int, ThoiGianBatDau date, ThoiGianKetThuc date)
AS
BEGIN
	INSERT INTO @table 
	SELECT lh.MaLopHoc, mh.TenMH, gv.HoTenGV, lh.SoLuong, lh.TenPhong, lh.Thu, lh.TietBatDau, lh.TietKetThuc, lh.ThoiGianBatDau, lh.ThoiGianKetThuc
	FROM LOPHOC lh
	JOIN GIANGVIEN gv ON gv.MaGV = lh.MaGV
	JOIN MONHOC_DAOTAO mhdt ON mhdt.MaMHDT = lh.MaMHDT
	JOIN MONHOC mh ON mh.MaMH = mhdt.MaMH
	WHERE mh.MaMH LIKE N'%' + @Monhoc + N'%' OR mh.TenMH LIKE N'%' + @Monhoc + '%'
	RETURN
END
GO
-- select * from dbo.RTM_TimKiemLopHocTheoMon('MATH')
-- drop function RTM_TimKiemLopHocTheoMon


-- Hàm: Thời khóa biểu của sinh viên
CREATE FUNCTION RTM_XemTKB (@MaSV nvarchar(20))
RETURNS @table TABLE (MaLopHoc nvarchar(20), TenMH nvarchar(100), HoTenGV nvarchar(100), Thu nvarchar(20), TietBatDau int, TietKetThuc int, TenPhong nvarchar(20))
AS
BEGIN 
	INSERT INTO @table
	SELECT lh.MaLopHoc, mh.TenMH, gv.HoTenGV, lh.Thu, lh.TietBatDau, lh.TietKetThuc, lh.TenPhong
	FROM DANGKY dk 
	JOIN LOPHOC lh ON lh.MaLopHoc = dk.MaLopHoc
	JOIN MONHOC_DAOTAO mhdt ON mhdt.MaMHDT = lh.MaMHDT
	JOIN MONHOC mh ON mh.MaMH = mhdt.MaMH
	JOIN GIANGVIEN gv ON gv.MaGV = lh.MaGV
	WHERE dk.MaSV = @MaSV

	RETURN
END
GO
-- select * from RTM_XemTKB('23110201')
-- drop function RTM_XemTKB

-- Hàm: Thời khóa biểu của giảng viên 
CREATE FUNCTION RTM_XEMTKBGV (@MaGV nvarchar(20))
RETURNS @table TABLE (MaLopHoc nvarchar(20), TenMH nvarchar(100), Thu nvarchar(20), TietBatDau int, TietKetThuc int, TenPhong nvarchar(20))
AS
	BEGIN
		INSERT INTO @table
		SELECT lh.MaLopHoc, mh.TenMH, lh.Thu, lh.TietBatDau, lh.TietKetThuc, lh.TenPhong
		FROM LOPHOC lh
		JOIN MONHOC_DAOTAO mhdt ON mhdt.MaMHDT = lh.MaMHDT
		JOIN MONHOC mh ON mh.MaMH = mhdt.MaMH
		WHERE lh.MaGV = @MaGV
		RETURN;
	END
GO
-- select * from RTM_XEMTKBGV('1996')

-- Hàm: Thông tin chi tiết lớp học của giảng viên 
CREATE FUNCTION RTM_ChiTietLHGV(@MaGV nvarchar(20))
RETURNS @table TABLE (MaLopHoc nvarchar(20), TenMH nvarchar(100), Thu nvarchar(20), TietBatDau int, TietKetThuc int, TenPhong nvarchar(20), SoLuong int)
AS
	BEGIN
		INSERT INTO @table
		SELECT DISTINCT          -- DISTINCT để phòng dữ liệu join bị nhân bản
        lh.MaLopHoc,
        mh.TenMH,
        lh.Thu,
        lh.TietBatDau,
        lh.TietKetThuc,
        lh.TenPhong,
        ISNULL(v.SoLuong, 0) soluong
    FROM dbo.LOPHOC lh
    JOIN dbo.MONHOC_DAOTAO mhdt ON mhdt.MaMHDT = lh.MaMHDT
    JOIN dbo.MONHOC mh ON mh.MaMH = mhdt.MaMH
    LEFT  JOIN dbo.View_SoLuongSVLop AS v ON v.MaLopHoc = lh.MaLopHoc
    WHERE lh.MaGV = @MaGV;

    RETURN;
	END
GO
-- select * from dbo.RTM_ChiTietLHGV('2005')
-- drop function RTM_ChiTietLHGV

--Hàm: Tìm kiếm lớp học đăng ký
CREATE FUNCTION RTM_TimKiemLHDK (@MaMH nvarchar(20), @MaSV nvarchar(20))
RETURNS @table TABLE (MaLopHoc nvarchar(20), TenGV nvarchar(100), SoLuong int, SoDaDK int, TenPhong nvarchar(20), Thu nvarchar(20), TietBatDau int, TietKetThuc int, ThoiGianBatDau date, ThoiGianKetThuc date)
AS
BEGIN	
	INSERT INTO @table
	SELECT lh.MaLopHoc, gv.HoTenGV, lh.SoLuong, ISNULL(dk.SLDK, 0), lh.TenPhong, lh.Thu, lh.TietBatDau, lh.TietKetThuc, lh.ThoiGianBatDau, lh.ThoiGianKetThuc
	FROM SINHVIEN as sv
	JOIN LOP lop ON lop.MaLop = sv.MaLop
    JOIN MONHOC_DAOTAO mhdt ON mhdt.MaCTDT = lop.MaCTDT
    JOIN MONHOC mh ON mh.MaMH = mhdt.MaMH
    JOIN LOPHOC lh ON lh.MaMHDT = mhdt.MaMHDT
    JOIN GIANGVIEN gv ON gv.MaGV = lh.MaGV
	LEFT JOIN (SELECT MaLopHoc, COUNT(*) AS SLDK FROM DANGKY GROUP BY MaLopHoc) dk ON dk.MaLopHoc = lh.MaLopHoc
	WHERE sv.MaSV = @MaSV and mh.MaMH = @MaMH

	RETURN
END
GO
-- select * from RTM_TimKiemLHDK('DBMS330284', '23110201')
-- drop function RTM_TimKiemLHDK