--use ClinicaVeterinaria
--1) insertar datos para consultas 
insert into Clientes(idCliente,nombre,ci,tlf,direccion) values 
(2,'sebas',30994215,0424555,'chilemex');

insert into Clientes(idCliente,nombre,ci,tlf,direccion) values 
(1,'sara',30994345,04243455,'guayana country'),
(6,'omar',3994345,04123455,'unare'),
(10,'magby',32994345,04243455,'los altos');


insert into Mascotas(idMascota,nombre,raza,fNacimiento,idCliente) values
(7,'didi','gato','2024/02/14',1),
(8,'michilina','gato','2020/02/14',1),
(10,'atenea','gato','2023/03/11',2),
(11,'canela','perro','2015/01/7',2);

insert into Veterinarios(idVeterinario,nombre,especialidad) values
(5,'vete1','cardiologo'),
(6,'vete2','cardiologo'),
(8,'vete3','psiquiatra'),
(9,'vete4','psiquiatra');

insert into Consultas(idConsulta,idMascota,fConsulta,motivo,diagnostico,idVeterinario,precio) values
(1,7,'2025/01/9','embarazo','que tenga a su bb',5,1500),
(2,8,GETDATE(),'obesidad','dieta',5,800),
(3,10,GETDATE(),'rasguño','curita',8,400),
(4,11,GETDATE(),'perdida de diente','resina',9,300);

insert into Tratamientos(idTratamiento,idConsulta,medicamento,dosis,duracionDias) values
(1,3,'alcohol','500ml',8),
(2,1,'anesteisa','30ml',1),
(3,8,'laxante','350ml',24);

insert into Vacunas(idVacuna,nombre,nombreLab,dosis,viaAplicacion,edadRecomendada) values
(1,'fiebrea amarilla','toxilab','85ml','inyeccion',1),
(2,'vitaminaD','toxilab','45ml','inyeccion',2),
(3,'esteroides','cliniLab','15ml','inyeccion',5),
(4,'antigripal','Clinilab','25ml','inyeccion',2);

insert into HistorialVacunacion(idHistorial,idVacuna,idMascota,fAplicacion,idVeterinario,observaciones)
values
(1,1,7,GETDATE(),5,'lloro'),
(2,2,7,GETDATE(),5,'no lloro'),
(3,3,8,GETDATE(),5,'lloro'),
(5,4,10,GETDATE(),5,'no lloro');

--2
select idConsulta,idMascota,fConsulta,motivo,diagnostico,idVeterinario
from Consultas
where idVeterinario = 
(select idVeterinario from Veterinarios 
where 
nombre ='vete1') 

--3
select idCliente,nombre from Clientes
where idCliente in(
select idCliente from Mascotas
where idMascota in
(
select idMascota from Consultas
group by idMascota
having SUM(precio)>500 
	)
)
--4
alter table Vacunas
add fVencimiento date

Update Vacunas
set fVencimiento = '2024/10/10'

update Vacunas
set fVencimiento = '2027/10/10'
where idVacuna = 2



update Vacunas 
set dosis = 'ninguna'
where fVencimiento < getDate();

update Vacunas 
set dosis = '25ml'
where fVencimiento > getDate();

select * from Vacunas

--5
select m.raza,SUM(c.precio) as precioConsulta from Mascotas as m,Consultas as c
where m.idMascota = c.idMascota
group by raza


--6 
select TOP 1 v.nombre, SUM(c.precio) as facturacion 
from Veterinarios as v, Consultas as c
where v.idVeterinario = c.idVeterinario
group by nombre
order by facturacion desc

--7
select nombre from Vacunas
where fVencimiento < GETDATE()

--8
select top 1 MONTH(fConsulta) as mes, count(*) as cantidad 
from Consultas
group by MONTH(fConsulta)
order by cantidad desc

--9
delete from Veterinarios
where idVeterinario not in (select distinct idVeterinario from Consultas)

select * from Consultas
select * from Veterinarios
where idVeterinario not in (select distinct idVeterinario from Consultas)

--10
select m.idMascota,m.nombre, MONTH(c.fConsulta) as mes, count(c.fConsulta) from Mascotas as m, Consultas as c
where m.idMascota=c.idMascota
and c.fConsulta >= DATEADD(MONTH,-1,GETDATE())
group by m.idMascota,m.nombre,MONTH(c.fConsulta)
having count(c.fConsulta)>3
