-- CÁC QUY ĐỊNH ĐẶT TÊN
-- NonP_ : Non-Parameter Stored Procedure: thủ tục không có tham số 
-- HasP_ : Has Parameter Stored Procedure: thủ tục có tham số
-- Re_ : Return / Result / with checks: nhóm thủ tục có trả về. Có tham số, thường có transaction, kiểm tra điều kiện, RAISERROR, RETURN
-- RNO_ : Return Number (One value): nhóm hàm trả về một giá trị (scalar function)
-- RTO_ : Return Table (One statement): nhóm trả về một bảng có một câu lệnh (inline table-valued function)
-- RTM_ : Return Table (Multi-statement): nhóm trả về một bảng có nhiều câu lệnh



-------------------------------------------------------------
-- 1. Role, Users, TaiKhoan
-------------------------------------------------------------
CREATE TABLE Role (
  RoleId INT IDENTITY PRIMARY KEY,
  RoleName NVARCHAR(50) NOT NULL UNIQUE, -- Admin, TruongKhoa, GiangVien
  Description NVARCHAR(255) NULL
);
GO

CREATE TABLE Users (
  UserId INT IDENTITY PRIMARY KEY,
  FullName NVARCHAR(150) NOT NULL,
  Email NVARCHAR(150) NULL,
  Phone NVARCHAR(20) NULL,
  RoleId INT NOT NULL,
  IsActive BIT NOT NULL DEFAULT 1,
  CONSTRAINT FK_Users_Role FOREIGN KEY (RoleId) REFERENCES Role(RoleId)
    ON DELETE NO ACTION ON UPDATE CASCADE
);
GO

