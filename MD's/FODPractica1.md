<h1 align="center">Practica 1</h1>

<div align = "center"  id="Ejercicio_1"> 
  
<h2> Indice: </h2>

| [1](#Ejercicio_1) | [2](#Ejercicio_2) | [3](#Ejercicio_3) | [4](#Ejercicio_4) | [5](#Ejercicio_5) | [6](#Ejercicio_6) | [7](#Ejercicio_7) |
===

</div>

```1.``` Realizar un algoritmo que cree un archivo de números enteros no ordenados y permita incorporar datos al archivo. Los números son ingresados desde teclado. El nombre del archivo debe ser proporcionado por el usuario desde teclado. La carga finaliza cuando se ingrese el número 30000, que no debe incorporarse al archivo.

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
program Practica1Ejercicio1;

type
    archivo = file of integer;
    cadena20 = string[20];

procedure CrearArchivo(var arch_logico:archivo; var arch_fisico:cadena20);
var
    num:integer;
begin
    writeln('Ingrese el nombre del archivo');
    readln(arch_fisico);
    assign(arch_logico, arch_fisico);
    rewrite(arch_logico);
	
    write('Ingrese un numero: ');
    readln(num);
    while (num <> 30000) do begin
        write(arch_logico, num);
        write('Ingrese un numero: ');
        readln(num);
    end;
    close(arch_logico);
end;

var
    arch_logico : archivo;
    arch_fisico : cadena20;

BEGIN
    CrearArchivo(arch_logico, arch_fisico);
END.
```
  
</details>

<hr id="Ejercicio_2"><br>

```2.``` Realizar un algoritmo, que utilizando el archivo de números enteros no ordenados creados en el ejercicio 1, informe por pantalla cantidad de números menores a 1500 y el promedio de los números ingresados. El nombre del archivo a procesar debe ser proporcionado por el usuario una única vez. Además, el algoritmo deberá listar el contenido del archivo en pantalla.

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
program Practica1Ejercicio2;

type
    archivo = file of integer;
    cadena20 = string[20];

procedure Informar (var arch_logico:archivo);
var
    numActual:integer;
    cantMenor:integer;
    cantTotal:integer;
    cantNums:integer;
    promedio:real;
begin
    cantNums:=0;
    cantMenor:=0;
    cantTotal:=0;
    promedio:=0;
    reset(arch_logico);
    while (not eof(arch_logico)) do begin
        cantNums := cantNums + 1;
        read(arch_logico, numActual);
        if (numActual < 1500) then begin
            cantTotal := cantTotal + numActual;
            cantMenor := cantMenor + 1;
        end;
    end;
    close(arch_logico);
    promedio:=cantTotal/cantNums;
    writeln('La cantidad de numeros menores a 1500 son ', cantMenor);
    writeln('El promedio de los numeros es de ', promedio:2:2);
end;

var
    arch_logico:archivo;
    arch_fisico:cadena20;
	
BEGIN
    writeln('Ingrese el nombre del archivo a imprimir: ');
    readln(arch_fisico);
    assign(arch_logico, arch_fisico);
    Informar(arch_logico);
END.
```
  
</details>

<hr id="Ejercicio_3"><br>

```3.``` Realizar un programa que presente un menú con opciones para:

- ```a.``` Crear un archivo de registros no ordenados de empleados y completarlo con datos ingresados desde teclado. De cada empleado se registra: número de empleado, apellido, nombre, edad y DNI. Algunos empleados se ingresan con DNI 00. La carga finaliza cuando se ingresa el String ‘fin’ como apellido.
- ```b.``` Abrir el archivo anteriormente generado y

‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ```i.``` Listar en pantalla los datos de empleados que tengan un nombre o apellido determinado.

‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ```ii.``` Listar en pantalla los empleados de a uno por línea.

‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ```iii.``` Listar en pantalla empleados mayores de 70 años, próximos a jubilarse.

***NOTA***: El nombre del archivo a crear o utilizar debe ser proporcionado por el usuario.

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
program Practica1Ejercicio3;

type
    cad20=string[20];
    cadDNI=string[8];
    empleado = record
        nombre:cad20;
        apellido:cad20;
        edad:integer;
        nro:integer;
        DNI:cadDNI;
    end;
    archivo = file of empleado;

procedure LeerEmpleado(var e:empleado);
begin
    write('Ingrese el apellido: ');
    readln(e.apellido);
    if (e.apellido <> 'fin') then begin
        write('Ingrese el nombre: ');
        readln(e.nombre);
        write('Ingrese la edad: ');
        readln(e.edad);
        write('Ingrese el numero de empleado: ');
        readln(e.nro);
        write('Ingrese el DNI: ');
        readln(e.DNI);
    end;
end;

procedure crearArchivo(var archLogico:archivo; var archFisico:cad20);
var
    e:empleado;
begin
    write('Ingrese el nombre del archivo a crear: ');
    readln(archFisico);
    assign(archLogico, archFisico);
    rewrite(archLogico);
    LeerEmpleado(e);
    while (e.apellido <> 'fin') do begin
        write(archLogico, e);
        LeerEmpleado(e);
    end;
    close(archLogico);
end;

procedure MostrarPersona(e:empleado);
begin
    WriteLn('Nro Empleado: ',e.nro);
    WriteLn('Apellido: ',e.apellido);
    WriteLn('Nombre: ',e.nombre);
    WriteLn('Dni: ',e.dni);
    WriteLn('Edad: ',e.edad);
end;

procedure Incisoi(var archLogico:archivo);
var
    e:empleado;
    nombre:cad20;
begin
    write('Ingrese un nombre a buscar: ');
    readln(nombre);
    reset(archLogico);
    while (not eof(archLogico)) do begin
        read(archLogico, e);
        if ((e.nombre = nombre) or (e.apellido = nombre)) then
            MostrarPersona(e);
    end;
    close(archLogico);
end;

procedure Incisoii(var archLogico:archivo);
var
    e:empleado;
begin
    reset(archLogico);
    while (eof(archLogico)) do begin
        read(archLogico,e);
        MostrarPersona(e);
        writeln('____________________');
    end;
    close(archLogico);
end;

procedure Incisoiii(var archLogico:archivo);
var
    e:empleado;
begin
    reset(archLogico);
    while (not eof(archLogico)) do begin
        read(archLogico, e);
        if (e.edad > 70) then begin 
            MostrarPersona(e);
            writeln('____________________');
        end;
    end;
    close(archLogico);
end;

procedure Menu ();
var
    opcion:integer;
    archFisico:cad20;
    archLogico:archivo;
begin
    opcion:=0;
    while (opcion <> 5) do begin
        writeln('_______________________');
        writeln('1 | Crear un Archivo con empleados(Siempre lo primero)');
        writeln('2 | Datos de Empleados con un apellido predeterminado');
        writeln('3 | Mostrar todos la Empleados');
        writeln('4 | Mostrar las Empleados mayores de 70');
        writeln('5 | Cerrar Menu');
        write('Opcion: ');
        readln(opcion);
        writeln('_______________________');
        case opcion of
            1:CrearArchivo(archLogico,archFisico);
            2:Incisoi(archLogico);
            3:Incisoii(archLogico);
            4:Incisoiii(archLogico);
            5:writeln('Archivo cerrado');
            else writeln('Numero Invalido');
        end;
    end;
end;

BEGIN
    Menu();	
END.
```
  
</details>

<hr id="Ejercicio_4"><br>

```4.``` Agregar al menú del programa del ejercicio 3, opciones para:

‎ ‎ ‎ ‎ ‎ ‎ ‎```a.``` Añadir uno o más empleados al final del archivo con sus datos ingresados por teclado. Tener en cuenta que no se debe agregar al archivo un empleado con un número de empleado ya registrado (control de unicidad).

‎ ‎ ‎ ‎ ‎ ‎ ‎```b.``` Modificar edad a uno o más empleados.

‎ ‎ ‎ ‎ ‎ ‎ ‎```c.``` Exportar el contenido del archivo a un archivo de texto llamado “todos_empleados.txt”.

‎ ‎ ‎ ‎ ‎ ‎ ‎```d.``` Exportar a un archivo de texto llamado: “faltaDNIEmpleado.txt”, los empleados que no tengan cargado el DNI (DNI en 00).

***NOTA***: Las búsquedas deben realizarse por número de empleado

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
program Practica1Ejercicio4;

type
    cad20=string[20];
    cadDNI=string[8];
    empleado = record
        nombre:cad20;
        apellido:cad20;
        edad:integer;
        nro:integer;
        DNI:cadDNI;
    end;
    archivo = file of empleado;

procedure LeerEmpleado(var e:empleado);
begin
    write('Ingrese el apellido: ');
    readln(e.apellido);
    if (e.apellido <> 'fin') then begin
        write('Ingrese el nombre: ');
        readln(e.nombre);
        write('Ingrese la edad: ');
        readln(e.edad);
        write('Ingrese el numero de empleado: ');
        readln(e.nro);
        write('Ingrese el DNI: ');
        readln(e.DNI);
    end;
end;

procedure crearArchivo(var archLogico:archivo; var archFisico:cad20);
var
    e:empleado;
begin
    write('Ingrese el nombre del archivo a crear: ');
    readln(archFisico);
    assign(archLogico, archFisico);
    rewrite(archLogico);
    LeerEmpleado(e);
    while (e.apellido <> 'fin') do begin
        write(archLogico, e);
        LeerEmpleado(e);
    end;
    close(archLogico);
end;

procedure MostrarPersona(e:empleado);
begin
    WriteLn('Nro Empleado: ',e.nro);
    WriteLn('Apellido: ',e.apellido);
    WriteLn('Nombre: ',e.nombre);
    WriteLn('Dni: ',e.dni);
    WriteLn('Edad: ',e.edad);
end;

procedure Incisoi(var archLogico:archivo);
var
    e:empleado;
    nombre:cad20;
begin
    write('Ingrese un nombre a buscar: ');
    readln(nombre);
    reset(archLogico);
    while (not eof(archLogico)) do begin
        read(archLogico, e);
        if ((e.nombre = nombre) or (e.apellido = nombre)) then
            MostrarPersona(e);
    end;
    close(archLogico);
end;

procedure Incisoii(var archLogico:archivo);
var
    e:empleado;
begin
    reset(archLogico);
    while (eof(archLogico)) do begin
        read(archLogico,e);
        MostrarPersona(e);
        writeln('____________________');
    end;
    close(archLogico);
end;

procedure Incisoiii(var archLogico:archivo);
var
    e:empleado;
begin
    reset(archLogico);
    while (not eof(archLogico)) do begin
        read(archLogico, e);
        if (e.edad > 70) then begin 
            MostrarPersona(e);
            writeln('____________________');
        end;
    end;
    close(archLogico);
end;

procedure IncisoA(var archLogico:archivo);
var
    e, aux:empleado;
    opcion:string;
    ok:boolean;
begin
    reset(archLogico);
    repeat
        ok:=true;
        LeerEmpleado(e);
        while ((not eof(archLogico)) and (ok)) do begin
            read(archLogico,aux);
            if (e.nro = aux.nro) then 
                ok:=false;
        end;
        if (not ok) then begin
            write(archLogico,e);
            writeln('Empleado aniadido');
        end else
            writeln('Empleado ya existente');
        write('Desea agregar otro empleado? ');
        readln(opcion);
    until opcion = 'No';
    close(archLogico);
end;

procedure IncisoB(var archLogico:archivo);
var
    nro:integer;
    aux:empleado;
    opcion:string;
begin
    reset(archLogico);
    repeat
        writeln('Ingrese un Nro de empleado a modificar; ');
        read(nro);
        read(archLogico, aux);
        while ((not eof(archLogico)) and (aux.nro <> nro)) do begin
            read(archLogico, aux);
        end;
        write('Ingrese la nueva edad: ');
        readln(nro);
        aux.nro:=nro;
        write('Desea modificar otra edad? ');
        readln(opcion);
    until opcion = 'No';
    close(archLogico);
end;

procedure IncisoC(var archLogico:archivo);
var
    carga:text;
    e:empleado;
begin
    assign(carga, 'Empleados.txt');
    reset(archLogico);
    rewrite(carga);
    while (not eof(archLogico)) do begin
        read(archLogico, e);
            with e do
                writeln(carga, ' ', nro, ' ', apellido, ' ', nombre, ' ', edad, ' ', DNI);
    end;
    writeln('Archivo exportado');
    close(archLogico);
    close(carga);
end;

procedure IncisoD (var archLogico:archivo);
var
    carga:text;
    e:empleado;
begin
    assign(carga, 'faltaDNIEmpleado.txt');
    reset(archLogico);
    rewrite(carga);
    while (not eof(archLogico)) do begin
        read(archLogico, e);
        if (e.DNI = '00') then begin
            with e do
                writeln(carga, ' ', nro, ' ', apellido, ' ', nombre, ' ', edad, ' ', DNI);
        end;
    end;
    writeln('Archivo exportado');
    close(archLogico);
    close(carga);
end;

procedure Menu ();
var
    opcion:integer;
    archFisico:cad20;
    archLogico:archivo;
begin
    opcion:=0;
    while (opcion <> 9) do begin
        writeln('_______________________');
        writeln('1 | Crear un Archivo con empleados');
        writeln('2 | Datos de Empleados con un apellido predeterminado');
        writeln('3 | Mostrar todos la Empleados');
        writeln('4 | Mostrar las Empleados mayores de 70');
        writeln('5 | Aniadir empleado');
        writeln('6 | Modificar edades');
        writeln('7 | Exportar contenido a un .txt');
        writeln('8 | Exportar empleados sin DNI a un .txt');
        writeln('9 | Cerrar Menu');
        write('Opcion: ');
        readln(opcion);
        writeln('_______________________');
        case opcion of
            1:CrearArchivo(archLogico,archFisico);
            2:Incisoi(archLogico);
            3:Incisoii(archLogico);
            4:Incisoiii(archLogico);
            5:IncisoA(archLogico);
            6:IncisoB(archLogico);
            7:IncisoC(archLogico);
            8:IncisoD(archLogico);
            9:writeln('Archivo cerrado');
            else writeln('Numero Invalido');
        end;
    end;
end;

BEGIN
    Menu();	
END.
```
  
</details>

<hr id="Ejercicio_5"><br>

```5.``` Realizar un programa para una tienda de celulares, que presente un menú con opciones para:

‎ ‎ ‎ ‎ ‎ ‎ ‎```a.``` Crear un archivo de registros no ordenados de celulares y cargarlo con datos ingresados desde un archivo de texto denominado “celulares.txt”. Los registros correspondientes a los celulares, deben contener: código de celular, el nombre, descripción, marca, precio, stock mínimo y el stock disponible.

‎ ‎ ‎ ‎ ‎ ‎ ‎```b.``` Listar en pantalla los datos de aquellos celulares que tengan un stock menor al stock mínimo.

‎ ‎ ‎ ‎ ‎ ‎ ‎```c.``` Listar en pantalla los celulares del archivo cuya descripción contenga una cadena de caracteres proporcionada por el usuario.

‎ ‎ ‎ ‎ ‎ ‎ ‎```d.``` Exportar el archivo creado en el inciso a) a un archivo de texto denominado “celulares.txt” con todos los celulares del mismo. El archivo de texto generado podría ser utilizado en un futuro como archivo de carga (ver inciso a), por lo que debería respetar el formato dado para este tipo de archivos en la NOTA 2.

