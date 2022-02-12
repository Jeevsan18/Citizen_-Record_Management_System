CREATE DATABASE CitizenRecordManagement
USE CitizenRecordManagement

CREATE TABLE GeneralRecord
(NationID INT NOT NULL,
FirstName VARCHAR(20) NOT NULL,
LastName VARCHAR(20) NOT NULL,
DateofBirth DATE NOT NULL,
Gender VARCHAR(10) NOT NULL,
PhoneNumber VARCHAR(20) NOT NULL,
EmailID VARCHAR(70),
Qualification VARCHAR(45),
PanNumber VARCHAR(15),
WorkStatus BIT,
CityofBirth VARCHAR(30),
PassportNumber VARCHAR(15),
StreetNumber VARCHAR(10),
City VARCHAR(45) NOT NULL,
State VARCHAR(45) NOT NULL,
Country VARCHAR(45) NOT NULL,
ZipCode VARCHAR(45) NOT NULL,
DateofDeath DATE NULL,
Age as DATEDIFF(hour,dateofbirth,getdate())/8766 ,
CumulativeAchievment AS dbo.fn_Achievementcount(NationID)
CONSTRAINT PK_GeneralRecord PRIMARY KEY(NationID));


CREATE TABLE SchoolRecord
(SchoolID VARCHAR(45) NOT NULL,
SchoolName VARCHAR(200) NOT NULL,
StreetNumber VARCHAR(10),
City VARCHAR(30) NOT NULL,
State VARCHAR(45) NOT NULL,
Country VARCHAR(45) NOT	NULL,
ZipCode VARCHAR(45) NOT NULL
CONSTRAINT PK_SchoolRecord PRIMARY KEY(SchoolID));


CREATE TABLE GeneralSchoolRecord
(NationID INT NOT NULL,
SchoolID VARCHAR(45) NOT NULL
CONSTRAINT PK_GeneralSchoolRecord PRIMARY KEY(NationID,SchoolID),
CONSTRAINT FK_GeneralSchoolRecordNationID FOREIGN KEY (NationID) REFERENCES GeneralRecord (NationID),
CONSTRAINT FK_GeneralSchoolRecordSchoolID FOREIGN KEY (SchoolID) REFERENCES SchoolRecord(SchoolID)
);


CREATE TABLE CollegeRecord
(CollegeID VARCHAR(45) NOT NULL,
CollegeName VARCHAR(200) NOT NULL,
StreetNumber VARCHAR(10),
City VARCHAR(30) NOT NULL,
State VARCHAR(45) NOT NULL,
Country VARCHAR(45) NOT NULL,
ZipCode VARCHAR(45) NOT NULL
CONSTRAINT PK_CollegeRecord PRIMARY KEY(CollegeID));


CREATE TABLE GeneralCollegeRecord
(NationID INT NOT NULL,
CollegeID VARCHAR(45) NOT NULL,
CONSTRAINT PK_GeneralCollegeRecord PRIMARY KEY(NationID,CollegeID),
CONSTRAINT FK_GeneralCollegeRecordNationID FOREIGN KEY (NationID) REFERENCES GeneralRecord (NationID),
CONSTRAINT FK_GeneralCollegeRecordCollegeID FOREIGN KEY (CollegeID) REFERENCES CollegeRecord(CollegeID)
);


CREATE TABLE HealthRecord
(
HealthID Varchar(45) NOT NULL,
NationID Int not null,
BMI float,
BloodGroup varchar(10),
MedicalCheckupDate Date,
HealthPolicyNumber varchar(15),
HealthInsurerName varchar(50),
CommunicableDiseases BIT NOT NULL,
PatientSummary Varchar(100),
CONSTRAINT PK_HealthRecord PRIMARY KEY(HealthID,NationID),
CONSTRAINT FK_HealthRecordNationID FOREIGN KEY (NationID) REFERENCES GeneralRecord (NationID)
);


CREATE TABLE BankRecord
(BankID VARCHAR(45) NOT NULL,
BankName VARCHAR(45) NOT NULL,
IFSC VARCHAR(45) NOT NULL,
BranchName VARCHAR(45) NOT NULL
CONSTRAINT PK_BankRecord PRIMARY KEY(BankID));


