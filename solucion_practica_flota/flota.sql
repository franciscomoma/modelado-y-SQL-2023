create schema flota;

create table flota.aseguradora(
	id serial primary key,
	nombre varchar(80) not null
);

create table flota.poliza(
	id serial primary key,
	id_aseguradora smallint not null,
	matricula varchar(10) not null,
	fecha_alta date not null,
	en_vigor boolean not null
);

create table flota.vehiculo(
	matricula VARCHAR(10) primary key,
	km int not null,
	fecha_compra date not null,
	id_modelo int not null,
	id_color int not null
);

create table flota.revision(
	id serial primary key,
	matricula varchar(10) not null,
	id_moneda smallint not null,
	km int not null,
	fecha_revision date not null,
	importe float not null
);

create table flota.moneda(
	id serial primary key,
	nombre varchar(50) not null
);

create table flota.color(
	id serial primary key,
	nombre varchar(50) not null
);

create table flota.grupo(
	id serial primary key,
	nombre varchar(80) not null
);

create table flota.marca(
	id serial primary key,
	id_grupo int not null,
	nombre varchar(80) not null
);

create table flota.modelo(
	id serial primary key,
	id_marca int not null,
	nombre varchar(80) not null
);

alter table flota.poliza add constraint fk_poliza_aseguradora foreign key (id_aseguradora) references flota.aseguradora(id);
alter table flota.poliza add constraint fk_poliza_vehiculo foreign key (matricula) references flota.vehiculo(matricula);

alter table flota.marca add constraint fk_marca_grupo foreign key (id_grupo) references flota.grupo(id);

alter table flota.modelo add constraint fk_modelo_marca foreign key (id_marca) references flota.marca(id);

alter table flota.vehiculo add constraint fk_vehiculo_modelo foreign key (id_modelo) references flota.modelo(id);
alter table flota.vehiculo add constraint fk_vehiculo_color foreign key (id_color) references flota.color(id);

alter table flota.revision add constraint fk_revision_vehiculo foreign key (matricula) references flota.vehiculo(matricula);
alter table flota.revision add constraint fk_revision_moneda foreign key (id_moneda) references flota.moneda(id);

CREATE TABLE flota.tmp_coches (
	matricula varchar(50) NULL,
	grupo varchar(50) NULL,
	marca varchar(50) NULL,
	modelo varchar(50) NULL,
	fecha_compra date NULL,
	color varchar(50) NULL,
	aseguradora varchar(50) NULL,
	n_poliza int4 NULL,
	fecha_alta_seguro date NULL,
	importe_revision float4 NULL,
	moneda varchar(50) NULL,
	kms_revision int4 NULL,
	fecha_revision date NULL,
	kms_totales int4 NULL
);