***NOTA 1***: El nombre del archivo binario de celulares debe ser proporcionado por el usuario.

***NOTA 2***: El archivo de carga debe editarse de manera que cada celular se especifique en tres líneas consecutivas: en la primera se especifica: código de celular, el precio y marca, en la segunda el stock disponible, stock mínimo y la descripción y en la tercera nombre en ese orden. Cada celular se carga leyendo tres líneas del archivo “celulares.txt”

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
program Practica1Ejercicio5;

type
    cad20=string[20];
    celulares=record
        cod:integer;
        nombre:cad20;
        desc:cad20;
        marca:cad20;
        precio:real;
        stockMin:integer;
        stockDis:integer;
    end;
    archivo = file of celulares;

procedure CrearArchivo(var archLogico:archivo; var archFisico:cad20);
var
    carga: text;
    c:celulares;
begin
    write('Ingrese un nombre de archivo: ');
    readln(archFisico);
    assign(archLogico, archFisico);
    assign(carga, 'celulares.txt');
    rewrite(archLogico);
    reset(carga);
    while (not eof(carga)) do begin
        with c do readln(carga, cod, precio, marca);
        with c do readln(carga, stockDis, stockMin,desc);
        with c do readln(carga, nombre);
        write(archLogico, c)
    end;
    writeln('Archivo cargado');
    close(archLogico);
    close(carga);
