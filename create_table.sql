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
  Password NVARCHAR(255) NOT NULL,
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
GO

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
  MaCB NVARCHAR(20) NOT NULL UNIQUE,
  HoTen NVARCHAR(150) NOT NULL,
  NgaySinh DATE NULL,
  GioiTinh CHAR(1) NULL CHECK (GioiTinh IN ('M','F')),
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
IF COL_LENGTH('dbo.CanBo','UserId') IS NULL
BEGIN
    ALTER TABLE dbo.CanBo ADD UserId INT NULL; 
END
GO

-- đảm bảo mỗi User chỉ gắn cho 1 cán bộ duy nhất
IF NOT EXISTS (SELECT 1 FROM sys.indexes 
               WHERE name = 'UX_CanBo_UserId' AND object_id = OBJECT_ID('dbo.CanBo'))
BEGIN
    CREATE UNIQUE INDEX UX_CanBo_UserId
    ON dbo.CanBo(UserId)
    WHERE UserId IS NOT NULL; -- cho phép nhiều NULL nhưng không cho trùng UserId
END
GO

-- liên kết với Users
IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_CanBo_Users')
BEGIN
    ALTER TABLE dbo.CanBo
    ADD CONSTRAINT FK_CanBo_Users
        FOREIGN KEY(UserId) REFERENCES dbo.Users(UserId)
        ON DELETE SET NULL ON UPDATE CASCADE;
END
GO


ALTER TABLE CanBo
ADD MaBacLuong NVARCHAR(20) FOREIGN KEY REFERENCES BacLuong(MaBacLuong),
    PhuCap DECIMAL(18,2) DEFAULT 0;

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
-- 6. Lop 
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
ALTER COLUMN MaNganh NVARCHAR(20) NOT NULL;

ALTER TABLE PhanCongGiangDay
ADD CONSTRAINT FK_PhanCong_Nganh FOREIGN KEY (MaNganh)
    REFERENCES Nganh(MaNganh);

-------------------------------------------------------------
-- 8. HeSoLuong, BangLuong (lương hàng tháng)
-------------------------------------------------------------

CREATE TABLE BacLuong (
    MaBacLuong NVARCHAR(20) PRIMARY KEY,
    HeSoLuong DECIMAL(4,2)
);

CREATE TABLE BangLuong (
    MaCB NVARCHAR(20) NOT NULL,
    Thang INT,
    Nam INT,
    Thuong DECIMAL(18,2) DEFAULT 0,
    KhauTru DECIMAL(18,2) DEFAULT 0,
	CONSTRAINT FK_BangLuong_CanBo FOREIGN KEY (MaCB) REFERENCES CanBo(MaCB) ON DELETE CASCADE,
	CONSTRAINT UQ_BangLuong UNIQUE (MaCB, Thang, Nam)
);

CREATE TABLE CauHinhLuong (
    MucLuongCoSo DECIMAL(18,2)
);