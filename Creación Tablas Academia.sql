-- Creamos el Esquema

create schema keepcoding;

-- A continuación, creamos todas las tablas con sus claves primarias


create table keepcoding.persona(
	dni VARCHAR(10) primary key,
	nombre VARCHAR(25) not null,
	primer_apellido VARCHAR(30) not null,
	segundo_apellido VARCHAR(30),
	numero smallint,
	ext VARCHAR(30),
	email VARCHAR(50) not null,
	telefono VARCHAR(15) not null,
	id_via int not null
);


create table keepcoding.matricula(
	id serial primary key,
	dni_alumno VARCHAR(10),
	id_curso INT not null,
	fecha_matriculacion date not null
);


create table keepcoding.calificacion(
	id serial primary key,
	dni_alumno VARCHAR(10) not null,
	id_modulo_curso int not null,
	apto boolean not null
);


create table keepcoding.profesor(
	dni_profesor VARCHAR(10) primary key,
	seg_social VARCHAR(20) not null
);


create table keepcoding.curso(
	id serial primary key,
	nombre VARCHAR(70) not null,
	año smallint not null
);

create table keepcoding.modulo(
	id serial primary key,
	nombre VARCHAR(50) not null
);

create table keepcoding.modulo_por_curso(
	id serial primary key,
	dni_profesor VARCHAR(10),
	id_curso int not null,
	id_modulo int not null,
	fecha_inicio date not null
);


create table keepcoding.via(
	id serial primary key,
	tipo_via VARCHAR(10) not null,
	nombre VARCHAR(70) 
);

create table keepcoding.codigo_postal(
	codigo_postal VARCHAR(10) primary key,
	id_poblacion int not null
);

create table keepcoding.codigo_postal_por_via(
	id serial primary key,
	codigo_postal VARCHAR(10) not null,
	id_via int not null
);

create table keepcoding.poblacion(
	id serial primary key,
	id_estado int not null,
	nombre VARCHAR(50) not null
);

create table keepcoding.estado(
	id serial primary key,
	id_pais int not null,
	nombre VARCHAR(50) not null
);

create table keepcoding.pais(
	id serial primary key,
	nombre VARCHAR(50) not null
);

-- Una vez creadas las tablas, podemos proceder a crear las relaciones

alter table keepcoding.profesor add constraint pk_profesor_persona foreign key (dni_profesor) references keepcoding.persona(dni);
alter table keepcoding.calificacion add constraint pk_calificacion_persona foreign key (dni_alumno) references keepcoding.persona(dni);
alter table keepcoding.calificacion add constraint pk_calificacion_modulo_por_curso foreign key (id_modulo_curso) references keepcoding.modulo_por_curso(id);
alter table keepcoding.persona add constraint pk_persona_via foreign key (id_via) references keepcoding.via(id);
alter table keepcoding.matricula add constraint pk_matricula_persona foreign key (dni_alumno) references keepcoding.persona(dni);
alter table keepcoding.matricula add constraint pk_matricula_curso foreign key (id_curso) references keepcoding.curso(id);
alter table keepcoding.modulo_por_curso add constraint pk_modulo_por_curso_curso foreign key (id_curso) references keepcoding.curso(id);
alter table keepcoding.modulo_por_curso add constraint pk_modulo_por_curso_profesor foreign key (dni_profesor) references keepcoding.profesor(dni_profesor);
alter table keepcoding.modulo_por_curso add constraint pk_modulo_por_curso_modulo foreign key (id_modulo) references keepcoding.modulo(id);
alter table keepcoding.codigo_postal add constraint pk_codigo_postal_poblacion foreign key (id_poblacion) references keepcoding.poblacion(id);
alter table keepcoding.codigo_postal_por_via add constraint pk_codigo_postal_por_via_via foreign key (id_via) references keepcoding.via(id);
alter table keepcoding.codigo_postal_por_via add constraint pk_codigo_postal_por_via_codigo_postal foreign key (codigo_postal) references keepcoding.codigo_postal(codigo_postal);
alter table keepcoding.poblacion add constraint pk_poblacion_estado foreign key (id_estado) references keepcoding.estado(id);
alter table keepcoding.estado add constraint pk_estado_pais foreign key (id_pais) references keepcoding.pais(id);


-- Ahora vamos a importar datos a una tabla auxiliar fuera del modelo llamada datos_academia:

CREATE TABLE keepcoding.datos_academia (
	nombre varchar(50) NULL,
	primer_apellido varchar(50) NULL,
	segundo_apellido varchar(50) NULL,
	dni varchar(50) NULL,
	email varchar(50) NULL,
	telefono int4 NULL,
	movil int4 NULL,
	fecha_nacimiento varchar(50) NULL,
	curso varchar(64) NULL,
	rol varchar(50) NULL,
	fecha_matriculacion varchar(50) NULL,
	poblacion varchar(50) NULL,
	estado varchar(50) NULL,
	codigo_postal int4 NULL,
	via varchar(50) NULL,
	ext varchar(50) NULL
);

-- Y le cargamos todos los datos:
-- Un apunte: Fijaos que con un solo VALUES inserta varios registros de una sola instrucción

INSERT INTO keepcoding.datos_academia (nombre,primer_apellido,segundo_apellido,dni,email,telefono,movil,fecha_nacimiento,curso,rol,fecha_matriculacion,poblacion,estado,codigo_postal,via,ext) VALUES
	 ('Maria isabel','Saez','Castro','6101425P','maria isabel.saez.castro@gmail.com',969188648,650447577,'1997-08-03','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-04-12','Zorraquín','Rioja, La',26003,'Miguel Hernández','18 4Izq.'),
	 ('Pilar','Mora','Mendez','3732740R','pilar.mora.mendez@gmail.com',959637447,620603080,'2008-12-19','Desarrollo Web Full Stack','PROFESOR','','Sestrica','Zaragoza',50001,'España','67 1B'),
	 ('Alvaro','Delgado','Marquez','2589275G','alvaro.delgado.marquez@gmail.com',952806402,617186032,'2007-01-26','Aprende a Programar desde Cero','PROFESOR','','Senyera','Valencia/València',46007,'Sol','35 4C'),
	 ('Maria mar','Fuentes','Marquez','7215956M','maria mar.fuentes.marquez@gmail.com',980766238,618020938,'1997-06-22','Aprende a Programar desde Cero','ALUMNO','2023-04-13','Sant Jaume dels Domenys','Tarragona',43002,'Miguel Hernández','2 2Izq.'),
	 ('Ignacio','Navarro','Gil','2280707G','ignacio.navarro.gil@gmail.com',995176707,682866698,'2001-03-10','DevOps & Cloud Computing Full Stack','PROFESOR','','Campdevànol','Girona',17001,'Clara Campoamor','46 4B'),
	 ('Maria angeles','Flores','Serrano','4654699M','maria angeles.flores.serrano@gmail.com',910406447,644991375,'2005-11-13','Ciberseguridad Full Stack','ALUMNO','2023-05-14','Dehesas de Guadix','Granada',18001,'Federico García Lorca','7 2C'),
	 ('Miguel angel','Vazquez','Rojas','8843886H','miguel angel.vazquez.rojas@gmail.com',900852997,683500251,'2011-08-28','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Villarrasa','Huelva',21001,'Dulcinea','46 3B'),
	 ('Felipe','Diaz','Medina','9685438T','felipe.diaz.medina@gmail.com',979535605,603747386,'1993-02-16','Desarrollo Web Full Stack','PROFESOR','','Valle de Santa Ana','Badajoz',6002,'Ramón y Cajal','54 3Der.'),
	 ('Angela','Marin','Carrasco','1898445W','angela.marin.carrasco@gmail.com',904208650,648821029,'2000-09-27','Aprende a Programar desde Cero','PROFESOR','','Alaminos','Guadalajara',19001,'Nueva','5 2C'),
	 ('Adrian','Gil','Fernandez','4426152D','adrian.gil.fernandez@gmail.com',975655492,687454937,'1996-01-03','Marketing Digital y Análisis de Datos','ALUMNO','2023-04-29','Biescas','Huesca',22001,'Francisco de Goya','49 1Der.'),
	 ('Consuelo','Santiago','Arias','5377492T','consuelo.santiago.arias@gmail.com',912835036,634636255,'2001-11-28','Marketing Digital y Análisis de Datos','PROFESOR','','Cilleruelo de Arriba','Burgos',9001,'Sol','1 4A'),
	 ('Fatima','Ruiz','Mora','7243750S','fatima.ruiz.mora@gmail.com',945726932,614954166,'2010-03-16','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-05-06','Sorihuela del Guadalimar','Jaén',23003,'Pablo Picasso','60 4B'),
	 ('Miriam','Prieto','Nieto','8740417A','miriam.prieto.nieto@gmail.com',940290951,685488341,'2000-04-01','Desarrollo Web Full Stack','PROFESOR','','Motilleja','Albacete',2002,'María Zambrano','49 1Der.'),
	 ('Celia','Garcia','Pastor','5125350F','celia.garcia.pastor@gmail.com',937666889,608570753,'2016-10-05','Desarrollo Web Full Stack','PROFESOR','','Tragacete','Cuenca',16003,'Hernán Cortés','82 1C'),
	 ('Rafael','Sanchez','Marin','6653469Y','rafael.sanchez.marin@gmail.com',983980522,670587298,'2007-07-26','Desarrollo Web Full Stack','ALUMNO','2023-05-07','Zerain','Gipuzkoa',20002,'Clara Campoamor','31 4Izq.'),
	 ('Juan francisco','Fuentes','Herrera','4500055J','juan francisco.fuentes.herrera@gmail.com',960071718,661008249,'2000-11-25','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Iglesias','Burgos',9003,'Dolores Ibárruri','68 1Der.'),
	 ('Juana','Rodriguez','Fuentes','5623093F','juana.rodriguez.fuentes@gmail.com',964496652,681972145,'2004-08-07','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Melque de Cercos','Segovia',40002,'España','33 4D'),
	 ('Celia','Gil','Iglesias','7991533E','celia.gil.iglesias@gmail.com',956934792,698936710,'2014-11-06','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Torralba de los Sisones','Teruel',44002,'Pablo Picasso','34 3Der.'),
	 ('Daniela','Marquez','Moya','7211648K','daniela.marquez.moya@gmail.com',958163136,637226933,'2017-01-14','DevOps & Cloud Computing Full Stack','ALUMNO','2023-05-14','Orellana la Vieja','Badajoz',6001,'Hernán Cortés','21 2Der.'),
	 ('Maria nieves','Morales','Cortes','5776993Z','maria nieves.morales.cortes@gmail.com',953216146,633664851,'1996-04-18','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-05-08','Tragacete','Cuenca',16003,'Real','90 3Izq.'),
	 ('Susana','Ramos','Rodriguez','6104633L','susana.ramos.rodriguez@gmail.com',952561091,693678339,'2012-02-22','Marketing Digital y Análisis de Datos','ALUMNO','2023-05-27','Lebrija','Sevilla',41001,'Eras','46 2D'),
	 ('Francisco','Martinez','Torres','8019801T','francisco.martinez.torres@gmail.com',940579214,615603691,'2015-02-14','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Gordexola','Bizkaia',48001,'Pablo Picasso','76 3D'),
	 ('Dolores','Iglesias','Marquez','6174600C','dolores.iglesias.marquez@gmail.com',985723143,620346688,'1998-03-09','Marketing Digital y Análisis de Datos','ALUMNO','2023-04-16','Sant Pol de Mar','Barcelona',8004,'Dulcinea','3 3Der.'),
	 ('Jose antonio','Gallego','Gallego','8370980S','jose antonio.gallego.gallego@gmail.com',971609493,662053787,'1995-11-15','Marketing Digital y Análisis de Datos','PROFESOR','','Pedraza','Segovia',40003,'Gloria Fuertes','45 4D'),
	 ('Encarnacion','Bravo','Santana','2293155D','encarnacion.bravo.santana@gmail.com',986930716,617001139,'1991-06-30','Marketing Digital y Análisis de Datos','ALUMNO','2023-05-29','Biescas','Huesca',22001,'San Juan','23 3Izq.'),
	 ('Raul','Vargas','Gallego','6381429X','raul.vargas.gallego@gmail.com',919919362,695616757,'1994-02-02','Desarrollo Web Full Stack','PROFESOR','','Guadasséquies','Valencia/València',46005,'Pablo Picasso','68 3Der.'),
	 ('Javier','Vazquez','Calvo','3964046L','javier.vazquez.calvo@gmail.com',928041657,614130162,'2015-08-27','DevOps & Cloud Computing Full Stack','PROFESOR','','Huerta de Arriba','Burgos',9002,'Mercé Rodoreda','10 3Der.'),
	 ('Miriam','Cruz','Hernandez','1029952N','miriam.cruz.hernandez@gmail.com',926846753,622283736,'2005-10-23','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Sabiote','Jaén',23002,'Federico García Lorca','12 4A'),
	 ('Maria dolores','Soler','Blanco','7213810K','maria dolores.soler.blanco@gmail.com',954564682,616136293,'1992-11-17','Ciberseguridad Full Stack','ALUMNO','2023-05-18','Vedra','Coruña, A',15002,'Fuente','67 3D'),
	 ('Maria elena','Gallego','Marquez','4507788H','maria elena.gallego.marquez@gmail.com',903535617,665984608,'2008-10-31','Desarrollo Web Full Stack','ALUMNO','2023-05-25','Sayatón','Guadalajara',19001,'Eras','82 2Izq.'),
	 ('Ivan','Calvo','Nieto','8088383L','ivan.calvo.nieto@gmail.com',942225187,663665918,'1996-05-13','Desarrollo Web Full Stack','PROFESOR','','Jana, la','Castellón/Castelló',12001,'Agustina de Aragón','28 2Der.'),
	 ('Adrian','Vega','Guerrero','7271791L','adrian.vega.guerrero@gmail.com',979807524,638080005,'1993-11-17','Ciberseguridad Full Stack','ALUMNO','2023-04-21','Benegiles','Zamora',49001,'Gloria Fuertes','67 2B'),
	 ('Fernando','Saez','Delgado','5924048F','fernando.saez.delgado@gmail.com',946884092,686067598,'2016-02-11','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Ayora','Valencia/València',46003,'Ramón y Cajal','1 4C'),
	 ('Alfredo','Cruz','Santos','2369066C','alfredo.cruz.santos@gmail.com',981362672,671827311,'1991-12-25','DevOps & Cloud Computing Full Stack','PROFESOR','','Humilladero','Málaga',29001,'Sol','82 1Izq.'),
	 ('Carmen','Marin','Carrasco','1511725G','carmen.marin.carrasco@gmail.com',971054008,640933165,'1997-04-29','Aprende a Programar desde Cero','PROFESOR','','Amunt','Barcelona',8002,'Pablo Picasso','50 3Izq.'),
	 ('Marina','Delgado','Lozano','4452917W','marina.delgado.lozano@gmail.com',973973527,661954618,'2012-01-04','Marketing Digital y Análisis de Datos','ALUMNO','2023-04-23','Guadalmez','Ciudad Real',13001,'Isabel la Católica','33 4Der.'),
	 ('Ignacio','Vazquez','Rojas','8297068W','ignacio.vazquez.rojas@gmail.com',924961923,677758340,'1992-07-14','Desarrollo Web Full Stack','ALUMNO','2023-05-06','Melgar de Fernamental','Burgos',9005,'Bartolomé Esteban Murillo','63 4B'),
	 ('Emilio','Jimenez','Peña','8235947S','emilio.jimenez.peña@gmail.com',925184442,640778705,'2001-07-28','DevOps & Cloud Computing Full Stack','ALUMNO','2023-04-21','Piña de Esgueva','Valladolid',47001,'Juan Ramón Jiménez','9 4D'),
	 ('Gloria','Pastor','Flores','3130557G','gloria.pastor.flores@gmail.com',958700705,674569106,'2006-06-23','Marketing Digital y Análisis de Datos','PROFESOR','','Tragacete','Cuenca',16003,'Mayor','71 3D'),
	 ('Jose carlos','Marin','Bravo','8812890A','jose carlos.marin.bravo@gmail.com',901630628,652389631,'2011-04-11','DevOps & Cloud Computing Full Stack','PROFESOR','','Zorraquín','Rioja, La',26003,'Constitución','16 1B'),
	 ('Carlos','Gomez','Montero','8115420P','carlos.gomez.montero@gmail.com',961700597,624000219,'1990-04-27','DevOps & Cloud Computing Full Stack','ALUMNO','2023-04-30','Bidaurreta','Navarra',31001,'Reina Sofía','52 1B'),
	 ('Jose maria','Garrido','Leon','5296974M','jose maria.garrido.leon@gmail.com',930965039,673728922,'2008-04-03','Ciberseguridad Full Stack','ALUMNO','2023-05-13','Alcublas','Valencia/València',46001,'Gloria Fuertes','37 4D'),
	 ('Andrea','Pastor','Roman','5256961N','andrea.pastor.roman@gmail.com',974948873,605602570,'2016-03-28','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-05-05','Sayatón','Guadalajara',19001,'Juan Ramón Jiménez','84 3C'),
	 ('Nicolas','Gil','Crespo','6531300J','nicolas.gil.crespo@gmail.com',965576287,624880969,'2007-06-14','Marketing Digital y Análisis de Datos','ALUMNO','2023-04-12','Campdevànol','Girona',17001,'Emilia Pardo Bazán','69 4D'),
	 ('Maria josefa','Herrera','Gonzalez','4195325X','maria josefa.herrera.gonzalez@gmail.com',937133308,639912764,'2015-03-09','Ciberseguridad Full Stack','ALUMNO','2023-05-11','Piña de Esgueva','Valladolid',47001,'Rosalía de Castro','53 2A'),
	 ('Fatima','Benitez','Prieto','4893212P','fatima.benitez.prieto@gmail.com',900673044,606172803,'1994-02-11','Desarrollo Web Full Stack','PROFESOR','','Comillas','Cantabria',39001,'España','83 2Izq.'),
	 ('Joaquin','Morales','Alvarez','4885532X','joaquin.morales.alvarez@gmail.com',920428093,697681899,'1998-03-12','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Lebrija','Sevilla',41001,'Rosalía de Castro','24 1Izq.'),
	 ('Ana isabel','Moya','Carmona','3375708K','ana isabel.moya.carmona@gmail.com',926588963,652860901,'1998-01-21','Marketing Digital y Análisis de Datos','ALUMNO','2023-04-30','Palacios de la Valduerna','León',24003,'Hernán Cortés','98 3C'),
	 ('Miguel angel','Cano','Caballero','9849689P','miguel angel.cano.caballero@gmail.com',977575787,632238913,'2007-09-04','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-05-05','Santoña','Cantabria',39003,'Isabel la Católica','76 3A'),
	 ('Hugo','Vicente','Navarro','5023537S','hugo.vicente.navarro@gmail.com',992830369,615455315,'2011-07-16','Ciberseguridad Full Stack','PROFESOR','','Proaza','Asturias',33001,'Concepción Arenal','64 2A'),
	 ('Jaime','Cabrera','Garrido','8649566W','jaime.cabrera.garrido@gmail.com',960512421,678758023,'2001-02-02','Desarrollo Web Full Stack','PROFESOR','','Pinilla de Molina','Guadalajara',19001,'España','67 2Izq.'),
	 ('Montserrat','Leon','Vicente','9834582N','montserrat.leon.vicente@gmail.com',953664777,665340190,'2006-05-11','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-05-19','Uixó, la','Castellón/Castelló',12002,'Agustina de Aragón','80 3D'),
	 ('Yolanda','Lopez','Nieto','4020140Q','yolanda.lopez.nieto@gmail.com',993528643,669635556,'1993-05-25','Desarrollo Web Full Stack','PROFESOR','','Santoña','Cantabria',39003,'Doctor Fleming','58 4Der.'),
	 ('Rocio','Iglesias','Gallego','8593735S','rocio.iglesias.gallego@gmail.com',954911194,691710295,'2002-05-23','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Melgar de Fernamental','Burgos',9005,'Iglesia','62 1Der.'),
	 ('Ainhoa','Gimenez','Mora','5660447D','ainhoa.gimenez.mora@gmail.com',940072838,687154860,'1990-08-24','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-05-11','Santa Eugènia de Berga','Barcelona',8005,'Mariana Pineda','25 4D'),
	 ('Mohamed','Santana','Campos','9348756S','mohamed.santana.campos@gmail.com',908405891,633181360,'2000-07-12','DevOps & Cloud Computing Full Stack','PROFESOR','','Santa Eugènia de Berga','Barcelona',8005,'Francisco de Goya','11 3C'),
	 ('Felix','Moya','Hernandez','2225076X','felix.moya.hernandez@gmail.com',974481993,646801988,'1991-12-10','Desarrollo Web Full Stack','ALUMNO','2023-05-06','Guadasséquies','Valencia/València',46005,'Antonio Machado','88 1B'),
	 ('Guillermo','Romero','Cortes','7182078Y','guillermo.romero.cortes@gmail.com',931690565,634893147,'2002-12-03','Desarrollo Web Full Stack','PROFESOR','','Urueñas','Segovia',40005,'Ramón y Cajal','77 3C'),
	 ('Amparo','Molina','Muñoz','6741636Z','amparo.molina.muñoz@gmail.com',920284270,669978140,'1997-03-30','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Zerain','Gipuzkoa',20002,'Antonio Machado','78 2Izq.'),
	 ('Diego','Gomez','Gonzalez','8642845C','diego.gomez.gonzalez@gmail.com',925520356,603542562,'2005-01-26','Desarrollo Web Full Stack','ALUMNO','2023-04-27','Senyera','Valencia/València',46007,'Eras','69 3Izq.'),
	 ('Guillermo','Mendez','Cortes','1165073P','guillermo.mendez.cortes@gmail.com',959414058,609096312,'2000-06-06','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Hornachuelos','Córdoba',14001,'Isabel la Católica','22 2D'),
	 ('Maria antonia','Cano','Pascual','9045843N','maria antonia.cano.pascual@gmail.com',935904530,655447764,'2009-07-20','Ciberseguridad Full Stack','PROFESOR','','Cilleruelo de Arriba','Burgos',9001,'Gloria Fuertes','94 3Der.'),
	 ('Josep','Sanz','Alvarez','9342415E','josep.sanz.alvarez@gmail.com',992074402,609053895,'1998-12-05','Aprende a Programar desde Cero','PROFESOR','','Ventosilla y Tejadilla','Segovia',40006,'Miguel Hernández','33 4Izq.'),
	 ('Veronica','Campos','Medina','2269314L','veronica.campos.medina@gmail.com',940114165,656248432,'1991-06-10','DevOps & Cloud Computing Full Stack','ALUMNO','2023-04-29','Zorraquín','Rioja, La',26003,'Mayor','9 4C'),
	 ('Maria elena','Vargas','Diaz','5632272D','maria elena.vargas.diaz@gmail.com',915712049,627655936,'2003-08-10','Aprende a Programar desde Cero','ALUMNO','2023-05-28','Santa Cruz de la Sierra','Cáceres',10002,'Velázquez','40 2Der.'),
	 ('Pilar','Jimenez','Gomez','7081332T','pilar.jimenez.gomez@gmail.com',917393011,673072847,'1996-06-29','Desarrollo Web Full Stack','ALUMNO','2023-05-08','Ripollet','Barcelona',8003,'Ramón y Cajal','34 2Der.'),
	 ('Oscar','Lorenzo','Martinez','4465225M','oscar.lorenzo.martinez@gmail.com',985682339,630682210,'1995-07-07','Marketing Digital y Análisis de Datos','PROFESOR','','Sant Jaume dels Domenys','Tarragona',43002,'Federico García Lorca','56 3Der.'),
	 ('Clara','Saez','Iglesias','2811905V','clara.saez.iglesias@gmail.com',975159620,664065629,'2009-05-25','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Zerain','Gipuzkoa',20002,'Madre Teresa de Calcuta','67 2C'),
	 ('Fernando','Reyes','Ortega','7296331H','fernando.reyes.ortega@gmail.com',967735638,632691505,'2000-07-04','Ciberseguridad Full Stack','ALUMNO','2023-05-20','Tragacete','Cuenca',16003,'Monjas','92 1D'),
	 ('Claudia','Hidalgo','Diez','4981060L','claudia.hidalgo.diez@gmail.com',956345228,621192547,'1995-02-17','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Benigànim','Valencia/València',46004,'Isabel la Católica','73 2D'),
	 ('Consuelo','Gomez','Velasco','8013980K','consuelo.gomez.velasco@gmail.com',967123668,627177771,'2006-12-16','Aprende a Programar desde Cero','ALUMNO','2023-04-14','Quintanilla del Monte','Zamora',49002,'Federico García Lorca','37 2C'),
	 ('Jose angel','Bravo','Fernandez','8597090N','jose angel.bravo.fernandez@gmail.com',948443893,607138491,'1997-06-10','Marketing Digital y Análisis de Datos','PROFESOR','','Sabiote','Jaén',23002,'Bartolomé Esteban Murillo','93 2C'),
	 ('Maria','Delgado','Cano','6590400A','maria.delgado.cano@gmail.com',991851642,642710375,'2006-06-18','DevOps & Cloud Computing Full Stack','ALUMNO','2023-05-03','Torresandino','Burgos',9006,'Francisco Pizarro','74 4D'),
	 ('Mateo','Arias','Leon','7752224M','mateo.arias.leon@gmail.com',921675575,641153938,'1996-10-19','Desarrollo Web Full Stack','ALUMNO','2023-04-18','Cisneros','Palencia',34001,'Reina Sofía','63 1C'),
	 ('Enrique','Bravo','Gil','9551003T','enrique.bravo.gil@gmail.com',966756132,646480186,'1998-02-18','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-04-19','Infant','Tarragona',43003,'España','20 4C'),
	 ('Maria mar','Ferrer','Peña','4524891D','maria mar.ferrer.peña@gmail.com',903013457,674955682,'1999-05-15','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Santa Cruz de la Sierra','Cáceres',10002,'Mariana Pineda','83 2Izq.'),
	 ('Jordi','Gomez','Ferrer','2339831H','jordi.gomez.ferrer@gmail.com',913115659,635592892,'1995-07-22','Marketing Digital y Análisis de Datos','PROFESOR','','Real de Gandia, el','Valencia/València',46006,'Bartolomé Esteban Murillo','28 1A'),
	 ('Ainhoa','Duran','Vazquez','4139799Y','ainhoa.duran.vazquez@gmail.com',973607458,632156598,'2014-01-07','DevOps & Cloud Computing Full Stack','PROFESOR','','Camarillas','Teruel',44001,'Pablo Picasso','26 1B'),
	 ('Maria luisa','Fernandez','Dominguez','3296593A','maria luisa.fernandez.dominguez@gmail.com',948583496,661400960,'2013-11-13','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-05-28','Villatoro','Ávila',5001,'Doctor Fleming','49 2A'),
	 ('Manuel','Ruiz','Lozano','6278661Y','manuel.ruiz.lozano@gmail.com',933703226,604416969,'1997-03-06','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-05-14','Gordexola','Bizkaia',48001,'Francisco de Goya','24 1A'),
	 ('Maria antonia','Gil','Caballero','1044039T','maria antonia.gil.caballero@gmail.com',973065865,642717709,'1998-04-15','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-04-19','Torralba de los Sisones','Teruel',44002,'Reina Sofía','43 1D'),
	 ('Noelia','Vega','Pascual','5679085V','noelia.vega.pascual@gmail.com',953216350,626969090,'2017-04-29','Desarrollo Web Full Stack','PROFESOR','','Villayón','Asturias',33001,'Eras','62 2C'),
	 ('Maria dolores','Marin','Lopez','5906768T','maria dolores.marin.lopez@gmail.com',940145900,629906139,'1993-06-25','Ciberseguridad Full Stack','ALUMNO','2023-04-14','Senyera','Valencia/València',46007,'Pablo Picasso','67 4Izq.'),
	 ('Lucas','Gonzalez','Flores','1841025J','lucas.gonzalez.flores@gmail.com',994927817,643498925,'2013-09-23','Desarrollo Web Full Stack','ALUMNO','2023-04-20','Santa Cruz de la Sierra','Cáceres',10002,'Nueva','17 2C'),
	 ('Eva','Vidal','Mora','9760510T','eva.vidal.mora@gmail.com',925977295,654528349,'1997-06-20','Marketing Digital y Análisis de Datos','PROFESOR','','Riudoms','Tarragona',43001,'Ramón y Cajal','36 2C'),
	 ('Jesus','Martin','Hernandez','5183383B','jesus.martin.hernandez@gmail.com',939681703,640131503,'2002-05-27','Marketing Digital y Análisis de Datos','PROFESOR','','Zerain','Gipuzkoa',20002,'Juan Ramón Jiménez','97 3Der.'),
	 ('Rafael','Gil','Hernandez','9455864N','rafael.gil.hernandez@gmail.com',983739175,686614148,'2008-12-16','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Zorraquín','Rioja, La',26003,'Mariana Pineda','65 1C'),
	 ('Sonia','Ortega','Fuentes','3439721W','sonia.ortega.fuentes@gmail.com',920727522,634252255,'2001-02-17','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-05-15','Orellana la Vieja','Badajoz',6001,'Monjas','39 3C'),
	 ('Clara','Ibañez','Reyes','2715719V','clara.ibañez.reyes@gmail.com',959993761,607982364,'2011-08-22','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Melgar de Fernamental','Burgos',9005,'Ramón y Cajal','61 2B'),
	 ('Pilar','Medina','Suarez','8639345Q','pilar.medina.suarez@gmail.com',946535658,615627938,'2009-10-13','Ciberseguridad Full Stack','PROFESOR','','Taravilla','Guadalajara',19001,'Reina Sofía','16 1A'),
	 ('David','Reyes','Martin','9325033M','david.reyes.martin@gmail.com',986742257,665002584,'2007-06-27','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Santa Cruz de la Sierra','Cáceres',10002,'Concepción Arenal','19 4D'),
	 ('Nicolas','Vidal','Ramos','9308506S','nicolas.vidal.ramos@gmail.com',947105968,614082624,'2011-03-07','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-04-30','Comillas','Cantabria',39001,'Nueva','53 2B'),
	 ('Cristina','Benitez','Santana','6613433J','cristina.benitez.santana@gmail.com',928697698,672680820,'2000-01-27','Marketing Digital y Análisis de Datos','PROFESOR','','Santa Cruz de la Zarza','Toledo',45001,'Mercé Rodoreda','100 4A'),
	 ('Julian','Peña','Blanco','4165223S','julian.peña.blanco@gmail.com',982293086,619693413,'2001-07-20','Ciberseguridad Full Stack','ALUMNO','2023-05-27','Comillas','Cantabria',39001,'Constitución','14 4B'),
	 ('Juan francisco','Gimenez','Marquez','3530471V','juan francisco.gimenez.marquez@gmail.com',903406336,638633141,'1998-01-18','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-04-30','Ayora','Valencia/València',46003,'Francisco de Goya','78 4A'),
	 ('Daniela','Aguilar','Bravo','3527673W','daniela.aguilar.bravo@gmail.com',954541400,636110190,'2013-08-17','Aprende a Programar desde Cero','PROFESOR','','Guadasséquies','Valencia/València',46005,'Monjas','29 2A'),
	 ('Amparo','Rodriguez','Molina','9770723R','amparo.rodriguez.molina@gmail.com',999782014,662610796,'2008-01-28','Ciberseguridad Full Stack','ALUMNO','2023-04-23','Villacidaler','Palencia',34003,'Reina Sofía','43 4Der.'),
	 ('Manuel','Roman','Moya','7415091Y','manuel.roman.moya@gmail.com',985383453,688809420,'2010-10-03','Desarrollo Web Full Stack','PROFESOR','','Robledo','Albacete',2003,'Constitución','10 2A'),
	 ('Celia','Arias','Santiago','6503357S','celia.arias.santiago@gmail.com',930066206,683487401,'1995-09-09','DevOps & Cloud Computing Full Stack','PROFESOR','','Zerain','Gipuzkoa',20002,'Madre Teresa de Calcuta','55 4Der.'),
	 ('Alberto','Pascual','Hernandez','9224385M','alberto.pascual.hernandez@gmail.com',908140945,600392639,'2017-02-09','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Sabiote','Jaén',23002,'Mayor','90 2Der.');
