---
date: 2017-01-05T21:07:33+01:00
title: Introduction
type: index
weight: 0
---

## One line summary

A source-control branching model, where a single branch called trunk* is where developers share code, and any pressure 
to create other long-lived development branches is resisted, by employing one or more documented techniques. 

![](/images/trunk1.png)
  
 &ast; 'master', in Git nomenclature    
  
## Caveats

- If you have more than a couple of developers on the project, you are going to need a hook up a 
  [Continuous Integration](continuous-integration/) Server to verify the commits being done.

- Depending on the team size, and the rate of commits, **very short lived** feature/task branches are used for 
  code-review and build checking (CI) to happen before commits land in the trunk for other developers to depend on.
  Github coined "Pull-Requests" [![](/images/ext.png)](https://github.com/blog/3-oh-yeah-there-s-pull-requests-now)
  and popularized it, after Google's internal Mondrian tech was disclosed.

- Depending on the intended release cadence, there may be [release branches](/branch-for-release/) (cut from trunk on 
  a just-in-time basis) that are 'hardened' before a release. Alternatively there may also be no release branches if 
  the team is [releasing from Trunk](/release-from-trunk/).

- Teams have to become adept with the related [branch by abstraction](/branch-by-abstraction/) technique, and 
  use [feature flags](/feature-flags/) in day to day development to facilitate 
  [concurrent development of consecutive releases](concurrent-development-of-consecutive-releases/), in order to
  resist the pressure for long running branches.

## History

Trunk Based Development is not a new branching model. The word 'trunk' is referent to the concept of a growing tree,
where the fattest and longest span is the trunk, not the branches that radiate from it and are of more limited length.

It has been a lesser known branching model of choice since the mid-nineties, and considered tactically since the eighties. 
The largest of development organizations, like Google and Facebook practice it at scale. Google has millions of 
individual source files in a single trunk branch of a repository that contains 86 terabytes of history. We cover that 
advanced setup in [Monorepos](monorepos/).

# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>

Date    | Type  | Article
--------|-------|--------
01 Jul 2016 | Blog Entry | [Why Google Stores Billions of Lines of Code in a Single Repository](http://cacm.acm.org/magazines/2016/7/204032-why-google-stores-billions-of-lines-of-code-in-a-single-repository/fulltext)
