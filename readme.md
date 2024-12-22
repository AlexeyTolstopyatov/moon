# caton 
caton (Cat's object notation) is a markup language similar to many popular markup or notation languages (e.g. JSON, YAML, and others) which I once dreamed about, and it seemed like a very unusual idea to store and read data.

## Syntax
Inside caton, I've seen only four concepts, when I dreamed:
 - Sets
 - Lists
 - Properties 

Field - Type of element which contains single value (e.g. String, Integer number, Floating point number, Logical Flag)

Set - Type of element, which contains unlimited count of elements with unique names.

List - Type of element, which contains unlimited count of unnamed, indexed elements.

> List stores objects of only one type. List structure can store sets but structure of sets must be same!

Properties - Objects which can store only one of three previous types

## Syntax Internals
I decided to design simple toolkit using R programming language for Caton
and inside of this toolkit, Lexems defines as built-in types of expressionis

| in file | in toolkit     | description         |
|---------|----------------|---------------------|
| `()`    | `set_node`     | set declaration     |
| `[]`    | `list_node`    | list declaration    |
| `#`     | `comment_node` | comment (1 string)  |
| `*`     | `any_node`     | "all inclusive" mark|
| any word| `prop_node`    | property declaration|


All Properties includes themselves 2 parameters: `key` and `value`
Key is name of property itself
Value is object (one of three) concepts

## Examples
The most sweet part in repo are examples of syntax usage.

```
app=(
   # Applications configuration
   user="admin"       # Postgre secret file
   password="admin"   # host working at https://127.0.0.1:5432
   
   args=[
      # Usage of Lists as List<string>
      "--usessl";
      "--cert";
      "mycert.crt"
    ]
   
   settings=(
      # Usage of Sets as structures
      debug=true
      log_level="info"
      allowed_users=*
   )
   
   rules=[
      # Usage of Lists as List<Rule>
      # Lists can store the Sets but sets must be 
      (rule="disableTempAdm" flag: true);
      (rule="disableFindMe" flag: true)
   ]
)
```

# In Future
I want to add extentions like XSD schemas in XAML/XML
for more strict design of object's notation and Some instruments/frameworks for working with Caton marked up files.
