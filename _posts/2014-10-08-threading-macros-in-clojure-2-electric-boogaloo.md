---
author: jamison
layout: post
title: "Threading Macros In Clojure 2: Electric Boogaloo"
description: "More on Clojure's threading macros"
categories: coding
tags: [clojure macros threading thrush]
---

Earlier I wrote about Clojure's humble [threading macro](http://jamisondance.com/10-06-2014/the-clojure-threading-macro/).
It turns out that like Transformers and ant nests there is more to threading
macros in Clojure than meets the eye. Also, they are apparently called
[thrush operators](http://debasishg.blogspot.com/2010/04/thrush-in-clojure.html).

## `->>`, or Thread Last

`->` threads an expression as the second item in an function call. In
comparison, `->>` threads the expression as the **last** item. Think of the
extra angle bracket as a speed line showing how the arrow is going faster, so
it flies in to the last position of the function call.

This is particularly helpful when working with sequences and functions that
operate on sequences since they usually take a function as the second argument
and the sequence as the last argument. For example, lets say we want to yell
about what things we don't like to see in job postings.

```clojure
(def bad-signs-in-job-postings ["facebook for" "rockstar" "guru" "ninja" "bro" "red bull" "crush" "disrupt"])
; actually disrupt is ok
(apply .toUpperCase (apply str (filter #((not (= "disrupt" %))) (shuffle bad-signs-in-job-postings))))
```

This looks a little tricky. Since `apply`, `filter`, and most of the functions
that operate on seqs take the sequence in the last position, `->` won't help us
here. What is that *whooshing* sound you hear? It is `->>`, whizzing in to the
rescue! Let's rewrite it and see how it looks.

```clojure
(def bad-signs-in-job-postings ["facebook for" "rockstar" "guru" "ninja" "bro" "red bull" "crush" "disrupt"])
; actually disrupt is ok
(->> bad-signs-in-job-postings shuffle (filter #((not (= "disrupt" %)))) (apply .toUpperCase) (clojure.string/join " "))
```

We thread `bad-signs-in-job-postings` through `shuffle`, `filter`, `apply`, and
`join`, with the result of each function call getting inserted in the last
position of the next function call. Now we are yelling about dumb startup
rhetoric! Neat!

## `as->`, or Thread However I Want

What if you want to mix up where something gets threaded? You could nest `->`
and `->>`, but that can get sticky icky quickly. Fortunately, Clojure 1.5 added
[`as->`](http://clojuredocs.org/clojure.core/as-%3E), which lets you go wild
with threading.

`as->` takes an expression, a name for that expression, and a bunch of forms
that you use that name in. In each form the name represents the result of
evaluating the previous form. Prose is hard, let's go coding.

```clojure
(as-> [1 2 3 4] $
  (seq $)
  (nth $ 0)
  (+ $ 5)
)
; 6
```
Coming up with a non-contrived example is left as an exercise to the reader.

## Other Threading Macros

There are a few other specialized threading macros. `cond->` and it's sibling
`cond->>` allow you to branch before threading, and `some->` and `some->>`
will thread a result through as long as it is not nil. My brain is tired so I
failed to write examples of using these, but it is helpful to know they are out
there. Now go forth and thread!
