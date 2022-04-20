---
title: "Issue Clearing a JavaFX 8 ComboBox"
author: "Geoffrey Hayward"
date: 2015-06-03T11:00:00Z
categories:
- computing
tags:
- Java SE
- Java Tip
- JavaFX 8
---
Some context: I'v just been bug fixing a JavaFX 8 application. The application has a JavaFX ComboBox that lets a user select a file name from a list. When a selection is made the file is read into a TextBox. This functionality worked fine until a clear button's event was added to the same controller.

<!--more-->

```java
@FXML
public void clear(ActionEvent event) {
    [...]
    myCombobox.getSelectionModel().clearSelection();
}
```

When a JavaFX ComboBox is cleared with `.getSelectionModel().clearSelection()` the `onAction` events of the ComboBox is called. This makes it important to null check within the `onAction` event.

```java
@FXML
public void selected(ActionEvent event) {
    if (myCombobox.getValue() != null) {
        [...]
    }
}
```

To conclude: If the <em>onAction</em> event of a ComboBox uses the ComboBox's value within the event it pays to null check the ComboBox's value.
