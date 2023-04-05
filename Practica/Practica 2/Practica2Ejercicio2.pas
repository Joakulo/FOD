program Practica2Ejercicio2;

const
	valorAlto = 9999;

type
	cad20 = string[20];
	alumnoMaestro = record
		cod: integer;
		apellido: cad20;
		nombre: cad20;
		cantM: integer;
		cantA: integer;
		cantFinal: integer;
	end;
	archivoMaestro = file of alumnoMaestro;
	
	alumnoDetalle = record
		cod : integer;
		aprueba : char;
	end;
	archivoDetalle = file of alumnoDetalle;

procedure leerMaestro(var archivo:archivoMaestro; var a:alumnoMaestro);
begin
	if (not eof(archivo))
		then read(archivo,a)
		else a.cod:=valorAlto;
end;

procedure leerDetalle(var archivo:archivoDetalle; var a:alumnoDetalle);
begin
	if (not eof(archivo))
		then read(archivo,a)
		else a.cod:=valorAlto;
end;

procedure ImprimirMaestro(var archL:archivoMaestro);
var
	a:alumnoMaestro;
begin
	reset(archL);
	leerMaestro(archL, a);
	while (a.cod <> 9999) do begin
		writeln('----------');
		writeln('Codigo: ', a.cod);
		writeln('Nombre: ', a.apellido, ' ', a.nombre);
		writeln('Cantidad de materias aprobadas: ', a.cantM);
		writeln('Materias aprobadas sin final: ', a.cantA);
		writeln('Materias aprobadas con final: ', a.cantFinal);
		writeln('----------');
		leerMaestro(archL, a);
	end;
	close(archL);
end;

procedure ImprimirDetalle(var archL:archivoDetalle);
var
	a:alumnoDetalle;
begin
	reset(archL);
	leerDetalle(archL, a);
	while (a.cod <> 9999) do begin
		writeln('----------');
		writeln('Codigo: ', a.cod);
		if (a.aprueba = 'A') 
			then writeln('Materia aprobada sin final.')
			else writeln('Materia aprobada con final.');
		writeln('----------');
		leerDetalle(archL, a);
	end;
	close(archL);
end;

procedure crearArchivoMaestro (var archL:archivoMaestro; var archF:string);		// Crea el archivo maestro que se dispone segun la consigna
var
	carga:text;
	a:alumnoMaestro;
begin
	assign(carga, 'Practica2Ejercicio2alumnosMaestro.txt');		// Toma la info de este .txt
	archF := 'Practica2Ejercicio2alumnosMaestro.dat';				// Y la vuelca en este .dat
	assign(archL, archF);
	rewrite(archL);
	reset(carga);
	while (not eof(carga)) do begin
		readln(carga, a.cod);
		readln(carga, a.apellido);
		readln(carga, a.nombre);
		readln(carga, a.cantM);
		readln(carga, a.cantA);
		readln(carga, a.cantFinal);
		write(archL, a);
	end;
	close(archL);
	close(carga);
	writeln('___________________________________');
	writeln('Archivo Practica2Ejercicio2alumnosMaestro.dat cargado.');
	writeln('___________________________________');
	ImprimirMaestro(archL);
end;

procedure crearArchivoDetalle (var archL:archivoDetalle; var archF:string);
var
	carga:text;
	a:alumnoDetalle;
begin
	assign(carga, 'Practica2Ejercicio2alumnosDetalle.txt');		// Toma la info de este .txt
	archF := 'Practica2Ejercicio2alumnosDetalle.dat';				// Y la vuelca en este .dat
	assign(archL, archF);
	reset(carga);
	rewrite(archL);
	while (not eof(carga)) do begin
		readln(carga, a.cod);
		readln(carga, a.aprueba);
		write(archL, a);
	end;
	close(archL);
	close(carga);
	writeln('___________________________________');
	writeln('Archivo alumnosDetalle.dat cargado.');
	writeln('___________________________________');
	ImprimirDetalle(archL);
end;

procedure actualizarMaestro(var archLM:archivoMaestro; var archLD:archivoDetalle; archFM, archFD: cad20);
var
	cantA, cantF : integer;
	aMaestro:alumnoMaestro;
	aDetalle:alumnoDetalle;
