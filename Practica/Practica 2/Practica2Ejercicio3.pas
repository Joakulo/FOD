program Practica2Ejercicio3;

const
	valorAlto = 9999;
	dimF = 30;
type
	rango = 1..dimF;
	str20 = string[20];
	producto = record
		cod:integer;
		nombre:str20;
		desc:string[50];
		stockD:integer;
		stockM:integer;
		precio:real;
	end;
	
	productoD = record
		cod:integer;
		cant:integer;
	end;
	
	archivoMaestro = file of producto;
	archivoDetalle = file of productoD;
	
	vectorDetalle = array[rango] of archivoDetalle;
	vectorRegistros = array[rango] of productoD;
	

procedure leerMaestro (var arch:archivoMaestro; var p:producto);
begin
	if (not eof(arch))
		then read(arch, p)
		else p.cod := valorAlto;
end;

procedure leerDetalle (var arch:archivoDetalle; var p:productoD);
begin
	if (not eof(arch))
		then read(arch, p)
		else p.cod := valorAlto;
end;

procedure minimo (var minD:productoD; var vDetalle:vectorDetalle; var vRegistros:vectorRegistros);
var
	i, pos:integer;
begin
	minD.cod := valorAlto;
	for i:=1 to dimF do begin
		if (vRegistros[i].cod < minD.cod) then begin			// Si el codigo es el menor hasta el momento actualiza minD y pos.
			minD := vRegistros[i];
			pos := i;
		end;
	end;
	if (minD.cod <> valorAlto) then						// Se avanza en el detalle con codigo minimo.
		leerDetalle(vDetalle[pos], vRegistros[pos]);			
end;

procedure actualizarMaestro(var archLM:archivoMaestro; var vDetalle:vectorDetalle; var vRegistros:vectorRegistros);
var
	pMaestro: producto;
	minD: productoD;
	i:integer;
begin
	reset(archLM);
	for i:=1 to dimF do
		reset(vDetalle[i]);

	minimo(minD, vDetalle, vRegistros);				// Busca el codigo minimo entre los productos de los detalles.
	while (minD.cod <> valorAlto) do begin			// Hasta que no se terminan de leer los detalles lee al maestro.
		leerMaestro(archLM, pMaestro);					
		while (pMaestro.cod <> minD.cod) do 		// Lee registros del maestro hasta encontrar uno equivalente al minimo de los detalles.
			leerMaestro(archLM, pMaestro);			
		while (pMaestro.cod = minD.cod) do begin	// Mientras que los codigos sean iguales, actualiza el registro del maestro
			pMaestro.stockD := pMaestro.stockD - minD.cant;
			minimo(minD, vDetalle, vRegistros);					// Busca el codigo minimo entre los productos de los detalles. 
		end;
		write(archLM, pMaestro);					// Se actualiza el registro.
	end;
	
	close(archLM);
	for i:=1 to dimF do
		close(vDetalle[i]);
end;

procedure Informartxt(var arch:archivoMaestro);
var
	p:producto;
	carga:text;
begin
	reset(arch);
	assign(carga, 'Practica2Ejercicio3productosStockMinimo.txt');
	rewrite(carga);
	leerMaestro(arch, p);
	while (p.cod <> valorAlto) do begin
		if (p.stockM > p.stockD) then begin
			writeln(carga, 'Nombre: ', p.nombre);
			writeln(carga, 'Descripcion: ', p.desc);
			writeln(carga, 'Stock disponible: ', p.stockD);
			writeln(carga, 'Precio: ', p.precio:0:00);
		end;
		leerMaestro(arch, p);
	end;
	close(arch);
	close(carga);
	writeln('___________________________________');
	writeln('Archivo Practica2Ejercicio3productosStockMinimo.txt cargado.');
	writeln('___________________________________');
end;

procedure crearArchivoMaestro (var arch:archivoMaestro; var archF:str20);		// Crea el archivo maestro que se dispone segun la consigna
var
	carga:text;
	p:producto;
begin
	assign(carga, 'Practica2Ejercicio3productos.txt');			// Toma la info de este .txt
	archF := 'Practica2Ejercicio3productos.dat';				// Y la vuelca en este .dat
	assign(arch, archF);
	rewrite(arch);
	reset(carga);
	while (not eof(carga)) do begin
		readln(carga, p.cod);
		readln(carga, p.nombre);
		readln(carga, p.desc);
		readln(carga, p.stockD);
		readln(carga, p.stockM);
		readln(carga, p.precio);
		write(arch, p);
	end;
	close(arch);
	close(carga);
	writeln('___________________________________');
	writeln('Archivo Practica2Ejercicio3productos.dat cargado.');
	writeln('___________________________________');
end;

var
	archLM: archivoMaestro;
	vDetalle: vectorDetalle;
	vRegistros: vectorRegistros;
	i: integer;
	archFM, iStr: str20;
	
BEGIN
	crearArchivoMaestro(archLM, archFM);
	for i:=1 to dimF do begin
		Str(i,iStr);
		assign(vDetalle[i], 'Practica2Ejercicio3detalle'+iStr+'.dat');		// Los 30 detalles que se reciben
		rewrite(vDetalle[i]);
		leerDetalle(vDetalle[i], vRegistros[i]);
		close(vDetalle[i]);
	end;
	actualizarMaestro(archLM, vDetalle, vRegistros);
	Informartxt(archLM);
END.

{     Como crear una lista random de productos(maestro) con ChatGPT:
Teniendo en cuenta que la informacion de un producto se tiene guardada de esta forma en una planilla:

Codigo de 3 digitos
Nombre
Descripcion
Stock disponible
Stock minimo
Precio 

Creame una lista donde aparezcan 15 productos.

---
 
Reemplaza cada "-" por un salto de linea.
}