INSERT INTO flota.tmp_coches (matricula,grupo,marca,modelo,fecha_compra,color,aseguradora,n_poliza,fecha_alta_seguro,importe_revision,moneda,kms_revision,fecha_revision,kms_totales) VALUES
	 ('7343FRT','Renault-Nissan-Mitsubishi Alliance','Renault','Clio','2009-06-01','Rojo','Allianz',25786,'2009-06-01',1076032.5,'Peso Colombiano',29564,'2020-07-07',47644),
	 ('2438GSV','PSA Peugeot S.A.','Citroën','DS4','2010-04-17','Gris Plateado','Allianz',195443,'2010-04-17',734.7,'Dólar',12028,'2010-05-13',52349),
	 ('2438GSV','PSA Peugeot S.A.','Citroën','DS4','2010-04-17','Gris Plateado','Axa',110761,'2011-08-23',460.0,'Euro',28312,'2016-05-17',52349),
	 ('9666FZC','Renault-Nissan-Mitsubishi Alliance','Nissan','Leaf','2008-03-03','Blanco','Allianz',79841,'2008-03-03',344330.4,'Peso Colombiano',19543,'2017-12-13',39533),
	 ('7221BJG','Hyundai Motor Group','Kia','Ceed','1999-09-30','Blanco','Allianz',112320,'1999-09-30',1162115.1,'Peso Colombiano',12066,'2000-05-18',70197),
	 ('7221BJG','Hyundai Motor Group','Kia','Ceed','1999-09-30','Blanco','Mapfre',135515,'2001-04-05',800.0,'Euro',41764,'2008-05-24',70197),
	 ('6756GXW','PSA Peugeot S.A.','Peugeot','206','2011-07-19','Negro','Mapfre',142266,'2011-07-19',3615469.2,'Peso Colombiano',21955,'2012-01-19',112881),
	 ('6756GXW','PSA Peugeot S.A.','Peugeot','206','2011-07-19','Negro','Mapfre',142266,'2011-07-19',697.5,'Dólar',50738,'2012-04-02',112881),
	 ('6756GXW','PSA Peugeot S.A.','Peugeot','206','2011-07-19','Negro','Mapfre',142266,'2011-07-19',11869.2,'Peso Mexicano',74499,'2012-06-28',112881),
	 ('6756GXW','PSA Peugeot S.A.','Peugeot','206','2011-07-19','Negro','Generali',159753,'2012-10-22',3579.6,'Peso Mexicano',94670,'2013-06-24',112881),
	 ('9314JHS','Renault-Nissan-Mitsubishi Alliance','Nissan','Qashqai','2017-10-10','Negro','Allianz',67577,'2017-10-10',14695.2,'Peso Mexicano',24441,'2019-09-04',41064),
	 ('7987FXL','Hyundai Motor Group','Kia','Rio','2009-01-23','Blanco','Generali',32844,'2009-01-23',730.0,'Euro',11140,'2021-12-04',24726),
	 ('4325KMF','PSA Peugeot S.A.','Citroën','DS4','2020-04-13','Blanco','Mapfre',12534,'2020-04-13',7912.8,'Peso Mexicano',20410,'2022-07-08',49476),
	 ('3883DSH','Renault-Nissan-Mitsubishi Alliance','Renault','Clio','2007-02-27','Blanco','Mapfre',54632,'2007-02-27',570.0,'Euro',19245,'2014-05-16',35949),
	 ('3242GQG','Renault-Nissan-Mitsubishi Alliance','Renault','Megane','2013-03-06','Rojo','Mapfre',183813,'2013-03-06',120.9,'Dólar',16209,'2014-02-10',77662),
	 ('3242GQG','Renault-Nissan-Mitsubishi Alliance','Renault','Megane','2013-03-06','Rojo','Mapfre',183813,'2013-03-06',80.0,'Euro',27845,'2014-04-27',77662),
	 ('3242GQG','Renault-Nissan-Mitsubishi Alliance','Renault','Megane','2013-03-06','Rojo','Mapfre',183813,'2013-03-06',1695.6,'Peso Mexicano',38072,'2014-06-07',77662),
	 ('3242GQG','Renault-Nissan-Mitsubishi Alliance','Renault','Megane','2013-03-06','Rojo','Generali',187526,'2014-07-14',16767.6,'Peso Mexicano',49153,'2021-11-30',77662),
	 ('4315JKL','Renault-Nissan-Mitsubishi Alliance','Dacia','Duster','2017-08-27','Gris Plateado','Mapfre',9482,'2017-08-27',15825.6,'Peso Mexicano',20263,'2017-11-02',46145),
	 ('5426HDG','Hyundai Motor Group','Kia','Ceed','2015-04-01','Negro','Axa',144573,'2015-04-01',437.1,'Dólar',16879,'2015-09-27',46759),
	 ('5426HDG','Hyundai Motor Group','Kia','Ceed','2015-04-01','Negro','Generali',186297,'2016-08-24',2883767.0,'Peso Colombiano',34964,'2019-08-24',46759),
	 ('6231KKQ','Renault-Nissan-Mitsubishi Alliance','Dacia','Duster','2019-04-10','Rojo','Allianz',34218,'2019-04-10',632.4,'Dólar',13755,'2021-04-04',39563),
	 ('7457BFT','Renault-Nissan-Mitsubishi Alliance','Nissan','Qashqai','2000-11-24','Negro','Mapfre',35103,'2000-11-24',90.0,'Euro',16226,'2018-09-24',39949),
	 ('5205DFJ','Hyundai Motor Group','Kia','Ceed','2006-03-04','Gris Plateado','Allianz',41930,'2006-03-04',14883.6,'Peso Mexicano',23043,'2022-05-24',50972),
	 ('3212HJW','Hyundai Motor Group','Kia','Rio','2014-08-04','Gris Plateado','Axa',117277,'2015-12-19',170.0,'Euro',14526,'2023-04-14',28986),
	 ('3313GGW','PSA Peugeot S.A.','Citroën','DS4','2013-04-01','Rojo','Mapfre',85225,'2013-04-01',1884.0,'Peso Mexicano',17187,'2017-12-13',35823),
	 ('6642GZP','Hyundai Motor Group','Hyundai','Tucson','2010-04-21','Verde','Mapfre',151249,'2010-04-21',3228097.5,'Peso Colombiano',21563,'2011-01-06',97183),
	 ('6642GZP','Hyundai Motor Group','Hyundai','Tucson','2010-04-21','Verde','Mapfre',151249,'2010-04-21',83.7,'Dólar',49405,'2011-05-04',97183),
	 ('6642GZP','Hyundai Motor Group','Hyundai','Tucson','2010-04-21','Verde','Axa',169829,'2011-12-01',1507.2,'Peso Mexicano',69454,'2023-03-11',97183),
	 ('3306GYM','Renault-Nissan-Mitsubishi Alliance','Nissan','Leaf','2011-12-19','Verde','Generali',174969,'2011-12-19',1463404.2,'Peso Colombiano',18060,'2012-04-17',76024),
	 ('3306GYM','Renault-Nissan-Mitsubishi Alliance','Nissan','Leaf','2011-12-19','Verde','Generali',174969,'2011-12-19',16767.6,'Peso Mexicano',37513,'2013-01-10',76024),
	 ('3306GYM','Renault-Nissan-Mitsubishi Alliance','Nissan','Leaf','2011-12-19','Verde','Axa',173030,'2013-02-18',14883.6,'Peso Mexicano',58378,'2019-06-16',76024),
	 ('5303DCG','PSA Peugeot S.A.','Citroën','DS4','2007-08-30','Gris Plateado','Allianz',79203,'2007-08-30',11492.4,'Peso Mexicano',14181,'2022-05-31',35530),
	 ('0827DBB','Renault-Nissan-Mitsubishi Alliance','Renault','Megane','2006-07-24','Gris Plateado','Generali',40647,'2006-07-24',325.5,'Dólar',24407,'2019-02-23',39061),
	 ('5047FJK','PSA Peugeot S.A.','Citroën','DS4','2009-10-26','Blanco','Mapfre',172625,'2009-10-26',5086.8,'Peso Mexicano',18053,'2010-02-22',90641),
	 ('5047FJK','PSA Peugeot S.A.','Citroën','DS4','2009-10-26','Blanco','Mapfre',172625,'2009-10-26',399.9,'Dólar',40390,'2010-05-03',90641),
	 ('5047FJK','PSA Peugeot S.A.','Citroën','DS4','2009-10-26','Blanco','Mapfre',161701,'2010-10-16',2324230.2,'Peso Colombiano',63099,'2010-12-08',90641),
	 ('4366GZX','Hyundai Motor Group','Hyundai','Tucson','2013-11-03','Verde','Axa',40977,'2013-11-03',306.9,'Dólar',21132,'2017-08-27',44510),
	 ('7561CND','Hyundai Motor Group','Hyundai','i30','2004-09-22','Blanco','Mapfre',170914,'2004-09-22',12622.8,'Peso Mexicano',13171,'2006-01-18',71901),
	 ('7561CND','Hyundai Motor Group','Hyundai','i30','2004-09-22','Blanco','Mapfre',170914,'2004-09-22',2926808.5,'Peso Colombiano',29474,'2006-02-27',71901),
	 ('7561CND','Hyundai Motor Group','Hyundai','i30','2004-09-22','Blanco','Mapfre',172754,'2006-03-23',74.4,'Dólar',42110,'2021-04-19',71901),
	 ('5954DWX','Renault-Nissan-Mitsubishi Alliance','Nissan','Qashqai','2007-10-25','Negro','Allianz',121919,'2008-08-21',440.0,'Euro',25110,'2016-05-30',39775),
	 ('9157JVM','PSA Peugeot S.A.','Citroën','Berlingo','2017-09-18','Blanco','Allianz',96770,'2017-09-18',390.6,'Dólar',21421,'2020-12-29',41539),
	 ('0366CKQ','PSA Peugeot S.A.','Peugeot','5008','2003-04-10','Gris Plateado','Axa',172546,'2003-04-10',13941.6,'Peso Mexicano',24801,'2003-04-28',118687),
	 ('0366CKQ','PSA Peugeot S.A.','Peugeot','5008','2003-04-10','Gris Plateado','Axa',172546,'2003-04-10',590.0,'Euro',51615,'2003-07-26',118687),
	 ('0366CKQ','PSA Peugeot S.A.','Peugeot','5008','2003-04-10','Gris Plateado','Axa',172546,'2003-04-10',83.7,'Dólar',74997,'2004-04-27',118687),
	 ('0366CKQ','PSA Peugeot S.A.','Peugeot','5008','2003-04-10','Gris Plateado','Allianz',111429,'2004-05-29',548.7,'Dólar',90943,'2009-06-04',118687),
	 ('2907GNT','Hyundai Motor Group','Hyundai','i30','2012-11-08','Negro','Mapfre',92532,'2012-11-08',753.3,'Dólar',25366,'2016-03-09',51508),
	 ('2428HYB','Renault-Nissan-Mitsubishi Alliance','Renault','Megane','2014-12-04','Verde','Generali',181054,'2014-12-04',269.7,'Dólar',17526,'2014-12-09',87006),
	 ('2428HYB','Renault-Nissan-Mitsubishi Alliance','Renault','Megane','2014-12-04','Verde','Generali',181054,'2014-12-04',610.0,'Euro',40875,'2015-09-05',87006),
	 ('2428HYB','Renault-Nissan-Mitsubishi Alliance','Renault','Megane','2014-12-04','Verde','Generali',181054,'2014-12-04',290.0,'Euro',59896,'2015-09-23',87006),
	 ('2428HYB','Renault-Nissan-Mitsubishi Alliance','Renault','Megane','2014-12-04','Verde','Axa',161471,'2015-10-15',399.9,'Dólar',72001,'2016-05-24',87006),
	 ('6743DYG','Hyundai Motor Group','Kia','Rio','2007-06-25','Gris Plateado','Axa',116336,'2007-06-25',8101.2,'Peso Mexicano',22761,'2008-01-13',76387),
	 ('6743DYG','Hyundai Motor Group','Kia','Rio','2007-06-25','Gris Plateado','Axa',116336,'2007-06-25',9608.4,'Peso Mexicano',34009,'2008-03-17',76387),
	 ('6743DYG','Hyundai Motor Group','Kia','Rio','2007-06-25','Gris Plateado','Mapfre',116398,'2008-09-16',450.0,'Euro',60377,'2012-11-14',76387),
	 ('8706FTV','Hyundai Motor Group','Hyundai','Tucson','2008-05-16','Verde','Mapfre',91503,'2008-05-16',3658510.5,'Peso Colombiano',25843,'2011-12-07',53733),
	 ('1567JPK','Hyundai Motor Group','Kia','Ceed','2016-12-03','Gris Plateado','Generali',19347,'2016-12-03',301289.1,'Peso Colombiano',28259,'2017-05-12',54278),
	 ('8802GQX','Renault-Nissan-Mitsubishi Alliance','Dacia','Duster','2013-04-23','Blanco','Generali',167291,'2014-05-02',820.0,'Euro',22523,'2015-06-15',34941),
	 ('0922JVF','PSA Peugeot S.A.','Peugeot','5008','2017-07-06','Negro','Mapfre',104210,'2017-07-06',602578.2,'Peso Colombiano',25300,'2018-11-25',97321),
	 ('0922JVF','PSA Peugeot S.A.','Peugeot','5008','2017-07-06','Negro','Mapfre',104210,'2017-07-06',6594.0,'Peso Mexicano',49167,'2018-12-06',97321),
	 ('0922JVF','PSA Peugeot S.A.','Peugeot','5008','2017-07-06','Negro','Mapfre',182094,'2019-01-02',8478.0,'Peso Mexicano',76863,'2023-05-08',97321),
	 ('5022JZD','Hyundai Motor Group','Hyundai','i30','2016-03-07','Verde','Mapfre',173686,'2016-03-07',430413.0,'Peso Colombiano',11715,'2016-05-13',63426),
	 ('5022JZD','Hyundai Motor Group','Hyundai','i30','2016-03-07','Verde','Axa',191842,'2017-08-09',539.4,'Dólar',35020,'2021-04-19',63426),
	 ('8177JPM','Renault-Nissan-Mitsubishi Alliance','Renault','Clio','2016-11-27','Gris Plateado','Allianz',119373,'2016-11-27',1678610.8,'Peso Colombiano',19822,'2017-01-24',77082),
	 ('8177JPM','Renault-Nissan-Mitsubishi Alliance','Renault','Clio','2016-11-27','Gris Plateado','Allianz',119373,'2016-11-27',483.6,'Dólar',41924,'2017-11-25',77082),
	 ('8177JPM','Renault-Nissan-Mitsubishi Alliance','Renault','Clio','2016-11-27','Gris Plateado','Mapfre',192389,'2018-04-19',387371.7,'Peso Colombiano',57202,'2021-05-04',77082),
	 ('8627FRY','Hyundai Motor Group','Hyundai','Tucson','2008-04-02','Blanco','Mapfre',51353,'2008-04-02',120.9,'Dólar',16181,'2020-04-28',30083),
	 ('7938HXH','Hyundai Motor Group','Hyundai','Tucson','2015-10-24','Gris Plateado','Mapfre',163498,'2015-10-24',186.0,'Dólar',20157,'2016-09-08',53342),
	 ('7938HXH','Hyundai Motor Group','Hyundai','Tucson','2015-10-24','Gris Plateado','Axa',105002,'2016-10-04',590.0,'Euro',34833,'2017-10-23',53342),
	 ('3230KTX','Renault-Nissan-Mitsubishi Alliance','Nissan','Qashqai','2019-04-16','Negro','Generali',146739,'2019-04-16',4898.4,'Peso Mexicano',25879,'2019-05-13',69200),
	 ('3230KTX','Renault-Nissan-Mitsubishi Alliance','Nissan','Qashqai','2019-04-16','Negro','Axa',127909,'2020-09-18',688.2,'Dólar',44068,'2023-02-02',69200),
	 ('7710HMZ','PSA Peugeot S.A.','Peugeot','206','2014-04-09','Verde','Allianz',190446,'2015-09-03',3391.2,'Peso Mexicano',22300,'2022-08-28',45773),
	 ('4221JXR','Hyundai Motor Group','Kia','Rio','2018-03-19','Azul','Generali',174298,'2018-03-19',50.0,'Euro',18380,'2018-06-08',50166),
	 ('4221JXR','Hyundai Motor Group','Kia','Rio','2018-03-19','Azul','Generali',109846,'2019-03-11',204.6,'Dólar',38809,'2022-05-22',50166),
	 ('3272JJJ','Hyundai Motor Group','Kia','Rio','2018-06-03','Verde','Mapfre',89739,'2018-06-03',210.0,'Euro',11209,'2022-10-04',27503),
	 ('2633GJF','PSA Peugeot S.A.','Peugeot','206','2011-02-19','Rojo','Mapfre',124027,'2012-04-19',3055932.2,'Peso Colombiano',25614,'2023-07-13',41129),
	 ('5648JTZ','Hyundai Motor Group','Kia','Ceed','2016-04-14','Verde','Allianz',189152,'2016-04-14',16390.8,'Peso Mexicano',22988,'2017-11-12',61124),
	 ('5648JTZ','Hyundai Motor Group','Kia','Ceed','2016-04-14','Verde','Axa',117439,'2017-11-21',946908.6,'Peso Colombiano',47336,'2019-06-20',61124),
	 ('1621CSY','PSA Peugeot S.A.','Citroën','DS4','2004-10-12','Rojo','Mapfre',89394,'2004-10-12',4898.4,'Peso Mexicano',29407,'2022-08-18',42218),
	 ('9428BCQ','Hyundai Motor Group','Kia','Ceed','2002-11-12','Verde','Allianz',96367,'2002-11-12',16956.0,'Peso Mexicano',14720,'2022-05-03',33451),
	 ('9412DTS','PSA Peugeot S.A.','Citroën','DS4','2007-01-31','Negro','Generali',82043,'2007-01-31',46.5,'Dólar',24707,'2015-05-30',54013),
	 ('9729KXJ','Renault-Nissan-Mitsubishi Alliance','Renault','Megane','2020-09-06','Verde','Allianz',184039,'2020-09-06',110.0,'Euro',14348,'2020-10-11',76972),
	 ('9729KXJ','Renault-Nissan-Mitsubishi Alliance','Renault','Megane','2020-09-06','Verde','Allianz',184039,'2020-09-06',632.4,'Dólar',36512,'2021-09-13',76972),
	 ('9729KXJ','Renault-Nissan-Mitsubishi Alliance','Renault','Megane','2020-09-06','Verde','Generali',131978,'2021-12-21',3873717.0,'Peso Colombiano',52881,'2022-04-12',76972),
	 ('2890DSR','Hyundai Motor Group','Kia','Ceed','2006-07-13','Gris Plateado','Allianz',16848,'2006-07-13',213.9,'Dólar',13864,'2014-07-23',28530),
	 ('2066BYF','PSA Peugeot S.A.','Citroën','Berlingo','1999-03-14','Gris Plateado','Axa',105112,'1999-03-14',1162115.1,'Peso Colombiano',14097,'1999-09-04',57697),
	 ('2066BYF','PSA Peugeot S.A.','Citroën','Berlingo','1999-03-14','Gris Plateado','Generali',126373,'2000-01-12',559536.9,'Peso Colombiano',28378,'2014-05-14',57697),
	 ('7466DMG','Renault-Nissan-Mitsubishi Alliance','Renault','Clio','2007-03-31','Gris Plateado','Allianz',145462,'2007-03-31',200.0,'Euro',19536,'2007-06-16',85722),
	 ('7466DMG','Renault-Nissan-Mitsubishi Alliance','Renault','Clio','2007-03-31','Gris Plateado','Allianz',145462,'2007-03-31',325.5,'Dólar',39863,'2007-09-26',85722),
	 ('7466DMG','Renault-Nissan-Mitsubishi Alliance','Renault','Clio','2007-03-31','Gris Plateado','Allianz',190418,'2008-05-10',270.0,'Euro',56109,'2018-10-08',85722),
	 ('0390DRK','PSA Peugeot S.A.','Citroën','DS4','2007-03-27','Verde','Axa',121129,'2008-05-01',6594.0,'Peso Mexicano',22339,'2015-12-01',38651),
	 ('6850KZW','Hyundai Motor Group','Kia','Ceed','2020-05-11','Blanco','Mapfre',66942,'2020-05-11',10173.6,'Peso Mexicano',15206,'2023-03-05',25227),
	 ('3960JYB','Renault-Nissan-Mitsubishi Alliance','Renault','Kangoo','2017-09-15','Negro','Mapfre',8307,'2017-09-15',158.1,'Dólar',17211,'2018-08-22',30810),
	 ('9209KGR','PSA Peugeot S.A.','Peugeot','5008','2020-03-02','Rojo','Generali',174043,'2020-03-02',2637.6,'Peso Mexicano',12808,'2021-08-15',58260),
	 ('9209KGR','PSA Peugeot S.A.','Peugeot','5008','2020-03-02','Rojo','Axa',118686,'2021-09-02',210.0,'Euro',31259,'2023-08-16',58260),
	 ('1323DQL','Renault-Nissan-Mitsubishi Alliance','Renault','Kangoo','2006-01-22','Negro','Mapfre',172309,'2006-01-22',3012891.0,'Peso Colombiano',26924,'2006-02-11',107492),
	 ('1323DQL','Renault-Nissan-Mitsubishi Alliance','Renault','Kangoo','2006-01-22','Negro','Mapfre',172309,'2006-01-22',590.0,'Euro',49644,'2006-12-02',107492),
	 ('1323DQL','Renault-Nissan-Mitsubishi Alliance','Renault','Kangoo','2006-01-22','Negro','Mapfre',172309,'2006-01-22',3701551.8,'Peso Colombiano',62371,'2007-01-03',107492),
	 ('1323DQL','Renault-Nissan-Mitsubishi Alliance','Renault','Kangoo','2006-01-22','Negro','Generali',176268,'2007-01-07',3572428.0,'Peso Colombiano',90278,'2007-11-23',107492),
	 ('2684FZV','PSA Peugeot S.A.','Citroën','DS4','2008-05-10','Negro','Mapfre',50387,'2008-05-10',455.7,'Dólar',17713,'2008-06-07',36859);