CREATE TABLE GeneralBankRecord
(
NationID INT NOT NULL,
AccountNumber Varchar(50) NOT NULL,
BankID VARCHAR(45) NOT NULL,
CONSTRAINT PK_GeneralBankRecord PRIMARY KEY clustered (AccountNumber,NationID,BankID),
CONSTRAINT FK_GeneralBankRecordNationID FOREIGN KEY (NationID) REFERENCES GeneralRecord (NationID),
CONSTRAINT FK_GeneralBankRecordBankID FOREIGN KEY (BankID) REFERENCES Bankrecord (BankID)
);


CREATE TABLE UtilityRecord
(
UtilityID INT NOT NULL,
ConsumptionPeriod DATE NOT NULL,
ElectricityConsumption FLOAT NOT NULL,
WaterConsumption FLOAT NOT NULL,
GasConsumption FLOAT,
NationID INT NOT NULL
CONSTRAINT PK_UtilityRecord PRIMARY KEY(UtilityID,NationID),
CONSTRAINT FK_UtilityRecordNationID FOREIGN KEY(NationID) REFERENCES GeneralRecord(NationID));


CREATE TABLE PropertyDetails
(PropertyID VARCHAR(45) NOT NULL,
PropertyOwned VARCHAR(45) NOT NULL,
Area FLOAT NOT NULL,
Location VARCHAR(20) NOT NULL,
PropertyValue BIGINT NOT NULL,
PropertyTax INT NOT NULL,
NationID INT NOT NULL
CONSTRAINT PK_PropertyDetails PRIMARY KEY(PropertyID,NationID),
CONSTRAINT FK_PropertyDetailsNationID FOREIGN KEY(NationID) REFERENCES GeneralRecord(NationID));


CREATE TABLE VehicleRecord
(VehicleID VARCHAR(30) NOT NULL,
VehicleNumber VARCHAR(45) NOT NULL,
VehicleType VARCHAR(45),
FuelType VARCHAR(20),
EngineNumber VARCHAR(45) NOT NULL,
ChassisNumber VARCHAR(45) NOT NULL,
VehicleInsurerName VARCHAR(200),
VehiclePolicyNumber VARCHAR(45),
NationID INT NOT NULL,
CONSTRAINT PK_VehicleRecord PRIMARY KEY(VehicleID,NationID),
CONSTRAINT FK_VehicleRecordNationID FOREIGN KEY(NationID) REFERENCES GeneralRecord(NationID));


CREATE TABLE CompanyRecord
(CompanyID VARCHAR(45) NOT NULL,
CompanyName VARCHAR(45) NOT NULL
CONSTRAINT PK_CompanyRecord PRIMARY KEY(CompanyID));


CREATE TABLE GeneralCompanyRecord
(NationID INT NOT NULL,
CompanyID VARCHAR(45) NOT NULL,
DateOfJoining DATE NOT NULL,
DateOfReleving DATE,
Designation VARCHAR(45) NOT NULL,
CurrentSalary INT,
Skills VARCHAR(45)
CONSTRAINT PK_GeneralCompanyRecord PRIMARY KEY(NationID,CompanyID),
CONSTRAINT FK_GeneralCompanyRecorddNationID FOREIGN KEY (NationID) REFERENCES GeneralRecord (NationID),
CONSTRAINT FK_GeneralCompanyRecordCompanyID FOREIGN KEY (CompanyID) REFERENCES CompanyRecord(CompanyID));


CREATE TABLE CriminalRecord(
CrimeID VARCHAR(45) NOT NULL,
FIRNumber VARCHAR(45) NOT NULL,
Section VARCHAR(10),
TypeOfCrime VARCHAR(20),
CurrentStatus BIT NOT NULL,
NationID INT NOT NULL
CONSTRAINT PK_CriminalRecord PRIMARY KEY (CrimeID,NationID),
CONSTRAINT FK_CriminalRecordNationID FOREIGN KEY(NationID) REFERENCES GeneralRecord(NationID));


CREATE TABLE TravelRecord
(TravelID VARCHAR(45) NOT NULL,
CountryVisited VARCHAR(45) NOT NULL,
DateofEntry DATE NOT NULL,
DateofExit DATE,
TravelInsuranceNumber VARCHAR(45),
TravelInsurerName VARCHAR(45),
NationID INT NOT NULL
CONSTRAINT PK_TravelRecord PRIMARY KEY(TravelID,NationID),
CONSTRAINT FK_TravelRecordNationID FOREIGN KEY(NationID) REFERENCES GeneralRecord(NationID));


CREATE TABLE AchievementRecord
(AchievementID VARCHAR(45) NOT NULL,
AchievementName VARCHAR(45) NOT NULL
CONSTRAINT PK_AchievementRecord PRIMARY KEY(AchievementID));

