---
author: jamison
layout: post-no-feature
title: Deconstruct Conf 2019 Recap
description: ""
published: true
---


# Deconstruct Conf 2019

I just got back from [Deconstruct Conf](http://deconstructconf.com). It was fantastic! Deconstruct is a generalist software conference that focuses on fantastic speakers giving wonderful talks. I've also heard it described as TED talks for developers, or "that [Gary Bernhardt](https://twitter.com/garybernhardt)" conference. It features wonderful speakers with both new and established voices, unlimited scholarships for under-represented folks or students, a gorgeous venue, no sponsorships, no swag, and a minimalist and bare-bones aesthetic. I could write a whole post on what I love about it as a conference organizer, but this one will focus on my experience as an attendee. I'll try to summarize a few moments and themes I really enjoyed.

### Games!

[Ayla Myers](https://mobile.twitter.com/bridgs_dev) talked about her adventures in multiplayer game development, and the repeated struggles she had while trying to make it work. The content of the talk was great - the woes of trusting the client, dealing with lag and the struggles with client-side prediction. I've played games for quite a while but never really understood the reasons for strange behavior in laggy network conditions. She hand-made pixel art for her slides, which were gorgeous and full of character. I especially love the penguin jumping animation:

![four frames of a penguin jumping](/images/deconstruct-2019/ayla.jpg)

The structure of the talk was great. It played out like a fable - every three years, a return to the struggle of multiplayer game programming. Her Sisyphus reference felt very apropos. Ayla is hilarious too. She absolutely killed it on stage. She is a very talented technologist, game developer, and storyteller.

Ayla's talk led me to playing around with [Pico8](https://www.lexaloffle.com/pico-8.php). She made building games seem approachable and fun, as long as you stay away from multiplayer game engines.

### Files, File Systems and Storage

[Dan Luu](https://twitter.com/danluu) talked at great speed about the file API, filesystems and disks, and how broken every single layer is. A phrase I wrote down was "impossible to use correctly, even for experts." Dan quoted heavily from research, both from academia and his own work, to try to answer questions empirically that are often just debated on Reddit.

The talk was motivated by one of those offhanded smug dismissals programmers love to toss out about how easy a difficult thing is in software development, and that the jokers getting it wrong just simply need to do [obvious thing x]. It turns out safely writing files is complicated!

I really love Dan's blog, so seeing more of this in person was wonderful. He is constantly peeling back layers and poking at conventional computing wisdom, and this talk felt like a fantastic entry in to that genre. Also, I love the shorthand of ✓∑ for checksum.

You can see a transcript of the talk [here](https://danluu.com/deconstruct-files/).

### Intentional Friction

This phrase from [Erica Gomez's](https://twitter.com/ericalgomez) talk has been stuck in my head since her talk. She looked at the history of aviation, regulation, agile, software, and it's focus on speed. The contrast between the way airplanes have been built and verified - ponderous but thorough - with the breakneck push for SPEED in software was fascinating. The talk highlighted the adoption of software-style pace in building the Boeing 737 Max, which famously has some software problems leading to crashes. The thesis of the talk is that the constant push for speed is expensive in hard-to-quantify ways. Burnout, ballooning tech debt, ethical problems, and a bunch more. The incentives are all set up to push us to go faster. The solution - intentional friction! Add things that slow you down and give you time to think, fix, secure, and consider. Pair programming, code reviews, curtailing working hours, refactoring and revisiting old designs are all things that slow us down but add value. We should be pushing for this!

There was also a thread about how people are an essential part of technical systems, with some great quotes from primary sources. She found the first reference to "software", and it turns it was used to describe people, not programs! 

> "In addition, the interactions between these various elements, hardware and software (people), must be recognized and included as the glue that holds the system together." - Richard Carhart, Proceedings of the Second Nation Symposium on Quality Control and Reliability in Electronics, 1956

 People have always been an essential part of technical systems. [http://www.historyofinformation.com/detail.php?entryid=936](http://www.historyofinformation.com/detail.php?entryid=936) looks like a fascinating link to dig more in to this.

I loved this talk. I took tons of notes, and have been thinking about its themes since I saw it. What kinds of intentional friction are most useful? How can I add them in ways that are helpful to the team but also to our users? What is my responsibility to push back against the push for ever more, ever faster?

### Voice-Computer Interfaces

[Emily](https://twitter.com/yomilly) spoke about her own personal struggles with RSI that led to her writing code and controlling her computer exclusively with her voice. It was probably the best live demo I've seen. She controlled her presentation with her voice, showed how it would work if you used the built-in operating system tools for coding with voice (basically impossible), and then moved to demoing and explaining her setup. She demoed writing Perl and Python (jaw-droppingly fast). She then dove deep in to the tools she uses, the ways she's customized her environment, her custom snippets, phonetic alphabet, using ordinal numbers to repeat commands, etc. It felt like someone showing off their very well-optimized editor setup, except it was all controlled by voice, and it worked really well. It felt like a glimpse of the future, but it works today.

She uses [Dragon](https://www.nuance.com/dragon.html) for speech-to-text and [Talon](https://talonvoice.com/) to program and customize her environment. Her Talon configs are [here](https://github.com/2shea/talon_configs). The person who makes Talon has a [Patreon](https://www.patreon.com/join/lunixbochs), which should be making more money than it does!

This was also a great talk about accessibility, despite not being explicitly about accessibility. Apps that aren't accessible don't lend themselves well to being controlled by voice.

[https://www.youtube.com/watch?v=Mz3JeYfBTcY](https://www.youtube.com/watch?v=Mz3JeYfBTcY) is a version of the talk given at a different conference. This talk was rad.

### Research and History

 One of my favorite things about Deconstruct is how much value the talks place on history and the past. Computing has a long and rich history of great ideas and valuable experience. That often gets lost in the rush towards the new hotness of the day. Several of the talks focused on or featured research - [Hillel Wayne](https://twitter.com/hillelogram) talked about his journey through primary sources to try to answer the question "Why do we ask people to reverse linked lists in interviews?". [Erica Gomez](https://twitter.com/ericalgomez)'s talk (more later) dove deeply in to aviation, regulation, and software history. Dan's talk featured both academic research on filesystems and disks, and his own personal research verifying results. [Kyle Kingsbury](https://twitter.com/aphyr/) shared new findings from Jepsen, his project on verifying correctness in distributed systems.

Deconstruct is one of my favorite conferences and this year lived up to my expectations. It featured kind people, a relaxed atmosphere and thought-provoking talks. I'll be back for sure.