end;

procedure ListarStock(var archLogico:archivo);
var
    c:celulares;
begin
    reset(archLogico);
    while (not eof(archLogico)) do begin
        read(archLogico,c);
        if (c.stockDis < c.stockMin) then begin
            with c do begin
                WriteLn('Codigo: ',cod);
                writeln('Nombre:', nombre);
                writeln('Descripcion:', desc);
                WriteLn('Marca: ',marca);
                writeln('Precio:', precio:2:2);
                WriteLn('Stock Minimo:',stockMin);
                writeln('Stock:', stockDis);
                WriteLn('_________');
            end;
        end;
    end;
    close(archLogico);
end;

procedure ListarDesc(var archLogico:archivo);
var
    c:celulares;
    UserDesc:cad20;
begin
    reset(archLogico);
    write('Ingrese una descripcion a buscar: ');
    readln(UserDesc);
    while (not eof(archLogico)) do begin
        read(archLogico,c);
        UserDesc:=Concat(' ',UserDesc); 
        if (UserDesc = c.desc) then begin
            with c do begin
                WriteLn('Codigo: ',cod);
                writeln('Nombre: ', nombre);
                writeln('Descripcion: ', desc);
                WriteLn('Marca: ',marca);
                writeln('Precio: ', precio:2:2);
                WriteLn('Stock Minimo: ',stockMin);
                writeln('Stock: ', stockDis);
                WriteLn('_________');
            end;
        end;
    end;
    close(archLogico);