CREATE TABLE GoodSamaritanRecord
(NationID INT NOT NULL,
AchievementID VARCHAR(45) NOT NULL
CONSTRAINT PK_GoodSamaritanRecord PRIMARY KEY(NationID,AchievementID),
CONSTRAINT FK_GoodSamaritanRecordNationID FOREIGN KEY(NationID) REFERENCES GeneralRecord(NationID),
CONSTRAINT FK_GoodSamaritanRecordAchievementID FOREIGN KEY(AchievementID) REFERENCES AchievementRecord(AchievementID));
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--INSERT STATEMENTS FOR GENERALRECORD

Insert Into GeneralRecord Values(1,'Sara','Dsouza','1986-05-01','Female','8123725753','d.sara@gmail.com','B.E','AAECC6548C','1','Goa','J8369854','15A','Goa','Goa','India','403110',NULL)
Insert Into GeneralRecord Values(2, 'Neha', 'Sharma','1972/09/28', 'Female','9345678658', 'sharma.neha72@hotmail.com', 'B.COM', 'BNZPM2501F', '1', 'Delhi', 'J5498883', '1C', 'Chandigarh','Chandigarh', 'India', '160005',NULL)
Insert Into GeneralRecord Values(3, 'Rakesh', 'Kumar', '1991/10/14', 'Male','7645783546','rakeshkumar14@yahoo.com','CA', 'ABCD1234A', '1', 'Mumbai', 'N1242853', '44C', 'Mumbai','Maharashtra', 'India', '400002',NULL)
Insert Into GeneralRecord Values(4, 'Andrew', 'Symonds', '1958/03/15', 'Male', '9987653421','andrew15symonds@gmail.com', 'B.SC', 'AQDPP8277H', '1', 'Cochin', 'N4017151', '12D', 'Chennai','Tamil Nadu','India', '682001', '12-04-19')
Insert Into GeneralRecord Values(5, 'Richard', 'Parker', '1990/12/11', 'Male','6789334567', 'rp11@outlook.com', 'M.A', 'BLUPS4233F', '1', 'Chennai', 'F7802033', '7A', 'Bangalore','Karnataka','India',  '560078',NULL)
Insert Into GeneralRecord Values(6, 'Raksha', 'Ramkumar', '1997-10-05','Female','8721908009','raksharamkumar@gmail.com', 'B.E', 'BAWIPP1078K', '1', 'Bangalore', 'FH2004824', '8A', 'Bangalore','Karnataka', 'India',  '560068',NULL)
Insert Into GeneralRecord Values(7, 'Paul', 'Wesley', '1982-07-23','Male','7213425789','wesleypaul2307@gmail.com', 'BBA', 'AABTG6381M', '0', 'Pune', 'H9137927', '7D', 'Pune', 'Maharashtra','India','400003',NULL)
Insert Into GeneralRecord Values(8, 'Ritika', 'Ahuja', '1999/12/31','Female','9704358558','ritikaa1999@gmail.com', 'B.COM', 'AAECB2434L', '0', 'Mumbai', 'F6494641', '11B', 'Kolkata', 'West Bengal','India',  '700027',NULL)
Insert Into GeneralRecord Values(9, 'Anusha', 'Rao', '1992/07/13','Female','9538283441','raoanusha@gmail.com', 'MS', 'AAMTS2433L', '1', 'Bangalore', 'H3925627', '6C', 'Hyderabad','Telangana', 'India',  '500001',NULL)
Insert Into GeneralRecord Values(10, 'Sachin', 'Tendulkar', '1973/04/24','Male','8356478921','sachintendulkar@gmail.com', 'High School', 'AAJFN2389N', '0', 'Mumbai', 'M1278934', 'C37', 'Ahemadabad','Gujarat', 'India','320008',NULL)

--INSERT STATEMENTS FOR COMPANYRECORD
Insert Into CompanyRecord values('ACCN','Accenture')
Insert Into CompanyRecord values('COGN','Cognizant')
Insert Into CompanyRecord values('INFY','Infosys')
Insert Into CompanyRecord values('GS','Goldman Sachs')
Insert Into CompanyRecord values('ALGS','AllGosystems')
Insert Into CompanyRecord values('TCS','Tata Consultancies')
Insert Into CompanyRecord values('MOS','Microsoft')
Insert Into CompanyRecord values('GGL','Google')
Insert Into CompanyRecord values('JPMC','JP Morgan Chase')
Insert Into CompanyRecord values('CDS','Cadence Design Systems')