CREATE TABLE TaiKhoan (
  AccountId INT IDENTITY PRIMARY KEY,
  UserId INT NOT NULL UNIQUE,
  Username NVARCHAR(100) NOT NULL UNIQUE,
  Password NVARCHAR(255) NOT NULL, -- plaintext (demo). KHÔNG DÙNG IN PRODUCTION
  IsLocked BIT NOT NULL DEFAULT 0,
  CONSTRAINT FK_TaiKhoan_Users FOREIGN KEY (UserId) REFERENCES Users(UserId) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

-------------------------------------------------------------
-- 2. Khoa, Nganh, ChuongTrinh
-------------------------------------------------------------
CREATE TABLE Khoa (
  MaKhoa NVARCHAR(20) NOT NULL PRIMARY KEY,
  TenKhoa NVARCHAR(200) NOT NULL
);
GO

CREATE TABLE Nganh (
  MaNganh NVARCHAR(20) NOT NULL PRIMARY KEY,
  TenNganh NVARCHAR(200) NOT NULL,
  MaKhoa NVARCHAR(20) NOT NULL,
  CONSTRAINT FK_Nganh_Khoa FOREIGN KEY (MaKhoa) REFERENCES Khoa(MaKhoa) ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE ChuongTrinh (
  MaCT NVARCHAR(20) NOT NULL PRIMARY KEY,
  TenCT NVARCHAR(200) NOT NULL,
  MaNganh NVARCHAR(20) NOT NULL,
  HinhThuc NVARCHAR(20) NOT NULL,
  HeDaoTao NVARCHAR(20) NOT NULL CHECK (HeDaoTao IN (N'Đại trà', N'CLC')),
  CONSTRAINT FK_ChuongTrinh_Nganh FOREIGN KEY (MaNganh) REFERENCES Nganh(MaNganh)
    ON DELETE NO ACTION ON UPDATE CASCADE
);
GO

-------------------------------------------------------------
-- 3. ChucVu, TrinhDo
-------------------------------------------------------------
CREATE TABLE ChucVu (
  MaChucVu NVARCHAR(20) NOT NULL PRIMARY KEY,
  TenChucVu NVARCHAR(100) NOT NULL
);
GO

CREATE TABLE TrinhDo (
  MaTrinhDo NVARCHAR(5) NOT NULL PRIMARY KEY,
  TenTrinhDo NVARCHAR(100) NOT NULL UNIQUE  -- Thạc sĩ, Tiến sĩ, Giáo sư...
);
GO

-------------------------------------------------------------
-- 4. CanBo (cán bộ / giảng viên)
--    dùng MaKhoa (tham chiếu Khoa.MaKhoa) và IsTruongKhoa để đảm bảo 1 trưởng khoa
-------------------------------------------------------------
CREATE TABLE CanBo (
  CanBoId INT IDENTITY PRIMARY KEY,
  MaCB NVARCHAR(20) NOT NULL UNIQUE,
  HoTen NVARCHAR(150) NOT NULL,
  NgaySinh DATE NULL,
  GioiTinh CHAR(1) NULL CHECK (GioiTinh IN ('M','F','O')),
  Email NVARCHAR(150) NULL,
  Phone NVARCHAR(20) NULL,
  MaKhoa NVARCHAR(20) NULL,      -- tham chiếu Khoa.MaKhoa
  MaChucVu NVARCHAR(20) NULL,    -- tham chiếu ChucVu.MaChucVu
  MaTrinhDo NVARCHAR(5) NULL,
  CONSTRAINT FK_CanBo_MaKhoa FOREIGN KEY (MaKhoa) REFERENCES Khoa(MaKhoa) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT FK_CanBo_MaChucVu FOREIGN KEY (MaChucVu) REFERENCES ChucVu(MaChucVu) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT FK_CanBo_TrinhDo FOREIGN KEY (MaTrinhDo) REFERENCES TrinhDo(MaTrinhDo) ON DELETE SET NULL ON UPDATE CASCADE
);
GO

-- Đảm bảo 1 trưởng khoa duy nhất: unique filtered index trên (MaKhoa) khi MaChucVu = 'TK';
CREATE UNIQUE INDEX UX_CanBo_OneHeadPerKhoa ON CanBo(MaKhoa)
WHERE MaChucVu = 'TK';
GO

-------------------------------------------------------------
-- 5. MonHoc + liên kết với ChuongTrinh (nhiều-nhiều)
-------------------------------------------------------------
CREATE TABLE MonHoc (
  MonHocId INT IDENTITY PRIMARY KEY,
  MaMon NVARCHAR(20) NOT NULL UNIQUE,
  TenMon NVARCHAR(200) NOT NULL DEFAULT N'Chưa đặt tên',
  SoTiet INT NOT NULL CHECK (SoTiet >= 0),
  SoTinChi INT NOT NULL CHECK (SoTinChi >= 0),
  MaKhoaPhuTrach NVARCHAR(20) NOT NULL
);
GO

CREATE TABLE ChuongTrinh_MonHoc (
  MaCT NVARCHAR(20) NOT NULL,
  BatBuoc BIT NOT NULL DEFAULT 1,
  MaMon NVARCHAR(20) NOT NULL,
  CONSTRAINT FK_CTMH_CT FOREIGN KEY (MaCT) REFERENCES ChuongTrinh(MaCT)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT FK_CTMH_MH FOREIGN KEY (MaMon) REFERENCES MonHoc(MaMon)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT UQ_CTMH UNIQUE (MaCT, MaMon)
);

-------------------------------------------------------------
-- 6. Lop (lớp học phần) và SinhVien, SinhVien_Lop (bảng trung gian)
-------------------------------------------------------------
CREATE TABLE LopHocPhan (
  MaLopHocPhan NVARCHAR(20) NOT NULL PRIMARY KEY,
  TenLopHocPhan NVARCHAR(200) NOT NULL,
  MaKhoa NVARCHAR(20) NULL,
  MaNganh NVARCHAR(20) NULL,
  MaCT NVARCHAR(20) NULL,
  SoLuongSV INT NOT NULL DEFAULT 0,
  MaMon NVARCHAR(20) NOT NULL,
  CONSTRAINT FK_Lop_MaKhoa FOREIGN KEY (MaKhoa) REFERENCES Khoa(MaKhoa) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT FK_Lop_MaNganh FOREIGN KEY (MaNganh) REFERENCES Nganh(MaNganh) ON DELETE SET NULL,
  CONSTRAINT FK_Lop_MaCT FOREIGN KEY (MaCT) REFERENCES ChuongTrinh(MaCT) ON DELETE SET NULL,
  CONSTRAINT FK_LopHocPhan_MonHoc FOREIGN KEY (MaMon) REFERENCES MonHoc(MaMon)
);
GO

CREATE TABLE SinhVien (
  HoTen NVARCHAR(150) NOT NULL,
  NgaySinh DATE NULL,
  GioiTinh CHAR(1) NULL CHECK (GioiTinh IN ('M','F','O')),
  MaKhoa NVARCHAR(20) NULL,
  MaNganh NVARCHAR(20) NULL,
  MaCT NVARCHAR(20) NULL,
  MaLop NVARCHAR(20) NOT NULL
  CONSTRAINT FK_SV_MaKhoa FOREIGN KEY (MaKhoa) REFERENCES Khoa(MaKhoa) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT FK_SV_MaNganh FOREIGN KEY (MaNganh) REFERENCES Nganh(MaNganh) ON DELETE SET NULL,
  CONSTRAINT FK_SV_MaCT FOREIGN KEY (MaCT) REFERENCES ChuongTrinh(MaCT) ON DELETE SET NULL
);
GO

-- Bảng trung gian SinhVien_Lop (một SV có thể học nhiều lớp; một lớp có nhiều SV)
CREATE TABLE SinhVien_Lop (
  MaSV NVARCHAR(20) NOT NULL,
  MaLopHocPhan NVARCHAR(20) NOT NULL,
  DiemQuaTrinh DECIMAL(5,2) NULL, --- Do GV được phân công nhập
  DiemCuoiKy DECIMAL(5,2) NULL,
  DiemTrungBinh DECIMAL(5,2) NULL,
  TrangThai NVARCHAR(20),
  CONSTRAINT FK_SVL_SV FOREIGN KEY (MaSV) REFERENCES SinhVien(MaSV) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT FK_SVL_Lop FOREIGN KEY (MaLopHocPhan) REFERENCES LopHocPhan(MaLopHocPhan) ON DELETE CASCADE,
  CONSTRAINT UQ_SVL UNIQUE (MaSV, MaLopHocPhan),
  CONSTRAINT PK_SVLHP PRIMARY KEY (MaSV, MaLopHocPhan)
);
GO


-------------------------------------------------------------
-- 7. PhanCongGiangDay (phân công)
-------------------------------------------------------------
CREATE TABLE PhanCongGiangDay (
  MaCB NVARCHAR(20) NOT NULL,
  TenMon NVARCHAR(200) NOT NULL,
  MaMon NVARCHAR(20) NOT NULL,
  MaLopHocPhan NVARCHAR(20) NOT NULL,
  SoTiet INT NOT NULL CHECK (SoTiet >= 0),
  SoTuan INT NOT NULL DEFAULT 15 CHECK (SoTuan > 0),
  HocKy INT NOT NULL, -- HK1
  NamHoc NVARCHAR(20) NOT NULL, -- 2024 - 2025
  CONSTRAINT FK_PCGD_MaCB FOREIGN KEY (MaCB) REFERENCES CanBo(MaCB) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT FK_PCGD_MaMon FOREIGN KEY (MaMon) REFERENCES MonHoc(MaMon) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT FK_PCGD_MaLopHocPhan FOREIGN KEY (MaLopHocPhan) REFERENCES LopHocPhan(MaLopHocPhan) ON DELETE NO ACTION,
  CONSTRAINT UQ_PCGD UNIQUE (MaCB, MaMon, MaLopHocPhan, NamHoc, HocKy)
);
Go

ALTER TABLE PhanCongGiangDay
ADD MaNganh NVARCHAR(20) NOT NULL;
GO

ALTER TABLE PhanCongGiangDay
ADD CONSTRAINT FK_PhanCong_Nganh FOREIGN KEY (MaNganh)
    REFERENCES Nganh(MaNganh)
    ON UPDATE CASCADE
    ON DELETE NO ACTION;
GO

EXEC sp_help 'PhanCongGiangDay';



-------------------------------------------------------------
-- 8. HeSoLuong, BangLuong (lương hàng tháng)
-------------------------------------------------------------
CREATE TABLE HeSoLuong (
  HeSoId INT IDENTITY PRIMARY KEY,
  TenHeSo NVARCHAR(100) NOT NULL,
  GiaTri DECIMAL(5,2) NOT NULL CHECK (GiaTri >= 0)
);
GO

CREATE TABLE BangLuong (
  BangLuongId INT IDENTITY PRIMARY KEY,
  MaCB NVARCHAR(20) NOT NULL,
  ThangNam CHAR(7) NOT NULL, -- 'YYYY-MM'
  LuongCoBan DECIMAL(18,2) NOT NULL CHECK (LuongCoBan >= 0),
  HeSoId INT NULL,
  TongPhuCap DECIMAL(18,2) DEFAULT 0,
  KhauTru DECIMAL(18,2) DEFAULT 0,
  TongLuong DECIMAL(18,2) NULL,
  CONSTRAINT FK_BangLuong_MaCB FOREIGN KEY (MaCB) REFERENCES CanBo(MaCB) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT FK_BangLuong_HeSo FOREIGN KEY (HeSoId) REFERENCES HeSoLuong(HeSoId) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT UQ_BangLuong UNIQUE (MaCB, ThangNam)
);
GO

