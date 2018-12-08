
var
  output: file of char;

var
  a: array [1..7] of byte;
  b: array of string;

var
  key, dl: uint64;

var
  txt: string;

var
  i, j, k: uint64;

var
  count: byte;

function hex(a: word): string;
var
  b, i, j: integer;
var
  d, buf: string;

begin
  repeat
    i := i + 1;
    b := a mod 16;
    if (b < 10) then
    begin
      str(b, buf);
      insert(buf, d, i);
      delete(buf, 1, 1);
    end;
    if (b = 10) then insert('A', d, i);
    if (b = 11) then insert('B', d, i);
    if (b = 12) then insert('C', d, i);
    if (b = 13) then insert('D', d, i);
    if (b = 14) then insert('E', d, i);
    if (b = 15) then insert('F', d, i);
    a := a div 16;
  until (a = 0);
  if i < 6 then
  begin
    for j := i to 6 do
      insert('0', d, i + 1);
  end;
  hex := d;
end;

begin
  writeln('создаю каталог в корне диска C,там будет лежать файл результат');
  mkdir('C:\productofgovno');
  chdir('C:\productofgovno');
  mkdir('output');
  chdir('output');
  writeln('генерирую ключ, запишите его, он пригодится для дальнейшего декодирования');
  randomize;
  key := random(8999999) + 1000000;
  writeln(key);
  assign(output, 'C:/productofgovno/output/output.txt');
  writeln('введите текст для зашифровки');
  rewrite(output);
  readln(txt);
  dl := length(txt);
  b := new string[dl + 2];
  for j := 1 to length(hex(length(txt))) do
    write(output, hex(length(txt))[j]);
  write(output, ' ');
  for i := 1 to length(txt) do
  begin
    for j := 1 to length(hex(ord(txt[i]))) do
      write(output, hex(ord(txt[i]))[j]);
    write(output, ' ');
  end;
  writeln('генерирую контрольную сумму');
  for i := 1 to 7 do
  begin
    a[i] := key mod 10;
    key := key div 10;
  end;
  write(output, inttostr((a[2] + a[5]) mod 10)[1], inttostr((a[4] + a[1]) mod 10)[1], inttostr((a[3] + a[5]) mod 10)[1], inttostr((a[2] + a[6]) mod 10)[1], inttostr((a[3] + a[6]) mod 10)[1], inttostr((a[1] + a[7]) mod 10)[1], inttostr((a[1] + a[2] + a[3] + a[4] + a[5] + a[6] + a[7]) mod 10)[1]);
  setlength(txt, 1);
  j := 1;
  i := 0;
  seek(output, 0);
  while not (eof(output)) do
  begin
    read(output, txt[1]);
    if (txt = ' ') then
    begin
      i := i + 1;
      j := 1;
    end
    else
    begin
      insert(txt, b[i], j);
      j := j + 1
    end;
  end;
  rewrite(output);
  for i := 1 to (length(b) - 2) do
  begin
    key := 1;
    if (b[i][2] = '0') and (b[i][3] = '0') and (b[i][4] = '0') then
      count := 1;
    if (b[i][3] = '0') and (b[i][4] = '0') and (b[i][2] <> '0') then
      count := 2;
    if (b[i][4] = '0') and (b[i][3] <> '0') and (b[i][2] <> '0') then
      count := 3;
    if (b[i][4] <> '0') and ((b[i][1] <> '0') or (b[i][2] <> '0') or (b[i][3] <> '0')) then
      count := 4;
    k := random(3, 4);
    for j := 1 to count do
      b[i][k + j - 1] := b[i][j];
    delete(b[i], 1, 2);
    str(count, txt);
    insert(txt, b[i], 1);
    str(k, txt);
    insert(txt, b[i], 2);
  end;
  for i := 0 to (length(b) - 1) do
  begin
    for j := 1 to length(b[i]) do
      write(output, b[i][j]);
    write(output, ' ');
  end;
  writeln('шифрование завершено, проверьте папку productofgovno в корне диска C');
  close(output);
end.

