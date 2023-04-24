<h1 align="center">Practica 2</h1>

<div align = "center"  id="Ejercicio_1"> 
  
<h2 align="center"> Indice: </h2>

| [1](#Ejercicio_1) | [2](#Ejercicio_2) | [3](#Ejercicio_3) | [4](#Ejercicio_4) | [5](#Ejercicio_5) | [6](#Ejercicio_6) | [7](#Ejercicio_7) | [8](#Ejercicio_8) | [9](#Ejercicio_9) | [10](#Ejercicio_10) | [11](#Ejercicio_11) | [12](#Ejercicio_12) | [13](#Ejercicio_13) | [14](#Ejercicio_14) | [15](#Ejercicio_15) | [16](#Ejercicio_16) | [17](#Ejercicio_17) | [18](#Ejercicio_18) |
===

</div>

<br>

`1.` Una empresa posee un archivo con información de los ingresos percibidos por diferentes empleados en concepto de comisión, de cada uno de ellos se conoce: código de empleado, nombre y monto de la comisión. La información del archivo se encuentra ordenada por código de empleado y cada empleado puede aparecer más de una vez en el archivo de comisiones. 

Realice un procedimiento que reciba el archivo anteriormente descripto y lo compacte. En consecuencia, deberá generar un nuevo archivo en el cual, cada empleado aparezca una única vez con el valor total de sus comisiones.

```
NOTA: No se conoce a priori la cantidad de empleados. Además, el archivo debe ser recorrido una única vez.
```
  
<details>

<summary> ▶️ </summary>
<br>
  
```Pas
program Practica2Ejercicio1;

const
    valorAlto = 9999;

type
    str20 = string[20];
    empleado = record
        cod: integer;
        nombre: str20;
        monto: real;
    end;
    archivo = file of empleado;

procedure crearArchivo(var archivoLogico:archivo; var archivoFisico:str20);    //Crea el archivo que ya se tiene segun la consigna
var
    carga: text;
    e: empleado;
begin
    assign(carga, 'empleados.txt');          // Toma la info de este .txt
    archivoFisico := 'empleados.dat';                // Y la vuelca en este .dat
    assign(archivoLogico, archivoFisico);               
    rewrite(archivoLogico);
    reset(carga);
    while (not eof(carga)) do begin
        readln(carga, e.cod);
        readln(carga, e.nombre);
        readln(carga, e.monto);
        write(archivoLogico, e);
    end;
    writeln('______________________________');
    writeln('Archivo empleados.dat cargado.');
    writeln('______________________________');
    close(carga);
    close(archivoLogico);
end;

procedure Imprimir(var archivoLogico:archivo);
var
    e:empleado;
begin
    reset(archivoLogico);
    while (not eof(archivoLogico)) do begin
        read(archivoLogico,e);
        writeln('Empleado Nro: ', e.cod);
        writeln('Nombre: ', e.nombre);
        writeln('Monto: ', e.monto:0:00);
        writeln('____________________');
    end;
    close(archivoLogico);
end;

procedure Leer(var archivoLogico:archivo; var e:empleado);
begin
    if (not eof(archivoLogico))
        then read(archivoLogico,e)
        else e.cod := valorAlto;
end;

procedure cargarArchivo(var archivoLogicoA, archivoLogicoN:archivo; var archivoFisicoN: str20);
var
    e, eActual:empleado;
    montoTotal:real;
begin
    reset(archivoLogicoA);
    write('Ingrese el nombre del archivo a crear: ');
    readln(archivoFisicoN);
    assign(archivoLogicoN, archivoFisicoN);
    rewrite(archivoLogicoN);
    Leer(archivoLogicoA, e);
    while (e.cod <> 9999) do begin
        montoTotal := 0;
        eActual := e;
        while (e.cod = eActual.cod) do begin
            montoTotal := montoTotal + e.monto;
            Leer(archivoLogicoA, e);
        end;
        eActual.monto := montoTotal;
        write(archivoLogicoN, eActual);
    end;
    writeln();
    Imprimir(archivoLogicoN);
end;

var
    archivoLogicoAntiguo, archivoLogicoNuevo: archivo;
    archivoFisicoA, archivoFisicoN: str20;

BEGIN
    crearArchivo(archivoLogicoAntiguo, archivoFisicoA);
    Imprimir(archivoLogicoAntiguo);
    cargarArchivo(archivoLogicoAntiguo, archivoLogicoNuevo, archivoFisicoN);
END.

{   Como crear una lista random de empleados con ChatGPT:
Teniendo en cuenta que la informacion de un empleado se tiene guardada de esta forma en una planilla:

Codigo de empleado de 3 digitos.
Nombre.
Monto recibido por comision entre 3 y 4 digitos.

Creame una lista donde aparezcan 15 persona, donde una persona puede aparecer más de una vez, 
  teniendo en cuenta que Codigo de Empleado y Nombre tienen que mantenerse constantes en una misma persona. 

---

Ordenalos por codigo de empleado.

---

Deja solo los campos importantes en la lista, elimina las palabras "Código de Empleado:", "Nombre:" y 
  "Monto de Comisión:" (Reemplazar cada campo con las palabras que utilice ChatGPT en su output).

--- 

Reemplaza cada "," por un salto de línea y elimina el signo "$" cada vez que aparezca
}
```
  
</details>

<br><hr id="Ejercicio_2"><br>
  
`2.` Se dispone de un archivo con información de los alumnos de la Facultad de Informática. Por cada alumno se dispone de su código de alumno, apellido, nombre, cantidad de materias (cursadas) aprobadas sin final y cantidad de materias con final aprobado. Además, se tiene un archivo detalle con el código de alumno e información correspondiente a una materia (esta información indica si aprobó la cursada o aprobó el final).

Todos los archivos están ordenados por código de alumno y en el archivo detalle puede haber 0, 1 ó más registros por cada alumno del archivo maestro. Se pide realizar un programa con opciones para:

‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ `a.` Actualizar el archivo maestro de la siguiente manera:

‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ `i.` Si aprobó el final se incrementa en uno la cantidad de materias con final aprobado.
  
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ `ii.` Si aprobó la cursada se incrementa en uno la cantidad de materias aprobadas sin final.

‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ `b.` Listar en un archivo de texto los alumnos que tengan más de cuatro materias con cursada aprobada pero no aprobaron el final. Deben listarse todos los campos.

```
NOTA: Para la actualización del inciso a) los archivos deben ser recorridos sólo una vez.
```
  
<details>

<summary> ▶️ </summary>
<br>
  
```Pas
program Practica2Ejercicio2;

const
    valorAlto = 9999;

type
    str20 = string[20];
    alumnoMaestro = record
        cod: integer;
        apellido: str20;
        nombre: str20;
        cantM: integer;
        cantA: integer;
        cantFinal: integer;
    end;
        
    alumnoDetalle = record
        cod : integer;
        aprueba : char;
    end;

    archivoMaestro = file of alumnoMaestro;
    archivoDetalle = file of alumnoDetalle;

procedure LeerMaestro(var archivo:archivoMaestro; var a:alumnoMaestro);
begin
    if (not eof(archivo))
        then read(archivo,a)
        else a.cod:=valorAlto;
end;

procedure LeerDetalle(var archivo:archivoDetalle; var a:alumnoDetalle);
begin
    if (not eof(archivo))
        then read(archivo,a)
        else a.cod := valorAlto;
end;

procedure ImprimirMaestro(var maestro:archivoMaestro);
var
    a:alumnoMaestro;
begin
    reset(maestro);
    LeerMaestro(maestro, a);
    while (a.cod <> 9999) do begin
        writeln('----------');
        writeln('Codigo: ', a.cod);
        writeln('Nombre: ', a.apellido, ' ', a.nombre);
        writeln('Cantidad de materias aprobadas: ', a.cantM);
        writeln('Materias aprobadas sin final: ', a.cantA);
        writeln('Materias aprobadas con final: ', a.cantFinal);
        writeln('----------');
        LeerMaestro(maestro, a);
    end;
    close(maestro);
end;

procedure ImprimirDetalle(var detalle:archivoDetalle);
var
    a:alumnoDetalle;
begin
    reset(detalle);
    LeerDetalle(detalle, a);
    while (a.cod <> 9999) do begin
        writeln('----------');
        writeln('Codigo: ', a.cod);
        if (a.aprueba = 'A') 
            then writeln('Materia aprobada sin final.')
            else writeln('Materia aprobada con final.');
        writeln('----------');
        LeerDetalle(detalle, a);
    end;
    close(detalle);
end;

procedure crearArchivoMaestro (var maestro:archivoMaestro);     // Crea el archivo maestro que se dispone segun la consigna
var
    carga:text;
    a:alumnoMaestro;
    maestroFisico:string;
begin
    assign(carga, 'Practica2Ejercicio2alumnosMaestro.txt');     // Toma la info de este .txt
    maestroFisico := 'Practica2Ejercicio2alumnosMaestro.dat';               // Y la vuelca en este .dat
    assign(maestro, maestroFisico);
    rewrite(maestro);
    reset(carga);
    while (not eof(carga)) do begin
        readln(carga, a.cod);
        readln(carga, a.apellido);
        readln(carga, a.nombre);
        readln(carga, a.cantM);
        readln(carga, a.cantA);
        readln(carga, a.cantFinal);
        write(maestro, a);
    end;
    close(maestro);
    close(carga);
    writeln('___________________________________');
    writeln('Archivo alumnosMaestro.dat cargado.');
    writeln('___________________________________');
    ImprimirMaestro(maestro);
end;

procedure crearArchivoDetalle (var detalle:archivoDetalle);
var
    carga:text;
    a:alumnoDetalle;
    detalleFisico:string
begin
    assign(carga, 'Practica2Ejercicio2alumnosDetalle.txt');     // Toma la info de este .txt
    detalleFisico := 'Practica2Ejercicio2alumnosDetalle.dat';               // Y la vuelca en este .dat
    assign(detalle, detalleFisico);
    reset(carga);
    rewrite(detalle);
    while (not eof(carga)) do begin
        readln(carga, a.cod);
        readln(carga, a.aprueba);
        write(detalle, a);
    end;
    close(detalle);
    close(carga);
    writeln('___________________________________');
    writeln('Archivo alumnosDetalle.dat cargado.');
    writeln('___________________________________');
    ImprimirDetalle(detalle);
end;

procedure actualizarMaestro (var maestro:archivoMaestro; var detalle:archivoDetalle);
var
    cantA, cantF : integer;
    aMaestro: alumnoMaestro;
    aDetalle: alumnoDetalle;
begin
    reset(maestro);
    reset(detalle);
    while (not eof(detalle)) do begin                                    // Comienza a avanzar en ambos.
        read(maestro, aMaestro);
        read(detalle, aDetalle);
        cantA := 0;
        cantF := 0;
        while (aMaestro.cod <> aDetalle.cod) do                         // Avanza en el maestro hasta encontrar su equivalente en el detalle.
            read(maestro, aMaestro);
            
        while ((not eof(detalle)) and (aMaestro.cod = aDetalle.cod)) do begin        // Mientras que sean equiavlentes procesa.
        
            if (aDetalle.aprueba = 'A') then
                cantA := cantA + 1
            else if (aDetalle.aprueba = 'F') then
                cantF := cantF + 1;
            read(detalle, aDetalle);
        end;
        
        aMaestro.cantA := aMaestro.cantA + cantA;           // Actualiza los campos necesarios
        aMaestro.cantFinal := aMaestro.cantFinal + cantF;
        
        if (not eof(detalle)) then
            seek(detalle, filepos(detalle) - 1);
        seek(maestro, filepos(maestro) - 1);
        write(maestro, aMaestro);                            // Sobreescribe el maestro
    end;
end;    


procedure ListarAlumnos(var maestro:archivoMaestro);
var
    carga:text;
    a:alumnoMaestro;
begin
    reset(maestro);
    assign(carga, 'alumnosCursadasAprobadas.txt');
    rewrite(carga);
    LeerMaestro(maestro, a);
    while (a.cod <> 9999) do begin
        if (a.cantA > 3) then begin
            writeln(carga, '----------');
            writeln(carga, 'Codigo: ', a.cod);
            writeln(carga, 'Nombre: ', a.apellido, ' ', a.nombre);
            writeln(carga, 'Materias aprobadas sin final: ', a.cantA);
            writeln(carga, 'Materias aprobadas con final: ', a.cantFinal);
            writeln(carga, '----------');
            LeerMaestro(maestro, a);
        end;
    end;
    close(carga);
    close(maestro);
    writeln('____________________________________________');
    writeln('Archivo alumnosCursadasAprobadas.txt cargado');
    writeln('____________________________________________');
end;

procedure Menu(var maestro:archivoMaestro; var detalle:archivoDetalle);
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
            1:actualizarMaestro(maestro, detalle);
            2:ListarAlumnos(maestro);
            3:writeln('Archivo cerrado.');
        else end;
    end;    
end;

var
    maestro:archivoMaestro;
    detalle:archivoDetalle;

BEGIN
    crearArchivoMaestro(maestro);
    crearArchivoDetalle(detalle);
    Menu(maestro, detalle);
END.
```
  
</details>

<br><hr id="Ejercicio_3"><br>

`3.` Se cuenta con un archivo de productos de una cadena de venta de alimentos congelados. De cada producto se almacena: código del producto, nombre, descripción, stock disponible, stock mínimo y precio del producto.

Se recibe diariamente un archivo detalle de cada una de las 30 sucursales de la cadena. Se debe realizar el procedimiento que recibe los 30 detalles y actualiza el stock del archivo maestro. La información que se recibe en los detalles es: código de producto y cantidad vendida. Además, se deberá informar en un archivo de texto: nombre de producto, descripción, stock disponible y precio de aquellos productos que tengan stock disponible por debajo del stock mínimo.

```
Nota: todos los archivos se encuentran ordenados por código de productos.
  En cada detalle puede venir 0 o N registros de un determinado producto.
```

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
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
        

procedure LeerMaestro (var archivo:archivoMaestro; var p:producto);
begin
    if (not eof(archivo))
        then read(archivo, p)
        else p.cod := valorAlto;
end;

procedure LeerDetalle (var archivo:archivoDetalle; var p:productoD);
begin
    if (not eof(archivo))
        then read(archivo, p)
        else p.cod := valorAlto;
end;

procedure minimo (var minD:productoD; var detalles:vectorDetalle; var registrosD:vectorRegistros);
var
    i, pos:integer;
begin
    minD.cod := valorAlto;
    for i:=1 to dimF do begin
        if (registrosD[i].cod < minD.cod) then begin            // Si el codigo es el menor hasta el momento actualiza minD y pos.
            minD := registrosD[i];
            pos := i;
        end;
    end;
    if (minD.cod <> valorAlto) then                     // Se avanza en el detalle con codigo minimo.
        LeerDetalle(detalles[pos], registrosD[pos]);            
end;

procedure actualizarMaestro(var maestro:archivoMaestro; var detalles:vectorDetalle; var registrosD:vectorRegistros);
var
    pMaestro: producto;
    minD: productoD;
    i:integer;
begin
    reset(maestro);
    for i:=1 to dimF do
        reset(detalles[i]);

    minimo(minD, detalles, registrosD);             // Busca el codigo minimo entre los productos de los detalles.
    while (minD.cod <> valorAlto) do begin          // Hasta que no se terminan de leer los detalles lee al maestro.
        LeerMaestro(maestro, pMaestro);                  
        while (pMaestro.cod <> minD.cod) do         // Lee registros del maestro hasta encontrar uno equivalente al minimo de los detalles.
            LeerMaestro(maestro, pMaestro);          
        while (pMaestro.cod = minD.cod) do begin    // Mientras que los codigos sean iguales, actualiza el registro del maestro
            pMaestro.stockD := pMaestro.stockD - minD.cant;
            minimo(minD, detalles, registrosD);                 // Busca el codigo minimo entre los productos de los detalles. 
        end;
        write(maestro, pMaestro);                    // Se actualiza el registro.
    end;
        
    close(maestro);
    for i:=1 to dimF do
        close(detalles[i]);
end;

procedure Informartxt(var maestro:archivoMaestro);
var
    p:producto;
    carga:text;
begin
    reset(maestro);
    assign(carga, 'productosStockMinimo.txt');
    rewrite(carga);
    LeerMaestro(maestro, p);
    while (p.cod <> valorAlto) do begin
        if (p.stockM > p.stockD) then begin
            writeln(carga, 'Nombre: ', p.nombre);
            writeln(carga, 'Descripcion: ', p.desc);
            writeln(carga, 'Stock disponible: ', p.stockD);
            writeln(carga, 'Precio: ', p.precio:0:00);
        end;
        LeerMaestro(maestro, p);
    end;
    close(maestro);
    close(carga);
    writeln('___________________________________');
    writeln('Archivo productosStockMinimo.txt cargado.');
    writeln('___________________________________');
end;

procedure crearArchivoMaestro (var maestro:archivoMaestro; var maestroFisico:str20);       // Crea el archivo maestro que se dispone segun la consigna
var
    carga:text;
    p:producto;
begin
    assign(carga, 'productos.txt');          // Toma la info de este .txt
    maestroFisico := 'productos.dat';                // Y la vuelca en este .dat
    assign(maestro, maestroFisico);
    rewrite(arch);
    reset(carga);
    while (not eof(carga)) do begin
        readln(carga, p.cod);
        readln(carga, p.nombre);
        readln(carga, p.desc);
        readln(carga, p.stockD);
        readln(carga, p.stockM);
        readln(carga, p.precio);
        write(maestro, p);
    end;
    close(maestro);
    close(carga);
    writeln('___________________________________');
    writeln('Archivo Practica2Ejercicio3productos.dat cargado.');
    writeln('___________________________________');
end;

var
    maestro: archivoMaestro;
    detalles: vectorDetalle;
    registrosD: vectorRegistros;
    i: integer;
    maestroFisico, iStr: str20;
        
BEGIN
    crearArchivoMaestro(maestro, maestroFisico);
    for i:=1 to dimF do begin
        Str(i,iStr);
        assign(detalles[i], 'detalle'+iStr+'.dat');      // Los 30 detalles que se reciben
        rewrite(detalles[i]);
        LeerDetalle(detalles[i], registrosD[i]);
        close(detalles[i]);
    end;
    actualizarMaestro(maestro, detalles, registrosD);
    Informartxt(maestro);
END.
```
  
</details>

<br><hr id="Ejercicio_4"><br>
  
`4.` Suponga que trabaja en una oficina donde está montada una LAN (red local). La misma fue construida sobre una topología de red que conecta 5 máquinas entre sí y todas las máquinas se conectan con un servidor central. Semanalmente cada máquina genera un archivo de logs informando las sesiones abiertas por cada usuario en cada terminal y por cuánto tiempo estuvo abierta. Cada archivo detalle contiene los siguientes campos: cod_usuario, fecha, tiempo_sesion. Debe realizar un procedimiento que reciba los archivos detalle y genere un archivo maestro con los siguientes datos: cod_usuario, fecha, tiempo_total_de_sesiones_abiertas.

```
Notas:
- Cada archivo detalle está ordenado por cod_usuario y fecha.
- Un usuario puede iniciar más de una sesión el mismo día en la misma o en diferentes máquinas.
- El archivo maestro debe crearse en la siguiente ubicación física: /var/log.
```

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
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
    assign(carga, 'Practica2Ejercicio4sesiones.txt');       // Toma la info de este .txt
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
```
  
</details>

<br><hr id="Ejercicio_5"><br>
  
`5.` A partir de un siniestro ocurrido se perdieron las actas de nacimiento y fallecimientos de toda la provincia de buenos aires de los últimos diez años. En pos de recuperar dicha información, se deberá procesar 2 archivos por cada una de las 50 delegaciones distribuidas en la provincia, un archivo de nacimientos y otro de fallecimientos y crear el archivo maestro reuniendo dicha información.

Los archivos detalles con nacimientos, contendrán la siguiente información: nro partida nacimiento, nombre, apellido, dirección detallada (calle,nro, piso, depto, ciudad), matrícula del médico, nombre y apellido de la madre, DNI madre, nombre y apellido del padre, DNI del padre.

En cambio, los 50 archivos de fallecimientos tendrán: nro partida nacimiento, DNI, nombre y apellido del fallecido, matrícula del médico que firma el deceso, fecha y hora del deceso y lugar.

Realizar un programa que cree el archivo maestro a partir de toda la información de los archivos detalles. Se debe almacenar en el maestro: nro partida nacimiento, nombre, apellido, dirección detallada (calle,nro, piso, depto, ciudad), matrícula del médico, nombre y apellido de la madre, DNI madre, nombre y apellido del padre, DNI del padre y si falleció, además matrícula del médico que firma el deceso, fecha y hora del deceso y lugar. Se deberá, además, listar en un archivo de texto la información recolectada de cada persona. 

```
Nota: Todos los archivos están ordenados por nro partida de nacimiento que es única.

Tenga en cuenta que no necesariamente va a fallecer en el distrito donde nació la persona y además puede no haber fallecido.
```

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
program Practica2Ejercicio5;

const
    valorAlto = 9999;
    dimF = 50;
type
    rango = 1..dimF;
    str20 = string[20];
        
    direccion = record
        calle:integer;
        nro:integer;
        piso:integer;
        depto:integer;
        ciudad:str20;
    end;
        
    nacimiento = record
        nro:integer;
        nombre:str20;
        apellido:str20;
        dire:direccion;
        matricula:integer;
        nombreM:str20;
        DNIm:integer;
        nombreP:str20;
        DNIp:integer;
    end;
        
    fallecimiento = record
        nro:integer;
        DNI:integer;
        nombre:str20;
        apellido:str20;
        matricula:integer;
        fecha:str20;
        lugar:str20;
    end;
        
    regMaestro = record
        nro:integer;
        nombre:str20;
        apellido:str20;
        dire:direccion;
        matriculaN:Integer;
        nombreM:str20;
        DNIm:integer;
        nombreP:str20;
        DNIp:integer;
        matriculaF:integer;
        fecha:str20;
        lugar:str20;        
    end;
        
    archivoN = file of nacimiento;
    vectorArchivoN = array[rango] of archivoN;
    vectorN = array[rango] of nacimiento;
        
    archivoF = file of fallecimiento;
    vectorArchivoF = array[rango] of archivoF;
    vectorF = array[rango] of fallecimiento;
        
    archivoM = file of regMaestro;


procedure LeerN(var archivo:archivoN; var n:nacimiento);
begin
    if(not EOF(archivo)) then
        read(archivo,n)
    else
        n.nro := valorAlto;
end;

procedure LeerF(var archivo:archivoF; var f:fallecimiento);
begin
    if(not EOF(archivo)) then
        read(archivo,f)
    else
        f.nro := valorAlto;
end;

procedure minimoN (var v:vectorArchivoN; var vR:vectorN; var min:nacimiento);
var
    i, pos: integer;
begin
    min.nro:=valorAlto;
    for i:=1 to dimF do begin
        if (vR[i].nro < min.nro) then begin
            min := vR[i];
            pos := i;
        end;
    end;
    if (min.nro <> valorAlto) then
        LeerN(v[pos], vR[pos]);
end;

procedure minimoF (var v:vectorArchivoF; var vR:vectorF; var min:fallecimiento);
var
    i, pos: integer;
begin
    min.nro := valorAlto;
    for i:=1 to dimF do begin
        if (vR[i].nro < min.nro) then begin
            min := vR[i];
            pos := i;
        end;
    end;
    if (min.nro <> valorAlto) then
        LeerF(v[pos], vR[pos]);
end;

procedure cargarNacimiento (var n:regMaestro; min:nacimiento);
begin
    with n do begin
        nro := min.nro;
        nombre := min.nombre;
        apellido := min.apellido;
        dire := min.dire;
        matriculaN := min.matricula;
        nombreM := min.nombreM;
        DNIm := min.DNIm;
        nombreP := min.nombreP;
        DNIp := min.DNIp;
        matriculaF := -1;       // Por ahora no se sabe si está muerto o no
        fecha := 'NULL';
        lugar := 'NULL';
    end;
end;

procedure cargarFallecimiento (var n:regMaestro; min:fallecimiento);
begin
    with n do begin
        matriculaF := min.matricula;
        fecha := min.fecha;
        lugar := min.lugar;
    end;
end;

procedure cargarMaestro (var maestro:archivoM; var vN:vectorArchivoN; vRN:vectorN; var vF:vectorArchivoF; vRF:vectorF);
var
    minN:nacimiento;
    minF:fallecimiento;
    M:regMaestro;
    i:integer;
begin
    for i:=1 to dimF do
        reset(vN[i]);
    assign(maestro, 'infoPersonas.dat');
    rewrite(maestro);
    minimoN(vN, vRN, minN);
    while (minN.nro <> valorAlto) do begin
        cargarNacimiento(M,minN);
        write(maestro, M);
        minimoN(vN, vRN, minN);
    end;
    for i:=1 to dimF do
        close(vN[i]);
    close(maestro);             // Una vez escrito por primera vez, cierro para despues actualizar.
    reset(maestro);
        
    for i:=1 to dimF do
        reset(vF[i]);
    minimoF(vF, vRF, minF);
    while (minF.nro <> valorAlto) do begin
        while (M.nro <> minF.nro) do
            read(maestro, M);
        cargarFallecimiento(M, minF);
        seek(maestro, filepos(maestro) -1);
        write(maestro, M);
        minimoF(vF, vRF, minF);
    end;
    for i:=1 to dimF do
        close(vF[i]);
    close(maestro);
end;

procedure cargartxt (var maestro: archivoM);
var
    carga: text;
    aux: regMaestro;
begin
    assign(carga, 'infoPersonas.txt');
    rewrite(carga);
    reset(maestro);
    read(maestro, aux);
    while (not eof(maestro)) do begin
        writeln(carga, 'Nro de partida de nacimiento: ', aux.nro);
        writeln(carga, 'Nombre completo: ', aux.apellido, ' ', aux.nombre);
        writeln(carga, 'Direccion: ', aux.dire.calle,' ',aux.dire.nro,' ', aux.dire.piso,' ', aux.dire.depto,' ', aux.dire.ciudad);
        if (aux.matriculaF <> -1) then begin
            writeln(carga, 'Fecha del fallecimiento: ', aux.fecha);
            writeln(carga, 'Lugar del fallecimiento: ', aux.lugar);
        end;
    end;
    close(carga);
    close(maestro);
end;        

var
    maestro: archivoM;
    vN: vectorArchivoN;
    vRN: vectorN;
    vF: vectorArchivoF;
    vRF: vectorF;
    i: integer;
    iStr: str20;

BEGIN
    for i:=1 to dimF do begin
        Str(i, iStr);
        assign(vN[i], 'nacimiento'+iStr+'.dat');
        assign(vF[i], 'fallecimiento'+iStr+'.dat');
        reset(vN[i]);
        reset(vF[i]);
        LeerN(vN[i], vRN[i]);
        LeerF(vF[i], vRF[i]);
        close(vN[i]);
        close(vF[i]);
    end;
    cargarMaestro(maestro, vN, vRN, vF, vRF);
    cargartxt(maestro);
END.
```
  
</details>

<br><hr id="Ejercicio_6"><br>
  
`6.` Se desea modelar la información necesaria para un sistema de recuentos de casos de covid para el ministerio de salud de la provincia de buenos aires.

Diariamente se reciben archivos provenientes de los distintos municipios, la información contenida en los mismos es la siguiente: código de localidad, código cepa, cantidad casosactivos, cantidad de casos nuevos, cantidad de casos recuperados, cantidad de casos fallecidos.

El ministerio cuenta con un archivo maestro con la siguiente información: código localidad, nombre localidad, código cepa, nombre cepa, cantidad casos activos, cantidad casos nuevos, cantidad recuperados y cantidad de fallecidos.

Se debe realizar el procedimiento que permita actualizar el maestro con los detallesrecibidos, se reciben 10 detalles. ***Todos  localidad y código de cepa.***

Para la actualización se debe proceder de la siguiente manera:
  
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ `1.` Al número de fallecidos se le suman el valor de fallecidos recibido del detalle.
  
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ `2.` Idem anterior para los recuperados.
  
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ `3.` Los casos activos se actualizan con el valor recibido en el detalle.
  
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ `4.` Idem anterior para los casos nuevos hallados.

Realice las declaraciones necesarias, el programa principal y los procedimientos que requiera para la actualización solicitada e informe cantidad de localidades con más de 50 casos activos (las localidades pueden o no haber sido actualizadas).

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
program Practica2Ejercicio6;

const
    valorAlto = 9999;
    dimF = 10;

type
    rango = 1..dimF;
    str20 = string[20];
    municipio = record
        codL:integer;
        codC:integer;
        cantA:integer;
        cantN:integer;
        cantR:integer;
        cantF:integer;
    end;
        
    regMaestro = record
        codL:integer;
        nombreL:str20;
        codC:integer;
        cantA:integer;
        cantN:integer;
        cantR:integer;
        cantF:integer;
    end;

    archivoM = file of regMaestro;

    archivoD = file of municipio;
    vArchivosD = array[rango] of archivoD;
    vMunicipios = array[rango] of municipio;
        
procedure LeerD (var arch:archivoD; var x:municipio);
begin
    if (not eof(arch)) 
        then read(arch, x)
        else x.codL := valorAlto;
end;

procedure minimo (var v:vArchivosD; var vR:vMunicipios; var min:municipio);
var
    i, pos: integer;
begin
    min.codL := valorAlto;
    for i:=1 to dimF do begin
        if (vR[i].codL > min.codL) then begin
            min := vR[i];
            pos := i;
        end;
    end;
    if (min.codL <> valorAlto) then
        LeerD(v[pos], vR[pos]);
end;

procedure actualizarMaestro (var maestro:archivoM; var vD:vArchivosD; var vRD:vMunicipios);
var
    min:municipio;
    M:regMaestro;
    i:integer;
begin
    for i:=1 to dimF do
        reset(vD[i]);
    reset(maestro);
    minimo(vD, vRD, min);
    while (min.codL <> valorAlto) do begin
        read(maestro, M);
        while (M.codL <> min.codL) do
            read(maestro, M);
        while (M.codL = min.codL) do begin
            while (M.codC <> min.codC) do
                read(maestro, M);
            while ((M.codL = min.codL) and (M.codC = min.codC)) do begin
                M.cantA := min.cantA;
                M.cantN := min.cantN;
                M.cantR := M.cantR + min.cantR;
                M.cantF := M.cantF + min.cantF;
            end;
        end;
    end;
    close(maestro);
    for i:=1 to dimF do
        close(vD[i]);
end;

procedure Informar(var maestro:archivoM);
var
    M:regMaestro;
    localidadActual: integer;
    cantActual: integer;
begin
    reset(maestro);
    read(maestro, M);
    while (not eof(maestro)) do begin
        localidadActual := M.codL;
        cantActual := 0;
        while ((not eof(maestro)) and (M.codL = localidadActual)) do begin
            cantActual := cantActual + M.cantA;
            read(maestro, M);
        end;
        writeln('Codigo de localidad: ', localidadActual);
        writeln('Cantidad de casos: ', cantActual);
    end;
    close(maestro);
end;

var
    maestro:archivoM;
    vD:vArchivosD;
    vRD:vMunicipios;
    i:integer;
    iStr:str20;
BEGIN
    for i:=1 to dimF do begin
        Str(i, iStr);
        assign(vD[i], 'detalle'+iStr+'.dat');
        reset(vD[i]);
        LeerD(vD[i], vRD[i]);
        close(vD[i]);
    end;
    actualizarMaestro(maestro, vD, vRD);
    Informar(maestro);  
END.
```
  
</details>

<br><hr id="Ejercicio_7"><br>
  
`7.` El encargado de ventas de un negocio de productos de limpieza desea administrar el stock de los productos que vende. Para ello, genera un archivo maestro donde figuran todos los productos que comercializa. De cada producto se maneja la siguiente información: código de producto, nombre comercial, precio de venta, stock actual y stock mínimo. 

Diariamente se genera un archivo detalle donde se registran todas las ventas de productos realizadas. De cada venta se registran: código de producto y cantidad de unidades vendidas.

Se pide realizar un programa con opciones para:

‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎`a.` Actualizar el archivo maestro con el archivo detalle, sabiendo que:

‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎● Ambos archivos están ordenados por código de producto.

‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎● Cada registro del maestro puede ser actualizado por 0, 1 ó más registros del archivo detalle.

‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎● El archivo detalle sólo contiene registros que están en el archivo maestro.

‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎`b.` Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo stock actual esté por debajo del stock mínimo permitido.

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
program Practica2Ejercicio7;

const
    valorAlto = -1;

type
    str20 = string[20];
    regMaestro = record
        cod:integer;
        nombre:str20;
        precio:real;
        stockA:integer;
        stockM:integer;
    end;
        
    regDetalle = record
        cod:integer;
        cant:integer;
    end;
        
    archivoM = file of regMaestro;
    archivoD = file of regDetalle;
        
procedure LeerM (var maestro:archivoM; var r:regMaestro);
begin
    if (not eof(maestro))
        then read(maestro, r)
        else r.cod := valorAlto;
end;

procedure LeerD (var detalle:archivoD; var r:regDetalle);
begin
    if (not eof(detalle))
        then read(detalle, r)
        else r.cod := valorAlto;
end;

procedure actualizarMaestro (var maestro:archivoM; var detalle:archivoD);
var
    m:regMaestro;
    d:regDetalle;
begin
    reset(maestro);
    reset(detalle);
    LeerD(detalle, d);
    while (d.cod <> -1) do begin
        LeerM(maestro, m);
        while (m.cod <> d.cod) do
            LeerM(maestro, m);
        while ((d.cod <> valorAlto) and (m.cod = d.cod)) do begin
            m.stockA := m.stockA - d.cant;
            LeerD(detalle, d);
        end;
        seek(maestro, filepos(maestro) -1);
        write(maestro, m);
    end;
    close(maestro);
    close(detalle);
end;

procedure listarEn_txt (var maestro:archivoM);
var
    carga:text;
    m:regMaestro;
begin
    reset(maestro);
    assign(carga, 'stock_minimo.txt');
    rewrite(carga);
    while (not eof(maestro)) do begin
        read(maestro, m);
        if (m.stockA < m.stockM) then begin
            writeln(carga, 'Codigo del producto: ', m.cod);
            writeln(carga, 'Nombre: ', m.nombre);
            writeln(carga, 'Precio: ', m.precio);
            writeln(carga, 'Stock actual: ', m.stockA);
            writeln(carga, 'Stock minimo: ', m.stockM);
        end;
    end;
end;

var
    maestro:archivoM;
    detalle:archivoD;

BEGIN
    assign(maestro, 'maestroProductos.dat');
    assign(detalle, 'detalleProductos.dat');
    actualizarMaestro(maestro, detalle);
    listarEn_txt(maestro);
END.
```
  
</details>

<br><hr id="Ejercicio_8"><br>
  
`8.` Se cuenta con un archivo que posee información de las ventas que realiza una empresa a los diferentes clientes. Se necesita obtener un reporte con las ventas organizadas por cliente. Para ello, se deberá informar por pantalla: los datos personales del cliente, el total mensual (mes por mes cuánto compró) y finalmente el monto total comprado en el año por el cliente.

Además, al finalizar el reporte, se debe informar el monto total de ventas obtenido por la empresa.

El formato del archivo maestro está dado por: cliente (cod cliente, nombre y apellido), año, mes, día y monto de la venta.

El orden del archivo está dado por: cod cliente, año y mes.

```
Nota: tenga en cuenta que puede haber meses en los que los clientes no realizaron compras.
```

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
program Practica2Ejercicio8;

const
    valorAlto = -1;
        
type
    str20 = string[20];
    rAnio = 1900..2023;
    rMes = 1..12;
    rDia = 1..31;
    cli = record
        cod:integer;
        nombre: str20;
        apellido: str20;
    end;
    regMaestro = record
        cliente:cli;
        anio:rAnio;
        mes:rMes;
        dia:rDia;
        monto:real;
    end;

    archivoM = file of regMaestro;

procedure Leer (var maestro:archivoM; var r:regMaestro);
begin
    if (not eof(maestro))
        then read(maestro, r)
        else r.cliente.cod := valorAlto;
end;

procedure procesarMaestro (var maestro:archivoM);
var
    m, actual:regMaestro;
    aux, auxAnual:real;
begin
    reset(maestro);
    Leer(maestro, m);
    while (m.cliente.cod <> valorAlto) do begin
        actual.cliente.cod := m.cliente.cod;
        writeln('Codigo de cliente: ', m.cliente.cod);
        writeln('Nombre completo: ', m.cliente.apellido, ' ', m.cliente.nombre);
        while (actual.cliente.cod = m.cliente.cod) do begin
            actual.anio := m.anio;
            auxAnual := 0;
            writeln('\nGastos del anio ', m.anio, '\n');
            while ((actual.cliente.cod = m.cliente.cod) and (actual.anio = m.anio)) do begin
                actual.mes := m.mes;
                aux := 0;
                while ((m.cliente.cod <> valorAlto) and (actual.cliente.cod = m.cliente.cod) and (actual.anio = m.anio) and (actual.mes = m.mes)) do begin
                    aux := aux + m.monto;
                    Leer(maestro, m);
                end;
                auxAnual := auxAnual + aux;
                writeln('Gastos del mes ',actual.mes,' $',aux:0:2);
            end;
            writeln('Monto gastado en el anio: $', auxAnual:0:2);
            writeln();
        end;
    end;
    close(maestro);
end; 

var
    maestro:archivoM;

BEGIN
    assign(maestro, 'ventasEmpresa.dat');
    procesarMaestro(maestro);
END.
```
  
</details>

<br><hr id="Ejercicio_9"><br>
  
`9.` Se necesita contabilizar los votos de las diferentes mesas electorales registradas por provincia y localidad. Para ello, se posee un archivo con la siguiente información: código de provincia, código de localidad, número de mesa y cantidad de votos en dicha mesa. 

Presentar en pantalla un listado como se muestra a continuación:
```
Código de Provincia
Código de Localidad         Total de Votos
...................         ..............
...................         ..............

Total de Votos Provincia: ____


Código de Provincia
Código de Localidad         Total de Votos
...................         ..............

Total de Votos Provincia: ___

..........................................

Total General de Votos: ___
```

```
NOTA: La información se encuentra ordenada por código de provincia y código de localidad.
```

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
program Practica2Ejercicio9;

const
    valorAlto = -1;

type
    mesa = record
        codP: integer;
        codL: integer;
        num : integer;
        cant: integer;
    end;
        
    archivo = file of mesa;

procedure Leer (var arch:archivo; var m:mesa);
begin
    if (not eof(arch))
        then read(arch, m)
        else m.codP := valorAlto;
end;

procedure procesar (var arch:archivo);
var
    act, m:mesa;
    contProv, contLocal, contTotal:integer;
begin
    reset(arch);
    Leer(arch,m);
    contTotal := 0;
    while (m.codP <> valorAlto) do begin
        act.codP := m.codP;
        contProv := 0;
        writeln('Codigo de provincia: ', m.codP);
        while (m.codP = act.codP) do begin
            act.codL := m.codL;
            contLocal := 0;
            write('Codigo de localidad: ', m.codL);
            while ((m.codL = act.codL) and (m.codP = act.codP)) do begin
                contLocal := contLocal + m.cant;
            end;
            writeln('     ', contLocal);
            contProv := contProv + contLocal;
        end;
        contTotal := contTotal + contProv;
        writeln('Total de Votos Provincia: ', contProv);
    end;
    writeln('Total General de Votos: ', contTotal);
    close(arch);
end;

var
    arch:archivo;

BEGIN
    assign(arch,'mesasElectorales.dat');
    procesar(arch);
END.
```
  
</details>

<br><hr id="Ejercicio_10"><br>
 
`10.` Se tiene información en un archivo de las horas extras realizadas por los empleados de una empresa en un mes. Para cada empleado se tiene la siguiente información: departamento, división, número de empleado, categoría y cantidad de horas extras realizadas por el empleado. Se sabe que el archivo se encuentra ordenado por departamento, luego por división, y por último, por número de empleados. Presentar en pantalla un listado con el siguiente formato:

```
Departamento
División
Número de Empleado Total de Hs. Importe a cobrar
...... .......... .........
...... .......... .........
Total de horas división: ____
Monto total por división: ____
División
.................
Total horas departamento: ____
Monto total departamento: ____
```

Para obtener el valor de la hora se debe cargar un arreglo desde un archivo de texto al iniciar el programa con el valor de la hora extra para cada categoría. La categoría varía de 1 a 15. En el archivo de texto debe haber una línea para cada categoría con el número de categoría y el valor de la hora, pero el arreglo debe ser de valores de horas, con la posición del valor coincidente con el número de categoría.

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
program Practica2Ejercicio10;

const
    dimF = 15;
    valorAlto = 9999;

type
    categoria = 1..dimF;
    empleado = record
        departamento: integer;
        division: integer;
        nro: integer;
        cat: categoria;
        cantH: real;
    end;
        
    archivoE = file of empleado;
    vector = array[categoria] of real;


procedure leer (var arch:archivoE; var e:empleado);
begin
    if (not eof(arch))
        then read(arch, e)
        else e.departamento := valorAlto;
end;


procedure cargarVector (var v:vector);
var
    carga:text;
    cat:categoria;
    valor:real;
    i:integer;
begin
    assign(carga, 'valorDeCadaHoraExtra.txt');
    reset(carga);
    for i:=1 to dimF do begin
        readln(carga, cat, valor);      // En cada linea del archivo está el numero de categoria (cat) y el valor de la hora (valor)
        v[cat] := valor;
    end;
    close(carga);
end;


procedure Imprimir(var arch:archivoE; v:vector);
var
    totalHorasDepto, montoTotalDepto, totalHorasDiv, montoTotalDiv: real;
    e, eActual:empleado;
begin
    reset(arch);
    leer(arch, e);
        
    while (e.departamento <> valorAlto) do begin
        eActual := e;
        totalHorasDepto := 0;
        montoTotalDepto := 0;
        writeln('Departamento ', eActual.departamento);
        
        while (eActual.departamento = e.departamento) do begin
            eActual := e;
            totalHorasDiv := 0;
            montoTotalDiv := 0;
            writeln('Division ', eActual.division);
            
            while ((eActual.division = e.division) and (eActual.departamento = e.departamento)) do begin
                eActual := e;
                writeln('Nro de empleado: ', eActual.nro, ' | Horas extra: ',eActual.cantH, ' | A cobrar: $', (v[eActual.cat] * eActual.cantH));
                totalHorasDiv := totalHorasDiv + eActual.cantH;
                montoTotalDiv := montoTotalDiv + (v[eActual.cat] * eActual.cantH);
                leer(arch,e);
            end;
            
            writeln('Total de horas division: ', totalHorasDiv);
            writeln('Monto total por division: ', montoTotalDiv);
            writeln();
            totalHorasDepto := totalHorasDepto + totalHorasDiv;
            montoTotalDepto := montoTotalDepto + montoTotalDiv;
        end;
        
        writeln('Total horas departamento: ', totalHorasDepto);
        writeln('Monto total departamento: ', montoTotalDepto);
        writeln();
    end;
        
    close(arch);
end;

var
    maestro:archivoE;
    detalle:vector;

BEGIN
    assign(maestro, 'horasExtras.dat');
    cargarVector(detalle);
    Imprimir(maestro,detalle);
END.
```
  
</details>

<br><hr id="Ejercicio_11"><br>
  
`11.` A partir de información sobre la alfabetización en la Argentina, se necesita actualizar un archivo que contiene los siguientes datos: nombre de provincia, cantidad de personas alfabetizadas y total de encuestados. Se reciben dos archivos detalle provenientes de dos agencias de censo diferentes, dichos archivos contienen: nombre de la provincia, código de localidad, cantidad de alfabetizados y cantidad de encuestados. Se pide realizar los módulos necesarios para actualizar el archivo maestro a partir de los dos archivos detalle.

```
NOTA: Los archivos están ordenados por nombre de provincia y en los
  archivos detalle pueden venir 0, 1 ó más registros por cada provincia.
```

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
program Practica2Ejercicio11;

const
    valorAlto = 'zzzz';

type
    str = string[53];
    censo = record
        nombre: str;
        cantA: integer;
        cantE: integer;
    end;
        
    censoDetalle = record
        info: censo;
        localidad: str;
    end;
        
    archivoM = file of censo;
    archivoD = file of censoDetalle;

procedure LeerMaestro (var arch:archivoM; var c:censo);
begin
    if (not eof(arch))
        then read(arch,c)
        else c.nombre := valorAlto;
end;

procedure LeerDetalle (var arch:archivoD; var c:censoDetalle);
begin
    if (not eof(arch))
        then read(arch,c)
        else c.info.nombre := valorAlto;
end;

procedure minimo (var arch1, arch2:archivoD; var c1, c2:censoDetalle; var min:censoDetalle);
begin
    if (c1.info.nombre <= c2.info.nombre) then begin
        min := c1;
        LeerDetalle(arch1, c1);
    end else begin
        min := c2;
        LeerDetalle(arch2, c2);
    end;
end;

procedure actualizarMaestro (var maestro:archivoM; var detalle1, detalle2:archivoD);
var
    m: censo;
    min, c1, c2: censoDetalle;
begin
    reset(maestro);
    reset(detalle1);
    reset(detalle2);
    LeerDetalle(detalle1, c1);
    LeerDetalle(detalle2, c2);
    minimo(detalle1, detalle2, c1, c2, min);
        
    while (min.info.nombre <> valorAlto) do begin
        LeerMaestro(maestro, m);
        
        while (min.info.nombre <> m.nombre) do begin
            LeerMaestro(maestro, m);
        end;
        
        while (min.info.nombre = m.nombre) do begin
            m.cantA := m.cantA + min.info.cantA;
            m.cantE := m.cantE + min.info.cantE;
            minimo(detalle1, detalle2, c1, c2, min);
        end;
        
        seek(maestro, filepos(maestro) -1);
        write(maestro, m);
    end;
        
    close(maestro);
    close(detalle1);
    close(detalle2);
end;

var
    maestro: archivoM;
    detalle1, detalle2: archivoD;

BEGIN
    assign(maestro, 'censo.dat');
    assign(detalle1, 'censoDetalle1.dat');
    assign(detalle2, 'censoDetalle2.dat');
    actualizarMaestro(maestro, detalle1, detalle2);
END.
```
  
</details>

<br><hr id="Ejercicio_12"><br>
  
`12.` La empresa de software ‘X’ posee un servidor web donde se encuentra alojado el sitio de la organización. En dicho servidor, se almacenan en un archivo todos los accesos que se realizan al sitio.

La información que se almacena en el archivo es la siguiente: año, mes, dia, idUsuario y tiempo de acceso al sitio de la organización. El archivo se encuentra ordenado por los siguientes criterios: año, mes, dia e idUsuario.

Se debe realizar un procedimiento que genere un informe en pantalla, para ello se indicará el año calendario sobre el cual debe realizar el informe. El mismo debe respetar el formato mostrado a continuación:

```
Año : ---
Mes:-- 1
día:-- 1
idUsuario 1 Tiempo Total de acceso en el dia 1 mes 1
--------
idusuario N Tiempo total de acceso en el dia 1 mes 1
Tiempo total acceso dia 1 mes 1
-------------
día N
idUsuario 1 Tiempo Total de acceso en el dia N mes 1
--------
idusuario N Tiempo total de acceso en el dia N mes 1
Tiempo total acceso dia N mes 1
Total tiempo de acceso mes 1
------
Mes 12
día 1
idUsuario 1 Tiempo Total de acceso en el dia 1 mes 12
--------
idusuario N Tiempo total de acceso en el dia 1 mes 12
Tiempo total acceso dia 1 mes 12
-------------
día N
idUsuario 1 Tiempo Total de acceso en el dia N mes 12
--------
idusuario N Tiempo total de acceso en el dia N mes 12
Tiempo total acceso dia N mes 12
Total tiempo de acceso mes 12
Total tiempo de acceso año
```

Se deberá tener en cuenta las siguientes aclaraciones:

‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ - El año sobre el cual realizará el informe de accesos debe leerse desde teclado.

‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ - El año puede no existir en el archivo, en tal caso, debe informarse en pantalla “año no encontrado”.

‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ - Debe definir las estructuras de datos necesarias.

‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ - El recorrido del archivo debe realizarse una única vez procesando sólo la información necesaria.

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
program Practica2Ejercicio12;

const
    valorAlto = 1988;

type
    anios = 1988..2023;
    str = string[20];
    fech = record
        dia: 1..31;
        mes: 1..12;
        anio: anios;
    end;
    acceso = record
        fecha: fech;
        idUsuario: str;
        tiempo: real;
    end;
        
    archivo = file of acceso;

procedure Leer(var arch:archivo; var a:acceso);
begin
    if (not eof(arch))
        then read(arch,a)
        else a.fecha.anio := valorAlto;
end;

procedure Imprimir (var arch:archivo; a:acceso);
var
    Actual: acceso;
    anio: anios;
    tUsuario, tDiario, tMensual, tAnual: real;
begin
    tAnual := 0;
    anio := a.fecha.anio;
    writeln('Anio: ', anio);
        
    while (a.fecha.anio = anio) do begin
        tMensual := 0;
        Actual := a;
        writeln('   Mes: ', Actual.fecha.mes);
        
        while ((a.fecha.mes = Actual.fecha.mes) and (a.fecha.anio = anio)) do begin
            tDiario := 0;
            Actual := a;
            writeln('       dia: ', Actual.fecha.dia);
            
            while ((a.fecha.dia = Actual.fecha.dia) and (a.fecha.mes = Actual.fecha.mes) and (a.fecha.anio = anio)) do begin
                tUsuario := 0;
                Actual := a;
                
                while ((a.idUsuario = Actual.idUsuario) and (a.fecha.dia = Actual.fecha.dia) and (a.fecha.mes = Actual.fecha.mes) and (a.fecha.anio = anio)) do begin
                    tUsuario := tUsuario + Actual.tiempo;
                    Leer(arch, a);
                end;
                
                writeln('           Usuario: ', Actual.idUsuario, ' | Tiempo Total de acceso en el dia ', Actual.fecha.dia,'/', Actual.fecha.mes,'/', Actual.fecha.anio,': ', tUsuario);
                tDiario := tDiario + tUsuario;
            end;
            
            writeln('       Tiempo total acceso dia ', Actual.fecha.dia,'/', Actual.fecha.mes,'/', Actual.fecha.anio,': ', tDiario);
            tMensual := tMensual + tDiario;
        end;
        
        writeln('   Tiempo total acceso mes ', Actual.fecha.mes,'/', Actual.fecha.anio,': ', tMensual);
        tAnual := tAnual + tMensual;
    end;
        
    writeln('Tiempo total acceso anio ', Actual.fecha.anio,': ', tAnual);
    close(arch);
end;

procedure chequearAnio (var arch:archivo; anio:anios);
var
    a:acceso;
begin
    reset(arch);
    Leer(arch, a);
        
    while ((a.fecha.anio <> valorAlto) and (a.fecha.anio <> anio)) do begin
        Leer(arch,a);
    end;
    if (a.fecha.anio = anio)
        then Imprimir(arch,a)
        else writeln('Anio no encontrado.');
    close(arch);
end;

var
    arch:archivo;
    anio:anios;

BEGIN
    assign(arch, 'accesos.dat');
    write('Ingrese un anio para buscar: ');
    readln(anio);
    chequearAnio(arch, anio);
END.
```
  
</details>

<br><hr id="Ejercicio_13"><br>
  
`13.` Suponga que usted es administrador de un servidor de correo electrónico. En los logs del mismo (información guardada acerca de los movimientos que ocurren en el server) que se encuentra en la siguiente ruta: /var/log/logmail.dat se guarda la siguiente información: nro_usuario, nombreUsuario, nombre, apellido, cantidadMailEnviados. Diariamente el servidor de correo genera un archivo con la siguiente información: nro_usuario, cuentaDestino, cuerpoMensaje. Este archivo representa todos los correos enviados por los usuarios en un día determinado. Ambos archivos están ordenados por nro_usuario y se sabe que un usuario puede enviar cero, uno o más mails por día.

‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ `a-` Realice el procedimiento necesario para actualizar la información del log en un día particular. Defina las estructuras de datos que utilice su procedimiento.

‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ `b-` Genere un archivo de texto que contenga el siguiente informe dado un archivo detalle de un día determinado:

```
nro_usuarioX…………..cantidadMensajesEnviados
………….
nro_usuarioX+n………..cantidadMensajesEnviados
```

```
Nota: tener en cuenta que en el listado deberán aparecer todos los usuarios que existen en el sistema.
```

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
program Practica2Ejercicio13;

const
    valorAlto = 9999;

type
    str = string[20];
    log = record
        nroU: integer;
        nombreU: str;
        nombre: str;
        apellido: str;
        cantMails: integer;
    end;

    correos = record
        nroU: integer;
        cuentaD: str;
        cuerpo: string;
    end;

    archivoM = file of log;
    archivoD = file of correos;

procedure LeerMaestro (var arch:archivoM; var l:log);
begin
    if (not eof(arch))
        then read(arch, l)
        else l.nroU := valorAlto;
end;

procedure LeerDetalle (var arch:archivoD; var c:correos);
begin
    if (not eof(arch))
        then read(arch, c)
        else c.nroU := valorAlto;
end;

procedure incisoA (var maestro:archivoM);
var
    m:log;
    detalle: archivoD;
    d: correos;
    nombreDetalle: string;
begin
    write('Ingrese el nombre del detalle a utilizar: ');
    readln(nombreDetalle);
    assign(detalle, nombreDetalle);
    reset(maestro);
    reset(detalle);
    LeerDetalle(detalle, d);

    while (d.nroU <> valorAlto) do begin
        LeerMaestro(maestro, m);

        while (d.nroU <> m.nroU) do begin
            LeerMaestro(maestro, m);
        end;

        while (d.nroU = m.nroU) do begin
            m.cantMails := m.cantMails + 1;
            LeerDetalle(detalle, d);
        end;

        seek(maestro, filepos(maestro) -1);
        write(maestro, m);
    end;

    close(maestro);
    close(detalle);
end;

procedure incisoB (var maestro:archivoM);
var
    m:log;
    detalle: archivoD;
    d:correos;
    nombreDetalle, txt:str;
    carga:text;
    userActual, cantMails:integer;
begin
    reset(maestro);
    LeerMaestro(maestro, m);

    write('Ingrese el nombre del detalle (ruta) a utilizar: ');
    readln(nombreDetalle);
    assign(detalle, nombreDetalle);
    reset(detalle);
    LeerDetalle(detalle, d);

    write('Ingrese el nombre del .txt a crear: ');
    readln(txt);
    assign(carga, txt);
    rewrite(carga);

    while (m.nroU <> valorAlto) do begin
    cantMails := 0;
    userActual := d.nroU;
        write(m.nroU, '..........');

        while (m.nroU = d.nroU) do begin
            cantMails := cantMails + 1;
            LeerDetalle(detalle, d);
        end;

        if (m.nroU = userActual)            // Si coinciden, quiere decir que existe en el detalle,
            then writeln(cantMails)         // entonces imprime la cantidad de correos de ese día,
            else writeln(0);                // si no coinciden, quiere decir que existe un user en el maestro que no existe en el detalle, por lo tanto, ese día envió 0 correos.
        
        LeerMaestro(maestro, m);
    end;

    close(maestro);
    close(detalle);
end;

var
    maestro: archivoM;

BEGIN
    assign(maestro, '/var/log/logmail.dat');
    incisoA(maestro);
    incisoB(maestro);
END.
```
  
</details>

<br><hr id="Ejercicio_14"><br>

`14.` Una compañía aérea dispone de un archivo maestro donde guarda información sobre sus próximos vuelos. En dicho archivo se tiene almacenado el destino, fecha, hora de salida y la cantidad de asientos disponibles. La empresa recibe todos los días dos archivos detalles para actualizar el archivo maestro. En dichos archivos se tiene destino, fecha, hora de salida y cantidad de asientos comprados. Se sabe que los archivos están ordenados por destino más fecha y hora de salida, y que en los detalles pueden venir 0, 1 ó más registros por cada uno del maestro. Se pide realizar los módulos necesarios para:

‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ `a.` Actualizar el archivo maestro sabiendo que no se registró ninguna venta de pasaje sin asiento disponible.
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ `b.` Generar una lista con aquellos vuelos (destino y fecha y hora de salida) que tengan menos de una cantidad específica de asientos disponibles. La misma debe ser ingresada por teclado.

```
NOTA: El archivo maestro y los archivos detalles sólo pueden recorrerse una vez.
```

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
program Practica2Ejercicio14;

const
    valorAlto = 'zzz';

type
    str = string[20];
    vueloMaestro = record
        destino: str;
        fecha: str;
        hora: str;
        asientosDisponibles: integer;
    end;

    vueloDetalle = record
        destino: str;
        fecha: str;
        hora: str;
        asientosComprados: integer;
    end;

    vuelosLista = record
        destino: str;
        fecha: str;
        hora: str;
    end;

    archivoM = file of vueloMaestro;
    archivoD = file of vueloDetalle;

    Lista = ^nodo;
    nodo = record
        dato: vuelosLista;
        sig: Lista;
    end;

procedure LeerMaestro (var maestro:archivoM; var v:vueloMaestro);
begin
    if (not eof(maestro))
        then read(maestro, v)
        else v.destino := valorAlto;
end;

procedure LeerDetalle (var detalle:archivoD; var v:vueloDetalle);
begin
    if (not eof(detalle))
        then read(detalle, v)
        else v.destino := valorAlto;
end;

procedure agregarAtras (var l, ult: Lista; dato:vueloMaestro);
var
    nue: lista;
begin
    new(nue);
    nue^.dato.destino := dato.destino;
    nue^.dato.fecha := dato.fecha;
    nue^.dato.hora := dato.hora;
    nue^.sig := nil;
    if (l <> nil) then
        ult^.sig := nue
    else
        l := nue;
    ult := nue;
end;

procedure minimo (var d1, d2: archivoD; var r1, r2, min: vueloDetalle);
begin
    if ((r1.destino <= r2.destino) and (r1.fecha <= r2.fecha) and (r1.hora <= r2.hora)) then begin
        min := r1;
        LeerDetalle(d1, r1);
    end else begin
        min := r2;
        LeerDetalle(d2, r2);
    end;
end;

procedure procesar (var maestro:archivoM; var detalle1, detalle2:archivoD; var L:Lista);
var
    m: vueloMaestro;
    d1, d2, min: vueloDetalle;
    asientosEspecificos: integer;
    ult: Lista;
begin
    reset(maestro);
    reset(detalle1);
    reset(detalle2);
    LeerDetalle(detalle1, d1);
    LeerDetalle(detalle2, d2);

    write('Ingrese una cantidad de asientos para buscar vuelos: ');
    readln(asientosEspecificos);

    minimo(detalle1, detalle2, d1, d1, min);
    
    while (min.destino <> valorAlto) do begin
        LeerMaestro(maestro, m);

        while (m.destino <> min.destino) do begin                   // Mientras que no encuentre un vuelo que este en alguno de los detalles,
            if (m.asientosDisponibles < asientosEspecificos) then   // se debe preguntar por la cantidad de asientos disponibles de ese mismo,
                agregarAtras(L,ult,m);                              // para saber si se agrega a la lista o no.
            LeerMaestro(maestro, m);
        end;

        while (m.destino = min.destino) do begin

            while (m.fecha <> min.fecha) do begin                       // Mientras que no encuentre un vuelo que este en alguno de los detalles,
                if (m.asientosDisponibles < asientosEspecificos) then   // se debe preguntar por la cantidad de asientos disponibles de ese mismo,
                    agregarAtras(L,ult,m);                              // para saber si se agrega a la lista o no.
                LeerMaestro(maestro, m);
            end;

            while ((m.fecha = min.fecha) and (m.destino = min.destino)) do begin
                
                while (m.hora <> min.hora) do begin                         // Mientras que no encuentre un vuelo que este en alguno de los detalles,
                    if (m.asientosDisponibles < asientosEspecificos) then   // se debe preguntar por la cantidad de asientos disponibles de ese mismo,
                        agregarAtras(L,ult,m);                              // para saber si se agrega a la lista o no.
                    LeerMaestro(maestro, m);
                end;

                while ((m.hora = min.hora) and (m.fecha = min.fecha) and (m.destino = min.destino)) do begin
                    m.asientosDisponibles := m.asientosDisponibles - min.asientosComprados;
                    minimo(detalle1, detalle2, d1, d1, min);
                end;
            end;
        end;

        seek(maestro, filepos(maestro)-1);
        write(maestro, m);
        if (m.asientosDisponibles < asientosEspecificos) then       // Una vez que se termine de procesar un mismo vuelo, 
            agregarAtras(L,ult,m);                                  // para saber si se agrega a la lista o no.
    end;

    close(maestro);
    close(detalle1);
    close(detalle2);
end;

var
    maestro: archivoM;
    detalle1, detalle2: archivoD;
    L:Lista;

BEGIN
    assign(maestro, 'maestroVuelos.dat');
    assign(detalle1, 'detalle1Vuelos.dat');
    assign(detalle2, 'detalle2Vuelos.dat');
    L := nil;
    procesar(maestro, detalle1, detalle2, L);
END.
```
  
</details>

<br><hr id="Ejercicio_15"><br>

`15.` Se desea modelar la información de una ONG dedicada a la asistencia de personas con carencias habitacionales. La ONG cuenta con un archivo maestro conteniendo información como se indica a continuación: Código pcia, nombre provincia, código de localidad, nombre de localidad, #viviendas sin luz, #viviendas sin gas, #viviendas de chapa, #viviendas sin agua,# viviendas sin sanitarios.
 
Mensualmente reciben detalles de las diferentes provincias indicando avances en las obras de ayuda en la edificación y equipamientos de viviendas en cada provincia. La información de los detalles es la siguiente: Código pcia, código localidad, #viviendas con luz, #viviendas construidas, #viviendas con agua, #viviendas con gas, #entrega sanitarios.


Se debe realizar el procedimiento que permita actualizar el maestro con los detalles recibidos, se reciben 10 detalles. Todos los archivos están ordenados por código de provincia y código de localidad.

Para la actualización se debe proceder de la siguiente manera:
`1.` Al valor de vivienda con luz se le resta el valor recibido en el detalle.
`2.` Idem para viviendas con agua, gas y entrega de sanitarios.
`3.` A las viviendas de chapa se le resta el valor recibido de viviendas construidas

La misma combinación de provincia y localidad aparecen a lo sumo una única vez. Realice las declaraciones necesarias, el programa principal y los procedimientos que requiera para la actualización solicitada e informe cantidad de localidades sin viviendas de chapa (las localidades pueden o no haber sido actualizadas).

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
program Practica2Ejercicio15;

const
    valorAlto = 9999;
    dimF = 10;

type
    str20 = string[20];
    infoMaestro = record
        codProv : integer;
        nombreProv : str20;
        codLoc : integer;
        nombreLoc : str20;
        sinLuz : integer;
        sinGas : integer;
        deChapa : integer;
        sinAgua : integer;
        sinSanitarios : integer;
    end;

    infoDetalle = record
        codProv: integer;
        codLoc: integer;
        conLuz: integer;
        conGas: integer;
        construidas: integer;
        conAgua: integer;
        conSanitarios: integer;
    end;

    archivoM = file of infoMaestro;
    archivoD = file of infoDetalle;
    vDetalle = array[1..dimF] of archivoD;
    registrosDetalles = array[1..dimF] of infoDetalle;

procedure LeerMaestro (var archivo:archivoM; var info:infoMaestro);
begin
    if (not eof(archivo))
        then read(archivo, info)
        else info.codProv := valorAlto;
end;

procedure LeerDetalle (var archivo:archivoD; var info:infoDetalle);
begin
    if (not eof(archivo))
        then read(archivo, info)
        else info.codProv := valorAlto;
end;

procedure abrirArchivos (var maestro:archivoM; var detalles:vDetalles);
var
    i: integer;
begin
    reset(maestro);
    for i:=1 to dimF do
        reset(detalles[i]);
end;

procedure cerrarArchivos (var maestro:archivoM; var detalles:vDetalles);
var
    i: integer;
begin
    close(maestro);
    for i:=1 to dimF do
        close(detalles[i]);
end;

procedure minimo (var v:vDetalle; var rD:registrosDetalles; var min:infoDetalle);
var
    i, pos: integer;
begin
    min.codProv := valorAlto;
    min.codLoc := valorAlto;
    for i:= 1 to dimF do begin
        if ((rD[i].codProv <= min.codProv) and (rD[i].codLoc
        < min.codLoc)) then begin       // No se puede repetir una combinacion de codProv y codLoc, por eso se pregunta por ( <= ) & ( < ).
            min := rD[i];
            pos := i;
        end;
    end;
    if (min.codProv <> valorAlto) then
        LeerDetalle(v[pos], rD[pos]);
end;

procedure actualizarMaestro (var maestro:archivoM; var detalles:vDetalle; var rDetalles:registrosDetalles);
var
    m: infoMaestro;
    min: infoDetalle;
begin
    abrirArchivos(maestro, detalles);
    minimo(detalles, rDetalles, min);
    LeerMaestro(maestro, m);

    while (min.codProv <> valorAlto) do begin

        while (m.codProv <> min.codProv) do begin
            LeerMaestro(maestro, m);
        end;

        while (m.codProv = min.codProv) do begin                                        // Una vez que encuentra dos registros con la misma provincia,
            if ((m.codLoc = min.codLoc) and (m.codProv = min.codProv)) then begin       // se fija una unica vez si conciden las localidades,
                m.sinLuz := m.sinLuz - min.conLuz;                                      // si coinciden, actualiza
                m.sinGas := m.sinGas - min.conGas;
                m.sinAgua := m.sinAgua - min.conAgua;
                m.sinSanitarios := m.sinSanitarios - min.conSanitarios;
                m.deChapa := m.deChapa - min.construidas;
                minimo(detalles, rDetalles, min);                                        // si coincidieron, vuelve a buscar un minimo para seguir actualizando

                seek(maestro, filepos(maestro) -1);
                write(maestro, m);
            end;
            LeerMaestro(maestro, m);                                                    // coincidan o no, lee en el maestro para seguir buscando.
        end;
    end;
    cerrarArchivos(maestro, detalles);
end;

var
    maestro: archivoM;
    detalles: vDetalle;
    rDetalles: registrosDetalles;
    i: integer;
    iStr: str20;

BEGIN
    assign(maestro, 'infoCenso.dat');
    for i := 1 to dimF do begin
        Str(i, iStr);
        assign(detalles[i], 'infoCensoDetalle(' + iStr + ').dat');
        reset(detalles[i]);
        LeerDetalle(detalles[i], rDetalles[i]);
        close(detalles[i]);
    end;
    actualizarMaestro(maestro, detalles, rDetalles);
END.
```
  
</details>

<br><hr id="Ejercicio_16"><br>

`16.` La editorial X, autora de diversos semanarios, posee un archivo maestro con la información correspondiente a las diferentes emisiones de los mismos. De cada emisión se registra: fecha, código de semanario, nombre del semanario, descripción, precio, total de ejemplares y total de ejemplares vendido.

Mensualmente se reciben 100 archivos detalles con las ventas de los semanarios en todo el país. La información que poseen los detalles es la siguiente: fecha, código de semanario y cantidad de ejemplares vendidos. Realice las declaraciones necesarias, la llamada al procedimiento y el procedimiento que recibe el archivo maestro y los 100 detalles y realice la actualización del archivo maestro en función de las ventas registradas. Además deberá informar fecha y semanario que tuvo más ventas y la misma información del semanario con menos ventas.

```
Nota: Todos los archivos están ordenados por fecha y código de semanario.
  No se realizan ventas de semanarios si no hay ejemplares para hacerlo
```

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
program Practica2Ejercicio16;

const
    stringAlto = '■■■■■';
    valorAlto = 9999;
    dimF = 100;

type
    str20 = string[20];
    emision = record
        fecha: str20;
        cod: integer;
        nombre: str20;
        desc: str20;
        precio: real;
        total: integer;
        ventas: integer;
    end;

    venta = record
        fecha: str20;
        cod: integer;
        ventas: integer;
    end;

    archivoM = file of emision;
    archivoD = file of venta;
    vDetalles = array[1..dimF] of archivoD;
    registrosDetalles = array[1..dimF] of venta;

    maxmin = record
        fecha: str20;
        ventas: integer;
    end;

procedure LeerMaestro (var archivo:archivoM; var e:emision);
begin
    if (not eof(archivo))
        then read(archivo, e)
        else e.fecha := stringAlto;
end;

procedure LeerDetalle (var archivo:archivoD; var v:venta);
begin
    if (not eof(archivo))
        then read(archivo, v)
        else v.fecha := stringAlto;
end;

procedure abrirArchivos (var maestro:archivoM; var detalles:vDetalles);
var
    i: integer;
begin
    reset(maestro);
    for i:=1 to dimF do
        reset(detalles[i]);
end;

procedure cerrarArchivos (var maestro:archivoM; var detalles:vDetalles);
var
    i: integer;
begin
    close(maestro);
    for i:=1 to dimF do
        close(detalles[i]);
end;

procedure minimo (var detalles:vDetalles; var rDetalles:registrosDetalles; var min:venta);
var
    i, pos:integer;
begin
    min.fecha := stringAlto;
    min.cod := valorAlto;

    for i := 1 to dimF do begin
        if ((rDetalles[i].fecha < min.fecha) and (rDetalles[i].cod < min.cod)) then begin
            min := rDetalles[i];
            pos := i;
        end;
    end;
    
    if (min.fecha <> stringAlto) then
        LeerDetalle(detalles[pos], rDetalles[pos]);
end;

procedure actualizarMaxMin (m:emision; var max, min:maxmin);
begin
    if (m.ventas > max.ventas) then begin
        max.fecha := m.fecha;
        max.ventas := m.ventas;
    end;
    if (m.ventas < min.ventas) then begin
        min.fecha := m.fecha;
        min.ventas := m.ventas;
    end;
end;

procedure actualizarMaestro (var maestro:archivoM; var detalles:vDetalles; var rDetalles:registrosDetalles);
var
    m: emision;
    min: venta;
    max, min2: maxmin;
begin
    abrirArchivos(maestro, detalles);
    minimo(detalles, rDetalles, min);
    max.ventas := -1;
    min.ventas := valorAlto;

    while (min.fecha <> stringAlto) do begin
        LeerMaestro(maestro, m);

        while (min.fecha <> m.fecha) do begin
            actualizarMaxMin(m, max, min2);
            LeerMaestro(maestro, m);
        end;

        while (min.fecha = m.fecha) do begin

            while (min.cod <> m.cod) do begin
                actualizarMaxMin(m, max, min2);
                LeerMaestro(maestro, m);
            end;

            while ((min.cod = m.cod) and (min.fecha = m.fecha)) do begin
                m.ventas := m.ventas + min.ventas;
                minimo(detalles, rDetalles, min);
            end;

            seek(maestro, filepos(maestro) -1);
            write(maestro, m);
        end;
    end;
    cerrarArchivos(maestro, detalles);
end;

var
    maestro: archivoM;
    detalles: vDetalles;
    rDetalles: registrosDetalles;
    i: integer;
    iStr: str20;

BEGIN
    assign(maestro, 'semanarios.dat');
    for i := 1 to dimF do begin
        Str(i, iStr);
        assign(detalles[i], 'semanariosDetalle(' + iStr + ').dat');
        reset(detalles[i]);
        LeerDetalle(detalles[i], rDetalles[i]);
        close(detalles[i]);
    end;
    actualizarMaestro(maestro, detalles, rDetalles);
END.
```
  
</details>

<br><hr id="Ejercicio_17"><br>
  
`17.` Una concesionaria de motos de la Ciudad de Chascomús, posee un archivo con información de las motos que posee a la venta. De cada moto se registra: código, nombre, descripción, modelo, marca y stock actual. Mensualmente se reciben 10 archivos detalles con información de las ventas de cada uno de los 10 empleados que trabajan. De cada archivo detalle se dispone de la siguiente información: código de moto, precio y fecha de la venta. Se debe realizar un proceso que actualice el stock del archivo maestro desde los archivos detalles. Además se debe informar cuál fue la moto más vendida.

```
NOTA: Todos los archivos están ordenados por código de la moto y el archivo
  maestro debe ser recorrido sólo una vez y en forma simultánea con los detalles.
```

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
program Practica2Ejercicio17;

const
    valorAlto = 9999;
    dimF = 10;

type
    str20 = string[20];
    motos = record
        cod: integer;
        nombre: str20;
        desc: str20;
        modelo: str20;
        stock: integer;
    end;

    venta = record
        cod: integer;
        precio: real;
        fecha: str20;
    end;

    archivoM = file of motos;
    archivoD = file of venta;
    vDetalles = array[1..dimF] of archivoD;
    registrosDetalles = array[1..dimF] of venta;


procedure LeerMaestro (var archivo:archivoM; var m:motos);
begin
    if (not eof(archivo))
        then read(archivo, m)
        else m.cod := valorAlto;
end;

procedure LeerDetalle (var archivo:archivoD; var v:venta);
begin
    if (not eof(archivo))
        then read(archivo, v)
        else v.cod := valorAlto;
end;

procedure abrirArchivos (var maestro:archivoM; var detalles:vDetalles);
var
    i: integer;
begin
    reset(maestro);
    for i:=1 to dimF do
        reset(detalles[i]);
end;

procedure cerrarArchivos (var maestro:archivoM; var detalles:vDetalles);
var
    i: integer;
begin
    close(maestro);
    for i:=1 to dimF do
        close(detalles[i]);
end;

procedure minimo (var detalles:vDetalles; var registros:registrosDetalles; var min:venta);
var
    i, pos: integer;
begin
    min.cod := valorAlto;

    for i:=1 to dimF do begin
        if (registros[i].cod < min.cod) then begin
            min := registros[i];
            pos := i;
        end;
    end;

    if (min.cod <> valorAlto) then
        LeerDetalle(detalles[pos], registros[pos]);
end;

procedure imprimirMasVendida (m:motos);
begin
    writeln('Moto mas vendida: ', m.nombre);
    writeln('Codigo: ', m.cod);
    writeln('Descripcion: ', m.desc);
    writeln('Modelo: ', m.modelo);
end;

procedure actualizarMaestro (var maestro:archivoM; var detalles:vDetalles; var registros:registrosDetalles);
var
    m, motoMax: motos;
    min: venta;
    actual, max: integer;
begin
    abrirArchivos(maestro, detalles);
    minimo(detalles, registros, min);
    max := 0;

    while (min.cod <> valorAlto) do begin
        LeerMaestro(maestro, m);

        while (min.cod <> m.cod) do
            LeerMaestro(maestro, m);

        actual := 0;
        while (min.cod = m.cod) do begin
            m.stock := m.stock - 1;
            actual := actual + 1;
            minimo(detalles, registros, min);
        end;

        seek(maestro, filepos(maestro)-1);
        write(maestro, m);
        if (actual > max) then
            motoMax := m;
    end;
    cerrarArchivos(maestro, detalles);

    imprimirMasVendida(motoMax);
end;

var
    maestro: archivoM;
    detalles: vDetalles;
    registros: registrosDetalles;
    i: integer;
    iStr: str20;

BEGIN
    assign(maestro, 'motos.dat');
    for i:=1 to dimF do begin
        Str(i, iStr);
        assign(detalles[i], 'venta(' + iStr + ').dat');
        reset(detalles[i]);
        LeerDetalle(detalles[i], registros[i]);
        close(detalles[i]);
    end;
    actualizarMaestro(maestro, detalles, registros);
END.
```
  
</details>

<br><hr id="Ejercicio_18"><br>
  
`18 .` Se cuenta con un archivo con información de los casos de COVID-19 registrados en los diferentes hospitales de la Provincia de Buenos Aires cada día. Dicho archivo contiene: cod_localidad, nombre_localidad, cod_municipio, nombre_minucipio, cod_hospital, nombre_hospital, fecha y cantidad de casos positivos detectados.

El archivo está ordenado por localidad, luego por municipio y luego por hospital.
‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ `a.` Escriba la definición de las estructuras de datos necesarias y un procedimiento que haga un listado con el siguiente formato:

```
Nombre Localidad 1
  Nombre Municipio 1
    Nombre Hospital 1..........Cantidad de casos Hospital 1
    .................
    Nombre Hospital N..........Cantidad de casos Hospital N
  Cantidad de casos Municipio 1
  ..................................................
  Nombre Municipio N
    Nombre Hospital 1..........Cantidad de casos Hospital 1
    ..................................................
    Nombre Hospital N..........Cantidad de casos Hospital N
  Cantidad de casos Municipio N
Cantidad de casos Localidad 1

..................................................

Nombre Localidad N
  Nombre Municipio 1
    Nombre Hospital 1..........Cantidad de casos Hospital 1
    .................
    Nombre Hospital N..........Cantidad de casos Hospital N
  Cantidad de casos Municipio 1
  ..................................................
  Nombre Municipio N
    Nombre Hospital 1..........Cantidad de casos Hospital 1
    ..................................................
    Nombre Hospital N..........Cantidad de casos Hospital N
  Cantidad de casos Municipio N
Cantidad de casos Localidad N

Cantidad de casos Totales en la Provincia
```

```b.``` Exportar a un archivo de texto la siguiente información nombre_localidad, nombre_municipio y cantidad de casos de municipio, para aquellos municipios cuya cantidad de casos supere los 1500. El formato del archivo de texto deberá ser el adecuado para recuperar la información con la menor cantidad de lecturas posibles.

```
NOTA: El archivo debe recorrerse solo una vez.
```
  
<details>

<summary> ▶️ </summary>
<br>
  
```Pas
program Practica2Ejercicio18;

const
    valorAlto = 9999;
    
type
    str20 = string[20];
    casos = record
        cod_localidad: integer;
        nombre_localidad: str20;
        cod_municipio: integer;
        nombre_municipio: str20;
        cod_hospital: integer;
        nombre_hospital: str20;
        fecha: str20;
        casosPositivos: integer;
    end;

    archivoM = file of casos;

procedure Leer (var arch:archivoM; var c:casos);
begin
    if (not eof(arch))
        then read(arch, c)
        else c.cod_localidad := valorAlto;
end;

procedure Listar (var archivo:archivoM);
var
    c, actual: casos;
    carga: text;
    cantCasosMunicipio, cantCasosLocalidad, cantCasosProvincia: integer;
begin
    reset(archivo);
    assign(carga, 'municipios+1500casos.txt');
    rewrite(carga);
    Leer(archivo, c);
    cantCasosProvincia := 0;

    while (c.cod_localidad <> valorAlto) do begin
        writeln(c.nombre_localidad,': ', c.cod_localidad);
        actual := c;
        cantCasosLocalidad := 0;

        while (c.cod_localidad = actual.cod_localidad) do begin
            writeln('   ', c.nombre_municipio,': ', c.cod_municipio);
            actual := c;
            cantCasosMunicipio := 0;

            while ((c.cod_municipio = actual.cod_municipio) and (c.cod_localidad = actual.cod_localidad)) do begin
                writeln('       ', c.nombre_hospital, ': ', c.cod_hospital, '..........Cantidad de casos: ', c.casosPositivos);
                cantCasosMunicipio := cantCasosMunicipio + c.casosPositivos;
                Leer(archivo, c);
            end;

            if (cantCasosMunicipio > 1500) then
                writeln(carga, c.nombre_localidad, c.nombre_municipio, cantCasosMunicipio);

            writeln('    Cantidad de casos Municipio ', actual.cod_municipio, ': ', cantCasosMunicipio);
            cantCasosLocalidad := cantCasosLocalidad + cantCasosMunicipio;
            writeln('...................................................');
        end;

        writeln('Cantidad de casos Localidad ', actual.cod_localidad, ': ', cantCasosLocalidad);
        cantCasosProvincia := cantCasosProvincia + cantCasosLocalidad;
        writeln('...................................................');
    end;

    writeln();
    writeln('Cantidad de casos Totales en la Provincia ', cantCasosProvincia);   
    close(archivo);
    close(carga);
end;

var
    archivo: archivoM;

BEGIN
    assign(archivo, 'casosCOVID-19.dat');
    Listar(archivo);
END.
```
  
</details>