INSERT INTO keepcoding.datos_academia (nombre,primer_apellido,segundo_apellido,dni,email,telefono,movil,fecha_nacimiento,curso,rol,fecha_matriculacion,poblacion,estado,codigo_postal,via,ext) VALUES
	 ('Aitor','Alonso','Garrido','6551522H','aitor.alonso.garrido@gmail.com',977939196,680195058,'1990-10-06','Marketing Digital y Análisis de Datos','ALUMNO','2023-04-27','Torresandino','Burgos',9006,'Francisco de Goya','41 1C'),
	 ('Ivan','Parra','Lopez','8340079A','ivan.parra.lopez@gmail.com',984132968,658012435,'2011-12-05','Desarrollo Web Full Stack','PROFESOR','','Orellana la Vieja','Badajoz',6001,'Iglesia','93 1D'),
	 ('Joan','Rubio','Iglesias','8903080X','joan.rubio.iglesias@gmail.com',996633140,676649455,'2012-05-23','DevOps & Cloud Computing Full Stack','PROFESOR','','Tolosa','Gipuzkoa',20001,'Francisco Pizarro','6 4B'),
	 ('Alba','Soler','Cano','3430883L','alba.soler.cano@gmail.com',948319802,605236666,'2002-04-26','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Almàssera','Valencia/València',46002,'Madre Teresa de Calcuta','57 2B'),
	 ('Mario','Suarez','Muñoz','7297559G','mario.suarez.muñoz@gmail.com',929150221,638396250,'1999-07-19','Ciberseguridad Full Stack','PROFESOR','','Humilladero','Málaga',29001,'Mayor','4 1C'),
	 ('Albert','Moreno','Garcia','3147751V','albert.moreno.garcia@gmail.com',958988625,667339289,'1997-01-04','Marketing Digital y Análisis de Datos','ALUMNO','2023-05-19','Robledo','Albacete',2003,'Mayor','12 1D'),
	 ('Oscar','Rivera','Hidalgo','4250861R','oscar.rivera.hidalgo@gmail.com',939348512,609520740,'1994-05-03','Ciberseguridad Full Stack','ALUMNO','2023-05-16','Sestrica','Zaragoza',50001,'Real','79 4B'),
	 ('Jose miguel','Medina','Gomez','1183834R','jose miguel.medina.gomez@gmail.com',921281258,601480970,'1991-06-28','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Gordexola','Bizkaia',48001,'Mariana Pineda','80 1Der.'),
	 ('Ricardo','Peña','Moreno','7835010Z','ricardo.peña.moreno@gmail.com',987490932,662777349,'2011-08-31','Ciberseguridad Full Stack','ALUMNO','2023-05-30','Valdáliga','Cantabria',39004,'Mariana Pineda','59 2D'),
	 ('Santiago','Mendez','Leon','5404462Z','santiago.mendez.leon@gmail.com',948094038,682401756,'2003-09-25','DevOps & Cloud Computing Full Stack','ALUMNO','2023-05-27','Cilleruelo de Arriba','Burgos',9001,'Real','66 4D'),
	 ('Tomas','Bravo','Rodriguez','8825954A','tomas.bravo.rodriguez@gmail.com',916032932,625709965,'2000-02-03','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Campdevànol','Girona',17001,'Cristóbal Colón','34 1D'),
	 ('Andres','Parra','Gimenez','7928247D','andres.parra.gimenez@gmail.com',999861825,614604061,'1996-03-07','Ciberseguridad Full Stack','ALUMNO','2023-05-30','Campdevànol','Girona',17001,'Cristóbal Colón','50 1A'),
	 ('Francisco','Rojas','Carrasco','6995930C','francisco.rojas.carrasco@gmail.com',944241071,659700758,'2002-12-02','Marketing Digital y Análisis de Datos','ALUMNO','2023-05-21','Camarillas','Teruel',44001,'Clara Campoamor','66 3Izq.'),
	 ('Ignacio','Marquez','Vargas','2686263R','ignacio.marquez.vargas@gmail.com',947166738,696048142,'1990-05-31','Desarrollo Web Full Stack','PROFESOR','','Medina de Pomar','Burgos',9004,'Emilia Pardo Bazán','55 2D'),
	 ('Eva','Benitez','Cortes','4114232S','eva.benitez.cortes@gmail.com',931068434,608651657,'2015-07-22','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-04-30','Cisneros','Palencia',34001,'Rosalía de Castro','60 4A'),
	 ('Lidia','Rubio','Gomez','4742546S','lidia.rubio.gomez@gmail.com',922840963,632181427,'2005-07-14','Marketing Digital y Análisis de Datos','ALUMNO','2023-04-20','Quintanilla del Monte','Zamora',49002,'Hernán Cortés','23 1Der.'),
	 ('Laura','Leon','Martinez','7896724L','laura.leon.martinez@gmail.com',955708770,699234606,'2007-12-25','Ciberseguridad Full Stack','ALUMNO','2023-05-29','Olmeda de las Fuentes','Madrid',28001,'Rosalía de Castro','96 4Izq.'),
	 ('Antonio','Alvarez','Gallego','2275890V','antonio.alvarez.gallego@gmail.com',933475664,673414561,'1994-09-01','Marketing Digital y Análisis de Datos','PROFESOR','','Villacidaler','Palencia',34003,'Gloria Fuertes','56 2Der.'),
	 ('Jose ramon','Vega','Moya','8513708M','jose ramon.vega.moya@gmail.com',930639062,605829680,'1990-11-05','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-04-26','Alaminos','Guadalajara',19001,'Agustina de Aragón','63 1Izq.'),
	 ('Clara','Gallardo','Soler','2919048A','clara.gallardo.soler@gmail.com',973802977,660079947,'1992-12-01','Desarrollo Web Full Stack','ALUMNO','2023-04-25','Sayatón','Guadalajara',19001,'Pablo Picasso','17 4Izq.'),
	 ('Salvador','Sanz','Ortiz','9905831F','salvador.sanz.ortiz@gmail.com',962853567,629630779,'1999-07-29','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-04-27','Santa Cruz de la Sierra','Cáceres',10002,'Constitución','53 1Der.'),
	 ('Raquel','Delgado','Peña','1773724X','raquel.delgado.peña@gmail.com',983735128,696815309,'2004-01-15','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-05-14','Sestrica','Zaragoza',50001,'España','37 1Izq.'),
	 ('Eduardo','Carrasco','Soto','8250095H','eduardo.carrasco.soto@gmail.com',906779100,630162091,'2010-01-16','Marketing Digital y Análisis de Datos','ALUMNO','2023-05-08','Palacios de la Valduerna','León',24003,'Reina Sofía','12 3A'),
	 ('Carla','Herrero','Moreno','7565378B','carla.herrero.moreno@gmail.com',941140042,624993587,'2006-08-02','Aprende a Programar desde Cero','PROFESOR','','Sayatón','Guadalajara',19001,'Real','93 1C'),
	 ('Marc','Prieto','Castillo','5132866W','marc.prieto.castillo@gmail.com',917933352,677107073,'2000-05-08','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-05-09','Dehesas de Guadix','Granada',18001,'Doctor Fleming','57 2B'),
	 ('Isabel','Lorenzo','Dominguez','7925090A','isabel.lorenzo.dominguez@gmail.com',974061797,656003399,'1996-08-26','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-05-18','Rianxo','Coruña, A',15001,'Miguel de Cervantes','58 2C'),
	 ('Juan manuel','Molina','Gallego','6510796W','juan manuel.molina.gallego@gmail.com',920204306,699996877,'2002-11-26','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Guadalmez','Ciudad Real',13001,'Monjas','47 1C'),
	 ('Paula','Vazquez','Sanchez','4405856E','paula.vazquez.sanchez@gmail.com',916964899,633563182,'1994-10-18','Ciberseguridad Full Stack','PROFESOR','','Dehesas de Guadix','Granada',18001,'Concepción Arenal','11 2C'),
	 ('Yolanda','Leon','Santos','8994389D','yolanda.leon.santos@gmail.com',988786955,693019274,'1994-02-16','DevOps & Cloud Computing Full Stack','ALUMNO','2023-05-29','Itero de la Vega','Palencia',34002,'Concepción Arenal','41 2A'),
	 ('Sandra','Sanchez','Cano','1008301G','sandra.sanchez.cano@gmail.com',940204367,623411782,'1995-06-10','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Rianxo','Coruña, A',15001,'Dulcinea','80 2Izq.'),
	 ('Esther','Gil','Serrano','7184632F','esther.gil.serrano@gmail.com',904360169,670671672,'2015-02-16','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-04-14','Campdevànol','Girona',17001,'Reina Sofía','87 1Izq.'),
	 ('Adrian','Gutierrez','Montero','2531478Y','adrian.gutierrez.montero@gmail.com',987364683,662877297,'1999-01-15','Ciberseguridad Full Stack','ALUMNO','2023-05-14','Olmeda de las Fuentes','Madrid',28001,'Eras','2 3C'),
	 ('Juan luis','Gomez','Fernandez','7546426B','juan luis.gomez.fernandez@gmail.com',916657924,697872093,'1997-03-21','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Valfermoso de Tajuña','Guadalajara',19001,'Mercé Rodoreda','18 4D'),
	 ('Antonia','Peña','Ramirez','1710507C','antonia.peña.ramirez@gmail.com',921444990,607664262,'2014-06-11','DevOps & Cloud Computing Full Stack','ALUMNO','2023-05-25','Alborea','Albacete',2001,'Nueva','70 3Izq.'),
	 ('Marta','Rojas','Rodriguez','2847892D','marta.rojas.rodriguez@gmail.com',917253527,618599788,'2011-08-08','Ciberseguridad Full Stack','PROFESOR','','Rozalén del Monte','Cuenca',16002,'Antonio Machado','87 1Der.'),
	 ('Carolina','Aguilar','Saez','4807383S','carolina.aguilar.saez@gmail.com',993855620,683086117,'2003-07-12','Desarrollo Web Full Stack','ALUMNO','2023-04-15','Torralba de los Sisones','Teruel',44002,'Concepción Arenal','18 4C'),
	 ('Claudia','Ruiz','Garcia','6833496N','claudia.ruiz.garcia@gmail.com',912142289,676425975,'2001-11-16','Marketing Digital y Análisis de Datos','ALUMNO','2023-04-19','Benegiles','Zamora',49001,'Isabel la Católica','8 2B'),
	 ('Domingo','Hernandez','Martinez','7892124L','domingo.hernandez.martinez@gmail.com',978705843,615608057,'2016-05-24','DevOps & Cloud Computing Full Stack','PROFESOR','','Gordexola','Bizkaia',48001,'Dolores Ibárruri','88 2Der.'),
	 ('Mercedes','Roman','Ortiz','5995109K','mercedes.roman.ortiz@gmail.com',901912814,681102753,'1993-07-06','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-05-09','Lebrija','Sevilla',41001,'Miguel de Cervantes','31 3C'),
	 ('Oscar','Moya','Sanz','5201955E','oscar.moya.sanz@gmail.com',922038485,649020088,'2005-02-03','Ciberseguridad Full Stack','ALUMNO','2023-05-18','Hornachuelos','Córdoba',14001,'Francisco de Goya','29 1A'),
	 ('Dolores','Roman','Muñoz','4411667Z','dolores.roman.muñoz@gmail.com',996161376,621610432,'1993-02-25','Marketing Digital y Análisis de Datos','PROFESOR','','Orellana la Vieja','Badajoz',6001,'Dulcinea','10 2D'),
	 ('Patricia','Lorenzo','Gutierrez','8438645Z','patricia.lorenzo.gutierrez@gmail.com',927451873,674730354,'1994-05-20','Ciberseguridad Full Stack','ALUMNO','2023-05-13','Humilladero','Málaga',29001,'Miguel Hernández','16 1D'),
	 ('Maria dolores','Herrera','Garrido','8687316D','maria dolores.herrera.garrido@gmail.com',938285082,622369668,'1994-09-01','Desarrollo Web Full Stack','ALUMNO','2023-04-18','Dehesas de Guadix','Granada',18001,'Reina Sofía','86 1Izq.'),
	 ('Sofia','Ferrer','Dominguez','4676227M','sofia.ferrer.dominguez@gmail.com',980402972,693144294,'2004-08-08','Desarrollo Web Full Stack','PROFESOR','','Robledo','Albacete',2003,'Clara Campoamor','37 2B'),
	 ('Jose luis','Moreno','Calvo','5806103Y','jose luis.moreno.calvo@gmail.com',989207505,663478701,'1993-10-23','Desarrollo Web Full Stack','PROFESOR','','Orellana la Vieja','Badajoz',6001,'María Zambrano','62 4Izq.'),
	 ('Marc','Aguilar','Dominguez','4953398A','marc.aguilar.dominguez@gmail.com',954151320,672093559,'2013-08-06','Aprende a Programar desde Cero','PROFESOR','','Pozal de Gallinas','Valladolid',47002,'Rosalía de Castro','82 1C'),
	 ('Daniel','Hidalgo','Martin','1664326T','daniel.hidalgo.martin@gmail.com',945258887,622261129,'2002-05-06','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Tragacete','Cuenca',16003,'Doctor Fleming','61 3A'),
	 ('Antonio','Parra','Vazquez','6792727E','antonio.parra.vazquez@gmail.com',949533860,605256524,'2013-05-03','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-05-11','Piña de Esgueva','Valladolid',47001,'Gloria Fuertes','85 3C'),
	 ('Santiago','Soto','Romero','4368168P','santiago.soto.romero@gmail.com',914387916,647767412,'1995-03-29','Aprende a Programar desde Cero','ALUMNO','2023-05-27','Jana, la','Castellón/Castelló',12001,'Constitución','78 2D'),
	 ('Juan carlos','Blanco','Sanchez','7968174P','juan carlos.blanco.sanchez@gmail.com',909171374,644135519,'2010-02-02','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Sant Pol de Mar','Barcelona',8004,'María Zambrano','48 4C'),
	 ('Clara','Guerrero','Blanco','3395437Q','clara.guerrero.blanco@gmail.com',920898699,615671907,'2017-02-28','Ciberseguridad Full Stack','PROFESOR','','Zorraquín','Rioja, La',26003,'Dolores Ibárruri','76 1Izq.'),
	 ('Nuria','Ortega','Crespo','5664485E','nuria.ortega.crespo@gmail.com',948187501,686895066,'2001-05-09','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Zerain','Gipuzkoa',20002,'Eras','10 4C'),
	 ('Maria nieves','Fuentes','Velasco','3125956A','maria nieves.fuentes.velasco@gmail.com',929504371,604796447,'2014-04-01','Desarrollo Web Full Stack','ALUMNO','2023-04-24','Olmeda de las Fuentes','Madrid',28001,'San Juan','69 2Der.'),
	 ('Hugo','Velasco','Carmona','2080660B','hugo.velasco.carmona@gmail.com',924975106,605034591,'2005-04-13','Desarrollo Web Full Stack','ALUMNO','2023-04-23','Biescas','Huesca',22001,'Gloria Fuertes','13 4Der.'),
	 ('Sonia','Castro','Mora','9105624Q','sonia.castro.mora@gmail.com',976503439,643259078,'2007-04-22','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-05-14','Valfermoso de Tajuña','Guadalajara',19001,'Mayor','9 4A'),
	 ('Rosario','Guerrero','Serrano','7597852D','rosario.guerrero.serrano@gmail.com',958045061,687632449,'2005-02-06','Ciberseguridad Full Stack','PROFESOR','','Camarillas','Teruel',44001,'Mercé Rodoreda','100 1C'),
	 ('Victor','Guerrero','Garcia','8143969Z','victor.guerrero.garcia@gmail.com',947255630,606850838,'2004-11-25','DevOps & Cloud Computing Full Stack','ALUMNO','2023-05-12','Alcublas','Valencia/València',46001,'Pablo Picasso','32 1B'),
	 ('Sergio','Gimenez','Fernandez','4567060L','sergio.gimenez.fernandez@gmail.com',984250866,635552832,'1992-12-23','DevOps & Cloud Computing Full Stack','PROFESOR','','Avinyó','Barcelona',8001,'Gloria Fuertes','89 4D'),
	 ('Angela','Sanz','Ramos','3536747Z','angela.sanz.ramos@gmail.com',980110741,605524318,'2001-09-10','Aprende a Programar desde Cero','ALUMNO','2023-04-28','Chantada','Lugo',27001,'Constitución','26 4C'),
	 ('Montserrat','Duran','Flores','6042528Z','montserrat.duran.flores@gmail.com',990967850,643478569,'2012-12-27','DevOps & Cloud Computing Full Stack','PROFESOR','','Sant Jaume dels Domenys','Tarragona',43002,'Velázquez','22 3Izq.'),
	 ('Jorge','Martinez','Blanco','8044164Y','jorge.martinez.blanco@gmail.com',956004844,608947716,'2003-04-12','DevOps & Cloud Computing Full Stack','PROFESOR','','Sant Pol de Mar','Barcelona',8004,'Gloria Fuertes','95 4B'),
	 ('Lucia','Muñoz','Lozano','8898495W','lucia.muñoz.lozano@gmail.com',995543862,687331032,'2001-01-06','Marketing Digital y Análisis de Datos','ALUMNO','2023-05-22','Olmeda del Rey','Cuenca',16001,'Bartolomé Esteban Murillo','74 2A'),
	 ('Maria','Diaz','Cabrera','3449734X','maria.diaz.cabrera@gmail.com',990776213,692977256,'1997-07-08','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Sayatón','Guadalajara',19001,'María Zambrano','84 1D'),
	 ('Sara','Cortes','Roman','4079920L','sara.cortes.roman@gmail.com',934292693,600291684,'2008-05-29','Aprende a Programar desde Cero','ALUMNO','2023-05-19','Tragacete','Cuenca',16003,'Fuente','14 1Izq.'),
	 ('Jose francisco','Carmona','Santiago','6560234J','jose francisco.carmona.santiago@gmail.com',951648097,604840575,'2013-06-17','Aprende a Programar desde Cero','ALUMNO','2023-04-19','Bidaurreta','Navarra',31001,'Francisco Pizarro','86 1Der.'),
	 ('Ainhoa','Dominguez','Hidalgo','4949432Q','ainhoa.dominguez.hidalgo@gmail.com',960587638,656378668,'2004-04-27','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-05-30','Santibáñez de la Sierra','Salamanca',37001,'San Juan','11 1D'),
	 ('Inmaculada','Moreno','Calvo','6819672B','inmaculada.moreno.calvo@gmail.com',964811362,661526993,'2001-05-02','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-05-09','Ventosilla y Tejadilla','Segovia',40006,'Sol','93 1A'),
	 ('Josep','Lopez','Delgado','1956596D','josep.lopez.delgado@gmail.com',989362788,639812994,'2006-12-11','Marketing Digital y Análisis de Datos','PROFESOR','','Campdevànol','Girona',17001,'Emilia Pardo Bazán','87 1D'),
	 ('Monica','Guerrero','Campos','8329659W','monica.guerrero.campos@gmail.com',995265894,614458666,'2015-06-26','Desarrollo Web Full Stack','ALUMNO','2023-04-14','Almàssera','Valencia/València',46002,'Reina Sofía','62 4B'),
	 ('Andrea','Guerrero','Flores','3914809W','andrea.guerrero.flores@gmail.com',955123426,677291220,'1993-10-07','Marketing Digital y Análisis de Datos','ALUMNO','2023-05-23','Valdáliga','Cantabria',39004,'Miguel Hernández','31 2D'),
	 ('Daniel','Vidal','Reyes','5824269W','daniel.vidal.reyes@gmail.com',995608655,612862005,'1993-02-20','DevOps & Cloud Computing Full Stack','ALUMNO','2023-04-12','Dehesas de Guadix','Granada',18001,'Pablo Picasso','5 4B'),
	 ('Luis miguel','Herrero','Soler','4396430A','luis miguel.herrero.soler@gmail.com',906858187,653246579,'1992-11-02','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Hornachuelos','Córdoba',14001,'Juan Ramón Jiménez','25 4Izq.'),
	 ('Rosa maria','Dominguez','Pascual','5801750T','rosa maria.dominguez.pascual@gmail.com',996491913,622496028,'1993-06-01','Desarrollo Web Full Stack','ALUMNO','2023-05-21','Lebrija','Sevilla',41001,'Isabel la Católica','4 4Izq.'),
	 ('Ana isabel','Garrido','Gallardo','8159832F','ana isabel.garrido.gallardo@gmail.com',915303148,680275533,'1998-05-01','Marketing Digital y Análisis de Datos','ALUMNO','2023-04-24','Guadalmez','Ciudad Real',13001,'Mariana Pineda','19 1Der.'),
	 ('Albert','Nuñez','Vargas','9994704P','albert.nuñez.vargas@gmail.com',978678435,602913930,'1999-02-05','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Huerta de Arriba','Burgos',9002,'Hernán Cortés','95 2D'),
	 ('Gloria','Rubio','Calvo','2728400W','gloria.rubio.calvo@gmail.com',936008362,658078430,'2003-12-15','Marketing Digital y Análisis de Datos','PROFESOR','','Guadasséquies','Valencia/València',46005,'Reina Sofía','59 1Izq.'),
	 ('Jose francisco','Prieto','Alonso','3933839B','jose francisco.prieto.alonso@gmail.com',940598263,687523640,'2005-12-28','Marketing Digital y Análisis de Datos','PROFESOR','','Villayón','Asturias',33001,'Constitución','4 4Der.'),
	 ('Victor','Crespo','Pastor','2739471X','victor.crespo.pastor@gmail.com',952216208,648260999,'1999-12-21','DevOps & Cloud Computing Full Stack','PROFESOR','','Olmeda de las Fuentes','Madrid',28001,'Pablo Picasso','41 1B'),
	 ('Angeles','Ortiz','Ortiz','1363498N','angeles.ortiz.ortiz@gmail.com',955161460,611320206,'2007-11-19','Marketing Digital y Análisis de Datos','PROFESOR','','Guadasséquies','Valencia/València',46005,'Pablo Picasso','23 1C'),
	 ('Eduardo','Martinez','Santana','8204581K','eduardo.martinez.santana@gmail.com',951833478,698274888,'1996-04-03','DevOps & Cloud Computing Full Stack','PROFESOR','','Infant','Tarragona',43003,'Miguel de Cervantes','53 2B'),
	 ('Alex','Carrasco','Garcia','5522700D','alex.carrasco.garcia@gmail.com',938658404,608398768,'2007-07-21','Ciberseguridad Full Stack','PROFESOR','','Valdáliga','Cantabria',39004,'Agustina de Aragón','32 1C'),
	 ('Alicia','Gimenez','Molina','6745733V','alicia.gimenez.molina@gmail.com',995199750,655932737,'2001-04-02','Ciberseguridad Full Stack','ALUMNO','2023-05-20','Sayatón','Guadalajara',19001,'Eras','30 4A'),
	 ('Maria cristina','Rojas','Prieto','4197066A','maria cristina.rojas.prieto@gmail.com',907966012,693949919,'2004-08-23','DevOps & Cloud Computing Full Stack','PROFESOR','','Quintanilla del Monte','Zamora',49002,'Constitución','8 3Der.'),
	 ('Maria dolores','Gutierrez','Perez','4844054R','maria dolores.gutierrez.perez@gmail.com',912309215,632320659,'2010-05-21','DevOps & Cloud Computing Full Stack','ALUMNO','2023-05-09','Pinilla de Molina','Guadalajara',19001,'María Zambrano','10 3C'),
	 ('Pilar','Rivera','Duran','5657971V','pilar.rivera.duran@gmail.com',966316982,612881182,'1997-07-17','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-05-18','Uixó, la','Castellón/Castelló',12002,'Constitución','16 1D'),
	 ('Francisco','Duran','Marin','1474607P','francisco.duran.marin@gmail.com',916658591,633527055,'1999-12-10','Marketing Digital y Análisis de Datos','ALUMNO','2023-05-11','Almàssera','Valencia/València',46002,'Rosalía de Castro','77 1A'),
	 ('Francisco','Ramirez','Gutierrez','4444980T','francisco.ramirez.gutierrez@gmail.com',930317698,625242423,'2005-03-23','Aprende a Programar desde Cero','ALUMNO','2023-05-25','Zerain','Gipuzkoa',20002,'Velázquez','36 4A'),
	 ('Natalia','Marquez','Fernandez','7219963X','natalia.marquez.fernandez@gmail.com',984781125,634570529,'2004-12-31','DevOps & Cloud Computing Full Stack','PROFESOR','','Lemoa','Bizkaia',48002,'Bartolomé Esteban Murillo','44 4Der.'),
	 ('Javier','Castillo','Santiago','6928864E','javier.castillo.santiago@gmail.com',966208665,637296651,'1991-01-01','Ciberseguridad Full Stack','PROFESOR','','Lebrija','Sevilla',41001,'Cristóbal Colón','56 4B'),
	 ('Yolanda','Romero','Cano','4395438T','yolanda.romero.cano@gmail.com',921163394,607035174,'2014-09-30','DevOps & Cloud Computing Full Stack','PROFESOR','','Santa Cruz de la Sierra','Cáceres',10002,'María Zambrano','8 4Izq.'),
	 ('Julia','Hernandez','Hernandez','4838174D','julia.hernandez.hernandez@gmail.com',969866109,622217919,'2013-03-30','Aprende a Programar desde Cero','PROFESOR','','Vedra','Coruña, A',15002,'Francisco Pizarro','3 2B'),
	 ('Amparo','Arias','Iglesias','8517269R','amparo.arias.iglesias@gmail.com',992396104,692425638,'1998-12-03','Ciberseguridad Full Stack','PROFESOR','','Villayón','Asturias',33001,'María Zambrano','98 2B'),
	 ('Marcos','Torres','Campos','6308004R','marcos.torres.campos@gmail.com',989282254,615443885,'1997-09-02','Desarrollo Web Full Stack','ALUMNO','2023-04-11','Isábena','Huesca',22001,'San Juan','49 1A'),
	 ('Maria dolores','Navarro','Ruiz','7495660Y','maria dolores.navarro.ruiz@gmail.com',982785473,655908819,'2009-01-29','Marketing Digital y Análisis de Datos','ALUMNO','2023-04-13','Quintanilla del Monte','Zamora',49002,'Federico García Lorca','65 1Der.'),
	 ('Maria mercedes','Ferrer','Castro','3342319M','maria mercedes.ferrer.castro@gmail.com',939035652,605126076,'2008-10-28','DevOps & Cloud Computing Full Stack','PROFESOR','','Robledo','Albacete',2003,'Rosalía de Castro','26 1Der.'),
	 ('Mercedes','Blanco','Ortega','3888514L','mercedes.blanco.ortega@gmail.com',985468258,684133753,'2017-02-16','Desarrollo Web Full Stack','ALUMNO','2023-04-30','Olmeda de las Fuentes','Madrid',28001,'Velázquez','74 2C'),
	 ('Maria mercedes','Ramos','Gil','1479794C','maria mercedes.ramos.gil@gmail.com',907565765,604541598,'1992-07-30','DevOps & Cloud Computing Full Stack','ALUMNO','2023-05-13','Proaza','Asturias',33001,'Francisco de Goya','60 3C'),
	 ('Consuelo','Carrasco','Rubio','1283277S','consuelo.carrasco.rubio@gmail.com',968456521,693428901,'1990-09-23','Marketing Digital y Análisis de Datos','PROFESOR','','Melque de Cercos','Segovia',40002,'Clara Campoamor','79 4B'),
	 ('Maria cristina','Arias','Romero','9136782D','maria cristina.arias.romero@gmail.com',950160231,685670427,'2000-11-27','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-04-25','Zorraquín','Rioja, La',26003,'Cristóbal Colón','71 1B'),
	 ('Agustin','Santos','Herrera','5881225X','agustin.santos.herrera@gmail.com',957869125,612720786,'2012-03-31','Desarrollo Web Full Stack','ALUMNO','2023-05-05','Alborea','Albacete',2001,'Mayor','35 2Izq.');