INSERT INTO flota.tmp_coches (matricula,grupo,marca,modelo,fecha_compra,color,aseguradora,n_poliza,fecha_alta_seguro,importe_revision,moneda,kms_revision,fecha_revision,kms_totales) VALUES
	 ('6010JXB','Hyundai Motor Group','Kia','Ceed','2017-06-30','Negro','Mapfre',117329,'2018-06-05',8854.8,'Peso Mexicano',19345,'2018-07-09',46520),
	 ('9281BNK','Hyundai Motor Group','Hyundai','Tucson','2002-04-06','Gris Plateado','Mapfre',88106,'2002-04-06',9043.2,'Peso Mexicano',15082,'2003-10-06',35517),
	 ('0393DWY','PSA Peugeot S.A.','Peugeot','5008','2007-08-02','Rojo','Allianz',73097,'2007-08-02',50.0,'Euro',22765,'2020-02-03',41340),
	 ('7792CKF','Hyundai Motor Group','Hyundai','Tucson','2003-03-02','Verde','Allianz',139949,'2003-03-02',560.0,'Euro',16746,'2003-05-06',59984),
	 ('7792CKF','Hyundai Motor Group','Hyundai','Tucson','2003-03-02','Verde','Mapfre',126578,'2004-01-30',3830675.8,'Peso Colombiano',37787,'2009-05-25',59984),
	 ('7905HMT','Hyundai Motor Group','Hyundai','i30','2015-10-31','Azul','Axa',56264,'2015-10-31',590.0,'Euro',11937,'2020-07-14',38622),
	 ('3274CYM','Renault-Nissan-Mitsubishi Alliance','Nissan','Qashqai','2004-03-13','Negro','Axa',39780,'2004-03-13',11869.2,'Peso Mexicano',17619,'2022-04-15',31210),
	 ('5751FCL','Hyundai Motor Group','Kia','Ceed','2008-07-30','Rojo','Allianz',4341,'2008-07-30',446.4,'Dólar',16314,'2010-08-06',40662),
	 ('9775BVC','Hyundai Motor Group','Hyundai','i30','2001-03-14','Gris Plateado','Generali',64092,'2001-03-14',1936858.5,'Peso Colombiano',11436,'2001-04-27',29962),
	 ('3122DZN','Renault-Nissan-Mitsubishi Alliance','Dacia','Duster','2007-12-01','Blanco','Axa',113718,'2008-11-19',16202.4,'Peso Mexicano',27367,'2022-05-06',50250),
	 ('7295DHG','Renault-Nissan-Mitsubishi Alliance','Nissan','Leaf','2006-10-17','Azul','Mapfre',55403,'2006-10-17',850.0,'Euro',20272,'2009-06-01',34938),
	 ('2874BRD','Hyundai Motor Group','Hyundai','i30','2000-10-01','Azul','Mapfre',115392,'2002-01-17',232.5,'Dólar',27678,'2021-12-22',46794),
	 ('8718CJT','Renault-Nissan-Mitsubishi Alliance','Nissan','Qashqai','2005-08-23','Negro','Allianz',20640,'2005-08-23',460.0,'Euro',25928,'2005-09-11',46682),
	 ('8563JCM','Renault-Nissan-Mitsubishi Alliance','Nissan','Leaf','2017-10-11','Azul','Mapfre',84213,'2017-10-11',720.0,'Euro',17322,'2018-05-24',45745),
	 ('6640FPQ','PSA Peugeot S.A.','Peugeot','5008','2008-02-12','Azul','Axa',85627,'2008-02-12',350.0,'Euro',14565,'2022-10-14',38454),
	 ('6788DRX','Hyundai Motor Group','Hyundai','i30','2007-11-15','Blanco','Axa',7094,'2007-11-15',840.0,'Euro',15306,'2015-12-29',36066),
	 ('2430FDP','PSA Peugeot S.A.','Citroën','Berlingo','2008-06-23','Negro','Generali',118284,'2008-06-23',530.0,'Euro',29114,'2009-07-10',91570),
	 ('2430FDP','PSA Peugeot S.A.','Citroën','Berlingo','2008-06-23','Negro','Generali',118284,'2008-06-23',3228097.5,'Peso Colombiano',53723,'2009-08-21',91570),
	 ('2430FDP','PSA Peugeot S.A.','Citroën','Berlingo','2008-06-23','Negro','Generali',137325,'2009-10-14',770.0,'Euro',66643,'2011-11-06',91570),
	 ('5851CSB','Hyundai Motor Group','Hyundai','i30','2004-06-21','Gris Plateado','Generali',73547,'2004-06-21',780.0,'Euro',20756,'2011-03-09',39717),
	 ('6708BTB','Renault-Nissan-Mitsubishi Alliance','Renault','Kangoo','2001-07-17','Rojo','Generali',124038,'2002-12-12',7347.6,'Peso Mexicano',27720,'2007-01-18',44027),
	 ('4916HJG','Renault-Nissan-Mitsubishi Alliance','Nissan','Qashqai','2015-03-29','Azul','Axa',136600,'2015-03-29',100.0,'Euro',17802,'2015-12-22',64638),
	 ('4916HJG','Renault-Nissan-Mitsubishi Alliance','Nissan','Qashqai','2015-03-29','Azul','Axa',136600,'2015-03-29',516495.6,'Peso Colombiano',28533,'2015-12-27',64638),
	 ('4916HJG','Renault-Nissan-Mitsubishi Alliance','Nissan','Qashqai','2015-03-29','Azul','Allianz',163789,'2016-01-31',46.5,'Dólar',39243,'2023-08-26',64638),
	 ('5899CLW','Hyundai Motor Group','Hyundai','Tucson','2003-03-02','Verde','Allianz',187586,'2004-05-18',2109023.8,'Peso Colombiano',18724,'2013-09-10',35922),
	 ('6016FWX','Renault-Nissan-Mitsubishi Alliance','Dacia','Lodgy','2008-04-29','Gris Plateado','Mapfre',54681,'2008-04-29',817784.7,'Peso Colombiano',15657,'2014-02-25',27713),
	 ('0007HHR','Hyundai Motor Group','Kia','Rio','2014-03-30','Verde','Allianz',131987,'2015-10-03',817784.7,'Peso Colombiano',23034,'2021-02-22',37686),
	 ('8540DXG','Hyundai Motor Group','Hyundai','Tucson','2007-03-13','Gris Plateado','Axa',71232,'2007-03-13',530.1,'Dólar',15249,'2014-01-12',27722),
	 ('6335BFK','Renault-Nissan-Mitsubishi Alliance','Dacia','Duster','1999-06-06','Verde','Axa',190383,'1999-06-06',9985.2,'Peso Mexicano',19109,'1999-09-27',53657),
	 ('6335BFK','Renault-Nissan-Mitsubishi Alliance','Dacia','Duster','1999-06-06','Verde','Allianz',177717,'2000-05-01',279.0,'Dólar',34682,'2009-04-14',53657),
	 ('3187KKM','Hyundai Motor Group','Hyundai','i30','2019-01-14','Rojo','Generali',196487,'2019-01-14',602578.2,'Peso Colombiano',20293,'2019-12-20',69946),
	 ('3187KKM','Hyundai Motor Group','Hyundai','i30','2019-01-14','Rojo','Generali',196487,'2019-01-14',1979899.8,'Peso Colombiano',33325,'2020-01-25',69946),
	 ('3187KKM','Hyundai Motor Group','Hyundai','i30','2019-01-14','Rojo','Allianz',189761,'2020-08-03',14318.4,'Peso Mexicano',43580,'2021-01-15',69946),
	 ('7631GCM','PSA Peugeot S.A.','Citroën','DS4','2011-09-17','Negro','Allianz',63946,'2011-09-17',830.0,'Euro',15837,'2021-11-16',31372),
	 ('9024CVP','Renault-Nissan-Mitsubishi Alliance','Nissan','Qashqai','2004-01-15','Verde','Allianz',62061,'2004-01-15',2668560.5,'Peso Colombiano',13470,'2014-03-18',25161),
	 ('4761CVL','Hyundai Motor Group','Hyundai','Tucson','2003-04-08','Rojo','Allianz',94565,'2003-04-08',2109023.8,'Peso Colombiano',21369,'2016-08-16',35224),
	 ('7489HBJ','Renault-Nissan-Mitsubishi Alliance','Renault','Kangoo','2014-10-11','Rojo','Axa',82585,'2014-10-11',316.2,'Dólar',22207,'2019-08-02',37783),
	 ('5188DWK','Hyundai Motor Group','Hyundai','i30','2007-12-07','Azul','Axa',161477,'2007-12-07',3572428.0,'Peso Colombiano',23426,'2008-06-16',74494),
	 ('5188DWK','Hyundai Motor Group','Hyundai','i30','2007-12-07','Azul','Axa',161477,'2007-12-07',670.0,'Euro',37800,'2008-09-25',74494),
	 ('5188DWK','Hyundai Motor Group','Hyundai','i30','2007-12-07','Azul','Generali',157749,'2009-03-12',4898.4,'Peso Mexicano',60028,'2023-08-20',74494),
	 ('7764GTD','Hyundai Motor Group','Hyundai','Tucson','2012-10-01','Verde','Generali',125045,'2012-10-01',510.0,'Euro',16201,'2013-10-25',54522),
	 ('7764GTD','Hyundai Motor Group','Hyundai','Tucson','2012-10-01','Verde','Allianz',136882,'2014-01-28',1162115.1,'Peso Colombiano',39865,'2015-03-30',54522),
	 ('7136BCS','PSA Peugeot S.A.','Peugeot','206','2001-02-09','Blanco','Generali',6062,'2001-02-09',595.2,'Dólar',22625,'2003-10-29',43363),
	 ('2835JQN','Renault-Nissan-Mitsubishi Alliance','Renault','Kangoo','2016-11-16','Rojo','Allianz',144448,'2016-11-16',1695.6,'Peso Mexicano',18893,'2018-05-05',61510),
	 ('2835JQN','Renault-Nissan-Mitsubishi Alliance','Renault','Kangoo','2016-11-16','Rojo','Allianz',108872,'2018-05-12',669.6,'Dólar',45588,'2021-08-01',61510),
	 ('4896HCC','Renault-Nissan-Mitsubishi Alliance','Nissan','Qashqai','2014-05-19','Negro','Generali',8576,'2014-05-19',7536.0,'Peso Mexicano',27814,'2020-05-01',45887),
	 ('5865JKB','Hyundai Motor Group','Hyundai','Tucson','2016-01-24','Azul','Axa',86600,'2016-01-24',620.0,'Euro',11276,'2016-07-17',30495),
	 ('8926GPQ','Renault-Nissan-Mitsubishi Alliance','Dacia','Duster','2012-09-29','Blanco','Allianz',26976,'2012-09-29',330.0,'Euro',25569,'2016-11-01',42989),
	 ('7224FDF','PSA Peugeot S.A.','Peugeot','5008','2008-04-29','Negro','Mapfre',48113,'2008-04-29',3228097.5,'Peso Colombiano',16890,'2008-11-20',28796),
	 ('1970BLH','Renault-Nissan-Mitsubishi Alliance','Nissan','Leaf','2002-04-18','Rojo','Generali',102441,'2003-03-27',2238147.5,'Peso Colombiano',21660,'2010-04-07',47354),
	 ('8217BCW','PSA Peugeot S.A.','Citroën','DS4','2001-12-18','Rojo','Mapfre',194490,'2003-07-13',620.0,'Euro',25009,'2020-05-08',43385),
	 ('0326HRM','PSA Peugeot S.A.','Peugeot','5008','2014-06-28','Gris Plateado','Axa',179156,'2014-06-28',827.7,'Dólar',20625,'2015-05-30',105374),
	 ('0326HRM','PSA Peugeot S.A.','Peugeot','5008','2014-06-28','Gris Plateado','Axa',179156,'2014-06-28',548.7,'Dólar',46451,'2015-06-11',105374),
	 ('0326HRM','PSA Peugeot S.A.','Peugeot','5008','2014-06-28','Gris Plateado','Axa',179156,'2014-06-28',350.0,'Euro',62529,'2015-06-18',105374),
	 ('0326HRM','PSA Peugeot S.A.','Peugeot','5008','2014-06-28','Gris Plateado','Generali',187973,'2015-06-19',241.8,'Dólar',90819,'2016-08-25',105374),
	 ('6532KNR','Hyundai Motor Group','Hyundai','i30','2019-03-24','Azul','Generali',45918,'2019-03-24',13753.2,'Peso Mexicano',19344,'2022-03-26',35831),
	 ('4389KSN','PSA Peugeot S.A.','Peugeot','206','2019-02-14','Rojo','Axa',112290,'2020-09-21',559536.9,'Peso Colombiano',19885,'2021-12-06',30862),
	 ('5572DHP','Hyundai Motor Group','Kia','Rio','2007-06-06','Blanco','Axa',75790,'2007-06-06',186.0,'Dólar',22437,'2014-05-29',42143);

