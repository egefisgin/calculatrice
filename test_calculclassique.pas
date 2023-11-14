program test_calculclassique;

uses calculclassique;

var expressions: String;
	check: String;
	answer: Real;
	j: Integer;
begin
writeln('Bienvenue dans la section calcul classique');
j := 1;
repeat
	lireChaine(expressions);
	answer := calculate(expressions);
	Writeln(answer);
	repeat
		writeln(' continue /c or exist /e ');
		readln(check);
		until (check = 'c') or (check = 'e');
	j := j + 1;
	until (check = 'e');
end.
