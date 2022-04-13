---
title: "Maven: Packaging Dockerfile's with variables"
author: "Geoffrey Hayward"
date: 2018-10-03T11:00:00Z
categories:
- computing
tags:
- AWS
- Docker
- Dockerfile
- Elastic Beanstalk
- Maven
---
This post is a note on using Maven's `maven-antrun-plugin` to replace a variable version number in a Dockerfile with the 
Maven project's version.

<!--more-->

The following code replaces this line `ADD ./target/application-@{version}.jar application.jar` in a Dockerfile with 
something like `ADD ./target/application-1.2.0-SNAPSHOT.jar application.jar`. The processed Dockerfile is then saved in 
the target folder alongside any other artifacts created by Maven.

```xml
<plugin>
    <artifactId>maven-antrun-plugin</artifactId>
    <version>1.8</version>
    <executions>
        <execution>
            <phase>package</phase>
            <configuration>
                <target>
                    <copy file="Dockerfile" todir="${project.build.directory}"/>
                    <replace file="${project.build.directory}/Dockerfile" >
                        <replacefilter token="@{version}" value="${project.version}" />
                    </replace>
                </target>
            </configuration>
            <goals>
                <goal>run</goal>
            </goals>
        </execution>
    </executions>
</plugin>
```

Once the Dockerfile has been processed a tool such as the Maven 'maven-assembly-plugin' can then package the Dockerfile and other artifacts into a shippable form.

For completeness, here is an example configuration that creates a shippable ZIP ready for AWS's Elastic Beanstalk.

```xml
<plugin>
    <artifactId>maven-assembly-plugin</artifactId>
    <version>3.0.0</version>
    <executions>
        <execution>
            <id>make-zip</id>
            <phase>package</phase>
            <goals>
                <goal>single</goal>
            </goals>
        </execution>
    </executions>
    <configuration>
        <appendAssemblyId>false</appendAssemblyId>
        <descriptors>
            <descriptor>assembly.xml</descriptor>
        </descriptors>
    </configuration>
</plugin>
```

And here is the corresponding example of the 'filesSets' element from an assembly.xml.

```xml
<fileSets>
    <fileSet>
        <directory>${project.build.directory}</directory>
        <includes>
            <include>${project.build.finalName}.jar</include>
        </includes>
        <outputDirectory>target</outputDirectory>
    </fileSet>
    <fileSet>
        <directory>${project.build.directory}</directory>
        <includes>
            <include>Dockerfile</include>
        </includes>
        <outputDirectory>.</outputDirectory>
    </fileSet>
    <fileSet>
        <directory>${basedir}</directory>
        <includes>
            <!-- other stuff from the base directory -->
        </includes>
        <outputDirectory>.</outputDirectory>
    </fileSet>
</fileSets>
```

I hope this helps you.
