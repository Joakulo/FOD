program ParcialServidor;

const
	valorAlto = 9999;

type
	acceso = record
		anio: integer;
		mes: integer;
		dia: integer;
		idUsuario: integer;
		tiempoDeAcceso: integer;
	end;
	
	archivo = file of acceso;

procedure Leer(var a:archivo; var acc:acceso);
begin
	if (not eof(a))
		then read(a, acc)
		else acc.anio := valorAlto;
end;

procedure Informar(var a:archivo);
var
	acc, act: acceso;
	tDiarioUsuario, tDiarioTotal, tMensual, tAnual, anio: integer;
begin
	reset(a);
	
	write('Ingrese un anio a informar');
	readln(anio);
	
	Leer(a, acc);
	while ((acc.anio <> anio) and (acc.anio <> valorAlto)) do
		Leer(a, acc);
	
	if (acc.anio = valorAlto) then
		writeln('Anio no encontrado')
	else begin
		
		act := acc;
		tAnual := 0;
		writeln('Anio: ', anio);
		
		while (acc.anio = act.anio) do begin
			tMensual := 0;
			writeln('Mes: ', act.mes);
			
			while ((acc.mes = act.mes) and (acc.anio = act.anio)) do begin
				act := acc;
				tDiarioTotal := 0;
				writeln('Dia: ', act.dia);
				
				while ((acc.dia = act.dia) and (acc.mes = act.mes) and (acc.anio = act.anio)) do begin
					act := acc;
					tDiarioUsuario := 0;
					
					while ((acc.idUsuario = act.idUsuario) and (acc.dia = act.dia) and (acc.mes = act.mes) and (acc.anio = act.anio)) do begin
						act := acc;
						tDiarioUsuario = tDiarioUsuario + act.tiempoDeAcceso;
						Leer(a, acc);
					end;
				
					writeln(act.idUsuario, ': Tiempo de acceso en el dia ', act.dia, ' mes ', act.mes, ': ', tDiarioUsuario);
					tDiarioTotal := tDiarioTotal + tDiarioUsuario;
				end;
				
				writeln('Tiempo de acceso dia ', act.dia, ' mes ', act.mes, ': ', tDiarioTotal);
				tMensual := tMensual + tDiarioTotal;
			end;
			
			writeln('Tiempo de acceso mes ', act.mes, ': ', tMensual);
			tAnual := tAnual + tMensual;
		end;
		
		writeln('Tiempo de acceso anual: ', tAnual);
	end;
	
	close(a);
end;

var
	accesos: archivo;

BEGIN
	assign(accesos, 'accesos.dat');
	Informar(accesos);
END.