INSERT INTO keepcoding.datos_academia (nombre,primer_apellido,segundo_apellido,dni,email,telefono,movil,fecha_nacimiento,curso,rol,fecha_matriculacion,poblacion,estado,codigo_postal,via,ext) VALUES
	 ('Carolina','Navarro','Duran','7842421L','carolina.navarro.duran@gmail.com',940923520,621783969,'2003-10-07','Aprende a Programar desde Cero','ALUMNO','2023-05-29','Guadasséquies','Valencia/València',46005,'Nueva','65 3A'),
	 ('Rocio','Romero','Caballero','9024459H','rocio.romero.caballero@gmail.com',921026738,663090761,'1990-06-15','Ciberseguridad Full Stack','PROFESOR','','Navezuelas','Cáceres',10001,'Clara Campoamor','67 3Izq.'),
	 ('Francisco jose','Roman','Navarro','1750895C','francisco jose.roman.navarro@gmail.com',986609329,622945036,'1991-12-25','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-05-27','Valdáliga','Cantabria',39004,'España','96 3A'),
	 ('Elena','Ibañez','Gutierrez','1917275H','elena.ibañez.gutierrez@gmail.com',907941155,677226519,'2014-11-08','Ciberseguridad Full Stack','PROFESOR','','Benegiles','Zamora',49001,'Mercé Rodoreda','61 1A'),
	 ('Susana','Gil','Suarez','6378345P','susana.gil.suarez@gmail.com',943054804,630786052,'1995-04-15','Desarrollo Web Full Stack','ALUMNO','2023-04-16','Uixó, la','Castellón/Castelló',12002,'Eras','64 4A'),
	 ('Esther','Martinez','Sanchez','9964983A','esther.martinez.sanchez@gmail.com',931228193,604405208,'2006-11-09','DevOps & Cloud Computing Full Stack','PROFESOR','','Fuentepiñel','Segovia',40001,'Sol','83 3C'),
	 ('Eva maria','Sanz','Suarez','1221310X','eva maria.sanz.suarez@gmail.com',942936351,620496118,'2015-01-12','Marketing Digital y Análisis de Datos','PROFESOR','','Huerta de Arriba','Burgos',9002,'Pablo Picasso','66 4B'),
	 ('Celia','Ramos','Vazquez','6123526Y','celia.ramos.vazquez@gmail.com',922238803,674030201,'2008-12-05','Marketing Digital y Análisis de Datos','ALUMNO','2023-05-01','Zorraquín','Rioja, La',26003,'Pablo Picasso','14 3Izq.'),
	 ('Maria elena','Lopez','Ramirez','1544106R','maria elena.lopez.ramirez@gmail.com',923295826,618621587,'2014-08-15','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Alborea','Albacete',2001,'Gloria Fuertes','89 2C'),
	 ('Javier','Mendez','Medina','1100693M','javier.mendez.medina@gmail.com',900212619,658140929,'1994-11-08','Aprende a Programar desde Cero','ALUMNO','2023-04-10','Dehesas de Guadix','Granada',18001,'Madre Teresa de Calcuta','41 4Der.'),
	 ('Lorena','Carmona','Prieto','9481876B','lorena.carmona.prieto@gmail.com',927023027,654087833,'1991-10-04','Ciberseguridad Full Stack','ALUMNO','2023-05-29','Humilladero','Málaga',29001,'Mariana Pineda','10 3B'),
	 ('Jose','Carmona','Gonzalez','8701078V','jose.carmona.gonzalez@gmail.com',905999370,687652812,'2013-07-22','Ciberseguridad Full Stack','ALUMNO','2023-05-15','Hornachuelos','Córdoba',14001,'Mercé Rodoreda','42 4A'),
	 ('Felix','Lopez','Rojas','1800259A','felix.lopez.rojas@gmail.com',901569184,691080555,'2014-04-29','Marketing Digital y Análisis de Datos','PROFESOR','','Robledo','Albacete',2003,'San Juan','36 2A'),
	 ('Concepcion','Ibañez','Caballero','8110766T','concepcion.ibañez.caballero@gmail.com',980083812,660393202,'2008-12-03','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-04-18','Iglesias','Burgos',9003,'Concepción Arenal','63 4A'),
	 ('Carmen','Serrano','Sanchez','1189374K','carmen.serrano.sanchez@gmail.com',953709189,699805816,'2012-02-27','Aprende a Programar desde Cero','ALUMNO','2023-04-16','Alaminos','Guadalajara',19001,'Emilia Pardo Bazán','90 2Izq.'),
	 ('Maria','Vicente','Mendez','8299779E','maria.vicente.mendez@gmail.com',961374748,672974973,'1992-10-30','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Alaminos','Guadalajara',19001,'Fuente','42 3B'),
	 ('Maria antonia','Hidalgo','Rubio','3507960T','maria antonia.hidalgo.rubio@gmail.com',984194118,608581535,'2009-03-16','Desarrollo Web Full Stack','ALUMNO','2023-05-26','Proaza','Asturias',33001,'Pablo Picasso','31 1A'),
	 ('Salvador','Gil','Parra','4423770L','salvador.gil.parra@gmail.com',930927850,694084324,'2009-02-22','Ciberseguridad Full Stack','PROFESOR','','Santa Eugènia de Berga','Barcelona',8005,'San Juan','95 4Der.'),
	 ('Pilar','Castro','Santos','9522680J','pilar.castro.santos@gmail.com',986440616,678651693,'2002-06-23','Ciberseguridad Full Stack','ALUMNO','2023-05-08','Lebrija','Sevilla',41001,'Miguel Hernández','56 3Izq.'),
	 ('Eva maria','Rojas','Fuentes','6945095S','eva maria.rojas.fuentes@gmail.com',994516695,648723419,'2008-05-23','Ciberseguridad Full Stack','PROFESOR','','Quintanilla del Monte','Zamora',49002,'Francisco de Goya','63 4A'),
	 ('Fernando','Velasco','Aguilar','1795811V','fernando.velasco.aguilar@gmail.com',941749870,682320800,'2016-09-10','DevOps & Cloud Computing Full Stack','PROFESOR','','Jana, la','Castellón/Castelló',12001,'Agustina de Aragón','29 4D'),
	 ('Juan luis','Arias','Cruz','2545908S','juan luis.arias.cruz@gmail.com',950468574,633564966,'2008-06-05','Ciberseguridad Full Stack','PROFESOR','','Navezuelas','Cáceres',10001,'Pablo Picasso','99 2Izq.'),
	 ('Jose angel','Roman','Santos','9631509Y','jose angel.roman.santos@gmail.com',994017544,670724352,'2005-08-25','Aprende a Programar desde Cero','PROFESOR','','Palacios de la Valduerna','León',24003,'Hernán Cortés','52 2Der.'),
	 ('Concepcion','Dominguez','Bravo','9535827G','concepcion.dominguez.bravo@gmail.com',937939740,612947507,'2009-01-27','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Jana, la','Castellón/Castelló',12001,'Mayor','81 4Izq.'),
	 ('Rocio','Vidal','Carmona','6280059R','rocio.vidal.carmona@gmail.com',938869663,652010453,'2001-04-27','Aprende a Programar desde Cero','PROFESOR','','Rianxo','Coruña, A',15001,'Doctor Fleming','60 4C'),
	 ('Jose angel','Benitez','Navarro','5107397V','jose angel.benitez.navarro@gmail.com',913793300,656723945,'1994-01-08','DevOps & Cloud Computing Full Stack','ALUMNO','2023-05-21','Villarrasa','Huelva',21001,'Federico García Lorca','58 4Der.'),
	 ('Jesus','Suarez','Vargas','7899686Z','jesus.suarez.vargas@gmail.com',984479622,655769889,'1999-05-19','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Olmeda de las Fuentes','Madrid',28001,'Cristóbal Colón','30 3D'),
	 ('Ramon','Ortega','Carmona','2631011H','ramon.ortega.carmona@gmail.com',992649923,619917479,'2006-10-31','Desarrollo Web Full Stack','ALUMNO','2023-04-21','Lebrija','Sevilla',41001,'Isabel la Católica','21 4A'),
	 ('Jose francisco','Martin','Serrano','3074382H','jose francisco.martin.serrano@gmail.com',928800064,622013441,'2009-02-13','Desarrollo Web Full Stack','PROFESOR','','Fuentepiñel','Segovia',40001,'San Juan','91 2Izq.'),
	 ('Maria rosa','Crespo','Iglesias','9729659S','maria rosa.crespo.iglesias@gmail.com',997805025,668863557,'2005-07-03','DevOps & Cloud Computing Full Stack','PROFESOR','','Santoña','Cantabria',39003,'Isabel la Católica','95 4A'),
	 ('Jose ramon','Santiago','Marquez','1334663L','jose ramon.santiago.marquez@gmail.com',947951168,629391284,'2000-05-07','Aprende a Programar desde Cero','ALUMNO','2023-05-12','Carolina, La','Jaén',23001,'Madre Teresa de Calcuta','32 3C'),
	 ('Manuel','Ramirez','Aguilar','1739879K','manuel.ramirez.aguilar@gmail.com',915638849,666205168,'2017-01-27','DevOps & Cloud Computing Full Stack','PROFESOR','','Sayatón','Guadalajara',19001,'Real','78 3Der.'),
	 ('Luis miguel','Fernandez','Moreno','8031314J','luis miguel.fernandez.moreno@gmail.com',917121712,689460809,'2012-09-24','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-04-19','Piña de Esgueva','Valladolid',47001,'Federico García Lorca','20 2C'),
	 ('Jose','Ortiz','Muñoz','7158835Q','jose.ortiz.muñoz@gmail.com',963623798,670266230,'2001-10-26','Ciberseguridad Full Stack','PROFESOR','','Torresandino','Burgos',9006,'Concepción Arenal','70 4B'),
	 ('Manuela','Moreno','Fuentes','3638653F','manuela.moreno.fuentes@gmail.com',944035170,667736049,'1993-12-09','Marketing Digital y Análisis de Datos','ALUMNO','2023-05-12','Guadalmez','Ciudad Real',13001,'Hernán Cortés','28 1Izq.'),
	 ('Marta','Saez','Fernandez','4566066Z','marta.saez.fernandez@gmail.com',967980015,686427299,'2000-10-24','Desarrollo Web Full Stack','ALUMNO','2023-04-22','Cilleruelo de Arriba','Burgos',9001,'Nueva','11 3A'),
	 ('Lucia','Vicente','Nuñez','7566323J','lucia.vicente.nuñez@gmail.com',907007413,645234316,'2010-05-22','Ciberseguridad Full Stack','PROFESOR','','Sorihuela del Guadalimar','Jaén',23003,'Cristóbal Colón','77 3B'),
	 ('Jordi','Mora','Cano','2596195R','jordi.mora.cano@gmail.com',912457810,608278965,'1998-05-01','Aprende a Programar desde Cero','ALUMNO','2023-05-22','Sorihuela del Guadalimar','Jaén',23003,'Nueva','45 4Der.'),
	 ('Nuria','Garcia','Aguilar','3717175F','nuria.garcia.aguilar@gmail.com',959641492,636039733,'1993-05-09','Aprende a Programar desde Cero','ALUMNO','2023-04-24','Zerain','Gipuzkoa',20002,'Reina Sofía','59 3Der.'),
	 ('Domingo','Herrero','Rivera','3261618B','domingo.herrero.rivera@gmail.com',919799523,628250696,'2005-11-08','Ciberseguridad Full Stack','ALUMNO','2023-04-24','Biescas','Huesca',22001,'Isabel la Católica','46 2B'),
	 ('Jesus','Molina','Cortes','9344975Y','jesus.molina.cortes@gmail.com',900155407,602736723,'2012-06-10','Marketing Digital y Análisis de Datos','PROFESOR','','Real de Gandia, el','Valencia/València',46006,'Real','22 3Der.'),
	 ('Clara','Leon','Blanco','5835758Z','clara.leon.blanco@gmail.com',926872419,652390978,'1994-02-12','Marketing Digital y Análisis de Datos','ALUMNO','2023-04-15','Rozalén del Monte','Cuenca',16002,'Francisco de Goya','9 3C'),
	 ('Maria antonia','Pastor','Gimenez','6538682N','maria antonia.pastor.gimenez@gmail.com',906615101,648391464,'2005-10-13','Ciberseguridad Full Stack','PROFESOR','','Real de Gandia, el','Valencia/València',46006,'Miguel Hernández','34 4Der.'),
	 ('Laura','Fuentes','Sanz','1661448C','laura.fuentes.sanz@gmail.com',917990647,644933411,'2005-09-21','Ciberseguridad Full Stack','ALUMNO','2023-05-29','Sorihuela del Guadalimar','Jaén',23003,'María Zambrano','16 4A'),
	 ('Sofia','Roman','Garcia','2579542T','sofia.roman.garcia@gmail.com',994960425,627121230,'1996-07-09','DevOps & Cloud Computing Full Stack','PROFESOR','','Ripollet','Barcelona',8003,'Mercé Rodoreda','68 2Der.'),
	 ('Roberto','Cortes','Ortiz','5011143H','roberto.cortes.ortiz@gmail.com',932291843,623135972,'2003-12-25','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Tragacete','Cuenca',16003,'Francisco Pizarro','59 2B'),
	 ('Juan luis','Vicente','Mendez','8297289Q','juan luis.vicente.mendez@gmail.com',936970335,699811414,'2006-02-19','Ciberseguridad Full Stack','ALUMNO','2023-04-23','Camarillas','Teruel',44001,'Francisco Pizarro','80 1C'),
	 ('Maria jose','Marquez','Ortiz','2211949Q','maria jose.marquez.ortiz@gmail.com',943754956,695809473,'2015-05-22','Aprende a Programar desde Cero','PROFESOR','','Robledo','Albacete',2003,'Real','79 2D'),
	 ('Victor','Bravo','Santos','9371914N','victor.bravo.santos@gmail.com',931586741,664527198,'1999-06-08','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-05-23','Jana, la','Castellón/Castelló',12001,'San Juan','27 2D'),
	 ('Alberto','Vidal','Serrano','2641517J','alberto.vidal.serrano@gmail.com',938592610,616625435,'2000-07-01','Aprende a Programar desde Cero','ALUMNO','2023-05-09','Iglesias','Burgos',9003,'Antonio Machado','12 2B'),
	 ('Catalina','Martin','Ortiz','4935556D','catalina.martin.ortiz@gmail.com',977064751,624753461,'2016-12-31','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-04-16','Orellana la Vieja','Badajoz',6001,'Clara Campoamor','64 2C'),
	 ('Nerea','Prieto','Hernandez','8343960C','nerea.prieto.hernandez@gmail.com',919851086,613622266,'2011-08-20','Desarrollo Web Full Stack','PROFESOR','','Riudoms','Tarragona',43001,'Pablo Picasso','59 3C'),
	 ('Ricardo','Iglesias','Sanchez','2593536X','ricardo.iglesias.sanchez@gmail.com',933358213,606134066,'2010-05-03','Aprende a Programar desde Cero','PROFESOR','','Olmeda del Rey','Cuenca',16001,'Juan Ramón Jiménez','38 2Der.'),
	 ('Isabel','Molina','Herrera','5383461N','isabel.molina.herrera@gmail.com',906083065,602451344,'2000-10-21','Aprende a Programar desde Cero','PROFESOR','','Ripollet','Barcelona',8003,'Cristóbal Colón','92 4A'),
	 ('Alba','Prieto','Calvo','7745464F','alba.prieto.calvo@gmail.com',936064221,650956184,'2008-07-28','Marketing Digital y Análisis de Datos','PROFESOR','','Santibáñez de la Sierra','Salamanca',37001,'Agustina de Aragón','75 4B'),
	 ('Antonio','Parra','Suarez','4100403D','antonio.parra.suarez@gmail.com',949829836,607962853,'2011-03-16','Desarrollo Web Full Stack','PROFESOR','','Motilleja','Albacete',2002,'Federico García Lorca','49 2B'),
	 ('Mario','Nuñez','Vazquez','2511418W','mario.nuñez.vazquez@gmail.com',939889324,655847152,'1992-09-10','Marketing Digital y Análisis de Datos','ALUMNO','2023-04-28','Alborea','Albacete',2001,'Ramón y Cajal','30 2D'),
	 ('Marta','Soto','Hernandez','2133650D','marta.soto.hernandez@gmail.com',985564652,655901807,'1998-01-29','DevOps & Cloud Computing Full Stack','PROFESOR','','Campdevànol','Girona',17001,'Cristóbal Colón','47 3D'),
	 ('Jose manuel','Ramirez','Soto','4171793F','jose manuel.ramirez.soto@gmail.com',906748106,608473319,'1990-11-18','DevOps & Cloud Computing Full Stack','ALUMNO','2023-05-30','Infant','Tarragona',43003,'Mayor','92 2D'),
	 ('Maria jesus','Arias','Castillo','9443423Z','maria jesus.arias.castillo@gmail.com',972055502,651991574,'1998-03-27','Desarrollo Web Full Stack','PROFESOR','','Humilladero','Málaga',29001,'Dolores Ibárruri','31 1D'),
	 ('Lorena','Iglesias','Roman','9034507S','lorena.iglesias.roman@gmail.com',911088522,662702455,'2008-09-06','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-05-04','Cilleruelo de Arriba','Burgos',9001,'Federico García Lorca','100 2D'),
	 ('Alicia','Ruiz','Nieto','3481767G','alicia.ruiz.nieto@gmail.com',956459256,681171698,'2016-04-17','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Humilladero','Málaga',29001,'Iglesia','63 1Izq.'),
	 ('Eva maria','Mendez','Nieto','7064669N','eva maria.mendez.nieto@gmail.com',979910733,669253655,'2000-07-25','DevOps & Cloud Computing Full Stack','ALUMNO','2023-04-25','Lebrija','Sevilla',41001,'Federico García Lorca','17 2C'),
	 ('Ana isabel','Vega','Pastor','5230591T','ana isabel.vega.pastor@gmail.com',917768107,653608917,'2008-08-21','Aprende a Programar desde Cero','ALUMNO','2023-04-22','Sayatón','Guadalajara',19001,'Eras','13 1Der.'),
	 ('Amparo','Nieto','Vargas','4451567D','amparo.nieto.vargas@gmail.com',960719601,635637577,'1995-09-24','Marketing Digital y Análisis de Datos','PROFESOR','','Guadalmez','Ciudad Real',13001,'Dulcinea','96 2Der.'),
	 ('Jaime','Mora','Garcia','7973028D','jaime.mora.garcia@gmail.com',996010831,664798820,'2016-09-07','Ciberseguridad Full Stack','PROFESOR','','Amunt','Barcelona',8002,'Bartolomé Esteban Murillo','45 4Der.'),
	 ('Marcos','Campos','Campos','3787744N','marcos.campos.campos@gmail.com',905256076,605013991,'2003-05-01','Marketing Digital y Análisis de Datos','ALUMNO','2023-05-23','Almàssera','Valencia/València',46002,'Constitución','10 2B'),
	 ('Roberto','Guerrero','Peña','1900242M','roberto.guerrero.peña@gmail.com',944166478,641016738,'2010-01-02','DevOps & Cloud Computing Full Stack','ALUMNO','2023-04-25','Cilleruelo de Arriba','Burgos',9001,'Mercé Rodoreda','17 1C'),
	 ('Carla','Santos','Cortes','3592813Y','carla.santos.cortes@gmail.com',952308719,686303099,'2011-05-18','Desarrollo Web Full Stack','PROFESOR','','Sant Jaume dels Domenys','Tarragona',43002,'Pablo Picasso','57 1Der.'),
	 ('Maria elena','Gil','Martin','9655411B','maria elena.gil.martin@gmail.com',949242689,637611524,'2005-11-04','Desarrollo Web Full Stack','ALUMNO','2023-04-17','Amunt','Barcelona',8002,'Dolores Ibárruri','60 2Izq.'),
	 ('Eva maria','Mora','Alonso','3562652K','eva maria.mora.alonso@gmail.com',905565936,668293560,'2007-09-23','Aprende a Programar desde Cero','PROFESOR','','Manzaneda','Ourense',32001,'Reina Sofía','42 2C'),
	 ('Dolores','Cortes','Ortega','9574008M','dolores.cortes.ortega@gmail.com',949269495,691744940,'1990-07-14','Ciberseguridad Full Stack','ALUMNO','2023-05-15','Chantada','Lugo',27001,'Isabel la Católica','75 1A'),
	 ('Vicente','Medina','Gomez','5550815H','vicente.medina.gomez@gmail.com',962684488,633748024,'2010-09-14','Aprende a Programar desde Cero','ALUMNO','2023-05-21','Valle de Santa Ana','Badajoz',6002,'Miguel de Cervantes','38 2Izq.'),
	 ('Mateo','Gallego','Ruiz','6678000L','mateo.gallego.ruiz@gmail.com',906400541,681840634,'2004-08-07','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Cabrillanes','León',24001,'Gloria Fuertes','44 1Der.'),
	 ('Ines','Rodriguez','Aguilar','4686970F','ines.rodriguez.aguilar@gmail.com',950005358,609893938,'1996-11-20','Aprende a Programar desde Cero','PROFESOR','','Benegiles','Zamora',49001,'Nueva','30 3Der.'),
	 ('Claudia','Ortiz','Fuentes','2709962X','claudia.ortiz.fuentes@gmail.com',945515393,630413764,'2015-02-03','DevOps & Cloud Computing Full Stack','PROFESOR','','Santa Eugènia de Berga','Barcelona',8005,'Iglesia','11 2C'),
	 ('Juan','Gallego','Navarro','2647364H','juan.gallego.navarro@gmail.com',984697163,697105669,'2009-06-21','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Valle de Santa Ana','Badajoz',6002,'Miguel de Cervantes','57 1B'),
	 ('Oscar','Sanz','Duran','2817208F','oscar.sanz.duran@gmail.com',964348705,690829197,'1998-08-22','Aprende a Programar desde Cero','ALUMNO','2023-05-26','Benegiles','Zamora',49001,'Mercé Rodoreda','60 4A'),
	 ('Xavier','Lopez','Aguilar','9792546C','xavier.lopez.aguilar@gmail.com',919569431,610361641,'2008-02-25','Desarrollo Web Full Stack','ALUMNO','2023-04-24','Avinyó','Barcelona',8001,'Nueva','33 3B'),
	 ('Alfonso','Lozano','Peña','9869007Y','alfonso.lozano.peña@gmail.com',902719156,605395534,'1998-07-08','DevOps & Cloud Computing Full Stack','PROFESOR','','Urueñas','Segovia',40005,'María Zambrano','34 2A'),
	 ('Antonio','Leon','Herrero','4401378Y','antonio.leon.herrero@gmail.com',949809938,633224418,'2010-04-21','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-05-01','Tragacete','Cuenca',16003,'Antonio Machado','21 2Der.'),
	 ('Rosario','Castillo','Blanco','2791298H','rosario.castillo.blanco@gmail.com',973008160,627266223,'2002-07-02','Marketing Digital y Análisis de Datos','PROFESOR','','Ripollet','Barcelona',8003,'Constitución','52 2A'),
	 ('Margarita','Santana','Castillo','5358560C','margarita.santana.castillo@gmail.com',995997010,689913997,'1996-02-26','Aprende a Programar desde Cero','ALUMNO','2023-05-13','Iglesias','Burgos',9003,'María Zambrano','38 1Der.'),
	 ('Maria angeles','Vega','Jimenez','3314081B','maria angeles.vega.jimenez@gmail.com',960384243,631551927,'2016-03-07','Aprende a Programar desde Cero','PROFESOR','','Camponaraya','León',24002,'Agustina de Aragón','65 3B'),
	 ('Marcos','Garcia','Herrera','8119323R','marcos.garcia.herrera@gmail.com',918130755,668050315,'2007-07-23','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Turégano','Segovia',40004,'Fuente','1 3C'),
	 ('Juan luis','Santos','Diez','7835574A','juan luis.santos.diez@gmail.com',933624386,654846365,'2010-09-07','Ciberseguridad Full Stack','ALUMNO','2023-04-27','Alborea','Albacete',2001,'Miguel de Cervantes','15 2C'),
	 ('Tomas','Morales','Medina','3414104F','tomas.morales.medina@gmail.com',914773987,695978208,'2013-10-07','Marketing Digital y Análisis de Datos','PROFESOR','','Alcublas','Valencia/València',46001,'Mayor','41 1Izq.'),
	 ('Francisca','Delgado','Moya','9223061S','francisca.delgado.moya@gmail.com',903530670,642360967,'2012-07-20','Aprende a Programar desde Cero','ALUMNO','2023-05-04','Zorraquín','Rioja, La',26003,'Monjas','17 4A'),
	 ('Miguel angel','Peña','Vicente','2324282V','miguel angel.peña.vicente@gmail.com',939741933,664140067,'2005-02-28','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-05-23','Almàssera','Valencia/València',46002,'Agustina de Aragón','90 2Izq.'),
	 ('Alfredo','Sanchez','Ramirez','6171875D','alfredo.sanchez.ramirez@gmail.com',973306262,678252095,'2013-12-06','DevOps & Cloud Computing Full Stack','ALUMNO','2023-04-19','Zorraquín','Rioja, La',26003,'Ramón y Cajal','95 1Izq.'),
	 ('Gonzalo','Duran','Vargas','4795001F','gonzalo.duran.vargas@gmail.com',912040480,683736253,'2007-01-26','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Alborea','Albacete',2001,'San Juan','38 1Der.'),
	 ('Alberto','Campos','Vega','5301677Q','alberto.campos.vega@gmail.com',919269457,602530964,'2013-12-24','Ciberseguridad Full Stack','ALUMNO','2023-04-24','Villayón','Asturias',33001,'Madre Teresa de Calcuta','49 1A'),
	 ('Angel','Benitez','Nieto','4474375R','angel.benitez.nieto@gmail.com',940216778,696043632,'1999-08-03','DevOps & Cloud Computing Full Stack','PROFESOR','','Santa Cruz de la Zarza','Toledo',45001,'Monjas','65 4Der.'),
	 ('Marcos','Castro','Sanz','8400084R','marcos.castro.sanz@gmail.com',949211571,640516043,'1991-09-26','Marketing Digital y Análisis de Datos','PROFESOR','','Valfermoso de Tajuña','Guadalajara',19001,'San Juan','64 1B'),
	 ('Julia','Ortega','Medina','3806168J','julia.ortega.medina@gmail.com',944089401,609614491,'2003-11-22','Desarrollo Web Full Stack','ALUMNO','2023-04-13','Alaminos','Guadalajara',19001,'Emilia Pardo Bazán','16 2B'),
	 ('Maria elena','Lozano','Peña','4545781S','maria elena.lozano.peña@gmail.com',983458692,683359457,'1997-12-16','Marketing Digital y Análisis de Datos','PROFESOR','','Cidamón','Rioja, La',26001,'Doctor Fleming','100 2B'),
	 ('Lucas','Lozano','Torres','2994896C','lucas.lozano.torres@gmail.com',942820309,662101417,'1999-02-01','Desarrollo Web Full Stack','ALUMNO','2023-05-22','Carolina, La','Jaén',23001,'Real','53 2A'),
	 ('Hector','Castro','Crespo','6510599N','hector.castro.crespo@gmail.com',970937226,683995908,'1991-07-29','DevOps & Cloud Computing Full Stack','ALUMNO','2023-05-04','Zerain','Gipuzkoa',20002,'Clara Campoamor','50 4Izq.'),
	 ('Victor','Lozano','Moreno','9934879Y','victor.lozano.moreno@gmail.com',980743051,649479196,'1997-12-05','DevOps & Cloud Computing Full Stack','ALUMNO','2023-04-17','Gordexola','Bizkaia',48001,'Real','38 4Izq.'),
	 ('Mohamed','Iglesias','Benitez','6136437Z','mohamed.iglesias.benitez@gmail.com',903282139,630091032,'2016-04-09','Marketing Digital y Análisis de Datos','PROFESOR','','Jana, la','Castellón/Castelló',12001,'Agustina de Aragón','91 1Izq.');
