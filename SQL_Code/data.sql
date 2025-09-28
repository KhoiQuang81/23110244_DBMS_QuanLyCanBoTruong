-- Role
INSERT INTO Role (RoleName, Description)
VALUES 
 (N'Admin', N'Quản trị hệ thống'),
 (N'TruongKhoa', N'Trưởng khoa'),
 (N'GiangVien', N'Giảng viên');

-- Users
INSERT INTO Users (FullName, Email, Phone, RoleId)
VALUES 
 (N'Admin', 'ad@hcmute.edu.vn', '0901111111', 1),
 (N'Lê Văn Vinh', 'vinhlv@hcmute.edu.vn', '0902222222', 2),
 (N'Vũ Đình Bảo', 'baovd@hcmute.edu.vn ', '0903333333', 3);

-- TaiKhoan
INSERT INTO TaiKhoan (UserId, Username, Password)
VALUES 
 (1, 'admin', '123'),
 (2, 'lvvinh', '123'),
 (3, 'vdbao', '123');


 -- Khoa
INSERT INTO Khoa (MaKhoa, TenKhoa) VALUES
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
('12', N'Khoa Xây dựng'),
('13', N'Viện Sư phạm Kỹ thuật'),
('14', N'Trung tâm GDQP và An ninh'),
('15', N'Trung tâm Giáo dục thể chất')

-- Nganh
INSERT INTO Nganh (MaNganh, TenNganh, MaKhoa) VALUES
('7480201', N'Công nghệ thông tin', '05'),
('7480202', N'An toàn thông tin', '05'),
('7480203', N'Kỹ thuật dữ liệu', '05'),
('7140231', N'Ngôn ngữ Anh', '10');
INSERT INTO Nganh (MaNganh, TenNganh, MaKhoa) VALUES
('7220201', N'Sư phạm tiếng Anh', '10');

-- ChuongTrinh
INSERT INTO ChuongTrinh (MaCT, TenCT, MaNganh, HinhThuc, HeDaoTao) VALUES
-- Ngành CNTT
 ('CNTT01', N'Công nghệ thông tin', '7480201', N'Chính Quy', N'Đại trà'),
 ('CNTT02', N'An toàn thông tin', '7480202', N'Chính Quy', N'Đại trà'),
 ('CNTT03', N'Kỹ thuật dữ liệu', '7480203', N'Chính Quy', N'Đại trà'),
 ('NNA01', N'Tiếng Anh thương mại', '7140231', N'Chính Quy', N'Đại trà'),
 ('NNA02', N'Tiếng Anh kỹ thuật', '7220201', N'Chính Quy', N'Đại trà');

 INSERT INTO ChuongTrinh (MaCT, TenCT, MaNganh, HinhThuc, HeDaoTao) VALUES
 ('','','','','');



 -- ChucVu
INSERT INTO ChucVu (MaChucVu, TenChucVu) VALUES
 ('TG', N'Thỉnh Giảng'),
 ('GV', N'Giảng viên'),
 ('PCN', N'Phó chủ nhiệm bộ môn'),
 ('CN', N'Chủ nhiệm bộ môn'),
 ('PK', N'Phó trưởng khoa'),
 ('TK', N'Trưởng khoa');


-- TrinhDo
INSERT INTO TrinhDo (MaTrinhDo, TenTrinhDo) VALUES
 (N'CN', N'Cử nhân'),
 (N'KS', N'Kỹ sư'),
 (N'ThS', N'Thạc sĩ'),
 (N'TS', N'Tiến sĩ');

-- CanBo
INSERT INTO CanBo (MaCB, HoTen, NgaySinh, GioiTinh, Email, Phone, MaKhoa, MaChucVu, MaTrinhDo, UserId)
VALUES
-- YYYY/MM/DD
 ('1980', N'Lê Văn Vinh',  '1983-10-16', 'M', 'vinhlv@hcmute.edu.vn', '0904554444', '05', 'TK', 'TS', 2),
 ('2003', N'Phan Thị Huyền Trang', '1988-06-01', 'F', 'trangpth@hcmute.edu.vn', '0904444444', '05', 'CN', 'TS', NULL),
 ('1981', N'Đặng Tấn Tín', '1985-07-15', 'M', 'tin.dang@hcmute.edu.vn', '0905555555', '10', 'TK', 'TS', NULL),
 ('1982', N'Lê Quốc Kiệt', '1990-09-20', 'M', 'kietlq@hcmute.edu.vn', '0906666666', '10', 'GV', 'ThS', NULL);


 -- MonHoc
INSERT INTO MonHoc (MaMon, TenMon, SoTiet, SoTinChi, MaKhoaPhuTrach) VALUES
-- Chính trị (Khoa 01)
('LLCT130105', N'Triết học Mác - Lênin', 45, 3, '01'),
('GELA220405', N'Pháp luật đại cương', 45, 2, '01'),
('LLCT120205', N'Kinh tế chính trị Mác - Lênin', 45, 2, '01'),
('LLCT120314', N'Tư tưởng Hồ Chí Minh', 45, 2, '01'),
('LLCT220514', N'Lịch sử Đảng CSVN', 45, 2, '01'),

