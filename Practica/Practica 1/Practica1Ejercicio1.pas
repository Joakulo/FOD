program Pr1Ej1;

type
	archivo = file of integer;
	cadena20 = string[20];

var
	arch_logico : archivo;
	arch_fisico : cadena20;

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

BEGIN
	CrearArchivo(arch_logico, arch_fisico);
END.