--INSERT STATEMENTS FOR GENERALSCHOOLRECORD
Insert Into GeneralSchoolRecord values(2,'HPSR')
Insert Into GeneralSchoolRecord values(1,'DPSN')
Insert Into GeneralSchoolRecord values(5,'CARM')
Insert Into GeneralSchoolRecord values(4,'APS')
Insert Into GeneralSchoolRecord values(4,'DAV')
Insert Into GeneralSchoolRecord values(4,'HPSR')
Insert Into GeneralSchoolRecord values(6,'LFS')
Insert Into GeneralSchoolRecord values(7,'BVBS')
Insert Into GeneralSchoolRecord values(10,'NHVPS')
Insert Into GeneralSchoolRecord values(3,'AGCS')
Insert Into GeneralSchoolRecord values(8,'NHVPS')
Insert Into GeneralSchoolRecord values(1,'BNM')
Insert Into GeneralSchoolRecord values(7,'SKCH')


--INSERT STATEMENTS FOR SCHOOLRECORD
Insert Into SchoolRecord values('HPSR','Hyderabad Public School','44A','Hyderabad','Telangana','India','560098')
Insert Into SchoolRecord values('DPSN','Delhi Public School North','2D','Delhi','Delhi','India','700001')
Insert Into SchoolRecord values('CARM','Carmel High School','23D','Bangalore','Karnataka','India','500078')
Insert Into SchoolRecord values('APS','Albert Public School','12A','Cochin','Kerala','India','430023')
Insert Into SchoolRecord values('LFS','Little Flower School','4D','Bangalore','Karnataka','India','560078')
Insert Into SchoolRecord values('BVBS','Bhartiya Vidhya Bhavans School','223E','Pune','Maharashtra','India','320087')
Insert Into SchoolRecord values('AGCS','Assembly of God Church School','10M','Mumbai','Maharashtra','India','432001')
Insert Into SchoolRecord values('NBPS','Nava Bharath Public School','23D','Kolkata','West Bengal','India','500001')
Insert Into SchoolRecord values('BNM','Bhageerathibai Narayanrao Maney','15D','God','Goa','India','570072')
Insert Into SchoolRecord values('SKCh','Shri Kumarans Children Home','1A','Bangalore','Karnataka','India','652001')
Insert Into SchoolRecord values('DAV','Dayanand Aglo Vedic','25V','Chennai','Tamil Nadu','India','654898')
Insert Into SchoolRecord values('NHVPS','National Hill View Public School','23D','Ahemadabad','Gujrat','India','540021')


--INSERT STATEMENTS FOR GENERALCOMPANYRECORD
Insert into GeneralCompanyRecord values(1,'JPMC','2018-07-07', NULL,'Sr.Software Developer',1100000,'Java')
Insert into GeneralCompanyRecord values(1,'ACCN','2011/04/02','2018/06/19','Associate Software Engineer',800000,'Perl')
Insert into GeneralCompanyRecord values(2,'MOS','2016/05/10',NULL,'Software Development Engineer',1500000,'Python')
Insert into GeneralCompanyRecord values (2,'TCS','2014/03/23','2016/04/01','DevOps Engineer',700000,'Python')
Insert into GeneralCompanyRecord values(2,'INFY','2010/01/15','2014/02/28','Business Development Associate',540000,'SQL')
Insert into GeneralCompanyRecord values(3,'ACCN','2015/08/15',NULL,'Accounts Manager',900000,'Java')
Insert into GeneralCompanyRecord values(4,'MOS','1999/11/13','2019/01/04','Production Manager',3000000,'C')
Insert into GeneralCompanyRecord values(4,'GS','1996/06/19','1999/10/20','Project Manager',1200000,'Ruby')
Insert into GeneralCompanyRecord values(5,'COGN','2012/07/15',NULL,'Senior Program Analyst',950000,'R')
Insert into GeneralCompanyRecord values(6,'ALGS','2019/07/05',NULL,'Software Developer',550000,'.net')
Insert into GeneralCompanyRecord values(7,'GS','2009/05/12',NULL,'Manager',1600000,'.Spark')
Insert into GeneralCompanyRecord values(9,'MOS','2019/03/07',NULL,'AI Engineer',2200000,'Matlab')
Insert into GeneralCompanyRecord values(9,'JPMC','2015/07/24','2013-02-19','Application Development Engineer',1400000,'C#')


