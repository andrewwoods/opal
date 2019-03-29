
# Developer Functions

This collection of function is to help developers.

**check_site**

Sometimes a website goes down. This function lets you check regularly to see if
it's back up. It's a good idea to run this in a separate terminal window, so
you can keep an eye on it without interfering with your other work.

```
$ check_site http://example.com
```

**htstatus**

lookup the http status code by number to refresh your memory

Display the meaning of a single numeric status code

```
$ htstatus 200
```

Display all the http codes

```
$ htstatus
```

**parse_git_branch**

get the name of the Git branch you're on, and put it in parentheses. this is useful for putting your branch in the prompt. 

**sha1**

Create a SHA1 hash for a filename

```
$ sha1 filename.php
```

**traceurl**

Given a short URL, this will follow the redirects to the final destination.
It's not uncommon for one short URL to be directed to another. 


**wp_install**

Creat a new WordPress install in a directory. The database information is
prompted, to allow for customization. 


**wp_plugins**

Take a filename that contains a list of plugin slugs. Each slug should be on
its own line.


