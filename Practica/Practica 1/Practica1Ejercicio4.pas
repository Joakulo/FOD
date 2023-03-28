program Practica1Ejercicio4;

type
	cad20=string[20];
	cadDNI=string[8];
	empleado = record
		nombre:cad20;
		apellido:cad20;
		edad:integer;
		nro:integer;
		DNI:cadDNI;
	end;
	archivo = file of empleado;

procedure LeerEmpleado(var e:empleado);
begin
	write('Ingrese el apellido: ');
	readln(e.apellido);
	if (e.apellido <> 'fin') then begin
		write('Ingrese el nombre: ');
		readln(e.nombre);
		write('Ingrese la edad: ');
		readln(e.edad);
		write('Ingrese el numero de empleado: ');
		readln(e.nro);
		write('Ingrese el DNI: ');
		readln(e.DNI);
	end;
end;

procedure crearArchivo(var archLogico:archivo; var archFisico:cad20);
var
	e:empleado;
begin
	write('Ingrese el nombre del archivo a crear: ');
	readln(archFisico);
	assign(archLogico, archFisico);
	rewrite(archLogico);
	LeerEmpleado(e);
	while (e.apellido <> 'fin') do begin
		write(archLogico, e);
		LeerEmpleado(e);
	end;
	close(archLogico);
end;

procedure MostrarPersona(e:empleado);
begin
    WriteLn('Nro Empleado: ',e.nro);
    WriteLn('Apellido: ',e.apellido);
    WriteLn('Nombre: ',e.nombre);
    WriteLn('Dni: ',e.dni);
    WriteLn('Edad: ',e.edad);
end;

procedure Incisoi(var archLogico:archivo);
var
	e:empleado;
	nombre:cad20;
begin
	write('Ingrese un nombre a buscar: ');
	readln(nombre);
	reset(archLogico);
	while (not eof(archLogico)) do begin
		read(archLogico, e);
		if ((e.nombre = nombre) or (e.apellido = nombre)) then
			MostrarPersona(e);
	end;
	close(archLogico);
end;

procedure Incisoii(var archLogico:archivo);
var
	e:empleado;
begin
	reset(archLogico);
	while (eof(archLogico)) do begin
		read(archLogico,e);
		MostrarPersona(e);
		writeln('____________________');
	end;
	close(archLogico);
end;

procedure Incisoiii(var archLogico:archivo);
var
	e:empleado;
begin
	reset(archLogico);
	while (not eof(archLogico)) do begin
		read(archLogico, e);
		if (e.edad > 70) then begin 
			MostrarPersona(e);
			writeln('____________________');
		end;
	end;
	close(archLogico);
end;

procedure IncisoA(var archLogico:archivo);
var
	e, aux:empleado;
	opcion:string;
	ok:boolean;
begin
	reset(archLogico);
	repeat
		ok:=true;
		LeerEmpleado(e);
		while ((not eof(archLogico)) and (ok)) do begin
			read(archLogico,aux);
			if (e.nro = aux.nro) then 
				ok:=false;
		end;
		if (not ok) then begin
			write(archLogico,e);
			writeln('Empleado aniadido');
		end else
			writeln('Empleado ya existente');
		write('Desea agregar otro empleado? ');
		readln(opcion);
	until opcion = 'No';
	close(archLogico);
end;

procedure IncisoB(var archLogico:archivo);
var
	nro:integer;
	aux:empleado;
	opcion:string;
begin
	reset(archLogico);
	repeat
		writeln('Ingrese un Nro de empleado a modificar; ');
		read(nro);
		read(archLogico, aux);
		while ((not eof(archLogico)) and (aux.nro <> nro)) do begin
			read(archLogico, aux);
		end;
		write('Ingrese la nueva edad: ');
		readln(nro);
		aux.nro:=nro;
		write('Desea modificar otra edad? ');
		readln(opcion);
	until opcion = 'No';
	close(archLogico);
end;

procedure IncisoC(var archLogico:archivo);
var
	carga:text;
	e:empleado;
begin
	assign(carga, 'Empleados.txt');
	reset(archLogico);
	rewrite(carga);
	while (not eof(archLogico)) do begin
		read(archLogico, e);
			with e do
				writeln(carga, ' ', nro, ' ', apellido, ' ', nombre, ' ', edad, ' ', DNI);
	end;
	writeln('Archivo exportado');
	close(archLogico);
	close(carga);
end;

procedure IncisoD (var archLogico:archivo);
var
	carga:text;
	e:empleado;
begin
	assign(carga, 'faltaDNIEmpleado.txt');
	reset(archLogico);
	rewrite(carga);
	while (not eof(archLogico)) do begin
		read(archLogico, e);
		if (e.DNI = '00') then begin
			with e do
				writeln(carga, ' ', nro, ' ', apellido, ' ', nombre, ' ', edad, ' ', DNI);
		end;
	end;
	writeln('Archivo exportado');
	close(archLogico);
	close(carga);
end;

procedure Menu ();
var
	opcion:integer;
	archFisico:cad20;
	archLogico:archivo;
begin
	opcion:=0;
	while (opcion <> 9) do begin
		writeln('_______________________');
		writeln('1 | Crear un Archivo con empleados');
		writeln('2 | Datos de Empleados con un apellido predeterminado');
		writeln('3 | Mostrar todos la Empleados');
		writeln('4 | Mostrar las Empleados mayores de 70');
        writeln('5 | Aniadir empleado');
        writeln('6 | Modificar edades');
        writeln('7 | Exportar contenido a un .txt');
        writeln('8 | Exportar empleados sin DNI a un .txt');
        writeln('9 | Cerrar Menu');
		write('Opcion: ');
		readln(opcion);
		writeln('_______________________');
		case opcion of
			1:CrearArchivo(archLogico,archFisico);
			2:Incisoi(archLogico);
			3:Incisoii(archLogico);
			4:Incisoiii(archLogico);
			5:IncisoA(archLogico);
			6:IncisoB(archLogico);
			7:IncisoC(archLogico);
			8:IncisoD(archLogico);
			9:writeln('Archivo cerrado');
			else writeln('Numero Invalido');
		end;
	end;
end;

BEGIN
	Menu();	
END.

