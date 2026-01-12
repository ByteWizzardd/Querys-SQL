--create database Empresa1;
--use Empresa1;

create table Empleados(
	idEmpleado int primary key not null,
	nombreEmpleado nvarchar (30) not null,
	salario float check (salario>0),
);
create table Clientes(
	idCliente int primary key not null,
	nombreCliente nvarchar(30),
);

create table ClientesBackup(
	idCliente int primary key not null,
	nombreCB nvarchar(30)
);

insert into Empleados(idEmpleado,nombreEmpleado,salario) values 
(1,'sara',50005),
(2,'franklin',60000),
(3,'larez',50000),
(4,'samuel',6320),
(5,'pedrito',4500),
(6,'vielmita',6900),
(7,'juan pablo',2000),
(8,'cristian',98),
(9,'maria',10000),
(10,'lusmilia',1);

insert into Clientes(idCliente,nombreCliente) values 
(1,'sara'),
(2,'franklin'),
(3,'larez'),
(4,'samuel'),
(5,'pedrito'),
(6,'vielmita'),
(7,'juan pablo'),
(8,'cristian'),
(9,'maria'),
(10,'lusmilia');

select * from Clientes;

select * from Empleados;

create procedure ActualizarSalario
As
Begin
	declare @idEmpleado int, @salarioNew decimal(18,2)
	--declaro cursor
	declare salario_cursor Cursor for 
	select idEmpleado,(salario+salario*0.10) as salarioNew
	from Empleados
	--abrir cursor
	open salario_cursor
	--obtener el primer registro 
	fetch next from salario_cursor into @idEmpleado,@salarioNew
	while @@FETCH_STATUS =0
	begin 
	--actualizar la tabla
	update Empleados
	set salario=@salarioNew
	where idEmpleado=@idEmpleado
	--obtener el siguiente registro
	fetch next from salario_cursor into @idEmpleado,@salarioNew;
	end;
	CLOSE salario_cursor;
    DEALLOCATE salario_cursor;
end;

EXEC ActualizarSalario;

--realizar un procedimeinto almacenado que copie el id y el nombre de los clientes en la tabla clientes backup, utilice cursores
create procedure CopiarIdNombre
As
Begin
	declare @idCliente int, @nCliente nvarchar(30)
	--declaro cursor
	declare copia_cursor Cursor for 
	select idCliente, nombreCliente as NombreCliente
	from Clientes
	--abrir cursor
	open copia_cursor
	--obtener el primer registro 
	fetch next from copia_cursor into @idCliente,@nCliente
	while @@FETCH_STATUS =0
	begin 
	--actualizar la tabla
	insert ClientesBackup(idCliente,nombreCB) values
	(@idCliente,@nCliente);
	--obtener el siguiente registro
	fetch next from copia_cursor into @idCliente,@nCliente;
	end;
	CLOSE copia_cursor;
    DEALLOCATE copia_cursor;
end;

exec CopiarIdNombre;

select * from ClientesBackup

create user usuariotemp without login;

grant select on Empleados to usuariotemp;

execute as user = 'usuariotemp';

select * from Clientes;

revert;