USE DENE
GO

-- 1. Customer Tablosu
-- Sütunlar: Name, Address, PhoneNumber, Email, CustomerType
INSERT INTO Customer (Name, Address, PhoneNumber, Email, CustomerType) VALUES 
('Ali Yılmaz', 'İstanbul', '05001112233', 'ali.yilmaz@example.com', 'Bireysel'),
('Ayşe Demir', 'Ankara', '05003334455', 'ayse.demir@example.com', 'Kurumsal'),
('Mehmet Kaya', 'İzmir', '05001234567', 'mehmet.kaya@example.com', 'Bireysel'),
('Elif Koç', 'Bursa', '05007894561', 'elif.koc@example.com', 'Bireysel'),
('Canan Aydın', 'Bingöl', '05009283746', 'canan.aydin@example.com', 'Kurumsal'),
('Burak Şahin', 'Konya', '05008887766', 'burak.sahin@example.com', 'Bireysel'),
('Zeynep Arslan', 'Eskişehir', '05009990012', 'zeynep.arslan@example.com', 'Kurumsal'),
('Fatma Çelik', 'Kayseri', '05006665544', 'fatma.celik@example.com', 'Bireysel'),
('Ahmet Öz', 'Gaziantep', '05007774422', 'ahmet.oz@example.com', 'Kurumsal'),
('Selin Er', 'Mersin', '05004561239', 'selin.er@example.com', 'Bireysel'),
('Hülya Kaplan', 'Tekirdağ', '05009384756', 'hulya.kaplan@example.com', 'Kurumsal'),
('Orhan Bulut', 'Muğla', '05002568974', 'orhan.bulut@example.com', 'Bireysel'),
('Deniz Taş', 'Trabzon', '05003847562', 'deniz.tas@example.com', 'Kurumsal'),
('Gamze Kar', 'Balıkesir', '05007452319', 'gamze.kar@example.com', 'Bireysel'),
('Murat Uzun', 'Adana', '05006123478', 'murat.uzun@example.com', 'Kurumsal'),
('Aslı Tunç', 'Edirne', '05003457812', 'asli.tunc@example.com', 'Bireysel'),
('Kerem Gök', 'Rize', '05009234581', 'kerem.gok@example.com', 'Kurumsal'),
('Nazlı Kır', 'Aydın', '05004321234', 'nazli.kir@example.com', 'Kurumsal'),
('Uğur Ateş', 'Van', '05006549871', 'ugur.ates@example.com', 'Bireysel'),
('Sevgi Baran', 'Malatya', '05007891234', 'sevgi.baran@example.com', 'Kurumsal'),
('Tolga Cenk', 'Kütahya', '05005678123', 'tolga.cenk@example.com', 'Bireysel'),
('Melis Gür', 'Sakarya', '05009998877', 'melis.gur@example.com', 'Bireysel'),
('Okan Sert', 'Denizli', '05003458912', 'okan.sert@example.com', 'Kurumsal'),
('Yasemin Kaan', 'Hatay', '05009341256', 'yasemin.kaan@example.com', 'Bireysel'),
('Efe Demirtaş', 'Samsun', '05008461239', 'efe.demirtas@example.com', 'Kurumsal');
GO

