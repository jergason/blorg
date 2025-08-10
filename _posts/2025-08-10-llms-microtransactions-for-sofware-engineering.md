---
author: jamison
layout: post
title: LLMs Are Microtransactions For Software Engineering
description: ""
published: true
---

Sometimes I finish a session in Claude Code and run the `/cost` command. "It cost $2.37 to fix that bug," etc etc. My own time is involved, of course, but seeing the cost in tokens and vendor spend is helping me think about building and tending software in a way I haven't before. Costs in software engineering are usually fuzzy. How much does a feature or product cost? Do you count salaried employee time? When do you start counting? Do you count [hammock time](https://www.youtube.com/watch?v=f84n5oFoZBc&themeRefresh=1) or shower time or the opportunity cost of not building other stuff? Cloud spend can sometimes be part of that cost, but is often a very small part for small startups, and if it's a feature on an existing product, it's hard to attribute fractions of cloud spend to that specific feature. This fuzziness often leads me to throw my hands up at the idea of measuring cost at all and go for vibes - this feature "feels" expensive, this refactoring doesn't. That's not even getting in to value, which is at least as hard to measure as cost. "Fractional not-churned custom" is not a unit we can easily measure in without a magical machine to fork the timelines in to control and experiment.

All of that is why I think it's nice to glance at an LLM bill and say "that bug cost $2.37 in LLM spend to fix". Sure, it doesn't account for the hard-to-quantify costs of gathering all the context to spend the $2.37 on an LLM in a way that would actually fix the bug. But I still like it. It kinda feels like buying gems in one of those horrible match-three mobile games. Spending money to buy engineering outcomes like quality, speed, security, etc, has been the promise of basically every engineering-focused vendor. I can now buy level-skips or whatever to deal with some tedious work to improve dev environments, clean up some janky code, fix a bug, etc. I am happily doing it.
