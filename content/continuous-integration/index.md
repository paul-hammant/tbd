---
date: 2016-03-09T20:10:46+01:00
title: Continuous Integration (CI)
weight: 40
---

## Daemon Confusion

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

## Verifications

Every dev team bigger than say three people needs a CI daemon to guard the codebase against bad work and mistakes of 
timing. Teams have engineered build scripts that fo their thing quickly, hopefully all the way through functional 
tests (and perhaps leveraging mocking at several levels), there is no guarantee that a developer ran it before 
committing. The CI daemon fills that gap, and verifies commits are good once they land in the trunk. Most enterprises 
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

## Advanced CI 

Commiting/pushing directly to the shared trunk may be fine for teams with not too many 
commits a day, or have a only a few developers who trust each other to be rigorous on their workstation before commit.

If teams are bigger though, with more commits a day, pushing something incorrect/broken to trunk could be disruptive to 
the team. Whether incorrect (say 'badly formatted'), or broken, finding that out after the commit is undesirable. 
Fixing things while the rest of the team watches or waits, is a team-throughput lowering practice. 

![](/images/ci_types.png)

Yellow = automated steps
Red = potentially disruptive

Note: for committing/pushing straight to the sahred trunk, code review and CI verification can happen in parallel. Most 
likely though is review happens after the CI daemon has cast it's vote on the commit (or commits if batching).

Better setups have code-review and CI verification before the commit lands in the trunk for all to see:

![](/images/ci_types2.png)

It is best to have a human agreement (the code review), and machine agreement (CI verification) before the commit lands in 
the trunk.  There's still room for error based on timing, so CI needs to kick in again after the push to the shared 
trunk, but it is so small that an automated revert/roll-back is probably the best way to handle it (and a notification).

With the advent of Github in particular, code-review **before** the push to the shared trunk, was possible for ordinary
teams. Google had engineered their Perforce trunk in the early 00's to have pre-commit code review and CI verification,
 but that wasn't avalable outside Google. Subversion using teams were in the same boat.

# References Elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>

Date    | Type  | Article
--------|-------|--------
2015-05-18 | Hangout Debate | [Branching strategies and continuous delivery](https://www.youtube.com/watch?v=30yN4hefrt0)
2015-09-02 | Conference Presentation | [The Death of Continuous Integration](https://www.youtube.com/watch?v=q-dPdpxIcZQ)