-- 2. Employee Tablosu
-- Sütunlar: Name, Surname, Salary, PhoneNumber, Email, Position, Address, HiredDate, SupervisorID
-- Orijinal verinizde Name ve Surname ayrımı yapılmadığı için, ilk kelimeyi Name, geri kalanını Surname olarak kabul ettim.
INSERT INTO Employee (Name, Surname, Salary, PhoneNumber, Email, Position, Address, HiredDate, SupervisorID) VALUES 
('Osman', 'Yılmaz', 9500, '05001112233', 'osman.yilmaz@company.com', 'Manager', 'İstanbul', '2015-01-10', NULL),
('Banu', 'Aksoy', 7200, '05003334455', 'banu.aksoy@company.com', 'Engineer', 'Ankara', '2017-03-12', 1),
('Ozan', 'Demir', 6800, '05001234567', 'ozan.demir@company.com', 'Technician', 'İzmir', '2018-07-22', 1),
('Cemil', 'Can', 7000, '05007894561', 'cemil.can@company.com', 'Analyst', 'Bursa', '2019-02-14', 1),
('Tuğçe', 'Aydın', 6000, '05008887766', 'tugce.aydin@company.com', 'Support', 'Konya', '2020-05-10', 2),
('Sinan', 'Turan', 7300, '05009990012', 'sinan.turan@company.com', 'Engineer', 'Eskişehir', '2016-04-18', 2),
('Gökhan', 'Yücel', 6700, '05006665544', 'gokhan.yucel@company.com', 'Designer', 'Kayseri', '2018-01-25', 3),
('Emre', 'Taşkın', 7200, '05007774422', 'emre.taskin@company.com', 'Technician', 'Gaziantep', '2019-11-11', 3),
('Pelin', 'Kılıç', 6900, '05004561239', 'pelin.kilic@company.com', 'HR Specialist', 'Mersin', '2021-03-07', 4),
('Hande', 'Güneş', 7600, '05009384756', 'hande.gunes@company.com', 'Supervisor', 'Tekirdağ', '2014-12-02', NULL),
('Yiğit', 'Bulut', 5800, '05002568974', 'yigit.bulut@company.com', 'Support', 'Muğla', '2022-04-04', 10),
('Serkan', 'Çetin', 6300, '05003847562', 'serkan.cetin@company.com', 'Sales', 'Trabzon', '2018-08-16', 10),
('Mert', 'Kaptan', 6400, '05007452319', 'mert.kaptan@company.com', 'HR', 'Balıkesir', '2017-10-01', 6),
('Furkan', 'Toprak', 7000, '05006123478', 'furkan.toprak@company.com', 'Marketing', 'Adana', '2015-06-05', 6),
('Gizem', 'Altan', 6100, '05003457812', 'gizem.altan@company.com', 'Admin Assistant', 'Edirne', '2020-09-21', 7),
('Hasan', 'Şen', 7500, '05009234581', 'hasan.sen@company.com', 'Engineer', 'Rize', '2013-05-12', 10),
('Dilek', 'Soylu', 6800, '05004321234', 'dilek.soylu@company.com', 'Coordinator', 'Aydın', '2019-01-29', 11),
('Caner', 'Bozkurt', 5400, '05006549871', 'caner.bozkurt@company.com', 'Technician', 'Van', '2021-07-15', 12),
('Irmak', 'Yücel', 7700, '05007891234', 'irmak.yucel@company.com', 'Supervisor', 'Malatya', '2014-03-03', NULL),
('Barış', 'Öztürk', 6900, '05005678123', 'baris.ozturk@company.com', 'Logistics', 'Kütahya', '2017-11-02', 15),
('Deniz', 'Akın', 6500, '05009998877', 'deniz.akin@company.com', 'Designer', 'Sakarya', '2021-02-18', 16),
('Eren', 'Özdemir', 7200, '05003458912', 'eren.ozdemir@company.com', 'Technician', 'Denizli', '2016-04-30', 16),
('Mine', 'Çevik', 6700, '05009341256', 'mine.cevik@company.com', 'Sales', 'Hatay', '2018-12-12', 18),
('Alp', 'Vural', 7000, '05008461239', 'alp.vural@company.com', 'Engineer', 'Samsun', '2019-09-09', 18),
('Arda', 'Menteş', 6600, '05007654321', 'arda.mentes@company.com', 'Technician', 'Bolu', '2022-01-10', 19);
GO


