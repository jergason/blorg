---
author: jamison
layout: post
title: Binding Multiple Sockets To The Same Port
description: ""
published: true
---

I've been a professional developer for about a decade, but there are tons of things I still don't know. That is part of what is rad about software: there are so many things to learn!

I'm reading a book about networking to try to learn more of these things. While reading the section about UDP I saw this sentence:

> [T]he transport layer assigns a port number in the range 1024 to 65535 that is currently not being used by any other UDP port in the host.

"that is currently not being used by any other *UDP* port" caught my eye. I always thought only one socket of *any* kind, TCP or UDP, could be bound to a port at once.

I can write a program to check this. Let's do that!

## Binding two UDP sockets to the same port

This should not work. Here is a small go program that demonstrates this:

```go
package main

import (
	"log"
	"net"
)

func main() {
	addr := &net.UDPAddr{
		IP:   net.IPv4(127, 0, 0, 1),
		Port: 5556,
	}
	if _, err := net.ListenUDP("udp", addr); err != nil {
		log.Fatal("error making first udp socket", err)
	}

	if _, err := net.ListenUDP("udp", addr); err != nil {
		log.Fatal("error making second udp socket", err)
	}
}
```

As expected, running this causes an error:

```bash
➜  socket-stuffs go run main.go
2018/05/27 17:19:33 error making second udp socketlisten udp 127.0.0.1:5556: bind: address already in use
exit status 1
```


## Binding a TCP and UDP socket to the same port
Time to see if the book is FULL OF LIES or not:

```go
package main

import (
	"log"
	"net"
)

func main() {
	addr := &net.UDPAddr{
		IP:   net.IPv4(127, 0, 0, 1),
		Port: 5556,
	}
	if _, err := net.ListenUDP("udp", addr); err != nil {
		log.Fatal("error making udp socket", err)
	}

	if _, err := net.Listen("tcp", "127.0.0.1:5556"); err != nil {
		log.Fatal("error mkaing tcp socket", err)
	}
}
```

This works:

```bash
➜  socket-stuffs go run main.go
➜  socket-stuffs echo $?
0
```

An aside: I'm not sure why the signature for `net.ListenUDP` is different from `net.Listen`. Why do you make a struct in `net.ListenUDP`, and mash all the fields in to a string in `net.Listen`?  ¯\\\_(ツ)\_/¯

## Why does this happen?

I'm not sure why this happens. I thought ports were managed by the operating system, and binding to a port "used up" a slot for that port in some internal kernel data structure. It looks like there is a slot per `(port, protocol)` pair? I'd like to understand more about those data structures and how the operating system manages them.
