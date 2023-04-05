program Practica2Ejercicio4;

const
	valorAlto = 9999;
	dimF = 5;

type	
	str10 = string[10];
	rango = 1..dimF;
	
	sesion = record
		cod:integer;
		fecha:str10;
		tiempo:real;
	end;
	
	archivo = file of sesion;
	vectorDetalle = array[rango] of archivo;
	vectorRegistros = array[rango] of sesion;
	

procedure leer(var arch:archivo; var s:sesion);
begin
	if (not eof(arch))
		then read(arch,s)
		else s.cod := valorAlto;
end;

procedure minimo (var minS:sesion; var vDetalle:vectorDetalle; var vRegistros:vectorRegistros);
var
	i, pos:integer;
begin
	minS.cod := valorAlto;
	minS.fecha := 'zzzz/zz/zz';
	for i:=1 to dimF do begin
		if (minS.cod > vRegistros[i].cod) then begin
			if (minS.fecha > vRegistros[i].fecha) then begin
				minS := vRegistros[i];
				pos := i;
			end;
		end;
	end;
	if (minS.cod <> valorAlto) then
		leer(vDetalle[pos], vRegistros[pos]);	
end;

procedure crearArchivoMaestro(var archLM:archivo; var vDetalle:vectorDetalle; var vRegistros:vectorRegistros);
var
	minS, sesionActual: sesion;
	i:integer;
begin
	assign(archLM, 'Practica2Ejercicio4sesiones.dat');
	rewrite(archLM);
	for i:=1 to dimF do
		reset(vDetalle[i]);
		
	minimo(minS, vDetalle, vRegistros);
	while (minS.cod <> valorAlto) do begin
		sesionActual.cod := minS.cod;
		while (minS.cod = sesionActual.cod) do begin
			sesionActual.fecha := minS.fecha;
			sesionActual.tiempo := 0;
			while ((minS.cod <> valorAlto) and (minS.cod = sesionActual.cod) and (minS.fecha = sesionActual.fecha)) do begin
				sesionActual.tiempo := sesionActual.tiempo + minS.tiempo;
				minimo(minS, vDetalle,  vRegistros);
			end;
			write(archLM, sesionActual);
		end;
	end;
	
	close(archLM);
	for i:=1 to dimF do
		close(vDetalle[i]);
		
	writeln('-----------------------------');
	writeln('Archivo Practica2Ejercicio4sesiones.dat cargado.');
	writeln('-----------------------------');
end;

procedure crearArchivoDetalle (var archL:archivo; archF:string);
var
	carga:text;
	s:sesion;
begin
	assign(carga, 'Practica2Ejercicio4sesiones.txt');		// Toma la info de este .txt
	assign(archL, archF);
	reset(carga);
	rewrite(archL);
	while (not eof(carga)) do begin
		readln(carga, s.cod);
		readln(carga, s.fecha);
		readln(carga, s.tiempo);
		write(archL, s);
	end;
	close(archL);
	close(carga);
	writeln('___________________________________');
	writeln('Archivo Practica2Ejercicio4'+archF+' cargado.');
	writeln('___________________________________');
end;

procedure Informartxt(var arch:archivo);
var
	s:sesion;
	carga:text;
begin
	reset(arch);
	assign(carga, 'Practica2Ejercicio4sesionesMaestro.txt');
	rewrite(carga);
	leer(arch, s);
	while (s.cod <> valorAlto) do begin
			writeln(carga, 'Codigo: ', s.cod);
			writeln(carga, 'Fecha: ', s.fecha);
			writeln(carga, 'Tiempo total: ', s.tiempo:00:00);
		leer(arch, s);
	end;
	close(arch);
	close(carga);
	writeln('___________________________________');
	writeln('Archivo Practica2Ejercicio4sesionesMaestro.txt cargado.');
	writeln('___________________________________');
end;

var
	archLM:archivo;
	vDetalle:vectorDetalle;
	vRegistros:vectorRegistros;
	i:integer;
	iStr:str10;
BEGIN
	for i:=1 to dimF do begin
		Str(i,iStr);
		crearArchivoDetalle(vDetalle[i], 'Practica2Ejercicio4detalle'+iStr+'.dat');
		reset(vDetalle[i]);
		leer(vDetalle[i], vRegistros[i]);
		close(vDetalle[i]);
	end;
	crearArchivoMaestro(archLM, vDetalle, vRegistros);
	Informartxt(archLM);
END.