-- 3. Supplier Tablosu
-- Sütunlar: SupplierName, Address, Email, PhoneNumber, ContactPerson, Country, Rating, PartnerShip, ReceivedProduct
INSERT INTO Supplier (SupplierName, Address, Email, PhoneNumber, ContactPerson, Country, Rating, PartnerShip, ReceivedProduct) VALUES 
('Akçelik Tedarik', 'İstanbul', 'info@akcelik.com', '02125551212', 'Murat Aydın', 'Türkiye', 5, '2015-01-10', 'Metal Parça'),
('MegaTech Components', 'Ankara', 'support@megatech.com', '03124567890', 'Elif Aksoy', 'Türkiye', 4, '2016-03-12', 'Elektronik Kart'),
('Efe Makina', 'İzmir', 'iletisim@efemakina.com', '02324561234', 'Efe Kumru', 'Türkiye', 5, '2014-07-22', 'Motor Aksamı'),
('Kuzey Parça', 'Bursa', 'info@kuzeyparca.com', '02245781234', 'Zeynep Çelik', 'Türkiye', 3, '2018-02-14', 'Vida & Civata'),
('Doğu Endüstri', 'Gaziantep', 'destek@doguendustri.com', '03424569870', 'Hakan Öztürk', 'Türkiye', 4, '2017-05-10', 'Kauçuk Parça'),
('Global Parts Co', 'Berlin', 'contact@globalparts.de', '004930112233', 'Anna Müller', 'Almanya', 5, '2013-11-11', 'Hassas Bileşen'),
('TechLine GmbH', 'Frankfurt', 'info@techline.de', '004969445566', 'Lukas Schneider', 'Almanya', 4, '2018-08-01', 'Kontrol Paneli'),
('EastAsia Supply', 'Seul', 'support@eastasiasupply.kr', '008223154400', 'Kim Jisoo', 'Kore', 5, '2019-04-18', 'Elektrik Kablosu'),
('KabloMaster', 'Konya', 'iletisim@kablosan.com', '03324447766', 'Serkan Kar', 'Türkiye', 3, '2016-09-21', 'Kablo Takımı'),
('BolTech', 'Kayseri', 'info@boltech.com', '03526789900', 'Fatih Bora', 'Türkiye', 4, '2014-06-05', 'Plastik Kapak'),
('Nordic Steel AB', 'Stockholm', 'support@nordicsteel.se', '004670998877', 'Erik Larsson', 'İsveç', 5, '2015-12-02', 'Boru Seti'),
('EuroMach Ltd', 'Londra', 'contact@euromach.co.uk', '004420778899', 'James Smith', 'İngiltere', 4, '2017-03-07', 'Servo Motor'),
('SinoTech Industrial', 'Şanghay', 'info@sinotech.cn', '008621334455', 'Li Wei', 'Çin', 5, '2012-05-12', 'Soğutma Ünitesi'),
('Mediterranean Parts', 'İzmir', 'iletisim@medparts.com', '02324321234', 'Seda Karaca', 'Türkiye', 4, '2018-01-29', 'Montaj Parçası'),
('Anadolu Elektrik', 'Adana', 'destek@anadoluelektrik.com', '03224561200', 'Levent Sönmez', 'Türkiye', 3, '2020-07-15', 'Kablo Demeti'),
('Hitech Nordic', 'Oslo', 'info@hitechnordic.no', '004722665544', 'Ola Hansen', 'Norveç', 5, '2013-10-01', 'Hidrolik Pompa'),
('MegaSteel', 'Kocaeli', 'info@megasteel.com', '02624567890', 'Ayhan Erel', 'Türkiye', 4, '2015-01-25', 'Çelik Parça'),
('PowerDrive', 'İstanbul', 'support@powerdrive.com', '02125559877', 'Gökhan Uçar', 'Türkiye', 5, '2016-11-02', 'Motor Sürücü'),
('Oceanic Plastics', 'İzmir', 'destek@oceanplast.com', '02324412345', 'Deniz Ok', 'Türkiye', 3, '2018-04-18', 'Polimer Parça'),
('Future Components', 'Tokyo', 'info@futurecomp.jp', '008133556677', 'Sato Hiroshi', 'Japonya', 5, '2014-03-03', 'Robotik Parça'),
('MetalTech', 'Bursa', 'info@metaltech.com', '02246789912', 'Yasin Ar', 'Türkiye', 4, '2017-11-11', 'Metal Gövde'),
('FiberLux', 'İstanbul', 'contact@fiberlux.com', '02126663344', 'Burcu Karel', 'Türkiye', 3, '2019-12-12', 'Fiber Kablo'),
('AsiaConnect', 'Hong Kong', 'support@asiaconnect.hk', '008523334455', 'Chen Wong', 'Çin', 5, '2018-09-09', 'Hassas Sensör'),
('SolarPro', 'Antalya', 'info@solarpro.com', '02425556677', 'Derya Tan', 'Türkiye', 4, '2015-02-18', 'Güneş Paneli'),
('OptiParts', 'Sakarya', 'iletisim@optiparts.com', '02644453210', 'Semih Demir', 'Türkiye', 4, '2016-04-30', 'Optik Bileşen');
GO

