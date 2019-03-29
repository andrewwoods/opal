
# Bash Utilities

These underscore functions are utility functions. They are used often, and their short names 

**_e**

Echo a string with some leading padding

```
$ _e "display this content"
```

**_l**

Display a line of characters. By default, display a line of - characters. The first parameter allows you to change the character

```
$ _l 
```

Create a line of \* characters

```
$ _l '*'
```


**_n**

Display an blank line

```
$ _n 
```


**_p**

Progressively echo a line of text

```
$ _p 'This line will be displayed as if being typed quickly'
```


**_s**

Say "vocalize" a line of text. This uses 'say', a Mac only command.

```
$ _s 'This will display and read out loud a message'  
```


