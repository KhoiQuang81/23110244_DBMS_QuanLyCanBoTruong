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

-- Hồ sơ cá nhân
GRANT EXECUTE ON dbo.Re_UpdateHoSoCaNhan     TO r_TruongKhoa;



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
-- Hồ sơ cá nhân
GRANT EXECUTE ON dbo.Re_UpdateHoSoCaNhan			TO r_GiangVien;





/*=========================
	 2. STORED PROCEDURE
  =========================*/


  -- 1. Thêm bảng lương cho 1 cán bộ trong tháng
CREATE OR ALTER PROCEDURE Re_InsertBangLuong
    @MaCB NVARCHAR(20),
    @ThangNam CHAR(7),
    @LuongCoBan DECIMAL(18,2),
    @HeSoId INT = NULL,
    @TongPhuCap DECIMAL(18,2) = 0,
    @KhauTru DECIMAL(18,2) = 0
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRAN;
        IF EXISTS (SELECT 1 FROM BangLuong WHERE MaCB=@MaCB AND ThangNam=@ThangNam)
        BEGIN
            RAISERROR(N'Bảng lương tháng này đã tồn tại cho cán bộ', 16, 1);
            ROLLBACK TRAN;
            RETURN;
        END
        INSERT INTO BangLuong(MaCB, ThangNam, LuongCoBan, HeSoId, TongPhuCap, KhauTru)
        VALUES(@MaCB, @ThangNam, @LuongCoBan, @HeSoId, @TongPhuCap, @KhauTru);
        COMMIT TRAN;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN;
        THROW;
    END CATCH
END;
GO

EXEC Re_InsertBangLuong '1980', '2025-09', 6000000, 2, 500000, 200000;
-- chạy lại cùng tháng để test RAISERROR
EXEC Re_InsertBangLuong '1980', '2025-09', 6000000, 2, 500000, 200000;



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

EXEC HasP_InsertCanBo '2020', N'Vũ Đình Bảo', '1993-05-20', 'M', 'baovd@hcmute.edu.vn', '0909999999', '05', 'GV', 'ThS', NULL;
EXEC HasP_UpdateCanBo '2020', N'Vũ Đình Bảo', '1993-05-20', 'M', 'baovd@hcmute.edu.vn', '0909999999', '05', 'GV', 'TS';
EXEC HasP_GetCanBoById '2020';
EXEC NonP_GetAllCanBo;
EXEC HasP_DeleteCanBo '2020';



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

-- 
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
-- Sửa lớp học phần (chỉ số thứ tự và số lượng SV)
--------------------------------------------------------
CREATE OR ALTER PROCEDURE HasP_UpdateLopHocPhan
    @OldMaLopHocPhan NVARCHAR(30),
    @SoThuTu INT,
    @SoLuongSV INT
AS
BEGIN
    DECLARE @MaMon NVARCHAR(20), @NewMaLopHocPhan NVARCHAR(30);

    -- Lấy lại mã môn từ lớp học phần cũ
    SELECT @MaMon = MaMon FROM LopHocPhan WHERE MaLopHocPhan = @OldMaLopHocPhan;

    IF @MaMon IS NULL
    BEGIN
        RAISERROR(N'Lớp học phần không tồn tại', 16, 1);
        RETURN;
    END

    -- Tạo mã lớp học phần mới dựa trên số thứ tự mới
    SET @NewMaLopHocPhan = @MaMon + '_' + RIGHT('00' + CAST(@SoThuTu AS NVARCHAR(2)), 2);

    UPDATE LopHocPhan
    SET MaLopHocPhan = @NewMaLopHocPhan,
        SoLuongSV = @SoLuongSV
    WHERE MaLopHocPhan = @OldMaLopHocPhan;
END;
GO


--------------------------------------------------------
-- Xoá lớp học phần
--------------------------------------------------------
CREATE OR ALTER PROCEDURE HasP_DeleteLopHocPhan
    @MaLopHocPhan NVARCHAR(30)
AS
BEGIN
    DELETE FROM LopHocPhan WHERE MaLopHocPhan = @MaLopHocPhan;
END;
GO


--------------------------------------------------------
-- Lấy tất cả lớp học phần
--------------------------------------------------------
CREATE OR ALTER PROCEDURE NonP_GetAllLopHocPhan
AS
BEGIN
    SELECT LHP.MaLopHocPhan, LHP.TenLopHocPhan, LHP.MaMon, MH.TenMon,
           LHP.MaKhoa, LHP.MaNganh, LHP.MaCT, LHP.SoLuongSV
    FROM LopHocPhan LHP
    JOIN MonHoc MH ON LHP.MaMon = MH.MaMon;
END;
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


CREATE OR ALTER PROCEDURE HasP_SearchLopHocPhan
    @MaMon NVARCHAR(20)
