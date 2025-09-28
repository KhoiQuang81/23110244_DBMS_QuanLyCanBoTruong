/*=========================
	   1. PHÂN QUYỀN
  =========================*/
-- Tạo login (SQL Server Authentication demo)
-- Thực tế: mỗi user trong DB sẽ map vào 1 login
CREATE LOGIN AdminLogin WITH PASSWORD = '123';
CREATE LOGIN TruongKhoaLogin WITH PASSWORD = '123';
CREATE LOGIN GiangVienLogin WITH PASSWORD = '123';

-- Tạo user trong DB
CREATE USER AdminUser FOR LOGIN AdminLogin;
CREATE USER TruongKhoaUser FOR LOGIN TruongKhoaLogin;
CREATE USER GiangVienUser FOR LOGIN GiangVienLogin;

-- Tạo role
CREATE ROLE AdminRole;
CREATE ROLE TruongKhoaRole;
CREATE ROLE GiangVienRole;

-- Gán user vào role
EXEC sp_addrolemember 'AdminRole', 'AdminUser';
EXEC sp_addrolemember 'TruongKhoaRole', 'TruongKhoaUser';
EXEC sp_addrolemember 'GiangVienRole', 'GiangVienUser';

-- Phân quyền
-- Admin: toàn quyền
GRANT CONTROL ON DATABASE::QLCanBoGiangVien TO AdminRole;

-- Trưởng khoa: CRUD giảng viên, môn học, lớp, phân công
GRANT SELECT, INSERT, UPDATE, DELETE ON CanBo TO TruongKhoaRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON MonHoc TO TruongKhoaRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON LopHocPhan TO TruongKhoaRole;
GRANT SELECT, INSERT, UPDATE, DELETE ON PhanCongGiangDay TO TruongKhoaRole;

-- Giảng viên: chỉ SELECT, nhập điểm lớp mình
GRANT SELECT ON CanBo TO GiangVienRole;
GRANT SELECT ON MonHoc TO GiangVienRole;
GRANT SELECT ON LopHocPhan TO GiangVienRole;
GRANT SELECT, UPDATE ON SinhVien_Lop TO GiangVienRole;
GRANT SELECT ON BangLuong TO GiangVienRole;






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
-- CRUD: SinhVien
-------------------------------------------------------------
CREATE OR ALTER PROCEDURE HasP_InsertSinhVien
 @MaSV NVARCHAR(20),
 @HoTen NVARCHAR(150),
 @NgaySinh DATE,
 @GioiTinh CHAR(1),
 @MaKhoa NVARCHAR(20),
 @MaNganh NVARCHAR(20),
 @MaCT NVARCHAR(20),
 @MaLop NVARCHAR(20)
AS
BEGIN
 INSERT INTO SinhVien(MaSV, HoTen, NgaySinh, GioiTinh, MaKhoa, MaNganh, MaCT, MaLop)
 VALUES(@MaSV, @HoTen, @NgaySinh, @GioiTinh, @MaKhoa, @MaNganh, @MaCT, @MaLop);
END;
GO

CREATE OR ALTER PROCEDURE HasP_UpdateSinhVien
 @MaSV NVARCHAR(20),
 @HoTen NVARCHAR(150),
 @NgaySinh DATE,
 @GioiTinh CHAR(1),
 @MaKhoa NVARCHAR(20),
 @MaNganh NVARCHAR(20),
 @MaCT NVARCHAR(20),
 @MaLop NVARCHAR(20)
AS
BEGIN
 UPDATE SinhVien
 SET HoTen=@HoTen, NgaySinh=@NgaySinh, GioiTinh=@GioiTinh,
     MaKhoa=@MaKhoa, MaNganh=@MaNganh, MaCT=@MaCT, MaLop=@MaLop
 WHERE MaSV=@MaSV;
END;
GO

CREATE OR ALTER PROCEDURE HasP_DeleteSinhVien
 @MaSV NVARCHAR(20)
