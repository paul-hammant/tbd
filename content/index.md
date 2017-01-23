---
date: 2017-01-05T21:07:33+01:00
title: Introduction
type: index
weight: 0
---

## One line summary

A source-control branching model, where developers can share code on a single branch called trunk*, 
and resist any pressure to create other long-lived development branches by employing one or more documented techniques. 

![](/images/trunk1.png)
  
 &ast; 'master', in Git nomenclature

Trunk Based Development is a key enabler of [Continuous Integration](continuous-integration/), and by extension
[Continuous Delivery](continuous-delivery/). When individuals on a team are committing their changes to the trunk
multiple times a day it becomes easy to satisfy the core requirement of Continuous Integration that all team
members commit to trunk at least once every 24 hours. This ensures the codebase is always releasable on demand
and helps to make Continuous Delivery a reality.
  
## Caveats

- If you have more than a couple of developers on the project, you are going to need a hook up a 
  [build server](continuous-integration/) to verify their commits

- Depending on the team size, and the rate of commits, **very short lived** feature/task branches are used for 
  code-review and build checking (CI) to happen before commits land in the trunk for other developers to depend on.
  This allows and engage in [eager and continuous code review](continuous-review/) of contributions before they land
  in the trunk.

- Depending on the intended release cadence, there may be [release branches](/branch-for-release/) (cut from trunk on 
  a just-in-time basis) that are 'hardened' before a release. Alternatively there may also be no release branches if 
  the team is [releasing from Trunk](/release-from-trunk/).

- Teams should become adept with the related [branch by abstraction](/branch-by-abstraction/) technique, and 
  use [feature flags](/feature-flags/) in day to day development.
   
- Development teams can transition from a maintenance-centric low head-count to a sudden 10x increase, tackling multiple
  parallel projects on the same application or service, with ease. [Branch by abstraction](/branch-by-abstraction/) 
  and [feature flags](/feature-flags/) again, but towards 
  [concurrent development of consecutive releases](concurrent-development-of-consecutive-releases/) to further
  resist the pressure for the creation of long-lived branches. Bonus: you can hedge on the order of releases. 

## History

Trunk Based Development is not a new branching model. The word 'trunk' is referent to the concept of a growing tree,
where the fattest and longest span is the trunk, not the branches that radiate from it and are of more limited length.

It has been a lesser known branching model of choice since the mid-nineties, and considered tactically since the eighties. 
The largest of development organizations, like Google and Facebook practice it at scale. 

Google, for one, has millions of 
individual source files in a single trunk branch of a repository that contains 86 terabytes of history, with 
25,000 developers contributing to it constantly. We cover that advanced setup in [Monorepos](monorepos/), And Googlers
talked about the incedible scale of their trunk 
[in a magazine article and a video](/game-changers#google-sharing-their-trunk-usage-2016).

Over 30 years different [advances to source-control technologies and related tools/techniques](/game-changers) have made 
Trunk Based Development more (and occasionally less) necessary.

## This portal

This portal attempts to collect all the related facts, rationale and techniques for Trunk Based Development together
in one place, complete with twenty four diagrams to help explain things. All without using TBD as an acronym
even ~~once~~ twice.