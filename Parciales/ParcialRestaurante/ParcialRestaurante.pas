program ParcialRestaurante;

const
	valorAlto = 9999;
	dimF = 3;

type
	cad20 = string[20];
	producto = record
		codigo: integer;
		nombre: cad20;
		descripcion: cad20;
		cod_barras: integer;
		categoria: cad20;
		stock_Actual: integer;
		stock_Minimo: integer;
	end;
	
	pedido = record
		codigo: integer;
		cant_pedida: integer;
		descripcion: cad20;
	end;
	
	maestro = file of producto;
	
	detalle = file of pedido;
	vDetalle = array[1..dimF] of detalle;
	vDRegistros = array[1..dimF] of pedido;
	
	vContador = array[1..dimF] of integer;


procedure LeerDetalle(var d:detalle; var p:pedido);
begin
	if (not eof(d))
		then read(d, p)
		else p.codigo := valorAlto;
end;

procedure InicializarArchivos(var m:maestro; var vD:vDetalle; var vDR:vDRegistros);
var
	i:integer;
	iStr: cad20;
begin
	assign(m, 'maestro.dat');
	for i:=1 to dimF do begin
		Str(i, iStr);
		assign(vD[i], 'detalle'+iStr+'.dat');
		reset(vD[i]);
		LeerDetalle(vD[i], vDR[i]);
		close(vD[i]);
	end;
end;

procedure minimo (var min:pedido; var vd: vDetalle; var vdr:vDRegistros; var pos:integer);
var
	i: integer;
begin
	min.codigo := valorAlto;
	
	for i:=1 to dimF do begin
		if (vdr[i].codigo < min.codigo) then begin
			min := vdr[i];
			pos := i;
		end;
	end;
	
	if (min.codigo <> valorAlto) then
		LeerDetalle(vd[pos], vdr[pos]);
end;

procedure Informar(p:producto; v:vContador);
var
	i:integer;
begin
	writeln('El producto ', p.descripcion, ' quedo por debajo del stock minimo.');
	for i:=1 to dimF do
		writeln('El restaurante ', i, ' no pudo recibir ', v[i], ' productos.');
end;

procedure actualizarMaestro(var m:maestro; var vd: vDetalle; var vdr:vDRegistros);
var
	pos, i: integer;
	min: pedido;
	prod: producto;
	cantSinEnviar: vContador;
begin
	reset(m);
	reset(vd[1]); reset(vd[2]); reset(vd[3]);
	
	minimo(min, vd, vdr, pos);
	while (min.codigo <> valorAlto) do begin
		read(m, prod);
		
		while (prod.codigo <> min.codigo) do
			read(m, prod);
		
		for i:=1 to dimf do
			cantSinEnviar[i] := 0;
			
		while (prod.codigo = min.codigo) do begin
			if (prod.stock_Actual - min.cant_pedida < 0) then begin
				if (prod.stock_Actual >= 0) then
					cantSinEnviar[pos] := (prod.stock_Actual - min.cant_pedida) * (-1)
				else
					cantSinEnviar[pos] := cantSinEnviar[pos] + min.cant_pedida;
			end;
			prod.stock_Actual := prod.stock_Actual - min.cant_pedida;
			minimo(min, vd, vdr, pos);
		end;
		
		if (prod.stock_Actual < prod.stock_Minimo) then
			Informar(prod, cantSinEnviar);
	end;
end;

var
	m: maestro;
	vd: vDetalle;
	vdr: vDRegistros;

BEGIN
	InicializarArchivos(m, vd, vdr);
	actualizarMaestro(m, vd, vdr);
END.
