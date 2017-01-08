---
date: 2016-03-09T20:10:46+01:00
title: Continuous Integration (CI)
weight: 40
---

Continuous Intgration (CI) as a concept was defined in 1991 by Grady Booch. Wikipedia
[details it best](https://en.wikipedia.org/wiki/Continuous_integration). 
According to its intentions, it and Trunk Based Development strive to achieve the exact same thing.

However, for many years CI has been accepted by most software development professionals to mean a daemon installed
somewhere that is watching a source-control repository for changes, and verifying that they are correct, before 
perhaps makiing binaries that could be deployed/shipped.  ThoughtWorks noted that a survey showed this 
to be true: ([No One Agrees How to Define CI or CD](https://blog.snap-ci.com/blog/2016/07/26/continuous-delivery-integration-devops-research/).

{{< note title="CI != Trunk Based Development" >}}
This page, if not this whole site, is going to match industry understanding and separate the daemon from the branching
model, given other popular branching models that are not Trunk Based Development benefit from CI daemons verifying 
commits too.
{{< /note >}}

Every dev team bigger than say three people needs a CI daemon to guard the codebase against bad work and mistakes of 
timing. Teams have  engineered build scripts that fo their thing quickly, hopefully all the way through functional 
tests (and perhaps  leveraging mocking at several levels), there is no guarantee that a developer ran it before 
committing. The CI  daemon fills that gap, and verifies commits are good once they land in the trunk. Most enterprises 
have built a larger scaled capability around the CI technology, such that it can:

* generally keep up with commits/pushes of the whole team by batching commits.

Some companies have scaled that infrastructure so that it can:

* run the whole build **per commit** without falling behind
* run the build for short-lived feature branches (PR branches/forks for Git) as well.
* leverage a **second tier** of scaled Selenium (for example) testing infrastructure

Google is the most famous example of using Scaled CI infrastructure to keep up with commits (every 30 seconds) to
a single shared trunk.

Generally the build script that developers run prior ro checking, is the thing that the CI process follows. Because of 
a need for succinct communication to dev teams, the build is broken into gated steps. The classic steps would be
compile, test-compile, unit test invocation, integration test invocation, functional test invocation. A popular 
radiator-style visual indication of progress would be those shown as a left-to-right series of Green (passing) or Red 
(failing) icons/buttons with a suitably short legend:

![](/images/pipelines1.png)

The elapsed time between the commit and the "this commit broke the build" notification, is key. That is because the cost 
to repair things in the case of a break, goes up when additional commits have been pushed to the branch. One of the 
facets of the 'distance' that we want to reduce (refer [5 minute overview](/5-min-overview/)) is the distance to break.