---
author: jamison
layout: post-no-feature
title: Technical debt and technical investment
description: ""

type: draft
---

## Technical debt

Technical debt is tool for talking about trade-offs in software engineering.
When you take on technical debt <sup><a href="#fn1" name="fn1src">[1]</a></sup>,
you build something quick and dirty that will be harder to maintain or change
down the line. The cost of maintaining the quick and dirty code or
infrastructure is higher over time than if you had built it right the first
time. You can tell this is true because I drew this scientific graph.

<img alt="graph of the decreasing productivity over time of technical debt" title="You can tell this is true because I drew a graph." src="/images/tech-debt.png">

Some people use the phrase technical debt to mean bad code. That is not quite
right. *Technical debt is bad code for a reason.* Sometimes you can get
something done faster the wrong way, and sometimes getting it done faster is
really important. When done correctly, you choose to take on debt when the
benefit of speed outweighs the cost of maintaining or refactoring bad code.

## Technical investment

The flip side to technical debt is technical investment
<sup><a href="#fn2" name="fn2src">[2]</a></sup>. With technical investment, you
slow down now to speed up in the future.  Maybe you switch programming
languages or web frameworks. Your team takes time to learn the new tool, but if
you chose wisely at some point they will be more productive. This is conclusively
proven by the graph with no numbers on it that I drew by hand.

<img alt="graph of the increasing productivity over time " title="This is conclusively proven by the graph with no numbers that I drew by hand." src="/images/tech-investment.png">

## You need to invest

A successful product only gets more complex. If people like and use your
product, you will add more features and complexity. Removing existing features
that people pay money for or use basically never happens.

Tools and techniques that are productive in the initial prototyping phase
sometimes struggle with the complexities of larger products. If you don't
invest to handle that complexity development speed will slow down as complexity
increases. Technical investment can scale your team's productivity with the
complexity of the product and the size of the team.

## Risk

Technical debt and technical investment are both risky. If you underestimate
the cost of maintaining some tech debt or the benefit of taking it on, your
product slows down for no long term benefit. If you overestimate the value of
a technical investment, you slow down in the short term without the long-term
speed up.

## What makes a good technical investment?

If you buy the idea of technical investment, the next question is "how do I
know if something is a good investment?" The answer to this is probably about
the same as in regular investing - you don't. You can examine current evidence
and try to predict future trends, but really it is all just guesswork.


This is hard in technology because our timescales for payoff are so short.
Every five years we have thrown away most of what was popular five years ago.
Every ten years most the developers have turned over. The institutional memory
to evalute technologies over the long term

The history of computing is littered with good ideas cast off prematurely, but
it is also strewn with bad ideas that stuck around for too long.

This is particularly hard in technology because every few years[pop culture] because sometimes things that look like great
investments turn out to not be. CORBA? WSDL?

With those caveats in place, here are a few predictions for good technical
investments for web development teams. I'm probably wrong about some of these.

### Elm, or PureScript, or something like it

I feel the most strongly about this one. I think statically typed purely
functional programming is the way of the future, especially for client-side
applications. Elm and PureScript are solving some of the culture and education
problems that have prevented a language like this from gaining mainstream
adoption, and I think one of them will gain a significant user base in the
next few years.

### Observables

This includes things like [RxJS](https://github.com/Reactive-Extensions/RxJS),
frameworks build on observables like [Cycle.js](http://cycle.js.org/), and also
the general practice of using observables to manage state and communication in
a JavaScript application.

### Hiring and mentoring junior developers

I'll probably write more about this, but the summary is that junior developers
are wildly undervalued in a job market that is always desperate to hire. The
team and company that work productively with junior developers, and help them
grow in to senior developers, will have a huge advantage in hiring.


## Things I think aren't good technical investments

There are a bunch of technologies that I think are full steam ahead on the
Fair Ship Hype. I'd be wary of investing too heavily in them.

![animated gif of the hype thrusters activating](/images/hype.gif)

### Microservices

You can't shake a stick without running in to a


* containers
* React.js

http://martinfowler.com/bliki/TechnicalDebt.html
http://martinfowler.com/bliki/TechnicalDebtQuadrant.html

Part of the decision to take on technical debt or technical investment involves
future timing. If you have a tight deadline right now, but you know that after
the deadline you will have some breathing room, that is a good time for
technical debt. If you have a tight deadline now, and right after that you have
more tight deadlines, techincal debt will speed you up now but make it hard to
continue to
hit your deadlines. It might be better to avoid the shortcut now.




There is a flip-side to the idea of technical debt, which is technical
investment.
Getting the right feature done faster means you can release faster, which means
you can earn money faster, which means you can build a successful product
faster. Technical debt is often used as a negative thing. It is just a
tool, like financial debt is a tool. Using debt poorly can bankrupt you, but
taking a loan that helps you start a business can get you that helps businesses get more cash to
expand and be profitable.

Debt in business is often used to set the company up for a better outcome in
the future. You borrow a bunch of money now and use it to expand to a new
market.  Even though you have to pay it all back with interest, the money you
borrowed means the business is better off 

<a name="fn1">[1]</a>: The earliest reference I can find to the term technical
debt is from Ward Cunningham in 1992. See
[http://c2.com/doc/oopsla92.html](http://c2.com/doc/oopsla92.html).
Interestingly, the idea was articulated while Ward was working on a finacial
application. Sometimes we find good metaphors for software in totally unrelated
domains. <a href="#fn1src">⏎</a>


<a name="fn2">[2]</a>: I first heard about technical investment in a discussion
a few months ago with [Randal Bennet](https://twitter.com/randallb). <a href="#fn2src">⏎</a>
