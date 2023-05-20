---
author: jamison
layout: post
title: Capatilities And Possibilities On Engineering Teams
description: ""
published: true
---

Lately I've been thinking about possibilities and capabilities on engineering teams. I was chatting with an engineer about [tracing](https://opentelemetry.io/docs/concepts/signals/traces/), [spans](https://opentelemetry.io/docs/concepts/signals/traces/#spans), and getting detailed timing information from a complex browser application. It was fun to think about! We had a bunch of different pieces that helped with different subsets of the problem. We could squint our eyes and see a way to combine them in to something that would kindof sortof work.

I was struck by how _hard_ it felt to do something seemingly routine like "figure out how long stuff takes in the browser." It shouldn't be this hard! Why did it require novel work and brainpower? Hadn't we worked on measuring performance several times? (We had.) Measuring front end performance was possible, but I wanted it to be easy. I wanted it to be a capability.

## What Is A Capability?

When I say _capability_ I mean a skill or outcome that is cheap and easy for an engineering team. It might be useful to contrast _capabilities_ and _possibilities_. Something is possible if someone on the engineering team could pull it off, sometimes with extraordinary effort or at high cost. Capabilities are cheap, boring, routine, repeatable, and predictable.

Capabilities are context-dependent. Different teams will have different capabilities. If your crack team of Rails developers decides to pivot to <del>mobile</del> <del>blockchain</del> <del>video</del> generative AI, it's probably _possible_ for them to stumble their way through deploying and operating large language models, and thus stumble in to enormous pots of VC funding. However, it won't be easy. "Figuring out how to do new things" is an important part of the job of software engineering. It's also more expensive to figure out how to do new things than to do things you already know how to do well. If instead the team has been working in AI since it was called machine learning and has heard of things like "MLOps" and knows what GPT stands for, deploying and operating large language models might be a capability. It also might not be! Rails application development is probably not a capability of this team.

After the team has developed a capability, doing the thing doesn't require specific skill or expertise. Developing capabilities requires skill and expertise and deliberate effort.

## Capabilities And Leverage

It's possible for a team to have expertise at something but not turn that expertise in to a capability. This can happen on teams with long tenure. Engineers just know the domain so well that the right thing seems obvious and they don't build tooling or processes around it. How many times have you seen deployment processes that involve bloodletting and careful consideration of the phases of the moon that the team is just [used to](./03-16-2019/starting-a-new-job-and-noticing-things)?

Identifying and developing capabilities can be a high-leverage activity. Senior engineers and managers should think about capabilities, identify gaps, and help teams develop capabilities. Picking capabilities to invest in can often be a judgement call, but if you get it right, you can make the right things easy.
