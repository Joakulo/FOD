program ParcialRapiPago;

const
	valorAlto = 9999;
	dimF = 30;

type	
	inscripcion = record
		dni_alumno: integer;
		codigo_carrera: integer;
		monto_total_pagado: real;
	end;
	
	pago = record
		dni_alumno: integer;
		codigo_carrera: integer;
		monto_cuota: real;
	end;
	
	maestro = file of inscripcion;
	detalle = file of pago;
	vDetalle = array[1..dimF] of detalle;
	vDRegistro = array[1..dimF] of pago;


procedure LeerMaestro(var m:maestro; var i:inscripcion);
begin
	if (not eof(m))
		then read(m, i)
		else i.dni_alumno := valorAlto;
end;

procedure LeerDetalle(var d:detalle; var p:pago);
begin
	if (not eof(d))
		then read(d, p)
		else p.dni_alumno := valorAlto;
end;

procedure SinPagos(var m:maestro);
var
	texto: text;
	ins: inscripcion;
begin
	reset(m);
	assign(texto, 'sinPagar.txt');
	rewrite(texto);
	LeerMaestro(m, ins);
	
	while (ins.dni_alumno <> valorAlto) do begin
		if (ins.monto_total_pagado <= 0) then
			writeln(texto, ins.dni_alumno,',',ins.codigo_carrera,',','alumno moroso');
		LeerMaestro(m, ins);
	end;
	
	writeln('Archivo creado: sinPagar.txt');
	close(texto);
	close(m);
end;

procedure minimo(var min:pago; var vd:vDetalle; var vdr:vDRegistro);
var
	i, pos: integer;
begin
	pos := -1;
	min.dni_alumno := -1;
	min.codigo_carrera := -1;
	for i:=1 to dimF do begin
		if (vdr[i].dni_alumno < min.dni_alumno) then begin
			if (vdr[i].codigo_carrera < min.codigo_carrera) then begin
				pos := i;
				min := vdr[pos];
			end;
		end;
	end;
	if (pos <> -1) then
		LeerDetalle(vd[pos], vdr[pos]);
end;

procedure actualizarMaestro(var m:maestro; var vd:vDetalle; var vdr:vDRegistro);
var
	ins: inscripcion;
	min: pago;
	i: integer;
begin
	reset(m);
	for i:=1 to dimF do
		reset(vd[i]);
	
	read(m, ins);
	minimo(min, vd, vdr);
	while (min.dni_alumno <> valorAlto) do begin
		
		while (ins.dni_alumno <> min.dni_alumno) do
			read(m, ins);
		
		while (ins.codigo_carrera <> min.codigo_carrera) do
			read(m, ins);
		
		while ((ins.codigo_carrera = min.codigo_carrera) and (ins.dni_alumno = min.dni_alumno)) do begin
			ins.monto_total_pagado := ins.monto_total_pagado + min.monto_cuota;
			minimo(min, vd, vdr);
		end;
		
		seek(m, filepos(m) -1);
		write(m, ins);
	end;
	
	for i:=1 to dimF do
		close(vd[i]);
	close(m);
end;

procedure InicializarArchivos(var m:maestro; var vd:vDetalle; var vdr:vDRegistro);
var
	i: integer;
	iStr: string[20];
begin
	assign(m, 'InscripcionAlumnos.dat');
	for i:=1 to dimF do begin
		Str(i, iStr);
		assign(vd[i], 'pagosRealizados'+iStr+'.dat');
		reset(vd[i]);
		LeerDetalle(vd[i], vdr[i]);
		close(vd[i]);
	end;
end;


var
	m: maestro;
	vd: vDetalle;
	vdr: vDRegistro;

BEGIN
	InicializarArchivos(m, vd, vdr);
	actualizarMaestro(m, vd, vdr);
	SinPagos(m);
END.
