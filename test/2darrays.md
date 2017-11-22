# strsplit & multi-dimensional arrays

> Note: To write `strsplit`, you'll have to have already written `strsub`, as well as `strlen`, since your implementation of `strsplit` will depend on these.

## What we already know

So we already understand the basics of arrays:

1. **An array is a series of some type of variable.** For example, the following program declares an array of 6 integers, and prints them out:
    ```c
    int a[6] = { 4, 8, 15, 16, 23, 42 };
        
    int i;
    i = 0;
    while (i < 6)
    {
	    printf("%d ", a[i]);
	    i++;
    }
    ```
    The above program prints out `4 8 15 16 23 42`

2. **A string is simply an _array of characters_** (an array of `char` elements). For example:
	```c
	char str[6] = "Hello!";
	printf("%s ", str);
	```
	The above program prints out `Hello!`
3. **An array can be treated as a pointer.** The previous example can be rewritten as:
	```c
	char *str = "Hello!";
	printf("%s ", str);
	```
4. **We use `malloc` to allocate space for an array** if, when we declare the array, we don't yet know how many elements it'll store (or the amount is determined by another variable).
	
	For example, to allocate space for a string that will be up to _n_ characters:
	```c
	char *str;
	str = (char *) malloc(n * sizeof(char));
	```
	We can use this to write a function that creates & returns a string with the first _n_ letters of the alphabet:
	```c
	char *alphabet(int n)
	{
		char *str;
		str = (char *) malloc(n * sizeof(char));
		
		int i;
		i = 0;
		while (i < n)
		{
			str[i] = 'a' + i;
			i++;
		}
		
		return str;
	}
	
	int main(void)
	{
		printf("%s ", alphabet(6));
		return 0;
	}
	```
	The above program will print `abcdef`

## Two-dimensional arrays

So... you can also have an array of arrays. Also known as a 2D array!

For example, the following declares a 2D array. `a` itself has 3 elements, each of which is an array of 4 elements.

```c
int a[3][4] = {
	{ 4, 8, 15, 16 },
	{ 23, 42, 88, 101 },
	{ 137, 256, 487, 555 }
};

int b;
b = a[1][2];
printf("%d ", b);
```
The above program will print the column at row 1, column 2 (and remember, array indexes start at 0). So the output will be `88`.

### Arrays of strings

Guess what: **An array of strings is simply a 2D array of characters!** Makes sense, right?

Say we want to create an array of names, and print out the first name. Here are 4 different ways we can accomplish the same thing. (All 4 of these examples print out `Anya`):

1. Example 1
    ```c
    char names[3][5] = {
	    { 'A', 'n', 'y', 'a', '\0' },
	    { 'D', 'r', 'e', 'w', '\0' },
	    { 'D', 'a', 'v', 'e', '\0' }
    };
    
    char *first;
    first = names[0];
    printf("%s ", first);
    ```
    
2. Example 2
    ```c
    char names[3][5] = {
	    "Anya",
	    "Drew",
	    "Dave"
	};
	
	char *first;
	first = names[0];
	printf("%s ", first);
	```
	> Remember that when we use double-quotes (`" "`) to declare strings, the compiler automatically adds the null-terminator (`\0`) for us. Which is why both of the previous examples are 3x5 `char` arrays, but we only explicitly add the null terminators in the first example.

3. Example 3
    ```c
    char **names;
    names = (char **) malloc(3 * sizeof(char *));
    names[0] = "Anya";
    names[1] = "Drew";
    names[2] = "Dave";
    
    char *first;
    first = names[0];
    printf("%s ", first);
    ```

4. Example 4
```c
char **names;
names = (char **) malloc(3 * sizeof(char *));
names[0] = (char *) malloc(4 * sizeof(char));
names[0][0] = 'A';
names[0][1] = 'n';
names[0][2] = 'y';
names[0][3] = 'a';
names[1] = (char *) malloc(4 * sizeof(char));
names[1][0] = 'D';
// Not going to finish this example, but you get the point
```

>If you understand everything up to here, then this stuff makes writing `main` functions much more intuitive!
>
> Think about it: **A series of command line arguments is simply an array of strings!** So your main will always give you (a) the number of command line arguments entered, and (b) an array of command line arguments that were entered!
>
>
> `int main(int argc, char **argv)`