INSERT INTO keepcoding.datos_academia (nombre,primer_apellido,segundo_apellido,dni,email,telefono,movil,fecha_nacimiento,curso,rol,fecha_matriculacion,poblacion,estado,codigo_postal,via,ext) VALUES
	 ('Isabel','Ruiz','Santana','5504814V','isabel.ruiz.santana@gmail.com',923543177,686940354,'2001-12-29','Desarrollo Web Full Stack','PROFESOR','','Santa Eugènia de Berga','Barcelona',8005,'Velázquez','35 4B'),
	 ('Lidia','Mendez','Nuñez','6201231V','lidia.mendez.nuñez@gmail.com',921622171,687682300,'1999-05-07','Marketing Digital y Análisis de Datos','PROFESOR','','Motilleja','Albacete',2002,'Gloria Fuertes','89 3C'),
	 ('Maria cristina','Suarez','Rivera','9483660R','maria cristina.suarez.rivera@gmail.com',950262536,684018013,'2003-02-03','Marketing Digital y Análisis de Datos','ALUMNO','2023-05-23','Uixó, la','Castellón/Castelló',12002,'Pablo Picasso','88 2D'),
	 ('Victor','Gimenez','Guerrero','5256250Z','victor.gimenez.guerrero@gmail.com',932288212,635242546,'2017-01-05','DevOps & Cloud Computing Full Stack','PROFESOR','','Pinilla de Molina','Guadalajara',19001,'Bartolomé Esteban Murillo','45 4B'),
	 ('Juan manuel','Garcia','Reyes','7658744C','juan manuel.garcia.reyes@gmail.com',908141707,663114744,'1996-01-26','Desarrollo Web Full Stack','PROFESOR','','Cidamón','Rioja, La',26001,'Velázquez','50 3Der.'),
	 ('Julia','Rojas','Delgado','5966573M','julia.rojas.delgado@gmail.com',970493179,663535538,'1996-05-07','Desarrollo Web Full Stack','PROFESOR','','Infant','Tarragona',43003,'María Zambrano','78 4D'),
	 ('Eva','Hidalgo','Crespo','1964967P','eva.hidalgo.crespo@gmail.com',967795378,651349039,'1994-06-22','Ciberseguridad Full Stack','ALUMNO','2023-05-26','Carolina, La','Jaén',23001,'Sol','84 2Der.'),
	 ('Clara','Peña','Garcia','1395733R','clara.peña.garcia@gmail.com',973019062,666596839,'2011-11-11','Desarrollo Web Full Stack','PROFESOR','','Riudoms','Tarragona',43001,'Madre Teresa de Calcuta','88 4B'),
	 ('Julian','Reyes','Mora','9417768G','julian.reyes.mora@gmail.com',929569522,612143041,'1990-05-23','Desarrollo Web Full Stack','PROFESOR','','Sestrica','Zaragoza',50001,'Miguel Hernández','71 1Izq.'),
	 ('Rosa maria','Iglesias','Saez','9812780Z','rosa maria.iglesias.saez@gmail.com',945256875,660941150,'2004-03-23','DevOps & Cloud Computing Full Stack','ALUMNO','2023-04-21','Guadalmez','Ciudad Real',13001,'Sol','65 3C'),
	 ('Maria pilar','Duran','Ramirez','4167232T','maria pilar.duran.ramirez@gmail.com',972764282,631064527,'2010-10-26','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Bidaurreta','Navarra',31001,'Constitución','16 1Izq.'),
	 ('Noelia','Dominguez','Moreno','4456606B','noelia.dominguez.moreno@gmail.com',983752845,600819462,'2001-11-23','Marketing Digital y Análisis de Datos','PROFESOR','','Dehesas de Guadix','Granada',18001,'Cristóbal Colón','56 2Der.'),
	 ('Miriam','Blanco','Torres','6982476K','miriam.blanco.torres@gmail.com',988030635,674044521,'1999-04-30','Marketing Digital y Análisis de Datos','PROFESOR','','Santa Cruz de la Sierra','Cáceres',10002,'Antonio Machado','73 4D'),
	 ('Sandra','Vargas','Pastor','7868475Z','sandra.vargas.pastor@gmail.com',948130922,622892645,'2009-06-26','Aprende a Programar desde Cero','PROFESOR','','Bidaurreta','Navarra',31001,'Real','93 2C'),
	 ('Maria rosa','Moya','Parra','5189170W','maria rosa.moya.parra@gmail.com',958975510,629844947,'1996-09-10','DevOps & Cloud Computing Full Stack','PROFESOR','','Infant','Tarragona',43003,'Ramón y Cajal','21 3Der.'),
	 ('Inmaculada','Ruiz','Romero','1901908S','inmaculada.ruiz.romero@gmail.com',999880160,629870459,'2012-08-08','Ciberseguridad Full Stack','PROFESOR','','Sant Pol de Mar','Barcelona',8004,'Concepción Arenal','34 2Izq.'),
	 ('Alba','Leon','Soto','8123981J','alba.leon.soto@gmail.com',932432491,680291107,'1994-10-03','Marketing Digital y Análisis de Datos','PROFESOR','','Pinilla de Molina','Guadalajara',19001,'Clara Campoamor','8 1D'),
	 ('Samuel','Perez','Rubio','3270165W','samuel.perez.rubio@gmail.com',953712891,654173982,'2007-07-07','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-04-22','Almenar de Soria','Soria',42001,'Concepción Arenal','47 2C'),
	 ('Jose francisco','Muñoz','Navarro','2305852X','jose francisco.muñoz.navarro@gmail.com',922721578,640709004,'1996-03-21','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Humilladero','Málaga',29001,'Monjas','99 2D'),
	 ('Gloria','Ramirez','Santiago','6565323L','gloria.ramirez.santiago@gmail.com',941316412,610935753,'2001-06-24','Ciberseguridad Full Stack','ALUMNO','2023-04-19','Alborea','Albacete',2001,'Reina Sofía','58 2D'),
	 ('Juan carlos','Campos','Gallego','4242076W','juan carlos.campos.gallego@gmail.com',904523368,692166535,'1997-05-18','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Taravilla','Guadalajara',19001,'Francisco de Goya','3 4Der.'),
	 ('Ramon','Lozano','Cortes','1957354P','ramon.lozano.cortes@gmail.com',998713584,677591708,'2011-12-22','Aprende a Programar desde Cero','ALUMNO','2023-05-07','Almenar de Soria','Soria',42001,'Miguel Hernández','93 2A'),
	 ('Carmen','Gallardo','Gallardo','1727624W','carmen.gallardo.gallardo@gmail.com',993420181,603373682,'2003-10-07','Aprende a Programar desde Cero','ALUMNO','2023-04-22','Ventosilla y Tejadilla','Segovia',40006,'Doctor Fleming','2 3Izq.'),
	 ('Maria luisa','Navarro','Sanchez','4858938G','maria luisa.navarro.sanchez@gmail.com',933595266,697740941,'1997-04-11','Marketing Digital y Análisis de Datos','ALUMNO','2023-05-29','Etxalar','Navarra',31001,'Sol','73 4B'),
	 ('Pedro','Blanco','Herrero','6276270F','pedro.blanco.herrero@gmail.com',939270445,669853009,'1993-10-29','DevOps & Cloud Computing Full Stack','PROFESOR','','Dehesas de Guadix','Granada',18001,'Reina Sofía','7 2D'),
	 ('Ignacio','Santiago','Cano','5654013S','ignacio.santiago.cano@gmail.com',956058898,636528455,'2004-11-06','Ciberseguridad Full Stack','PROFESOR','','Sabiote','Jaén',23002,'María Zambrano','92 3Izq.'),
	 ('Maria nieves','Ibañez','Guerrero','9074808C','maria nieves.ibañez.guerrero@gmail.com',905049321,676969748,'2007-04-14','Aprende a Programar desde Cero','ALUMNO','2023-04-16','Santa Eugènia de Berga','Barcelona',8005,'Dolores Ibárruri','81 1A'),
	 ('Julio','Medina','Martinez','8557412D','julio.medina.martinez@gmail.com',900731230,682291906,'2016-11-13','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Zorraquín','Rioja, La',26003,'Real','69 2D'),
	 ('Guillermo','Castro','Diez','7091259Z','guillermo.castro.diez@gmail.com',942527608,638019769,'1998-05-29','Marketing Digital y Análisis de Datos','ALUMNO','2023-04-30','Alcublas','Valencia/València',46001,'Monjas','51 2D'),
	 ('Jorge','Diaz','Diaz','9028431B','jorge.diaz.diaz@gmail.com',983090776,688159942,'2006-03-29','Aprende a Programar desde Cero','ALUMNO','2023-04-23','Gordexola','Bizkaia',48001,'España','60 3Der.'),
	 ('Angel','Rodriguez','Hidalgo','1714773P','angel.rodriguez.hidalgo@gmail.com',992562862,619365238,'1996-12-23','Ciberseguridad Full Stack','PROFESOR','','Hornachuelos','Córdoba',14001,'Constitución','7 1C'),
	 ('Raquel','Suarez','Cano','3716964A','raquel.suarez.cano@gmail.com',941298952,613381061,'1995-08-29','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-04-22','Villarrasa','Huelva',21001,'Rosalía de Castro','2 2A'),
	 ('Lucia','Carrasco','Molina','2462261L','lucia.carrasco.molina@gmail.com',927416540,630612691,'1999-09-15','DevOps & Cloud Computing Full Stack','PROFESOR','','Sant Jaume dels Domenys','Tarragona',43002,'Antonio Machado','2 3B'),
	 ('Rocio','Carrasco','Vega','9421399R','rocio.carrasco.vega@gmail.com',970159876,693386735,'2003-10-06','Aprende a Programar desde Cero','PROFESOR','','Isábena','Huesca',22001,'San Juan','48 4Izq.'),
	 ('Maria jesus','Lopez','Fuentes','4662873Z','maria jesus.lopez.fuentes@gmail.com',914641455,634180781,'2015-03-16','Marketing Digital y Análisis de Datos','PROFESOR','','Santoña','Cantabria',39003,'Mayor','75 4B'),
	 ('Maria pilar','Delgado','Ramirez','5150904P','maria pilar.delgado.ramirez@gmail.com',956128620,619058447,'2003-06-17','DevOps & Cloud Computing Full Stack','PROFESOR','','Pinilla de Molina','Guadalajara',19001,'Pablo Picasso','80 4B'),
	 ('Jose ramon','Ruiz','Ortiz','5333106G','jose ramon.ruiz.ortiz@gmail.com',986116889,668394872,'2008-02-01','DevOps & Cloud Computing Full Stack','PROFESOR','','Peñarrubia','Cantabria',39002,'Eras','63 4Izq.'),
	 ('Jose miguel','Vega','Caballero','5063009L','jose miguel.vega.caballero@gmail.com',910431671,665125714,'2017-03-08','Aprende a Programar desde Cero','ALUMNO','2023-05-29','Santa Cruz de la Zarza','Toledo',45001,'Concepción Arenal','90 2A'),
	 ('Juan','Leon','Navarro','8743633E','juan.leon.navarro@gmail.com',904517550,657947105,'1994-04-24','Marketing Digital y Análisis de Datos','PROFESOR','','Riudoms','Tarragona',43001,'Mayor','32 2Der.'),
	 ('Daniel','Mora','Gonzalez','2917321R','daniel.mora.gonzalez@gmail.com',964667107,668216796,'2003-10-28','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Villayón','Asturias',33001,'Miguel de Cervantes','79 1C'),
	 ('Juan luis','Carmona','Jimenez','8899501L','juan luis.carmona.jimenez@gmail.com',914645485,632499002,'2004-06-06','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Navezuelas','Cáceres',10001,'Mercé Rodoreda','27 1Der.'),
	 ('Samuel','Martin','Benitez','3276147G','samuel.martin.benitez@gmail.com',952364454,651700248,'1992-07-26','DevOps & Cloud Computing Full Stack','PROFESOR','','Chantada','Lugo',27001,'España','82 4Der.'),
	 ('Isabel','Romero','Pastor','7313476M','isabel.romero.pastor@gmail.com',928602751,600905817,'1998-12-19','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-05-30','Olmeda del Rey','Cuenca',16001,'Antonio Machado','86 2B'),
	 ('Ismael','Morales','Gimenez','3968516G','ismael.morales.gimenez@gmail.com',999981299,604550936,'1990-04-28','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Cidamón','Rioja, La',26001,'Mariana Pineda','82 4Der.'),
	 ('Juan','Cruz','Garrido','5395636C','juan.cruz.garrido@gmail.com',953079389,646952892,'1991-06-03','DevOps & Cloud Computing Full Stack','ALUMNO','2023-04-23','Almàssera','Valencia/València',46002,'Monjas','11 1C'),
	 ('Marina','Velasco','Fuentes','3773592M','marina.velasco.fuentes@gmail.com',980124887,679694926,'2004-05-13','Desarrollo Web Full Stack','PROFESOR','','Gordexola','Bizkaia',48001,'Concepción Arenal','88 1Izq.'),
	 ('Maria jesus','Castro','Moya','2498129F','maria jesus.castro.moya@gmail.com',945986529,628450848,'2001-01-15','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Bidaurreta','Navarra',31001,'Mayor','1 4D'),
	 ('Rosa maria','Hernandez','Peña','9940788G','rosa maria.hernandez.peña@gmail.com',961260893,696410696,'2003-03-02','DevOps & Cloud Computing Full Stack','PROFESOR','','Gallinero de Cameros','Rioja, La',26002,'Cristóbal Colón','40 3Izq.'),
	 ('Ana isabel','Diaz','Moya','8801332Z','ana isabel.diaz.moya@gmail.com',935602681,607143979,'2016-06-28','Ciberseguridad Full Stack','PROFESOR','','Piña de Esgueva','Valladolid',47001,'María Zambrano','66 2Izq.'),
	 ('Fatima','Montero','Sanz','7950695D','fatima.montero.sanz@gmail.com',913960922,638499888,'1999-07-20','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-04-21','Valfermoso de Tajuña','Guadalajara',19001,'Mercé Rodoreda','27 3Der.'),
	 ('Rocio','Reyes','Pascual','9464131E','rocio.reyes.pascual@gmail.com',986799866,679083908,'2015-06-04','Marketing Digital y Análisis de Datos','PROFESOR','','Campos del Río','Murcia',30001,'Federico García Lorca','50 4B'),
	 ('Francisca','Blanco','Montero','5791979G','francisca.blanco.montero@gmail.com',917327660,601365392,'1993-03-15','Ciberseguridad Full Stack','PROFESOR','','Sant Pol de Mar','Barcelona',8004,'España','96 1C'),
	 ('Jesus','Martin','Gonzalez','2837072E','jesus.martin.gonzalez@gmail.com',984183661,613579112,'2014-12-19','Marketing Digital y Análisis de Datos','PROFESOR','','Hornachuelos','Córdoba',14001,'Juan Ramón Jiménez','35 1Der.'),
	 ('Diego','Herrero','Bravo','7816165Y','diego.herrero.bravo@gmail.com',999818558,672187964,'2015-11-21','Desarrollo Web Full Stack','ALUMNO','2023-04-21','Dehesas de Guadix','Granada',18001,'Dolores Ibárruri','46 4Izq.'),
	 ('Jose ramon','Hernandez','Marquez','3563625M','jose ramon.hernandez.marquez@gmail.com',967960416,643656350,'1990-08-10','Desarrollo Web Full Stack','PROFESOR','','Sestrica','Zaragoza',50001,'Real','24 4B'),
	 ('Rosa','Muñoz','Alvarez','5922727C','rosa.muñoz.alvarez@gmail.com',965959794,646053984,'2011-05-11','Aprende a Programar desde Cero','ALUMNO','2023-05-26','Villatoro','Ávila',5001,'Dulcinea','3 3B'),
	 ('Juan luis','Calvo','Marquez','8802251J','juan luis.calvo.marquez@gmail.com',989496560,660912792,'2002-11-29','Desarrollo Web Full Stack','ALUMNO','2023-05-10','Tragacete','Cuenca',16003,'Madre Teresa de Calcuta','39 1D'),
	 ('Juan','Flores','Medina','5585393G','juan.flores.medina@gmail.com',934806776,661878127,'2008-05-26','DevOps & Cloud Computing Full Stack','PROFESOR','','Guadalmez','Ciudad Real',13001,'Reina Sofía','82 4B'),
	 ('Rocio','Herrero','Hidalgo','5724919N','rocio.herrero.hidalgo@gmail.com',915189770,687263173,'1993-04-20','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-04-18','Riudoms','Tarragona',43001,'Hernán Cortés','64 1C'),
	 ('Victor','Suarez','Hernandez','4435715G','victor.suarez.hernandez@gmail.com',949307216,686249515,'2008-07-25','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Villarrasa','Huelva',21001,'Real','63 4A'),
	 ('Lidia','Medina','Hidalgo','1916085R','lidia.medina.hidalgo@gmail.com',945903762,666022509,'1994-05-07','DevOps & Cloud Computing Full Stack','ALUMNO','2023-04-15','Zorraquín','Rioja, La',26003,'San Juan','75 1A'),
	 ('Maria jesus','Aguilar','Vega','6491400H','maria jesus.aguilar.vega@gmail.com',918699414,689448382,'1995-01-20','Aprende a Programar desde Cero','PROFESOR','','Olmeda de las Fuentes','Madrid',28001,'Doctor Fleming','91 2B'),
	 ('Silvia','Mendez','Gomez','9080256V','silvia.mendez.gomez@gmail.com',925002566,648379022,'2005-09-21','Aprende a Programar desde Cero','ALUMNO','2023-05-03','Cisneros','Palencia',34001,'Mayor','72 3D'),
	 ('Angel','Vargas','Garcia','6471283A','angel.vargas.garcia@gmail.com',947324003,691421317,'2016-12-01','DevOps & Cloud Computing Full Stack','ALUMNO','2023-05-10','Rozalén del Monte','Cuenca',16002,'Constitución','27 2A'),
	 ('Maria rosa','Serrano','Ruiz','2918175G','maria rosa.serrano.ruiz@gmail.com',989702221,613958125,'2005-07-16','DevOps & Cloud Computing Full Stack','ALUMNO','2023-05-07','Valle de Santa Ana','Badajoz',6002,'Reina Sofía','85 3A'),
	 ('David','Arias','Garrido','3772055D','david.arias.garrido@gmail.com',920231772,615377738,'2003-01-03','Desarrollo Web Full Stack','ALUMNO','2023-04-11','Taravilla','Guadalajara',19001,'Francisco Pizarro','49 2C'),
	 ('Jose miguel','Ibañez','Lorenzo','1499881M','jose miguel.ibañez.lorenzo@gmail.com',950733324,608586360,'2016-05-18','Marketing Digital y Análisis de Datos','PROFESOR','','Almàssera','Valencia/València',46002,'Francisco de Goya','83 4C'),
	 ('Maria teresa','Vicente','Ortega','6505423B','maria teresa.vicente.ortega@gmail.com',957110064,620001187,'1995-09-01','Marketing Digital y Análisis de Datos','PROFESOR','','Sayatón','Guadalajara',19001,'Nueva','70 2D'),
	 ('Sara','Duran','Peña','9651019N','sara.duran.peña@gmail.com',965406284,662855558,'2015-10-02','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-05-13','Lebrija','Sevilla',41001,'Rosalía de Castro','52 2Izq.'),
	 ('Maria cristina','Ruiz','Leon','2573757B','maria cristina.ruiz.leon@gmail.com',952979353,680957120,'2009-05-03','Ciberseguridad Full Stack','PROFESOR','','Ventosilla y Tejadilla','Segovia',40006,'Hernán Cortés','44 4D'),
	 ('Gabriel','Castro','Sanz','9453163W','gabriel.castro.sanz@gmail.com',958189852,645084307,'2014-05-14','Aprende a Programar desde Cero','ALUMNO','2023-05-13','Dehesas de Guadix','Granada',18001,'Real','62 4C'),
	 ('Daniel','Vazquez','Marquez','4920369W','daniel.vazquez.marquez@gmail.com',926697602,633880727,'2012-08-12','Desarrollo Web Full Stack','ALUMNO','2023-05-26','Torresandino','Burgos',9006,'Doctor Fleming','82 2A'),
	 ('Angel','Castro','Lozano','6217977L','angel.castro.lozano@gmail.com',992059627,663979994,'1999-10-13','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-05-10','Avinyó','Barcelona',8001,'Concepción Arenal','90 2Izq.'),
	 ('Francisca','Sanz','Sanchez','8854497A','francisca.sanz.sanchez@gmail.com',966102853,624905115,'1993-06-12','Ciberseguridad Full Stack','ALUMNO','2023-04-22','Torralba de los Sisones','Teruel',44002,'Sol','82 3Izq.'),
	 ('Marc','Alvarez','Vidal','4145096J','marc.alvarez.vidal@gmail.com',932103759,601145591,'2013-10-22','Aprende a Programar desde Cero','PROFESOR','','Melgar de Fernamental','Burgos',9005,'Isabel la Católica','20 4B'),
	 ('Francisca','Peña','Cruz','5829405D','francisca.peña.cruz@gmail.com',971394144,642150735,'2008-06-07','Ciberseguridad Full Stack','ALUMNO','2023-05-07','Medina de Pomar','Burgos',9004,'Isabel la Católica','2 2B'),
	 ('Angela','Soler','Garcia','7855600L','angela.soler.garcia@gmail.com',920055043,639185531,'2003-03-27','Desarrollo Web Full Stack','PROFESOR','','Castrelo do Val','Ourense',32001,'Dulcinea','7 4B'),
	 ('Maria antonia','Rojas','Alvarez','8498364W','maria antonia.rojas.alvarez@gmail.com',964577568,631955501,'2008-03-06','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Humilladero','Málaga',29001,'Clara Campoamor','27 2Der.'),
	 ('Sergio','Marin','Iglesias','3701572K','sergio.marin.iglesias@gmail.com',995346636,689327537,'2009-09-19','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-05-08','Villarrasa','Huelva',21001,'Antonio Machado','37 2Izq.'),
	 ('Rosario','Vazquez','Iglesias','7054379A','rosario.vazquez.iglesias@gmail.com',933423709,607290179,'2014-02-04','DevOps & Cloud Computing Full Stack','PROFESOR','','Biescas','Huesca',22001,'Fuente','84 3Der.'),
	 ('Lorena','Leon','Perez','3279694D','lorena.leon.perez@gmail.com',975765881,649329251,'1996-10-20','Desarrollo Web Full Stack','ALUMNO','2023-05-07','Cilleruelo de Arriba','Burgos',9001,'Agustina de Aragón','41 1A'),
	 ('Daniela','Torres','Benitez','4574170E','daniela.torres.benitez@gmail.com',921775630,675905530,'2007-08-13','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Iglesias','Burgos',9003,'Isabel la Católica','16 1Der.'),
	 ('Jose','Ruiz','Santiago','4539135Q','jose.ruiz.santiago@gmail.com',915921795,637146329,'2006-03-16','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-04-21','Sayatón','Guadalajara',19001,'Cristóbal Colón','84 3A'),
	 ('Elena','Arias','Romero','4863002C','elena.arias.romero@gmail.com',919373026,624997371,'2017-01-11','DevOps & Cloud Computing Full Stack','ALUMNO','2023-04-26','Valdáliga','Cantabria',39004,'Doctor Fleming','88 2Der.'),
	 ('Gabriel','Cabrera','Cano','9920540L','gabriel.cabrera.cano@gmail.com',933856777,638406203,'2011-04-08','Ciberseguridad Full Stack','ALUMNO','2023-04-20','Etxalar','Navarra',31001,'Miguel de Cervantes','69 4D'),
	 ('Teresa','Cortes','Leon','9886857P','teresa.cortes.leon@gmail.com',964839631,642514378,'2006-02-16','Desarrollo Web Full Stack','ALUMNO','2023-05-28','Zerain','Gipuzkoa',20002,'Nueva','81 3A'),
	 ('Maria concepcion','Dominguez','Roman','1500838L','maria concepcion.dominguez.roman@gmail.com',986028665,615962346,'1992-01-30','Marketing Digital y Análisis de Datos','ALUMNO','2023-04-18','Gallinero de Cameros','Rioja, La',26002,'Miguel Hernández','79 1A'),
	 ('Maria pilar','Castro','Velasco','6525585W','maria pilar.castro.velasco@gmail.com',972372347,658205031,'2008-05-21','Marketing Digital y Análisis de Datos','PROFESOR','','Bidaurreta','Navarra',31001,'Velázquez','90 1Izq.'),
	 ('Ivan','Jimenez','Vicente','6183965R','ivan.jimenez.vicente@gmail.com',971421249,666052244,'2017-05-12','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-05-21','Gordexola','Bizkaia',48001,'Federico García Lorca','44 1C'),
	 ('Sonia','Nuñez','Marquez','7269270M','sonia.nuñez.marquez@gmail.com',905213539,602433679,'1993-02-08','Marketing Digital y Análisis de Datos','PROFESOR','','Cilleruelo de Arriba','Burgos',9001,'Dolores Ibárruri','61 2Der.'),
	 ('Sergio','Rojas','Gonzalez','5880808F','sergio.rojas.gonzalez@gmail.com',986287781,631759186,'2008-12-19','Marketing Digital y Análisis de Datos','ALUMNO','2023-04-29','Manzaneda','Ourense',32001,'Real','99 3Izq.'),
	 ('Maria mercedes','Gallardo','Moya','9658768X','maria mercedes.gallardo.moya@gmail.com',929410296,686702879,'1998-05-15','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-04-15','Vedra','Coruña, A',15002,'Reina Sofía','71 1C'),
	 ('Pilar','Gutierrez','Vargas','1041217F','pilar.gutierrez.vargas@gmail.com',997925657,639441263,'2002-10-21','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-05-07','Humilladero','Málaga',29001,'Cristóbal Colón','87 1A'),
	 ('Maria cristina','Pascual','Peña','8104654Y','maria cristina.pascual.peña@gmail.com',980874196,669566599,'2003-10-21','Desarrollo Web Full Stack','PROFESOR','','Huerta de Arriba','Burgos',9002,'Mariana Pineda','15 4Der.'),
	 ('Pablo','Rojas','Reyes','3328311G','pablo.rojas.reyes@gmail.com',979315907,690077749,'2009-11-25','Desarrollo Web Full Stack','ALUMNO','2023-04-19','Ripollet','Barcelona',8003,'Pablo Picasso','57 2D'),
	 ('Felipe','Medina','Carmona','7489393H','felipe.medina.carmona@gmail.com',999366409,641361645,'2002-01-26','Aprende a Programar desde Cero','ALUMNO','2023-05-14','Uixó, la','Castellón/Castelló',12002,'Francisco de Goya','94 1Izq.'),
	 ('Jose angel','Soto','Blanco','8008141R','jose angel.soto.blanco@gmail.com',941116396,657945586,'1991-12-12','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-04-13','Pinilla de Molina','Guadalajara',19001,'Velázquez','50 1Der.'),
	 ('Maria','Ruiz','Sanchez','3577759V','maria.ruiz.sanchez@gmail.com',915895680,628420792,'1999-06-30','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-05-24','Sabiote','Jaén',23002,'Federico García Lorca','86 4A'),
	 ('Esther','Arias','Cano','6354412H','esther.arias.cano@gmail.com',966901500,647552429,'1992-05-07','Aprende a Programar desde Cero','PROFESOR','','Melgar de Fernamental','Burgos',9005,'María Zambrano','47 2Izq.'),
	 ('Laura','Iglesias','Saez','7019605M','laura.iglesias.saez@gmail.com',967207516,675313750,'2009-07-27','DevOps & Cloud Computing Full Stack','ALUMNO','2023-04-13','Campdevànol','Girona',17001,'Reina Sofía','47 4C');
