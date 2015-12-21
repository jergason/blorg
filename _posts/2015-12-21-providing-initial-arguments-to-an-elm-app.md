---
author: jamison
layout: post-no-feature
title: Providing initial values to an Elm app
description: ""
published: true
---

[Elm](http://elm-lang.org/) is a functional programming language that runs in
the browser, and using it is the most fun I've had programming in years.

Recently I was trying to figure out how to provide initial values to an
application, and was doing horrible things with signals and ports. However, Elm
already provides a way to pass values from JavaScript to Elm when the app
starts.

To embed an Elm app on the page, you call `Elm.embed` (or `Elm.fullscreen` if
you aren't embedding the app inside a div, or `Elm.worker` if you don't want it
to render UI at all). The [docs](http://elm-lang.org/guide/interop) claim that
`Elm.embed` takes two arguments: the Elm app you want to embed, and a DOM node
to embed it in.

As of Elm 0.16, `Elm.embed` actually takes three arguments. The third argument
is an map of keys to initial values. If you create ports in Elm that match the
keys you provided to the object, you can pull in these initial values in to
your Elm app. Here is an example to make this more clear.


In the JavaScript, just pass in an object to `Elm.embed`:


```JavaScript
import Elm from './src/Main.elm'

const container = document.querySelector('.app')
const elmApp = Elm.embed(Elm.Main, container, {getStartTime: Date.now()})
```


In the Elm side, make a port to handle it:


```Haskell
import Graphics.Element exposing (show)
import Time exposing (Time)

main = show model

model : Time
model = getStartTime

-- This port will have the value we passed to Elm.embed
port getStartTime : Time
```
