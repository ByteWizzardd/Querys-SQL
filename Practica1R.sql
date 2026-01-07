--primera parte
--create database ClinicaVeterinaria;
--use ClinicaVeterinaria;

create table Clientes(
	idCliente int primary key not null,
	nombre nvarchar(30),
	ci int unique not null , --clave alternativa
	tlf nvarchar(12),
	email nvarchar(30)
);

create table Mascotas(
	idMascota int primary key not null,
	nombre nvarchar(30),
	raza nvarchar(30),
	fNacimiento date,
	idCliente int,
	foreign key (idCliente) references Clientes (idCliente)
);

create table Veterinarios(
	idVeterinario int primary key not null,
	nombre nvarchar(30),
	especialidad nvarchar(30),
);

create table Consultas(
	idConsulta int primary key not null,
	idMascota int,
	fConsulta date,
	motivo nvarchar(30),
	diagnostico nvarchar(30),
	idVeterinario int,
	foreign key (idMascota) references Mascotas(idMascota),
	foreign key (idVeterinario) references Veterinarios(idVeterinario)
);

create table Tratamientos(
	idTratamiento int primary key not null,
	idConsulta int,
	medicamento nvarchar(30),
	dosis nvarchar(30),
	duracionDias int,
);

create table Vacunas(
	idVacuna int primary key not null,
	nombre nvarchar(30),
	nombreLab nvarchar(30),
	dosis nvarchar(30),
	viaAplicacion nvarchar(30),
	edadRecomendada int
);

create table HistorialVacunacion(
	idHistorial int primary key not null,
	idVacuna int,
	idMascota int,
	fAplicacion date,
	idVeterinario int,
	observaciones nvarchar(30),
	foreign key (idVacuna) references Vacunas(idVacuna),
	foreign key (idMascota) references Mascotas(idMascota),
	foreign key (idVeterinario) references Veterinarios(idVeterinario),

);
--segunda parte

alter table Consultas
add precio int not null

alter table Clientes
drop column email

alter table Clientes
add direccion nvarchar(30) not null

alter table Veterinarios 
add tlf nvarchar(12)