AS
BEGIN
 DELETE FROM SinhVien WHERE MaSV=@MaSV;
END;
GO

CREATE OR ALTER PROCEDURE NonP_GetAllSinhVien
AS
BEGIN
 SELECT * FROM SinhVien;
END;
GO

CREATE OR ALTER PROCEDURE HasP_GetSinhVienById
 @MaSV NVARCHAR(20)
AS
BEGIN
 SELECT * FROM SinhVien WHERE MaSV=@MaSV;
END;
GO


-- Insert
EXEC HasP_InsertSinhVien '23110353', N'Vũ Quốc Trung', '2005-01-09', 'M', '05', '7480201', 'CNTT01', '231101A';
-- Update
EXEC HasP_UpdateSinhVien '23110353', N'Vũ Quốc Trung', '2005-01-09', 'F', '05', '7480201', 'CNTT01', '231101A';
-- Select by Id
EXEC HasP_GetSinhVienById '23110353';
-- Select all
EXEC NonP_GetAllSinhVien;
-- Delete
EXEC HasP_DeleteSinhVien '23110353';


-------------------------------------------------------------
-- CRUD: CanBo
-------------------------------------------------------------
CREATE OR ALTER PROCEDURE HasP_InsertCanBo
 @MaCB NVARCHAR(20),
 @HoTen NVARCHAR(150),
 @NgaySinh DATE,
 @GioiTinh CHAR(1),
 @Email NVARCHAR(150),
 @Phone NVARCHAR(20),
 @MaKhoa NVARCHAR(20),
 @MaChucVu NVARCHAR(20),
 @MaTrinhDo NVARCHAR(5)
AS
BEGIN
 INSERT INTO CanBo(MaCB, HoTen, NgaySinh, GioiTinh, Email, Phone,
                   MaKhoa, MaChucVu, MaTrinhDo)
 VALUES(@MaCB, @HoTen, @NgaySinh, @GioiTinh, @Email, @Phone,
        @MaKhoa, @MaChucVu, @MaTrinhDo);
END;
GO

CREATE OR ALTER PROCEDURE HasP_UpdateCanBo
 @MaCB NVARCHAR(20),
 @HoTen NVARCHAR(150),
 @NgaySinh DATE,
 @GioiTinh CHAR(1),
 @Email NVARCHAR(150),
 @Phone NVARCHAR(20),
 @MaKhoa NVARCHAR(20),
 @MaChucVu NVARCHAR(20),
 @MaTrinhDo NVARCHAR(5)
AS
BEGIN
 UPDATE CanBo
 SET HoTen=@HoTen, NgaySinh=@NgaySinh, GioiTinh=@GioiTinh,
     Email=@Email, Phone=@Phone,
     MaKhoa=@MaKhoa, MaChucVu=@MaChucVu, MaTrinhDo=@MaTrinhDo
 WHERE MaCB=@MaCB;
END;
GO

CREATE OR ALTER PROCEDURE HasP_DeleteCanBo
 @MaCB NVARCHAR(20)
AS
BEGIN
 DELETE FROM CanBo WHERE MaCB=@MaCB;
END;
GO

CREATE OR ALTER PROCEDURE NonP_GetAllCanBo
AS
BEGIN
 SELECT * FROM CanBo;
END;
GO

CREATE OR ALTER PROCEDURE HasP_GetCanBoById
 @MaCB NVARCHAR(20)
AS
BEGIN
 SELECT * FROM CanBo WHERE MaCB=@MaCB;
END;
GO

CREATE OR ALTER PROCEDURE HasP_GetCanBoByName
    @HoTen NVARCHAR(150)
AS
BEGIN
    SELECT * 
    FROM CanBo
    WHERE HoTen LIKE '%' + @HoTen + '%';
END;
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
-- Thêm môn học vào ngành
CREATE OR ALTER PROCEDURE HasP_InsertMonHoc
    @MaMon NVARCHAR(20),
    @TenMon NVARCHAR(200),
    @SoTiet INT,
    @SoTinChi INT,
    @MaCT NVARCHAR(20),
    @BatBuoc BIT,
    @MaKhoaPhuTrach NVARCHAR(5)  -- thêm tham số mới
