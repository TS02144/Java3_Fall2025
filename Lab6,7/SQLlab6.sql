CREATE DATABASE HRM;
GO
USE HRM;
GO

[cite_start]-- Bài 1: Tạo bảng [cite: 11-31]
CREATE TABLE Departments (
    Id CHAR(3) NOT NULL PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    Description NVARCHAR(255) NULL
);

CREATE TABLE Employees (
    Id VARCHAR(20) NOT NULL PRIMARY KEY,
    Password NVARCHAR(50) NOT NULL,
    Fullname NVARCHAR(50) NOT NULL,
    Photo NVARCHAR(50) NOT NULL,
    Gender BIT NOT NULL,
    Birthday DATE NOT NULL,
    Salary FLOAT NOT NULL,
    DepartmentId CHAR(3) NOT NULL,
    FOREIGN KEY (DepartmentId) REFERENCES Departments(Id) 
    ON DELETE CASCADE ON UPDATE CASCADE
);

-- Dữ liệu mẫu để test
INSERT INTO Departments VALUES ('IT', N'Công nghệ thông tin', N'Phòng kỹ thuật');
INSERT INTO Departments VALUES ('HR', N'Nhân sự', N'Quản lý nhân viên');
GO

[cite_start]-- Bài 4: Tạo Stored Procedures [cite: 176-211]
-- Insert
CREATE PROCEDURE spInsert(
    @Id VARCHAR(20), @Name NVARCHAR(50), @Description NVARCHAR(100)
) AS BEGIN
    INSERT INTO Departments (Id, Name, Description) VALUES(@Id, @Name, @Description)
END;
GO
-- Update
CREATE PROCEDURE spUpdate(
    @Id VARCHAR(20), @Name NVARCHAR(50), @Description NVARCHAR(100)
) AS BEGIN
    UPDATE Departments SET Name=@Name, Description=@Description WHERE Id=@Id
END;
GO
-- Delete
CREATE PROCEDURE spDeleteById(@Id VARCHAR(20)) AS BEGIN
    DELETE FROM Departments WHERE Id=@Id
END;
GO
-- Select All
CREATE PROCEDURE spSelectAll AS BEGIN
    SELECT * FROM Departments
END;
GO
-- Select By ID
CREATE PROCEDURE spSelectById(@Id VARCHAR(20)) AS BEGIN
    SELECT * FROM Departments WHERE Id=@Id
END;
GO