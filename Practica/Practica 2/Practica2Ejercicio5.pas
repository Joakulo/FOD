program Practica2Ejercicio5;

const
	valorAlto = 9999;
	dimF = 10;
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
        dir:direccion;
        matricula:Integer;
        nombreM:str20;
		DNIm:integer;
		nombreP:str20;
		DNIp:integer;
		matricula:integer;
		fecha:str20;
		lugar:str20;		
	end;
	
	archivoN = file of nacimientos;
	vectorArchivoN = array[rango] of archivoN;
	vectorN = array[rango] of nacimiento;
	
	archivoF = file of fallecimientos;
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

var

BEGIN
	
	
END.

