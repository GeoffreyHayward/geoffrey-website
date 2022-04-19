---
title: "GREP with a Negative Lookbehind"
author: "Geoffrey Hayward"
date: 2016-05-27T11:00:00Z
categories:
- computing
tags:
- GREP
- Regular Expression
---
This is a note on a simple regular expression to GREP for exceptions in a group of log files.

I have been debugging an issue unsure of what to look for. Of course 'Exception' on its own is not a great search term. Using a negative look-behind made the difference in trying to narrow down on what to look for. The look-behind made it possible to rule out the name of some of the exceptions that are not important to the issue at hand.

```text
(?<!Faces|FileNotFound|Configuration)Exception
```
