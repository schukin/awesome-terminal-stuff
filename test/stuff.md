```
char    *ft_strchr(const char *str, int c)
{
    for( ; *str && (*str != c); str++ ) ;

    return ( *str? str : NULL);
}
```

This function returns a `char *`, aka a string.

`const` is a thing you can prepend to your variable declaration, but I don't think you ever use them in school so you can ignore it.

```
for( ; *str && (*str != c); str++ ) ;
```

This is using a "**for loop**" to accomplish something weird. As far as I know, you're currently not allowed to use `for` loops, which is a bit strange because they're used _extensively_ in practical programming, much more so than `while` loops.

## For loops

**At this point, make sure you're 100% crystal clear on how a `while` loop works, and what it's doing**.

A `for` loop is very similar to a `while` loop; To demonstrate, let's start with a simple `while` loop that prints out `0 1 2 3 4`:

```
int i;
i = 0;

while (i < 5)
{
	printf("%d ", i);
	i++;
}
```

The above `while` loop can be re-written as a `for` loop as such:

```
for (int i = 0; i < 5; i++)
{
	printf("%d ", i);
}
```

Let's break it down:

![](https://i.imgur.com/5VNdzky.png)

---

So if we go all the way back to the initial code snippet:

```
for( ; *str && (*str != c); str++ ) ;
```

What this is doing:

1. The first part is empty with just a semicolon; thus it doesn't declare a "counter" variable of any sort.
2. The condition is `*str && (*str != c)`, so this will keep looping while (a) `*str` is not null/empty, and (b) `*str` is not equal to `c`.
3. The 3rd part increments the `*str` pointer.
4. There's a semicolon after the parenthesis, instead of curly braces. This means that there's nothing inside the for loop, and it's basically just being used to increment `str`.

Like I said, it's weird / succinct / maybe clever, but "clever" is often unreadable.

---

## The ternary operator

```
return ( *str? str : NULL);
```

This is usage of the [ternary ?: operator](https://en.wikipedia.org/wiki/%3F:). I'll let you click the link if you want to find out more, but this is another way to write code that is super succinct at the expense of legibility. I don't think you're allowed to use it in school, so you can prob ignore it for now.

This can be re-written as:

```
if (*str)
	return str;
else
	return NULL;
```

## Putting it all together

Our function:

```
char    *ft_strchr(const char *str, int c)
{
    for( ; *str && (*str != c); str++ ) ;

    return ( *str? str : NULL);
}
```

can be rewritten as:

```
char    *ft_strchr(char *str, int c)
{
	while (*str && (*str != c))
		str++;
	
	if (*str)
		return str;
	else
		return NULL;
}
```

Or better put, because it's strongly recommended you always use curly braces even for 1-line loops & `if` statements:

```
char    *ft_strchr(char *str, int c)
{
	while (*str && (*str != c))
	{
		str++;
	}
	
	if (*str)
	{
		return str;
	}
	else
	{
		return NULL;
	}
}
```
