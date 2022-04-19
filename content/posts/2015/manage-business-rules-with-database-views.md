---
title: "Manage Business Rules With Database Views"
author: "Geoffrey Hayward"
date: 2015-06-09T11:00:00Z
categories:
- computing
tags:
- Software Engineering
---
Whilst fixing a defect in this blog's platform (now the prior platform) I realised that a particular business rule could be moved out of the code; into a database view. The movable business rule was "All posts returned to the front-end should have a published state". This rule extends to include all post's tags. That is "only the tags of a published post should appear in tag summaries".

<!--more-->

One way to add this business rule would be to preform a `WHERE published = true` check in each respective query. The check would be executed by the database but is declared in the code. The declaration of the check is also in many places. I found it is particularly easy to forget to declare the check when joining tables. In the case of the tag summaries the check got over looked in a join between tags and posts.

Another way to add this rule to the platform would be to create a database view that encompasses the rule. Each query that has the aspect would then use the view. The business rule is then given once, declared and executed in the database. The join between tags and posts would then be:

```sql
SELECT *
FROM tags t
JOIN published_posts p
[...]
```

Where `published_posts` is a database view; not a table.

So that's what I did.
