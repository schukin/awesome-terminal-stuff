# Structs

`int` and `char` are called **types** in C, and in general programming. You declare a variable with a *type*, to specify the type of data that will be stored in that variable.

```c
int 
```

We can use `int` and `char` to store an integer or a character, respectively. 


# Variables

## Primitive types

Let's enumerate all the different variable _types_ we can use, starting by what we'd use them for.

**If we want to store an integer**, we use an `int`.

```c
int a;
a = 42;
```

**If we want to store a single character**, we use a `char`.

```c
char c;
c = 'a';
```

> Remember: _Single character, single quote!_

When we declare a regular `int` or `char` variable, and call another function with that variable as a parameter, then (1) that function makes a local "copy" of that variable, thus (2) *changing the value of the variable inside the function does not change its value outside the function*. For example:

```c
void bar(int b)
{
	b = 68;
}

void foo()
{
	int a;
	a = 42;
	
	bar(a);
	printf("%d", a);
}
```

The above program will print `42`, rather than 68. *This is extremely important, so if this is unclear, send Dave an email immediately saying "variables unclear"!*

`int` and `char` are "primitive types". We'll soon find that there are many different _types_ of variables you can have (pointers, arrays, and more), although `int` and `char` are the most simple, or _primitive_.

## Pointers

**If we want the change to a variable inside a given function to also reflect a change outside the function,** we use _pointers_.

Tweaking the previous example:

```c
void bar(int *b)
{
	*b = 68;
}

void foo()
{
	int a;
	a = 42;
	
	bar(&a);
	printf("%d", a);
}
```

The above program will print `68`.

## Arrays

**If we want to store a series of primitives (integers or characters) without declaring a separate variable for each primitive**, we use an _array_ of primitives.

When you declare an array, you specify the number of values (integers or characters) it'll store, inside the brackets.

![coolnumbers](https://i.imgur.com/i7akdNi.png)

For example:

```c
int coolnumbers[4];
coolnumbers[0] = 42;
coolnumbers[1] = 100;
coolnumbers[2] = 88;
coolnumbers[3] = 31;
printf("%d", coolnumbers[3]);
```

The above program will print `31`.

## Strings

A _string_ is simply an _array_ of `char` variables! Makes sense, right? For example:

```c
char coolstring[4];
coolstring[0] = 'P';
coolstring[1] = 'o';
coolstring[2] = 'o';
coolstring[3] = 'p';
printf("%s", coolstring);
```
This will print "`Poop`".

"But wait, shouldn't I use `char *` for strings?"

Guess what: They're interchangeable in most cases! An array _is_ a pointer. So when you use `char *`, you're simply creating an array of characters! For example:

```c
char *coolstring;
coolstring = "Poop";
printf("%s", coolstring);
```

This will print "`Poop`".

**If you want to store a string**, use a `char` pointer, or an array of `char`'s. There are subtle differences though, which I'll explain later.

## Structs

A struct is a custom type, that can include any of the types discussed above.

Say we want to store the first name & age of people. We have two people, Bob & Cathy, who are 38 & 42 respectively. Here's one way to do it:

```c
void foo()
{
	char *personAname;
	int personAage;
	char *personBname;
	int personBage;

	personAname = "Bob";
	personAage = 38;
	personBname = "Cathy";
	personBage = 42;
}
```

If we started adding more people, this would get tedious, because for each person we have to separately declare two variables (a `char *` for the name & a `int` for the age).

With a `struct`, we can encompass name & age into a single type. Here's how:

```c
typedef struct t_person {
	char *name;
	int age;
} t_person;

void foo()
{
	t_person personA;
	t_person personB;
	
	personA.name = "Bob";
	personA.age = 38;
	personB.name = "Cathy";
	personB.age = 42;
}
```

See how it's simpler???

**When we want to combine multiple different types for reuse**, we use _structs_.

This is getting kinda meta, so I'll try to break it down:

![structs](https://i.imgur.com/QLIrAZs.png)

> **It is critical that you understand what structs are. If you don't, email Dave.**

# Struct pointers

Just like you can have integer & character pointers, you can have `struct` pointers.

> I'm going to use `malloc` here, and assume you remember how to use `malloc` for earlier material. If you don't, see my PDF on malloc.

I'm going to tweak the previous example to add a third person Dave, but use a pointer this time.

```c
typedef struct t_person {
	char *name;
	int age;
} t_person;

void foo()
{
	t_person personA;
	t_person personB;
	t_person *personC = malloc(sizeof(t_person));
	
	personA.name = "Bob";
	personA.age = 38;
	personB.name = "Cathy";
	personB.age = 42;
	personC->name = "Dave";
	personC->age = 31;
}
```

Notice the arrow instead of dot! **When we use struct pointers, use arrows to access member variables. Otherwise, use dots.**

> The `malloc` in this example was probably confusing. That's okay! This entire document kinda skipped right past `malloc`. It's just as important, but we can study it separately (and let's not forget to!).