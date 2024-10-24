CREATE DATABASE Kitapvekitap
USE Kitapvekitap

CREATE TABLE Musteriler (
    musteri_id INT PRIMARY KEY IDENTITY(1,1),
    musteri_isim NVARCHAR(100),
	musteri_soyisim NVARCHAR(100),
    email NVARCHAR(100),
    sehir NVARCHAR(100)
);

CREATE TABLE Kitaplar (
    kitap_id INT PRIMARY KEY IDENTITY(1,1),
    kitap_isim NVARCHAR(100),
    yazar_isim NVARCHAR(100),
	kategori NVARCHAR(50),
    ucret DECIMAL(10, 2),
    basim_yili INT,
	stok INT
);


CREATE TABLE Siparisler (
    siparis_id INT PRIMARY KEY IDENTITY(1,1),
    musteri_id INT,
    kitap_id INT,
    siparis_tarihi DATE,
    miktar INT,
    FOREIGN KEY (musteri_id) REFERENCES Musteriler(musteri_id),
    FOREIGN KEY (kitap_id) REFERENCES Kitaplar(kitap_id)
);

DECLARE @i int =1;
DECLARE @musteri_isim NVARCHAR(100);
DECLARE @musteri_soyisim NVARCHAR(100);
DECLARE @email NVARCHAR(100);
DECLARE @sehir NVARCHAR(100);

declare @isimler table (musteri_isim NVARCHAR (100));
INSERT INTO @isimler VALUES

('Ali'),('Veli'),('Ahmet'),('Mehmet'),('Mustafa'),('Hasan'),('Hüseyin'),('Necati'),
('Pelin'),('Selin'),('Leyla'),('Fatma'),('Ayþe'),('Nur'),('Þenay'),('Nisa'),('Elif')

DECLARE @soyadlar TABLE (musteri_soyisim NVARCHAR (100));
INSERT INTO @soyadlar VALUES

('Yýlmaz'),('Demir'),('Kaya'),('Demirci'),('Yýldýz'),('Aydýn'),('Aydýnoðlu'),('Korkmaz'),('Özdemir'),
('Koç'),('Doðan'),('Sabancý'),('Sabuncu'),('Zeki'),('Yurtsever')

DECLARE @Sehirler table(sehir NVARCHAR (100));
INSERT INTO @Sehirler VALUES
('Ýzmir'),('Aydýn'),('Manisa'),('Ýstanbul'),('Ankara'),('Muðla'),('Balýkesir'),('Denizli'),('Uþak'),
('Çanakkale'),('Bursa')

WHILE @i <= 100000
BEGIN
    SELECT TOP 1 @musteri_isim = musteri_isim FROM @isimler ORDER BY NEWID();
    
	SELECT TOP 1 @musteri_soyisim = musteri_soyisim FROM @soyadlar ORDER BY NEWID();
    
	SET @email = LOWER(@musteri_isim) + '.' + LOWER(@musteri_soyisim) + CAST(@i AS NVARCHAR(10)) + '@kitapvekitap.com';
    
	SELECT TOP 1 @sehir = sehir FROM @Sehirler ORDER BY NEWID();
    
	INSERT INTO Musteriler (musteri_isim, musteri_soyisim, email, sehir)
    
	VALUES (@musteri_isim, @musteri_soyisim, @email, @sehir);
    
	SET @i = @i + 1;
END

DECLARE @j INT = 1;
DECLARE @kitap_isim NVARCHAR(100);
DECLARE @yazar_isim NVARCHAR(100);
DECLARE @kategori NVARCHAR(50);
DECLARE @ucret DECIMAL(10, 2);
DECLARE @basim_yili INT;
DECLARE @stok INT;


DECLARE @kitap_isimleri TABLE (kitap_isim NVARCHAR(100));
INSERT INTO @kitap_isimleri VALUES
('Güneþin Doðuþu'), ('Kayýp Þehir'), ('Sessiz Tanýk'), ('Denizin Kalbi'), ('Zaman Yolcusu'),
('Yalnýz Adam'), ('Mavi Gözyaþý'), ('Kýrýk Hayaller'), ('Yolun Sonu'), ('Sonsuz Gece'),
('Gölge Oyunu'), ('Karanlýðýn Çaðrýsý'), ('Beyaz Zambaklar'), ('Küçük Prens'), ('Gizli Bahçe');


