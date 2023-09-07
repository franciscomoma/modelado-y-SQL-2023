create schema keepcoding;

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
