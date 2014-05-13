---
author: jamison
layout: post-no-feature
title: An Ember Canvas Component
description: "How to render data to a canvas element with Ember.js"
categories: coding
tags: [javascript, ember]
---

You want to render some data to a &lt;canvas&gt; tag. You are also using
[Ember](http://emberjs.com/). Boy do I have a blog post for you.

<aside>If you want the TL;DR, the final code is in a [JSBin](http://emberjs.jsbin.com/zetereka/4/edit).</aside>

Ember is optimized for the common case of rendering data to the DOM. If you
want to do something different, like render to &lt;canvas&gt;, Ember provides
a few hooks to do so.

First, let's make a basic app with a component. We grab the ember dependencies
and create a template for our component.


```html
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Ember Starter Kit</title>
  <link rel="stylesheet" href="http://cdnjs.cloudflare.com/ajax/libs/normalize/2.1.0/normalize.css">
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
  <script src="http://builds.handlebarsjs.com.s3.amazonaws.com/handlebars-v1.3.0.js"></script>
  <script src="http://builds.emberjs.com/tags/v1.5.0/ember.js"></script>
</head>
<body>

  <script type="text/x-handlebars">
    <h2> Welcome to Ember.js</h2>
    {{canvas-thing}}
  </script>
  <script type="text/x-handlebars" data-template-name="components/canvas-thing">
    Your browser doesn't support canvas. :(
  </script>
</body>
</html>
```


Notice the name is `"compontents/canvas-thing"`. Ember components must have a
dash in their name, and the template name must start with `component/`. See
the [components guide](http://emberjs.com/guides/components/defining-a-component/) for
more specifics on this.

The default HTML tag for a component is a &lt;div&gt;. Since we want to use a
&lt;canvas&gt; tag, we need to create a custom JavaScript class to override it.
This will come in handy later when we need to draw in it as well.

```
App = Ember.Application.create();


App.CanvasThingComponent = Ember.Component.extend({
  tagName: 'canvas',
  width: 100,
  height: 100,
  attributeBindings: ['width','height']
});
```

We create a component subclass, override the html tag, and set some default
attributes to control the element size. Again, pretty basic stuff.


## Draw me like one of your french components

An empty canvas element is pretty lame. We still haven't drawn anything. Ember
provides the [didInsertElement](https://github.com/emberjs/ember.js/blob/d6c3366c84d3bc793c12dd98aec65dd4a9437ca9/packages_es6/ember-views/lib/views/view.js#L1760)
hook, which will be called once our canvas is in the DOM. Let's implement it
to draw some stuff!


```
App.CanvasThingComponent = Ember.Component.extend({
  // other stuff elided
  didInsertElement: function() {
    var ctx = this.get('element').getContext('2d')
     ctx.fillStyle = "#000";
     ctx.fillRect(0, 0, this.get('width'), this.get('height'));
  }
});
```


You should see a black box on your screen. Take a moment now to stand up and
gaze triumphantly into the distance with your clenched fist raised over your
head, because you are awesome.


However, this isn't actually rendering any of your data. Worse, it won't update
when your data changes! Let's fix that.

## Updating when data changes

To update the component when data changes, we can just create a `draw` method
that draws the data, and observes the data. Looky here:

```
App.CanvasThingComponent = Ember.Component.extend({
  // other stuff elided
  didInsertElement: function() {
    // gotta set ctxf here instead of in init because
    // the element might not be in the dom yet in init
    this.set('ctx', this.get('element').getContext('2d'));
    this._empty();
    this.draw();
  },

  draw: function() {
    this._empty();
    var ctx = this.get('ctx');
    ctx.strokeStyle = '#DE28B3';
    console.log(this.get('data'));
    ctx.strokeText(this.get('data'), this.get('width')/4, this.get('height')/2);

    // draw some stars yo
    this._star(40, 40);
    this._star(300, 300);
    this._star(123, 250);
    this._star(320, 90);
  }.observes('data'),

  _empty: function() {
    var ctx = this.get('ctx');
    ctx.fillStyle = '#fff';
    ctx.fillRect(0, 0, this.get('width'), this.get('height'));
  },

  _star: function(x, y) {
    var radius = 20;
    var points = 5;
    var inset = 0.5;
    var ctx = this.get('ctx');

    ctx.save();
    ctx.beginPath();
    ctx.fillStyle = '#FAFF66';
    ctx.translate(x, y);
    ctx.moveTo(0,0-radius);
    for (var i = 0; i < points; i++) {
      ctx.rotate(Math.PI / points);
      ctx.lineTo(0, 0 - (radius*inset));
      ctx.rotate(Math.PI / points);
      ctx.lineTo(0, 0 - radius);
    }
    ctx.fill();
    ctx.restore();
  }
});
```

This got a little more complex, but the concepts are simple. We create a `draw`
method like we said. It draws the `data` as text, and then some sweet stars
for bling. The rest is cleanup and helper functions around this.

The important thing to note is the `.observes('data')` at the end of the `draw`
method. This calls `draw` whenever the data changes. We'll add a little input
helper to the application template to show this off.


```html
<script type="text/x-handlebars">
  <h2> Welcome to Ember.js</h2>
  {{canvas-thing data=someControllerStuff}}
  {{input placeholder="Type some swagtastic text" value=someControllerStuff}}
</script>
```

We grab the text from the input and send it in to the component. Watch how
it updates, and also sparkles. Pretty neat!

If you want to see the final thing in action, check out the
[JSBin](http://emberjs.jsbin.com/zetereka/4/edit). If you make it draw cooler
things than stars, like dinosaurs or laser beams or laser dinosaurs, please
let me know [@jergason](https://twitter.com/jergason).
