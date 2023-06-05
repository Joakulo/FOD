program ParcialEmpresa;

const
	valorAlto = 9999;
	fechaAlta = 'ZZZZZ';
	dimF = 30;

type
	cad20 = string[20];
	venta = record
		cod_farmaco: integer;
		nombre: cad20;
		fecha: cad20;
		cantidad_vendida: integer;
		forma_pago: integer;
	end;

	archivo = file of venta;
	vArchivos = array[1..dimF] of archivo;
	vVentas = array[1..dimF] of venta;
	
procedure Leer(var a:archivo; var v:venta);
begin
	if (not eof(a))
		then read(a, v)
		else v.cod_farmaco := valorAlto;
end;

procedure minimo(var min:venta; var va:vArchivos; var vv:vVentas);
var
	i, pos: integer;
begin
	min.cod_farmaco := valorAlto;
	min.fecha := fechaAlta;
	for i:=1 to dimF do begin
		if (vv[i].cod_farmaco < min.cod_farmaco) then begin
			if (vv[i].fecha < min.fecha) then begin
				min := vv[i];
				pos := i;
			end;
		end;
	end;
	if (min.cod <> valorAlto) then
		Leer(va[pos], vv[pos]);
end;

procedure Informar(var va:vArchivos; var vv:vVentas);
var
	texto: text;
	act, min, maxVentas, aTexto: venta;
	actVentas, cantContados, maxContados: integer;
	maxContadosFecha: cad20;
begin
	for i:=1 to dimF do
		reset(va[i]);
	rewrite(texto, 'resumenVentas.txt');
	
	maxVentas.cantidad_vendida := 0;
	maxContados := 0;
	minimo(min, va, vv);
	while (min.cod_farmaco <> valorAlto) do begin
		act := min;
		actVentas := 0;
		
		while (act.cod_farmaco = min.cod_farmaco) do begin
			act := min;
			aTexto := min;
			aTexto.cantidad_vendida := 0;
			
			while ((act.fecha = min.fecha) and (act.cod_farmaco = min.cod_farmaco)) do begin
				actVentas := actVentas + min.cantidad_vendida;
				if (min.forma_pago = 'contado') then
					cantContados := cantContados + 1;
				aTexto.cantidad_vendida := aTexto.cantidad_vendida + min.cantidad_vendida;
				writeln(texto, aTexto.cod_farmaco, aTexto.nombre, aTexto.fecha, aTexto.cantidad_vendida, aTexto.forma_pago);
				
				minimo(min, va, vv);
			end;
			
			if (maxContados > cantContados) then begin
				maxContados := cantContados;
				maxContadosFecha := act.fecha;
			end;
		end;
		
		if (actVentas > maxVentas.cantidad_vendida) then
			maxVentas := act
	end;
	
	writeln('Farmaco con mayor cantidad de ventas: ', maxVentas.nombre, ', ',maxVentas.cod_farmaco);
	writeln('Fecha en la que se produjeron mas pagos de contado: ', maxContadosFecha, ', ', maxContados);
	
	for i:=1 to dimF do
		close(va[i]);
	close(texto);
end;

var

BEGIN
	
	
END.

