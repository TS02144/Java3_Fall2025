-- 1. Bảng Categories (Loại tin)
CREATE TABLE Categories (
    Id VARCHAR(50) PRIMARY KEY,        -- Mã loại tin (ví dụ: CAT001)
    Name NVARCHAR(200) NOT NULL,       -- Tên loại tin
    CreatedDate DATETIME DEFAULT GETDATE(),
    UpdatedDate DATETIME DEFAULT GETDATE()
);

-- 2. Bảng Users (Người dùng)
CREATE TABLE Users (
    Id VARCHAR(50) PRIMARY KEY,               -- Mã đăng nhập (hoặc có thể dùng UUID)
    Password VARCHAR(255) NOT NULL,            -- Mật khẩu đã được hash
    Fullname NVARCHAR(200) NOT NULL,           
    Birthday DATE NULL,
    Gender BIT NULL,                           -- 1 = Nam, 0 = Nữ (hoặc NULL nếu không muốn tiết lộ)
    Mobile VARCHAR(20) NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Role BIT NOT NULL DEFAULT 0,               -- 0 = phóng viên, 1 = quản trị viên
    CreatedDate DATETIME DEFAULT GETDATE(),
    UpdatedDate DATETIME DEFAULT GETDATE()
);

-- 3. Bảng News (Bản tin / Bài viết)
CREATE TABLE News (
    Id VARCHAR(50) PRIMARY KEY,                -- Mã bản tin (NEWS001, NEWS002...)
    Title NVARCHAR(500) NOT NULL,             
    Content NTEXT NOT NULL,                    -- Nội dung bài viết
    Image VARCHAR(500) NULL,                   -- Đường dẫn hình ảnh/video đại diện
    PostedDate DATETIME NOT NULL DEFAULT GETDATE(),
    Author VARCHAR(50) NOT NULL,               -- Tác giả (mã phóng viên)
    ViewCount INT DEFAULT 0,
    CategoryId VARCHAR(50) NOT NULL,           
    Home BIT NOT NULL DEFAULT 0,               -- true = hiển thị trang chủ
    
    -- Khóa ngoại
    CONSTRAINT FK_News_Author FOREIGN KEY (Author) 
        REFERENCES Users(Id) ON DELETE NO ACTION,
    CONSTRAINT FK_News_Category FOREIGN KEY (CategoryId) 
        REFERENCES Categories(Id) ON DELETE NO ACTION
);

-- Index để tìm kiếm nhanh
CREATE INDEX IX_News_PostedDate ON News(PostedDate DESC);
CREATE INDEX IX_News_CategoryId ON News(CategoryId);
CREATE INDEX IX_News_Home ON News(Home);

-- 4. Bảng Newsletters (Đăng ký nhận tin)
CREATE TABLE Newsletters (
    Email VARCHAR(255) PRIMARY KEY,            -- Email người đăng ký
    Enabled BIT NOT NULL DEFAULT 1,            -- true = còn hiệu lực
    SubscribedDate DATETIME DEFAULT GETDATE()
);

-- Tạo một số dữ liệu mẫu (tuỳ chọn)
INSERT INTO Categories (Id, Name) VALUES 
('CAT001', N'Tin tức trong nước'),
('CAT002', N'Tin tức quốc tế'),
('CAT003', N'Thể thao'),
('CAT004', N'Giải trí');

INSERT INTO Users (Id, Password, Fullname, Email, Role) VALUES
('ADMIN001', 'hashed_password_here', N'Quản trị viên', 'admin@website.com', 1),
('PV001', 'hashed_password_here', N'Nguyễn Văn A', 'pv1@website.com', 0),
('PV002', 'hashed_password_here', N'Trần Thị B', 'pv2@website.com', 0);