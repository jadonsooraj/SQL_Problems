Draw The Triangle 1

--Explanation:

1. Variable Initialization:
	@x = 20: Starts from 20 stars.
	@y = 1: The loop stops when @x becomes less than 1.

2. WHILE Loop Condition:
	WHILE @x >= @y: The loop runs as long as @x is greater than or equal to 1.
	Inside the Loop:
	PRINT REPLICATE('* ', @x): Prints a line with @x asterisks (with spaces).
	SET @x = @x - 1: Decreases @x by 1 on each iteration to reduce the star count.

3.Loop Execution:
	First line prints 20 stars, second line prints 19, ... down to 1.


CODE:
declare @x int =20;
declare @y int =1;

WHILE @x>=@y
BEGIN
PRINT replicate('* ',@x);
set @x=@x-1
END