program Pr1Ej2;

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