end;

procedure ExportarArchivo(var archLogico:archivo);
var
    c:celulares;
    carga:text;
begin
    reset(archLogico);
    assign(carga,'celulares.txt');
    rewrite(carga);
    while (not eof(archLogico)) do begin
        read(archLogico,c);
            with c do begin
                writeln(carga, cod, precio, marca);
                writeln(carga, stockDis, stockMin,desc);
                writeln(carga, nombre);
            end;
    end;
end;

procedure Menu();
var
    archLogico:archivo;
    archFisico:cad20;
    opcion:integer;
begin
    opcion:=0;
    while (opcion <> 5) do begin
        writeln('1 | Crear archivo');
        writeln('2 | Listar celulares con poco stock');
        writeln('3 | Listar celulares por descripcion');
        writeln('4 | Exportar a .txt');
        writeln('5 | Cerrar Archivo');
        write('Opcion: ');
        readln(opcion);
        writeln('_______________________');
        case opcion of
            1:CrearArchivo(archLogico, archFisico);
            2:ListarStock(archLogico);
            3:ListarDesc(archLogico);
            4:ExportarArchivo(archLogico);
            5:Writeln('Archivo cerrado');
        else writeln('Opcion invalida');
        end;
    end;
end;

BEGIN
    Menu();
END.
```
  
</details>

<hr id="Ejercicio_6"><br>

```6.```  Agregar al menú del programa del ejercicio 5, opciones para:

‎ ‎ ‎ ‎ ‎ ‎ ‎```a.``` Añadir uno o más celulares al final del archivo con sus datos ingresados por teclado.

‎ ‎ ‎ ‎ ‎ ‎ ‎```b.``` Modificar el stock de un celular dado.

‎ ‎ ‎ ‎ ‎ ‎ ‎```c.``` Exportar el contenido del archivo binario a un archivo de texto denominado: ”SinStock.txt”, con aquellos celulares que tengan stock 0.

***NOTA***: Las búsquedas deben realizarse por nombre de celular.

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
program Practica1Ejercicio6;

type
    cad20=string[20];
    celular=record
        cod:integer;
        nombre:cad20;
        desc:cad20;
        marca:cad20;
        precio:real;
        stockMin:integer;
        stockDis:integer;
    end;
    archivo = file of celular;

procedure CrearArchivo(var archLogico:archivo; var archFisico:cad20);
var
    carga: text;
    c:celular;
begin
    write('Ingrese un nombre de archivo: ');
    readln(archFisico);
    assign(archLogico, archFisico);
    assign(carga, 'celulares.txt');
    rewrite(archLogico);
    reset(carga);
    while (not eof(carga)) do begin
        with c do readln(carga, cod, precio, marca);
        with c do readln(carga, stockDis, stockMin,desc);
        with c do readln(carga, nombre);
        write(archLogico, c)
    end;
    writeln('Archivo cargado');
    close(archLogico);
    close(carga);
end;

procedure ListarStock(var archLogico:archivo);
var
    c:celular;
begin
    reset(archLogico);
    while (not eof(archLogico)) do begin
        read(archLogico,c);
        if (c.stockDis < c.stockMin) then begin
            with c do begin
                WriteLn('Codigo: ',cod);
                writeln('Nombre: ', nombre);
                writeln('Descripcion:', desc);
                WriteLn('Marca:',marca);
                writeln('Precio: ', precio:2:2);
                WriteLn('Stock Minimo: ',stockMin);
                writeln('Stock: ', stockDis);
                WriteLn('_________');
            end;
        end;
    end;
    close(archLogico);
end;

procedure ListarDesc(var archLogico:archivo);
var
    c:celular;
    UserDesc:cad20;
begin
    reset(archLogico);
    write('Ingrese una descripcion a buscar: ');
    readln(UserDesc);
    UserDesc:=Concat(' ',UserDesc); 
    while (not eof(archLogico)) do begin
        read(archLogico,c);
        if (UserDesc = c.desc) then begin
            with c do begin
                WriteLn('Codigo: ',cod);
                writeln('Nombre: ', nombre);
                writeln('Descripcion:', desc);
                WriteLn('Marca:',marca);
                writeln('Precio: ', precio:2:2);
                WriteLn('Stock Minimo: ',stockMin);
                writeln('Stock: ', stockDis);
                WriteLn('_________');
            end;
        end;
    end;
    close(archLogico);
end;

procedure ExportarArchivo(var archLogico:archivo);
var
    c:celular;
    carga:text;
begin
    reset(archLogico);
    assign(carga,'celulares2.txt');
    rewrite(carga);
    while (not eof(archLogico)) do begin
        read(archLogico,c);
            with c do begin
                writeln(carga, 'Codigo:.......', cod, '   Precio:.......', precio:2:2, '  Marca:.......', Copy(marca, 2, Length(marca)-1){Elimina el primer caracter de c.marca});
                writeln(carga, 'Stock actual:.', stockDis, '   Stock minimo:.', stockMin,'     Descripcion:.', Copy(desc, 2, Length(desc)-1){Elimina el primer caracter de c.desc});
                writeln(carga, 'Nombre:.......', nombre);
                writeln(carga, '');
            end;
    end;
    close(archLogico);
    close(carga);
end;

procedure LeerCelular(var c:celular);
begin
    write('Ingrese el codigo: ');
    readln(c.cod);
    write('Ingrese el nombre: ');
    readln(c.nombre);
    write('Ingrese la descripcion: ');
    readln(c.desc);
    c.desc := Concat(' ',c.desc);
    write('Ingrese la marca: ');
    readln(c.marca);
    c.marca := Concat(' ',c.marca);
    write('Ingrese el precio: ');
    readln(c.precio);
    write('Ingrese el stock minimo: ');
    readln(c.stockMin);
    write('Ingrese el stock disponible: ');
    readln(c.stockDis);
end;

procedure AgregarCelular(var archLogico:archivo);
var
    c:celular;
    opcion:cad20;
begin
    reset(archLogico);
    seek(archLogico,fileSize(archLogico));
    repeat
        LeerCelular(c);
        write(archLogico,c);
        write('Desea agregar otro celular? ');
        readln(opcion);
    until opcion = 'No';
    close(archLogico);
end;

procedure ModificarStock(var archLogico:archivo);
var
    nombre:cad20;
    c:celular;
begin
    reset(archLogico);
    read(archLogico,c);
    write('Ingrese un nombre a buscar: ');
    readln(nombre);
    while ((not eof(archLogico)) and (c.nombre <> nombre)) do begin
        read(archLogico,c);
    end;
    write('Ingrese el nuevo stock: ');
    readln(c.stockDis);
    seek(archLogico,filePos(archLogico)-1);
    write(archLogico,c);
    close(archLogico);
end;

procedure ExportarSinStock(var archLogico:archivo);
var
    c:celular;
    carga:text;
begin
    reset(archLogico);
    assign(carga,'SinStock.txt');
    rewrite(carga);
    while (not eof(archLogico)) do begin
        read(archLogico,c);
        if (c.stockDis = 0) then begin
            with c do begin
                writeln(carga, 'Codigo:.......', cod, '   Precio:.......', precio:2:2, '  Marca:.......', marca);
                writeln(carga, 'Stock actual:.', stockDis, '   Stock minimo:.', stockMin,'     Descripcion:.',desc);
                writeln(carga, 'Nombre:.......', nombre);
                writeln(carga, '');
            end;
        end;
    end;
    close(carga);
    close(archLogico);
end;

procedure Menu();
var
    archLogico:archivo;
    archFisico:cad20;
    opcion:integer;
begin
    opcion:=0;
    while (opcion <> 8) do begin
        writeln('_______________________');
        writeln('1 | Crear archivo');
        writeln('2 | Listar celulares con poco stock');
        writeln('3 | Listar celulares por descripcion');
        writeln('4 | Exportar a .txt');
        writeln('5 | Aniadir celular');
        writeln('6 | Modificar stock');
        writeln('7 | Exportar a SinStock.txt');
        writeln('8 | Cerrar Archivo');
        write('Opcion: ');
        readln(opcion);
        writeln('_______________________');
        case opcion of
            1:CrearArchivo(archLogico, archFisico);
            2:ListarStock(archLogico);
            3:ListarDesc(archLogico);
            4:ExportarArchivo(archLogico);
            5:AgregarCelular(archlogico);
            6:ModificarStock(archlogico);
            7:ExportarSinStock(archlogico);
            8:Writeln('Archivo cerrado');
        else
        end;
    end;
end;

BEGIN
    Menu();
END.
```
  
