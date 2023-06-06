program ParcialSistemasOperativos;

const
	valorAlto = 9999;

type
	cad20 = string[20];
	SO = record
		nombre_sistema_operativo: cad20;
		cantidad_instalaciones: integer;
		es_de_codigo_abierto: boolean;
		tipo_licencia: cad20;
	end;
	archivo = file of SO;

procedure Leer(var a:archivo; var s:SO);
begin
	if (not eof(a))
		then read(a, s)
		else s.cantidad_instalaciones := valorAlto;
end;

procedure Alta(var a:archivo; s:SO);
var
	cabecera: SO;
begin
	reset(a);
	Leer(a,cabecera);
	
	if (cabecera.cantidad_instalaciones = 0) then begin
		seek(a, filesize(a));
		write(a, s);
	end else begin
		seek(a, (cabecera.cantidad_instalaciones * (-1)));
		read(a, cabecera);
		
		seek(a, filepos(a)-1);
		write(a, s);
		
		seek(a, 0);
		write(a, cabecera)
	end;
		
	close(a);
end;

procedure BajaLogica(var a:archivo; s:SO);
var
	cabecera, act: SO;
	pos: integer;
begin
	reset(a);
	Leer(a, act);
	cabecera := act;
	
	while ((act.cantidad_instalaciones <> valorAlto) and (act.nombre_sistema_operativo = s.nombre_sistema_operativo)) do
		Leer(a, act);
	
	if (act.cantidad_instalaciones = valorAlto) then
		writeln('Sistema operativo no encontrado.')
	else begin
		pos := filepos(a) -1;
		seek(a, pos);
		write(a, cabecera);
		
		seek(a, 0);
		act.cantidad_instalaciones := pos * (-1);
		write(a, act);
	end;
	
	close(a);
end;


var

BEGIN
	
	
END.

