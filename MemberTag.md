# Tag: @member #

The member tag can be used to tell that a specific method/property/event is part of a specific class. For example if there is a method that gets added later on in a separate file.

## Example of member tag ##
```
/**
 * This method is static. 
 *
 * @method someMethod
 * @member someNameSpace.someClass
 */
someNameSpace.someClass.someMethod = function() {
};
```