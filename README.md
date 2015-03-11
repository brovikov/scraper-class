# scraper-class
Simple scraper class for store web page to local file (incl. images, CSS, JavaScript)

But it is a simple method, and it will not find:

* scripts or CSS loaded dynamically by JavaScript (creating elements and appending them to the document)
* images requested by JavaScript, e.g. var img = new Image; img.src="...";
* CSS linked from CSS, e.g. @import url(foo.css);
* Images referenced by CSS, e.g. #nav { background:url(/images/navhead.png) }

Let me know please our goal for this task, how it will use? It will help me improve it.
