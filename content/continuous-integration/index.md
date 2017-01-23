---
date: 2016-03-09T20:10:46+01:00
title: Continuous Integration (CI)
weight: 40
---

{{< quote title="individuals practice Trunk Based Development, and teams practice CI" >}}
&mdash; *Agile* Steve Smith
{{< /quote >}}

## Continuous Integration - as defined

For many years CI has been accepted by a portion of software development community to mean a daemon process 
that is watching the source-control repository for changes, and verifying that they are correct, **regardless
of branching model**. 

However, the original intention was to focus on the verification **single integration point** 
for the developer team. and do it daily if not more. The idea was for developers themselves to develop
habits to ensure everything going to that shared place many times a day was of high enough quality, 
and for the CI server to merely verify that quality, nightly.

CI as we know it today, was defined by Kent Beck, as one of the practices he included in 
"Extreme Programming"{{< ext url="https://en.wikipedia.org/wiki/Extreme_programming" >}}
in the mid nineties. Certainly in 1996, on the famous Chrysler Comprehensive Compensation System 
project{{< ext url="https://en.wikipedia.org/wiki/Chrysler_Comprehensive_Compensation_System" >}} Kent had all 
developers experiencing and enjoying the methodology - including the continuous integration aspect. The language for 
that project was Smalltalk and the single integration point was a Smalltalk image 
(a technology more advanced than a "mere" source-control systems that rule today).

Thus, the intention of CI, as defined, was pretty much exactly the same as Trunk Based Development, that emerged 
elsewhere. Trunk Based Development did not say anything about Continuous Integration daemons directly or indirectly, 
but there is an overlap today - the safety net around a mere branching model (and a bunch of techniques) is greatly 
valued.

Martin Fowler (with Matt Foemmel) called out Continuous Integration in a article in 2000
{{< ext url="https://www.martinfowler.com/articles/originalContinuousIntegration.html" >}}, 
(rewritten in 2006{{< ext url="https://www.martinfowler.com/articles/continuousIntegration.html" >}}), and 
ThoughtWorks colleagues went on to build the then-dominant "Cruise Control" {{< ext url="http://cruisecontrol.sourceforge.net" >}} 
in early 2001. Cruise Control co-located the CI configuration on the branch being built next to the build script, as it 
should be.

## CI daemons performing verifications

Every development team bigger than, say, three people needs a CI daemon to guard the codebase against bad commits and mistakes of 
timing. Teams have engineered build scripts that do their thing quickly, hopefully all the way through functional 
tests (perhaps leveraging mocking at several levels). There is no guarantee that a developer ran the build though before 
committing. The CI daemon fills that gap, and verifies commits are good once they land in the trunk. Most enterprises 
have built a larger scaled capability around the CI technology, such that it can generally keep up with commits/pushes 
of the whole team by batching commits.

### Humans and daemons do the same build

It is important to note that the build script that developers run prior to checking, is **the same one** that the CI 
process follows. Because of 
a need for succinct communication to development teams, the build is broken into gated steps. The classic steps would be
compile, test-compile, unit test invocation, integration test invocation, functional test invocation. 

### Radiators

A popular 
radiator-style visual indication of progress would be those shown as a left-to-right series of Green (passing) or Red 
(failing) icons/buttons with a suitably short legend:

![](/images/pipelines1.png)

This should go up on TVs if developers are co-located. It should also be a click through from notification emails.

### Quick build news

The elapsed time between the commit and the "this commit broke the build" notification, is key. That is because the cost 
to repair things in the case of a break, goes up when additional commits have been pushed to the branch. One of the 
facets of the 'distance' that we want to reduce (refer [5 minute overview](/5-min-overview/)) is the distance to break.

### Pipelines - further reading

