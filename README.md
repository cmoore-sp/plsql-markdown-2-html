# plsql-markdown-2-html
This PL/SQL package includes functions that convert Markdown to HTML. The markdown text is presented via CLOB/VARCHAR2 and return in the same datatype. I just could not find a PL/SQL package that addressed this issue for me.

My vision for this tool is use in Oracle APEX and letting application users create relatively straight forward HTML pages. I also made the assumption that I'd be happy with the 32K text limit allow the tool to use the APEX Utility for reading text (apex_util.string_to_table). It might be fair to expand the package to includes that exceed 32K.

## Limitations
### CLOB Size < 32K
CLOB that exceed 32K will not be processed unless we (collectively) write include a CLOB parser.

### Lists not nested
UL/OL lists are treated as flat. It is not possible with this code to nest lists.

### Issue with underscore in link URL
There maybe an issue with underscores inside a link's URL.

## Variations
In the code there are some variations for accommodating newline codes (cr, crlf). With a quick code change, or a new parameter, you can opt to return text with HTML breaks or cr or crlf. 

# Markdown Guidance
I used Adam Pritchard's Markdown guidance as a template for the Markdown to work from. There are some variations. 
A link to his document is [here](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet). 

A tip-of-the-hat to [Johnny Broadway](https://gist.github.com/jbroadway/2836900#file-slimdown-php) for some helpful suggestions on `regexp` for markdown. Thank you Johnny. 

# Documentation
To play, I created a simple table with a primary key and a clob field. I tossed my markdown text into the clob with SQL developer and run the code. I've included a sample of the calling code in the package. The functions are overloaded to accommodate both clob and varchar2.

As a coder, I am far happier writing PL/SQL then anything in regexp. I can document and read PL/SQL phrases. A reader may notice a blending of approaches. I would rather write more and get clarity and simplify debugging then have code that is so dense you can't see errors. 
