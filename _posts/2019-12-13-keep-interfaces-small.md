---
author: jamison
layout: post-no-feature
title: Keep Interfaces Small
description: "The best interface is the smallest possible one."
published: true
---

Keep interfaces small. Other things equal, a larger interface is always worse than a smaller interface. What do I mean when I say interface? An interface is the exposed functionality of a module.

> An interface is the exposed functionality of a module.

For an HTTP service, the routes are the interface. For a library, exported or exposed functions, methods, and data structures are the interface. Each thing (variable, type, function, route, concept) exposed to consumers is part of that module's interface. An interface is an implicit contract to consumers - both "this is stuff you can use that won't change", and "this is stuff you might need to use."

Larger interfaces are worse for the developer of the module because each exposed thing is a fixed point that is hard or impossible to change. Again, interfaces are contracts to users. Breaking contracts comes with large costs. Migration, education, breaking consumers that refuse to migrate, long upgrade cycles, etc. In some environments, it is basically impossible to change an interface once it has *any* consumers! Large interfaces have large costs on the creator and consumer side.

Like [Sandi Metz says](https://18f.gsa.gov/2016/06/24/5-lessons-in-object-oriented-design-from-sandi-metz/), good design is easy to change. Creating an interface costs the module developer flexibility, but usually it is worth it since it provides stability to users. This is good (no one would use a module that had no guarantees of stability), but also comes at a cost. You’re locking yourself down and limiting your flexibility to respond to future change. Smaller interfaces lock you down less.

If you’re making libraries or modules consumed by programs you write, a larger public API increases the number of connections between different parts of your program. That is more parts for you to keep track of and update when you want to change things. The best interface is the smallest possible one that can do the job. Whenever you can, inline abstractions, hide implementation details, and don't add things to the module's interface. Your default approach should be to keep interfaces as small as possible.

Larger interfaces are worse for users because there are more things to learn and keep track of. It increases the cognitive load of using the module. Larger interfaces also encourage more dependencies between a module and its consumers.

So do whatever you can to keep interfaces small. Audit a module's exported concepts and structures. Do they pay for themselves? Does the added functionality pay for the reduced flexibility? Is it worth the added burden of knowledge on the user?
