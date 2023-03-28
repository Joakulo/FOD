program Practica1Ejercicio6;

type
	cad20=string[20];
	celular=record
		cod:integer;
		nombre:cad20;
		desc:cad20;
		marca:cad20;
		precio:real;
		stockMin:integer;
		stockDis:integer;
	end;
	archivo = file of celular;

procedure CrearArchivo(var archLogico:archivo; var archFisico:cad20);
var
	carga: text;
	c:celular;
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
	c:celular;
begin
	reset(archLogico);
	while (not eof(archLogico)) do begin
		read(archLogico,c);
		if (c.stockDis < c.stockMin) then begin
			with c do begin
				WriteLn('Codigo: ',cod);
				writeln('Nombre: ', nombre);
				writeln('Descripcion:', desc);
				WriteLn('Marca:',marca);
				writeln('Precio: ', precio:2:2);
				WriteLn('Stock Minimo: ',stockMin);
				writeln('Stock: ', stockDis);
				WriteLn('_________');
			end;
		end;
	end;
	close(archLogico);
end;

procedure ListarDesc(var archLogico:archivo);
var
	c:celular;
	UserDesc:cad20;
begin
	reset(archLogico);
	write('Ingrese una descripcion a buscar: ');
	readln(UserDesc);
	UserDesc:=Concat(' ',UserDesc); 
	while (not eof(archLogico)) do begin
		read(archLogico,c);
		if (UserDesc = c.desc) then begin
			with c do begin
				WriteLn('Codigo: ',cod);
				writeln('Nombre: ', nombre);
				writeln('Descripcion:', desc);
				WriteLn('Marca:',marca);
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
	c:celular;
	carga:text;
begin
	reset(archLogico);
	assign(carga,'celulares2.txt');
	rewrite(carga);
	while (not eof(archLogico)) do begin
		read(archLogico,c);
			with c do begin
				writeln(carga, 'Codigo:.......', cod, '   Precio:.......', precio:2:2, '  Marca:.......', Copy(marca, 2, Length(marca)-1){Elimina el primer caracter de c.marca});
				writeln(carga, 'Stock actual:.', stockDis, '   Stock minimo:.', stockMin,'     Descripcion:.', Copy(desc, 2, Length(desc)-1){Elimina el primer caracter de c.desc});
				writeln(carga, 'Nombre:.......', nombre);
				writeln(carga, '');
			end;
	end;
	close(archLogico);
	close(carga);
end;

procedure LeerCelular(var c:celular);
begin
	write('Ingrese el codigo: ');
	readln(c.cod);
	write('Ingrese el nombre: ');
	readln(c.nombre);
	write('Ingrese la descripcion: ');
	readln(c.desc);
	c.desc := Concat(' ',c.desc);
	write('Ingrese la marca: ');
	readln(c.marca);
	c.marca := Concat(' ',c.marca);
	write('Ingrese el precio: ');
	readln(c.precio);
	write('Ingrese el stock minimo: ');
	readln(c.stockMin);
	write('Ingrese el stock disponible: ');
	readln(c.stockDis);
end;

procedure AgregarCelular(var archLogico:archivo);
var
	c:celular;
	opcion:cad20;
begin
	reset(archLogico);
	seek(archLogico,fileSize(archLogico));
	repeat
		LeerCelular(c);
		write(archLogico,c);
		write('Desea agregar otro celular? ');
		readln(opcion);
	until opcion = 'No';
	close(archLogico);
end;

procedure ModificarStock(var archLogico:archivo);
var
	nombre:cad20;
	c:celular;
begin
	reset(archLogico);
	read(archLogico,c);
	write('Ingrese un nombre a buscar: ');
	readln(nombre);
	while ((not eof(archLogico)) and (c.nombre <> nombre)) do begin
		read(archLogico,c);
	end;
	write('Ingrese el nuevo stock: ');
	readln(c.stockDis);
	seek(archLogico,filePos(archLogico)-1);
	write(archLogico,c);
	close(archLogico);
end;

procedure ExportarSinStock(var archLogico:archivo);
var
	c:celular;
	carga:text;
begin
	reset(archLogico);
	assign(carga,'SinStock.txt');
	rewrite(carga);
	while (not eof(archLogico)) do begin
		read(archLogico,c);
		if (c.stockDis = 0) then begin
			with c do begin
				writeln(carga, 'Codigo:.......', cod, '   Precio:.......', precio:2:2, '  Marca:.......', marca);
				writeln(carga, 'Stock actual:.', stockDis, '   Stock minimo:.', stockMin,'     Descripcion:.',desc);
				writeln(carga, 'Nombre:.......', nombre);
				writeln(carga, '');
			end;
		end;
	end;
	close(carga);
	close(archLogico);
end;

procedure Menu();
var
	archLogico:archivo;
	archFisico:cad20;
	opcion:integer;
begin
	opcion:=0;
	while (opcion <> 8) do begin
		writeln('_______________________');
		writeln('1 | Crear archivo');
		writeln('2 | Listar celulares con poco stock');
		writeln('3 | Listar celulares por descripcion');
		writeln('4 | Exportar a .txt');
		writeln('5 | Aniadir celular');
		writeln('6 | Modificar stock');
		writeln('7 | Exportar a SinStock.txt');
		writeln('8 | Cerrar Archivo');
		write('Opcion: ');
		readln(opcion);
		writeln('_______________________');
		case opcion of
			1:CrearArchivo(archLogico, archFisico);
			2:ListarStock(archLogico);
			3:ListarDesc(archLogico);
			4:ExportarArchivo(archLogico);
			5:AgregarCelular(archlogico);
			6:ModificarStock(archlogico);
			7:ExportarSinStock(archlogico);
			8:Writeln('Archivo cerrado');
		else
		end;
	end;
end;

BEGIN
	Menu();
END.

