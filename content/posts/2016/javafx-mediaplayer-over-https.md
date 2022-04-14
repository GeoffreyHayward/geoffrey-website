---
title: "JavaFX MediaPlayer over HTTPS"
author: "Geoffrey Hayward"
date: 2016-04-06T11:00:00Z
categories:
- computing
tags:
- HTTPS
- Java SE
- JavaFX 8
- MediaPlayer
---
I have been trying to get the JavaFX MediaPlayer to play MP3s. Each of the MP3s, that I have been trying to play, are being retrieved over HTTPS. The `java javafx.scene.media.Media` class does not support the HTTPS protocol.

<!--more-->

To workaround this problem meant temporarily storing the MP3 on the local disk. And then playing the MP3 from the temporary disk location.

```java
URL url = new URL("https://resource.track.mp3");
        
Path mp3 = Files.createTempFile("now-playing", ".mp3");
        
try (InputStream stream = url.openStream()) {
    Files.copy(stream, mp3, StandardCopyOption.REPLACE_EXISTING);
}

Media media = new Media(mp3.toFile().toURI().toString());
MediaPlayer mediaPlayer = new MediaPlayer(media);
mediaPlayer.play();
```

Do you know of a better solution or workaround that will skip the need to write to disk when the media file is retrieved over HTTPS? Message me if you do.

I hope this post helped you.