--INSERT STATEMENTS FOR GOODSAMRITANRECORD
Insert Into GoodSamaritanRecord values(1,'1')
Insert Into GoodSamaritanRecord values(1,'4')
Insert Into GoodSamaritanRecord values(3,'6')
Insert Into GoodSamaritanRecord values(3,'2')
Insert Into GoodSamaritanRecord values(5,'7')
Insert Into GoodSamaritanRecord values(6,'8')
Insert Into GoodSamaritanRecord values(7,'9')
Insert Into GoodSamaritanRecord values(8,'2')
Insert Into GoodSamaritanRecord values(9,'10')
Insert Into GoodSamaritanRecord values(10,'3')


--INSERT STATEMENTS FOR ACHIEVEMENTRECORD
Insert Into AchievementRecord values('1','Blood Donation')
Insert Into AchievementRecord values('2','Educational Drives')
Insert Into AchievementRecord values('3','Plantation Drive')
Insert Into AchievementRecord values('4','Army Service')
Insert Into AchievementRecord values('5','Scientific Invention')
Insert Into AchievementRecord values('6','Sports')
Insert Into AchievementRecord values('7','National Bravery Award')
Insert Into AchievementRecord values('8','Contribution to rural Upliftment')
Insert Into AchievementRecord values('9','Women Empowerment')
Insert Into AchievementRecord values('10','Government Donation')

--INSERT STATEMENTS FOR PROPERTYDETAILS
Insert Into PropertyDetails values('P1','Sara','1000.25','Goa','2500000','208333','1')
Insert Into PropertyDetails values('P2','Neha','2000.21','Chandigargh','3000000','250000','2')
Insert Into PropertyDetails values('P3','Rakesh','1548.95','Mumbai','10000000','833333','3')
Insert Into PropertyDetails values('P4','Andrew','711.45','Chennai','15000000','1250000','4')
Insert Into PropertyDetails values('P5','Richard','850.45','Bangalore','15000000','1250000','5')
Insert Into PropertyDetails values('P6','Raksha','601.95',' Bangalore','10000000','833333','6')
Insert Into PropertyDetails values('P7','Paul','999.65','Pune','20000000','1666666','7')
Insert Into PropertyDetails values('P8','Ritika','500.78','Kolkata','7000000','583333','8')
Insert Into PropertyDetails values('P9','Anusha','760.36',' Hyderabad','10000000','833333','9')
Insert Into PropertyDetails values('P10','Sachin','820.48','Ahemadabad','15000000','1250000','10')

--INSERT STATEMENTS FOR VEHICLERECORD
Insert Into VehicleRecord values('V01','KA 09 CA 1243',	'car', 'Diesel','53WCV10223','1KDF2932HE237119','Bajaj Allianz','198478RY346','5')
Insert Into VehicleRecord values('V02',	'TN 10 ED 9987','car','Petrol','27AWC98237','1AKJDJ29428B232O8','Bharti AXA','28167SADH8643','4')
Insert Into VehicleRecord values('V03','KA 01 AW 0065','car','Diesel','98QWE98730','1KS23726J2J222','New India Insurance','1846JFHS17246','6')
Insert Into VehicleRecord values('V04','MH 07 AZ 4563','car','Petrol','09LKJF12332','1AAJK29137NN1387','Bajaj Allianz','12461FKH278871','7')
Insert Into VehicleRecord values('V05','TS 09 AA 0010','Car','Diesel','99ZXZ91833','1KJKSD2746JH22929','New India Insurance','1486712414KA7723','9')
Insert Into VehicleRecord values('V06','TN 08 AC 2881',	'Two wheeler','Petrol','88EER776611','1JSD28736HHS17823','New India Insurance','1846SALC176811','4')
Insert Into VehicleRecord values('V07','CH 09 AA 7767','Two wheeler','Petrol','11HFG00987','1JKDF27367NJ2272','Future Generali','18467QWQ871476','2')
Insert Into VehicleRecord values('V08','GA 01 AS 0001','Two wheeler','Petrol','21AAS654277','1BFZJ73248BJ2292','Bajaj Allianz','1476CJCKZ11971','1')
Insert Into VehicleRecord values('V09','KA 08 AZ 1001','car','Diesel','77ZSE297947','1AIRU283684H2800','New India Insurance','1471KSDH876','4')
Insert Into VehicleRecord values('V10','GJ 01 AA 0123',	'car','Diesel','88DDG13711','1KSD3286TYU93788','Bharti AXA','832617AKH3784','10')

