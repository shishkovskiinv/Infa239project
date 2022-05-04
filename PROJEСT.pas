uses graphWPF;

type
  
  _Rectangle = record
    x1: real;
    y1: real;
    x2: real;
    y2: real;
  end;
  
  SetRectangle = array of _Rectangle;

var
  Graphic: real;
  
  a: integer;
  SetRect1, SetRect2: SetRectangle;
  ym, xm: real;
  mouse_up: integer;

procedure MouseDown(x: real; y: real; mb: integer);
begin
  
  if (mb = 1) then 
  begin
    
    xm := x;
    ym := y;
    mouse_up := 1;
  end;
  
end;

procedure DrawRect(var a: SetRectangle; c: Color);
begin
  for var i := 0 to Length(a) - 1 do
  begin
    DrawRectangle(a[i].x2, a[i].y2, a[i].y1 - a[i].y2, a[i].x1 - a[i].x2, c); 
  end;
end;


procedure FillSet1(var a: SetRectangle; c: Color);
var
  x1, x2, y1, y2: real;
  quantity: integer;
begin
  write('Ведите количество прямоугольников :');
  readln(quantity);
  a := new _Rectangle[quantity];
  for var i := 1 to quantity do
  begin
    write('Ведите x1 :');
    readln(x1);
    
    write('Ведите y1 :');
    readln(y1);
    
    write('Ведите x2 :');
    readln(x2);
    
    write('Ведите y2 :');
    readln(y2);
    
    a[i - 1].x1 := max(x1, x2);
    a[i - 1].x2 := min(x1, x2);
    a[i - 1].y1 := max(y1, y2);
    a[i - 1].y2 := min(y1, y2);
  end;
  DrawRect(a, c);
end;

procedure FillSet2(var a: SetRectangle; c: Color);
var
  _file, q: string;
  SetRectangleStr: string;
  SetRectangleStrChoord: array of string;
  x1, x2, y1, y2: real;
  quantity, v: integer;
  f: file;
begin
  v := 0;
  Write('Введите название файла:');
  Readln(_file);
  
  SetRectangleStr := ReadAllText(_file);
  
  SetRectangleStrChoord := SetRectangleStr.ToWords(' ');
  
  quantity := StrToInt(SetRectangleStrChoord[0]);
  
  a := new _Rectangle[quantity];
  
  for var i := 1 to Length(SetRectangleStrChoord) - 4 do
  begin
    if(i mod 4 = 1) then begin
      x1 := StrToReal(SetRectangleStrChoord[i]);
      y1 := StrToReal(SetRectangleStrChoord[i + 1]);
      x2 := StrToReal(SetRectangleStrChoord[i + 2]);
      y2 := StrToReal(SetRectangleStrChoord[i + 3]);
      a[v].x1 := max(x1, x2);
      a[v].x2 := min(x1, x2);
      a[v].y1 := max(y1, y2);
      a[v].y2 := min(y1, y2);
      
      DrawRectangle(a[v].x2, a[v].y2, a[v].x1 - a[v].x2, a[v].y1 - a[v].y2, c);
      v := v + 1;
    end;
    
    
    
    
    
  end;
  
  
end;

procedure FillSet3(var a: SetRectangle; c: Color);
var
  quantity: integer;
  x1, x2, y1, y2: real;
begin
  Write('Введите количество прямоугольников:');
  Readln(quantity);
  a := new _Rectangle[quantity];
  
  for var i := 0 to quantity - 1 do
  begin
    
    repeat
      OnMouseDown := MouseDown;
    until(mouse_up = 1);   
    
    x1 := xm;
    y1 := ym;
    DrawCircle(x1, y1, 0.02);
    mouse_up := 0;
    repeat
      OnMouseDown := MouseDown;
    until(mouse_up = 1);
    mouse_up := 0;
    
    x2 := xm;
    y2 := ym;
    DrawCircle(x2, y2, 0.02);
    a[i].x1 := max(x1, x2);
    a[i].x2 := min(x1, x2);
    a[i].y1 := max(y1, y2);
    a[i].y2 := min(y1, y2);
    DrawRectangle(a[i].x2, a[i].y2, a[i].x1 - a[i].x2, a[i].y1 - a[i].y2, c);
    
    
  end;
  
  
end;

procedure FinalSet(SetRect1: SetRectangle; SetRect2: SetRectangle);
var
  
  SortY: array of real;
  SortX: array of real;
  Intersection1: boolean;
  Intersection2: boolean;