-- Ngôn ngữ Anh (Khoa 10)
 ('LISP240135', 'Pre-intermediate Listening and Speaking', 75, 4, '10'),
 ('LISP240235 ', 'Intermediate Listening and Speaking', 75, 4, '10'),
 ('LISP340335', 'Upper-intermediate Listening and Speaking', 75, 4, '10'),
 ('ENCS330537', N'Tiếng Anh Chuyên ngành Khoa học Máy tính', 45, 3, '10'),

 -- Chuyên ngành ngôn ngữ Anh (Khoa 10)
  ('EIBC330237', 'English for International Business Contracts ', 60, 3, '10'),
  ('ENBC330137', 'English for Business Communication', 60, 3, '10'),
  ('ENBC330537', 'Tiếng Anh Thư tín Thương mại', 60, 3, '10'),
  ('ENFI330437', 'Tiếng Anh chuyên ngành Tài chính ', 60, 3, '10'),

-- Toán - Lý (Khoa 08)
('MATH132401', N'Toán 1', 45, 3, '08'),
('MATH132501', N'Toán 2', 45, 3, '08'),
('MATH132901', N'Xác suất thống kê ứng dụng', 45, 3, '08'),
('PHYS130902', N'Vật lý 1', 45, 3, '08'),
('PHYS111202', N'Thí nghiệm Vật lý 1 (Thực hành)', 30, 1, '08'),

-- Điện tử căn bản (Khoa 06)
('EEEN234162', N'Điện tử căn bản (CTT)', 60, 3, '06'),
('PRBE214262', N'Thực tập điện tử căn bản (Thực hành)', 60, 1, '06'),

-- Giáo dục thể chất (Khoa 16)
('PHED110513', N'Giáo dục thể chất 1', 30, 1, '16'),
('BASK112330', N'Bóng rổ', 30, 1, '16'),
('PICK112330', N'Pickleball', 30, 3, '16'),

-- Giáo dục quốc phòng (Khoa 15)
('GDQP008031', N'Giáo dục quốc phòng 1(ĐH)', 45, 1, '15'),
('GDQP008032', N'Giáo dục quốc phòng 2(ĐH)', 30, 1, '15'),
('GDQP008033', N'Giáo dục quốc phòng 3(ĐH)', 90, 2, '15'),

-- Cơ sở ngành CNTT (Khoa 05)
('INPR140285', N'Nhập môn lập trình', 75, 4, '05'),
('INIT130185', N'Nhập môn ngành CNTT', 60, 3, '05'),
('PRTE230385', N'Kỹ thuật lập trình', 60, 3, '05'),
('DIGR240485', N'Toán rời rạc và lý thuyết đồ thị', 60, 4, '05'),
('DASA230179', N'Cấu trúc dữ liệu và giải thuật', 60, 3, '05'),
('CAAL230180', N'Kiến trúc máy tính và hợp ngữ', 60, 3, '05'),
('IPPA233277', N'Lập Trình Python', 60, 3, '05'),
('DBSY240184', N'Cơ sở dữ liệu', 75, 4, '05'),
('DBMS330284', N'Hệ quản trị cơ sở dữ liệu', 60, 3, '05'),

-- Chuyên ngành CNTT (Khoa 05)
('ARIN330585', N'Trí tuệ nhân tạo', 60, 3, '05'),
('SOEN330679', N'Công nghệ phần mềm', 60, 3, '05'),
('WEPR330479', N'Lập trình Web', 60, 3, '05');
GO


-- ChuongTrinh_MonHoc
 -- CNTT01 - Công nghệ thông tin
INSERT INTO ChuongTrinh_MonHoc (MaCT, BatBuoc, MaMon) VALUES
 ('CNTT01', 1, 'INPR140285'), -- Nhập môn lập trình
 ('CNTT01', 1, 'INIT130185'), -- Nhập môn ngành CNTT
 ('CNTT01', 1, 'PRTE230385'), -- Kỹ thuật lập trình
 ('CNTT01', 1, 'DIGR240485'), -- Toán rời rạc
 ('CNTT01', 1, 'DASA230179'), -- CTDL & GT
 ('CNTT01', 1, 'CAAL230180'), -- Kiến trúc máy tính
 ('CNTT01', 1, 'IPPA233277'), -- Python
 ('CNTT01', 1, 'DBSY240184'), -- CSDL
 ('CNTT01', 1, 'DBMS330284'), -- Hệ QTCSDL
 ('CNTT01', 1, 'ARIN330585'), -- Trí tuệ nhân tạo (tự chọn)
 ('CNTT01', 1, 'SOEN330679'), -- Công nghệ phần mềm (tự chọn)
 ('CNTT01', 1, 'WEPR330479'); -- Lập trình Web (tự chọn)

