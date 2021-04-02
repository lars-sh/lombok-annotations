# Lombok Annotations
This project packages the annotations of [Project Lombok](https://projectlombok.org/) as separate JAR to improve compiling and handling Java sources generated by [Delombok](https://projectlombok.org/features/delombok).

[Changelog](CHANGELOG.md)  |  [JavaDoc](https://lars-sh.github.io/lombok-annotations/apidocs)  |  [Generated Reports](https://lars-sh.github.io/lombok-annotations/project-reports.html)

## Getting started
Lombok Annotations are meant to be used in conjunction with Delombok and **without** Project Lombok.

```XML
<dependency>
	<groupId>de.lars-sh</groupId>
	<artifactId>lombok-annotations</artifactId>
	<version><!-- TODO --></version>
	<scope>provided</scope>
</dependency>

<plugin>
	<groupId>org.projectlombok</groupId>
	<artifactId>lombok-maven-plugin</artifactId>
	<version><!-- TODO --></version>
	<executions>
		<execution>
			<goals>
				<goal>delombok</goal>
				<goal>testDelombok</goal>
			</goals>
		</execution>
	</executions>
</plugin>
```

## Rationale

### At its simplest
Project Lombok can be used by adding its dependency at compile time.

Here's how the Maven dependency looks like:

```XML
<dependency>
	<groupId>org.projectlombok</groupId>
	<artifactId>lombok</artifactId>
	<version><!-- TODO --></version>
	<scope>provided</scope>
</dependency>
```

### You can further improve this
The Java sources compiled differ from your sources and highly depend on Project Lomboks version and *magic*.

Though you might need the correct Java sources. For yourself to understand what's going on, for debugging purposes, for documentation or even for revision control.

Therefore keep your Maven dependency and add the [Lombok Maven Plugin](https://awhitford.github.io/lombok.maven/lombok-maven-plugin/) to execute Delombok on your sources.

```XML
<plugin>
	<groupId>org.projectlombok</groupId>
	<artifactId>lombok-maven-plugin</artifactId>
	<version><!-- TODO --></version>
	<executions>
		<execution>
			<goals>
				<goal>delombok</goal>
				<goal>testDelombok</goal>
			</goals>
		</execution>
	</executions>
</plugin>
```

The plugin runs Delombok on your sources, places the resulting Java sources at `target/generated-sources/delombok` and tells Maven to compile those.

### Fine until here, right?
**No!** The Lombok Maven Plugin is alright, but as Project Lombok is still part of your dependencies, it registers itself when compiling and processes the generated sources a second time.

That reduces compiling performance and might modify your sources even further. Take a look at `demos/demo-2-delombok-and-lombok` as an example:

1. Run "mvn package". The build process fails. Don't hesitate, that's the correct behavior!
2. Delombok was executed just as expected. You can verify this yourself.
3. Even though the compilation fails, as `demoField` is missing the `@NonFinal` annotation.

Note: This demo makes use of `lombok.fieldDefaults.defaultFinal=true` inside `lombok.config`.

### Here we go!
Therefore simply replace the dependency to Project Lombok with the one for Lombok Annotations as done at Getting started. No magic, no more than that.

Using Lombok Annotations does not load Project Lomboks logic implicitly, while the Lombok Maven Plugin / Delombok and the Eclipse plugin still do their work as expected.
