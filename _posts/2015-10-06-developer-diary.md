---
author: jamison
layout: post-no-feature
title: Keep A Developer Diary
description: ""
published: true
---

I recently added this alias to my [`.bashrc`](https://github.com/jergason/dotfiles/blob/master/.bashrc):


```bash
alias diary='cd ~/code/journal && vim `date +"%Y-%m-%d"`.md'
```

If you don't speak bash (it's ok, no one understands bash except the
all-knowing [Advanced Bash Scripting
Guide](http://www.tldp.org/LDP/abs/html/)), it adds an `alias` command that
opens a file named `[todays-date].md`. In it I write about the code I'm writing
or my day at work. I talk about what I'm stuck on, do little post-mortems of
why things took longer to finish than I thought they did, and call myself a
moron. Here is what I wrote on September 23, 2015:


```
# Print stylesheet

Added a few classes for print stylsheets, used !important to override inline
styles. Currently stuck icss not workin well with normal css.

Lol turns out I had the class misspelled. That was a waste of a call to murphy.
Add that to my list of things that I need to check before calling in help.
```


I'm not generally prone to self-reflection. This means that I often do stupid
things without learning from them, which leads to me doing similarly stupid
things later. The developer diary is an attempt to speed up how quickly I learn
and improve.

It is easier to be insightful about someone else's problems than your own. The
developer diary makes your problems look like someone else's. This will trick
your brain in to solving your own problems. Gotcha, brain!

You should try a developer diary. It doesn't matter how you do it. You could
craft artisanal notebooks out of recycled bamboo or use clay tablets or fling
feces on the wall in a pattern meaningful only to you or write them in
[Ook!](http://www.dangermouse.net/esoteric/ook.html). What matters is the act
of describing what you are doing, why you are doing it, and what went wrong.
