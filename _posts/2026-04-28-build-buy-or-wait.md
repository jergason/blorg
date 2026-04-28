---
author: jamison
layout: post
title: "Build, Buy, Or Wait"
published: true
---

It's a weird exciting time in software engineering. LLMs advance. We get better at using them. Background agents hit critical mass in January 2026 with Stripe's [Minions](https://stripe.dev/blog/minions-stripes-one-shot-end-to-end-coding-agents), and [Ramp's background agents](https://builders.ramp.com/post/why-we-built-our-background-agent). Cursor launched [computer use](https://cursor.com/blog/agent-computer-use) in their cloud agents and [automations](https://cursor.com/blog/automations) in February and March 2026. Anthropic has been pushing hooking Claude Code up to GitHub Actions for [a while](https://code.claude.com/docs/en/github-actions).

At work we've been talking a lot about background agents. They are useful. We have some capabilities deployed, but most of our LLM use is manually triggered by humans. We could invest some time (much less than a few years ago, thanks to LLMs!) building background agents. It would be fun! It's also not what customers pay us for. We could pay for something like Cursor Cloud Agents or [one](https://www.warp.dev/oz) [of](https://modal.com/docs/guide/sandboxes) [the](https://background-agents.com/) many background-agent-like vendors. We tie ourselves to a vendor, get a bunch of cool functionality that we don't have to build, and deal with or paper over any mismatches with our needs. Or we can just **wait**, and in six months more vendors will appear and models will improve and the big LLM vendors will ship a bunch of stuff that may even kill this whole category. AI-assisted Engineering is moving fast enough that this has happened several times already. I know of companies that built their own half-baked internal agentic coding tools, only to look longingly at [OpenCode](https://opencode.ai/) and [Claude Code](https://code.claude.com/docs/en/overview).

## Examples Of Build, Buy, Or Wait In Computing

### Front-End Data Fetching

This same build, buy, or wait dynamic shows up all over software engineering history. In the mid-2010s, big companies were struggling with ad-hoc data-fetching logic sprinkled everywhere in the app. Netflix made [Falcor](https://netflix.github.io/falcor/), then-Facebook was pushing/promising [Relay](https://web.archive.org/web/20231002170350/https://engineering.fb.com/2015/09/14/core-infra/relay-declarative-data-for-react-applications/) and GraphQL, and most devs just . . . kept fetching data with REST. Several years later, [Apollo GraphQL](https://www.apollographql.com/docs/) became a thing, but most React devs ended up just using something like [React Query](https://tanstack.com/query/latest) or other wrappers to make data fetching easier and a bit more declarative without going all in on a vendor or GraphQL solution. I think "wait" won this battle outside of giant megacorps since most front-end teams are not 500+ people and don't feel the same pain as Netflix/Facebook.

### Cluster Orchestration

In the late 2000s and early 2010s, cloud, containers, and orchestration was a big problem. If you have one million CPU cores and a giant pile of heterogeneous work that needs to run across them, how do you do that? "Allocate enough capacity to a team to cover the peak" was wasteful and risky. Best case is the team's capacity estimates are right on, and you allocate enough to cover the peak, and waste a bunch of compute otherwise. If the capacity allocations are off, you waste even more compute or crumble under the peak.

If you squint, [Hadoop](https://en.wikipedia.org/wiki/Apache_Hadoop) both wins the award for "most fun open source name to say" and is kindof a solution to this problem, but was more focused on batch processing and not general computing. [Mesos](https://people.eecs.berkeley.edu/~alig/papers/mesos.pdf) was an early solution from the University of California, Berkeley and was open-sourced in 2011 and joined Apache in 2013. [Kubernetes](https://www.docker.com/blog/10-years-since-kubernetes-launched-at-dockercon/) (K8s for street cred) is descended from internal Google tools like [Borg](https://dl.acm.org/doi/epdf/10.1145/2741948.2741964) and [Omega](https://static.googleusercontent.com/media/research.google.com/en//pubs/archive/41684.pdf). It launched in 2014 at DockerCon, which is no coincidence, since it uses containers as the core abstraction of "stuff to be run on compute". If you went all-in on Mesos, [like Twitter did](https://blog.x.com/engineering/en_us/topics/infrastructure/2016/the-infrastructure-behind-twitter-efficiency-and-optimization), you probably missed out on containers since you invested engineering effort in a different branch of the tree. There are a bunch of other solutions like [Hashicorp Nomad](https://developer.hashicorp.com/nomad) or [Docker Swarm](https://docs.docker.com/engine/swarm/), but Kubernetes is the default now. If you solved this problem in 2015, you might have picked Mesos or built your own thing. If you solved this problem in 2020, you picked K8s, like everybody else, and many problems were already solved for you. Twitter even ended up [moving to Kubernetes](https://www.alibabacloud.com/blog/twitter-announced-switch-from-mesos-to-kubernetes_595156), I'm sure at great expense.

The problem with going all in on K8s is now you have K8s. It’s powerful and deep and complicated and a pain to operate well. If you waited even longer, you could have ended up using lambdas or ECS or one of its equivalent across cloud providers, or even something like Cloudflare workers or whatever the new "do a bunch of work without worrying a ton about infrastructure" thing is. K8s and big infra decisions like this often have high switching costs. If you know switching costs are high before you adopt something, waiting looks more appealing.

## How To Solve This Generally

I dunno, but that won't stop me from writing about it! I'd estimate along a few dimensions:

1. How fast is the space advancing or evolving?
2. How expensive is it to build your own thing vs buying?
3. What's the opportunity cost of waiting?
4. How related is it to what makes you money?
5. How expensive is it to switch if you build/buy and change your mind?

Faster advancement makes waiting look better. If the opportunity cost of waiting is large enough, building or buying might still be worth it. You get the idea. Think of this as a five-dimensional space and imagine a couple of hyperplanes splitting the space up into build, buy and wait. "But Jamison, isn't this just a pretentious way of saying 'it depends'?" Yes! But at least I got to google "what is the five-dimension equivalent of a plane in 3d."

## Back To Background Agents

For background agents, we chose "buy". Switching costs are low, opportunity cost feels reasonably high, we don't make money from them but expect a lot of value, and building is fairly expensive. We're mostly using Cursor Automations. It feels like a good decision so far. They have some gaps but they're improving quickly. They just added support for posting videos of computer use sessions to PRs, which makes it easier to trust their output. I think we're better off than we would have been if we built our own thing or waited.