Note: Continuous Integration Pipelines are better described in the best selling 
[Continuous Delivery](/publications/#continuous-delivery-july-27-2010) book. So are dozens of nuanced, lean inspired 
concepts for teams pushing that far.

## Advanced CI topics

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
the team. Having the CI daemon deal with every commit is desirable. If the CI daemon is single-threading "jobs" there is a risk
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
likely though is reviews happening after the CI daemon has cast its vote on the quality of the commit(s).

Better setups have code-review and CI verification before the commit lands in the trunk for all to see:

![](/images/ci_types2.png)

It is best to have a human agreement (the code review), and machine agreement (CI verification) before the commit lands in 
the trunk.  There's still room for error based on timing, so CI needs to kick in a second time **after** the push to the shared 
trunk, but the chance of the second build failing so small that an automated revert/roll-back is probably the best way 
to handle it (and a notification).

TODO links to game changers

## Industry CI daemon confusion

ThoughtWorks commissioned a survey - "No One Agrees How to Define CI or CD"{{< ext url="https://blog.snap-ci.com/blog/2016/07/26/continuous-delivery-integration-devops-research" >}}.   
That the hypothesis of Continuous Integration being thought of as compatible with branching models other than Trunk Based Development
was unfortunately showed to be true. Their chief scientist, Martin Fowler, writes about the general effect in his "Semantic Diffusion"
article {{< ext url="https://martinfowler.com/bliki/SemanticDiffusion.html" >}}. 

Martin also wrote specifically on the 
lamentable *pat on the back* that multi-active-branch teams give themselves when they setup a CI server/daemon for one
or all of those branches: "Continuous Integration Certification" 
{{< ext url="https://martinfowler.com/bliki/ContinuousIntegrationCertification.html" >}} and within that *a great
coin* "Daemonic Continuous Integration" for this effect.

{{< note title="This site's use of CI and Trunk Based Development" >}} 
Given other popular branching models (that are not Trunk Based Development) **also** benefit from CI servers watching 
for and verifying commits, this site is going to refer to the commit to a **enforced single shared source-control branch* 
practice as Trunk Based Development.
{{< /note >}}

There are many CI technologies and services available for teams to use. Some are free, and some are open source. 
Some store the configuration for a pipeline in VCS, and some store it somewhere else. In order to more smoothly support
[branch for release](branch_for_release/), the best CI solutions co-locate the configuration for a pipeline in the same 
branch too.

## Server/daemon implementations

* [Jenkins](https://jenkins.io/) commercial service, for [Jenkins Open Source](https://github.com/jenkinsci) - on-premises installable
* [Travis-CI](https://travis-ci.org/) - cloud
* ThoughtWorks' [Snap-CI](https://www.snap-ci.com/) - cloud
* [Circle-CI](https://circleci.com/) - cloud
* ThoughtWorks' [Go CD](https://www.gocd.io) - cloud and on premises install
* [Codeship](https://codeship.com/) - cloud
* Atlassian's [Bamboo](https://www.atlassian.com/software/bamboo) - on premises install
* JetBrains' [TeamCity](https://www.jetbrains.com/teamcity/) - on premises install
* Microsoft's [TFS platform](https://www.visualstudio.com/tfs/) - on premises install (built in to larger platform)

Note, for Jenkins, you should use it with GroupOn's [DotCI](https://github.com/groupon/DotCi) to match that early 
CruiseControl feature of co-locating the config with the thing being built/verified in source-control.

# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>

Date    | Type  | Article
--------|-------|--------
10 Sep 2000 | MartinFowler.com Article | [Continuous Integration - original version](https://www.martinfowler.com/articles/originalContinuousIntegration.html)
18 May 2006 | MartinFowler.com Article | [Continuous Integration](https://www.martinfowler.com/articles/continuousIntegration.html)
18 May 2015 | Hangout Debate | [Branching strategies and continuous delivery](https://www.youtube.com/watch?v=30yN4hefrt0)
02 Sep 2015 | Conference Presentation | [The Death of Continuous Integration](https://www.infoq.com/presentations/death-continuous-integration)