INSERT INTO keepcoding.datos_academia (nombre,primer_apellido,segundo_apellido,dni,email,telefono,movil,fecha_nacimiento,curso,rol,fecha_matriculacion,poblacion,estado,codigo_postal,via,ext) VALUES
	 ('Francisca','Carmona','Pastor','6285743G','francisca.carmona.pastor@gmail.com',951464352,672904930,'2017-01-01','DevOps & Cloud Computing Full Stack','ALUMNO','2023-04-17','Medina de Pomar','Burgos',9004,'Gloria Fuertes','60 3D'),
	 ('Salvador','Arias','Medina','7642303R','salvador.arias.medina@gmail.com',944972130,671793748,'2008-05-18','Aprende a Programar desde Cero','ALUMNO','2023-04-11','Chantada','Lugo',27001,'Francisco Pizarro','8 2Der.'),
	 ('Catalina','Carmona','Marin','9231953Y','catalina.carmona.marin@gmail.com',975049423,653899183,'2010-11-04','Desarrollo Web Full Stack','PROFESOR','','Cidamón','Rioja, La',26001,'Francisco de Goya','80 4A'),
	 ('Adrian','Prieto','Cortes','9967683N','adrian.prieto.cortes@gmail.com',906306923,661765911,'2012-03-24','DevOps & Cloud Computing Full Stack','PROFESOR','','Zorraquín','Rioja, La',26003,'Miguel Hernández','24 3Der.'),
	 ('Maria soledad','Marquez','Vargas','6207077K','maria soledad.marquez.vargas@gmail.com',945338578,652965977,'1993-09-02','DevOps & Cloud Computing Full Stack','ALUMNO','2023-05-17','Ayora','Valencia/València',46003,'Eras','64 1D'),
	 ('Alejandro','Montero','Castro','8607873P','alejandro.montero.castro@gmail.com',917356990,611874328,'2007-03-08','Aprende a Programar desde Cero','ALUMNO','2023-05-19','Riudoms','Tarragona',43001,'Iglesia','58 2D'),
	 ('Amparo','Rodriguez','Guerrero','1543193P','amparo.rodriguez.guerrero@gmail.com',923736909,686845038,'2014-07-10','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-04-22','Itero de la Vega','Palencia',34002,'Concepción Arenal','42 3Der.'),
	 ('Claudia','Herrero','Ortega','3540777L','claudia.herrero.ortega@gmail.com',996447143,675322680,'1998-08-06','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-04-29','Rianxo','Coruña, A',15001,'Dulcinea','40 3Izq.'),
	 ('Hugo','Carrasco','Roman','3456948W','hugo.carrasco.roman@gmail.com',968839871,603796672,'2005-09-14','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Itero de la Vega','Palencia',34002,'España','21 4Der.'),
	 ('Ricardo','Nieto','Bravo','8650602A','ricardo.nieto.bravo@gmail.com',900389706,696507116,'1998-10-19','DevOps & Cloud Computing Full Stack','PROFESOR','','Castrelo do Val','Ourense',32001,'Pablo Picasso','3 1A'),
	 ('Alba','Lorenzo','Rubio','6561858G','alba.lorenzo.rubio@gmail.com',998418878,693712156,'2008-05-05','Aprende a Programar desde Cero','ALUMNO','2023-05-21','Motilleja','Albacete',2002,'Rosalía de Castro','56 3A'),
	 ('Guillermo','Alvarez','Gonzalez','1642332V','guillermo.alvarez.gonzalez@gmail.com',960971611,665153453,'1997-04-14','DevOps & Cloud Computing Full Stack','ALUMNO','2023-04-28','Humilladero','Málaga',29001,'Bartolomé Esteban Murillo','35 4B'),
	 ('Alex','Molina','Ferrer','4543883A','alex.molina.ferrer@gmail.com',923624382,608151093,'1998-06-03','Marketing Digital y Análisis de Datos','PROFESOR','','Alcublas','Valencia/València',46001,'Mariana Pineda','8 1Der.'),
	 ('Mario','Rojas','Perez','9121908Q','mario.rojas.perez@gmail.com',972134811,611887793,'2009-02-12','Ciberseguridad Full Stack','ALUMNO','2023-05-29','Villarrasa','Huelva',21001,'Eras','36 2Izq.'),
	 ('Jose manuel','Leon','Duran','7982912A','jose manuel.leon.duran@gmail.com',974306115,667152440,'2000-10-30','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Torralba de los Sisones','Teruel',44002,'Iglesia','95 3Der.'),
	 ('Irene','Ramos','Ortiz','2627756Y','irene.ramos.ortiz@gmail.com',929712248,606523462,'2006-05-13','Aprende a Programar desde Cero','ALUMNO','2023-04-23','Campdevànol','Girona',17001,'Mariana Pineda','11 3A'),
	 ('Victor','Torres','Velasco','4997054M','victor.torres.velasco@gmail.com',949962829,646782628,'1990-10-13','Desarrollo Web Full Stack','ALUMNO','2023-05-17','Manzaneda','Ourense',32001,'Miguel de Cervantes','28 4B'),
	 ('Maria nieves','Rojas','Moya','4657076J','maria nieves.rojas.moya@gmail.com',989095132,635807894,'1991-02-03','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Ripollet','Barcelona',8003,'España','61 3A'),
	 ('Rodrigo','Suarez','Nieto','6293980F','rodrigo.suarez.nieto@gmail.com',978787197,634913254,'2011-06-19','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-04-23','Valfermoso de Tajuña','Guadalajara',19001,'Eras','38 4D'),
	 ('Carla','Saez','Caballero','2587917A','carla.saez.caballero@gmail.com',916676472,671876494,'1994-02-03','Ciberseguridad Full Stack','PROFESOR','','Villatoro','Ávila',5001,'Doctor Fleming','42 3Izq.'),
	 ('Inmaculada','Gimenez','Martin','9763653S','inmaculada.gimenez.martin@gmail.com',972320407,695495422,'2010-01-21','Desarrollo Web Full Stack','ALUMNO','2023-04-15','Olmeda del Rey','Cuenca',16001,'Bartolomé Esteban Murillo','63 3Der.'),
	 ('Juan jose','Vazquez','Perez','9510974Z','juan jose.vazquez.perez@gmail.com',928514749,671591253,'2004-08-21','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Torresandino','Burgos',9006,'Miguel de Cervantes','7 1D'),
	 ('Joan','Molina','Benitez','1290523Q','joan.molina.benitez@gmail.com',903215399,642530055,'1995-02-14','Desarrollo Web Full Stack','PROFESOR','','Real de Gandia, el','Valencia/València',46006,'Sol','33 1Der.'),
	 ('Miriam','Garcia','Rivera','9086565R','miriam.garcia.rivera@gmail.com',901333039,640897374,'2002-05-05','Desarrollo Web Full Stack','ALUMNO','2023-05-07','Lemoa','Bizkaia',48002,'María Zambrano','49 3Izq.'),
	 ('Maria angeles','Santos','Mora','7816737A','maria angeles.santos.mora@gmail.com',935172779,636820623,'1992-02-27','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-05-21','Valcabado','Zamora',49003,'Nueva','40 3Izq.'),
	 ('Lucia','Suarez','Ibañez','5040831J','lucia.suarez.ibañez@gmail.com',942119976,681779763,'1991-05-15','Ciberseguridad Full Stack','ALUMNO','2023-05-02','Vedra','Coruña, A',15002,'Hernán Cortés','6 2B'),
	 ('Agustin','Herrero','Carmona','5318408A','agustin.herrero.carmona@gmail.com',963482058,626839592,'2004-05-07','Desarrollo Web Full Stack','ALUMNO','2023-04-17','Valdáliga','Cantabria',39004,'Francisco Pizarro','52 1Der.'),
	 ('Felix','Sanchez','Alvarez','4368291Q','felix.sanchez.alvarez@gmail.com',990597555,672288519,'1999-12-26','Ciberseguridad Full Stack','ALUMNO','2023-05-04','Zorraquín','Rioja, La',26003,'Francisco Pizarro','48 3B'),
	 ('Ana','Ruiz','Marin','5950239R','ana.ruiz.marin@gmail.com',928082417,659468088,'1996-03-24','Aprende a Programar desde Cero','ALUMNO','2023-05-05','Guadasséquies','Valencia/València',46005,'Iglesia','91 4D'),
	 ('Victoria','Fuentes','Hernandez','5520073G','victoria.fuentes.hernandez@gmail.com',981392990,600498386,'2012-02-14','Desarrollo Web Full Stack','PROFESOR','','Fuentepiñel','Segovia',40001,'Iglesia','24 3Izq.'),
	 ('Alicia','Nuñez','Garcia','6362902K','alicia.nuñez.garcia@gmail.com',988523724,683622410,'1997-05-03','Ciberseguridad Full Stack','PROFESOR','','Peñarrubia','Cantabria',39002,'Cristóbal Colón','86 4Izq.'),
	 ('Raul','Gomez','Gutierrez','4167969R','raul.gomez.gutierrez@gmail.com',955727428,697309378,'2012-05-13','Marketing Digital y Análisis de Datos','PROFESOR','','Quintanilla del Monte','Zamora',49002,'Antonio Machado','86 4Izq.'),
	 ('Andres','Martinez','Serrano','1546151E','andres.martinez.serrano@gmail.com',924299978,605022318,'2004-10-26','Desarrollo Web Full Stack','PROFESOR','','Almàssera','Valencia/València',46002,'Velázquez','21 4A'),
	 ('Maria isabel','Aguilar','Castillo','7701410K','maria isabel.aguilar.castillo@gmail.com',905021337,673841710,'2005-11-12','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-05-01','Real de Gandia, el','Valencia/València',46006,'Fuente','14 2Izq.'),
	 ('Pedro','Cortes','Gonzalez','5390770F','pedro.cortes.gonzalez@gmail.com',992344738,626368319,'2012-02-19','DevOps & Cloud Computing Full Stack','PROFESOR','','Villatoro','Ávila',5001,'España','6 1B'),
	 ('Francisco','Moya','Lorenzo','8069363C','francisco.moya.lorenzo@gmail.com',949582188,606029275,'1999-12-06','Desarrollo Web Full Stack','PROFESOR','','Robledo','Albacete',2003,'Dulcinea','80 3C'),
	 ('Nerea','Blanco','Saez','4759804T','nerea.blanco.saez@gmail.com',969954995,641477622,'2005-09-05','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Zorraquín','Rioja, La',26003,'Isabel la Católica','28 2A'),
	 ('Jose maria','Prieto','Vega','6859139X','jose maria.prieto.vega@gmail.com',907348755,623810777,'2014-10-02','Desarrollo Web Full Stack','PROFESOR','','Benigànim','Valencia/València',46004,'Bartolomé Esteban Murillo','36 4C'),
	 ('Maria teresa','Carrasco','Martin','8229814T','maria teresa.carrasco.martin@gmail.com',912765825,632145716,'2000-11-26','Marketing Digital y Análisis de Datos','PROFESOR','','Camarillas','Teruel',44001,'Madre Teresa de Calcuta','71 3Der.'),
	 ('Julio','Marquez','Fuentes','3058670S','julio.marquez.fuentes@gmail.com',980409750,635789759,'2011-08-23','Ciberseguridad Full Stack','ALUMNO','2023-04-15','Fuentepiñel','Segovia',40001,'Federico García Lorca','23 1A'),
	 ('Margarita','Caballero','Dominguez','1334944R','margarita.caballero.dominguez@gmail.com',917259742,614669717,'1998-07-28','Desarrollo Web Full Stack','PROFESOR','','Infant','Tarragona',43003,'Agustina de Aragón','31 1A'),
	 ('Maria dolores','Herrero','Cabrera','7741627B','maria dolores.herrero.cabrera@gmail.com',909144521,627537491,'1991-05-28','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Cabrillanes','León',24001,'Dulcinea','21 1D'),
	 ('Julio','Pastor','Ortega','7488139Y','julio.pastor.ortega@gmail.com',951342799,652640929,'2000-04-04','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-04-20','Benegiles','Zamora',49001,'Eras','56 3D'),
	 ('Juan manuel','Montero','Lopez','9519997K','juan manuel.montero.lopez@gmail.com',991970297,674088158,'2003-09-24','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Carolina, La','Jaén',23001,'Rosalía de Castro','12 1C'),
	 ('Juan francisco','Prieto','Arias','7254872M','juan francisco.prieto.arias@gmail.com',965585371,653940839,'1999-07-10','DevOps & Cloud Computing Full Stack','ALUMNO','2023-04-27','Gallinero de Cameros','Rioja, La',26002,'Constitución','37 1C'),
	 ('David','Moya','Diaz','3059614Q','david.moya.diaz@gmail.com',950942292,600617577,'1990-09-19','Aprende a Programar desde Cero','ALUMNO','2023-05-05','Medina de Pomar','Burgos',9004,'San Juan','94 4C'),
	 ('Felix','Crespo','Vega','5718646H','felix.crespo.vega@gmail.com',973537889,654106363,'1994-01-21','DevOps & Cloud Computing Full Stack','ALUMNO','2023-05-09','Lemoa','Bizkaia',48002,'Gloria Fuertes','39 4C'),
	 ('Victoria','Rivera','Hidalgo','1353445X','victoria.rivera.hidalgo@gmail.com',935313309,689106131,'2007-03-24','Aprende a Programar desde Cero','ALUMNO','2023-05-09','Villatoro','Ávila',5001,'Sol','64 1D'),
	 ('Eva maria','Montero','Mendez','8633377M','eva maria.montero.mendez@gmail.com',967069733,683492062,'1998-02-01','Aprende a Programar desde Cero','PROFESOR','','Guadasséquies','Valencia/València',46005,'Sol','94 2B'),
	 ('Rosa','Bravo','Hidalgo','9292523V','rosa.bravo.hidalgo@gmail.com',990038614,682685165,'1994-09-25','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Santibáñez de la Sierra','Salamanca',37001,'Eras','30 2Der.'),
	 ('Oscar','Delgado','Rojas','6559960S','oscar.delgado.rojas@gmail.com',962739023,615237654,'2013-11-20','Ciberseguridad Full Stack','ALUMNO','2023-05-15','Fuentepiñel','Segovia',40001,'Federico García Lorca','94 1D'),
	 ('Jose maria','Morales','Iglesias','2353733M','jose maria.morales.iglesias@gmail.com',970812906,627001042,'1994-07-24','Marketing Digital y Análisis de Datos','PROFESOR','','Ayora','Valencia/València',46003,'Velázquez','75 4Der.'),
	 ('Concepcion','Santana','Benitez','6673525Y','concepcion.santana.benitez@gmail.com',912541296,608832209,'2016-06-23','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-04-26','Cidamón','Rioja, La',26001,'Emilia Pardo Bazán','22 3A'),
	 ('Felix','Molina','Ortega','2432419P','felix.molina.ortega@gmail.com',929490107,620442224,'2009-03-11','Ciberseguridad Full Stack','ALUMNO','2023-05-07','Quintanilla del Monte','Zamora',49002,'Cristóbal Colón','71 4Izq.'),
	 ('Jose luis','Blanco','Roman','7873305Z','jose luis.blanco.roman@gmail.com',921650115,605429658,'1996-12-09','Marketing Digital y Análisis de Datos','ALUMNO','2023-04-22','Gordexola','Bizkaia',48001,'Rosalía de Castro','90 3A'),
	 ('Maria luisa','Gutierrez','Sanz','9512764X','maria luisa.gutierrez.sanz@gmail.com',918602295,621279309,'1998-03-23','Ciberseguridad Full Stack','PROFESOR','','Piña de Esgueva','Valladolid',47001,'Madre Teresa de Calcuta','95 1Der.'),
	 ('Maria dolores','Herrera','Ramos','8341716F','maria dolores.herrera.ramos@gmail.com',942536630,609451735,'1996-03-27','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-05-11','Sabiote','Jaén',23002,'Gloria Fuertes','98 2C'),
	 ('Elena','Sanchez','Gomez','9913947G','elena.sanchez.gomez@gmail.com',945593760,617798756,'2011-04-14','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-05-28','Rianxo','Coruña, A',15001,'Miguel Hernández','54 2Der.'),
	 ('Cesar','Vargas','Cortes','8830151Z','cesar.vargas.cortes@gmail.com',914005057,624179311,'1993-07-17','Marketing Digital y Análisis de Datos','PROFESOR','','Santa Cruz de la Zarza','Toledo',45001,'Mercé Rodoreda','25 4D'),
	 ('Paula','Crespo','Guerrero','1799966D','paula.crespo.guerrero@gmail.com',959555363,691211654,'2014-06-10','Aprende a Programar desde Cero','PROFESOR','','Tolosa','Gipuzkoa',20001,'Doctor Fleming','12 4D'),
	 ('Hector','Marin','Ferrer','4952790Q','hector.marin.ferrer@gmail.com',924805643,684149598,'2015-01-04','Desarrollo Web Full Stack','ALUMNO','2023-04-15','Tragacete','Cuenca',16003,'Velázquez','74 4Der.'),
	 ('Juan jose','Ruiz','Hidalgo','3105761W','juan jose.ruiz.hidalgo@gmail.com',921438324,622171304,'1992-02-16','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Ripollet','Barcelona',8003,'Rosalía de Castro','79 4A'),
	 ('Noelia','Herrero','Navarro','7862122D','noelia.herrero.navarro@gmail.com',945218382,635968540,'2010-03-31','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Santa Eugènia de Berga','Barcelona',8005,'Juan Ramón Jiménez','21 3D'),
	 ('Claudia','Martinez','Vazquez','5171798H','claudia.martinez.vazquez@gmail.com',918458061,660691469,'2008-03-05','DevOps & Cloud Computing Full Stack','ALUMNO','2023-05-23','Taravilla','Guadalajara',19001,'Juan Ramón Jiménez','65 4D'),
	 ('Francisco jose','Rivera','Arias','6934488B','francisco jose.rivera.arias@gmail.com',976239653,621286789,'2014-12-24','Ciberseguridad Full Stack','ALUMNO','2023-05-19','Cidamón','Rioja, La',26001,'Real','80 3Izq.'),
	 ('Joan','Mendez','Martin','2344684H','joan.mendez.martin@gmail.com',940391835,604066578,'1992-09-12','DevOps & Cloud Computing Full Stack','PROFESOR','','Almàssera','Valencia/València',46002,'Fuente','39 1D'),
	 ('Maria elena','Vicente','Rivera','7253587P','maria elena.vicente.rivera@gmail.com',902208788,643172311,'2009-09-09','Ciberseguridad Full Stack','PROFESOR','','Chantada','Lugo',27001,'Fuente','35 1D'),
	 ('Francisco','Cruz','Rodriguez','3970828Q','francisco.cruz.rodriguez@gmail.com',980585854,625808920,'1994-09-09','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Real de Gandia, el','Valencia/València',46006,'Eras','99 4Der.'),
	 ('Rosario','Blanco','Gimenez','2523797F','rosario.blanco.gimenez@gmail.com',900283492,613640475,'2001-01-29','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Motilleja','Albacete',2002,'Reina Sofía','28 2Izq.'),
	 ('Maria isabel','Pascual','Gallardo','5611768K','maria isabel.pascual.gallardo@gmail.com',925540985,639694814,'2000-09-02','Aprende a Programar desde Cero','ALUMNO','2023-04-12','Turégano','Segovia',40004,'Antonio Machado','33 2Izq.'),
	 ('Sebastian','Sanz','Gonzalez','5491641T','sebastian.sanz.gonzalez@gmail.com',909783986,620876736,'2008-09-21','Ciberseguridad Full Stack','ALUMNO','2023-05-02','Ripollet','Barcelona',8003,'María Zambrano','66 2Izq.'),
	 ('Joaquin','Castillo','Santana','7152176G','joaquin.castillo.santana@gmail.com',900192438,657358575,'2009-06-04','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-05-13','Rozalén del Monte','Cuenca',16002,'Hernán Cortés','50 1D'),
	 ('Josep','Marin','Santiago','6029387Y','josep.marin.santiago@gmail.com',987495812,634924732,'2004-03-04','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-05-30','Dehesas de Guadix','Granada',18001,'Iglesia','84 1A'),
	 ('Lorena','Herrero','Duran','8105656L','lorena.herrero.duran@gmail.com',931317040,677869349,'2010-02-07','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Real de Gandia, el','Valencia/València',46006,'Nueva','56 4D'),
	 ('Manuela','Rivera','Fuentes','6434138A','manuela.rivera.fuentes@gmail.com',922997400,626884220,'2005-08-03','Ciberseguridad Full Stack','PROFESOR','','Itero de la Vega','Palencia',34002,'Dulcinea','72 1C'),
	 ('Ana isabel','Marquez','Reyes','8540255X','ana isabel.marquez.reyes@gmail.com',958577430,680527614,'2004-06-02','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Chantada','Lugo',27001,'Fuente','21 2Der.'),
	 ('Maria','Martinez','Ramos','7222210A','maria.martinez.ramos@gmail.com',918755643,631644005,'1995-07-21','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Lemoa','Bizkaia',48002,'Monjas','26 2A'),
	 ('Alejandra','Lopez','Perez','2986522H','alejandra.lopez.perez@gmail.com',990556693,669214508,'2000-05-14','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Jana, la','Castellón/Castelló',12001,'Constitución','80 4D'),
	 ('Pilar','Martinez','Nuñez','9449124B','pilar.martinez.nuñez@gmail.com',928564412,698681295,'2013-06-13','Aprende a Programar desde Cero','ALUMNO','2023-04-27','Sestrica','Zaragoza',50001,'Dulcinea','79 1C'),
	 ('Teresa','Fuentes','Alvarez','7141207Y','teresa.fuentes.alvarez@gmail.com',909396451,638049794,'2000-09-09','Marketing Digital y Análisis de Datos','PROFESOR','','Uixó, la','Castellón/Castelló',12002,'Hernán Cortés','58 4B'),
	 ('Maria jose','Flores','Torres','3784380Y','maria jose.flores.torres@gmail.com',927520758,632227366,'1999-01-24','Aprende a Programar desde Cero','ALUMNO','2023-05-28','Melgar de Fernamental','Burgos',9005,'Rosalía de Castro','24 2C'),
	 ('Catalina','Vega','Moreno','6408785L','catalina.vega.moreno@gmail.com',924423926,604323624,'1991-09-21','Desarrollo Web Full Stack','ALUMNO','2023-04-22','Olmeda del Rey','Cuenca',16001,'Juan Ramón Jiménez','4 3D'),
	 ('Alberto','Gil','Gil','2347982G','alberto.gil.gil@gmail.com',983498014,667985592,'1991-10-18','Marketing Digital y Análisis de Datos','PROFESOR','','Tragacete','Cuenca',16003,'Francisco Pizarro','87 3A'),
	 ('Encarnacion','Ruiz','Martin','4526270P','encarnacion.ruiz.martin@gmail.com',991780614,686825611,'1998-03-28','DevOps & Cloud Computing Full Stack','PROFESOR','','Cisneros','Palencia',34001,'Concepción Arenal','7 3C'),
	 ('Jose ignacio','Vargas','Santiago','6400095T','jose ignacio.vargas.santiago@gmail.com',904767020,634630660,'2016-02-04','Marketing Digital y Análisis de Datos','PROFESOR','','Navezuelas','Cáceres',10001,'Mariana Pineda','40 1C'),
	 ('Rosa maria','Hidalgo','Fernandez','5017522A','rosa maria.hidalgo.fernandez@gmail.com',947411379,699310220,'1990-12-09','Ciberseguridad Full Stack','PROFESOR','','Peñarrubia','Cantabria',39002,'Bartolomé Esteban Murillo','52 4B'),
	 ('Lucas','Ortega','Pascual','2432605X','lucas.ortega.pascual@gmail.com',973890906,636815358,'2004-08-13','Aprende a Programar desde Cero','ALUMNO','2023-05-01','Iglesias','Burgos',9003,'Dulcinea','59 1B'),
	 ('Maria elena','Ramirez','Peña','9473631T','maria elena.ramirez.peña@gmail.com',976647742,600750412,'2010-05-10','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Manzaneda','Ourense',32001,'Doctor Fleming','65 1Izq.'),
	 ('Felix','Gutierrez','Montero','9507255K','felix.gutierrez.montero@gmail.com',934281738,642174749,'2015-11-08','Desarrollo Web Full Stack','ALUMNO','2023-04-17','Humilladero','Málaga',29001,'Francisco Pizarro','14 2D'),
	 ('Guillermo','Campos','Aguilar','2007614J','guillermo.campos.aguilar@gmail.com',919979605,658903450,'1993-10-02','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-05-26','Motilleja','Albacete',2002,'Dulcinea','47 3A'),
	 ('Mateo','Sanchez','Gil','9960082R','mateo.sanchez.gil@gmail.com',982414935,621544336,'2011-12-11','Desarrollo Web Full Stack','PROFESOR','','Valcabado','Zamora',49003,'Clara Campoamor','61 4B'),
	 ('Ines','Parra','Parra','4914885S','ines.parra.parra@gmail.com',993911237,639968135,'2002-11-07','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-05-11','Avinyó','Barcelona',8001,'Velázquez','19 2B'),
	 ('Andrea','Carmona','Caballero','5040245W','andrea.carmona.caballero@gmail.com',915410111,630354804,'2003-02-18','Marketing Digital y Análisis de Datos','PROFESOR','','Bidaurreta','Navarra',31001,'Concepción Arenal','23 4Der.'),
	 ('Maria nieves','Hidalgo','Sanchez','8360569T','maria nieves.hidalgo.sanchez@gmail.com',929517404,607956413,'1995-07-31','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-04-22','Manzaneda','Ourense',32001,'Mayor','93 2B'),
	 ('Emilio','Iglesias','Muñoz','6877148X','emilio.iglesias.muñoz@gmail.com',994848568,676316632,'2000-10-04','Aprende a Programar desde Cero','PROFESOR','','Cilleruelo de Arriba','Burgos',9001,'Hernán Cortés','50 3B'),
	 ('Martin','Campos','Soto','6768713C','martin.campos.soto@gmail.com',943916117,640470271,'1998-03-02','DevOps & Cloud Computing Full Stack','ALUMNO','2023-05-07','Campdevànol','Girona',17001,'Hernán Cortés','10 3A'),
	 ('Dolores','Nieto','Duran','7885880P','dolores.nieto.duran@gmail.com',976137999,636916312,'2000-09-09','DevOps & Cloud Computing Full Stack','PROFESOR','','Alaminos','Guadalajara',19001,'María Zambrano','63 2C'),
	 ('Juan','Caballero','Calvo','1651325V','juan.caballero.calvo@gmail.com',949554906,661014430,'2005-06-21','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Biescas','Huesca',22001,'Ramón y Cajal','66 3Der.'),
	 ('Ivan','Gil','Medina','6094976E','ivan.gil.medina@gmail.com',913304490,652256616,'2004-11-27','Marketing Digital y Análisis de Datos','ALUMNO','2023-05-05','Medina de Pomar','Burgos',9004,'Federico García Lorca','48 4C'),
	 ('Angel','Vega','Leon','1411960J','angel.vega.leon@gmail.com',973365271,668162908,'1998-02-23','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Ripollet','Barcelona',8003,'Iglesia','4 1A');
