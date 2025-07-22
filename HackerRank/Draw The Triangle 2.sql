Draw The Triangle 2

CODE:
declare @x int = 1;
declare @y int = 20;

while @x<=@y
begin
print replicate('* ',@x);
set @x=@x+1
end