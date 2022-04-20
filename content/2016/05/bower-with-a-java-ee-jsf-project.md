---
title: "Bower with a Java EE JSF Project"
author: "Geoffrey Hayward"
date: 2016-05-19T11:00:00Z
categories:
- computing
tags:
- Bower
- GIT
- Java EE
- JSF
---
I have been experimenting with the [Twitter Bower package manager](https://bower.io/) as part of the tech stack to be used with a Java EE JSF project.

<!--more-->

This post is a note on how I set up the Web Application project to use the Bower package manager.

I began by setting up a new Mavan Web Application. I used the NetBeans 'New Project' wizard. Once the new Web Application project was created I added JavaServer Faces to the project via NetBeans' **Properties > Framework** menu.

Next I added a `.bowerrc` file to the root of the webapp as:

```json
{
  "directory": "resources/components"
}
```

This `.bowerrc` file changes the default location that Bower will store the components it downloads. This change made Bower fit with a Mavan Web Application folder structure. Next I added a `bower.json` file to the root of the webapp.

```json
{
  "name": "bower-setup-test",
  "authors": [
    "Geoffrey Hayward"
  ],
  "private": true
}
```

The `bower.json` file keeps a record of each dependency and its version that is added to the project. See the [bower.json](https://github.com/bower/spec/blob/master/json.md) spec for details.

Then from the root of the webapp I ran the command: `bower install bootstrap --save`. The `--save` saved the dependency to bower.json file.

Why Bower? Good question. To reduce the size of the tracked GIT repository and to make the web component libraries explicit. Each time a file is forked from the dependency, such as a bootstrap LESS variables file, you add it to the `bower.json` ignore property. Likewise you then begin tracking the forked file in GIT. Everything that is managed by Bower (that is not forked) is in (or should be in) the `.gitignore` file.

## My Thoughts: Post Experiment

My thoughts to using Bower with a Java EE JSF project are Bower adds complexity to a Java EE JSF project that may not bring any value. But, with that said Bower certainly would come in handy for a front-end framework heavy project; particularly when some control over what should and should not be edited is needed. In other words I am undecided for now, but have no plans to start using Bower just yet in this context.