insert into flota.grupo (nombre)
select grupo from flota.tmp_coches group by grupo;

insert into flota.marca (id_grupo, nombre)
select g.id, tmp.marca from flota.tmp_coches tmp 
inner join flota.grupo g on g.nombre = tmp.grupo 
group by g.id, tmp.marca;

insert into flota.modelo (id_marca, nombre)
select m.id, tmp.modelo from flota.tmp_coches tmp 
inner join flota.grupo g on g.nombre = tmp.grupo 
inner join flota.marca m on m.nombre = tmp.marca
group by g.id, m.id, tmp.modelo;

insert into flota.aseguradora (nombre)
select aseguradora from flota.tmp_coches group by aseguradora;

insert into flota.color (nombre)
select color from flota.tmp_coches group by color;

insert into flota.moneda (nombre)
select moneda from flota.tmp_coches group by moneda;

insert into flota.vehiculo (matricula, fecha_compra, id_modelo, id_color, km)
select matricula, fecha_compra, md.id, c.id, kms_totales from flota.tmp_coches tmp
inner join flota.grupo g on g.nombre = tmp.grupo 
inner join flota.marca m on m.nombre = tmp.marca
inner join flota.modelo md on md.nombre = tmp.modelo
inner join flota.color c on c.nombre = tmp.color
group by matricula, fecha_compra, md.id, c.id, kms_totales;

