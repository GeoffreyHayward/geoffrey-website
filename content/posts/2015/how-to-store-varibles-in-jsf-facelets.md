---
title: "How to Store Variables in JSF Facelets"
author: "Geoffrey Hayward"
date: 2015-09-07T11:00:00Z
categories:
- computing
tags:
- EJB
- Facelet
- JSF
---
JSF Facelets can store the returned value yielded from a call to an EJB. Doing so will mean the EJB does less work.

<!--more-->

Let's say you are implementing a Facelet that will display a message stating something like 'No results' when a collection is empty. If the collection is not empty, the Facelet will call the EJB a second time. First to calculate the size of the collection; second to display the data in the collection etc.


Here is an example:

```xml
<ui:fragment rendered="#{pages.all().size() == 0}" >
    <h:outputText value="No pages yet." />
</ui:fragment>
            
<ui:fragment rendered="#{pages.all().size() > 0}" >
    <h:dataTable value="#{pages.all()}" var="page">
        <!-- display the data -->
    </h:dataTable>
</ui:fragment>
```

In the example above the Facelet calls the EJB three times. First to calculate the size of the collection; second to display the elements the data table will occupy; third the data from the collection.

## How to Store Values in JSF Facelets

The calling to the EJB can be reduced to just once per page render. Calling the backing bean using the `ui:param` JSF element will store the returned value in a variable.

```xml
<f:metadata>
   <ui:param name="pageSet" value="#{pages.all()}" />
</f:metadata>
```

Using the `ui:param` JSF element, here is an improved example:

```xml
<f:metadata>
  <ui:param name="pageSet" value="#{pages.all()}" />
</f:metadata>

<ui:fragment rendered="#{pageSet.size() == 0}" >
    <h:outputText value="No pages yet." />
</ui:fragment>
            
<ui:fragment rendered="#{pageSet.size() > 0}" >
    <h:dataTable value="#{pageSet}" var="page">
        <!-- display the data -->
    </h:dataTable>
</ui:fragment>
```

I hope this helps.