AS
BEGIN
    BEGIN TRY
        BEGIN TRAN;

        INSERT INTO MonHoc (MaMon, TenMon, SoTiet, SoTinChi, MaKhoaPhuTrach)
        VALUES (@MaMon, @TenMon, @SoTiet, @SoTinChi, @MaKhoaPhuTrach);

        INSERT INTO ChuongTrinh_MonHoc (MaCT, MaMon, BatBuoc)
        VALUES (@MaCT, @MaMon, @BatBuoc);

        COMMIT TRAN;
    END TRY
    BEGIN CATCH
        ROLLBACK TRAN;
        THROW;
    END CATCH
END;
GO

-- Sửa môn học
CREATE OR ALTER PROCEDURE HasP_UpdateMonHoc
    @MaMon NVARCHAR(20),
    @TenMon NVARCHAR(200),
    @SoTiet INT,
    @SoTinChi INT,
    @BatBuoc BIT,
    @MaKhoaPhuTrach NVARCHAR(5)
AS
BEGIN
    UPDATE MonHoc
    SET TenMon = @TenMon, 
        SoTiet = @SoTiet, 
        SoTinChi = @SoTinChi,
        MaKhoaPhuTrach = @MaKhoaPhuTrach
    WHERE MaMon = @MaMon;

    UPDATE ChuongTrinh_MonHoc
    SET BatBuoc = @BatBuoc
    WHERE MaMon = @MaMon;
END;
GO


-- Xóa môn học
CREATE OR ALTER PROCEDURE HasP_DeleteMonHoc
    @MaMon NVARCHAR(20)
AS
BEGIN
    DELETE FROM ChuongTrinh_MonHoc WHERE MaMon = @MaMon;
    DELETE FROM MonHoc WHERE MaMon = @MaMon;
END;
GO



EXEC HasP_InsertMonHoc 'DBMS', N'Hệ quản trị ', 75, 4, '05';
EXEC HasP_UpdateMonHoc 'DBMS', N'Hệ quản trị ', 60, 3, '05';
EXEC HasP_GetMonHocById 'DBMS';
EXEC HasP_DeleteMonHoc 'DBMS';


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
CREATE OR ALTER PROCEDURE HasP_InsertLopHocPhan
    @MaMon NVARCHAR(20),
    @SoThuTu INT,
    @MaKhoa NVARCHAR(20),
    @MaNganh NVARCHAR(20),
    @MaCT NVARCHAR(20),
    @SoLuongSV INT
AS
BEGIN
    DECLARE @MaLopHocPhan NVARCHAR(30);
    SET @MaLopHocPhan = @MaMon + '_' + RIGHT('00' + CAST(@SoThuTu AS NVARCHAR(2)), 2);

    INSERT INTO LopHocPhan(MaLopHocPhan, MaMon, TenLopHocPhan, MaKhoa, MaNganh, MaCT, SoLuongSV)
    SELECT @MaLopHocPhan, @MaMon, TenMon, @MaKhoa, @MaNganh, @MaCT, @SoLuongSV
    FROM MonHoc
    WHERE MaMon = @MaMon;
END;



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

-- Thêm lớp học phần
CREATE OR ALTER PROCEDURE HasP_InsertLopHocPhan
    @MaLopHocPhan NVARCHAR(20),
    @TenLopHocPhan NVARCHAR(200),
    @MaKhoa NVARCHAR(20),
    @MaNganh NVARCHAR(20),
    @MaCT NVARCHAR(20)
AS
BEGIN
    INSERT INTO LopHocPhan(MaLopHocPhan, TenLopHocPhan, MaKhoa, MaNganh, MaCT, SoLuongSV)
    VALUES(@MaLopHocPhan, @TenLopHocPhan, @MaKhoa, @MaNganh, @MaCT, 0);
