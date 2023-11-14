Unit calculclassique;

Interface

procedure lireChaine(var str: string);
function priority(c: char): integer;
procedure calculmath(var numbers: array of real; sign: char);
procedure add(var j: Integer; var numero: Real; expression: String);
function Calculate(expression: String): Real;

Implementation

uses sysutils, math;

const Max = 60;
//////////////////
 procedure lireChaine(var str : string);
	begin
   writeln('Entrez un calcul : ');
   readln(str);
	end;
//////////////////
function Priority(c: char): integer;
begin
  case c of
    '+', '-': Priority := 1;
    'x', '/': Priority := 2;
    '^': Priority := 3;
    's', 'c': Priority := 4;
    else Priority := 0;
  end;
end;


procedure calculmath(var numbers: array of real; sign: char);
begin
case sign of
	'+': numbers[High(numbers) - 1] := numbers[High(numbers) - 1] + numbers[High(numbers)];
	'-': numbers[High(numbers) - 1] := numbers[High(numbers) - 1] - numbers[High(numbers)];
	'x': numbers[High(numbers) - 1] := numbers[High(numbers) - 1] * numbers[High(numbers)];
	'/': numbers[High(numbers) - 1] := numbers[High(numbers) - 1] / numbers[High(numbers)];
	'^': numbers[High(numbers) - 1] := power(numbers[High(numbers) - 1], numbers[High(numbers)]);
	's': numbers[High(numbers)] := sin(DegToRad(numbers[High(numbers)]));
	'c': numbers[High(numbers)] := cos(DegToRad(numbers[High(numbers)]));
	else
		begin
		writeln('Invalid operator!');
		exit;
		end;
	end;
end;

////////////
procedure Add(var j: Integer; var numero: Real; expression: String);
begin
  j := j + 1;
  while (j <= Length(expression)) and (expression[j] in ['0'..'9', '.']) do
  begin
    numero := numero * 10 + StrToFloat(expression[j]);
    j := j + 1;
  end;
  j := j - 1; // Bir sonraki döngüde index'i arttırmak için
end;

////////////

function Calculate(expression: String): Real;
var
  opNumber: array of char;
  numberOfNumber: array of real;
  i: integer;
  number: real;
  operateur: char;
begin
  SetLength(opNumber, 0);
  SetLength(numberOfNumber, 0);
  i := 1;

  while i <= Length(expression) do
  begin
    if (expression[i] in ['0'..'9', '.']) then
    begin
      number := StrToFloat(expression[i]);
      Add(i, number, expression);
      SetLength(numberOfNumber, Length(numberOfNumber) + 1);
      numberOfNumber[High(numberOfNumber)] := number;
    end
    
     else if expression[i] in [ 's', 'c'] then
    begin
      while (Length(opNumber) > 0) and (Priority(opNumber[High(opNumber)]) >= Priority(expression[i])) do
      begin
        operateur := opNumber[High(opNumber)];
        SetLength(opNumber, Length(opNumber) - 1);
        CalculMath(numberOfNumber, operateur);
        SetLength(numberOfNumber, Length(numberOfNumber) - 1);
      end;
      SetLength(opNumber, Length(opNumber) + 1);
      opNumber[High(opNumber)] := expression[i];
    end
    
      else if expression[i] in [ '^'] then
    begin
      while (Length(opNumber) > 0) and (Priority(opNumber[High(opNumber)]) >= Priority(expression[i])) do
      begin
        operateur := opNumber[High(opNumber)];
        SetLength(opNumber, Length(opNumber) - 1);
        CalculMath(numberOfNumber, operateur);
        SetLength(numberOfNumber, Length(numberOfNumber) - 1);
      end;
      SetLength(opNumber, Length(opNumber) + 1);
      opNumber[High(opNumber)] := expression[i];
    end
    
    else if expression[i] in ['x', '/'] then
    begin
      while (Length(opNumber) > 0) and (Priority(opNumber[High(opNumber)]) >= Priority(expression[i])) do
      begin
        operateur := opNumber[High(opNumber)];
        SetLength(opNumber, Length(opNumber) - 1);
        CalculMath(numberOfNumber, operateur);
        SetLength(numberOfNumber, Length(numberOfNumber) - 1);
      end;
      SetLength(opNumber, Length(opNumber) + 1);
      opNumber[High(opNumber)] := expression[i];
    end
     else if expression[i] in ['+', '-'] then
     begin
      while (Length(opNumber) > 0) and (Priority(opNumber[High(opNumber)]) >= Priority(expression[i])) do
      begin
        operateur := opNumber[High(opNumber)];
        SetLength(opNumber, Length(opNumber) - 1);
        CalculMath(numberOfNumber, operateur);
        SetLength(numberOfNumber, Length(numberOfNumber) - 1);
      end;
      SetLength(opNumber, Length(opNumber) + 1);
      opNumber[High(opNumber)] := expression[i];
    end;

    i := i + 1;
  end;

  while Length(opNumber) > 0 do
  begin
    operateur := opNumber[High(opNumber)];
    SetLength(opNumber, Length(opNumber) - 1);
    CalculMath(numberOfNumber, operateur);
  end;

  Calculate := numberOfNumber[0];
end;
end.
