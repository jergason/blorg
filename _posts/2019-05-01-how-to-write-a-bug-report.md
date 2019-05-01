---
author: jamison
layout: post-no-feature
title: How To Write A Bug Report
description: "A bug report has three main parts: what you expected to see, what you saw and steps to reproduce."
published: true
---

A bug report has three main parts: **what you expected to see, what you saw** and **steps to reproduce**. This structure makes it easier for the team resolving to fix bugs you report.

## What You Expected To See

Including what you expected to see provides context. Maybe you know how the feature should work, but the bug fixer could be looking at this feature for the first time. "What you expected to see" doesn't have to be a detailed design document, but it should give the bug fixer a rough idea of what was wrong with what you saw. For example:

> "I expected some indication that a pug test was running."

Sometimes what you expected to see is really obvious. If the UI is rendering as a blank screen, you could leave out saying "it should render the app." For most things though, adding what you expected to see is important detail for the bug fixer.

## What You Saw

What tipped you off that something was wrong? Saying "test pug release is broken" doesn't give very much information. How is it broken? Is it testing the spider release instead? Is it crashing your browser?

Instead, say what you saw that seemed wrong:

> "Nothing happened on the screen either time I clicked the button, but when I looked out my window my front yard was filled with delightful pugs."

Include screenshots, stack traces, responses, error messages, or other output from the system if you have them.

## Steps To Reproduce

How did you reveal the bug? The developer fixing the bug will need to reproduce it. Clear steps to reproduce make this easy, which makes fixing the bug easier. Here's an example:

1. Log in to www.release-the-pugs.com with a username of "user" and a password of "password".
2. Click the "Test Pug Release" button in the top left corner.
3. Wait 30 seconds.
4. Click the "Test Pug Release" button again.

The steps to reproduce should include specific data you used, like request bodies, form input values or configuration options. You're trying to give enough context that the bug fixer can see the problem in their test environment and fix it.

For really obvious things, you could combine the parts of a bug report in to one sentence: "The login screen in production is rendering as a blank screen." For most things though, more detail and structure is better.

Sadly, software has bugs. Writing good bug reports helps us fix them faster.

<small>This is a repost of a private I wrote for my team at Walmart Labs. Thanks to [Chase Adams](https://twitter.com/chaseadamsio/) for editing help.</small>
