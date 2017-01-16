---
date: 2016-03-09T20:10:46+01:00
title: Continuous Integration (CI)
weight: 40
---

## Founding History

{{< quote title="individuals practice TBD, and teams practice CI" >}}
&mdash; *Agile* Steve Smith
{{< /quote >}}

Continuous Integration (CI) as we know it today, was defined by Kent Beck, as one of the practices he included in 
"Extreme Programming"[![](/images/ext.png)](https://en.wikipedia.org/wiki/Extreme_programming)
in the mid nineties. Certainly the famous Chrysler Comprehensive Compensation System 
project[![](/images/ext.png)](https://en.wikipedia.org/wiki/Chrysler_Comprehensive_Compensation_System) 
in 1996 had all developers experiencing and enjoying the methodology. "Continuous Integration"
for the "C3" project, meant end-of-day integration test execution. It also meant developers checking into the single
shared "image" whenever a unit of work was completed. For an Extreme Programming team, with pair-programming and 
"small stories" guiding what to develop, that could be a few times a day, even back then.
Wikipedia also attempts to define it[![](/images/ext.png)](https://en.wikipedia.org/wiki/Continuous_integration). 

However, for many years CI has been accepted by a portion of software development community to mean a server process
on a server that is watching the source-control repository for changes, and verifying that they are correct, **regardless
of branching model**. ThoughtWorks commissioned a survey - "No One Agrees How to Define CI or CD" - that unfortunately 
showed this to be true[![](/images/ext.png)](https://blog.snap-ci.com/blog/2016/07/26/continuous-delivery-integration-devops-research/).
Their chief scientist, Martin Fowler, writes about the effect in his Semantic Diffusion
[![](/images/ext.png)](https://martinfowler.com/bliki/SemanticDiffusion.html) article.

{{< note title="This site's use of CI and Trunk Based Development" >}}
This site, is going to refer to the commit to **single shared codeline** practice as Trunk Based Development, 
given other popular branching models that are not Trunk Based Development benefit from CI servers watching for and 
verifying commits too.
{{< /note >}}

There are many CI technologies and services available for teams to use. Some are free, and some are open source. 
Some store the configuration for a pipeline in VCS, and some store it somewhere else. In order to more smoothly support
[branch for release](branch_for_release/), the best CI solutions co-locate the configuration for a pipeline in the same 
branch too.

## CI performing verifications

Every dev team bigger than say three people needs a CI server to guard the codebase against bad work and mistakes of 
timing. Teams have engineered build scripts that fo their thing quickly, hopefully all the way through functional 
tests (and perhaps leveraging mocking at several levels), there is no guarantee that a developer ran it before 
committing. The CI server fills that gap, and verifies commits are good once they land in the trunk. Most enterprises 
have built a larger scaled capability around the CI technology, such that it can:

* generally keep up with commits/pushes of the whole team by batching commits.

Some companies have scaled that infrastructure so that it can:

* run the whole build **per commit** without falling behind
* run the build for short-lived feature branches (PR branches/forks for Git) as well.
* leverage a **second tier** of elastic infrastructure, for scaled Selenium/WebDriver testing 

Google is the most famous example of using Scaled CI infrastructure to keep up with commits (one every 30 seconds on 
average) to a single shared trunk.

Generally the build script that developers run prior ro checking, is **the same one** that the CI process follows. 
Because of 
a need for succinct communication to dev teams, the build is broken into gated steps. The classic steps would be
compile, test-compile, unit test invocation, integration test invocation, functional test invocation. A popular 
radiator-style visual indication of progress would be those shown as a left-to-right series of Green (passing) or Red 
(failing) icons/buttons with a suitably short legend:

![](/images/pipelines1.png)

The elapsed time between the commit and the "this commit broke the build" notification, is key. That is because the cost 
to repair things in the case of a break, goes up when additional commits have been pushed to the branch. One of the 
facets of the 'distance' that we want to reduce (refer [5 minute overview](/5-min-overview/)) is the distance to break.

Continuous Integration Pipelines are better described in the best selling 
[Continuous Delivery](/publications/#continuous-delivery-july-27-2010) book.

## CI per commit 

Commiting/pushing directly to the shared trunk may be fine for teams with not too many 
commits a day, or have a only a few developers who trust each other to be rigorous on their workstation before commit.

If teams are bigger though, with more commits a day, pushing something incorrect/broken to trunk could be disruptive to 
the team. Whether incorrect (say 'badly formatted'), or broken, finding that out after the commit is undesirable. 
Fixing things while the rest of the team watches or waits, is a team-throughput lowering practice. 

![](/images/ci_types.png)

Yellow = automated steps, Red = a potential to break build for everyone

Note: for committing/pushing straight to the shared trunk, code review and CI verification can happen in parallel. Most 
likely though is review happens after the CI server has cast its vote on the commit (or commits if batching).

Better setups have code-review and CI verification before the commit lands in the trunk for all to see:

![](/images/ci_types2.png)

It is best to have a human agreement (the code review), and machine agreement (CI verification) before the commit lands in 
the trunk.  There's still room for error based on timing, so CI needs to kick in again after the push to the shared 
trunk, but it is so small that an automated revert/roll-back is probably the best way to handle it (and a notification).

With the advent of Github in particular, code-review **before** the push to the shared trunk, was possible for ordinary
teams. Google had engineered their Perforce trunk in the early 00's to have pre-commit code review and CI verification,
but that wasn't avalable outside Google. Subversion using teams were in the same boat.

# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>

Date    | Type  | Article
--------|-------|--------
18 May 2015 | Hangout Debate | [Branching strategies and continuous delivery](https://www.youtube.com/watch?v=30yN4hefrt0)
02 Sep 2015 | Conference Presentation | [The Death of Continuous Integration](https://www.youtube.com/watch?v=q-dPdpxIcZQ)