begin
	reset(archLM);
	reset(archLD);
	while (not eof(archLD)) do begin									// Comienza a avanzar en ambos.
		read(archLM, aMaestro);
		read(archLD, aDetalle);
		cantA := 0;
		cantF := 0;
		while (aMaestro.cod <> aDetalle.cod) do							// Avanza en el maestro hasta encontrar su equivalente en el detalle.
			read(archLM, aMaestro);
			
		while ((not eof(archLD)) and (aMaestro.cod = aDetalle.cod)) do begin		// Mientras que sean equiavlentes procesa.
		
			if (aDetalle.aprueba = 'A') then
				cantA := cantA + 1
			else if (aDetalle.aprueba = 'F') then
				cantF := cantF + 1;
			read(archLD, aDetalle);
		end;
		
		aMaestro.cantA := aMaestro.cantA + cantA;			// Actualiza los campos necesarios
		aMaestro.cantFinal := aMaestro.cantFinal + cantF;
		
		if (not eof(archLD)) then
			seek(archLD, filepos(archLD) - 1);
		seek(archLM, filepos(archLM) - 1);
		write(archLM, aMaestro);							// Sobreescribe el maestro
	end;
end;	


procedure ListarAlumnos(var archL:archivoMaestro);
var
	carga:text;
	a:alumnoMaestro;
begin
	reset(archL);
	assign(carga, 'alumnosCursadasAprobadas.txt');
	rewrite(carga);
	leerMaestro(archL, a);
	while (a.cod <> 9999) do begin
		if (a.cantA > 3) then begin
			writeln(carga, '----------');
			writeln(carga, 'Codigo: ', a.cod);
			writeln(carga, 'Nombre: ', a.apellido, ' ', a.nombre);
			writeln(carga, 'Materias aprobadas sin final: ', a.cantA);
			writeln(carga, 'Materias aprobadas con final: ', a.cantFinal);
			writeln(carga, '----------');
			leerMaestro(archL, a);
		end;
	end;
	close(carga);
	close(archL);
	writeln('____________________________________________');
	writeln('Archivo alumnosCursadasAprobadas.txt cargado');
	writeln('____________________________________________');
end;

procedure Menu(var archLM:archivoMaestro; var archLD:archivoDetalle; archFM, archFD: cad20);
var
	opcion:integer;
begin
	opcion := 0;
	while (opcion <> 3) do begin
		writeln('____________________________________________');
		writeln('1 | Actualizar maestro.');
		writeln('2 | Listar alumnos con 4 materias aprobadas.');
		writeln('3 | Cerrar programa.');
		writeln('____________________________________________');
		write('Opcion: ');
		readln(opcion);
		case opcion of
			1:actualizarMaestro(archLM, archLD, archFM, archFD);
			2:ListarAlumnos(archLM);
			3:writeln('Archivo cerrado.');
		else end;
	end;	
end;


var
	archLM:archivoMaestro;
	archLD:archivoDetalle;
	archFM, archFD: string;

BEGIN
	crearArchivoMaestro(archLM, archFM);
	crearArchivoDetalle(archLD, archFD);
	Menu(archLM, archLD, archFM, archFD);
END.



{	Como crear una lista random de alumnos(maestro) con ChatGPT:
Teniendo en cuenta que la informacion de un alumno se tiene guardada de esta forma en una planilla:

Codigo de alumno de 3 digitos.
Nombre.
Cantidad de materias cursadas (numero entre 3 y 15).
Cantidad de materias aprobadas sin final (numero entre 3 y 15)
Cantidad de materias aprobadas con final (numero de materias cursadas - materias aprobadas sin final)

Creame una lista donde aparezcan 15 personas.

---

Deja solo los campos importantes en la lista, elimina las palabras "Código:", "Nombre:", "Cursadas:", "Aprobadas sin final" y "Aprobadas con final". (Reemplazar cada campo con las palabras que utilice ChatGPT en su output).

--- 

Reemplaza cada "," por un salto de línea.

* Depende como se hace el type, los nombres y apellidos pueden quedar en una misma linea o en distintas.



********************************************************************************************************



	Como crear una lista random de alumnos(detalle) con ChatGPT:
Teniendo en cuenta que la informacion de un alumno se tiene guardada de esta forma en una planilla:

Codigo de alumno de 3 digitos.
A o F.

Creame una lista donde aparezcan 25 personas. Ademas cada persona se puede repetir más de una vez.

---

Ordena la lista por codigo.  
}