END;
GO

-- Sửa lớp học phần
CREATE OR ALTER PROCEDURE HasP_UpdateLopHocPhan
    @MaLopHocPhan NVARCHAR(20),
    @TenLopHocPhan NVARCHAR(200),
    @MaKhoa NVARCHAR(20),
    @MaNganh NVARCHAR(20),
    @MaCT NVARCHAR(20)
AS
BEGIN
    UPDATE LopHocPhan
    SET TenLopHocPhan = @TenLopHocPhan,
        MaKhoa = @MaKhoa,
        MaNganh = @MaNganh,
        MaCT = @MaCT
    WHERE MaLopHocPhan = @MaLopHocPhan;
END;
GO

-- Xóa lớp học phần
CREATE OR ALTER PROCEDURE HasP_DeleteLopHocPhan
    @MaLopHocPhan NVARCHAR(20)
AS
BEGIN
    DELETE FROM LopHocPhan WHERE MaLopHocPhan = @MaLopHocPhan;
END;
GO


-------------------------------------------------------------
-- CRUD: Phân công
-------------------------------------------------------------
-- Giảng viên theo khoa
CREATE OR ALTER PROCEDURE HasP_GetGiangVienByKhoa
    @MaKhoa NVARCHAR(20)
AS
BEGIN
    SELECT MaCB, HoTen
    FROM CanBo
    WHERE MaKhoa = @MaKhoa
    ORDER BY HoTen;
END;
GO

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
CREATE OR ALTER PROCEDURE HasP_InsertPhanCong
    @MaCB NVARCHAR(20),
    @MaMon NVARCHAR(20),
    @MaLopHocPhan NVARCHAR(20),
    @SoTiet INT,
    @SoTuan INT,
    @HocKy INT,
    @NamHoc NVARCHAR(9),
    @MaNganh NVARCHAR(20)   -- thêm ngành
AS
BEGIN
    IF EXISTS (SELECT 1 FROM PhanCongGiangDay
               WHERE MaLopHocPhan=@MaLopHocPhan
                 AND HocKy=@HocKy AND NamHoc=@NamHoc)
    BEGIN
        RAISERROR(N'Lớp học phần đã được phân công kỳ/năm này',16,1); RETURN;
    END;

    DECLARE @TenMon NVARCHAR(200) = (SELECT TenMon FROM MonHoc WHERE MaMon=@MaMon);

    INSERT INTO PhanCongGiangDay(MaCB, MaMon, TenMon, MaLopHocPhan, SoTiet, SoTuan, HocKy, NamHoc, MaNganh)
    VALUES(@MaCB, @MaMon, @TenMon, @MaLopHocPhan, @SoTiet, @SoTuan, @HocKy, @NamHoc, @MaNganh);
END;
GO

-- Update phân công
CREATE OR ALTER PROCEDURE HasP_UpdatePhanCong
    @Old_MaCB NVARCHAR(20),
    @Old_MaMon NVARCHAR(20),
    @Old_MaLopHocPhan NVARCHAR(20),
    @Old_HocKy INT,
    @Old_NamHoc NVARCHAR(9),

    @New_MaMon NVARCHAR(20),
    @New_MaLopHocPhan NVARCHAR(20),
    @New_SoTiet INT,
    @New_SoTuan INT,
    @New_HocKy INT,
    @New_NamHoc NVARCHAR(9),
    @New_MaNganh NVARCHAR(20)   -- thêm ngành