--INSERT STATEMENTS FOR UTILITYRECORD
Insert Into UtilityRecord values('1','2020-05-11','1000.25','500.95','20.01','1')
Insert Into UtilityRecord values('2','2020-04-20','850.96','750.65','100.23','2')
Insert Into UtilityRecord values('3','2020-05-20','2000.24','1056.96','75.45','2')
Insert Into UtilityRecord values('4','2019-05-05','650.45','1201.45','50.8','4')
Insert Into UtilityRecord values('5','2020-05-19','2150.96','1000.75','250.45','5')
Insert Into UtilityRecord values('6','2020-01-29','3000.47','2500.89','300.32','6')
Insert Into UtilityRecord values('7','2018-12-19','1150.16','550.45','100.45','7')
Insert Into UtilityRecord values('8','2020-12-12','750.36','300.45','150.47','8')
Insert Into UtilityRecord values('9','2020-02-20','1500.02','1250.78','800.69','9')
Insert Into UtilityRecord values('10','2020-07-07','1250.36','1000.45','550.36','10')

--INSERT STATEMENTS FOR GENERALBANKRECORD
Insert Into GeneralBankRecord values('1','1288547943829008','HDFCB')
Insert Into GeneralBankRecord values('2','679900564483','SBIB')
Insert Into GeneralBankRecord values('3','900884384409','BOB')
Insert Into GeneralBankRecord values('4','7554564480041224','AXB')
Insert Into GeneralBankRecord values('5','338888700033','KMB')
Insert Into GeneralBankRecord values('6','112343438776','IIB')
Insert Into GeneralBankRecord values('7','998700554876','YB')
Insert Into GeneralBankRecord values('8','9984097775534443','PNB')
Insert Into GeneralBankRecord values('9','777658440032','BOI')
Insert Into GeneralBankRecord values('10','2243008006601122','ICICIB')

--INSERT STATEMENTS FOR BANKRECORD
Insert Into BankRecord values('HDFCB','HDFC Bank','HDFC00006457','siolim')
Insert Into BankRecord values('BOB','Bank of Baroda','BOBN00003214','Chandigarh main')
Insert Into BankRecord values('SBIB','State Bank of India' ,'SBIN00008870','Kohinoor city')
Insert Into BankRecord values('AXB','Axis Bank','UTIB00001122','Adyar')
Insert Into BankRecord values('KMB','Kotak Mahindra Bank','KKBK00000172','langford road')
Insert Into BankRecord values('IIB','Indusind Bank' ,'INDB00000030','BTS layout') 
Insert Into BankRecord values('YB','Yes Bank' ,'YESB0000008','Indapur')
Insert Into BankRecord values('PNB','Punjab National Bank','PUNB03090300','Bangur')
Insert Into BankRecord values('BOI','Bank of India','BKID00080987','Banjara Hills') 
Insert Into BankRecord values('ICICIB','ICICI Bank' ,'ICIC00000005','Behampura')

--INSERT STATEMENTS FOR CRIMINALRECORD
Insert  Into CriminalRecord values('CR08','FIR001','SEC112','Theft','1','2');
Insert  Into CriminalRecord values('CR09','FIR002','SEC724','Drunken Drive','1','2');
Insert  Into CriminalRecord values('CR10','FIR003','SEC420','Fraud','1','2');
Insert  Into CriminalRecord values('CR101','FIR021','SEC111','Murder','1','4');
Insert  Into CriminalRecord values('CR105','FIR022','SEC112','Theft','1','4');
Insert  Into CriminalRecord values('CR108','FIR023','SEC724','Drunken Drive','1','4');
Insert  Into CriminalRecord values('CR110','FIR024','SEC111','Murder','1','4');
Insert  Into CriminalRecord values('CR120','FIR025','SEC119','Money laundering','1','4');
Insert  Into CriminalRecord values('CR096','FIR004','SEC420','Fraud','1','2');
Insert  Into CriminalRecord values('CR40','FIR005','SEC900','Pickpocket','0','2');