-- 4. Partner Tablosu
-- Sütunlar: PartnerName, PartnerType, Country, PartnershipDate, Email, PhoneNumber
INSERT INTO Partner (PartnerName, PartnerType, Country, PartnershipDate, Email, PhoneNumber) VALUES 
('Alpha Solutions', 'Technology', 'Türkiye', '2018-01-10', 'info@alphasolutions.com', '02121234567'),
('Beta Logistics', 'Logistics', 'Türkiye', '2017-03-12', 'support@betalog.com', '02125553377'),
('Orion Global', 'Manufacturing', 'Almanya', '2016-07-22', 'contact@orionglobal.de', '004930112233'),
('NovaTech', 'R&D', 'İsveç', '2019-02-14', 'info@novatech.se', '004670998877'),
('Sunrise Import', 'Import', 'Çin', '2015-05-10', 'sales@sunrise.cn', '008621334455'),
('BlueOcean Trade', 'Export', 'İngiltere', '2020-11-11', 'info@blueocean.co.uk', '004420778899'),
('GreenEnergy Partners', 'Energy', 'Norveç', '2018-08-01', 'contact@greenenergy.no', '004722665544'),
('TechBridge', 'Technology', 'ABD', '2014-09-21', 'info@techbridge.com', '001415998877'),
('Horizon Machines', 'Manufacturing', 'Japonya', '2016-06-05', 'support@horizon.jp', '008133556677'),
('EuroSupply', 'Logistics', 'Hollanda', '2017-12-02', 'office@eurosupply.nl', '003120778855'),
('AsiaTrade Co', 'Import', 'Singapur', '2015-04-18', 'info@asiatrade.sg', '006534128800'),
('GlobalVision', 'Consulting', 'Fransa', '2019-01-29', 'support@globalvision.fr', '0033144556677'),
('PrimeTech', 'Technology', 'İspanya', '2020-07-15', 'info@primetech.es', '003491223344'),
('HyperLink', 'Software', 'Türkiye', '2013-10-01', 'info@hyperlink.com.tr', '02124567890'),
('OptiSystems', 'Optics', 'İtalya', '2016-01-25', 'sales@optisystems.it', '003906558877'),
('ProConnect', 'Logistics', 'Türkiye', '2018-11-02', 'info@proconnect.com', '02124446655'),
('RedStar Robotics', 'Manufacturing', 'Japonya', '2014-04-18', 'contact@redstar.jp', '008133667788'),
('SkyTech', 'Technology', 'Kore', '2019-03-03', 'info@skytech.kr', '008223154400'),
('FutureWorks', 'R&D', 'ABD', '2015-11-11', 'team@futureworks.com', '001305778899'),
('GoldenGate', 'Consulting', 'Türkiye', '2021-02-18', 'info@goldengate.com.tr', '02123334455'),
('BrightLine', 'Marketing', 'Kanada', '2017-04-30', 'contact@brightline.ca', '001416778899'),
('DeepSea Trade', 'Export', 'Norveç', '2016-06-12', 'info@deepsea.no', '004723667788'),
('SilverTech', 'Software', 'Almanya', '2018-12-12', 'info@silvertech.de', '004930887766'),
('Quantum Partners', 'Technology', 'İsviçre', '2019-09-09', 'team@quantum.ch', '004122667788'),
('BlueWind R&D', 'R&D', 'Türkiye', '2020-05-05', 'info@bluewind.com.tr', '02122233445');
GO