DECLARE @yazar_isimleri TABLE (yazar_isim NVARCHAR(100));
INSERT INTO @yazar_isimleri VALUES
('Orhan Pamuk'), ('Elif Þafak'), ('Ahmet Ümit'), ('Sabahattin Ali'), ('Yaþar Kemal'),
('Halikarnas Balýkçýsý'), ('Ýskender Pala'), ('Reþat Nuri Güntekin'), ('Zülfü Livaneli'), ('Nazým Hikmet'),
('Murathan Mungan'), ('Atilla Ýlhan'), ('Necip Fazýl Kýsakürek'), ('Peyami Safa'), ('Cemal Süreya');


DECLARE @kategoriler TABLE (kategori NVARCHAR(50));
INSERT INTO @kategoriler VALUES
('Roman'), ('Bilim'), ('Tarih'), ('Macera'), ('Fantastik'), ('Psikoloji'), ('Klasik'), ('Polisiye');


WHILE @j <= 10000
BEGIN
    SELECT TOP 1 @kitap_isim = kitap_isim FROM @kitap_isimleri ORDER BY NEWID();
    SELECT TOP 1 @yazar_isim = yazar_isim FROM @yazar_isimleri ORDER BY NEWID();
    SELECT TOP 1 @kategori = kategori FROM @kategoriler ORDER BY NEWID();
	SET @ucret = ROUND(RAND() * (500 - 50) + 50, 2);
	SET @basim_yili = FLOOR(RAND() * (2023 - 1990 + 1)) + 1990;
	SET @stok = FLOOR(RAND() * (100 - 1 + 1)) + 1;
    INSERT INTO Kitaplar (kitap_isim, yazar_isim, kategori, ucret, basim_yili, stok)
    VALUES (@kitap_isim, @yazar_isim, @kategori, @ucret, @basim_yili, @stok);
    SET @j = @j + 1;
END


DECLARE @k INT = 1;
DECLARE @musteri_id INT;
DECLARE @kitap_id INT;
DECLARE @siparis_tarihi DATE;
DECLARE @miktar INT;

DECLARE @StartDate DATE = '2020-01-01';
DECLARE @EndDate DATE = '2024-06-01';

DECLARE @TotalDays INT = DATEDIFF(DAY, @StartDate, @EndDate);

WHILE @k <= 100000
BEGIN
    
    SET @musteri_id = FLOOR(RAND() * 100000) + 1;

    SET @kitap_id = FLOOR(RAND() * 1000) + 1;

    SET @siparis_tarihi = DATEADD(DAY, FLOOR(RAND() * @TotalDays), @StartDate);

    SET @miktar = FLOOR(RAND() * 10) + 1;

    INSERT INTO Siparisler (musteri_id, kitap_id, siparis_tarihi, miktar)
    VALUES (@musteri_id, @kitap_id, @siparis_tarihi, @miktar);

    SET @k = @k + 1;
END


CREATE INDEX idx_musteri_id ON Siparisler(musteri_id);
CREATE INDEX idx_kitap_id ON Siparisler(kitap_id);

CREATE VIEW MusteriSiparisMiktari AS
SELECT 
    m.musteri_id,
    m.musteri_isim,
    m.musteri_soyisim,
    COUNT(s.siparis_id) AS toplam_siparis_miktari
FROM 
    Musteriler m
LEFT JOIN 
    Siparisler s ON m.musteri_id = s.musteri_id
GROUP BY 
    m.musteri_id, m.musteri_isim, m.musteri_soyisim;

	
CREATE PROCEDURE GetSiparislerByTarih
    @BaslangicTarihi DATE,
    @BitisTarihi DATE
AS
BEGIN
    SELECT *
    FROM Siparisler
    WHERE siparis_tarihi BETWEEN @BaslangicTarihi AND @BitisTarihi;
END

