It's fairly easy to use these tools inside Ant. You need to load them I usually use a path element to enable me to load them from a location outside the ant directory.

# Usage example inside an ant build.xml #
```
<!-- Setup classpath for js-build-tools ant tasks -->
<path id="tasks.classpath">
    <pathelement location="."/>

    <fileset dir="tools/ant">
        <include name="**/*.jar"/>
    </fileset>
</path>

<!-- Register new js-build-tools ant tasks -->
<taskdef name="preprocess" classname="com.moxiecode.ant.tasks.PreProcessTask" classpathref="tasks.classpath" loaderref="tasks.classpath.loader" />
<taskdef name="yuicompress" classname="com.moxiecode.ant.tasks.YuiCompressTask" classpathref="tasks.classpath" loaderref="tasks.classpath.loader" />
<taskdef name="moxiedoc" classname="com.moxiecode.ant.tasks.MoxieDocTask" classpathref="tasks.classpath" loaderref="tasks.classpath.loader" />

<target name="moxiedoc">
    <moxiedoc outdir="docs\api" templatedir="tools\templates">
        <fileset dir="jscripts\tiny_mce\classes">
            <include name="**/*.js" /> 
        </fileset>
    </moxiedoc>
</target>
```