-- 5. Machine Tablosu
-- Sütunlar: MachineName, PurchaseDate, Status, Location, LastMaintenance, NextMaintenance, Capacity
INSERT INTO Machine (MachineName, PurchaseDate, Status, Location, LastMaintenance, NextMaintenance, Capacity) VALUES 
('CNC Torna 2000', '2015-01-10', 'Active', 'Atölye 1', '2023-01-15', '2023-07-15', 120),
('Endüstriyel Kesici X5', '2016-03-12', 'Active', 'Atölye 2', '2023-02-01', '2023-08-01', 95),
('Hidrolik Pres 300', '2017-07-22', 'UnderMaintenance', 'Bakım Alanı', '2022-12-05', '2023-02-15', 150),
('Lazer Kesim L-500', '2019-02-14', 'Active', 'Kesim Bölümü', '2023-03-10', '2023-09-10', 80),
('Kaynak Robotu R2', '2020-05-10', 'Active', 'Montaj Hattı A', '2023-04-01', '2023-10-01', 60),
('Montaj Kolaboratif Robot A1', '2018-11-11', 'Active', 'Montaj Hattı B', '2023-03-18', '2023-09-18', 50),
('Konveyör Sistem CS-30', '2014-09-21', 'Inactive', 'Depo 1', '2022-11-02', '2023-06-02', 200),
('CNC Freze 1500', '2013-06-05', 'Active', 'Atölye 1', '2023-01-03', '2023-07-03', 140),
('Bükme Makinesi BK-120', '2016-12-02', 'Active', 'Atölye 3', '2023-02-22', '2023-08-22', 110),
('Paketleme Robotu P1', '2017-04-18', 'Active', 'Paketleme Alanı', '2023-04-12', '2023-10-12', 70),
('Kompresör K-45', '2015-10-29', 'UnderMaintenance', 'Bakım Alanı', '2023-01-20', '2023-05-20', 85),
('Soğutma Ünitesi S-200', '2016-08-01', 'Active', 'Soğutma Odası', '2023-03-01', '2023-09-01', 130),
('Otomatik Vidalama Makinesi V10', '2019-03-07', 'Active', 'Montaj Hattı C', '2023-02-15', '2023-08-15', 55),
('Darbeli Pres DP-90', '2014-05-12', 'Inactive', 'Depo 2', '2022-10-01', '2023-04-01', 160),
('Endüstriyel Fırın F-300', '2018-01-29', 'Active', 'Isıtma Alanı', '2023-03-18', '2023-09-18', 200),
('Test Cihazı T-20', '2020-07-15', 'Active', 'Test Lab', '2023-05-10', '2023-11-10', 30),
('Talaşlı İmalat Makinesi TM-40', '2015-11-11', 'Active', 'Atölye 2', '2023-04-22', '2023-10-22', 90),
('CNC Router R700', '2017-02-18', 'Active', 'Ahşap Üretim', '2023-02-11', '2023-08-11', 75),
('Endüstriyel Karıştırıcı K-60', '2016-04-30', 'Active', 'Kimya Bölümü', '2023-01-19', '2023-07-19', 45),
('Otomatik Etiketleme Makinesi E40', '2019-06-12', 'Active', 'Paketleme Alanı', '2023-03-10', '2023-09-10', 65),
('Montaj Press AP-10', '2018-12-12', 'Active', 'Montaj Hattı D', '2023-02-02', '2023-08-02', 100),
('Robotik Kol RX-90', '2020-09-09', 'Active', 'Robotik Hat', '2023-04-15', '2023-10-15', 50),
('Toz Boya Fırını BF-200', '2015-02-18', 'Active', 'Boya Bölümü', '2023-03-21', '2023-09-21', 180),
('Isıl İşlem Makinesi IIM-70', '2014-04-30', 'Inactive', 'Depo 3', '2022-12-12', '2023-06-12', 120),
('Lazer Tarayıcı LT-80', '2021-01-10', 'Active', 'Kalite Laboratuvarı', '2023-05-01', '2023-11-01', 40);
GO

