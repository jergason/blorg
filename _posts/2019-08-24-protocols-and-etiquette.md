---
author: jamison
layout: post-no-feature
title: Protocols and Etiquette
description: "What is a protocol? A protocol is a definition for how things communicate. Think of it like an etiquette."
published: true
---
Recently I've been teaching networking concepts to front-end developers. Protocols come up frequently in networking, but I've found it hard to explain what a protocol is in general, separate from a talking about a specific protocol.

The word "protocol" gets tossed quite a bit in computing. It shows up in a bunch of acronyms. HTTP is Hyper Text Transfer Protocol, TCP is Transmission Control Protocol, and I've renamed dinner to Food Ingestion Protocol in order to spark joy in my family. It has not worked.

What is a protocol actually though? A protocol is a definition for how things communicate. Think of it like an etiquette.

Apparently there an etiquette for communicating with your knife and fork at 🎩FANCY👸 meals. This image filled me with a spicy blast of anxiety as I thought of all the times I accidentally dropped my utensils on the plate in the wrong configuration telling my mom I didn't like the macaroni and cheese she made for me.

![Etiquette rules for how you place your utensils on a page.](/images/etiquette.png)

An etiquette is a set of rules for communicating. Etiquette defines what format you use to send messages. In this case utensils arranged in shapes send messages. Etiquette tells the sender and receiver what those messages mean and how to respond to them. Probably a butler will be summoned or something. It defines the message format and message meaning - the syntax and semantics. A different etiquette would have a different way of sending messages and different meanings. For example, there is an etiquette for Business Emails: eschew emojis, keep them short and easy to scan, say "per my last email" instead of "are you kidding me", etc.

You could think of HTTP like an etiquette for how two applications communicate. Just like fork etiquette, HTTP defines a [message format](https://tools.ietf.org/html/rfc7230#section-3). Clients communicate by sending HTTP requests to a hostname at a specific path with a specified verb, headers, and body. Servers reply by sending HTTP responses with a status code, headers and a response body. HTTP defines what those messages mean, and gives rules for sending and receiving them.

You can read about the etiquette of HTTP in the RFCs: mainly [https://tools.ietf.org/html/rfc7230](https://tools.ietf.org/html/rfc7230) and [https://tools.ietf.org/html/rfc7231](https://tools.ietf.org/html/rfc7231).

Network protocols don't actually exist as physical artifacts. There isn't a solid block of aluminum that represents HTTP sitting under a glass case somewhere. They are written down sometimes (you can read the definition of the HTTP protocol in the [RFCs](https://tools.ietf.org/html/rfc7230)), but they only get reified by code running on a routers and clients and servers and switches. They are abstract concepts that affect our life as developers and users of software consumers. [TCP slow start](https://varvy.com/pagespeed/slow-start.html) is a tool for congestion control built in to TCP. Basically, packets sent at the beginning of a TCP connection are smaller and gradually ramp up in size. That means if you make many TCP connections for sending small files, each of those connections will go through slow start. This translates to common front-end perf advice - bundle your CSS or JavaScript instead of serving each file individually. It also is a [core motivation](https://http2.github.io/faq/#why-revise-http) for HTTP/2 - by multiplexing HTTP requests in to the same TCP connection, we avoid slow start without having to manually bundle files.
