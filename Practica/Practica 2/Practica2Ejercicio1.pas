program Practica2Ejercicio1;

const
	valorAlto = 9999;

type
	cad20=string[20];
	empleado = record
		cod:integer;
		nombre:cad20;
		monto:real;
	end;
	archivo=file of empleado;

procedure crearArchivo(var archL:archivo; var archF:string);	//Crea el archivo que ya se tiene segun la consigna
var
	carga:text;
	e:empleado;
begin
	assign(carga, 'Practica2Ejercicio1empleados.txt');			// Toma la info de este .txt
	archF := 'Practica2Ejercicio1empleados.dat';				// Y la vuelca en este .dat
	readln(archF);
	assign(archL, archF);				
	rewrite(archL);
	reset(carga);
	while (not eof(carga)) do begin
		readln(carga, e.cod);
		readln(carga, e.nombre);
		readln(carga, e.monto);
		write(archL, e);
	end;
	writeln('______________________________');
	writeln('Archivo Practica2Ejercicio1empleados.dat cargado.');
	writeln('______________________________');	close(carga);
	close(archL);
end;

procedure Imprimir(var archL:archivo);
var
	e:empleado;
begin
	reset(archL);
	while (not eof(archL)) do begin
		read(archL,e);
		writeln('Empleado Nro: ', e.cod);
		writeln('Nombre: ', e.nombre);
		writeln('Monto: ', e.monto:0:00);
		writeln('____________________');
	end;
	close(archL);
end;

procedure leer(var archivo:archivo; var e:empleado);
begin
	if (not eof(archivo))
		then read(archivo,e)
		else e.cod:=valorAlto;
end;

procedure cargarArchivo(var archLA, archLN : archivo; var archFN: cad20);
var
	e, eActual:empleado;
	montoTotal:real;
begin
	reset(archLA);
	write('Ingrese el nombre del archivo a crear: ');
	readln(archFN);
	assign(archLN, archFN);
	rewrite(archLN);
	leer(archLA, e);
	while (e.cod <> 9999) do begin
		montoTotal := 0;
		eActual := e;
		while (e.cod = eActual.cod) do begin
			montoTotal := montoTotal + e.monto;
			leer(archLA, e);
		end;
		eActual.monto := montoTotal;
		write(archLN, eActual);
	end;
	writeln();
	Imprimir(archLN);
end;

var
	archLantiguo, archLnuevo : archivo;
	archFA, archFN : cad20;

BEGIN
	crearArchivo(archLantiguo, archFA);
	Imprimir(archLantiguo);
	cargarArchivo(archLantiguo, archLnuevo, archFN);
END.

{	Como crear una lista random de empleados con ChatGPT:
Teniendo en cuenta que la informacion de un empleado se tiene guardada de esta forma en una planilla:

Codigo de empleado de 3 digitos.
Nombre.
Monto recibido por comision entre 3 y 4 digitos.

Creame una lista donde aparezcan 15 persona, donde una persona puede aparecer más de una vez, teniendo en cuenta que Codigo de Empleado y Nombre tienen que mantenerse constantes en una misma persona. 

---

Ordenalos por codigo de empleado.

---

Deja solo los campos importantes en la lista, elimina las palabras "Código de Empleado:", "Nombre:" y "Monto de Comisión:" (Reemplazar cada campo con las palabras que utilice ChatGPT en su output).

--- 

Reemplaza cada "," por un salto de línea y elimina el signo "$" cada vez que aparezca


}