-- 6. Product Tablosu
-- Sütunlar: ProductName, UnitPrice, Category, Cost, Stock, ManufacturedDate, SupplierID, MachineID, QualityStatus
INSERT INTO Product (ProductName, UnitPrice, Category, Cost, Stock, ManufacturedDate, SupplierID, MachineID, QualityStatus) VALUES 
('Metal Gövde A1', 250, 'Metal Parça', 180, 120, '2022-01-10', 1, 3, NULL),
('Elektronik Kontrol Kartı K10', 480, 'Elektronik', 350, 85, '2021-03-15', 2, 4, NULL),
('Motor Sürücü M2', 950, 'Motor', 720, 60, '2020-07-22', 19, 5, NULL),
('Plastik Kapak P500', 40, 'Plastik', 15, 300, '2021-02-10', 10, 9, NULL),
('Hassas Sensör S20', 780, 'Sensör', 620, 40, '2023-04-01', 23, 25, NULL),
('Fiber Kablo F12', 150, 'Kablo', 90, 500, '2022-05-12', 22, 7, NULL),
('Servo Motor SM150', 1200, 'Motor', 900, 35, '2020-11-05', 12, 8, NULL),
('Montaj Parçası MP30', 95, 'Montaj', 55, 200, '2022-03-18', 14, 11, NULL),
('Robotik Kol Bileşeni RBX', 2100, 'Robotik', 1650, 25, '2021-01-25', 20, 20, NULL),
('Kauçuk Yastık KY-80', 65, 'Kauçuk', 30, 260, '2023-02-01', 5, 14, NULL),
('Soğutma Ünitesi S200', 3300, 'Soğutma', 2500, 10, '2020-09-21', 13, 12, NULL),
('Polimer Kasnak PK100', 180, 'Polimer', 70, 140, '2019-06-15', 20, 16, NULL),
('Hidrolik Pompa HP300', 2700, 'Hidrolik', 2100, 18, '2022-08-11', 16, 17, NULL),
('Montaj Aparatı MA44', 120, 'Montaj', 65, 180, '2021-10-02', 15, 15, NULL),
('Servo Kontrol Ünitesi SKU90', 680, 'Elektronik', 450, 55, '2023-03-12', 7, 13, NULL),
('Optik Lens OL25', 550, 'Optik', 320, 22, '2020-12-05', 25, 18, NULL),
('Endüstriyel Fan F900', 1500, 'Soğutma', 1100, 15, '2021-07-30', 6, 6, NULL),
('Konveyör Zinciri KZ75', 230, 'Konveyör', 130, 95, '2022-09-01', 7, 2, NULL),
('Elektrik Bağlantı Kablosu EBK45', 55, 'Kablo', 20, 400, '2023-01-09', 4, 10, NULL),
('Motor Vidası MV10', 12, 'Vida', 2, 800, '2021-06-22', 1, 1, NULL),
('Boru Seti BS40', 340, 'Metal Parça', 220, 140, '2019-11-14', 11, 24, NULL),
('Plastik Panel PP22', 90, 'Plastik', 30, 160, '2020-08-17', 10, 22, NULL),
('Robotik Aktüatör RA50', 1900, 'Robotik', 1500, 18, '2021-03-05', 17, 21, NULL),
('Optik Sensör OS18', 490, 'Sensör', 300, 50, '2022-04-11', 23, 19, NULL),
('Güneş Paneli GP100', 2600, 'Enerji', 1900, 28, '2023-02-25', 24, 23, NULL);
GO

-- 7. QualityCheck Tablosu
-- Sütunlar: ProductID, MachineID, CheckDate, Result, CheckedByEmployeeID
INSERT INTO QualityCheck (ProductID, MachineID, CheckDate, Result, CheckedByEmployeeID) VALUES 
(1, 1, '2023-01-10', 'Pass', 1),
(2, 3, '2023-01-12', 'Pass', 2),
(3, 4, '2023-01-15', 'Fail', 3),
(4, 2, '2023-01-18', 'Pass', 4),
(5, 5, '2023-01-20', 'Pass', 5),
(6, 6, '2023-02-01', 'Pass', 6),
(7, 7, '2023-02-05', 'Fail', 7),
(8, 8, '2023-02-08', 'Pass', 8),
(9, 9, '2023-02-10', 'Pass', 9),
(10, 10, '2023-02-14', 'Fail', 10),
(11, 11, '2023-03-01', 'Pass', 11),
(12, 12, '2023-03-03', 'Pass', 12),
(13, 13, '2023-03-05', 'Fail', 13),
(14, 14, '2023-03-10', 'Pass', 14),
(15, 15, '2023-03-12', 'Pass', 15),
(16, 16, '2023-04-01', 'Pass', 16),
(17, 17, '2023-04-04', 'Fail', 17),
(18, 18, '2023-04-06', 'Pass', 18),
(19, 19, '2023-04-09', 'Pass', 19),
(20, 20, '2023-04-15', 'Fail', 20),
(21, 21, '2023-05-01', 'Pass', 21),
(22, 22, '2023-05-03', 'Pass', 22),
(23, 23, '2023-05-05', 'Fail', 23),
(24, 24, '2023-05-08', 'Pass', 24),
(25, 25, '2023-05-10', 'Pass', 25);
GO