--INSERT STATEMENTS FOR TRAVELRECORD
Insert Into TravelRecord values ('NK08','Northkorea','2017-10-20','2017-10-30','AKF842','AirTravelInsurance','1');
Insert Into TravelRecord values('UK01','UnitedKingdom','2015-06-05','2015-07-05','XYG678','SafeTravelInsurance','2');
Insert Into TravelRecord values('US98','Unitedstates','2000-01-10','2000-11-10','ASD456','SafeTravelInsurance','3');
Insert Into TravelRecord values('BR25','Brazil','1990-03-25','1990-04-27','QWE256','AirIndiaTravelInsurance','4');
Insert into TravelRecord values('PA81','Paris','2014-08-13','2014-10-10','MIK098','SafeTravelInsurance','5');
Insert Into TravelRecord values('SW55','Switzerland','2002-04-17','2002-05-01','JKL512','AirIndiaTravelInsurance','6');
Insert Into TravelRecord values('US98','Unitedstates','2008-06-09','2009-06-09','GHY710','AirIndiaTravelInsurance','7');
Insert Into TravelRecord values('SP09','Spain','1997-06-08','1997-10-01','MLK389','AirTravelInsurance','8');
Insert Into TravelRecord values('TH04','Thailand','2001-01-22','2001-02-05','KLM125','AirTravelInsurance','9');
Insert Into TravelRecord values('IR34','Ireland','1994-06-30','1994-07-10','FGY890','AirTravelInsurance','10');


--INSERT STATEMENTS FOR HEALTHRECORD
Insert Into HealthRecord values('HT01','1','18.5','A+','2017-09-15','SHN0045','StarHealth','1','Patient has NOVEL COVID 19');
Insert Into HealthRecord values('HT02','2','30.1','A-','2015-04-10','HDFCN0100','HDFCLife','0','patient is undergoing treatment for cancer');
Insert Into HealthRecord values('HT03','3','27.3','B+','2001-02-10','MCN0115','MedCare','0','Patient is sufuring from ulcer');
Insert Into HealthRecord values('HT04','4','32.3','B-','1991-04-10','MCN0007','MedCare','0','Patient has undergone openheart surgery');
Insert Into HealthRecord values('HT05','5','19.2','O+','2013-01-10','SHN0200','StarHealth','0','Patient has drinking habit');
Insert Into HealthRecord values('HT06','6','24.9','O-','2003-05-17','SBILN0050','SBILife','1','Patient has hepetitis A');
Insert Into HealthRecord values('HT07','7','33.4','AB+','2010-06-12','HDFCN0034','HDFCLife','0','Patirent has High BMI , Diabetes');
Insert Into HealthRecord values('HT08','8','29.9','AB-','1997-09-10','HDFCN0052','HDFCLife','0','Patient has very are blood group');
Insert Into HealthRecord values('HT09','9','30.0','A+','2001-01-20','SBILN0088','SBILife','0','Patient is alergic to penicillin');
Insert Into HealthRecord values('HT10','10','18.5','B+','1994-11-04','SHN0097','StarHealth','0','Patient is in Good health');

--INSERT STATEMENTS FOR GENERALCOLLGERECORD
Insert Into GeneralCollegeRecord values('1','IISC003');
Insert Into GeneralCollegeRecord values ('2','IITD089');
Insert Into GeneralCollegeRecord values ('3','IITM101');
Insert Into GeneralCollegeRecord values ('4','IITKGP12');
Insert Into GeneralCollegeRecord values ('5','IITK45');
Insert Into GeneralCollegeRecord values ('6','IISC003');
Insert Into GeneralCollegeRecord values ('7','UH003');
Insert Into GeneralCollegeRecord values ('8','IITR220');
Insert Into GeneralCollegeRecord values ('9','IITG077');
Insert Into GeneralCollegeRecord values ('10','IITB004');


--INSERT STATEMENTS FOR COLLEGERECORD
Insert Into CollegeRecord values('IISC003','Indian Institute of Science (IISC) Bangalore','12A','Bangalore','Karnataka','India','560012');
Insert Into CollegeRecord values('IITD089','Indian Institute of Technology Delhi (IITD)','15/3','Delhi','Delhi','India','110016');
Insert Into CollegeRecord values('IITM101','Indian Institute of Technology Madras (IITM)','108A','Chennai','Tamilnadu','India','600036');
Insert Into CollegeRecord values('IITKGP12','Indian Institute of Technology Kharagpur (IITKGP)','56B','Kharagpur','Westbengal','India','721302');
Insert Into CollegeRecord values('IITK45','Indian Institute of Technology Kanpur (IITK)','96R','Kanpur','Uttar Pradesh','India','208016');
Insert Into CollegeRecord values('IISC004','Indian Institute of Science (IISC) Bangalore','154/6','Bangalore','Karnataka','India','560012');
Insert Into CollegeRecord values('UH003','University of Hyderabad','56S','Hyderabad','Telengana','India','500046');
Insert Into CollegeRecord values('IITR220','Indian Institute of Technology Roorkee (IITR)','96R','Roorkee','Uttarakhand','India','800123');
Insert Into CollegeRecord values('IITG077','Indian Institute of Technology Guwahati (IITG)','32A','Guwahati','Assam','India','781039');
Insert Into CollegeRecord values('IITB004','Indian Institute of Technology Bombay (IITB)','565A','Bombay','Maharastra','India','400076');
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--TABLE LEVEL CONSTRATINT
CREATE FUNCTION restrictGoodSamaritan
(@NationID int)
RETURNS smallInt
AS 
BEGIN
	DECLARE @output smallInt =0;
	SELECT @output = COUNT(NationID)
	FROM 
	dbo.CriminalRecord
	WHERE CurrentStatus = 1 AND NationID = @NationID;
	RETURN @Output
