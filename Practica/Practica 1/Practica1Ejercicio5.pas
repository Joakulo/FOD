program Practica1Ejercicio5;

type
	cad20=string[20];
	celulares=record
		cod:integer;
		nombre:cad20;
		desc:cad20;
		marca:cad20;
		precio:real;
		stockMin:integer;
		stockDis:integer;
	end;
	archivo = file of celulares;

procedure CrearArchivo(var archLogico:archivo; var archFisico:cad20);
var
	carga: text;
	c:celulares;
begin
	write('Ingrese un nombre de archivo: ');
	readln(archFisico);
	assign(archLogico, archFisico);
	assign(carga, 'celulares.txt');
	rewrite(archLogico);
	reset(carga);
	while (not eof(carga)) do begin
		with c do readln(carga, cod, precio, marca);
		with c do readln(carga, stockDis, stockMin,desc);
        with c do readln(carga, nombre);
        write(archLogico, c)
	end;
	writeln('Archivo cargado');
	close(archLogico);
	close(carga);
end;

procedure ListarStock(var archLogico:archivo);
var
	c:celulares;
begin
	reset(archLogico);
	while (not eof(archLogico)) do begin
		read(archLogico,c);
		if (c.stockDis < c.stockMin) then begin
			with c do begin
				WriteLn('Codigo: ',cod);
				writeln('Nombre:', nombre);
				writeln('Descripcion:', desc);
				WriteLn('Marca: ',marca);
				writeln('Precio:', precio:2:2);
				WriteLn('Stock Minimo:',stockMin);
				writeln('Stock:', stockDis);
				WriteLn('_________');
			end;
		end;
	end;
	close(archLogico);
end;

procedure ListarDesc(var archLogico:archivo);
var
	c:celulares;
	UserDesc:cad20;
begin
	reset(archLogico);
	write('Ingrese una descripcion a buscar: ');
	readln(UserDesc);
	while (not eof(archLogico)) do begin
		read(archLogico,c);
		UserDesc:=Concat(' ',UserDesc); 
		if (UserDesc = c.desc) then begin
			with c do begin
				WriteLn('Codigo: ',cod);
				writeln('Nombre: ', nombre);
				writeln('Descripcion: ', desc);
				WriteLn('Marca: ',marca);
				writeln('Precio: ', precio:2:2);
				WriteLn('Stock Minimo: ',stockMin);
				writeln('Stock: ', stockDis);
				WriteLn('_________');
			end;
		end;
	end;
	close(archLogico);
end;

procedure ExportarArchivo(var archLogico:archivo);
var
	c:celulares;
	carga:text;
begin
	reset(archLogico);
	assign(carga,'celulares.txt');
	rewrite(carga);
	while (not eof(archLogico)) do begin
		read(archLogico,c);
			with c do begin
				writeln(carga, cod, precio, marca);
				writeln(carga, stockDis, stockMin,desc);
				writeln(carga, nombre);
			end;
	end;
end;

procedure Menu();
var
	archLogico:archivo;
	archFisico:cad20;
	opcion:integer;
begin
	opcion:=0;
	while (opcion <> 5) do begin
		writeln('1 | Crear archivo');
		writeln('2 | Listar celulares con poco stock');
		writeln('3 | Listar celulares por descripcion');
		writeln('4 | Exportar a .txt');
		writeln('5 | Cerrar Archivo');
		write('Opcion: ');
		readln(opcion);
		writeln('_______________________');
		case opcion of
			1:CrearArchivo(archLogico, archFisico);
			2:ListarStock(archLogico);
			3:ListarDesc(archLogico);
			4:ExportarArchivo(archLogico);
			5:Writeln('Archivo cerrado');
		else writeln('Opcion invalida');
		end;
	end;
end;

BEGIN
	Menu();
END.

