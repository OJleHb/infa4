
var
  key: integer;

var
  a: array [1..7] of byte;
  a1: array [1..8] of byte;
  b: array of string;

var
  input: file of char;
  res: text;

var
  i, j: uint64;

var
  txt: string;

var
  k, count, chn, l: byte;

var
  code: real;

label 1;
begin
  mkdir('C:\productofgovno');
  chdir('C:\productofgovno');
  mkdir('decrypt');
  chdir('decrypt');
  assign(input, 'C:\productofgovno\decrypt\input.txt');
  reset(input);
  assign(res, 'C:\productofgovno\decrypt\result.txt');
  rewrite(res);
  1:
  writeln('Enter decryption key given by encryption program');
  readln(key);
  if ((key div 1000000) > 0) and ((key div 1000000) < 10) then
  begin
    for i := 1 to 7 do
    begin
      a[i] := key mod 10;
      key := key div 10;
    end;
  end
  else
  begin
    writeln('Incorrect input format, try again');
    goto 1;
  end;
  b := new string[1];
  setlength(txt, 1);
  j := 1;
  i := 0;
  while not (eof(input)) do
  begin
    read(input, txt[1]);
    if (txt = ' ') then
    begin
      j := 1;
      i := i + 1;
      setlength(b, length(b) + 1);
    end
    else
    begin
      insert(txt, b[i], j);
      j := j + 1
    end;
  end;
  for i := 1 to 8 do
    a1[i] := strtoint(b[length(b) - 2][i]);
  if (((a[2] + a[5]) mod 10) <> a1[1]) or (((a[4] + a[1]) mod 10) <> a1[2]) or (((a[3] + a[5]) mod 10) <> a1[3]) or (((a[2] + a[6]) mod 10) <> a1[4]) or (((a[3] + a[6]) mod 10) <> a1[5]) or (((a[1] + a[7]) mod 10) <> a1[6]) or (((a[4] + a[7]) mod 10) <> a1[7]) or (((a[1] + a[2] + a[3] + a[4] + a[5] + a[6] + a[7]) mod 10) <> a1[8]) then
  begin
    writeln('Error: Incorrect key, stopping');
    key := 0;
    exit;
  end;
  chn := 1;
  for i := 1 to length(b) - 3 do
  begin
    if (strtoint(b[i][8]) mod 2 = 0) then
    begin
      k := 3;
      if (strtoint(b[i][7]) >= 3) then
        count := a[chn] - strtoint(b[i][1]);
      if (strtoint(b[i][7]) = 2) then
        count := a[chn] - strtoint(b[i][1]);
      if (strtoint(b[i][7]) = 1) then
        count := 10 + a[chn] - strtoint(b[i][1]);
      if (strtoint(b[i][7]) = 0) then
        count := 10 + a[chn] - strtoint(b[i][1]);
      chn := chn + 2;
      if chn = 8 then
        chn := 1;
      if chn = 9 then
        chn := 2;
      chn := chn + 2;
      if chn = 8 then
        chn := 1;
      if chn = 9 then
        chn := 2;
    end
    else
    begin
      k := 4;
      if (strtoint(b[i][3]) >= 3) then
        count := a[chn] - strtoint(b[i][1]);
      if (strtoint(b[i][3]) = 2) then
        count := a[chn] - strtoint(b[i][1]);
      if (strtoint(b[i][3]) = 1) then
        count := 10 + a[chn] - strtoint(b[i][1]);
      if (strtoint(b[i][3]) = 0) then
        count := 10 + a[chn] - strtoint(b[i][1]);
      chn := chn + 2;
      if chn = 8 then
        chn := 1;
      if chn = 9 then
        chn := 2;
      chn := chn + 2;
      if chn = 8 then
        chn := 1;
      if chn = 9 then
        chn := 2;
    end;
    setlength(txt, 0);
    for j := k to k + count - 1 do
      insert(b[i][j], txt, 1);
    for j := 1 to count do
    begin
      if (txt[j] >= '0') and (txt[j] <= '9') then
        l := strtoint(txt[j]);
      if txt[j] = 'A' then
        l := 10;
      if txt[j] = 'B' then
        l := 11;
      if txt[j] = 'C' then
        l := 12;
      if txt[j] = 'D' then
        l := 13;
      if txt[j] = 'E' then
        l := 14;
      if txt[j] = 'F' then
        l := 15;
      code := code + l * power(16, count - j)
    end;
    write(res, chr(round(code)));
    code := 0;
    setlength(txt, 0);
    l := 0;
  end;
  writeln('decryption task failed succesfully :D ');
  close(input);
  close(res);
end.