INSERT INTO keepcoding.datos_academia (nombre,primer_apellido,segundo_apellido,dni,email,telefono,movil,fecha_nacimiento,curso,rol,fecha_matriculacion,poblacion,estado,codigo_postal,via,ext) VALUES
	 ('Sonia','Vazquez','Campos','3092011Y','sonia.vazquez.campos@gmail.com',955301833,675726884,'2005-01-02','Desarrollo Web Full Stack','ALUMNO','2023-04-26','Motilleja','Albacete',2002,'Sol','8 2Izq.'),
	 ('Dolores','Perez','Sanz','1873801Z','dolores.perez.sanz@gmail.com',945798085,696167583,'1998-01-30','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Ventosilla y Tejadilla','Segovia',40006,'Isabel la Católica','79 1Der.'),
	 ('Sergio','Soto','Rojas','4625298K','sergio.soto.rojas@gmail.com',940700395,680993967,'2014-12-28','Marketing Digital y Análisis de Datos','PROFESOR','','Guadalmez','Ciudad Real',13001,'María Zambrano','49 4Izq.'),
	 ('Eva','Parra','Peña','4703104H','eva.parra.peña@gmail.com',927406375,655151763,'2016-01-05','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Zorraquín','Rioja, La',26003,'Eras','24 2Der.'),
	 ('Julio','Lorenzo','Ramos','9805286H','julio.lorenzo.ramos@gmail.com',946403455,642259085,'2000-03-24','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Piña de Esgueva','Valladolid',47001,'Federico García Lorca','2 4Der.'),
	 ('Maria rosa','Gil','Carrasco','8838689L','maria rosa.gil.carrasco@gmail.com',946790149,646858051,'1991-10-02','Ciberseguridad Full Stack','ALUMNO','2023-05-04','Real de Gandia, el','Valencia/València',46006,'Constitución','76 2C'),
	 ('Carolina','Calvo','Marin','5714730N','carolina.calvo.marin@gmail.com',908848194,622294813,'2013-05-19','Ciberseguridad Full Stack','PROFESOR','','Urueñas','Segovia',40005,'Cristóbal Colón','3 3A'),
	 ('Mariano','Romero','Gallego','1355209A','mariano.romero.gallego@gmail.com',981382027,612885667,'1991-05-31','Marketing Digital y Análisis de Datos','ALUMNO','2023-04-11','Ripollet','Barcelona',8003,'Mayor','82 3Der.'),
	 ('Maria antonia','Dominguez','Romero','8794519D','maria antonia.dominguez.romero@gmail.com',966586615,656527047,'2001-05-03','DevOps & Cloud Computing Full Stack','PROFESOR','','Turégano','Segovia',40004,'Antonio Machado','65 3Izq.'),
	 ('Daniel','Rodriguez','Romero','8762861E','daniel.rodriguez.romero@gmail.com',956878027,654047961,'1999-12-08','Marketing Digital y Análisis de Datos','PROFESOR','','Sabiote','Jaén',23002,'San Juan','34 1B'),
	 ('Marcos','Benitez','Gomez','4522377W','marcos.benitez.gomez@gmail.com',979318226,638906390,'1999-10-08','Ciberseguridad Full Stack','ALUMNO','2023-04-26','Santoña','Cantabria',39003,'Nueva','45 2D'),
	 ('Jose ignacio','Gonzalez','Carrasco','4543597Q','jose ignacio.gonzalez.carrasco@gmail.com',980869274,626389032,'2004-12-19','Aprende a Programar desde Cero','PROFESOR','','Orellana la Vieja','Badajoz',6001,'Cristóbal Colón','91 4C'),
	 ('Mario','Benitez','Ortiz','8687510L','mario.benitez.ortiz@gmail.com',951056364,608642406,'2006-08-17','Big Data, Inteligencia Artificial & Machine Learning Full Stack','PROFESOR','','Orellana la Vieja','Badajoz',6001,'Nueva','93 4Der.'),
	 ('Felix','Ramirez','Ibañez','2240242L','felix.ramirez.ibañez@gmail.com',901334367,673643501,'2006-09-11','DevOps & Cloud Computing Full Stack','PROFESOR','','Torresandino','Burgos',9006,'Cristóbal Colón','82 4D'),
	 ('Francisca','Navarro','Perez','5628901L','francisca.navarro.perez@gmail.com',960355894,629415536,'2002-12-15','Aprende a Programar desde Cero','ALUMNO','2023-05-10','Valfermoso de Tajuña','Guadalajara',19001,'San Juan','40 4Der.'),
	 ('Sandra','Garcia','Morales','6802133K','sandra.garcia.morales@gmail.com',926701108,671214713,'2002-07-27','Desarrollo Web Full Stack','PROFESOR','','Olaibar','Navarra',31001,'Constitución','30 1Izq.'),
	 ('Alejandro','Dominguez','Alvarez','5561214K','alejandro.dominguez.alvarez@gmail.com',935181503,654161793,'2002-11-23','Desarrollo Web Full Stack','PROFESOR','','Campos del Río','Murcia',30001,'Federico García Lorca','53 3B'),
	 ('Juan luis','Alvarez','Guerrero','5596360T','juan luis.alvarez.guerrero@gmail.com',981895571,686055343,'1993-10-29','Marketing Digital y Análisis de Datos','PROFESOR','','Guadalmez','Ciudad Real',13001,'Real','6 3B'),
	 ('Marta','Cruz','Molina','5997934V','marta.cruz.molina@gmail.com',901058449,687910614,'1998-12-10','Marketing Digital y Análisis de Datos','PROFESOR','','Lebrija','Sevilla',41001,'Hernán Cortés','94 4B'),
	 ('Agustin','Parra','Santos','5480202S','agustin.parra.santos@gmail.com',966317325,692954363,'2000-12-19','Aprende a Programar desde Cero','ALUMNO','2023-04-14','Pozal de Gallinas','Valladolid',47002,'Cristóbal Colón','15 1B'),
	 ('Rodrigo','Mora','Ramirez','4594820H','rodrigo.mora.ramirez@gmail.com',925758591,606777402,'2001-03-20','Aprende a Programar desde Cero','PROFESOR','','Jana, la','Castellón/Castelló',12001,'Isabel la Católica','83 3B'),
	 ('Felipe','Gutierrez','Cortes','8649032C','felipe.gutierrez.cortes@gmail.com',992467843,619310046,'1997-08-13','Ciberseguridad Full Stack','ALUMNO','2023-04-24','Etxalar','Navarra',31001,'María Zambrano','83 1Izq.'),
	 ('David','Delgado','Diaz','1497709H','david.delgado.diaz@gmail.com',900167405,632259855,'2011-02-27','Aprende a Programar desde Cero','ALUMNO','2023-05-27','Torralba de los Sisones','Teruel',44002,'Cristóbal Colón','62 4Der.'),
	 ('Roberto','Marquez','Alonso','1981453A','roberto.marquez.alonso@gmail.com',905191399,615511366,'2003-06-22','Desarrollo Web Full Stack','ALUMNO','2023-05-18','Lebrija','Sevilla',41001,'Constitución','1 1Izq.'),
	 ('Julian','Roman','Soto','5404410P','julian.roman.soto@gmail.com',993202420,618046427,'1991-04-20','DevOps & Cloud Computing Full Stack','ALUMNO','2023-05-29','Alcublas','Valencia/València',46001,'Miguel de Cervantes','57 3Der.'),
	 ('Alba','Perez','Ortega','3897801Z','alba.perez.ortega@gmail.com',930345893,635568125,'1992-03-19','Ciberseguridad Full Stack','ALUMNO','2023-04-27','Campdevànol','Girona',17001,'Mercé Rodoreda','51 3C'),
	 ('Xavier','Molina','Hidalgo','3552938J','xavier.molina.hidalgo@gmail.com',977235269,675406766,'2004-03-06','Aprende a Programar desde Cero','ALUMNO','2023-04-29','Camarillas','Teruel',44001,'Dolores Ibárruri','2 4A'),
	 ('Nerea','Benitez','Hidalgo','4705064T','nerea.benitez.hidalgo@gmail.com',901051920,664491328,'2009-11-17','DevOps & Cloud Computing Full Stack','ALUMNO','2023-04-16','Hornachuelos','Córdoba',14001,'Francisco Pizarro','49 3A'),
	 ('Victoria','Herrera','Flores','5560749Q','victoria.herrera.flores@gmail.com',999362898,675356169,'2013-10-04','Aprende a Programar desde Cero','PROFESOR','','Camarillas','Teruel',44001,'Juan Ramón Jiménez','24 2Izq.'),
	 ('Eva maria','Perez','Herrera','6532178V','eva maria.perez.herrera@gmail.com',970009193,631025206,'2009-02-10','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-04-30','Isábena','Huesca',22001,'Dulcinea','4 2B'),
	 ('Manuel','Vicente','Ferrer','4056180S','manuel.vicente.ferrer@gmail.com',994237756,670004990,'1995-08-30','DevOps & Cloud Computing Full Stack','ALUMNO','2023-04-21','Itero de la Vega','Palencia',34002,'Ramón y Cajal','77 3Der.'),
	 ('Maria','Fuentes','Ramirez','5370635C','maria.fuentes.ramirez@gmail.com',979037464,615809252,'2000-02-05','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Alcublas','Valencia/València',46001,'Velázquez','20 4D'),
	 ('Ignacio','Sanz','Crespo','5324175C','ignacio.sanz.crespo@gmail.com',934548603,669539360,'2006-05-02','Desarrollo Web Full Stack','ALUMNO','2023-05-27','Benigànim','Valencia/València',46004,'Miguel de Cervantes','88 1D'),
	 ('Angeles','Vargas','Cabrera','8881127E','angeles.vargas.cabrera@gmail.com',904298147,696226154,'2005-02-03','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-04-14','Sant Pol de Mar','Barcelona',8004,'Dulcinea','61 1Der.'),
	 ('Ricardo','Gutierrez','Blanco','1012421F','ricardo.gutierrez.blanco@gmail.com',972532219,620371898,'1992-09-03','Desarrollo Web Full Stack','ALUMNO','2023-04-11','Pedraza','Segovia',40003,'Bartolomé Esteban Murillo','12 2Der.'),
	 ('Lucia','Hernandez','Carrasco','4909075R','lucia.hernandez.carrasco@gmail.com',961454454,675406586,'1995-10-05','Aprende a Programar desde Cero','PROFESOR','','Urueñas','Segovia',40005,'Constitución','81 1D'),
	 ('Ricardo','Vargas','Vargas','4009671N','ricardo.vargas.vargas@gmail.com',944924582,687966708,'1992-07-16','Ciberseguridad Full Stack','PROFESOR','','Benigànim','Valencia/València',46004,'Constitución','91 4Der.'),
	 ('Sofia','Vargas','Carrasco','4922993G','sofia.vargas.carrasco@gmail.com',915500785,699925729,'2004-03-23','Desarrollo Web Full Stack','ALUMNO','2023-04-12','Torresandino','Burgos',9006,'Federico García Lorca','42 1D'),
	 ('Jose ramon','Gallego','Fuentes','9922272A','jose ramon.gallego.fuentes@gmail.com',951281477,621248501,'1991-07-23','Marketing Digital y Análisis de Datos','PROFESOR','','Valfermoso de Tajuña','Guadalajara',19001,'Madre Teresa de Calcuta','87 3Izq.'),
	 ('Miriam','Hernandez','Ortega','6502125W','miriam.hernandez.ortega@gmail.com',935912397,664227682,'1998-02-03','Aprende a Programar desde Cero','ALUMNO','2023-05-04','Infant','Tarragona',43003,'Monjas','17 2D'),
	 ('Maria isabel','Flores','Molina','5229916S','maria isabel.flores.molina@gmail.com',930998781,619733353,'2000-03-02','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-05-25','Gordexola','Bizkaia',48001,'Mayor','69 4B'),
	 ('Jordi','Ibañez','Lozano','2732222Y','jordi.ibañez.lozano@gmail.com',945433517,647215523,'1994-12-16','Marketing Digital y Análisis de Datos','PROFESOR','','Real de Gandia, el','Valencia/València',46006,'Dolores Ibárruri','65 2B'),
	 ('Josep','Reyes','Moya','1424396Y','josep.reyes.moya@gmail.com',929879982,692538096,'1998-01-09','DevOps & Cloud Computing Full Stack','ALUMNO','2023-04-15','Recuerda','Soria',42002,'Ramón y Cajal','97 3Izq.'),
	 ('Maria isabel','Roman','Herrero','3394870R','maria isabel.roman.herrero@gmail.com',902586331,635098473,'2003-07-11','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-05-20','Guadalmez','Ciudad Real',13001,'Mayor','14 2Izq.'),
	 ('Maria teresa','Santos','Carmona','5722476F','maria teresa.santos.carmona@gmail.com',993017630,612354451,'2010-03-02','DevOps & Cloud Computing Full Stack','PROFESOR','','Hornachuelos','Córdoba',14001,'España','33 3C'),
	 ('Ana','Moreno','Serrano','1021654V','ana.moreno.serrano@gmail.com',979035160,603970612,'1999-05-08','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-05-15','Fuentepiñel','Segovia',40001,'Mariana Pineda','7 1Izq.'),
	 ('Gonzalo','Gutierrez','Parra','6038556K','gonzalo.gutierrez.parra@gmail.com',933679747,672592859,'2005-07-06','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Avinyó','Barcelona',8001,'Madre Teresa de Calcuta','87 3A'),
	 ('Victor','Ferrer','Serrano','9579777R','victor.ferrer.serrano@gmail.com',968711676,664690767,'2007-04-16','Aprende a Programar desde Cero','PROFESOR','','Santa Cruz de la Zarza','Toledo',45001,'Bartolomé Esteban Murillo','45 3A'),
	 ('Natalia','Medina','Pastor','6239425P','natalia.medina.pastor@gmail.com',923152145,638271772,'1991-03-13','DevOps & Cloud Computing Full Stack','ALUMNO','2023-04-21','Valdáliga','Cantabria',39004,'Fuente','77 3B'),
	 ('Marta','Lorenzo','Guerrero','1732928Q','marta.lorenzo.guerrero@gmail.com',991375594,696830445,'2011-08-06','Ciberseguridad Full Stack','PROFESOR','','Santa Cruz de la Sierra','Cáceres',10002,'Miguel de Cervantes','42 2C'),
	 ('Rodrigo','Saez','Blanco','9024889B','rodrigo.saez.blanco@gmail.com',966508511,656910888,'1996-07-04','Desarrollo Web Full Stack','PROFESOR','','Alaminos','Guadalajara',19001,'Francisco de Goya','57 1Izq.'),
	 ('Celia','Campos','Nieto','5715635C','celia.campos.nieto@gmail.com',911222633,610937212,'2008-12-26','Aprende a Programar desde Cero','PROFESOR','','Navezuelas','Cáceres',10001,'Eras','19 2A'),
	 ('Sergio','Soler','Alonso','3599196H','sergio.soler.alonso@gmail.com',912670673,660425861,'2016-08-25','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-05-08','Vedra','Coruña, A',15002,'Monjas','31 1Der.'),
	 ('Gabriel','Ortiz','Vazquez','3344931H','gabriel.ortiz.vazquez@gmail.com',959620856,655242054,'1990-08-04','Marketing Digital y Análisis de Datos','ALUMNO','2023-04-22','Santoña','Cantabria',39003,'Miguel Hernández','14 2Izq.'),
	 ('Daniela','Benitez','Mora','9026661N','daniela.benitez.mora@gmail.com',975060315,681464502,'2015-05-12','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-04-23','Alcublas','Valencia/València',46001,'Dolores Ibárruri','7 4B'),
	 ('Francisco javier','Hernandez','Muñoz','6387931A','francisco javier.hernandez.muñoz@gmail.com',964198527,638960641,'1991-09-21','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Cilleruelo de Arriba','Burgos',9001,'España','53 1B'),
	 ('Alex','Iglesias','Moreno','4551278S','alex.iglesias.moreno@gmail.com',937942721,649507099,'2006-06-15','Aprende a Programar desde Cero','PROFESOR','','Villacidaler','Palencia',34003,'Emilia Pardo Bazán','72 4Izq.'),
	 ('Emilio','Jimenez','Gutierrez','4467499W','emilio.jimenez.gutierrez@gmail.com',976547271,698088430,'2002-06-18','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Real de Gandia, el','Valencia/València',46006,'San Juan','34 4C'),
	 ('Felix','Caballero','Lopez','2969136C','felix.caballero.lopez@gmail.com',975381600,627835717,'2003-12-06','Marketing Digital y Análisis de Datos','ALUMNO','2023-05-11','Porriño, O','Pontevedra',36001,'Bartolomé Esteban Murillo','40 2D'),
	 ('Jorge','Benitez','Moya','2263719J','jorge.benitez.moya@gmail.com',905632294,647042600,'2001-05-25','DevOps & Cloud Computing Full Stack','ALUMNO','2023-05-16','Chantada','Lugo',27001,'Dolores Ibárruri','57 2D'),
	 ('Lucia','Pascual','Vazquez','9766612F','lucia.pascual.vazquez@gmail.com',910128838,659405222,'2016-08-23','Aprende a Programar desde Cero','ALUMNO','2023-04-24','Pinilla de Molina','Guadalajara',19001,'Eras','93 1D'),
	 ('Mercedes','Crespo','Calvo','3354717Y','mercedes.crespo.calvo@gmail.com',942873590,678015200,'2015-01-08','Desarrollo Web Full Stack','PROFESOR','','Olmeda del Rey','Cuenca',16001,'Concepción Arenal','30 4A'),
	 ('Veronica','Garrido','Hernandez','6532322T','veronica.garrido.hernandez@gmail.com',936496333,662950968,'2002-09-30','Marketing Digital y Análisis de Datos','ALUMNO','2023-04-10','Vedra','Coruña, A',15002,'Isabel la Católica','19 1Izq.'),
	 ('Beatriz','Prieto','Crespo','7589340F','beatriz.prieto.crespo@gmail.com',921477583,628723971,'2013-09-18','Aprende a Programar desde Cero','PROFESOR','','Infant','Tarragona',43003,'Emilia Pardo Bazán','77 4Der.'),
	 ('Nerea','Mora','Santiago','6459133C','nerea.mora.santiago@gmail.com',998267269,626192556,'2001-10-07','DevOps & Cloud Computing Full Stack','PROFESOR','','Hornachuelos','Córdoba',14001,'Francisco de Goya','81 1D'),
	 ('Jose manuel','Medina','Santiago','5081294L','jose manuel.medina.santiago@gmail.com',909642101,661623728,'2011-10-09','Big Data, Inteligencia Artificial & Machine Learning Full Stack','ALUMNO','2023-05-26','Orellana la Vieja','Badajoz',6001,'Rosalía de Castro','39 1A'),
	 ('Ignacio','Herrera','Fernandez','9739336D','ignacio.herrera.fernandez@gmail.com',975917080,636427234,'2000-07-10','Desarrollo Web Full Stack','PROFESOR','','Villayón','Asturias',33001,'Pablo Picasso','28 1C'),
	 ('Eduardo','Prieto','Serrano','1858255Q','eduardo.prieto.serrano@gmail.com',942433879,683085281,'1991-04-28','DevOps & Cloud Computing Full Stack','PROFESOR','','Orellana la Vieja','Badajoz',6001,'María Zambrano','41 3Der.'),
	 ('Marcos','Carrasco','Vidal','1646570T','marcos.carrasco.vidal@gmail.com',989602716,659524387,'1993-05-13','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-04-22','Santibáñez de la Sierra','Salamanca',37001,'Eras','8 2A'),
	 ('Angeles','Dominguez','Cortes','3736264Y','angeles.dominguez.cortes@gmail.com',922986689,603060543,'2014-12-13','Aprende a Programar desde Cero','ALUMNO','2023-05-25','Uixó, la','Castellón/Castelló',12002,'Ramón y Cajal','36 3D'),
	 ('Juan','Ramos','Herrera','7016405W','juan.ramos.herrera@gmail.com',991807745,657365014,'1990-09-21','Desarrollo Web Full Stack','PROFESOR','','Huerta de Arriba','Burgos',9002,'Madre Teresa de Calcuta','72 3Der.'),
	 ('Agustin','Arias','Marin','2032734V','agustin.arias.marin@gmail.com',972117466,654693067,'2000-03-04','Desarrollo de Apps Móviles Full Stack','ALUMNO','2023-05-20','Chantada','Lugo',27001,'Cristóbal Colón','61 1C'),
	 ('Maria josefa','Vidal','Nieto','5957033X','maria josefa.vidal.nieto@gmail.com',902625477,617894088,'1991-07-17','Aprende a Programar desde Cero','ALUMNO','2023-05-14','Etxalar','Navarra',31001,'Cristóbal Colón','50 4Izq.'),
	 ('Alfredo','Campos','Gomez','1790461A','alfredo.campos.gomez@gmail.com',960022037,682949979,'1991-12-15','Marketing Digital y Análisis de Datos','ALUMNO','2023-05-11','Amunt','Barcelona',8002,'España','93 4A'),
	 ('Catalina','Mendez','Gomez','6376833Z','catalina.mendez.gomez@gmail.com',957409080,600068150,'2007-08-02','Marketing Digital y Análisis de Datos','PROFESOR','','Cisneros','Palencia',34001,'Francisco Pizarro','54 4Izq.'),
	 ('Noelia','Jimenez','Parra','6487438N','noelia.jimenez.parra@gmail.com',985743455,652273435,'2015-10-25','Desarrollo de Apps Móviles Full Stack','PROFESOR','','Alaminos','Guadalajara',19001,'Emilia Pardo Bazán','65 1Izq.'),
	 ('Alba','Prieto','Mendez','5155614A','alba.prieto.mendez@gmail.com',922285876,618020290,'2015-10-17','DevOps & Cloud Computing Full Stack','ALUMNO','2023-04-25','Villacidaler','Palencia',34003,'Mayor','26 1D'),
	 ('Teresa','Mendez','Rojas','6499657H','teresa.mendez.rojas@gmail.com',994634749,668902810,'2005-02-19','Aprende a Programar desde Cero','ALUMNO','2023-05-22','Melgar de Fernamental','Burgos',9005,'España','20 2D'),
	 ('Carla','Ramirez','Hidalgo','8556033X','carla.ramirez.hidalgo@gmail.com',918602233,616544629,'2004-02-02','DevOps & Cloud Computing Full Stack','ALUMNO','2023-05-08','Avinyó','Barcelona',8001,'Miguel de Cervantes','98 4C'),
	 ('Alejandra','Vicente','Velasco','7294159P','alejandra.vicente.velasco@gmail.com',971444477,627793277,'2007-03-06','DevOps & Cloud Computing Full Stack','ALUMNO','2023-04-26','Medina de Pomar','Burgos',9004,'Dolores Ibárruri','30 4A');

	