-- CNTT02 - An toàn thông tin
INSERT INTO ChuongTrinh_MonHoc (MaCT, BatBuoc, MaMon) VALUES
 ('CNTT02', 1, 'INPR140285'),
 ('CNTT02', 1, 'PRTE230385'),
 ('CNTT02', 1, 'DASA230179'),
 ('CNTT02', 1, 'DBSY240184'),
 ('CNTT02', 1, 'DBMS330284'),
 ('CNTT02', 1, 'CAAL230180'),
 ('CNTT02', 1, 'WEPR330479');

-- CNTT03 - Kỹ thuật dữ liệu
INSERT INTO ChuongTrinh_MonHoc (MaCT, BatBuoc, MaMon) VALUES
 ('CNTT03', 1, 'INPR140285'),
 ('CNTT03', 1, 'PRTE230385'),
 ('CNTT03', 1, 'DASA230179'),
 ('CNTT03', 1, 'DBSY240184'),
 ('CNTT03', 1, 'DBMS330284'),
 ('CNTT03', 1, 'ARIN330585'),
 ('CNTT03', 1, 'SOEN330679');

-- NNA01 - Tiếng Anh thương mại
INSERT INTO ChuongTrinh_MonHoc (MaCT, BatBuoc, MaMon) VALUES
 ('NNA01', 1, 'LISP240135'),
 ('NNA01', 1, 'LISP240235'),
 ('NNA01', 1, 'LISP340335'),
 ('NNA01', 1, 'ENCS330537'),
 ('NNA01', 1, 'EIBC330237'),
 ('NNA01', 1, 'ENBC330137'),
 ('NNA01', 1, 'ENBC330537'),
 ('NNA01', 1, 'ENFI330437');

-- NNA02 - Tiếng Anh kỹ thuật
INSERT INTO ChuongTrinh_MonHoc (MaCT, BatBuoc, MaMon) VALUES
 ('NNA02', 1, 'LISP240135'),
 ('NNA02', 1, 'LISP240235'),
 ('NNA02', 1, 'LISP340335'),
 ('NNA02', 1, 'ENCS330537'),
 ('NNA02', 1, 'EIBC330237'),
 ('NNA02', 1, 'ENBC330137'),
 ('NNA02', 1, 'ENBC330537'),
 ('NNA02', 1, 'ENFI330437');


 -- Lop
INSERT INTO LopHocPhan (MaLopHocPhan, TenLopHocPhan, MaKhoa, MaNganh, MaCT, SoLuongSV) VALUES
 -- các lớp n công nghệ thông tin
('INPR140285_02', N'Nhập môn lập trình', '05', '7480201', 'CNTT01', 75),
('INPR140285_04', N'Nhập môn lập trình', '05', '7480201', 'CNTT01', 75),
('PRTE230385_25', N'Kỹ thuật lập trình', '05', '7480201', 'CNTT01', 75),
('PRTE230385_26', N'Kỹ thuật lập trình', '05', '7480201', 'CNTT01', 75),
('DIGR240485_09', N'Toán rời rạc và lý thuyết đồ thị', '05', '7480201', 'CNTT01', 75);
GO

-- SinhVien
INSERT INTO SinhVien (MaSV, HoTen, NgaySinh, GioiTinh, MaKhoa, MaNganh, MaCT, MaLop) VALUES
 ('23110201', N'Trần Lê Quốc Đại', '2005-04-27', 'M', '05', '7480201', 'CNTT01', '231101A'),
 ('23110244', N'Đoàn Quang Khôi', '2005-01-08', 'M', '05', '7480201', 'CNTT01', '231101A');


-- SinhVien_Lop
INSERT INTO SinhVien_Lop (MaSV, MaLopHocPhan, DiemQuaTrinh, DiemCuoiKy, DiemTrungBinh, TrangThai) VALUES
 ('23110201', 'PRTE230385_25', 5, 4.8, NULL, NULL),
 ('23110244', 'DIGR240485_09', 8, 2.5, NULL, NULL),
 ('23110244', 'INPR140285_02', 8.5, 8.5, NULL, NULL);

 INSERT INTO PhanCongGiangDay (MaCB, TenMon, MaMon, MaLopHocPhan, SoTiet, SoTuan, HocKy, NamHoc) VALUES
 ('2003', N'Nhập môn lập trình', 'INPR140285', 'INPR140285_02', 75, 15, 1, '2025-2026');


 -- HeSoLuong
INSERT INTO HeSoLuong (TenHeSo, GiaTri) VALUES
 (N'Giảng viên', 2.34),
 (N'Trưởng khoa', 3.50);

-- BangLuong
INSERT INTO BangLuong (MaCB, ThangNam, LuongCoBan, HeSoId, TongPhuCap, KhauTru)
VALUES
 ('2003', '2025-08', 5000000, 1, 1000000, 500000),
 ('1980', '2025-08', 5000000, 2, 1000000, 500000);
 