Got it so far? **Make sure you understand 2D arrays before proceeding!**

## strsplit

Let's write a function called `ds_strsplit`!

```
char **ds_strsplit(char const *str, char delimiter)
```
Its first parameter is the input string. The second parameter is the delimiter character, which we'll be finding in the input string, and using that to split into multiple strings.

The return type of this function is an _array of strings_, or a 2D array of `char`'s.

For example...

```c
char *everyone; 
char **names;
char *first;
everyone = "Anya,Drew,Dave";
names = ds_strsplit(everyone, ',');
first = names[0];
printf("%s ", first);
```

The above program should print out `Anya`.

So, if we go back to **Example 4** in the previous section, we see that there are 2 "levels" of `malloc` needed to create a 2D array. The first "level" will be the number of names. But how do we get the number of names?

Just loop through the string and count the # of occurrences of the delimiter character:

```c
char **ds_strsplit(char const *str, char delimiter)
{
    int len;
    int i;
    len = 0;
    i = 0;
    
    while (str[i])
    {
        if (str[i] == delimiter)
            len++;
        i++;
    }
    
    printf("%d occurrences ", len);
    
    return NULL;
}

int main(void)
{
    ds_strsplit("Anya,Drew,Dave", ',');
    return 0;
}
```

A couple things to note in the above code:
* We're returning NULL at the end of our function just to get it to compile; we're not actually using the return value anywhere at the moment, so this could be anything.
* We're `printf`'ing our delimiter count within our function. We're just doing this for now, to ensure that the little code we've written so far is correct.

The above code should print `2 occurrences`, because there are 2 commas.

Great! Next...

1. Let's move this delimiter counting code into its own function to clean things up.
2. Remember to add 1 to the delimiter count. As in the example above, there's 2 delimiters but 3 names.
3. Use this count to `malloc` our 2D array that we'll eventually return!

```c
int ds_delim_count(char const *str, char delimiter)
{
    int count;
    int i;
    count = 0;
    i = 0;
    
    while (str[i])
    {
        if (str[i] == delimiter)
            count++;
        i++;
    }
    
    return count;
}

char **ds_strsplit(char const *str, char delimiter)
{
    int len;
    len = ds_delim_count(str, delimiter);
    len++;
    
    char **strings;
    strings = (char **) malloc(len * sizeof(char *));
    
    return NULL;
}

int main(void)
{
    ds_strsplit("Anya,Drew,Dave", ',');
    return 0;
}
```

Sweet!

Next step: We'll have 3 loops:

1. An outer `while` loop, that keeps track of the # of words we've found.
2. Our 1st inner `while` loop, which iterates over each character of our input string, skipping over the delimiters
3. Our 2nd inner `while` loop, which continues iterating over each character of our input string, to figure out the length of the word (or the # of characters between delimiters). Once we've figured out the length of a word, we can add it to our array

```c
char **ds_strsplit(char const *str, char delimiter)
{
    char **strings;
    int len; // The total number of words we expect & allocate for
    int count; // The number of words we've gone through
    int i; // Character index counter
    
    len = ds_delim_count(str, delimiter);
    len++; // There is always 1 more than the delimiter count
    strings = (char **) malloc(len * sizeof(char *));
    count = 0;
    i = 0;
    
    // Loop through each "word" by keeping track of the
    // # of words we've gone through (stored in `count`)
    while (count < len)
    {
        int wordlen;
        wordlen = 0;
        
        // Keep moving the character index forward as long as
        // (1) we keep encountering delimiters,
        //     i.e. in case we encounter multiple consecutive delimiters
        // (2) the current character is non-null
        while (str[i] == delimiter && str[i])
            i++;
        
        // Once we've encountered a character that isn't a delimiter,
        // keep looping through the subsequent characters to
        // determine the length of the current word
        while (str[i] != delimiter && str[i])
        {
            wordlen++;
            i++;
        }
        
        // Once we know the length of the current word,
        // use its length to get the substring of our input string
        strings[count] = ds_strsub(&str[i - wordlen], 0, wordlen);
        
        // Increment the # of words we've found
        count++;
    }
    
    return strings;
}
```

That's it! You'll find other implementations of `strsplit` which should be very similar; if you've gotten to this point, they should be fairly easy to read & understand. (I hope, I might be biased here since I just wrote this whole guide lol)