/*
 * Ahora vamos a trabajar. Lo primero que vamos a extraer son los datos 
 * de cursos únicos de la tabla sin normalizar datos_academia
 * 
 * Para ello vamos a hacer un SELECT de ese campo. Como en nuestro modelo de datos
 * tenemos una tabla curso que almacena el nombre y el año y el año no lo tenemos en la
 * tabla dacos_academia, añadimos directamente el valor en la consulta SELECT. Para 
 * sacar los valores sin repetir, agrupamos por curso:
 */

select 2023 as año, curso from keepcoding.datos_Academia group by curso;

/*
 * Esta consulta podemos usarla como fuente en un INSERT INTO.
 * 
 * ¡¡¡RECUERDA QUE EN INSERT INTO TENEMOS QUE PONER LOS NOMBRES DE LOS CAMPOS Y LOS VALORES
 * EN EL MISMO ORDEN!!!
 */

insert into keepcoding.curso (año, nombre) select 2023 as año, curso from keepcoding.datos_Academia group by curso;

/*
 * Vamos a continuar cargando los estados (o provincias, como mejor lo entiendas).
 * Para poder cargarlas, debemos crear primero un país, así que ejecutaremos un INSERT INTO en esa
 * tabla, pero esta vez con VALUES:
 */

insert into keepcoding.pais (nombre) values ('España');

