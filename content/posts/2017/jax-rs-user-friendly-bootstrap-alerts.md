---
title: "JAX-RS: Java Exceptions to User Friendly Bootstrap Alerts"
author: "Geoffrey Hayward"
date: 2017-05-10T11:00:00Z
categories:
- computing
tags:
- Bootstrap
- Java EE
- JavaScript
- JAX-RS
- JQuery
- JSON
- Knockout JS
---
When an exception is thrown server side it is often desirable to let the user know what went wrong. When working with JAX-RS it is surprisingly simple to send a user-friendly error responds. In this post I will show you how simple it can be.

<!--more-->

If you are reading this I assume you have some familiarity with JAX-RS (hopefully Java EE), Bootstrap, JQuery, and with a bit of luck Knockout JS. If you don't, well you soon will.

## JAX-RS Mapped Exceptions

With JAX-RS when an endpoint is called that results in an exception, the developer can map the exception to a response. You, the developer, map exceptions by implementing the ExceptionMapper generic. Here is an example:

```java
@Provider
public class ConnectExceptionMapper implements ExceptionMapper<ConnectException> {

    @Override
    public Response toResponse(ConnectException ex) {
        return Response
                .status(Response.Status.GATEWAY_TIMEOUT)
                .entity(new ErrorMessage("Connection Error", ex.getLocalizedMessage))
                .build();
    }
}
```


A Java EE application container uses the `@Provider` annotation to link-up the mapping. The response , in this example, sets a '504 Gateway Timeout' status, and takes an entity. The entity is an important element in this example; it will become the user-friendly error message.

The ErrorMessage entity is ordinary but I will include it for completeness.

```javas
@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement
public class ErrorMessage {
    
    private String title;
    private String body;

    public ErrorMessage() {
    }

    public ErrorMessage(String title, String body) {
        this.title = title;
        this.body = body;
    }

}
```


The `@XmlRootElement` is used by JAX-RS via JAXB to format the object. The response format in our case will be assumed as JSON. The format is usually determined by the subject JAX-RS endpoint using the `@Produces` annotation.

## The Web UI

Next you will need to create an HTML5 page. Add the following libraries: [Bootstrap](https://getbootstrap.com/getting-started/#download), [JQuery](https://jquery.com/download/), and [Knockout JS](http://knockoutjs.com/downloads/index.html).</p>

### The Knockout JS

Knockout JS is very lean; here is the only Knockout JS JavaScript that you need for this example (other than the binding):

```javascript
var ErrorMessagesViewModel = function () {
    this.list = ko.observableArray([]);
};
```

This JavaScript is a ViewModel that holds a list. The list is a Knockout JS `observableArray`, so that the error messages can be pushed onto the list. 

Next add the Knockout JS view. Knockout JS applies the `alert-template` to each item in the list.

```html
<div data-bind="template: { name: 'alert-template', foreach: list }">
    <!-- KO dynamic -->
</div> 
```

In this example I opted for a Knockout JS view template, as I do not like to see a 'flash' load. A 'flash' load would briefly show the view on a page loads then hide it.

Here is the 'alert-template':

```html
<script type="text/html" id="alert-template">
    <div class="alert alert-warning alert-dismissible" role="alert">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <strong data-bind="text: title"></strong>
        <br />
        <span data-bind="text: body"></span>
    </div>
</script>
```

The template is the closable Alert from Bootstrap. The message's title and body are the variables within the template.

Next we will construct the ViewModel and bind it.

```javascript
var messages = new ErrorMessagesViewModel();
ko.applyBindings(messages);
```

As you can see the constructed ViewModel is assigned to a variable named 'messages'. In the next section JQuery will use the 'messages' variable to push server error responses.

### The JQuery

JQuery's AJAX utility can catch global events. We are going to catch global error events. Here is the JQuery:

```javascript
$(document).ajaxError(function (event, response, settings, thrownError) {
     messages.list(response.responseJSON);
});
```

That's it, as long as you are using JQuery's AJAX utility, such as `$.getJSON` to send requests the JAX-RS mapped exceptions are pushed on to the list and shown to the users.

As an aside the solution in this example is an aspect, in the AOP sense. The `ErrorMessagesViewModel` is a modularisation of concern.

## Video Supplement

This post is an after the fact note on a solution from a project I am working on. So here is a video of this solution in action within the other project.

{{< youtube wWMgu18gPU8 >}}