# MoxieDoc comment tags #

MoxieDoc uses Javadoc style comments to generate HTML documentation and IntelliSense files. Since JavaScript is such a dynamic language it's very hard to parse out the member names for classes it's also useful if you want to add documentation for psuedo classes that helps the user to impelement specific interfaces but there isn't really any code. So a difference between MoxieDoc and other common documentation tools like JavaDoc is that you need to specify what each item is and the name of it.

## Example of MoxieDoc comment ##
```
/**
 * Pointless function that returns a hello string.
 *
 * @method someMethod
 * @param {String} arg1 Some pointless argument.
 * @param {String} arg1 Some other pointless argument.
 * @return {String} Some return value.
 */
someClass.prototype.someMethod = function(arg1, arg2) {
   return "Hello;
}
```

## Type tags ##
Since MoxieDoc only parses comments type tags are required for all documentation blocks. All type tags requires you to specify a name after them. For example "@class MyClass".

| **Tag** | **Details** |
|:--------|:------------|
| [class](http://code.google.com/p/js-build-tools/wiki/ClassTag)    | Specifies that the item is a class. |
| [event](http://code.google.com/p/js-build-tools/wiki/EventTag)    | Specifies that the item is an event of the current class. |
| [method](http://code.google.com/p/js-build-tools/wiki/MethodTag)   | Specifies that the item is a method of the current class. |
| [property](http://code.google.com/p/js-build-tools/wiki/PropertyTag) | Specifies that the item is an property of the current class. |

## Optional tags ##
There are a few other tags that are needed in special situations for example when a class extends another class.

| **Tag** | **Details** |
|:--------|:------------|
| [author](http://code.google.com/p/js-build-tools/wiki/AuthorTag)            | Enables you to specify an author for a class or member. |
| [constructor](http://code.google.com/p/js-build-tools/wiki/ConstructorTag)  | Specifies that the method is a contructor. |
| [deprecated](http://code.google.com/p/js-build-tools/wiki/DeprecatedTag)    | Specifies that the member or class is old and shouldn't be used. |
| [example](http://code.google.com/p/js-build-tools/wiki/ExampleTag)          | Generates an example of usage. |
| [extends](http://code.google.com/p/js-build-tools/wiki/ExtendsTag)          | Enables you to specify an inheritance between two classes. |
| [member](http://code.google.com/p/js-build-tools/wiki/MemberTag)            | Enables you to specify that the member if part of another class. |
| [see](http://code.google.com/p/js-build-tools/wiki/See)            | Enables you to reference other classes/members. |
| [static](http://code.google.com/p/js-build-tools/wiki/StaticTag)            | Sets that the member or class is static. |
| [type](http://code.google.com/p/js-build-tools/wiki/TypeTag)                | Specifies the property type. |
| [version](http://code.google.com/p/js-build-tools/wiki/VersionTag)          | Enables you to set a version number when the item was introduced. |