AS
BEGIN
    IF EXISTS (SELECT 1 FROM PhanCongGiangDay
               WHERE MaLopHocPhan=@New_MaLopHocPhan
                 AND HocKy=@New_HocKy AND NamHoc=@New_NamHoc
                 AND NOT (MaCB=@Old_MaCB AND MaMon=@Old_MaMon 
                          AND MaLopHocPhan=@Old_MaLopHocPhan 
                          AND HocKy=@Old_HocKy AND NamHoc=@Old_NamHoc))
    BEGIN
        RAISERROR(N'Lớp học phần đã được phân công kỳ/năm này',16,1); RETURN;
    END;

    UPDATE PhanCongGiangDay
    SET MaMon=@New_MaMon,
        TenMon=(SELECT TenMon FROM MonHoc WHERE MaMon=@New_MaMon),
        MaLopHocPhan=@New_MaLopHocPhan,
        SoTiet=@New_SoTiet,
        SoTuan=@New_SoTuan,
        HocKy=@New_HocKy,
        NamHoc=@New_NamHoc,
        MaNganh=@New_MaNganh
    WHERE MaCB=@Old_MaCB AND MaMon=@Old_MaMon AND MaLopHocPhan=@Old_MaLopHocPhan
          AND HocKy=@Old_HocKy AND NamHoc=@Old_NamHoc;
END;
GO


-- Xóa phân công
CREATE OR ALTER PROCEDURE HasP_DeletePhanCong
    @MaCB NVARCHAR(20),
    @MaMon NVARCHAR(20),
    @MaLopHocPhan NVARCHAR(20),
    @HocKy INT,
    @NamHoc NVARCHAR(9)
AS
BEGIN
    DELETE FROM PhanCongGiangDay
    WHERE MaCB=@MaCB AND MaMon=@MaMon AND MaLopHocPhan=@MaLopHocPhan
          AND HocKy=@HocKy AND NamHoc=@NamHoc;
END;
GO

-- Danh sách phân công theo khoa
CREATE OR ALTER PROCEDURE HasP_GetPhanCongByKhoa
    @MaKhoa NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        pc.MaCB,
        pc.MaMon,          -- thêm cột này để form dùng
        pc.TenMon,
        pc.MaLopHocPhan,
        pc.SoTiet,
        pc.SoTuan,
        pc.HocKy,
        pc.NamHoc
    FROM PhanCongGiangDay pc
    JOIN CanBo cb ON pc.MaCB = cb.MaCB
    WHERE cb.MaKhoa = @MaKhoa
    ORDER BY pc.NamHoc DESC, pc.HocKy, pc.TenMon;
END;

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



  -- 5. Trigger Tính lương
CREATE TRIGGER TRG_TinhTongLuong
ON BangLuong
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE BL
    SET 
		TongLuong = (BL.LuongCoBan * ISNULL(H.GiaTri, 1)) + ISNULL(BL.TongPhuCap, 0) - ISNULL(BL.KhauTru, 0)
    FROM BangLuong BL
    INNER JOIN inserted I
        ON BL.BangLuongId = I.BangLuongId
    LEFT JOIN HeSoLuong H
        ON BL.HeSoId = H.HeSoId;
END;
GO






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
CREATE OR ALTER VIEW Vw_CanBo_Luong AS
SELECT cb.MaCB, cb.HoTen, bl.ThangNam, bl.LuongCoBan,
       h.GiaTri AS HeSo, bl.TongPhuCap, bl.KhauTru, bl.TongLuong
FROM BangLuong bl
JOIN CanBo cb ON bl.MaCB = cb.MaCB
LEFT JOIN HeSoLuong h ON bl.HeSoId = h.HeSoId;
GO

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
CREATE OR ALTER VIEW Vw_PhanCong_ChiTiet AS
SELECT  pc.MaCB, cb.HoTen AS TenCB,
        pc.MaMon, mh.TenMon,
        pc.MaLopHocPhan, lhp.TenLopHocPhan,
        pc.SoTiet, pc.SoTuan, pc.HocKy, pc.NamHoc
FROM PhanCongGiangDay pc
JOIN CanBo cb           ON pc.MaCB = cb.MaCB
JOIN MonHoc mh          ON pc.MaMon = mh.MaMon
JOIN LopHocPhan lhp     ON pc.MaLopHocPhan = lhp.MaLopHocPhan;
GO



/*=========================
	   6. TRANSACTION
  =========================*/