/*
 * Para poder relacionar los estados o provincias con el país España que acabamos de crear,
 * primero tenemos que saber cual es su primary key:
 */

select id from keepcoding.pais where nombre = 'España';

/*
 * Con eso ya podemos proceder a insertar los estados, añadiendo el literal obtenido en la consulta anterior
 * como hemos hecho antes con el año al insertar los cursos. Para asegurarme que funciona siempre, voy a unir con la tabla
 * pais, y ordeno los estados alfabeticamente con ORDER BY.
 * 
 * Recuerda que al usar GROUP BY hay que agrupar por todas las columnas que tenemos que mostrar, o aplicar alguna función
 * de agregación como COUNT(), MIN(), MAX(), etcétera. Pero no es el caso aquí:
 */

insert into keepcoding.estado (id_pais, nombre) 
select p.id, da.estado
from keepcoding.datos_Academia da
inner join keepcoding.pais p on p.nombre = 'España'
group by da.estado, p.id
order by da.estado;

/* 
 * Bien, ahora ya tenenemos todos los estados únicos cargados.
 * Hagamos lo mismo con las poblaciones.
 * 
 * En este caso, tendremos que unir datos_academia con la tabla de estados para saber
 * las primary keys de las estados:
 */

insert into keepcoding.poblacion (id_estado, nombre)
select e.id, da.poblacion
from keepcoding.datos_Academia da
inner join keepcoding.estado e on e.nombre = da.estado
group by da.poblacion, e.id
order by da.poblacion;

/*
 * Lo siguiente que vamos a cargar son los códigos postales. Como bien se dio cuenta mucha gente en clase,
 * hay un error que no nos permite cargarlo: Algunas poblaciones tienen códigos postales repetidos.
 * Vamos a tratar de identificar que poblaciones son. 
 * 
 * Lo primero que vamos a hacer es agrupar las poblaciones, provincias y codigos postales juntos
 * para obtener todas las combinaciones:
 */

select da.codigo_postal, da.poblacion, da.estado
from keepcoding.datos_academia da
group by da.codigo_postal, da.poblacion, da.estado
order by da.codigo_postal;

/*
 * Una vez extraído, voy a tomarme la licencia de enseñaros a hacer algo que no ha dado tiempo en clase:
 * Una subconsulta. A una consulta ya existente, podemos aplicar otro SELECT si la envolvemos entre
 * paréntesis y le asignamos un alias.
 * 
 * Para solucionar el error, vamos a quedarnos con los códigos postales únicos que hay en datos_academia
 * y le asignamos la primera poblacion que encuentre con ese valor, utilizando MIN().
 * 
 * Unimos con las tablas poblacion y estado por si tuvieramos el caso de que una población pertenezca a dos estados.
 * 
 * Una vez hecho, podemos usar ese SELECT para insertar en la tabla de codigos postales.
 * 
 * Esta solución es la que creo que aplicaron algunos compañeros en clase, así que en vez de arreglar el 
 * conjunto de datos, os la paso aquí para que la podáis ver todos :)
 */

insert into keepcoding.codigo_postal (codigo_postal, id_poblacion)
select cp.codigo_postal, min(p.id) id_poblacion
from (
	select da.codigo_postal, da.poblacion, da.estado
	from keepcoding.datos_academia da
	group by da.codigo_postal, da.poblacion, da.estado
	order by da.codigo_postal
) cp
inner join keepcoding.estado e on e.nombre = cp.estado
inner join keepcoding.poblacion p on p.nombre = cp.poblacion and p.id_estado = e.id
group by cp.codigo_postal, e.id;

/*
 * Ahora lo que vamos a insertar son las diferentes vías. Agruparemos en este caso por codigo postal y provincia.
 * 
 * Lamentablemente, nos van a dar valores duplicados, con lo que podemos darnos cuenta de que, en el modelo de datos,
 * deberíamos haber relacionado codigos_postales_por_via con persona, en lugar de via.
 *
 * Vamos a alterar esa relación para poder cargar la información correctamente:
 * 
 */

alter table keepcoding.persona drop constraint pk_persona_via;
alter table keepcoding.persona add constraint pk_persona_codigo_postal_por_via foreign key (id_via) references keepcoding.codigo_postal_por_via(id);

insert into keepcoding.via (tipo_via, nombre)
select 'Calle' as tipo_via, da.via
from keepcoding.datos_academia da
group by da.via;

/* 
 * Y con esto ya podemos cargar los codigos postales por vía:
 */

insert into keepcoding.codigo_postal_por_via (codigo_postal, id_via)
select da.codigo_postal, v.id
from keepcoding.datos_academia da
inner join keepcoding.via v on v.nombre = da.via
group by da.codigo_postal, v.id , da.estado
order by da.codigo_postal;

/*
 * Por fin, en este punto podremos cargar los datos de las personas.
 * Para extraer el número y la extensión del campo ext de datos_academia usaremos la función
 * split_part() PostgreSQL. Esta función nos permite partir un valor por el caracter que necesitemos,
 * en este caso, por un espacio.
 * 
 * También convertiremos algunos tipos de datos con la función cast(), para que se adapten a los tipos de datos
 * de las tablas donde se va a almacenar.
 */

insert into keepcoding.persona (dni, nombre, primer_apellido, segundo_apellido, numero, ext, email, telefono, id_via)
select da.dni, da.nombre, da.primer_apellido, da.segundo_apellido, cast(split_part(ext, ' ', 1) as int) numero, split_part(ext, ' ', 2) ext, email, telefono, cp.id
from keepcoding.datos_academia da
inner join keepcoding.via v on v.nombre = da.via
inner join keepcoding.codigo_postal_por_via cp on cp.codigo_postal = cast(da.codigo_postal as varchar) and cp.id_via = v.id;


/*
 * Ya casi hemos terminado. Vamos a insertar las matrículas de los alumnos.
 * 
 * Para ello tenemos que filtrar por los registros que NO tengan fecha de matriculación en blanco.
 * 
 * Para eso, se utiliza != en lugar de igual. != significa "Distinto de"
 */

insert into keepcoding.matricula (dni_alumno, fecha_matriculacion, id_curso)
select da.dni, cast(da.fecha_matriculacion as date), c.id
from keepcoding.datos_academia da
inner join keepcoding.curso c on c.nombre = da.curso
where da.fecha_matriculacion != '';

/*
 * Y por último, los datos de los profesores. Este caso es similar pero filtrando por el rol.
 * 
 * Como no tenemos datos de seguridad social, guardamos el DNI dos veces
 */

insert into keepcoding.profesor (dni_profesor, seg_social)
select da.dni, da.dni
from keepcoding.datos_academia da
where da.rol = 'PROFESOR';

/*
 * Con todo cargado, podremos carganos la tabla datos_academia y vamos a recuperar los datos de nuestro modelo
 * normalizado.
 * 
 * Usamos left join en este caso cuando queremos recuperar todas las personas aunque no tengan datos relacionados en las tablas
 * de matricula ni curso.
 * 
 * De esta manera recuperamos todos los registros de personas sean o no alumnos.
 */

drop table keepcoding.datos_academia;


select p.dni, p.nombre, p.primer_apellido, p.segundo_apellido, v.nombre via, p.numero, p.ext, cp.codigo_postal, pb.nombre poblacion, e.nombre estado, m.fecha_matriculacion, c.nombre curso
from keepcoding.persona p
inner join keepcoding.codigo_postal_por_via cpv on p.id_via = cpv.id 
inner join keepcoding.via v on v.id = cpv.id_via 
inner join keepcoding.codigo_postal cp on cp.codigo_postal = cpv.codigo_postal
inner join keepcoding.poblacion pb on cp.id_poblacion = pb.id
inner join keepcoding.estado e on e.id = pb.id_estado
left join keepcoding.matricula m on p.dni = m.dni_alumno 
left join keepcoding.curso c on c.id = m.id_curso;


alter table keepcoding.estado add constraint pais_estado_unicos unique (id_pais, nombre);


alter table keepcoding.modulo add constraint modulo_unico unique (nombre);

insert into keepcoding.modulo (nombre) values 
	('Modelado de datos e iniciación a SQL'),
	('Fundamentos HTML y CSS3'),
	('Frontend Avanzado'),
	('Backend Avanzado'),
	('Git'),
	('Iniciación a Swift'),
	('Lenguaje Kotlin'),
	('IOS Avanzado'),
	('Patrones de diseño'),
	('NLP'),
	('SQL Avanzado'),
	('Estadística');



-- Producto cartesiano

alter table keepcoding.modulo_por_curso add constraint curso_modulo_unicos unique (id_curso, id_modulo);


insert into keepcoding.modulo_por_curso (dni_profesor, id_modulo, id_curso, fecha_inicio)
select p.dni_profesor, m.id , c.id, (now() - interval '14 day')::date fecha_inicio from keepcoding.curso c, keepcoding.modulo m 
join (select row_number() over (order by dni_profesor) num_profesor, *  from keepcoding.profesor) p on p.num_profesor = m.id
where c.nombre = 'Desarrollo Web Full Stack' and 
m.nombre in ('Modelado de datos e iniciación a SQL', 'Frontend Avanzado', 'Backend Avanzado', 'Git');


insert into keepcoding.modulo_por_curso (dni_profesor, id_modulo, id_curso, fecha_inicio)
select p.dni_profesor, m.id , c.id, (now() - interval '14 day')::date fecha_inicio from keepcoding.curso c, keepcoding.modulo m 
join (select row_number() over (order by dni_profesor) num_profesor, *  from keepcoding.profesor) p on p.num_profesor = m.id
where c.nombre = 'Desarrollo de Apps Móviles Full Stack' and 
m.nombre in ('Modelado de datos e iniciación a SQL', 'Git', 'Iniciación a Swift', 'Lenguaje Kotlin', 'IOS Avanzado', 'Patrones de diseño');

insert into keepcoding.modulo_por_curso (dni_profesor, id_modulo, id_curso, fecha_inicio)
select p.dni_profesor, m.id , c.id, (now() - interval '14 day')::date fecha_inicio from keepcoding.curso c, keepcoding.modulo m 
join (select row_number() over (order by dni_profesor) num_profesor, *  from keepcoding.profesor) p on p.num_profesor = m.id
where c.nombre = 'Big Data, Inteligencia Artificial & Machine Learning Full Stack' and 
m.nombre in ('Modelado de datos e iniciación a SQL', 'NLP', 'SQL Avanzado', 'Estadística');


select * from keepcoding.modulo_por_curso mpc;

select row_number() over (order by dni_profesor) num_profesor, *  from keepcoding.profesor;


alter table keepcoding.calificacion drop column apto;
alter table keepcoding.calificacion add column nota float check (nota >= 0 and nota <= 10);

select * from keepcoding.matricula m where m.id_curso = 2;

select * from keepcoding.modulo_por_curso mpc ;



select * from keepcoding.modulo_por_curso mpc where mpc.id_curso = 2;

insert into keepcoding.calificacion (dni_alumno, id_modulo_curso, nota)
select m.dni_alumno, mpc.id, (floor(random() * 16) * 0.5) + 2 from keepcoding.matricula m
join keepcoding.modulo_por_curso mpc on m.id_curso = mpc.id_curso 
left join keepcoding.calificacion c on c.dni_alumno = m.dni_alumno and mpc.id = c.id_modulo_curso
where c.nota is null;

select * from keepcoding.calificacion c 
join keepcoding.modulo_por_curso mpc on c.id_modulo_curso = mpc.id
join keepcoding.matricula m on m.dni_alumno = c.dni_alumno ;

select * from (
	(select * from keepcoding.calificacion c order by c.id desc limit 5)
	union
	(select * from keepcoding.calificacion c order by c.id desc offset 5 limit 5)
) a
order by id desc;


select *, 
case when nota >= 5 then 'Si'
 	 else 'No'
 	end apto
from keepcoding.calificacion c;


create view keepcoding.notas_medias as 
select p.dni, p.nombre, concat(substring(p.primer_apellido,1,1), substring(p.segundo_apellido,1,1)) apellidos, c.nombre nombre_curso, round(avg(cl.nota)::numeric, 2) note_media from keepcoding.calificacion cl
inner join keepcoding.modulo_por_curso mpc on cl.id_modulo_curso = mpc.id
inner join keepcoding.curso c on mpc.id_curso = c.id 
inner join keepcoding.persona p on p.dni = cl.dni_alumno
group by p.dni, p.nombre, p.primer_apellido, p.segundo_apellido, c.nombre;


create table keepcoding.tabla_notas_medias as 
select p.dni, p.nombre, concat(substring(p.primer_apellido,1,1), substring(p.segundo_apellido,1,1)) apellidos, c.nombre nombre_curso, round(avg(cl.nota)::numeric, 2) note_media from keepcoding.calificacion cl
inner join keepcoding.modulo_por_curso mpc on cl.id_modulo_curso = mpc.id
inner join keepcoding.curso c on mpc.id_curso = c.id 
inner join keepcoding.persona p on p.dni = cl.dni_alumno
group by p.dni, p.nombre, p.primer_apellido, p.segundo_apellido, c.nombre;


select * from keepcoding.notas_medias nm where nm.dni = '7925090A';
select * from keepcoding.tabla_notas_medias nm where nm.dni = '7925090A';


select * from keepcoding.calificacion c where c.dni_alumno = '7925090A';




