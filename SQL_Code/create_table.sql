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




/*=========================
	   1. PHÂN QUYỀN
  =========================*/
  USE QLCanBoGiangVien;
GO
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = N'r_Admin')
    CREATE ROLE r_Admin;
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = N'r_TruongKhoa')
    CREATE ROLE r_TruongKhoa;
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = N'r_GiangVien')
    CREATE ROLE r_GiangVien;
GO


-- Hàm lấy danh tính hiện tại (role, MaCB, MaKhoa) Dùng USER_NAME() để map sang TaiKhoan.Username
  CREATE OR ALTER FUNCTION dbo.RTO_CurrentPrincipal()
RETURNS TABLE
AS
RETURN
(
    SELECT  t.UserId,
            u.FullName,
            r.RoleName,
            cb.MaCB,
            cb.MaKhoa
    FROM dbo.TaiKhoan t
    JOIN dbo.Users u ON u.UserId = t.UserId
    JOIN dbo.Role  r ON r.RoleId = u.RoleId
    LEFT JOIN dbo.CanBo cb ON cb.UserId = u.UserId
    WHERE t.Username = USER_NAME()
);
GO

/* SAU KHI THÊM TÀI KHOẢN -> TỰ TẠO LOGIN/USER + ADD ROLE */
CREATE OR ALTER TRIGGER TRG_TaiKhoan_AI
ON dbo.TaiKhoan
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @u NVARCHAR(100), @p NVARCHAR(255), @role NVARCHAR(50), @sql NVARCHAR(MAX);

    SELECT TOP(1)
        @u = i.Username,
        @p = i.Password,
        @role = r.RoleName
    FROM inserted i
    JOIN dbo.Users u ON u.UserId = i.UserId
    JOIN dbo.Role  r ON r.RoleId = u.RoleId;

    -- Tạo/đổi mật khẩu LOGIN
    IF SUSER_ID(@u) IS NULL
        SET @sql = N'CREATE LOGIN ' + QUOTENAME(@u) +
                   N' WITH PASSWORD = ''' + REPLACE(@p,'''','''''') + N''', CHECK_POLICY=OFF, CHECK_EXPIRATION=OFF;';
    ELSE
        SET @sql = N'ALTER LOGIN ' + QUOTENAME(@u) +
                   N' WITH PASSWORD = ''' + REPLACE(@p,'''','''''') + N''', CHECK_POLICY=OFF;';
    EXEC(@sql);

    -- Tạo USER trong database (nếu chưa có)
    IF USER_ID(@u) IS NULL
    BEGIN
        SET @sql = N'CREATE USER ' + QUOTENAME(@u) + N' FOR LOGIN ' + QUOTENAME(@u) + N';';
        EXEC(@sql);
    END

    -- Add vào ROLE
    IF @role = N'Admin'
        SET @sql = N'ALTER ROLE r_Admin ADD MEMBER ' + QUOTENAME(@u) + N';';
    ELSE IF @role = N'TruongKhoa'
        SET @sql = N'ALTER ROLE r_TruongKhoa ADD MEMBER ' + QUOTENAME(@u) + N';';
    ELSE IF @role = N'GiangVien'
        SET @sql = N'ALTER ROLE r_GiangVien ADD MEMBER ' + QUOTENAME(@u) + N';';
    ELSE
        SET @sql = NULL;

    IF @sql IS NOT NULL EXEC(@sql);
END
GO

/* XÓA TÀI KHOẢN -> DROP USER + LOGIN + GỠ ROLE */
CREATE OR ALTER TRIGGER TRG_TaiKhoan_AD
ON dbo.TaiKhoan
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @u NVARCHAR(100), @sql NVARCHAR(MAX);

    SELECT TOP(1) @u = d.Username FROM deleted d;

    -- Gỡ khỏi mọi role (thử từng role)
    SET @sql = N'IF IS_ROLEMEMBER(''r_Admin'',''' + REPLACE(@u,'''','''''') + N''')=1 ALTER ROLE r_Admin DROP MEMBER ' + QUOTENAME(@u) + N';';
    EXEC(@sql);
    SET @sql = N'IF IS_ROLEMEMBER(''r_TruongKhoa'',''' + REPLACE(@u,'''','''''') + N''')=1 ALTER ROLE r_TruongKhoa DROP MEMBER ' + QUOTENAME(@u) + N';';
    EXEC(@sql);
    SET @sql = N'IF IS_ROLEMEMBER(''r_GiangVien'',''' + REPLACE(@u,'''','''''') + N''')=1 ALTER ROLE r_GiangVien DROP MEMBER ' + QUOTENAME(@u) + N';';
    EXEC(@sql);

    -- Drop USER
    IF USER_ID(@u) IS NOT NULL
    BEGIN
        SET @sql = N'DROP USER ' + QUOTENAME(@u) + N';';
        EXEC(@sql);
    END

    -- Drop LOGIN
    IF SUSER_ID(@u) IS NOT NULL
    BEGIN
        SET @sql = N'DROP LOGIN ' + QUOTENAME(@u) + N';';
        EXEC(@sql);
    END
END
GO

/* CẬP NHẬT TÊN/MẬT KHẨU -> ĐỔI LOGIN/USER TƯƠNG ỨNG */
CREATE OR ALTER TRIGGER TRG_TaiKhoan_AU
ON dbo.TaiKhoan
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @oldU NVARCHAR(100), @newU NVARCHAR(100), @newP NVARCHAR(255), @sql NVARCHAR(MAX);

    SELECT TOP(1)
        @oldU = d.Username, @newU = i.Username, @newP = i.Password
    FROM inserted i CROSS JOIN deleted d;

    IF UPDATE(Username) AND @oldU <> @newU
    BEGIN
        SET @sql = N'ALTER LOGIN ' + QUOTENAME(@oldU) + N' WITH NAME = ' + QUOTENAME(@newU) + N';';
        EXEC(@sql);
        IF USER_ID(@oldU) IS NOT NULL
        BEGIN
            SET @sql = N'ALTER USER ' + QUOTENAME(@oldU) + N' WITH NAME = ' + QUOTENAME(@newU) + N';';
            EXEC(@sql);
        END
    END

    IF UPDATE(Password)
    BEGIN
        DECLARE @target NVARCHAR(100) = CASE WHEN UPDATE(Username) AND @oldU <> @newU THEN @newU ELSE @oldU END;
        SET @sql = N'ALTER LOGIN ' + QUOTENAME(@target) + N' WITH PASSWORD = ''' + REPLACE(@newP,'''','''''') + N''', CHECK_POLICY=OFF;';
        EXEC(@sql);
    END
END
GO

-- GRANT QUYỀN

-- Cho tất cả role được phép gọi hàm RTO_CurrentPrincipal
GRANT SELECT ON OBJECT::dbo.RTO_CurrentPrincipal TO r_Admin;
GRANT SELECT ON OBJECT::dbo.RTO_CurrentPrincipal TO r_TruongKhoa;
GRANT SELECT ON OBJECT::dbo.RTO_CurrentPrincipal TO r_GiangVien;


-- ADMIN: toàn quyền schema dbo
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::dbo TO r_Admin;
GRANT EXECUTE ON SCHEMA::dbo TO r_Admin;


-- Trưởng khoa: EXECUTE các SP kiểm tra khoa
-- Khoa + Ngành
GRANT EXECUTE ON dbo.NonP_GetAllKhoa         TO r_TruongKhoa;
GRANT EXECUTE ON dbo.HasP_GetNganhByKhoa     TO r_TruongKhoa;
GRANT EXECUTE ON dbo.HasP_InsertNganh        TO r_TruongKhoa;
GRANT EXECUTE ON dbo.HasP_UpdateNganh        TO r_TruongKhoa;
GRANT EXECUTE ON dbo.HasP_DeleteNganh        TO r_TruongKhoa;

-- Giảng viên (CanBo)
GRANT EXECUTE ON dbo.HasP_GetGiangVienByKhoa TO r_TruongKhoa;
GRANT EXECUTE ON dbo.HasP_GetGiangVienByKhoa_GV TO r_TruongKhoa;
GRANT EXECUTE ON dbo.HasP_InsertCanBo        TO r_TruongKhoa;
GRANT EXECUTE ON dbo.HasP_UpdateCanBo        TO r_TruongKhoa;
GRANT EXECUTE ON dbo.HasP_DeleteCanBo        TO r_TruongKhoa;
GRANT EXECUTE ON dbo.HasP_GetCanBoByName     TO r_TruongKhoa;


-- Môn học
GRANT EXECUTE ON dbo.HasP_InsertMonHoc				TO r_TruongKhoa;
GRANT EXECUTE ON dbo.HasP_UpdateMonHoc				TO r_TruongKhoa;
GRANT EXECUTE ON dbo.HasP_DeleteMonHoc				TO r_TruongKhoa;
GRANT EXECUTE ON dbo.HasP_GetChuongTrinhByNganh		TO r_TruongKhoa;
GRANT EXECUTE ON dbo.HasP_GetMonHocByCT				TO r_TruongKhoa;
GRANT EXECUTE ON dbo.HasP_SearchMonHoc				TO r_TruongKhoa;


-- Lớp học phần
GRANT EXECUTE ON dbo.HasP_InsertLopHocPhan		TO r_TruongKhoa;
GRANT EXECUTE ON dbo.HasP_UpdateLopHocPhan		TO r_TruongKhoa;
GRANT EXECUTE ON dbo.HasP_DeleteLopHocPhan		TO r_TruongKhoa;
GRANT EXECUTE ON dbo.HasP_GetLopHocPhanByMon	TO r_TruongKhoa;
GRANT EXECUTE ON dbo.HasP_GetMonHocByNganh		TO r_TruongKhoa;
GRANT EXECUTE ON dbo.HasP_GetLopChuaPhanCong	TO r_TruongKhoa;


-- Phân công
GRANT EXECUTE ON dbo.HasP_GetPhanCongByKhoa		TO r_TruongKhoa;
GRANT EXECUTE ON dbo.HasP_InsertPhanCong		TO r_TruongKhoa;
GRANT EXECUTE ON dbo.HasP_UpdatePhanCong		TO r_TruongKhoa;
GRANT EXECUTE ON dbo.HasP_DeletePhanCong		TO r_TruongKhoa;
GRANT EXECUTE ON dbo.HasP_GetMonHocByNganh_PC   TO r_TruongKhoa;
GRANT EXECUTE ON dbo.HasP_GetSoTietByMon		TO r_TruongKhoa;


-- Lương: chỉ xem
GRANT SELECT  ON dbo.Vw_CanBo_Luong				TO r_TruongKhoa;
GRANT SELECT ON dbo.Vw_Khoa_CuaToi				TO r_TruongKhoa;
GRANT SELECT ON dbo.Vw_Nganh_TrongKhoaCuaToi	TO r_TruongKhoa;
GRANT SELECT ON dbo.Vw_Luong_CuaToi				TO r_TruongKhoa;

-- Giảng viên: chỉ SELECT view an toàn
GRANT SELECT ON dbo.Vw_CanBo_TrongKhoaCuaToi		TO r_GiangVien;
GRANT SELECT ON dbo.Vw_Nganh_TrongKhoaCuaToi		TO r_GiangVien;
GRANT SELECT ON dbo.Vw_MonHoc_TrongKhoaCuaToi		TO r_GiangVien;
GRANT SELECT ON dbo.Vw_LopHP_TrongKhoaCuaToi		TO r_GiangVien;
GRANT SELECT ON dbo.Vw_LopHP_CuaToi					TO r_GiangVien;
GRANT SELECT ON dbo.Vw_PhanCong_CuaToi				TO r_GiangVien;
GRANT SELECT ON dbo.Vw_CanBo_Luong					TO r_GiangVien;
GRANT EXECUTE ON dbo.HasP_GetCanBoByName			TO r_GiangVien;
GRANT SELECT ON dbo.Vw_Khoa_CuaToi					TO r_GiangVien;
GRANT EXECUTE ON dbo.HasP_GetChuongTrinhByNganh		TO r_GiangVien;
GRANT EXECUTE ON dbo.HasP_GetMonHocByCT				TO r_GiangVien;
GRANT EXECUTE ON dbo.HasP_SearchMonHoc				TO r_GiangVien;
GRANT EXECUTE ON dbo.HasP_GetLopHocPhanByMon		TO r_GiangVien;
GRANT EXECUTE ON dbo.HasP_GetMonHocByNganh			TO r_GiangVien;
GRANT EXECUTE ON dbo.HasP_GetNganhByKhoa			TO r_GiangVien;
GRANT EXECUTE ON dbo.HasP_GetMonHocByNganh_PC		TO r_GiangVien;
GRANT EXECUTE ON dbo.HasP_GetSoTietByMon			TO r_GiangVien;
GRANT EXECUTE ON dbo.HasP_GetLopChuaPhanCong		TO r_GiangVien;
GRANT SELECT ON dbo.Vw_Luong_CuaToi					TO r_GiangVien;





/*=========================
	 2. STORED PROCEDURE
  =========================*/


-------------------------------------------------------------
-- CRUD: CanBo
-------------------------------------------------------------
CREATE OR ALTER PROCEDURE dbo.HasP_InsertCanBo
    @MaCB NVARCHAR(20),
    @HoTen NVARCHAR(200),
    @NgaySinh DATE,
    @GioiTinh NVARCHAR(5),
    @Email NVARCHAR(100),
    @Phone NVARCHAR(20),
    @MaKhoa NVARCHAR(20),
    @MaChucVu NVARCHAR(20),
    @MaTrinhDo NVARCHAR(20)
AS
BEGIN
    -- Kiểm tra nhập thiếu
    IF @MaCB IS NULL OR LTRIM(RTRIM(@MaCB)) = ''
        RAISERROR(N'Bạn chưa nhập Mã cán bộ.', 16, 1); RETURN;
    IF @HoTen IS NULL OR LTRIM(RTRIM(@HoTen)) = ''
        RAISERROR(N'Bạn chưa nhập Họ tên.', 16, 1); RETURN;
    IF @MaKhoa IS NULL OR LTRIM(RTRIM(@MaKhoa)) = ''
        RAISERROR(N'Bạn chưa nhập Mã khoa.', 16, 1); RETURN;
    IF @MaChucVu IS NULL OR LTRIM(RTRIM(@MaChucVu)) = ''
        RAISERROR(N'Bạn chưa nhập Mã chức vụ.', 16, 1); RETURN;
    IF @MaTrinhDo IS NULL OR LTRIM(RTRIM(@MaTrinhDo)) = ''
        RAISERROR(N'Bạn chưa nhập Mã trình độ.', 16, 1); RETURN;

    DECLARE @role NVARCHAR(50), @mk NVARCHAR(20);
    SELECT TOP(1) @role = RoleName, @mk = MaKhoa
    FROM dbo.RTO_CurrentPrincipal();

    IF @role <> N'Admin' AND @mk <> @MaKhoa
        RAISERROR(N'Không thêm giảng viên ngoài khoa của bạn.', 16, 1);
    ELSE
        INSERT INTO dbo.CanBo(MaCB, HoTen, NgaySinh, GioiTinh, Email, Phone, MaKhoa, MaChucVu, MaTrinhDo)
        VALUES(@MaCB, @HoTen, @NgaySinh, @GioiTinh, @Email, @Phone, @MaKhoa, @MaChucVu, @MaTrinhDo);
END
GO

CREATE OR ALTER PROCEDURE dbo.HasP_UpdateCanBo
    @MaCB NVARCHAR(20),
    @HoTen NVARCHAR(200),
    @NgaySinh DATE,
    @GioiTinh NVARCHAR(5),
    @Email NVARCHAR(100),
    @Phone NVARCHAR(20),
    @MaKhoa NVARCHAR(20),
    @MaChucVu NVARCHAR(20),
    @MaTrinhDo NVARCHAR(20)
AS
BEGIN
    -- Kiểm tra nhập thiếu
    IF @MaCB IS NULL OR LTRIM(RTRIM(@MaCB)) = ''
        RAISERROR(N'Bạn chưa nhập Mã cán bộ.', 16, 1); RETURN;
    IF @HoTen IS NULL OR LTRIM(RTRIM(@HoTen)) = ''
        RAISERROR(N'Bạn chưa nhập Họ tên.', 16, 1); RETURN;
    IF @MaKhoa IS NULL OR LTRIM(RTRIM(@MaKhoa)) = ''
        RAISERROR(N'Bạn chưa nhập Mã khoa.', 16, 1); RETURN;
    IF @MaChucVu IS NULL OR LTRIM(RTRIM(@MaChucVu)) = ''
        RAISERROR(N'Bạn chưa nhập Mã chức vụ.', 16, 1); RETURN;
    IF @MaTrinhDo IS NULL OR LTRIM(RTRIM(@MaTrinhDo)) = ''
        RAISERROR(N'Bạn chưa nhập Mã trình độ.', 16, 1); RETURN;

    DECLARE @role NVARCHAR(50), @mk NVARCHAR(20), @target NVARCHAR(20);
    SELECT TOP(1) @role = RoleName, @mk = MaKhoa
    FROM dbo.RTO_CurrentPrincipal();

    SELECT @target = cb.MaKhoa FROM dbo.CanBo cb WHERE cb.MaCB = @MaCB;

    IF @target IS NULL
        RAISERROR(N'Cán bộ không tồn tại.', 16, 1);
    ELSE IF @role <> N'Admin' AND @target <> @mk
        RAISERROR(N'Không sửa giảng viên ngoài khoa của bạn.', 16, 1);
    ELSE
        UPDATE dbo.CanBo
        SET HoTen = @HoTen,
            NgaySinh = @NgaySinh,
            GioiTinh = @GioiTinh,
            Email = @Email,
            Phone = @Phone,
            MaKhoa = @MaKhoa,
            MaChucVu = @MaChucVu,
            MaTrinhDo = @MaTrinhDo
        WHERE MaCB = @MaCB;
END
GO


CREATE OR ALTER PROCEDURE dbo.HasP_DeleteCanBo
    @MaCB NVARCHAR(20)
AS
BEGIN
    DECLARE @role NVARCHAR(50), @mk NVARCHAR(20), @target NVARCHAR(20);
    SELECT TOP(1) @role = RoleName, @mk = MaKhoa
    FROM dbo.RTO_CurrentPrincipal();

    SELECT @target = cb.MaKhoa FROM dbo.CanBo cb WHERE cb.MaCB = @MaCB;

    IF @target IS NULL
        RAISERROR(N'Cán bộ không tồn tại.', 16, 1);
    ELSE IF @role <> N'Admin' AND @target <> @mk
        RAISERROR(N'Không xóa giảng viên ngoài khoa của bạn.', 16, 1);
    ELSE
        DELETE FROM dbo.CanBo WHERE MaCB = @MaCB;
END
GO

CREATE OR ALTER PROCEDURE NonP_GetAllCanBo
AS
BEGIN
 SELECT * FROM CanBo;
END;
GO

CREATE OR ALTER PROCEDURE dbo.HasP_GetCanBoByName
    @HoTen NVARCHAR(200)
AS
BEGIN
    DECLARE @role NVARCHAR(50), @mk NVARCHAR(20);
    SELECT TOP(1) @role = RoleName, @mk = MaKhoa
    FROM dbo.RTO_CurrentPrincipal();

    IF @role = N'Admin'
    BEGIN
        SELECT MaCB, HoTen, MaKhoa, MaChucVu, MaTrinhDo, Email, Phone, NgaySinh, GioiTinh
        FROM dbo.CanBo
        WHERE HoTen LIKE N'%' + @HoTen + N'%';
    END
    ELSE
    BEGIN
        SELECT MaCB, HoTen, MaKhoa, MaChucVu, MaTrinhDo, Email, Phone, NgaySinh, GioiTinh
        FROM dbo.CanBo
        WHERE HoTen LIKE N'%' + @HoTen + N'%' AND MaKhoa = @mk;
    END
END
GO


-------------------------------------------------------------
-- CRUD: MonHoc
-------------------------------------------------------------
-- Lấy tất cả môn của ngành
CREATE OR ALTER PROCEDURE HasP_GetMonHocByNganh
    @MaNganh NVARCHAR(20)
AS
BEGIN
    SELECT mh.MaMon, mh.TenMon, mh.SoTiet, mh.SoTinChi, ctmh.BatBuoc
    FROM ChuongTrinh ct
    JOIN ChuongTrinh_MonHoc ctmh ON ct.MaCT = ctmh.MaCT
    JOIN MonHoc mh ON ctmh.MaMon = mh.MaMon
    WHERE ct.MaNganh = @MaNganh;
END;
GO

-- INSERT môn học đầy đủ
CREATE OR ALTER PROCEDURE dbo.HasP_InsertMonHoc
    @MaMon NVARCHAR(20),
    @TenMon NVARCHAR(200),
    @SoTiet INT,
    @SoTinChi INT,
    @MaKhoaPhuTrach NVARCHAR(20),
    @MaCT NVARCHAR(20),
    @BatBuoc BIT
AS
BEGIN
    DECLARE @role NVARCHAR(50), @mk NVARCHAR(20);
    SELECT TOP(1) @role = RoleName, @mk = MaKhoa FROM dbo.RTO_CurrentPrincipal();

    IF @role <> N'Admin' AND @MaKhoaPhuTrach <> @mk
        RAISERROR(N'Không thêm môn ngoài khoa của bạn.', 16, 1);
    ELSE
    BEGIN
        -- Nếu môn chưa tồn tại thì thêm mới
        IF NOT EXISTS (SELECT 1 FROM dbo.MonHoc WHERE MaMon = @MaMon)
        BEGIN
            INSERT INTO dbo.MonHoc(MaMon, TenMon, SoTiet, SoTinChi, MaKhoaPhuTrach)
            VALUES(@MaMon, @TenMon, @SoTiet, @SoTinChi, @MaKhoaPhuTrach);
        END

        -- Thêm vào chương trình - môn học
        INSERT INTO dbo.ChuongTrinh_MonHoc(MaCT, MaMon, BatBuoc)
        VALUES(@MaCT, @MaMon, @BatBuoc);
    END
END
GO

-- UPDATE môn học đầy đủ
CREATE OR ALTER PROCEDURE dbo.HasP_UpdateMonHoc
    @MaMon NVARCHAR(20),
    @TenMon NVARCHAR(200),
    @SoTiet INT,
    @SoTinChi INT,
    @MaKhoaPhuTrach NVARCHAR(20),
    @MaCT NVARCHAR(20),
    @BatBuoc BIT
AS
BEGIN
    DECLARE @role NVARCHAR(50), @mk NVARCHAR(20), @target NVARCHAR(20);
    SELECT TOP(1) @role = RoleName, @mk = MaKhoa FROM dbo.RTO_CurrentPrincipal();
    SELECT @target = MaKhoaPhuTrach FROM dbo.MonHoc WHERE MaMon = @MaMon;

    IF @target IS NULL
        RAISERROR(N'Môn học không tồn tại.', 16, 1);
    ELSE IF @role <> N'Admin' AND @target <> @mk
        RAISERROR(N'Không sửa môn ngoài khoa của bạn.', 16, 1);
    ELSE
    BEGIN
        UPDATE dbo.MonHoc
        SET TenMon = @TenMon,
            SoTiet = @SoTiet,
            SoTinChi = @SoTinChi,
            MaKhoaPhuTrach = @MaKhoaPhuTrach
        WHERE MaMon = @MaMon;

        UPDATE dbo.ChuongTrinh_MonHoc
        SET BatBuoc = @BatBuoc
        WHERE MaCT = @MaCT AND MaMon = @MaMon;
    END
END
GO

-- DELETE môn học
CREATE OR ALTER PROCEDURE dbo.HasP_DeleteMonHoc
    @MaMon NVARCHAR(20),
    @MaCT NVARCHAR(20)
AS
BEGIN
    DECLARE @role NVARCHAR(50), @mk NVARCHAR(20), @target NVARCHAR(20);
    SELECT TOP(1) @role = RoleName, @mk = MaKhoa FROM dbo.RTO_CurrentPrincipal();
    SELECT @target = MaKhoaPhuTrach FROM dbo.MonHoc WHERE MaMon = @MaMon;

    IF @target IS NULL
        RAISERROR(N'Môn học không tồn tại.', 16, 1);
    ELSE IF @role <> N'Admin' AND @target <> @mk
        RAISERROR(N'Không xóa môn ngoài khoa của bạn.', 16, 1);
    ELSE
    BEGIN
        DELETE FROM dbo.ChuongTrinh_MonHoc WHERE MaCT = @MaCT AND MaMon = @MaMon;

        IF NOT EXISTS (SELECT 1 FROM dbo.ChuongTrinh_MonHoc WHERE MaMon = @MaMon)
            DELETE FROM dbo.MonHoc WHERE MaMon = @MaMon;
    END
END
GO

CREATE OR ALTER PROCEDURE HasP_GetNganhByKhoa
    @MaKhoa NVARCHAR(20)
AS
BEGIN
    SELECT MaNganh, TenNganh FROM Nganh WHERE MaKhoa = @MaKhoa;
END;


CREATE OR ALTER PROCEDURE HasP_GetChuongTrinhByNganh
    @MaNganh NVARCHAR(20)
AS
BEGIN
    SELECT TOP 1 MaCT, TenCT FROM ChuongTrinh WHERE MaNganh = @MaNganh;
END;


CREATE OR ALTER PROCEDURE HasP_GetMonHocByCT
    @MaCT NVARCHAR(20)
AS
BEGIN
    SELECT mh.MaMon, mh.TenMon, mh.SoTiet, mh.SoTinChi, ctmh.BatBuoc
    FROM ChuongTrinh_MonHoc ctmh
    JOIN MonHoc mh ON ctmh.MaMon = mh.MaMon
    WHERE ctmh.MaCT = @MaCT;
END;

CREATE OR ALTER PROCEDURE HasP_SearchMonHoc
    @MaCT NVARCHAR(20),
    @Keyword NVARCHAR(100)
AS
BEGIN
    SELECT mh.MaMon, mh.TenMon, mh.SoTiet, mh.SoTinChi, ctmh.BatBuoc
    FROM ChuongTrinh_MonHoc ctmh
    JOIN MonHoc mh ON ctmh.MaMon = mh.MaMon
    WHERE ctmh.MaCT = @MaCT
      AND mh.TenMon LIKE '%' + @Keyword + '%';
END;


-------------------------------------------------------------
-- CRUD: LopHocPhan
-------------------------------------------------------------
--------------------------------------------------------
-- Thêm lớp học phần
--------------------------------------------------------
-- INSERT: tạo mã lớp và tên lớp tự động từ @MaMon + @SoThuTu
CREATE OR ALTER PROCEDURE dbo.HasP_InsertLopHocPhan
    @MaMon NVARCHAR(20),
    @SoThuTu INT,
    @SoLuongSV INT
AS
BEGIN
    DECLARE @role NVARCHAR(50), @mk NVARCHAR(20),
            @khoaMon NVARCHAR(20), @tenMon NVARCHAR(200),
            @MaLop NVARCHAR(32), @TenLop NVARCHAR(250);

    SELECT TOP(1) @role=RoleName, @mk=MaKhoa FROM dbo.RTO_CurrentPrincipal();
    SELECT @khoaMon = MaKhoaPhuTrach, @tenMon = TenMon
    FROM dbo.MonHoc WHERE MaMon = @MaMon;

    IF @khoaMon IS NULL
        RAISERROR(N'Môn học không tồn tại.',16,1);
    ELSE IF @role <> N'Admin' AND @khoaMon <> @mk
        RAISERROR(N'Không thêm lớp ngoài khoa của bạn.',16,1);
    ELSE
    BEGIN
        -- Mã lớp dạng MaMon_XX (01, 02, 03, ...)
        SET @MaLop = @MaMon + N'_' + RIGHT('00' + CAST(@SoThuTu AS NVARCHAR(2)),2);

        -- Tên lớp = tên môn (không thêm đuôi nhóm)
        SET @TenLop = @tenMon;

        IF EXISTS (SELECT 1 FROM dbo.LopHocPhan WHERE MaLopHocPhan = @MaLop)
            RAISERROR(N'Mã lớp đã tồn tại.',16,1);
        ELSE
            INSERT dbo.LopHocPhan(MaLopHocPhan, TenLopHocPhan, MaMon, SoLuongSV)
            VALUES(@MaLop, @TenLop, @MaMon, @SoLuongSV);
    END
END
GO


CREATE OR ALTER PROCEDURE dbo.HasP_UpdateLopHocPhan
    @OldMaLopHocPhan NVARCHAR(20),
    @SoThuTu INT,
    @SoLuongSV INT
AS
BEGIN
    DECLARE @role NVARCHAR(50), @mk NVARCHAR(20),
            @targetKhoa NVARCHAR(20),
            @MaMon NVARCHAR(20), @TenMon NVARCHAR(200),
            @NewMaLop NVARCHAR(32), @NewTenLop NVARCHAR(250);

    SELECT TOP(1) @role=RoleName, @mk=MaKhoa 
    FROM dbo.RTO_CurrentPrincipal();

    -- Lấy thông tin lớp cũ
    SELECT lhp.MaMon, mh.TenMon, mh.MaKhoaPhuTrach
    INTO #tmp
    FROM dbo.LopHocPhan lhp
    JOIN dbo.MonHoc mh ON lhp.MaMon = mh.MaMon
    WHERE lhp.MaLopHocPhan = @OldMaLopHocPhan;

    IF NOT EXISTS (SELECT 1 FROM #tmp)
    BEGIN
        RAISERROR(N'Lớp học phần không tồn tại.',16,1);
        RETURN;
    END

    SELECT @MaMon=MaMon, @TenMon=TenMon, @targetKhoa=MaKhoaPhuTrach FROM #tmp;
    DROP TABLE #tmp;

    IF @role <> N'Admin' AND @targetKhoa <> @mk
        RAISERROR(N'Không sửa lớp ngoài khoa của bạn.',16,1);
    ELSE
    BEGIN
        -- Sinh mã lớp mới theo số thứ tự
        SET @NewMaLop = @MaMon + N'_' + RIGHT('00' + CAST(@SoThuTu AS NVARCHAR(2)),2);

        -- Tên lớp = tên môn (không đổi)
        SET @NewTenLop = @TenMon;

        -- Nếu mã mới trùng lớp khác thì báo lỗi
        IF EXISTS (SELECT 1 FROM dbo.LopHocPhan WHERE MaLopHocPhan=@NewMaLop AND MaLopHocPhan<>@OldMaLopHocPhan)
            RAISERROR(N'Mã lớp mới đã tồn tại.',16,1);
        ELSE
            UPDATE dbo.LopHocPhan
            SET MaLopHocPhan = @NewMaLop,
                TenLopHocPhan = @NewTenLop,
                SoLuongSV = @SoLuongSV
            WHERE MaLopHocPhan = @OldMaLopHocPhan;
    END
END
GO


CREATE OR ALTER PROCEDURE dbo.HasP_DeleteLopHocPhan
    @MaLopHocPhan NVARCHAR(20)
AS
BEGIN
    DECLARE @role NVARCHAR(50), @mk NVARCHAR(20), @target NVARCHAR(20);
    SELECT TOP(1) @role=RoleName, @mk=MaKhoa FROM dbo.RTO_CurrentPrincipal();

    SELECT @target = mh.MaKhoaPhuTrach
    FROM dbo.LopHocPhan lhp
    JOIN dbo.MonHoc mh ON lhp.MaMon = mh.MaMon
    WHERE lhp.MaLopHocPhan = @MaLopHocPhan;

    IF @target IS NULL
        RAISERROR(N'Lớp học phần không tồn tại.',16,1);
    ELSE IF @role <> N'Admin' AND @target <> @mk
        RAISERROR(N'Không xóa lớp ngoài khoa của bạn.',16,1);
    ELSE
        DELETE FROM dbo.LopHocPhan WHERE MaLopHocPhan = @MaLopHocPhan;
END
GO


--------------------------------------------------------
-- Lấy lớp học phần theo môn học
--------------------------------------------------------
CREATE OR ALTER PROCEDURE HasP_GetLopHocPhanByMon
    @MaMon NVARCHAR(20)
AS
BEGIN
    SELECT lhp.MaLopHocPhan, lhp.MaMon, lhp.TenLopHocPhan,
           lhp.MaKhoa, lhp.MaNganh, lhp.MaCT, lhp.SoLuongSV
    FROM LopHocPhan lhp
    WHERE lhp.MaMon = @MaMon;
END;
GO


-------------------------------------------------------------
-- CRUD: Ngành
-------------------------------------------------------------
CREATE OR ALTER PROCEDURE HasP_InsertNganh -- dùng
 @MaNganh NVARCHAR(20),
 @TenNganh NVARCHAR(200),
 @MaKhoa NVARCHAR(20)
AS
BEGIN
 INSERT INTO Nganh(MaNganh, TenNganh, MaKhoa)
 VALUES(@MaNganh, @TenNganh, @MaKhoa);
END;
GO

CREATE OR ALTER PROCEDURE HasP_UpdateNganh -- dùng
 @MaNganh NVARCHAR(20),
 @TenNganh NVARCHAR(200),
 @MaKhoa NVARCHAR(20)
AS
BEGIN
 UPDATE Nganh
 SET TenNganh=@TenNganh, MaKhoa=@MaKhoa
 WHERE MaNganh=@MaNganh;
END;
GO

CREATE OR ALTER PROCEDURE HasP_DeleteNganh -- dùng
 @MaNganh NVARCHAR(20)
AS
BEGIN
 DELETE FROM Nganh WHERE MaNganh=@MaNganh;
END;
GO



-------------------------------------------------------------
-- CRUD: Phân công
-------------------------------------------------------------
-- Giảng viên theo khoa
CREATE OR ALTER PROCEDURE dbo.HasP_GetGiangVienByKhoa @MaKhoa NVARCHAR(20)
AS
BEGIN
    DECLARE @role NVARCHAR(50), @mk NVARCHAR(20);
    SELECT TOP(1) @role=RoleName,@mk=MaKhoa FROM dbo.RTO_CurrentPrincipal();

    IF @role<>N'Admin' AND @MaKhoa<>@mk
        RAISERROR(N'Không có quyền xem giảng viên ngoài khoa của bạn.',16,1);
    ELSE
        SELECT MaCB,HoTen,MaKhoa,MaBacLuong,PhuCap FROM dbo.CanBo WHERE MaKhoa=@MaKhoa;
END
GO

CREATE OR ALTER PROCEDURE dbo.HasP_GetGiangVienByKhoa_GV
    @MaKhoa NVARCHAR(20)
AS
BEGIN
    SELECT cb.MaCB,
           cb.HoTen,
           cb.MaKhoa,
           cb.MaChucVu,
           cb.MaTrinhDo,
           cb.Email,
           cb.Phone,
           cb.NgaySinh,
           cb.GioiTinh
    FROM dbo.CanBo cb
    CROSS JOIN dbo.RTO_CurrentPrincipal() cp
    WHERE cb.MaKhoa = @MaKhoa
      AND (cp.RoleName = N'Admin' OR cp.MaKhoa = @MaKhoa);
END

-- Danh sách ngành theo khoa
CREATE OR ALTER PROCEDURE HasP_GetNganhByKhoa
    @MaKhoa NVARCHAR(20)
AS
BEGIN
    SELECT MaNganh, TenNganh
    FROM Nganh
    WHERE MaKhoa = @MaKhoa;
END;
GO

-- Môn học theo ngành
CREATE OR ALTER PROCEDURE HasP_GetMonHocByNganh_PC
    @MaNganh NVARCHAR(20)
AS
BEGIN

    SELECT DISTINCT mh.MaMon, mh.TenMon, mh.SoTiet
    FROM ChuongTrinh ct
    JOIN ChuongTrinh_MonHoc ctmh ON ct.MaCT = ctmh.MaCT
    JOIN MonHoc mh ON ctmh.MaMon = mh.MaMon
    WHERE ct.MaNganh = @MaNganh
    ORDER BY mh.TenMon;
END;
GO

-- Lớp học phần của môn CHƯA phân công trong HK + NH
CREATE OR ALTER PROCEDURE HasP_GetLopChuaPhanCong
    @MaMon NVARCHAR(20)
AS
BEGIN
    SELECT MaLopHocPhan, TenLopHocPhan
    FROM LopHocPhan
    WHERE MaMon = @MaMon
      AND NOT EXISTS (
          SELECT 1 FROM PhanCongGiangDay
          WHERE PhanCongGiangDay.MaLopHocPhan = LopHocPhan.MaLopHocPhan
      );
END;
GO

-- Lấy số tiết mặc định của môn
CREATE OR ALTER PROCEDURE HasP_GetSoTietByMon
    @MaMon NVARCHAR(20)
AS
BEGIN
    SELECT SoTiet FROM MonHoc WHERE MaMon = @MaMon;
END;
GO

-- Thêm phân công
CREATE OR ALTER PROCEDURE dbo.HasP_InsertPhanCong
    @MaLopHocPhan NVARCHAR(20),
    @MaCB NVARCHAR(20),
    @MaMon NVARCHAR(20),
    @SoTiet INT,
    @SoTuan INT,
    @HocKy INT,
    @NamHoc NVARCHAR(20),
    @MaNganh NVARCHAR(20)
AS
BEGIN
    DECLARE @role NVARCHAR(50), @mk NVARCHAR(20), @target NVARCHAR(20), @TenMon NVARCHAR(200);

    SELECT TOP(1) @role=RoleName,@mk=MaKhoa FROM dbo.RTO_CurrentPrincipal();
    SELECT @target=cb.MaKhoa FROM dbo.CanBo cb WHERE cb.MaCB=@MaCB;
    SELECT @TenMon=TenMon FROM dbo.MonHoc WHERE MaMon=@MaMon;

    IF @role<>N'Admin' AND @target<>@mk
        RAISERROR(N'Không phân công giảng viên ngoài khoa.',16,1);
    ELSE
        INSERT INTO dbo.PhanCongGiangDay
        (MaLopHocPhan, MaCB, MaNganh, MaMon, TenMon, SoTiet, SoTuan, HocKy, NamHoc)
        VALUES(@MaLopHocPhan,@MaCB,@MaNganh,@MaMon,@TenMon,@SoTiet,@SoTuan,@HocKy,@NamHoc);
END
GO



CREATE OR ALTER PROCEDURE dbo.HasP_UpdatePhanCong
	@OldMaCB NVARCHAR(20),
    @OldMaMon NVARCHAR(20),
    @OldMaLopHocPhan NVARCHAR(20),
    @OldHocKy INT,
    @OldNamHoc NVARCHAR(9),

    @NewMaMon NVARCHAR(20),
    @NewMaLopHocPhan NVARCHAR(20),
    @NewSoTiet INT,
    @NewSoTuan INT,
    @NewHocKy INT,
    @NewNamHoc NVARCHAR(9),
    @NewMaNganh NVARCHAR(20)   -- thêm ngành
AS
BEGIN
    DECLARE @role NVARCHAR(50), @mk NVARCHAR(20), @target NVARCHAR(20), @TenMon NVARCHAR(200);
    SELECT TOP(1) @role=RoleName, @mk=MaKhoa FROM dbo.RTO_CurrentPrincipal();
    SELECT @target=cb.MaKhoa FROM dbo.CanBo cb WHERE cb.MaCB=@OldMaCB;
    SELECT @TenMon=TenMon FROM dbo.MonHoc WHERE MaMon=@NewMaMon;

    IF @target IS NULL
        RAISERROR(N'Giảng viên mới không tồn tại.',16,1);
    ELSE IF @role<>N'Admin' AND @target<>@mk
        RAISERROR(N'Không phân công giảng viên ngoài khoa.',16,1);
    ELSE
        UPDATE dbo.PhanCongGiangDay
        SET MaLopHocPhan=@NewMaLopHocPhan,
            MaNganh=@NewMaNganh,
            MaMon=@NewMaMon,
            TenMon=@TenMon,
			-- TenMon=(SELECT TenMon FROM MonHoc WHERE MaMon=@NewMaMon),
            SoTiet=@NewSoTiet,
            SoTuan=@NewSoTuan,
            HocKy=@NewHocKy,
            NamHoc=@NewNamHoc
        WHERE MaLopHocPhan=@OldMaLopHocPhan 
          AND MaCB=@OldMaCB 
          AND HocKy=@OldHocKy 
          AND NamHoc=@OldNamHoc
		  --AND MaMon=@OldMaMon
		  ;
END
GO



CREATE OR ALTER PROCEDURE dbo.HasP_DeletePhanCong
    @MaLopHocPhan NVARCHAR(20),
    @MaCB NVARCHAR(20),
    @HocKy INT,
    @NamHoc NVARCHAR(20),
	@MaMon NVARCHAR(20)
AS
BEGIN
    DECLARE @role NVARCHAR(50), @mk NVARCHAR(20), @target NVARCHAR(20);
    SELECT TOP(1) @role=RoleName, @mk=MaKhoa FROM dbo.RTO_CurrentPrincipal();

    SELECT @target=cb.MaKhoa
    FROM dbo.CanBo cb
    WHERE cb.MaCB=@MaCB;

    IF @target IS NULL
        RAISERROR(N'Giảng viên không tồn tại.',16,1);
    ELSE IF @role<>N'Admin' AND @target<>@mk
        RAISERROR(N'Không xóa phân công ngoài khoa.',16,1);
    ELSE
        DELETE FROM dbo.PhanCongGiangDay
        WHERE MaLopHocPhan=@MaLopHocPhan AND MaCB=@MaCB
              AND HocKy=@HocKy AND NamHoc=@NamHoc;
END
GO

-- Danh sách phân công theo khoa
CREATE OR ALTER PROCEDURE HasP_GetPhanCongByKhoa
    @MaKhoa NVARCHAR(20)
AS
BEGIN

    SELECT pc.MaCB, pc.MaMon, pc.TenMon, pc.MaLopHocPhan,
		   pc.SoTiet, pc.SoTuan, pc.HocKy, pc.NamHoc, pc.MaNganh
	FROM PhanCongGiangDay pc
	JOIN CanBo cb ON pc.MaCB = cb.MaCB
	WHERE cb.MaKhoa = @MaKhoa
	ORDER BY pc.NamHoc DESC, pc.HocKy, pc.TenMon;
END;
go




/*=========================
		3. FUNCTION
  =========================*/

  -- 1. Check format năm học
CREATE OR ALTER FUNCTION RNO_IsValidNamHoc(@NamHoc NVARCHAR(9))
RETURNS BIT
AS
BEGIN
    -- hợp lệ: '2025-2026' (9 ký tự, có dấu - ở giữa, số sau = số trước + 1)
    IF @NamHoc IS NULL OR LEN(@NamHoc) <> 9 OR SUBSTRING(@NamHoc,5,1) <> '-'
        RETURN 0;

    DECLARE @y1 INT = TRY_CAST(LEFT(@NamHoc,4) AS INT);
    DECLARE @y2 INT = TRY_CAST(RIGHT(@NamHoc,4) AS INT);

    IF @y1 IS NULL OR @y2 IS NULL OR @y2 <> @y1 + 1 OR @y1 < 2000 OR @y2 > 2100
        RETURN 0;

    RETURN 1;
END;
GO



CREATE OR ALTER PROCEDURE Re_TinhLuongCanBo
    @MaCB NVARCHAR(20),
    @Thang INT,
    @Nam INT,
    @Thuong DECIMAL(18,2) = 0,
    @KhauTru DECIMAL(18,2) = 0
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRAN;

        -- Kiểm tra cán bộ tồn tại
        IF NOT EXISTS (SELECT 1 FROM CanBo WHERE MaCB=@MaCB)
        BEGIN
            RAISERROR(N'Cán bộ không tồn tại',16,1);
            ROLLBACK TRAN;
            RETURN;
        END;

        -- Kiểm tra đã có lương tháng/năm chưa
        IF EXISTS (SELECT 1 FROM BangLuong WHERE MaCB=@MaCB AND Thang=@Thang AND Nam=@Nam)
        BEGIN
            RAISERROR(N'Đã có bảng lương cho cán bộ này trong tháng/năm', 16, 1);
            ROLLBACK TRAN;
            RETURN;
        END;

        -- Chèn bản ghi lương
        INSERT INTO BangLuong(MaCB, Thang, Nam, Thuong, KhauTru)
        VALUES(@MaCB, @Thang, @Nam, @Thuong, @KhauTru);

        COMMIT TRAN;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN;
        THROW;
    END CATCH
END;
GO


EXEC Re_TinhLuongCanBo '2003', 9, 2025, 500000, 200000;
SELECT * FROM Vw_CanBo_Luong;



CREATE OR ALTER PROCEDURE HasP_UpdateBangLuong
    @MaCB NVARCHAR(20),
    @Thang INT,
    @Nam INT,
    @Thuong DECIMAL(18,2),
    @KhauTru DECIMAL(18,2)
AS
BEGIN
    UPDATE BangLuong
    SET Thuong=@Thuong, KhauTru=@KhauTru
    WHERE MaCB=@MaCB AND Thang=@Thang AND Nam=@Nam;
END
GO
EXEC HasP_UpdateBangLuong
    @MaCB = N'1982',
    @Thang = 12,
    @Nam = 2026,
    @Thuong = 1500000,
    @KhauTru = 100000;
GO

-- Kiểm tra lại
SELECT * FROM BangLuong WHERE MaCB = '1982' AND Thang = 12 AND Nam = 2026;

-- Delete
CREATE OR ALTER PROCEDURE HasP_DeleteBangLuong
    @MaCB NVARCHAR(20),
    @Thang INT,
    @Nam INT
AS
BEGIN
    DELETE FROM BangLuong
    WHERE MaCB=@MaCB AND Thang=@Thang AND Nam=@Nam;
END
GO

EXEC HasP_DeleteBangLuong
    @MaCB = N'1982',
    @Thang = 12,
    @Nam = 2026;
GO

-- Kiểm tra lại
SELECT * FROM BangLuong WHERE MaCB = '2003' AND Thang = 9 AND Nam = 2025;

CREATE OR ALTER PROCEDURE NonP_GetAllKhoa
AS
BEGIN
    SELECT MaKhoa, TenKhoa FROM Khoa;
END;

/*=========================
		  5. VIEW
  =========================*/
  


-- View: Lương giảng viên chi tiết
CREATE OR ALTER VIEW Vw_CanBo_Luong
AS
SELECT 
    bl.MaCB,
    cb.HoTen,
    bl.Thang,
    bl.Nam,
    cb.PhuCap,
    bl.Thuong,
    bl.KhauTru,
    b.HeSoLuong,
    ch.MucLuongCoSo,
    (ch.MucLuongCoSo * b.HeSoLuong + cb.PhuCap + bl.Thuong - bl.KhauTru) AS TongLuong
FROM BangLuong bl
JOIN CanBo cb ON bl.MaCB = cb.MaCB
JOIN BacLuong b ON cb.MaBacLuong = b.MaBacLuong
CROSS APPLY (SELECT TOP 1 MucLuongCoSo FROM CauHinhLuong) ch;
SELECT * FROM Vw_CanBo_Luong;





CREATE OR ALTER VIEW dbo.Vw_CanBo_TrongKhoaCuaToi
AS
SELECT cb.MaCB,
       cb.HoTen,
       cb.MaKhoa,
       cb.MaChucVu,
       cb.MaTrinhDo,
       cb.Email,
       cb.Phone,
       cb.NgaySinh,
       cb.GioiTinh
FROM dbo.CanBo cb
CROSS JOIN dbo.RTO_CurrentPrincipal() cp
WHERE cp.RoleName IN (N'TruongKhoa', N'GiangVien')
  AND cb.MaKhoa = cp.MaKhoa;


CREATE OR ALTER VIEW dbo.Vw_MonHoc_TrongKhoaCuaToi
AS
SELECT mh.MaMon,
       mh.TenMon,
       mh.MaKhoaPhuTrach
FROM dbo.MonHoc mh
CROSS JOIN dbo.RTO_CurrentPrincipal() cp
WHERE cp.RoleName IN (N'TruongKhoa', N'GiangVien')
  AND mh.MaKhoaPhuTrach = cp.MaKhoa;
GO


CREATE OR ALTER VIEW dbo.Vw_LopHP_TrongKhoaCuaToi
AS
SELECT lhp.MaLopHocPhan,
       lhp.MaMon,
       lhp.TenLopHocPhan,
       lhp.SoLuongSV,
       mh.MaKhoaPhuTrach
FROM dbo.LopHocPhan lhp
JOIN dbo.MonHoc mh ON lhp.MaMon = mh.MaMon
CROSS JOIN dbo.RTO_CurrentPrincipal() cp
WHERE cp.RoleName IN (N'TruongKhoa', N'GiangVien')
  AND mh.MaKhoaPhuTrach = cp.MaKhoa;
GO



CREATE OR ALTER VIEW dbo.Vw_PhanCong_CuaToi
AS
SELECT 
    pc.MaCB,
    pc.MaMon,
    mh.TenMon,
    pc.MaLopHocPhan,
    lhp.TenLopHocPhan,
    pc.SoTiet,
    pc.SoTuan,
    pc.HocKy,
    pc.NamHoc,
    pc.MaNganh
FROM dbo.PhanCongGiangDay pc
JOIN dbo.MonHoc mh ON pc.MaMon = mh.MaMon
JOIN dbo.LopHocPhan lhp ON pc.MaLopHocPhan = lhp.MaLopHocPhan
CROSS JOIN dbo.RTO_CurrentPrincipal() cp
WHERE pc.MaCB = cp.MaCB;
GO


CREATE OR ALTER VIEW dbo.Vw_Nganh_TrongKhoaCuaToi
AS
SELECT ng.MaNganh,
       ng.TenNganh,
       ng.MaKhoa
FROM dbo.Nganh ng
CROSS JOIN dbo.RTO_CurrentPrincipal() cp
WHERE cp.RoleName IN (N'TruongKhoa', N'GiangVien')
  AND ng.MaKhoa = cp.MaKhoa;
GO

 
CREATE OR ALTER VIEW dbo.Vw_Khoa_CuaToi
AS
SELECT DISTINCT k.MaKhoa, k.TenKhoa
FROM dbo.Khoa k
JOIN dbo.CanBo cb ON cb.MaKhoa = k.MaKhoa
CROSS JOIN dbo.RTO_CurrentPrincipal() cp
WHERE cp.RoleName IN (N'TruongKhoa', N'GiangVien')
  AND cb.MaCB = cp.MaCB;
GO

-- 12. 
CREATE OR ALTER VIEW Vw_Luong_CuaToi
AS
SELECT v.*
FROM Vw_CanBo_Luong v
CROSS JOIN RTO_CurrentPrincipal() cp
WHERE v.MaCB = cp.MaCB;

SELECT * FROM Vw_Luong_CuaToi;