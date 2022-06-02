
--Tao bang
GO
CREATE TABLE San_Pham (
	Ma_SP INT IDENTITY(1,1) PRIMARY KEY,
	Ten_SP varchar(50),
	Don_Gia MONEY,
	Ma_KH varchar(10),
	FOREIGN KEY (Ma_KH) REFERENCES Khach_Hang(Ma_KH)
);
GO
CREATE TABLE Khach_Hang (
	Ma_KH varchar(10) PRIMARY KEY,
	Ten_KH varchar(50),
	Phone_No varchar(11),
	Ghi_Chu text
);
GO
CREATE TABLE Don_Hang (
	Ma_DH INT IDENTITY(1,1) PRIMARY KEY,
	Ngay_DH date,
	Ma_SP INT,
	So_Luong INT
	FOREIGN KEY (Ma_SP) REFERENCES San_Pham(Ma_SP)
);
--Them du lieu vao cac bang
GO
INSERT INTO Khach_Hang
VALUES ('MaKH1', 'KH1', '012345689', 'ghi chu 1'), 
	('MaKH2', 'KH2', '012345679', 'ghi chu 2'), 
	('MaKH3', 'KH3', '012515355', 'ghi chu 3')
GO
INSERT INTO San_Pham (Ten_SP, Don_Gia, Ma_KH)
VALUES ('San Pham 1', 30000, 'MaKH1'),
	('San Pham 2', 40000, 'MaKH2'),
	('San Pham 3', 60000, 'MaKH3')
GO
INSERT INTO Don_Hang (Ngay_DH, Ma_SP, So_Luong)
VALUES ('2022-04-05', 1, 15),
	('2022-03-15', 2, 20),
	('2022-06-25', 3, 6)
	
--Tao view
GO
CREATE VIEW ThongTinDonHang AS (

	SELECT kh.Ten_KH, dh.Ngay_DH, sp.Ten_SP, dh.So_Luong, sp.Don_Gia * dh.So_Luong as Thanh_Tien
	FROM dbo.Don_Hang dh 
	INNER JOIN dbo.San_Pham sp ON dh.Ma_SP = sp.Ma_SP
	INNER JOIN dbo.Khach_Hang kh ON sp.Ma_KH = kh.Ma_KH

)