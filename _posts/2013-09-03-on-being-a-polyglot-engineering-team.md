---

layout: post-no-feature
title: On Being A Polyglot Engineering Team
author: jamison
published: false

---
 i.TV has historically been a node.js shop, with iOS, Android and web clients consuming APIs. We ran node v0.4 in production, which was good for our resumes and bad for our cortisol levels (just kidding, we love node). However, after using node for everything for a few years it became clear that some areas of our stack would benefit from a less hammer-shaped hammering device.

Lately we have begun to diversify our application infrastructure and are just deploying our first major Golang service. Another Python service is coming soon. Working in several different environments has been challenging, but we believe it is important for the health of our engineering team and our product. These are some of the benefits and challenges of being a [polyglot](http://en.wikipedia.org/wiki/Polyglotism) engineering team.

## The Good

A polyglot engineering team can use the right tool for the job, expose and deal with technical debt, and encourage a curious culture.

### The Right Tool For The Job

Early on it can make sense to use the same tech for everything. The value of specialization and experience with that tool is greater than the costs of using it in non-optimal ways. Every tech has its limits, but in the beginning you don't know what limits you will hit first. Optimizing for developer comfort and potentially trading scalability for rapid development is a reasonable choice early in a product's life cycle.

As user bases, products, and organizations grow the original architecture may shows signs of strain. That place where your uptime monitoring was just `while true; do echo 'EVERYTHING IS OKAY LALALA'; done;` might have been fine early on, but now you need something better. Sweet! Since your team is full of polyglots, you have engineers who can write or consume the best tool for the job *in your specific circumstances*, regardless of what language it depends on.

A common story is a [Rails app](http://www.infoq.com/articles/twitter-java-use) offloading some expensive computation to a more performant language to eliminate a bottleneck or offloading work to a queue when it no longer fits inside a request-response model. At some point, you will hit limits in your chosen language or stack. It helps to be able to switch tools.

### Promote Good Architecture
To support a polyglot architecture, you must have some modularity in your architecture. It is much harder to implement user notifications in Clojure if that feature is currently jammed inside a monolithic app.

Diverse applications encourage loose coupling between services and communication through protocols instead of just relying on object graphs in memory. This is [A GOOD THING](http://12factor.net/) since you can parallelize development and scale parts of your architecture independently. You can get these benefits without having different languages in your stack, but if you have a Ruby app and a Golang app, they are forced upon you.

It also <strike>forces</strike> helps your ops layer remain flexible. It might be a painful transition but being able to deploy and manage apps written in different languages forces you to eliminate language-specific assumptions, which can make your deployment strategies and operations more robust. Think of it like brussels sprouts but for servers.

### A Curious Culture
My non-scientific anecdotal evidence is that my favorite people to work with are curious, and this curiosity correlates strongly with interest in different technologies. That isn't a knock on specialists, but I believe a polyglot culture attracts great people who have diverse interests and skill sets and a common love of learning new things. Curiosity also means you are comfortable not knowing things. That reduces arrogance and cynicism, which is good for human beings in general. It discourages [blame](http://codeascraft.com/2012/05/22/blameless-postmortems/) and encourages experimentation.

## The Bad
I'm not trying to sell you anything, so I get to talk about the downsides too. Polyglot teams make you feel like a noob and can make it harder to specialize.

### Throw Away Everything You Know
Working with node for several years has made us very comfortable with it. We've written some great tools like  [gogogo](https://github.com/idottv/gogogo) to deploy node apps and [dependable](https://github.com/idottv/dependable) to handle dependency injection. We are comfortable creating, debugging, upgrading, monitoring, scaling, and testing node apps.

Imagine you are working in your own most comfortable technology. Now some [maverick] (http://screencrave.com/wp-content/uploads/2010/10/Top-Gun-Sequel-14-10-10-kc.jpg) wants to come in and turn you into a code monkey who is mainlining StackOverflow posts like a junkie just to write a Java app.

Hyperbole, but it is disorienting to be taken out of your comfort zone. How do you deploy? What is the best testing framework? What does this class of errors indicate? How do you manage packages (unless it is the browser, in which case it is "ARGHHH WHY CAN'T YOU MANAGE PACKAGES")? It takes time to build up that knowledge in a new language, not to mention the overhead of context switching between them.

This is an inherent problem in learning new technologies, so we haven't really found a good way to solve this beyond best practices for learning in general - pairing, mentoring, exploration, curiosity and time.

### Specialization
The yang to the previous point's ying is that jumping back and forth between tech makes it harder to develop incredibly deep knowledge of any one stack. How much time can you devote to becoming a world-class iOS developer if you need to jump back and forth between Ruby and node and Java and Erlang on the back end?

While many skills learned in one language carry over to other environments, experience is invaluable in firefighting and crunch time. We solve this by encouraging engineers to be [t-shaped](http://www.adam-mcfarland.net/wp-content/uploads/2012/12/valve_t_shaped_people.png). The engineering team as a whole is polyglot, but the individual engineers are generalists who specialize.

## In Conclusion

We have found great value in encouraging different technologies in our stack. We can use the best tools for any problem, attract and empower awesome engineers, and stay flexible in our deployment and operations. Consider how being more open to different technologies could help your engineering team.

<small>Thanks to [@taterbase](http://twitter.com/taterbase), [@addisonjh](http://twitter.com/addisonjh) and [@laynemoseley](https://twitter.com/laynemoseley) for proofreading and suggestions.</small>