-- 8. Invoice Tablosu
-- Sütunlar: InvoiceDate, CustomerID, ProductID, TotalAmount, TaxRate, TaxOfficeNumber, InvoiceType, InvoicingParty, InvoicedParty
-- TotalWithTax SADECE hesaplanmış (COMPUTED) sütun olduğu için INSERT listesine dahil edilmez.
INSERT INTO Invoice (InvoiceDate, CustomerID, ProductID, TotalAmount, TaxRate, TaxOfficeNumber, InvoiceType, InvoicingParty, InvoicedParty) VALUES 
('2023-01-05', 1, 1, 850, 20.0, 'İST-KDK-01', 'Sales', 'Dene Teknoloji', 'Ali Yılmaz'),
('2023-01-10', 2, 2, 1200, 18.0, 'ANK-MLT-02', 'Sales', 'Dene Teknoloji', 'Ayşe Demir'),
('2023-01-14', 3, 3, 450, 20.0, 'İZM-KRS-11', 'Return', 'Mehmet Kaya', 'Dene Teknoloji'),
('2023-01-18', 4, 4, 980, 20.0, 'BUR-TRM-09', 'Sales', 'Dene Teknoloji', 'Elif Koç'),
('2023-01-22', 5, 5, 1500, 18.0, 'ANT-GLM-03', 'Sales', 'Dene Teknoloji', 'Canan Aydın'),
('2023-02-01', 6, 6, 620, 20.0, 'KON-YNS-07', 'Sales', 'Dene Teknoloji', 'Burak Şahin'),
('2023-02-04', 7, 7, 2200, 20.0, 'ESK-FRM-02', 'Sales', 'Dene Teknoloji', 'Zeynep Arslan'),
('2023-02-09', 8, 8, 980, 18.0, 'KYS-DMR-10', 'Sales', 'Dene Teknoloji', 'Fatma Çelik'),
('2023-02-12', 9, 9, 3600, 20.0, 'GZT-TBR-21', 'Sales', 'Dene Teknoloji', 'Ahmet Öz'),
('2023-02-18', 10, 10, 740, 20.0, 'MRS-ERL-33', 'Return', 'Selin Er', 'Dene Teknoloji'),
('2023-03-03', 11, 11, 650, 20.0, 'TKR-KPL-44', 'Sales', 'Dene Teknoloji', 'Hülya Kaplan'),
('2023-03-07', 12, 12, 4300, 18.0, 'MUG-BLT-22', 'Sales', 'Dene Teknoloji', 'Orhan Bulut'),
('2023-03-09', 13, 13, 1200, 20.0, 'TRB-DNZ-12', 'Sales', 'Dene Teknoloji', 'Deniz Taş'),
('2023-03-15', 14, 14, 1700, 20.0, 'BLK-KAR-56', 'Sales', 'Dene Teknoloji', 'Gamze Kar'),
('2023-03-20', 15, 15, 2500, 18.0, 'ADN-UZN-78', 'Sales', 'Dene Teknoloji', 'Murat Uzun'),
('2023-04-02', 16, 16, 880, 20.0, 'EDR-TNC-03', 'Return', 'Aslı Tunç', 'Dene Teknoloji'),
('2023-04-06', 17, 17, 1980, 20.0, 'RİZ-GOK-19', 'Sales', 'Dene Teknoloji', 'Kerem Gök'),
('2023-04-10', 18, 18, 640, 20.0, 'AYD-KIR-88', 'Sales', 'Dene Teknoloji', 'Nazlı Kır'),
('2023-04-15', 19, 19, 1100, 20.0, 'VAN-ATS-04', 'Sales', 'Dene Teknoloji', 'Uğur Ateş'),
('2023-04-19', 20, 20, 2850, 20.0, 'MLT-BRN-90', 'Sales', 'Dene Teknoloji', 'Sevgi Baran'),
('2023-05-03', 21, 21, 720, 20.0, 'KUT-CNK-11', 'Return', 'Tolga Cenk', 'Dene Teknoloji'),
('2023-05-08', 22, 22, 450, 20.0, 'SAK-GUR-14', 'Sales', 'Dene Teknoloji', 'Melis Gür'),
('2023-05-12', 23, 23, 2100, 18.0, 'DNZ-SRT-66', 'Sales', 'Dene Teknoloji', 'Okan Sert'),
('2023-05-18', 24, 24, 980, 20.0, 'HTY-KAN-77', 'Return', 'Yasemin Kaan', 'Dene Teknoloji'),
('2023-05-22', 25, 25, 1600, 20.0, 'SMS-DMR-55', 'Sales', 'Dene Teknoloji', 'Efe Demirtaş');
GO