AS
BEGIN
    SELECT lhp.MaLopHocPhan, lhp.TenLopHocPhan, lhp.SoLuongSV, mh.TenMon
    FROM LopHocPhan lhp
	JOIN MonHoc mh ON lhp.MaMon = mh.MaMon
    WHERE lhp.MaMon = @MaMon
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

CREATE OR ALTER PROCEDURE NonP_GetAllNganh -- dùng
AS
BEGIN
 SELECT MaNganh, TenNganh FROM Nganh;
END;
GO


-- tìm ngành
CREATE OR ALTER PROCEDURE HasP_GetNganhByKhoa
    @MaKhoa NVARCHAR(20)
AS
BEGIN
    SELECT MaNganh, TenNganh, MaKhoa
    FROM Nganh
    WHERE MaKhoa = @MaKhoa;
END;


-------------------------------------------------------------
-- CRUD: Lớp học phần
-------------------------------------------------------------
-- Lấy tất cả lớp học phần theo ngành
CREATE OR ALTER PROCEDURE HasP_GetLopHocPhanByNganh
    @MaNganh NVARCHAR(20)
AS
BEGIN
    SELECT MaLopHocPhan, TenLopHocPhan, MaKhoa, MaNganh, MaCT, SoLuongSV
    FROM LopHocPhan
    WHERE MaNganh = @MaNganh;
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


-- thông tin cá nhân
CREATE OR ALTER PROCEDURE dbo.Re_UpdateHoSoCaNhan
    @Email NVARCHAR(150)=NULL, @Phone NVARCHAR(20)=NULL
AS
BEGIN
    DECLARE @uid INT;
    SELECT TOP(1) @uid=u.UserId
    FROM dbo.TaiKhoan t JOIN dbo.Users u ON t.UserId=u.UserId
    WHERE t.Username=USER_NAME();

    IF @uid IS NULL
        RAISERROR(N'Không xác định được tài khoản.',16,1);
    ELSE
        UPDATE dbo.Users SET Email=COALESCE(@Email,Email), Phone=COALESCE(@Phone,Phone) WHERE UserId=@uid;
END
GO


-------------------------------------------------------------
-----------------------LƯƠNG---------------------------------
-------------------------------------------------------------





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

-- 2. check lớp chưa phân công
CREATE OR ALTER FUNCTION RTO_LopHP_ChuaPhanCong
(
    @MaMon NVARCHAR(20),
    @HocKy INT,
    @NamHoc NVARCHAR(9)
)
RETURNS TABLE
AS
RETURN
(
    SELECT lhp.MaLopHocPhan, lhp.TenLopHocPhan
    FROM LopHocPhan lhp
    WHERE lhp.MaMon = @MaMon
      AND NOT EXISTS (
            SELECT 1 FROM PhanCongGiangDay pc
            WHERE pc.MaLopHocPhan = lhp.MaLopHocPhan
              AND pc.HocKy = @HocKy
              AND pc.NamHoc = @NamHoc
        )
);
GO

CREATE OR ALTER FUNCTION RTM_PhanCong_ByKhoaNganh
(
    @MaKhoa NVARCHAR(20) = NULL,
    @MaNganh NVARCHAR(20) = NULL,
    @HocKy INT = NULL,
    @NamHoc NVARCHAR(9) = NULL
)
RETURNS @T TABLE
(
    MaCB NVARCHAR(20), TenCB NVARCHAR(150),
    MaMon NVARCHAR(20), TenMon NVARCHAR(200),
    MaLopHocPhan NVARCHAR(20), TenLopHocPhan NVARCHAR(200),
    SoTiet INT, SoTuan INT, HocKy INT, NamHoc NVARCHAR(20)
)
AS
BEGIN
    INSERT @T
    SELECT pc.MaCB, cb.HoTen, pc.MaMon, mh.TenMon,
           pc.MaLopHocPhan, lhp.TenLopHocPhan,
           pc.SoTiet, pc.SoTuan, pc.HocKy, pc.NamHoc
    FROM PhanCongGiangDay pc
    JOIN CanBo cb    ON pc.MaCB = cb.MaCB
    JOIN MonHoc mh   ON pc.MaMon = mh.MaMon
    JOIN LopHocPhan lhp ON pc.MaLopHocPhan = lhp.MaLopHocPhan
    WHERE (@MaKhoa IS NULL  OR lhp.MaKhoa = @MaKhoa)
      AND (@MaNganh IS NULL OR lhp.MaNganh = @MaNganh)
      AND (@HocKy IS NULL   OR pc.HocKy = @HocKy)
      AND (@NamHoc IS NULL  OR pc.NamHoc = @NamHoc);
    RETURN;
END;
GO



/*=========================
		 4. TRIGGER
  =========================*/


  -- 1. Trigger Xét kết quả
