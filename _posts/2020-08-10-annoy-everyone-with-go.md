---
author: jamison
layout: post-no-feature
title: How To Annoy Everyone You Admire With Go
description: "Use the Twitter API and Go to something something blockchain"
published: true
---

My Twitter feed is a nightmarish cacophony - [cute](https://twitter.com/swordandsnore/status/1291894852641325061) [art](https://twitter.com/Powersaurus/status/1291764687076458497), police brutality, security vulnerabilities with catchy nicknames, dire economic news, fun jokes, squabbles over programming languages, etc. You know the [dril](https://twitter.com/dril).

Time for a change! I follow people I like and admire and am friends with, but the aggregate feed of all these people I like and admire and am friends with somehow makes me sad. Perhaps I am just fragile?

Anyways, the best solution to this social/personal problem is clearly to write a computer program. My feed is too overwhelming, but I don't want to lose touch with the people I follow ("friends" in the Twitter API parlance). I will move my friends to a list and unfollow basically everybody.

The Twitter UI for lists is a pain and involves lots of clicking.

![please notice me][notice]

Let's use the Twitter API to load all my friends and add them to this list!

## The Code

```go
package main

import (
	"fmt"
	"strings"

	"github.com/dghubble/go-twitter/twitter"
	"github.com/dghubble/oauth1"
)

const (
	// lol no
	apiKey      = "⊙▽⊙"
	apiSecret   = "¯\_(ツ)_/¯"
	accessToken = "(>._.)>"
	secret      = "^_^"
	listID      = 1234
)

func main() {
	config := oauth1.NewConfig(apiKey, apiSecret)
	token := oauth1.NewToken(accessToken, secret)
	httpClient := config.Client(oauth1.NoContext, token)

	client := twitter.NewClient(httpClient)

	// Cleverly avoid the if err != nil boilerplate by not checking for errors
	friendIds, _, _ := client.Friends.IDs(nil)

	// You can only add 100 users to a list at a time, so group in to slices of 100 ids.
	// This took an embarassing amount of time to get right.
	ids := make([][]int64, 0, 0)
	for i := 0; i <= len(friendIds.IDs)/100; i++ {
		end := (i + 1) * 100
		if len(friendIds.IDs) < end {
			end = len(friendIds.IDs)
		}
		ids = append(ids, friendIds.IDs[i*99:end])
	}

	for _, hundredIds := range ids {
		str := strings.Trim(strings.Join(strings.Fields(fmt.Sprint(hundredIds)), ","), "[]")
		client.Lists.MembersCreateAll(&twitter.ListsMembersCreateAllParams{ListID: listID, UserID: str})
	}

	// No need to check for errors if your heart is pure.
	res, _, _ := client.Lists.Show(&twitter.ListsShowParams{ListID: listID})
	fmt.Printf("%s: %d", res.Name, res.MemberCount)
}
```

## About The Code

This code uses several Go patterns, including "just don't check errors" and "hope everything works". I didn't even need generics. Go really does help you write fast and correct code! I also use other best practices like "search GitHub for libraries and install the first one that shows up". My in-depth analysis led me to the [github.com/dghubble/go-twitter](https://github.com/dghubble/go-twitter), which worked fine.

If the list you're trying to add people to is public, this code will also send them a notification each time you add them to the list! This is a great way to remind people you are friends with and admire that you exist, just like high school. This is especially effective when I run this code dozens of times using all dozen of my brain cells to debug the for loop.

In case you're wondering the code font is Times New Roman and the editor is Kubernetes.

## Why I Chose Golang

`¯\_(ツ)_/¯`

## A Powerful Conclusion Goes Here

My original goal was to bring some silence to my Twitter feed by replacing following with lists. I still didn't un-follow anyone because it made me feel bad, so now I just double-follow everyone. In the end, writing a computer program in Go did not solve all my personal/social problems. Perhaps Rust?

[notice]: /images/notice.gif
