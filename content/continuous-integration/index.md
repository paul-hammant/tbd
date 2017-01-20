---
date: 2016-03-09T20:10:46+01:00
title: Continuous Integration (CI)
weight: 40
---

{{< quote title="individuals practice Trunk Based Development, and teams practice CI" >}}
&mdash; *Agile* Steve Smith
{{< /quote >}}

For many years CI has been accepted by a portion of software development community to mean a server process 
is watching the source-control repository for changes, and verifying that they are correct, **regardless
of branching model**. However the original intention was to focus on the verification **single integration point** 
for the developer team. and do it daily if not more. The idea was for developers themselves to develop
habits to ensure everything going to that shared place (many times a day) was high quality, and for the CI server to 
merely verify that high quality (nightly).

CI as we know it today, was defined by Kent Beck, as one of the practices he included in 
"Extreme Programming"[![](/images/ext.png)](https://en.wikipedia.org/wiki/Extreme_programming)
in the mid nineties. Certainly in 1996, on the famous Chrysler Comprehensive Compensation System 
project[![](/images/ext.png)](https://en.wikipedia.org/wiki/Chrysler_Comprehensive_Compensation_System) Kent had all 
developers experiencing and enjoying the methodology - including the continuous integration aspect. The language for 
that project was Smalltalk and the single integration point was a Smalltalk image 
(a technology more advanced than a "mere" source-control systems that rule today).

Thus, the intention of CI, as defined, was pretty much exactly the same as Trunk Based Development, that emerged 
elsewhere. Trunk Based Development did not say anything about CI Servers at the outset, but there's overlap today
and such things expand the safety net around the branching model.

## CI servers performing verifications

Every development team bigger than, say, three people needs a CI server to guard the codebase against bad commits and mistakes of 
timing. Teams have engineered build scripts that do their thing quickly, hopefully all the way through functional 
tests (perhaps leveraging mocking at several levels). There is no guarantee that a developer ran the build though before 
committing. The CI server fills that gap, and verifies commits are good once they land in the trunk. Most enterprises 
have built a larger scaled capability around the CI technology, such that it can generally keep up with commits/pushes 
of the whole team by batching commits.

It is important to note that the build script that developers run prior to checking, is **the same one** that the CI 
process follows. Because of 
a need for succinct communication to development teams, the build is broken into gated steps. The classic steps would be
compile, test-compile, unit test invocation, integration test invocation, functional test invocation. A popular 
radiator-style visual indication of progress would be those shown as a left-to-right series of Green (passing) or Red 
(failing) icons/buttons with a suitably short legend:

![](/images/pipelines1.png)

The elapsed time between the commit and the "this commit broke the build" notification, is key. That is because the cost 
to repair things in the case of a break, goes up when additional commits have been pushed to the branch. One of the 
facets of the 'distance' that we want to reduce (refer [5 minute overview](/5-min-overview/)) is the distance to break.

Note: Continuous Integration Pipelines are better described in the best selling 
[Continuous Delivery](/publications/#continuous-delivery-july-27-2010) book. So are dozens of nuanced, lean inspired 
concepts for teams pushing that far.

## More Advanced CI

### CI per commit or batching?

Commiting/pushing directly to the shared trunk may be fine for teams with only a few 
commits a day. Fine too for teams that have a only a few developers who trust each other to be rigorous on their 
workstation before committing.

Setups having the CI server single threading on builds and the notification cycle around pass/fail will
occasion lead to the batching in a CI job. This is not a big problem for small teams. Batching is where one build is 
verifying two or more commits in one go. Failure of a build that contains two commits is not going to be hard to pick 
apart in order to know which one caused the failure. That confidence comes from the high probability the two commits 
were in different sections of the code base and are almost never entangled.

If teams are bigger though, with more commits a day, pushing something incorrect/broken to trunk could be disruptive to 
the team. Having the CI server deal with every commit is desirable. If the CI server is single-threading there is a risk
that the thing could fall behind. Thus, more advanced CI Server configurations have a master and many slaves setup so 
that build jobs can be parallelized. That's more of an investment than the basic setup, and but is getting easier and 
easier in the modern era with evolved CI technologies and services. And the likes of Docker. 

### CI Pre or Post Commit?

In terms of breakages, whether incorrect (say 'badly formatted'), or genuinely broken, finding that out **after the 
commit** is undesirable. Fixing things while the rest of the team watches or waits, is a team-throughput 
lowering practice. 

![](/images/ci_types.png)

Yellow = automated steps, Red = a potential to break build for everyone

Note: for committing/pushing straight to the shared trunk, code review and CI verification can happen in parallel. Most 
likely though is reviews happening after the CI server has cast its vote on the commit(s) quality.

Better setups have code-review and CI verification before the commit lands in the trunk for all to see:

![](/images/ci_types2.png)

It is best to have a human agreement (the code review), and machine agreement (CI verification) before the commit lands in 
the trunk.  There's still room for error based on timing, so CI needs to kick in a second time **after** the push to the shared 
trunk, but the chance of the second build failing so small that an automated revert/roll-back is probably the best way 
to handle it (and a notification).

### Google internal CI and tooling

Google is the most famous example of using Scaled CI infrastructure to keep up with commits (one every 30 seconds on 
average) to a single shared trunk. Google's setup would also allow the same infrastructure to verify *proposed* commits.

Their VCS technology in the early 2000's when they engineered this was Perforce, and it did not have an ability
to effectively do CI on commits that had not yet landed in the trunk. So Google made their own tooling for this and
pending commits were plucked from developer workstations for verification (and code review). After its initial 
creation, Google's now "Google3" setup, gained a UI ([Mondrian](/continuous-review/#mondrian-2006)) to allow the code 
review to be performed in a web-page, and the 
results of the pre-commit CI verification to shown alongside. 

Google also **leverage a second tier** of elastic infrastructure**, for scaled Selenium/WebDriver testing. Their 
"Selenium Farm" was also available to developers at their desks, who just wanted to run such tests against a stood-up
version of what they were working on. That was 2006/7 and these days, that would deploy Selenium-Grid internally or
leverage one of the online services for elastic Selenium testing. That and spend a lot of effort bringing Selenium 
tests down to split second.

### Github's platform raising the bar

In 2008 Github delivered the first version of their built in code review[![](/images/ext.png)](https://github.com/blog/42-commit-comments).
Nowadays this facility casually delivers the ability do do code-review **before** the push to the shared trunk. The 
immensely popular pull-request (PR) is the facilitator of that. Google's *thing* was possible now for ordinary teams. 
A few years later (with the help of third parties like TravisCI).
"build passes" and "build fails" badges were woven into the Github UI. This made it was clear whether the proposed PR 
would break the build or not were it to be merged into trunk. This combination was a game changer, and 
forced the entire VCS industry to take note, and plan equivalents.

## Industry CI confusion

ThoughtWorks commissioned a survey - "No One Agrees How to Define CI or CD"[![](/images/ext.png)](https://blog.snap-ci.com/blog/2016/07/26/continuous-delivery-integration-devops-research/).   
That Continuous Integration unfortunately thought of as compatible with branching models other than Trunk Based Development
was unfortunately showed to be true. Their chief scientist, Martin Fowler, writes about the effect in his Semantic Diffusion
article[![](/images/ext.png)](https://martinfowler.com/bliki/SemanticDiffusion.html).

{{< note title="This site's use of CI and Trunk Based Development" >}}
This site, is going to refer to the commit to **single shared code line** practice as Trunk Based Development, 
given other popular branching models (that are not Trunk Based Development) also benefit from CI servers watching for 
and verifying commits.
{{< /note >}}

There are many CI technologies and services available for teams to use. Some are free, and some are open source. 
Some store the configuration for a pipeline in VCS, and some store it somewhere else. In order to more smoothly support
[branch for release](branch_for_release/), the best CI solutions co-locate the configuration for a pipeline in the same 
branch too.

## Implementations

# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>

Date    | Type  | Article
--------|-------|--------
10 Sep 2000 | MartinFowler.com Article | [Continuous Integration - original version](https://www.martinfowler.com/articles/originalContinuousIntegration.html)
18 May 2006 | MartinFowler.com Article | [Continuous Integration](https://www.martinfowler.com/articles/continuousIntegration.html)
18 May 2015 | Hangout Debate | [Branching strategies and continuous delivery](https://www.youtube.com/watch?v=30yN4hefrt0)
02 Sep 2015 | Conference Presentation | [The Death of Continuous Integration](https://www.youtube.com/watch?v=q-dPdpxIcZQ)

