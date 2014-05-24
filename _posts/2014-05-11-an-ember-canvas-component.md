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


<script src='https://gist.github.com/anonymous/89fd59649a8e856e700e.js'></script>

Notice the name is `"compontents/canvas-thing"`. Ember components must have a
dash in their name, and the template name must start with `component/`. See
the [components guide](http://emberjs.com/guides/components/defining-a-component/) for
more specifics on this.

The default HTML tag for a component is a &lt;div&gt;. Since we want to use a
&lt;canvas&gt; tag, we need to create a custom JavaScript class to override it.
This will come in handy later when we need to draw in it as well.

<script src='https://gist.github.com/anonymous/0f783177017b60096814.js'></script>

We create a component subclass, override the html tag, and set some default
attributes to control the element size. Again, pretty basic stuff.


## Draw me like one of your french components

An empty canvas element is pretty lame. We still haven't drawn anything. Ember
provides the [didInsertElement](https://github.com/emberjs/ember.js/blob/d6c3366c84d3bc793c12dd98aec65dd4a9437ca9/packages_es6/ember-views/lib/views/view.js#L1760)
hook, which will be called once our canvas is in the DOM. Let's implement it
to draw some stuff!


<script src='https://gist.github.com/anonymous/6fa8cc1b494e360bc05d.js'></script>


You should see a black box on your screen. Take a moment now to stand up and
gaze triumphantly into the distance with your clenched fist raised over your
head, because you are awesome.


However, this isn't actually rendering any of your data. Worse, it won't update
when your data changes! Let's fix that.

## Updating when data changes

To update the component when data changes, we can just create a `draw` method
that draws the data, and observes the data. Looky here:

<script src='https://gist.github.com/anonymous/6755560b28a16af654ed.js'></script>

This got a little more complex, but the concepts are simple. We create a `draw`
method like we said. It draws the `data` as text, and then some sweet stars
for bling. The rest is cleanup and helper functions around this.

The important thing to note is the `.observes('data')` at the end of the `draw`
method. This calls `draw` whenever the data changes. We'll add a little input
helper to the application template to show this off.

<script src='https://gist.github.com/anonymous/ce353cbacdcb177c762f.js'></script>

We grab the text from the input and send it in to the component. Watch how
it updates, and also sparkles. Pretty neat!

Behold the final result:

<a class="jsbin-embed" href="http://emberjs.jsbin.com/zetereka/4/embed?output">Ember Starter Kit</a><script src="http://static.jsbin.com/js/embed.js"></script>

If you make it draw cooler things than stars, like dinosaurs or laser beams or
laser dinosaurs, please let me know [@jergason](https://twitter.com/jergason).
