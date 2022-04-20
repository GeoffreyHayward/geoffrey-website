---
title: "Character Replace with Apache Module mod_rewrite"
author: "Geoffrey Hayward"
date: 2014-04-09T11:00:00Z
categories:
- computing
tags:
- mod_rewrite
- Regular Expression
- RewriteRule
---
Using Apache Module mod_rewrite to do a character replace is a little fiddly. It's particularly fiddly when you need to send back a single 301 redirect. But, it's not impossible.

## mod_rewrite Underscores to Hyphens

In this solution all underscores are replaced with hyphens before the final 301 redirect is sent to the browser.

```text
RewriteRule ^(.*)_(.*)$ $1-$2 [N,E=redirect:true]
RewriteCond %{ENV:redirect} ^true$
RewriteRule (.*) $1 [R=301]
```

The solution I created above looks for a match that includes anything either side of an underscore plus an underscore. Both sides of the underscore are captured at the same time. At the end of the match the capture groups are put back together, this time with a hyphen between them. The 'N' flag indicates to mod_rewrite that the rewrite rules should be run agents the subject all over again. The subject is changed to reflect the last run before it's re-evaluated. This rerunning continues until there are no more matches.

<!--more-->

Unfortunately, you cannot just add the 'R' redirect flag to the end of the rewrite rule akin to this:

```text
RewriteRule ^(.*)_(.*)$ $1-$2 [N,R=301]
```

In this shorter unfit solution the 'R' flag is evaluated and the redirect is sent before the rewrite rule can be rerun. Therefore for each replaceable character a redirect is sent back over and over until all the characters have been replaced. This will create needless round trips between the client and the server.

The redirect 'R' flag cannot be on the same line as the 'N' flag in order for the 'N' flag to do its job. Therefore, the 'R' flag needs to follow another rewrite rule in order for the redirect to be sent back only once. The problem is there actually is no more rewriting to be done. The following rewrite rule works as anything will match the pattern triggering the 'R' flags function to send a redirect.

```text
RewriteRule (.*) $1 [R=301]
```

However, having this rewrite rule on its own will make all requests that are filtered via this set of rules (.htaccess file etc.) redirect. Consequently, a rewrite condition needs to prevent all other request from being redirected and only allowing redirects where a character has been replaced in the main rewrite rule.

Using the 'E' flag allows you to set an environment variable. In this case the environment variable is set after the 'N' flag. It is set for each time the rewrite rule is run: don't forget the last run will not match as all replacements have completed.

The variable in my solution is named 'redirect' and given a String value of true. The solution uses the environment variable as a means to prevent or trigger the 'match all' rewrite rule so that the redirect can be sent back appropriately.