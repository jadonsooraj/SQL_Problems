--Print Prime Numbers

--Explanation
1. For each number n, checks divisibility from 2 to √n (using i*i <= n).
2. If no divisor is found → it’s prime.
3. Appends prime numbers to a string @result, separated by &.
4. At the end, trims the last trailing & and prints the result.

--CODE:
DECLARE @n INT = 2;
DECLARE @i INT;
DECLARE @isPrime BIT;
DECLARE @result VARCHAR(MAX) = '';

WHILE @n <= 1000
BEGIN
    SET @isPrime = 1;
    SET @i = 2;

    WHILE @i * @i <= @n
    BEGIN
        IF @n % @i = 0
        BEGIN
            SET @isPrime = 0;
            BREAK;
        END
        SET @i = @i + 1;
    END

    IF @isPrime = 1
        SET @result = @result + CAST(@n AS VARCHAR) + '&';

    SET @n = @n + 1;
END

-- Remove the trailing '&'
IF RIGHT(@result, 1) = '&'
    SET @result = LEFT(@result, LEN(@result) - 1);

PRINT @result;