insert into flota.poliza (matricula, id, id_aseguradora, fecha_alta, en_vigor)
select tmp.matricula, tmp.n_poliza, a.id, tmp.fecha_alta_seguro, false  from flota.tmp_coches tmp
inner join flota.aseguradora a on a.nombre = tmp.aseguradora
group by tmp.matricula, tmp.n_poliza, a.id, tmp.fecha_alta_seguro
order by tmp.matricula, tmp.n_poliza;

update flota.poliza p 
set en_vigor = true 
from (select p.matricula, max(p.fecha_alta) max_fecha_alta from flota.poliza p group by p.matricula) pv 
where p.matricula = pv.matricula and p.fecha_alta = pv.max_fecha_alta;

insert into flota.revision (matricula, km, id_moneda, fecha_revision, importe)
select tmp.matricula, tmp.kms_revision, m.id, tmp.fecha_revision, round(tmp.importe_revision::decimal, 2) from flota.tmp_coches tmp
inner join flota.moneda m on m.nombre = tmp.moneda
group by tmp.matricula, tmp.kms_revision, m.id, tmp.fecha_revision, tmp.importe_revision
order by tmp.matricula;

drop table flota.tmp_coches;

select g.nombre grupo, md.nombre modelo, mr.nombre marca, v.fecha_compra, v.matricula, c.nombre color, v.km total_kilometros, a.nombre aseguradora, p.id poliza
from flota.vehiculo v
inner join flota.modelo md on md.id = v.id_modelo
inner join flota.marca mr on mr.id = md.id_marca
inner join flota.grupo g on g.id = mr.id_grupo
inner join flota.poliza p on p.matricula = v.matricula and p.en_vigor = true
inner join flota.aseguradora a on a.id = p.id_aseguradora
inner join flota.color c on c.id = v.id_color
