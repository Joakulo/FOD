<h1 align="center">Practica 3</h1>

<div align = "center"  id="Ejercicio_1"> 
  
<h2 align="center"> Indice: </h2>

| [1](#Ejercicio_1) | [2](#Ejercicio_2) | [3](#Ejercicio_3) | [4](#Ejercicio_4) | [5](#Ejercicio_5) | [6](#Ejercicio_6) | [7](#Ejercicio_7) | [8](#Ejercicio_8) |
===

</div>

<br>

`1.` Modificar el ejercicio 4 de la práctica 1 (programa de gestión de empleados), agregándole una opción para realizar bajas copiando el último registro del archivo en la posición del registro a borrar y luego truncando el archivo en la posición del último registro de forma tal de evitar duplicados.

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
program Practica3Ejercicio1;

const
    valorAlto = 9999;

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

procedure Leer (var archLogico:archivo; var e:empleado);
begin
    if (not eof(archLogico))
        then read(archLogico, e)
        else e.nro := valorAlto;
end;

procedure BajaFisica(var archLogico:archivo; archFisico:cad20);
var
    e, eUlt: empleado;
    nro: integer;
begin
    assign(archLogico, archFisico);
    reset(archLogico);
    Seek(archLogico, FileSize(archLogico) -1);
    Leer(archLogico, eUlt);
    Seek(archLogico, 0);
    Leer(archLogico, e);
    write('Ingrese el nro de un empleado a eliminar: ');
    readln(nro);
    while ((e.nro <> nro) and (e.nro <> valorAlto)) do
        Leer(archLogico, e);
    if (e.nro <> valorAlto) then begin
        Seek(archLogico, FilePos(archLogico)-1);
        write(archLogico, eUlt);
        Seek(archLogico, FileSize(archLogico) -1);
        Truncate(archLogico);
    end else
        writeln('Empleado no encontrado.');
end;

procedure Menu ();
var
    opcion:integer;
    archFisico:cad20;
    archLogico:archivo;
begin
    opcion:=-1;
    while (opcion <> 0) do begin
        writeln('_______________________');
        writeln('1 | Crear un Archivo con empleados');
        writeln('2 | Datos de Empleados con un apellido predeterminado');
        writeln('3 | Mostrar todos la Empleados');
        writeln('4 | Mostrar las Empleados mayores de 70');
        writeln('5 | Aniadir empleado');
        writeln('6 | Modificar edades');
        writeln('7 | Exportar contenido a un .txt');
        writeln('8 | Exportar empleados sin DNI a un .txt');
        writeln('9 | Eliminar un empleado');
        writeln('0 | Cerrar Menu');
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
            9:BajaFisica(archLogico, archFisico);
            0:writeln('Archivo cerrado');
            else writeln('Numero Invalido');
        end;
    end;
end;

BEGIN
    Menu(); 
END.
```
  
</details>

<br><hr id="Ejercicio_2"><br>

`2.`  Definir un programa que genere un archivo con registros de longitud fija conteniendo información de asistentes a un congreso a partir de la información obtenida por teclado. Se deberá almacenar la siguiente información: nro de asistente, apellido y nombre, email, teléfono y D.N.I. Implementar un procedimiento que, a partir del archivo de datos generado, elimine de forma lógica todos los asistentes con nro de asistente inferior a 1000.

Para ello se podrá utilizar algún carácter especial situándolo delante de algún campo String a su elección. Ejemplo: ‘@Saldaño’.

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
program Practica3Ejercicio2;

const
    valorAlto = 9999;
        
type
    str20 = string[20];
    str40 = string[40];
    asistente = record
        nro: integer;
        apellido: str20;
        nombre: str20;
        email: str40;
        telefono: str20;
        DNI: integer;
    end;

    archivo = file of asistente;

procedure Leer(var aLogico:archivo; var a:asistente);
begin
    if (not eof(aLogico))
        then read(aLogico, a)
        else a.nro := valorAlto;
end;

procedure LeerAsistente(var a:asistente);
begin
    write('Ingrese el Nro de asistente: ');
    readln(a.nro);
    if (a.nro <> valorAlto) then begin
        write('Ingrese el Apellido: ');
        readln(a.apellido);
        write('Ingrese el Nombre: ');
        readln(a.nombre);
        write('Ingrese el Email: ');
        readln(a.email);
        write('Ingrese el Telefono: ');
        readln(a.telefono);
        write('Ingrese el DNI: ');
        readln(a.DNI);
    end;
end;

procedure CrearArchivo(var aLogico:archivo; var aFisico:str20);
var
    a:asistente;
begin
    aFisico := 'asistentes.dat';
    assign(aLogico, aFisico);
    rewrite(aLogico);
    LeerAsistente(a);
    while (a.nro <> valorAlto) do begin
        write(aLogico, a);
        LeerAsistente(a);
    end;
    close(aLogico);
end;

procedure BajaLogica(var aLogico:archivo);
var
    a:asistente;
begin
    reset(aLogico);
    Leer(aLogico, a);
    while (not eof(aLogico)) do begin
        if (a.nro < 1000) then begin
            a.apellido := '@' + a.apellido;
            seek(aLogico, FilePos(aLogico)-1);
            write(aLogico, a);
        end;
        Leer(aLogico, a);
    end;
    close(aLogico);
end;

var
    aLogico: archivo;
    aFisico: str20;

BEGIN
    crearArchivo(aLogico, aFisico);
    BajaLogica(aLogico);
END.
```
  
</details>

<br><hr id="Ejercicio_3"><br>

`3.`  Realizar un programa que genere un archivo de novelas filmadas durante el presente año. De cada novela se registra: código, género, nombre, duración, director y precio. El programa debe presentar un menú con las siguientes opciones:

‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ `a.`  Crear el archivo y cargarlo a partir de datos ingresados por teclado. Se utiliza la técnica de lista invertida para recuperar espacio libre en el archivo. Para ello, durante la creación del archivo, en el primer registro del mismo se debe almacenar la cabecera de la lista. Es decir un registro ficticio, inicializando con el valor cero (0) el campo correspondiente al código de novela, el cual indica que no hay espacio libre dentro del archivo.

‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ `b.` Abrir el archivo existente y permitir su mantenimiento teniendo en cuenta el inciso a., se utiliza lista invertida para recuperación de espacio. En particular, para el campo de ´enlace´ de la lista, se debe especificar los números de registro referenciados con signo negativo, (utilice el código de novela como enlace). Una vez abierto el archivo, brindar operaciones para:

‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ `i.` Dar de alta una novela leyendo la información desde teclado. Para esta operación, en caso de ser posible, deberá recuperarse el espacio libre. Es decir, si en el campo correspondiente al código de novela del registro cabecera hay un valor negativo, por ejemplo -5, se debe leer el registro en la posición 5, copiarlo en la posición 0 (actualizar la lista de espacio libre) y grabar el nuevo registro en la posición 5. Con el valor 0 (cero) en el registro cabecera se indica que no hay espacio libre.

‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ `ii.`  Modificar los datos de una novela leyendo la información desde teclado. El código de novela no puede ser modificado.

‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ `iii.` Eliminar una novela cuyo código es ingresado por teclado. Por ejemplo, si se da de baja un registro en la posición 8, en el campo código de novela del registro cabecera deberá figurar -8, y en el registro en la posición 8 debe copiarse el antiguo registro cabecera.

‎ ‎ ‎ ‎ ‎ ‎ ‎ ‎ `c.`  Listar en un archivo de texto todas las novelas, incluyendo las borradas, que representan la lista de espacio libre. El archivo debe llamarse “novelas.txt”.
  
```
NOTA: Tanto en la creación como en la apertura el nombre del archivo debe ser
proporcionado por el usuario.
```

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
program Practica3Ejercicio3;

const
    valorAlto = 9999;
        
type
    str20 = string[20];
    novela = record
        codigo: integer;
        genero: str20;
        nombre: str20;
        duracion: double;
        director: str20;
        precio: double;
    end;
    maestro = file of novela;
        
procedure Leer(var archivo:maestro; var n:novela);
begin
    if (not eof(archivo))
        then read(archivo, n)
        else n.codigo := valorAlto;
end;

procedure LeerNovela(var n:novela);
begin
    write('Ingrese el codigo:');
    readln(n.codigo);
    if (n.codigo <> valorAlto) then begin
        write('Ingrese el genero:');
        readln(n.genero);
        write('Ingrese el nombre:');
        readln(n.nombre);
        write('Ingrese la duracion:');
        readln(n.duracion);
        write('Ingrese el director:');
        readln(n.director);
        write('Ingrese el precio:');
        readln(n.precio);
    end;
end;

procedure crearArchivo();
var
    aLogico:maestro;
    aFisico: str20;
    n: novela;
begin
    write('Ingrese el nombre y extension del archivo a crear: ');
    readln(aFisico);
    assign(aLogico, aFisico);
    rewrite(aLogico);
        
    n.codigo := 0;
    write(aLogico, n);
        
    LeerNovela(n);
    while (n.codigo) do begin
        write(aLogico, n);
        LeerNovela(n);
    end;
    close(aLogico);
end;

procedure agregarNovela(var archivo:maestro);
var
    n, act, ant:novela;
    posAnt: integer;
begin
    reset(archivo);
    LeerNovela(n);
    Leer(archivo, act);
        
    if (aux.codigo = 0) then begin
        seek(archivo, FileSize(archivo) -1);
        write(archivo,n);
    end else begin
        while (act.codigo <> 0) do begin        
        //Mientras que el codigo del registro actual no llegue a 0,
        //quiere decir que no encontre el ultimo espacio libre.
        
            ant := act;                         //Guardo el actual en una variable auxiliar,
            posAnt := FilePos(archivo) -1;      //guardo su posicion.
            seek(archivo, (act.codigo * (-1)));     //Me dirijo hacia el proximo espacio libre,
            Leer(archivo, act);                     //lo leo.
        end;
        seek(archivo, FilePos(archivo) -1);     //Cuando encontre el registro con codigo = 0,
        write(archivo, n);                      //escribo la nueva novela ahí.  
        
        ant.codigo := 0;            //Actualizo el anterior espacio libre, marcando que ahora es el ultimo,
        seek(archivo, posAnt);      //voy hacia su posicion,
        write(archivo, ant);        //lo escribo.
    end;
    close(archivo);
end;

procedure modificarNovela(var archivo:maestro);
var
    n, act: novela;
begin
    reset(archivo);
    write('Ingrese el codigo de la novela a modificar: ');
    readln(n.codigo);
        
    while ((n.codigo = valorAlto) or (n.codigo < 1)) do begin
        write('Codigo Invalido - Ingrese el codigo de la novela a modificar: ');
        readln(n.codigo);
    end;
        
    Leer(archivo, act);
    while ((not eof(archivo)) and (act.codigo <> n.codigo)) do
        Leer(archivo, act);
        
    if (act.codigo <> valorAlto) then begin
        write('Genero actualizado:');
        readln(n.genero);
        write('Nombre actualizado:');
        readln(n.nombre);
        write('Duracion actualizada:');
        readln(n.duracion);
        write('Director actualizado:');
        readln(n.director);
        write('Precio actualizado:');
        readln(n.precio);
        
        seek(archivo, FilePos(archivo) -1);
        write(archivo, n);
    end else
        writeln('Novela no encontrada.');
        
    close(archivo);
end;

procedure BajaLogica (var archivo:maestro);
var
    n, act: novela;
    posE, cod: integer;
begin
    reset(archivo);
    write('Ingrese el codigo de una novela a eliminar: ');
    readln(cod);
        
    while ((cod = valorAlto) or (cod < 1)) do begin
        write('Codigo invalido - Ingrese el codigo de una novela a eliminar: ');
        readln(cod);
    end;
        
    Leer(archivo, n);   //Guardo el primer registro.
    while ((not eof(archivo)) and (act.codigo <> cod)) do
        Leer(archivo, act);
        
    if (act.codigo <> valorAlto) then begin
        
        posE := FilePos(archivo) -1;
        seek(archivo, posE);    //Sobreescribo el eliminado con el registro de cabecera,
        write(archivo, n);      //que tiene la posicion del eliminado anteriormente (o el 0).
        
        seek(archivo, 0);
        n.codigo := posE;       //Actualizo la posicion del ultimo eliminado,
        write(archivo, n);      //lo escribo en la cabecera
        
    end else
        writeln('Novela no encontrada.');
    close(archivo);
end;

procedure MenuB();
var
    aLogico: maestro;
    aFisico: str20;
    opcion: integer;
begin
    write('Nombre del archivo: ');
    readln(aFisico);
    assign(aLogico, aFisico);
        
    opcion:=0;
    while (opcion <> 4) do begin
        writeln('_______________________');
        writeln('1 | Agregar una novela');
        writeln('2 | Modificar una novela');
        writeln('3 | Eliminar una novela');
        writeln('4 | Cerrar el archivo');
        write('Opcion: ');
        readln(opcion);
        writeln('_______________________');
        case opcion of
            1:agregarNovela(aLogico);
            2:modificarNovela(aLogico);
            3:BajaLogica(aLogico);
            4:writeln('Archivo cerrado');
            else writeln('Numero Invalido');
        end;
    end;
end;

procedure listarArchivo();
var
    aLogico: maestro;
    aFisico: str20;
    carga: text;
    n:novela;
begin
    write('Ingrese el nombre del archivo para pasar a .txt');
    readln(aFisico);
    assign(aLogico, aFisico);
    reset(aLogico);
    assign(carga, 'novelas.txt');
        
    Leer(aLogico, n);
    while (not eof(aLogico)) do begin
        writeln(carga, 'Codigo: ', n.codigo);
        writeln(carga, 'Genero: ', n.genero);
        writeln(carga, 'Nombre: ', n.nombre);
        writeln(carga, 'Duracion: ', n.duracion);
        writeln(carga, 'Director: ', n.director);
        writeln(carga, 'Precio: ', n.precio);
        writeln(carga, '');
        Leer(aLogico, n);
    end;
end;

procedure Menu();       //Dentro de cada proceso se elige que archivo usar
var                     //      => no hace falta que reciba ningun parametro.
    opcion: integer;
begin
    opcion := 0;
    while (opcion <> 4) do begin
        writeln('_______________________');
        writeln('1 | Crear archivo de novelas');
        writeln('2 | Agregar - Modificar - Eliminar una novela');
        writeln('3 | Listar novelas en un .txt');
        writeln('4 | Cerrar el archivo');
        write('Opcion: ');
        readln(opcion);
        writeln('_______________________');
        case opcion of
            1:crearArchivo();
            2:MenuB();
            3:listarArchivo();
            4:writeln('Archivo cerrado');
            else writeln('Numero Invalido');
        end;
    end;
end;

BEGIN
    Menu();
END.
```
  
</details>

<br><hr id="Ejercicio_4"><br>

`4.`  Dada la siguiente estructura:

```Pas
type
  reg_flor = record
    nombre: String[45];
    codigo:integer;
  tArchFlores = file of reg_flor;
```

Las bajas se realizan apilando registros borrados y las altas reutilizando registros borrados. El registro 0 se usa como cabecera de la pila de registros borrados: el número 0 en el campo código implica que no hay registros borrados y -N indica que el próximo registro a reutilizar es el N, siendo éste un número relativo de registro válido.
  
```a.``` Implemente el siguiente módulo:

```Pas
{Abre el archivo y agrega una flor, recibida como parámetro
manteniendo la política descripta anteriormente}

procedure agregarFlor (var a: tArchFlores ; nombre: string; codigo:integer);
```

```b.``` Liste el contenido del archivo omitiendo las flores eliminadas. Modifique lo que considere necesario para obtener el listado

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
```
  
</details>

<br><hr id="Ejercicio_5"><br>

`5.`  Dada la estructura planteada en el ejercicio anterior, implemente el siguiente módulo:

```Pas
{Abre el archivo y elimina la flor recibida como parámetro manteniendo
la política descripta anteriormente}

procedure eliminarFlor (var a: tArchFlores; flor:reg_flor);
```
  
<details>

<summary> ▶️ </summary>
<br>
  
```Pas
```
  
</details>

<br><hr id="Ejercicio_6"><br>

`6.`  Una cadena de tiendas de indumentaria posee un archivo maestro no ordenado con la información correspondiente a las prendas que se encuentran a la venta. De cada prenda se registra: cod_prenda, descripción, colores, tipo_prenda, stock y precio_unitario. Ante un eventual cambio de temporada, se deben actualizar las prendas a la venta. Para ello reciben un archivo conteniendo: cod_prenda de las prendas que quedarán obsoletas. Deberá implementar un procedimiento que reciba ambos archivos y realice la baja lógica de las prendas, para ello deberá modificar el stock de la prenda correspondiente a valor negativo.

Por último, una vez finalizadas las bajas lógicas, deberá efectivizar las mismas compactando el archivo. Para ello se deberá utilizar una estructura auxiliar, renombrando el archivo original al finalizar el proceso.. Solo deben quedar en el archivo las prendas que no fueron borradas, una vez realizadas todas las bajas físicas.

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
```
  
</details>

<br><hr id="Ejercicio_7"><br>

`7.`  Se cuenta con un archivo que almacena información sobre especies de aves en vía de extinción, para ello se almacena: código, nombre de la especie, familia de ave, descripción y zona geográfica. El archivo no está ordenado por ningún criterio. Realice un programa que elimine especies de aves, para ello se recibe por teclado las especies a eliminar. Deberá realizar todas las declaraciones necesarias, implementar todos los procedimientos que requiera y una alternativa para borrar los registros. Para ello deberá implementar dos procedimientos, uno que marque los registros a borrar y posteriormente otro procedimiento que compacte el archivo, quitando los registros marcados. Para quitar los registros se deberá copiar el último registro del archivo en la posición del registro a borrar y luego eliminar del archivo el último registro de forma tal de evitar registros duplicados.

```
Nota: Las bajas deben finalizar al recibir el código 500000
```

<details>

<summary> ▶️ </summary>
<br>
  
```Pas
```
  
</details>

<br><hr id="Ejercicio_8"><br>

`8.`   Se cuenta con un archivo con información de las diferentes distribuciones de linux existentes. De cada distribución se conoce: nombre, año de lanzamiento, número de versión del kernel, cantidad de desarrolladores y descripción. El nombre de las distribuciones no puede repetirse.

Este archivo debe ser mantenido realizando bajas lógicas y utilizando la técnica de reutilización de espacio libre llamada lista invertida.

Escriba la definición de las estructuras de datos necesarias y los siguientes procedimientos:

```ExisteDistribucion```: módulo que recibe por parámetro un nombre y devuelve verdadero si la distribución existe en el archivo o falso en caso contrario.

```AltaDistribución```: módulo que lee por teclado los datos de una nueva distribución y la agrega al archivo reutilizando espacio disponible en caso de que exista. (El control de unicidad lo debe realizar utilizando el módulo anterior). En caso de que la distribución que se quiere agregar ya exista se debe informar “ya existe la distribución”.

```BajaDistribución```: módulo que da de baja lógicamente una distribución  cuyo nombre se lee por teclado. Para marcar una distribución como borrada se debe utilizar el campo cantidad de desarrolladores para mantener actualizada la lista invertida. Para verificar que la distribución a borrar exista debe utilizar el módulo ExisteDistribucion. En caso de no existir se debe informar “Distribución no existente”.
  
<details>

<summary> ▶️ </summary>
<br>
  
```Pas
```
  
</details>
  
  
  
  
  
  
  
  
