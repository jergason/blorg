---
author: jamison
layout: post
title: How To Learn Technical Things
description: ""
published: true
---


I see developers, especially juniors, stress about learning new things. Often
they compare themselves to a developer who already knows what they are
learning and they feel like they come up short. I do this to myself, and I know
how frustrating and demotivating it can be.

The people that know the concept you are learning went through the same process
that you are going through - often multiple times - to get where they are
today.

The actual mechanics of learning are the same for everyone: you poke around,
you push the edges of what you know, you make mistakes, you do dumb things, you
struggle to understand, you apply it to problems you are interested in, and
knowledge grows over time.

Some developers seem to be better at learning new things than others. This
feels loosely correlated with experience, but experience isn't the only factor.
What techniques does a skilled learner use? Here are a few ideas shaped by my
own experience and observations.

## Make mistakes

Good learners make mistakes. Mistakes are key to exploring the boundaries of
your knowledge and discovering where your assumptions are incorrect.  Everyone
makes mistakes when learning, but the best learners make those mistakes *fast*.
They aren't afraid of breaking things or doing things wrong - they relish it.
By breaking things, they figure out how to fix them. By doing things
wrong, they learn the right way.

One of my favorite examples of this is [Julia Evans' blog
posts](http://jvns.ca/). She is amazing at diving deeply into things that are a
bit intimidating to me, like [the Linux
kernel](http://jvns.ca/blog/2014/01/04/4-paths-to-being-a-kernel-hacker/), [the
Java GC](http://jvns.ca/blog/2016/01/03/java-isnt-slow/), or cool things you
can do with
[strace](http://jvns.ca/blog/2016/05/06/a-workshop-on-strace-and-tcpdump/). Her
blog posts are often stories of her explorations with some new system concept,
including all the things she tried that didn't work or all the things that went
wrong. The posts usually end up with a list of things that she learned, and I
learn things from reading them.


## Ask questions

Asking a question exposes your lack of knowledge. This can be intimidating, You
are admitting that you don't know something, which can feel a lot like exposing
a weakness.  Despite being scary, asking questions is a great way to expose
fundamental misunderstandings or make you aware of unknown unknowns.

My friend [Aimee Knight](http://www.aimeemarieknight.com/) is a great example
of this. She keeps a list of questions on a piece of paper. Every week she
pulls someone aside to go through her list.  She is great at learning.

## Get rapid feedback

Good learners are relentless in the pursuit of feedback. This might mean unit
tests if you are playing with a new technique or library, a REPL if you are
learning a new language, or building a small demo if you are learning a UI
framework. The common thread is that they try to set up a feedback loop that can
very quickly answer the question "is this right?"

My friend [Dallin Osmun](https://github.com/numso) is amazing at this. He
wanted to learn [GraphQL](http://graphql.org/). My instinct is to spend hours
reading docs and understanding concepts. Dallin focused on the installation
instructions and immediately started building a GraphQL server and a client
that consumed the data. He knew that he faster he could get some code running,
the easier it would be to get feedback on his understanding.  Dallin is a good
learner.

## Get uncomfortable

Good learners build knowledge iteratively. They accept that they don't know the
perfect way to do something, but they still get things done with the knowledge
they have now. After working in an environment where they are experts it can be
uncomfortable to be a beginner again. They embrace and push through that
discomfort.

## Compare it to what you know

Good learners often take shortcuts by comparing to something they already know.
This is one area where being experienced can help. If you have seen many
different programming languages you discover that most languages are a mixture
of several different concepts, most of which show up in other languages. If you
already understand immutability then Clojure or Elm or Haskell, all languages
that heavily feature immutability, get a bit easier to learn.

Beware. Sometimes these shortcuts can mislead you. You might dismiss something
good because it bears a passing similarity to a technology you had a bad
experience with previously. If a new tech reminds you of something you already
know you might skip understanding it, only to have it bite you later on when
you uncover fundamental differences.

## Keep going

Good learners keep trying. It often takes a few tries between with a technology
to break through to understanding. Struggling to learn something doesn't mean
you can't learn it. It means you are growing.  It took me a few tries to learn
React, node.js made no sense to me for a few months, Clojure was baffling the
first two times I tried to learn it (how can you program without mutating
data?), and I still haven't quite cracked Haskell.  Keep going.

If you want to hear more about this, Dave Smith and I discussed it in [Episode
16](http://thesmithfam.org/podcasts/sse-016.mp3?rss=true) of the Soft Skills
Engineering podcast.