</details>

<hr id="Ejercicio_7"><br>

```7.``` Realizar un programa que permita:

‎ ‎ ‎ ‎ ‎ ‎ ‎```a.``` Crear un archivo binario a partir de la información almacenada en un archivo de texto. El nombre del archivo de texto es: “novelas.txt”

‎ ‎ ‎ ‎ ‎ ‎ ‎```b.``` Abrir el archivo binario y permitir la actualización del mismo. Se debe poder agregar una novela y modificar una existente. Las búsquedas se realizan por código de novela.

***NOTA***: La información en el archivo de texto consiste en: código de novela, nombre, género y precio de diferentes novelas argentinas. De cada novela se almacena la información en dos líneas en el archivo de texto. La primera línea contendrá la siguiente información: código novela, precio, y género, y la segunda línea almacenará el nombre de la novela.

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
program Practica1Ejercicio7;

type
    cad20=string[20];
    novela=record
        cod:integer;
        nombre:cad20;
        genero:cad20;
        precio:real;
    end;
    archivo=file of novela;

procedure CrearArchivo(var archLogico:archivo; var archFisico:cad20);
var
    carga:text;
    n:novela;
begin
        
    write('Ingrese el nombre del archivo: ');
    readln(archFisico);
    assign(archLogico, archFisico);
    rewrite(archLogico);
    assign(carga,'novelas.txt');
    reset(carga);
    while (not eof(carga)) do begin
        with n do readln(carga, cod, precio, genero);
        with n do readln(carga, nombre);
        write(archLogico, n);
    end;
    writeln('Archivo cargado.');
    close(archLogico);
    close(carga);
