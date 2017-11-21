# File descriptors

A file descriptor is an `int` variable that is used to read or write data to files. Think of it as a product SKU, or a badge ID number. It's some integer value, but you don't ever need to remember the value cause it's used by some system for lookup.

## Testing reading/writing to files

Pretend you wrote a function already called `ds_putchar_fd`, which writes a single character to a file.

```c
void ds_putchar_fd(char c, int fd)
{
    write(fd, &c, 1);
}
```

Here's how you would go about testing it:

1. Create a file somewhere called `testfile.txt`. This is the file you'll write to (the name & extension don't matter, just make sure they're consistent w/ your code).

	```
	touch testfile.txt
	```

2. Grab the path where this file is stored using the `pwd` command. In our code, we'll append the filename `testfile.txt` to the path where it's located, so that the code is referencing a full file path.

3. Here's how your test program, complete with `main` would look like:
	
    ```c
    void ds_putchar_fd(char c, int fd)
    {
        write(fd, &c, 1);
    }
    
    int main(void)
    {
        int filedesc = open("/Users/aschukin/somepath/testfile.txt", O_WRONLY);
        
        if (filedesc < 0) {
            printf("Oops! Couldn't open the file. \n");
            return -1;
        }
        
        ds_putchar_fd('H', filedesc);
        ds_putchar_fd('e', filedesc);
        ds_putchar_fd('l', filedesc);
        ds_putchar_fd('l', filedesc);
        ds_putchar_fd('o', filedesc);
        
        return 0;
    }
    ```
    
    Make sure you replace `/Users/aschukin/somepath/testfile.txt` in the above code with the actual path of your test file that you've created!

4. Build & run your test program. 
5. Open `testfile.txt` (or read it on the command line using `cat testfile.txt`). You should see the world `Hello` in your file!

### What's going on here?

The following line of code:

```
int filedesc = open("/Users/aschukin/somepath/testfile.txt", O_WRONLY);
```

is opening a file at the given path. The second parameter of this function has a flag `O_WRONLY`, which means "write only".