---
author: jamison
layout: post
title: Software Engineering With LLMs
description: ""
published: true
---

LLMs and coding agents like Claude Code crank out code but have poor taste. They are irrepressibly-enthusiastic junior savants. Irrepressibly enthusiastic junior savants are super useful! However, when used carelessly you're at the mercy of the model. That's fine for prototypes or small codebases, but in a larger codebase doing Real Software Engineering with a team of engineers, heavy agent usage without good taste amplifies chaos and degrades the team's shared theory of the program. Agents used well can greatly increase the capacity of careful, thorough, experienced software engineers.
Frontier models like Opus 4.5 and GPT 5.2 Codex are now good enough that operator skill is the biggest bottleneck to getting great outcomes for coding. Here are some scattered things I've learned that have helped me get better output from LLMs on a team in an existing codebase of ~1 million LoC.

## Carefully Craft Context

Provide good context to the agent. See [context engineering](https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents) for a broad overview of this. Commonly useful pieces of context like a description of your product and broad architectural or documentation patterns should go in your [AGENTS.md](https://agents.md/) or its equivalent so you don't have to re-create it every time.
[LLM performance degrades](https://research.trychroma.com/context-rot) as context fills up. Crafting context is about carefully providing just the right information. Too much info can be worse than not enough. "Here is our whole codebase, good luck" (at one point a cutting-edge technique when context windows exploded) will do much worse than "here are the five files describe the interface to PDF uploading and generation, the problem we're currently working on." Agents have gotten better at iterating and compacting, but the wrong context can still set them off down a long and wrong path.
Use sub-agents to avoid filling up context. This keeps your main conversation's context slim, which keeps performance better longer. Sub-agents are more effective the more open-ended and research-heavy your task is. I don't always reach for it, but if I'm diving in to the unknown or hit a roadblock, I'll ask Claude to spin up one or more sub-agents to go dig in to specifics.
Good context also includes a clear description of the problem you are trying to solve. Clearly articulating a problem is a classic senior software engineer skill. It's even higher-leverage now with LLMs. If I don't know the problem well enough to articulate it clearly, I'll often separate out exploration and discovery in to a separate session. Then, once I understand it more clearly, I can hand off the clear description to a new session and start over with a fresh context window. Claude Code plan mode even supports this natively with the "Clear context and implement plan" option when exiting plan mode.

### Write Your Prompt In A File

Since the initial context is so important, I'll sometimes spend a few minutes writing and editing the prompt in a separate file. This is annoying in Claude Code directly, so I put it in a file and then copy-paste.
A written prompt in a file especially helps if the agent goes down a rabbit-hole to answer some question or problem, consuming lots of the context. Once it figures out the answer, I add the findings in the prompt and start over with fresh context.

### Start Over

Don't be afraid to throw away your session and start over! Since you wrote your prompt in a file (right???), this is easy. Tweak the prompt with what you learn. Ask the agent to record what it learned or did in a markdown file that you can feed to a new session. Long sessions can pin you in local maximums as the LLM goes down a rabbit-hole. LLMs will gleefully keep solving problems created by their earlier solutions forever. This can be a trap! It takes human judgement to recognize that the endless proliferation of problems is a signal that you've gone terribly astray. That signal is weaker when it's the LLM writing the code, so pay more attention to it. [Stepping back and starting over](https://x.com/acdlite/status/1027067642249535488) is useful in general software engineering, and it's cheaper and easier to do this with LLMs than people.

## Give LLMs Good Feedback Loops

Just like humans, LLMs can iterate faster with good feedback loops. Type checking, test suites and linting can tell an LLM where it’s going wrong. Encoding correctness in systems that give fast feedback is higher-leverage than ever. Perhaps this will encourage more type systems, formal methods, etc? Interesting times.
Great LLM-driven manual QA feels like an unsolved problem here. LLMs create good test plans for features with some nudging. I HATE HATE HATE manual testing and am generally lazy and feckless about exhaustively checking things. I want to get the LLM to execute the test plan for me. If you've got this nailed, tell me how! Hopefully I'll have something to report here in the next few weeks.

## Tell LLMs The Theory Of Your Program

[Programming As Theory Building](https://pages.cs.wisc.edu/~remzi/Naur.pdf) is my favorite piece of writing on building software in teams. Go read it, but my TL;DR is that good programs don't just accomplish a task. They have a coherent theory, and the team **knows** the theory. The program is deliberately structured. The team knows _why_ the program is structured that way. There are answers for how you accomplish common things in the codebase or what abstractions to use, and why those abstractions exist.
For LLMs to do well on existing codebases, you need to explicitly write down the theory of the program in prompts, documentation, and tooling. I've seen huge performance improvements in agents after documenting implicit theories or architecture. The agent doesn't have to explore the codebase to learn them anew and doesn't slam in head-scratchingly weird workarounds for carefully-enforced abstractions or reinvent solutions to already-solved problems. Documenting the theory of your program helps keep context clean and your codebase more consistent. These docs are also useful for humans. Humans can ask questions and retain context, but good docs, ESPECIALLY that focus on theory-building, help guide questions and direct towards an understanding of the theory.

### Creating A Theory Of Your Program

This advice isn’t much help if you don’t have a theory of your program. Creating or reifying the theory of an existing program is a whole separate topic, but good news - LLMs can help you with that as well! They're much better at uncovering theory than coming up with one out of a mess of spaghetti. Human judgement is still the best tool for broad architectural changes. Good taste, which LLMs lack, is essential for designing a theory of your program. LLM-enhanced capacity also makes the large refactors that are necessary for imposing a coherent theory on an ad-hoc codebase way more palatable. Exciting times!

## Use LLMs To Improve Future LLM Performance

Barring improvements in underlying models, the only way agents get better is if their inputs and environmental feedback get better. The newest junior developer onboarding to your codebase gains and retains context over time. Agents don't learn ANY context about your codebase or business or patterns or preferences. **YOU** learn, or your codebase changes to become easier for AI to manipulate correctly.
You can use agents to help with this! A simple, dumb solution is to ask the agent to create durable artifacts recording things it learned from this session. "Add this pattern to our AGENTS.md file", or "write out a markdown file explaining this architecture" is a common way I end a session. These AI-generated artifacts usually have the tell-tale stink of AI slop and thus benefit from human curation, but they can also be better than nothing.
Tell the agents to write tests and create lint rules. Complex eslint plugins that touch on semantics, not just style, are beyond my feeble human capacity. I will make my irrepressible junior savant robot friend write them for me. Agents should be self-improving because they should improve the environment they run in.

## Agent Experience Is Developer Experience

Investing in developer experience (DX so I don't have to type this out every time) makes agents more effective, and making agents more effective can have huge returns. Agent experience is developer experience. You should probably invest more in DX than you were before using agents.
Larger engineering orgs (100+ engineers) typically dedicate a single-digit percentage of headcount to an engineering productivity team. They build frameworks and component libraries, create developer tools, operate CI/CD, make releases faster, or do other stuff that makes all the other engineers work more effectively. Businesses don't like that many engineers working on non-customer-facing things, but at large enough scale, shared problems with developer efficiency are visible enough to justify the investment. Smaller orgs generally rely on individual heroics or skunkworks projects which can lead to poor DX.
LLMs make investments in DX much higher leverage. If a small team of five engineers is managing hundreds of parallel agents, a small gain in efficiency by steering them better through great abstractions, excellent docs, easy sandbox environments, faster deploys, comprehensive testing, a consistent design system, great error messages, etc etc, is spread across those hundreds of agents, not just the individual engineers.
LLMs also make investment in DX cheaper. I've done a TON of ops and observability work that would have been _just_ annoying enough before LLMs that I would have never gotten to it.
Take advantage of this virtuous cycle. LLMs make it easier to build systems around your software to make it easier to build and run. They also do better when these systems exist.

## You Don't Have To Be On The Bleeding Edge

There is a cacophony of LLM hype on Twitter, Reddit, YouTube, and elsewhere. My friend [Chad](https://www.chaddonohue.dev/) called this LLM fatigue, and it feels pretty accurate if you lived through the [JavaScript Fatigue](https://medium.com/@ericclemmons/javascript-fatigue-48d4011b6fc4) days. There are infinity frameworks and tools and courses and abstractions. Prompts become commands become hooks become skills become plugins become some new thing. "You're falling behind if you're not running <del>clawdbot</del> <del>moltbot</del> [OpenClaw](https://openclaw.ai/)." "Oh, you're not using <del><a href="https://steve-yegge.medium.com/welcome-to-gas-town-4f25ee16dd04">GasTown</a></del> <del><a href="https://www.conductor.build/">Conductor</a></del> a rack of raspberry Pis running [Kimi K2.5](https://huggingface.co/moonshotai/Kimi-K2.5)? How gauche."

It gets exhausting.

This is the most excited I've ever been about software engineering. [There's so much to learn](https://youtu.be/C7YCZK2yQrY?t=94). Under the hype, there is real benefit. I can do more and go faster than before.
The noise can make it feel like you're hopelessly behind. You're not behind. Most developers are barely using LLMs. Most of the noise is people trying to sell you something. Great ideas will stick around. I've found peace in being a few months behind and learning at my own pace. It's still enough, and I'm still getting better.

## Acknowledgements

Thanks to [Kiran](https://x.com/kiransparks) for teaching me how rad LLMs are for software development and filtering out some of the noise and [Chad](https://www.chaddonohue.dev/) for bouncing ideas around.