CREATE OR ALTER TRIGGER trg_SVL_CalcDiem ON SinhVien_Lop
AFTER INSERT, UPDATE
AS
BEGIN

  UPDATE svl
  SET 
      DiemTrungBinh = ROUND(
          ISNULL(svl.DiemQuaTrinh,0) * 0.5 + ISNULL(svl.DiemCuoiKy,0) * 0.5, 2),
      TrangThai = CASE 
                     WHEN I.DiemCuoiKy IS NULL OR I.DiemQuaTrinh IS NULL THEN NULL
					 WHEN I.DiemCuoiKy < 3 OR (I.DiemQuaTrinh * 0.5 + I.DiemCuoiKy * 0.5) < 5 
						THEN N'Không đạt'
					 ELSE N'Đạt'
                  END
  FROM SinhVien_Lop svl
  INNER JOIN inserted i 
       ON svl.MaSV = i.MaSV AND svl.MaLopHocPhan = i.MaLopHocPhan;
END;
GO
UPDATE SinhVien_Lop
SET DiemQuaTrinh = 8, DiemCuoiKy = 9
WHERE MaSV = '23110244' AND MaLopHocPhan = 'INPR140285_02';



-- 2. Trigger: cập nhật SoLuongSV trong LopHocPhan khi INSERT/DELETE
CREATE OR ALTER TRIGGER trg_UpdateSoLuongSV
ON SinhVien_Lop
AFTER INSERT, DELETE
AS
BEGIN
    UPDATE LHP
    SET SoLuongSV = (SELECT COUNT(*) FROM SinhVien_Lop S WHERE S.MaLopHocPhan = LHP.MaLopHocPhan)
    FROM LopHocPhan LHP
    WHERE LHP.MaLopHocPhan IN (
        SELECT MaLopHocPhan FROM inserted
        UNION
        SELECT MaLopHocPhan FROM deleted
    );
END;
GO
INSERT INTO SinhVien_Lop (MaSV, MaLopHocPhan) VALUES ('23110244', 'PRTE230385_25');
SELECT SoLuongSV FROM LopHocPhan WHERE MaLopHocPhan='PRTE230385_25';

DELETE FROM SinhVien_Lop WHERE MaSV='23110244' AND MaLopHocPhan='PRTE230385_25';
SELECT SoLuongSV FROM LopHocPhan WHERE MaLopHocPhan='PRTE230385_25';



-- 3. Trigger: không cho nhập điểm ngoài thang điểm (0-10)
CREATE OR ALTER TRIGGER trg_CheckDiem
ON SinhVien_Lop
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM inserted WHERE DiemQuaTrinh < 0 OR DiemQuaTrinh > 10 OR DiemCuoiKy < 0 OR DiemCuoiKy > 10)
    BEGIN
        RAISERROR(N'Điểm phải nằm trong khoảng 0 đến 10', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
GO


-- 4. Trigger: ngăn không cho xóa môn học nếu đã có phân công
CREATE OR ALTER TRIGGER trg_PreventDeleteMonHoc
ON MonHoc
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM PhanCongGiangDay pc JOIN deleted d ON pc.MaMon = d.MaMon)
    BEGIN
        RAISERROR(N'Không thể xóa môn học đã được phân công giảng dạy', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        DELETE FROM MonHoc WHERE MaMon IN (SELECT MaMon FROM deleted);
    END
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



/*=========================
		  5. VIEW
  =========================*/
  
  -- 1. View: Bảng điểm SV theo lớp học phần
CREATE OR ALTER VIEW Vw_SinhVien_Diem AS
SELECT sv.MaSV, sv.HoTen, sv.MaLop, svl.MaLopHocPhan,
       svl.DiemQuaTrinh, svl.DiemCuoiKy, svl.DiemTrungBinh, svl.TrangThai
FROM SinhVien sv
JOIN SinhVien_Lop svl ON sv.MaSV = svl.MaSV;
GO

-- 2. View: Lương giảng viên chi tiết
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




-- 3. Ngành Khoa (Dùng)
CREATE OR ALTER VIEW Vw_Nganh
AS
SELECT n.MaNganh, n.TenNganh, n.MaKhoa, k.TenKhoa
FROM Nganh n
JOIN Khoa k ON n.MaKhoa = k.MaKhoa;


SELECT TOP 10 * FROM Vw_SinhVien_Diem;
SELECT TOP 10 * FROM Vw_CanBo_Luong;

-- 4. Khoa
CREATE OR ALTER PROCEDURE NonP_GetAllKhoa
AS
BEGIN
    SELECT MaKhoa, TenKhoa FROM Khoa;
END;


-- 5. Phân công
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

-- 6.
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

--7.
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


-- 8. 
CREATE OR ALTER VIEW dbo.Vw_LopHP_CuaToi
AS
SELECT pc.MaLopHocPhan, lhp.TenLopHocPhan, pc.MaCB
FROM dbo.PhanCongGiangDay pc
JOIN dbo.LopHocPhan lhp ON pc.MaLopHocPhan=lhp.MaLopHocPhan
CROSS JOIN dbo.RTO_CurrentPrincipal() cp
WHERE pc.MaCB = cp.MaCB;
GO

-- 9.
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



-- 10.
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

-- 11. 
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