
# Web Developer Checklists

This list should be a table to contents with jump links

* Operations



## Operations

### Make sure users can't read your .git folder

Load http://example.com/.git in your browser. If it loads you have a few options.
	
* Change permissions on .git

	```
	$ chmod o-rwx .git
	```
This will prevent the user from reading your .git folder
	but returns at 403 error. So now they know it exists, even though
	they can't read it.

* Turn off Indexes in your .htaccess

	```
	Option -Indexes	
	```
	
* Add this line to your .htaccess

	```
	RedirectMatch 404 /\.git
	```
	
	This returns a 404 error, which tells the user it's not found, or "it doesn't exist"

### Add a robots.txt to your website root

On a **staging or development** environment, this should block search engines, so your development site doesn't get indexed. 

On **production**, ensure it's no longer denying search engines

### Add a humans.txt to your website root

Let people know who contributed to the development of the website
Learn more about it from [HumansTXT](http://humanstxt.org/) 

### 404 Error Page

Create a useful error page to help your website visitor

### XML Sitemap

create an XML Sitemap to tell search engines about the structure of your website. 

### Check for Broken Links

### Check Directory Permissions

### Code Validation

Validate your HTML and CSS. Correct code ensures a smoother experience.

### Image Optimization

Compress your images, and combine them when possible (CSS Sprites)

### Optimize your JS and CSS files for performance

* Use only what you need &mdash; Are you *really* using all those frameworks?
* Combine multiple files into single file to reduce HTTP requests
