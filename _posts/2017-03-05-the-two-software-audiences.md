---
author: jamison
layout: post-no-feature
title: The Two Audiences of Software
published: true
description: "Software has at least two audiences: the users and the creators."

---

Developers care about things like functional programming and continuous integration and Docker and code style and Elixir and PostgreSQL and small functions and the Single Responsibility Principle. Users care about ease of use, documentation, UI, discoverability, consistency, price, and support. The two audiences overlap in some areas; maybe  you want to use Elixir because it sounds fun, but it also makes your software faster. Adding animations to UI can be interesting and make your app feel more intuitive. For the most part though, users don't care what programming language you use or if your data structures are immutable or if your app is rendered on the server or in the browser.

That doesn't mean the **how** is unimportant. Technical things affect reliability, performance, pace, hiring, culture, and developer happiness. These in turn all affect the product the user sees.

Software that is all about the developer tends to die under a pile of reinvented wheels as devs build a cloud orchestration platform on top of Docker just to deploy a CRUD app or iterate endlessly on the perfect component library. Software that focuses on the user and completely ignores the developer sometimes lives, but it is a crummy sort of existence where everyone who works on it begrudges it. Development is a slog, responding to changing requirements is impossible, and morale is low. As in most things, the right approach is somewhere in the middle.

If you have to favor one over the other, it seems better to favor users. You can build a successful business with software that users love but developers hate, but you can't really do it the other way around. With enough money from happy users you can improve the technical story.

Keep your eyes peeled for things that help both audiences. Those are free wins. If you can pick a tech that makes writing good software easier, and also is ridiculously fast, you can make both developers and users happy. <aside>Identifying free wins is the subject of <del>another post</del> a lifetime.</aside>

If you have to trade-off, be aware that you are making a trade-off. There are techniques for speeding up page load times that aren't widely supported by common tools or workflows. You can do them, but they make life harder for developers. However, if it makes life better enough for users, you might be willing to sacrifice one audience for another.

Most technical decisions involve trade-offs, but I usually hear them discussed along different axes. Performance vs resource consumption, community excitement vs community maturity, ease of adoption vs long-term maintainability, etc. User-facing vs developer-facing is an idea that is sometime implicit in these discussions, but it's worth calling out explicitly. What audience does this technical decision support? Is that the audience that it **should** support?