END;


ALTER TABLE dbo.GoodSamaritanRecord ADD CONSTRAINT restrictCriminalEntry CHECK 
(dbo.restrictGoodSamaritan(NationID)=0)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--COMPUTED COLUMN
Create Function fn_Achievementcount(@NationID INT)
Returns int
As
Begin
Declare @achievecount int;
(select @achievecount=COALESCE (Count(AchievementID),0)
 FROM GoodSamaritanRecord s
JOIN GeneralRecord g
ON s.Nationid=g.Nationid
Where s.NationID= @NationID);
Return @achievecount;
END


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- VIEW - 1 (All In One View)
-- House Keeping
DROP VIEW IF EXISTS AllInOneView;
-- View Creation
CREATE VIEW AllInOneView WITH SCHEMABINDING
AS 
SELECT gr.NationID,FirstName, LastName, DateofBirth, CommunicableDiseases, MedicalCheckupDate, AchievementName, DateOfExit, 
CountryVisited, FIRNumber, CurrentStatus, CompanyName, CurrentSalary, VehicleNumber, VehicleType, PropertyValue,
Location, ElectricityConsumption,GasConsumption, WaterConsumption, BankName, AccountNumber, CollegeName,
colr.State AS CollegeState, SchoolName, sr.State AS SchoolState
FROM
dbo.GeneralRecord gr LEFT JOIN dbo.HealthRecord hr
ON gr.NationID = hr.NationID
LEFT JOIN dbo.GoodSamaritanRecord gsr
ON gr.NationID = gsr.NationID
LEFT JOIN dbo.AchievementRecord  ar
ON gsr.AchievementID = ar.AchievementID
LEFT JOIN dbo.TravelRecord tr
ON tr.NationID = gr.NationID
LEFT JOIN dbo.CriminalRecord cr
ON cr.NationID = gr.NationID
LEFT JOIN dbo.GeneralCompanyRecord gcr
ON gcr.NationID = gr.NationID
LEFT JOIN dbo.CompanyRecord com
ON com.CompanyID = gcr.CompanyID
LEFT JOIN dbo.VehicleRecord vr
ON vr.NationID = gr.NationID
LEFT JOIN dbo.PropertyDetails pd
ON pd.NationID = gr.NationID
LEFT JOIN dbo.GeneralSchoolRecord gscr
ON gscr.NationID = gr.NationID
LEFT JOIN dbo.SchoolRecord sr
ON sr.SchoolID = gscr.SchoolID
LEFT JOIN dbo.GeneralCollegeRecord gcolr
ON gcolr.NationID = gr.NationID
LEFT JOIN dbo.CollegeRecord colr
ON colr.CollegeID = gcolr.CollegeID
LEFT JOIN dbo.UtilityRecord ur
ON ur.NationID = gr.NationID
LEFT JOIN dbo.GeneralBankRecord gbr
ON gr.NationID = gbr.NationID
LEFT JOIN dbo.BankRecord br
ON br.BankID = gbr.BankID

GO
select * from AllInOneView


-- View 2 (CommunicableDiesease View)

-- House Keeping
DROP VIEW IF EXISTS CommunicableDiseasesView
-- View Creation
CREATE VIEW CommunicableDiseasesView WITH SCHEMABINDING
AS
SELECT gr.NationID, FirstName, LastName, Gender, DateOfBirth, MedicalCheckupDate,CommunicableDiseases,
CountryVisited,DateofEntry, DateofExit FROM
dbo.GeneralRecord gr LEFT JOIN dbo.HealthRecord hr
ON gr.NationID = hr.NationID
LEFT JOIN dbo.TravelRecord tr
ON gr.NationID = tr.NationID

GO
select * from CommunicableDiseasesView
