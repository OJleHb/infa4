
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

var
  check1, check2: boolean;

var
  chn: integer;

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
  if i < 7 then
  begin
    for j := i to 7 do
      insert('0', d, i + 1);
  end;
  hex := d;
end;

begin
  writeln('Generating program folder...');
  mkdir('C:\productofgovno');
  chdir('C:\productofgovno');
  mkdir('output');
  chdir('output');
  writeln('Generating key, please do not lose it...');
  randomize;
  key := random(8999999) + 1000000;
  writeln(key);
  assign(output, 'C:/productofgovno/output/output.txt');
  writeln('Please enter message below...');
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
  writeln('Generating checksum...');
  for i := 1 to 7 do
  begin
    a[i] := key mod 10;
    key := key div 10;
  end;
  write(output, inttostr((a[2] + a[5]) mod 10)[1], inttostr((a[4] + a[1]) mod 10)[1], inttostr((a[3] + a[5]) mod 10)[1], inttostr((a[2] + a[6]) mod 10)[1], inttostr((a[3] + a[6]) mod 10)[1], inttostr((a[1] + a[7]) mod 10)[1], inttostr((a[4] + a[7]) mod 10)[1], inttostr((a[1] + a[2] + a[3] + a[4] + a[5] + a[6] + a[7]) mod 10)[1]);
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
  chn := 1;
  for i := 1 to (length(b) - 2) do
  begin
    if (b[i][2] = '0') and (b[i][3] = '0') and (b[i][4] = '0') then
      count := 1;
    if (b[i][3] = '0') and (b[i][4] = '0') and (b[i][2] <> '0') then
      count := 2;
    if (b[i][4] = '0') and (b[i][3] <> '0') then
      count := 3;
    if (b[i][4] <> '0') and ((b[i][1] <> '0') or (b[i][2] <> '0') or (b[i][3] <> '0')) then
      count := 4;
    k := random(3, 4);
    for j := count downto 1 do
      swap(b[i][j], b[i][j + k - 1]);
    delete(b[i], 1, 2);
    if (count > a[chn]) then
    begin
      str(10 + a[chn] - count, txt);
      insert(txt[1], b[i], 1);
      chn := chn + 2;
      check1 := true;
      if chn = 8 then
        chn := 1;
      if chn = 9 then
        chn := 2;
    end
    else
    begin
      str(a[chn] - count, txt);
      insert(txt[1], b[i], 1);
      chn := chn + 2;
      if chn = 8 then
        chn := 1;
      if chn = 9 then
        chn := 2;
    end;
    if (k > a[chn]) then
    begin
      str(10 + a[chn] - k, txt);
      insert(txt[1], b[i], 2);
      chn := chn + 2;
      check2 := true;
      if chn = 8 then
        chn := 1;
      if chn = 9 then
        chn := 2;
    end
    else
    begin
      str(a[chn] - k, txt);
      insert(txt[1], b[i], 2);
      chn := chn + 2;
      if chn = 8 then
        chn := 1;
      if chn = 9 then
        chn := 2;
    end;
    if k = 3 then
    begin
      delete(b[i], 7, 1);
      if (check1 = true) and (check2 = true) then
      begin
        str(0, txt);
        insert(txt[1], b[i], 7);
      end;
      if (check1 = true) and (check2 = false) then
      begin
        str(1, txt);
        insert(txt[1], b[i], 7)
      end;
      if (check1 = false) and (check2 = true) then
      begin
        str(2, txt);
        insert(txt[1], b[i], 7)
      end;
      if (check1 = false) and (check2 = false) then
      begin
        str(random(3, 9), txt);
        insert(txt[1], b[i], 7)
      end;
      delete(b[i], 8, 1);
      str(((random(1, 4)) * 2), txt);
      insert(txt[1], b[i], 8);
      if count < 4 then
      begin
        for j := 1 to (4 - count) do        
          b[i][k + count + j - 1] := inttostr(random(1, 9))[1];
      end;
      check1 := false;
      check2 := false;
      count := 0;
      k := 0;
    end;
    if (k = 4) then
    begin
      delete(b[i], 3, 1);
      if (check1 = true) and (check2 = true) then
      begin
        str(0, txt);
        insert(txt[1], b[i], 3);
      end;
      if (check1 = true) and (check2 = false) then
      begin
        str(1, txt);
        insert(txt[1], b[i], 3)
      end;
      if (check1 = false) and (check2 = true) then
      begin
        str(2, txt);
        insert(txt[1], b[i], 3)
      end;
      if (check1 = false) and (check2 = false) then
      begin
        str(random(3, 9), txt);
        insert(txt[1], b[i], 3)
      end;
      delete(b[i], 8, 1);
      str((((random(0, 4)) * 2) + 1), txt);
      insert(txt, b[i], 8);
      if count < 4 then
      begin
        for j := 1 to (4 - count) do
          b[i][k + count + j - 1] := inttostr(random(1, 9))[1];
      end;
      check1 := false;
      check2 := false;
    end;
  end;
  for i := 0 to (length(b) - 1) do
  begin
    for j := 1 to length(b[i]) do
      write(output, b[i][j]);
    write(output, ' ');
  end;
  writeln('Task failed succesfully, check folder C:\productofgovno');
  close(output);
  writeln('Press enter to continue...');
  readln;
end.

