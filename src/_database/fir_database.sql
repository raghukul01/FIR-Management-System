CREATE TABLE Person(
 CNIC integer PRIMARY KEY, 
 Name varchar(255) NOT NULL, 
 Father_Name varchar(255) NOT NULL, 
 Age integer NOT NULL, 
 Address varchar(255) NOT NULL,
 DOA integer NOT NULL,
 Gender integer NOT NULL,
 check ( CNIC > 0 ),
 check (Age >= 0),
 check (Gender in (1,2,3)),
 Check (DOA in (1,2))
);

CREATE TABLE Person_Contact(
 CNIC integer NOT NULL,
 Contact integer NOT NULL,
 PRIMARY KEY (CNIC, Contact),
 FOREIGN KEY (CNIC) REFERENCES Person(CNIC), 
 check ( Contact >= 0 )
);

create table police_station
(
police_station_id integer primary key,
police_station_name varchar(255) not null,
location varchar(255) not null,
city varchar(255) not null,
head_id integer not null unique,
foreign key (head_id) references Person (CNIC),
Check (police_station_id > 0) 
);

CREATE TABLE police_station_contact
(
police_station_id integer not null,
 contact integer not null,
 PRIMARY KEY (police_station_id, contact),
 FOREIGN KEY (police_station_id) REFERENCES police_station(police_station_id), 
 check ( contact > 0 )
);


CREATE TABLE Police_Officer
(
Officer_ID integer PRIMARY KEY,
Email varchar(255) NOT NULL,
Police_Station_ID integer NOT NULL,
Officer_phone integer NOT NULL,
FOREIGN KEY (Officer_ID) REFERENCES Person(CNIC),
FOREIGN KEY (police_station_ID) REFERENCES police_station(police_station_ID)
);


CREATE TABLE PRISON
(
        Prison_ID INTEGER,
        Prison_Address varchar(265) not null,
        PRIMARY KEY(Prison_ID),
        check (Prison_ID > 0)
); 

Create table prisoner (
prisoner_no integer not null,
prisoner_id integer not null,
identification_mark varchar(255) not null,
crime_description varchar(255) not null,
prison_id integer not null,
Primary key (prisoner_no, prison_id),
foreign key (prisoner_id) references Person (CNIC),
foreign key (prison_id) references PRISON (Prison_ID), 
Check (prisoner_no > 0),
Check (prisoner_id > 0),
Check (prison_id > 0)
);

Create table prisoner_charge_sheet_no
(
prisoner_no integer not null,
prison_id integer not null,
charge_sheet_no integer not null,
Primary Key (prisoner_no, prison_id, charge_sheet_no),
Foreign Key (prisoner_no, prison_id) references prisoner (prisoner_no, prison_id),
Check (prisoner_no > 0),
Check (prison_id > 0),
Check (charge_sheet_no > 0)
);





CREATE TABLE SECTIONS 
(
        Section_ID INTEGER not null,
        Crime_Desc VARCHAR(200) not null,
        Prison_Time INTEGER not null,
        Fine INTEGER not null,
        PRIMARY KEY(Section_ID),
        check (Section_ID > 0),
        check (Prison_Time >=0),
        check (Fine >= 0)
);

CREATE TABLE FIR
(
 FIR_ID integer PRIMARY KEY,
 Date_of_Report date NOT NULL,
 Officer_ID integer NOT NULL,
 Description varchar(1000) NOT NULL,
 Complainer_ID integer NOT NULL,
 FOREIGN KEY (Officer_ID) REFERENCES Police_Officer(Officer_ID),
FOREIGN KEY (Complainer_ID) REFERENCES Person(CNIC)
);


CREATE TABLE Cases(
        Case_ID INTEGER ,
        Witness INTEGER not null,
        Court varchar(265) not null, 
        Prosecution_Lawyer_ID INTEGER not null,        
        Defence_Lawyer_ID INTEGER not null,
        Judge_ID INTEGER not null,
        Case_Status INTEGER not null,
        Section_ID INTEGER not null,
        Charge_Sheet_No INTEGER not null,
        FIR_ID INTEGER not null,
        Prisoner_ID INTEGER not null,
        PRIMARY KEY(Case_ID),
        FOREIGN KEY(Section_ID) references SECTIONS(Section_ID),
        FOREIGN KEY(Prisoner_ID) references prisoner(prisoner_id),
        FOREIGN KEY(FIR_ID) references FIR (FIR_ID),
        Check (Case_ID > 0),
        Check(Judge_ID >0),
        Check (Section_ID > 0),
        Check (Charge_Sheet_No >0),
        Check (FIR_ID >0),
        Check (Prisoner_ID >0)
);

CREATE TABLE Accused
(
 Accused_ID integer PRIMARY KEY,
 Remarks varchar(255) NULL,
 Status integer NULL,
 FOREIGN KEY (Accused_ID) REFERENCES Person(CNIC)
);

CREATE TABLE Victims_FIR
(
Victim_ID integer,
FIR_ID integer,
FOREIGN KEY (Victim_ID) REFERENCES Person(CNIC),
FOREIGN KEY (FIR_ID) REFERENCES FIR (FIR_ID),
PRIMARY KEY(Victim_ID, FIR_ID)
);
CREATE TABLE Accused_FIR
(
 Accused_ID integer not null,
FIR_ID integer not null,
 FOREIGN KEY (Accused_ID) REFERENCES Person(CNIC),
FOREIGN KEY (Accused_ID) REFERENCES Accused(Accused_ID),
FOREIGN KEY (FIR_ID) REFERENCES FIR(FIR_ID),
PRIMARY KEY(FIR_ID, Accused_ID)
);
CREATE TABLE CASE_FIR
(
CASE_ID integer not null,
FIR_ID integer not null,
FOREIGN KEY (CASE_ID) REFERENCES Cases (Case_ID),
FOREIGN KEY (FIR_ID) REFERENCES FIR(FIR_ID),
PRIMARY KEY(FIR_ID, CASE_ID)
);


CREATE TABLE Charge_Sheet
(
        Charge_Sheet_No integer PRIMARY KEY,
        Description VARCHAR(1000),
        Date date NOT NULL
);
CREATE TABLE Charge_Sheet_Sections
(
        Charge_Sheet_No integer,
        Section_ID integer,
        FOREIGN KEY (Section_ID) REFERENCES SECTIONS(Section_ID),
        FOREIGN KEY (Charge_Sheet_No) REFERENCES Charge_Sheet(Charge_Sheet_No),
        PRIMARY KEY (Charge_Sheet_No, Section_ID)
);









INSERT INTO Person Values(10001,'Abhinav Shukla','Vibhor',20,'Kalyanpur,Kanpur',2,1);
INSERT INTO Person Values(10002,'Raghukul Raman','Vibhor',20,'Jaipur',2,1);
INSERT INTO Person Values(10003,'Rhaegar Targaryen','Mad King',40,'Kings Landing',1,1);
INSERT INTO Person Values(10004,'Lyanna Stark','some stark',39,'Winterfell',1,2);
INSERT INTO Person Values(10005,'Aegon Targaryen','Rhaegar Targaryen',29,'Winterfell',2,1);
INSERT INTO Person Values(10006,'Arya Stark','Ned stark',18,'Winterfell',2,2);


