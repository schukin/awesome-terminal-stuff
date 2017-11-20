# itoa

```c
char *ds_itoa(int num, char* str, int base)
```

`itoa` converts an integer into a string. Let's go over its parameters:

* `int num` - this is the integer we want to convert.
* `char *str` - once we convert it to a string, this is where we'll store it. Because we want to write to this, we'll want to pass it an empty array of characters, i.e. `char str[100];`
* `int base` - let's ignore this for now, we'll re-examine towards the end.

The best way to think of a problem like this is: _Let's solve the absolutely simplest case first, then go from there._

## The simplest case

Ask yourself this: Are there _any_ numbers that you know how to convert to a string? Or to step back... that you know how to convert to a `char` (single character)?

Of course! You already know how to convert any digit from `0` to `9` to a `char`! So let's start with writing a function that converts single-digit numbers:

```c
char *ds_itoa(int num, char* str, int base)
{
	char c;
	c = '0' + num;
	str[0] = c;
	return str;
}
```

Great! We can even tighten this up a bit:

```c
char *ds_itoa(int num, char* str, int base)
{
	str[0] = '0' + num;
	return str;
}
```

> Note: When testing the above function, you'll likely see the rest of your string have "garbage data" when printing it, because we didn't add a null terminator (`\0`). That's fine for now.

## 2-digit numbers

How can we take an integer, and split it into multiple digits, so we can convert each into a character? What if we divide the integer, and grab the _remainder_?

To divide a number and get the remainder, we use the **modulo** (`%`) operator.

So for a 2-digit integer, we would do the following:

1. For the 2nd digit, we'd get the _remainder_ when dividing the integer by 10. Then we can convert that.
2. For the 1st digit, we'd simply divide the integer by 10. Then we can convert that.

Let's code this up:

```c
char *ds_itoa(int num, char* str, int base)
{
	int digit1;
	int digit2;
	digit2 = num % 10;
	digit1 = num / 10;

	str[1] = '0' + digit2;
	str[0] = '0' + digit1;
	return str;
}
```

OMIGOSH IT WORKS WITH 2-DIGIT INTEGERS!!!11

## Multiple digit numbers

How would we extend this to integers with any # of digits?

To do this, we'll have a `while` loop that keeps getting the last digit via `%`, and then dividing by 10. So we're effectively converting each digit in reverse order.

But first we'll need to count how many digits the number has. We can do this by using another `while` loop to count how many times we can divide it by 10 before it becomes 0.

```c
char *ds_itoa(int num, char* str, int base)
{
	int digits;
	int num_copy;
	
	digits = 0;
	num_copy = num;
	
	// This counts the number of digits in num,
	// before we start converting any digits to characters
	while (num_copy > 0)
	{
		digits++;
		num_copy = num_copy / 10;
	}
	
	// Then, copy digits into string, in reverse order.
	// We'll use i to keep track of which character
	// index we're at.
	int i;
	
	i = digits - 1;	

	while (num > 0)
	{
		str[i] = '0' + (num % 10);
		num = num / 10;
		i--;
	}

	return str;
}
```

w00t!!! It works!!! Let's clean this up by extracting the calculation of # of digits into a separate function. Now's also a good time to add our null-terminating `\0` at the end.

```c
int count_digits(int num)
{
	int digits;
	digits = 0;
	
	while (num > 0)
	{
		digits++;
		num = num / 10;
	}
	
	return digits;
}

char *ds_itoa(int num, char* str, int base)
{
	int digits;
	int i;
	digits = count_digits(num);
	i = digits - 1;

	while (num > 0)
	{
		str[i] = '0' + (num % 10);
		num = num / 10;
		i--;
	}
	
	str[digits] = '\0';

	return str;
}
```

## Negative numbers

Oh right. Integers can be negative.

There are a few ways to do this. I've offered one solution below.

```c
int count_digits(int num)
{
    int digits;
    digits = 0;
    
    while (num > 0)
    {
        digits++;
        num = num / 10;
    }
    
    return digits;
}

char *ds_itoa(int num, char* str, int base)
{
    int digits;
    int i;
    
    // If the number is negative...
    if (num < 0)
    {
        str[0] = '-'; // The first character is the negative symbol
        num = -num;   // Invert `num` so the rest of our logic works normally
        digits = 1;   // Add 1 to our digit counter because of the negative symbol
    } else {
        digits = 0;
    }
    
    digits = digits + count_digits(num);
    
    i = digits - 1;
    
    while (num > 0)
    {
        str[i] = '0' + (num % 10);
        num = num / 10;
        i--;
    }
    
    str[digits] = '\0';
    
    return str;
}
```

## Base

Ping me if you get here.