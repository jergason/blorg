---
author: jamison
layout: post-no-feature
title: The Clojure Threading Macro
description: "What on earth does -> mean and also why doesn't it use threads"
categories: coding
tags: [clojure]
---

Clojure is a language for turning parentheses into Java NullPointerExceptions.
PLOT TWIST: that was a joke and since you laughed we are now friends. I am
the funny friend.

Clojure is actually lisp that runs on the JVM. You invoke functions by putting
the function name and then the arguments after, like-a-so:

```clojure
(first (.split (.toUpperCase "a b c d") " "))
```

This gets evaluated inside-out, which can be tricky for long sequences of
operations. It also involves lots of parentheses, which is bad for the
environment.

## -> or the threading macro


The threading macro (which confusingly has nothing to do with concurrency) takes
the first expression, inserts it as the second item in the second expression,
inserts the result of that function as the second item in the third expression,
and so on. It looks a little like threading an expression through a sequence of
functions, hence the name. You could re-write the above example like so:

```clojure
(-> "a b c d" .toUpperCase (.split " ") first)
```

If we expand this once, it turns in to

```clojure
(-> (.toUpperCase "a b c d") (.split " ") first)
```

Expanding again becomes

```clojure
(-> (.split (.toUpperCase "a b c d")) first)
```

If we expand once more, it turns back in to the origial form:

```clojure
(first (.split (.toUpperCase "a b c d")))
```

You can also use `clojure.walk/macroexpand-all` to let Clojure do this
expansion for you:

```clojure
(require 'clojure.walk)
(clojure.walk/macroexpand-all '(-> "a b c d" .toUpperCase (.split " ") first))
; (first (.split (.toUpperCase "a b c d")))
```
