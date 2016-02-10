This page shows a list of ant task currently available in the JS Build Tools package.

# preprocess #
The JS Build Tools package comes with a Javascript preprocessor engine. This Ant task processes statements like #ifdef, #ifndef or #endif.

## Parameters ##
  * infile - Input file to process.
  * outfile - Output file to write the processed contents to.
  * defines - Comma separated list of defined values to check for.

Here is an example on how to use the preprocessor in a JS file:
```
// #ifdef somevalue1

someFunction();

// #endif

// #ifndef somevalue1

someOtherFunction();

// #endif
```

Here is an example on how to use the preprocessor ant task in a build script:
```
<preprocess infile="file.js" outfile="file.processed.js" defines="value1,value2" />
```

The preprocessor enables you to include/exclude code depending in defined values. This is very useful if you want to for example remove all debug code when making a distribution package.

# yuicompress #

This task compresses the specified script using the YUICompressor package. The YUICompressor will remove all unneeded white space and obfuscate long variable names.

## Parameters ##
  * infile - Input file to compress.
  * outfile - Output file to write the compressed contents to.
  * charset - Charset to use when writing the compressed contents.
  * munge - Should we munge function/variable names.
  * warn - Present warning messages to the user regarding the code.
  * preserveAllSemiColons - Preserve semicolons in order to run it through jslint.
  * optimize - Optimize the JavaScript code.

Here is an example on how to use the yuicompressor ant task in a build script:
```
<yuicompress infile="file.js" outfile="file.min.js" />
```

# moxiedoc #

This task generates documentation for JavaScript projects by parsing special [MoxieDoc comments](http://code.google.com/p/js-build-tools/wiki/MoxieDocTags). This is very similar to how JavaDoc functions.

## Parameters ##
  * templatedir - Location where moxiedoc can find the xsl templates.
  * outdir - Output directory where the documentation is to be generated.
  * msintellisense - (Optional) File path to where the MS IntelliSense file will be generated. This is a js file with stub data.

Here is an example on how to use the yuicompressor ant task in a build script:
```
<moxiedoc outdir="docs\api" msintellisense="docs\apitinymce.vsdoc.js" templatedir="tools\templates">
    <fileset dir="jscripts\tiny_mce\classes">
        <include name="**/*.js" /> 
    </fileset>
</moxiedoc>
```

Using the MS IntelliSense file in Visual Studio. Add this to your ASPX file after the script that you are using in the case below TinyMCE.
```
<!-- Removes the script from page output -->
<% if (false) { %>
   <script type="text/javascript" src="tinymce.vsdoc.js"></script>
<% } %>
```

There is an example build.xml file that comes with the package. This file displays how to use the ant tasks.