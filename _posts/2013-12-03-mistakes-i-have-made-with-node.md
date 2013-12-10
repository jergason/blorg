---
layout: post-no-feature
author: jamison
title: Mistakes I Have Made With Node Web Apps
description: "I have done things. Things I'm not proud of. Learn from my mistakes."
published: false
category: articles
tags: [node, javascript]
---

I have been working with [node.js](http://nodejs.org/) in private and in
production since 2011. Node is great, but it is still possible to shoot
yourself in the foot with it. My foot is scarred with bullet wounds. A wise
developer learns from other's mistakes. Hopefully some of you gain wisdom from
my mistakes.

## Don't Block The Event Loop
```
You find youself in an ancient temple of unknown religion.
In the room is a large ALTAR inscribed with text.
To the WEST you see a entrance hall.
To the NORTH you see a spacious bathroom.

> read altar

HERE LIES JAMISON DANCE, WHO ONCE BLOCKED THE EVENT LOOP AND THEN DIED
```

WHAT AM I TRYING TO SAY

do i/o, your stuff goes to sleep automatically, get notification when i/o
is done and node starts running your stuff again.

One of node's best features is [non-blocking I/O](wikipedia entry) by default.
In most web apps, most of the time is spent waiting on I/O (citation needed).
When node does some I/O (reading from a db, making a network request, etc), it
will put that thread to sleep and process other requests. This is great
meansInstead of waiting and preventing other clients from being served, node will
yeild to the event loop whenever it does I/O

This works really well UNLESS you do long-running calculations without yeilding
the event loop. This blocks the loop so nothing else can be processed.

## Don't Serve Static Files With Node
Serving static files in node is pretty convenient. In
[express](http://expressjs.org) is is a one-liner:

```javascript
app.use(express.static(__dirname + '/public'))
```

If express isn't your thing there are [tons]() [of]() [modules]() that serve
static files. If you are building a backend in node, why not serve files from
node too? I will answer that question with the power of SLIGHTLY SKETCHY
BENCHMARKS!

Imagine a simple express app that looks like this:

```javascript
var path = require('path')
var express = require('express')
var app = express()


app.use(express.static(path.join(__dirname, 'public')))

app.get('/hurp', function(req, res, next) {
  // simulate db call or something
  setTimeout(function() {
    res.json({success: true, data: 'BE EXCELLENT TO EACH OTHER'})
  }, 200)
})

app.post('/hurp', function(req, res, next) {
  // simulate some I/O
  setTimeout(function() {
    res.send(req.body)
  }, 200)
})

app.listen(1338) // EVEN MORE L33T
```

It accepts POST and GET requests at `/hurp` and serves static files from a
`/public` directory. It also eschews semicolons for RAW SPEED. Let's run some
simple load tests with [`ab`](apache benchmark).
