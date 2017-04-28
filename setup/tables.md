```sql
CREATE TABLE "MRK_CLOB" (
  "MARKDOWN_PK" NUMBER GENERATED ALWAYS AS IDENTITY MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE  NOT NULL ENABLE, 
	"MARKDOWN_CLOB" CLOB, 
	CONSTRAINT "MARKDOWN" PRIMARY KEY ("MARKDOWN_PK")
  USING INDEX (CREATE UNIQUE INDEX "MARKDOWN_PK" ON "MRK_CLOB" ("MARKDOWN_PK")) 
  ) ;
```
# Code for updating the clob
```sql
update mrk_clob set
	markdown_clob = '
# Header 1
Lorem ipsum dolor sit *amet,* consectetur *adipiscing _elit_*. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa. Vestibulum lacinia arcu eget nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur sodales ligula in libero. 

## Header 2
Sed dignissim ~~lacinia~~ nunc. Curabitur tortor. Pellentesque nibh. Aenean quam. In scelerisque sem at dolor. Maecenas mattis. Sed convallis tristique sem. Proin ut ligula vel nunc egestas porttitor. Morbi lectus risus, iaculis vel, suscipit quis, luctus non, massa. Fusce ac turpis quis ligula lacinia aliquet. Mauris ipsum. Nulla metus metus, ullamcorper vel, tincidunt sed, euismod in, nibh. Quisque volutpat condimentum velit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. 

### Header 3
Nam nec ante. Sed **lacinia**, urna non tincidunt mattis, tortor neque adipiscing diam, a cursus ipsum ante quis turpis. Nulla facilisi. Ut fringilla. Suspendisse potenti. Nunc feugiat mi a tellus consequat imperdiet. Vestibulum sapien. Proin quam. Etiam ultrices. Suspendisse in justo eu magna luctus suscipit. Sed lectus. 

#### Header 4
Integer euismod lacus luctus magna. Quisque cursus, metus vitae pharetra auctor, sem massa mattis sem, at interdum magna augue eget diam. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Morbi lacinia molestie dui. Praesent blandit dolor. Sed non quam. In vel mi sit amet augue congue elementum. Morbi in ipsum sit amet pede facilisis laoreet. Donec lacus nunc, viverra nec, blandit vel, egestas et, augue. Vestibulum tincidunt malesuada tellus. Ut ultrices ultrices enim. Curabitur sit amet mauris. Morbi in dui quis est pulvinar ullamcorper. Nulla facilisi. 

##### H5
###### H6

Integer lacinia sollicitudin massa:
1. Cras metus. 
1. Sed aliquet 
3. risus a tortor. 
1. Integer id quam. 

Morbi mi. Quisque nisl felis:
* venenatis tristique, 
- dignissim in, 
+ ultrices sit amet, 
* augue. 

Proin sodales libero eget ante followed block quote. 

> Nulla quam. Aenean laoreet. Vestibulum nisi lectus, commodo ac, facilisis ac, 
> ultricies eu, pede. Ut orci risus, accumsan porttitor, cursus quis, aliquet eget, justo. 

```
10 begin

20 print "HELLO WORLD"

30 end
```

and now we need a table


| Tables        | Are           | Cool  |
| ------ |:-----:| -------:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |

Sed pretium blandit orci. Link to [Storm Petrel LLC](https://storm-petrel.com) Ut eu diam at pede suscipit sodales. 

Quisque cursus, metus vitae pharetra ![auctor](https://storm-petrel.com/wp-content/uploads/2016/05/tempest-gems-T-word-tag-250.gif), sem massa mattis sem, at interdum magna augue eget diam. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Morbi lacinia molestie dui. Praesent blandit dolor. Sed non quam. In vel mi sit amet augue congue elementum. Morbi in ipsum sit amet pede facilisis laoreet. Donec lacus nunc, viverra nec, blandit vel, egestas et, augue. Vestibulum tincidunt malesuada tellus. 

Ut ultrices ultrices enim. Curabitur sit amet mauris. Morbi in dui quis est pulvinar ullamcorper.

And other table with limited header stuff. All columns are left aligned

| Tables        | Are           | Cool  |
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |

eof'
```
