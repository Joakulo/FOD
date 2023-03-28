program Practica1Ejercicio7;

type
	cad20=string[20];
	novela=record
		cod:integer;
		nombre:cad20;
		genero:cad20;
		precio:real;
	end;
	archivo=file of novela;

procedure CrearArchivo(var archLogico:archivo; var archFisico:cad20);
var
	carga:text;
	n:novela;
begin
	
	write('Ingrese el nombre del archivo: ');
	readln(archFisico);
	assign(archLogico, archFisico);
	rewrite(archLogico);
	assign(carga,'novelas.txt');
	reset(carga);
	while (not eof(carga)) do begin
		with n do readln(carga, cod, precio, genero);
		with n do readln(carga, nombre);
	end;
	writeln('Archivo cargado.');
	close(archLogico);
	close(carga);
end;

procedure LeerNovela(var n:novela);
begin
	with n do begin
		write('Ingrese el codigo: ');
		readln(cod);
		write('Ingrese el nombre: ');
		readln(nombre);
		write('Ingrese el genero: ');
		readln(genero);
		write('Ingrese el precio: ');
		readln(precio);
	end;
end;

procedure AgregarNovela(var archLogico:archivo);
var
	n:novela;
begin
	reset(archLogico);
	seek(archLogico,fileSize(archLogico));
	LeerNovela(n);
	write(archLogico,n);
	close(archLogico);
end;

procedure ModificarNovela(var archLogico:archivo);
var
	n:novela;
	cod:integer;
begin
	reset(archLogico);
	write('Ingrese el codigo de la novela a modificar: ');
	readln(cod);
	read(archLogico,n);
	while ((not eof(archLogico)) and (cod <> n.cod)) do begin
		read(archLogico,n);
	end;
	seek(archLogico,filePos(archLogico) - 1);
	write('Codigo antiguo: ', n.cod);
	write('Codigo nuevo: ');
	readln(n.cod);
	write('Precio antiguo: ', n.nombre);
	write('Precio nuevo: ');
	readln(n.precio);
	write('Genero antiguo: ', n.genero);
	write('Genero nuevo: ');
	readln(n.genero);
	write('Nombre antiguo: ', n.nombre);
	write('Nombre nuevo: ');
	readln(n.nombre);
	
end;

BEGIN
	
	
END.