-- 9. Payment Tablosu
-- Sütunlar: InvoiceID, PaymentType, PaymentDate, PaymentAmount, SwiftNo, PaymentMethod, ApprovedBy, Payee
INSERT INTO Payment (InvoiceID, PaymentType, PaymentDate, PaymentAmount, SwiftNo, PaymentMethod, ApprovedBy, Payee) VALUES 
(1, 'Sale Payment', '2023-01-06', 850, 'TR001XYZ001', 'EFT', 'Ahmet Kar', 'Dene Teknoloji'),
(2, 'Sale Payment', '2023-01-12', 1200, 'TR002XYZ002', 'EFT', 'Elif Kaya', 'Dene Teknoloji'),
(3, 'Return Refund', '2023-01-16', 450, NULL, 'CASH', 'Burak Demir', 'Mehmet Kaya'),
(4, 'Sale Payment', '2023-01-19', 980, 'TR004XYZ004', 'CREDIT', 'Selin Ak', 'Dene Teknoloji'),
(5, 'Sale Payment', '2023-01-25', 1500, 'TR005XYZ005', 'EFT', 'Merve Çınar', 'Dene Teknoloji'),
(6, 'Sale Payment', '2023-02-03', 620, NULL, 'CASH', 'Zeynep Kurt', 'Dene Teknoloji'),
(7, 'Sale Payment', '2023-02-07', 2200, 'TR007XYZ007', 'EFT', 'Efe Tunç', 'Dene Teknoloji'),
(8, 'Sale Payment', '2023-02-11', 980, NULL, 'CASH', 'Savaş Yalçın', 'Dene Teknoloji'),
(9, 'Sale Payment', '2023-02-14', 3600, 'TR009XYZ009', 'EFT', 'Aslı Tek', 'Dene Teknoloji'),
(10, 'Return Refund', '2023-02-20', 740, NULL, 'CASH', 'Pelin Ada', 'Selin Er'),
(11, 'Sale Payment', '2023-03-04', 650, NULL, 'CASH', 'Koray Alp', 'Dene Teknoloji'),
(12, 'Sale Payment', '2023-03-10', 4300, 'TR012XYZ012', 'EFT', 'Yusuf Ateş', 'Dene Teknoloji'),
(13, 'Sale Payment', '2023-03-12', 1200, NULL, 'CREDIT', 'Murat Yılmaz', 'Dene Teknoloji'),
(14, 'Sale Payment', '2023-03-17', 1700, 'TR014XYZ014', 'EFT', 'Gültekin Ar', 'Dene Teknoloji'),
(15, 'Sale Payment', '2023-03-21', 2500, 'TR015XYZ015', 'EFT', 'Melis Tuncer', 'Dene Teknoloji'),
(16, 'Return Refund', '2023-04-05', 880, NULL, 'CASH', 'Serkan Acar', 'Aslı Tunç'),
(17, 'Sale Payment', '2023-04-09', 1980, 'TR017XYZ017', 'EFT', 'Filiz Er', 'Dene Teknoloji'),
(18, 'Sale Payment', '2023-04-12', 640, NULL, 'CASH', 'Hande Solmaz', 'Dene Teknoloji'),
(19, 'Sale Payment', '2023-04-17', 1100, NULL, 'CREDIT', 'Mert Can', 'Dene Teknoloji'),
(20, 'Sale Payment', '2023-04-22', 2850, 'TR020XYZ020', 'EFT', 'Berk Yıldız', 'Dene Teknoloji'),
(21, 'Return Refund', '2023-05-04', 720, NULL, 'CASH', 'Nesrin Ak', 'Tolga Cenk'),
(22, 'Sale Payment', '2023-05-09', 450, NULL, 'CASH', 'Ayhan Yurt', 'Dene Teknoloji'),
(23, 'Sale Payment', '2023-05-15', 2100, 'TR023XYZ023', 'EFT', 'Ömer Faruk', 'Dene Teknoloji'),
(24, 'Return Refund', '2023-05-20', 980, NULL, 'CASH', 'Pınar Soy', 'Yasemin Kaan'),
(25, 'Sale Payment', '2023-05-25', 1600, 'TR025XYZ025', 'EFT', 'Esra Kartal', 'Dene Teknoloji');
GO