begin
 
  
  
  SortY := new real[Length(SetRect1) * 2 + Length(SetRect2) * 2];
  SortX := new real[Length(SetRect1) * 2 + Length(SetRect2) * 2];
  for var i := 0 to Length(SetRect1) * 2 - 1 do
  begin
    if(i mod 2 = 0) then
    begin
      SortY[i] := SetRect1[i div 2].y1;
      SortY[i + 1] := SetRect1[i div 2].y2;
    end;
  end;
  
  for var i := Length(SetRect1) * 2 to Length(SetRect2) * 2 + Length(SetRect1) * 2 - 1 do
  begin
    if(i mod 2 = 0) then
    begin
      SortY[i] := SetRect2[(i - Length(SetRect1) * 2) div 2].y1;
      SortY[i + 1] := SetRect2[(i - Length(SetRect1) * 2) div 2].y2;
    end;
  end;
  
  Sort(SortY); 
  
  for var i := 0 to Length(SetRect1) * 2 - 1 do
  begin
    if(i mod 2 = 0) then
    begin
      SortX[i] := SetRect1[i div 2].x1;
      SortX[i + 1] := SetRect1[i div 2].x2;
    end;
  end;
  
  for var i := Length(SetRect1) * 2 to Length(SetRect2) * 2 + Length(SetRect1) * 2 - 1 do
  begin
    if(i mod 2 = 0) then
    begin
      SortX[i] := SetRect2[(i - Length(SetRect1) * 2) div 2].x1;
      SortX[i + 1] := SetRect2[(i - Length(SetRect1) * 2) div 2].x2;
    end;
  end;
  
  Sort(SortX); 
  
  for var i := 0 to Length(SetRect2) * 2 + Length(SetRect1) * 2 - 2 do
    for var j := 0 to Length(SetRect2) * 2 + Length(SetRect1) * 2 - 2 do
    begin
      Intersection1 := false;
      Intersection2 := true;
      for var k := 0 to Length(SetRect1) - 1 do
      begin
        if((SortY[i] >= SetRect1[k].y2)
        and (SortY[i] <= SetRect1[k].y1) 
        and (SortY[i + 1] >= SetRect1[k].y2) 
        and (SortY[i + 1] <= SetRect1[k].y1) 
        and (SortX[j] >= SetRect1[k].x2) 
        and (SortX[j] <= SetRect1[k].x1)
        and (SortX[j + 1] >= SetRect1[k].x2)
        and (SortX[j + 1] <= SetRect1[k].x1)) then
        begin
          Intersection1 := true;
        end;
        
        
        
        
      end;
      
      for var k := 0 to Length(SetRect2) - 1 do
      begin
        if((SortY[i] >= SetRect2[k].y2)
        and (SortY[i] <= SetRect2[k].y1) 
        and (SortY[i + 1] >= SetRect2[k].y2) 
        and (SortY[i + 1] <= SetRect2[k].y1) 
        and (SortX[j] >= SetRect2[k].x2) 
        and (SortX[j] <= SetRect2[k].x1)
        and (SortX[j + 1] >= SetRect2[k].x2)
        and (SortX[j + 1] <= SetRect2[k].x1)) then
        
        begin
          Intersection2 := false;
        end;
        
        
        
      end;
      
      if(Intersection1 and Intersection2) then FillRectangle(SortX[j], SortY[i], SortX[j + 1] - SortX[j], SortY[i + 1] - SortY[i], ARGB(255, 255, 0, 0));
    end;
  
end;




begin
  Write('Введите максимальную(она также будет минимальной) координату по оси X и Y(положительное число):');
  Readln(Graphic);
  
  SetMathematicCoords(-1 * Graphic, Graphic, true);
  Writeln('Выберите способ ввода прямоугольников первого множества:');
  Writeln('1 - ввод вручную');
  Writeln('2 - ввод из файла ');
  Writeln('3 - графический ввод');
  Write('Ваш выбор:');
  Readln(a);
  
  case a of
    1:
    FillSet1(SetRect1, ARGB(255, 0, 255, 0));
    
    2:
    FillSet2(SetRect1, ARGB(255, 0, 255, 0));
    
    3:
    FillSet3(SetRect1, ARGB(255, 0, 255, 0));
  
  
  end;
  
  Writeln('Выберите способ ввода прямоугольников второго множества:');
  Writeln('1 - ввод вручную');
  Writeln('2 - ввод из файла ');
  Writeln('3 - графический ввод');
  Write('Ваш выбор:');
  Readln(a);
  
  case a of
    1:
    FillSet1(SetRect2, ARGB(255, 0, 0, 255));
    
    2:
    FillSet2(SetRect2, ARGB(255, 0, 0, 255));
    
    3:
    FillSet3(SetRect2, ARGB(255, 0, 0, 255));
  end;
  
  FinalSet(SetRect1, SetRect2);
  
end.