end;

procedure LeerNovela(var n:novela);
begin
    with n do begin
        write('Ingrese el codigo: ');
        readln(cod);
        write('Ingrese el nombre: ');
        readln(nombre);
        write('Ingrese el genero: ');
        readln(genero);
        write('Ingrese el precio: ');
        readln(precio);
    end;
end;

procedure AgregarNovela(var archLogico:archivo);
var
    n:novela;
begin
    reset(archLogico);
    seek(archLogico,fileSize(archLogico));
    LeerNovela(n);
    write(archLogico,n);
    close(archLogico);
end;

procedure ModificarNovela(var archLogico:archivo);
var
    n:novela;
    cod:integer;
begin
    reset(archLogico);
    write('Ingrese el codigo de la novela a modificar: ');
    readln(cod);
    read(archLogico,n);
    while ((not eof(archLogico)) and (cod <> n.cod)) do begin
        read(archLogico,n);
    end;
    seek(archLogico,filePos(archLogico) - 1);
    write('Codigo antiguo: ', n.cod);
    write('Codigo nuevo: ');
    readln(n.cod);
    write('Precio antiguo: ', n.precio);
    write('Precio nuevo: ');
    readln(n.precio);
    write('Genero antiguo: ', n.genero);
    write('Genero nuevo: ');
    readln(n.genero);
    write('Nombre antiguo: ', n.nombre);
    write('Nombre nuevo: ');
    readln(n.nombre);
        
    write(archLogico, n);
    close(archLogico);
end;

var
    archLogico:archivo;
    archFisico:cad20;

BEGIN
    CrearArchivo(archLogico, archFisico);
    AgregarNovela(archLogico);
    ModificarNovela(archLogico);    
END.
```
  
</details>
