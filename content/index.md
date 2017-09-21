---
date: 2015-01-01T21:07:33+01:00
title: 介绍
type: index
weight: 0
---

<!-- print <h1 style="color: white; padding: 32px 20px 72px; background-image:url(/images/LogoSlim.png); background-repeat: no-repeat; background-size: 100% auto"><span style="background-color: #5677fc">Introduction</span></h1> print -->

## 综述
主干开发是一套代码分支管理策略，开发人员之间通过约定向被指定为“主干”*的分支提交代码，以此抵抗因为长期存在的多分支导致的开发压力。 此举可避免分支合并的困扰，保证随时拥有可发布的版本。

![](trunk1.png)
([key](/key/))


 &ast; Git 中的 *master* 分支


Trunk-Based Development is a key enabler of [Continuous Integration](/continuous-integration/) and by extension
[Continuous Delivery](/continuous-delivery/). When individuals on a team are committing their changes to the trunk
multiple times a day it becomes easy to satisfy the core requirement of Continuous Integration that all team
members commit to trunk at least once every 24 hours. This ensures the codebase is always releasable on demand
and helps to make Continuous Delivery a reality.

## Claims

- You should do Trunk-Based Development instead of GitFlow and other branching models that feature multiple long-running branches
- You can either do a direct to trunk commit/push (v small teams) or a Pull-Request workflow as long as those feature branches
  are short-lived and the product of a single person.

## Caveats

- Depending on the team size, and the rate of commits, 
  [short-lived feature branches](/short-lived-feature-branches/) are used for
  code-review and build checking (CI) to happen before commits land in the trunk for other developers to depend on.
  Such branches allow developers to engage in [eager and continuous code review](/continuous-review/) of contributions
  before their code is integrated into the trunk. Smaller teams may [commit direct to the trunk](/committing-straight-to-the-trunk/).

- Depending on the intended release cadence, there may be [release branches](/branch-for-release/) that are cut from the trunk on
  a just-in-time basis, are 'hardened' before a release (without that being a team activity), and **those branches are deleted** some time after release. Alternatively, there 
  may also be no release branches if the team is [releasing from Trunk](/release-from-trunk/), and choosing a "fix
  forward" strategy for bug fixes. Releasing from trunk is also for high-throughput teams, too.

- Teams should become adept with the related [branch by abstraction](/branch-by-abstraction/) technique for longer
  to achieve changes, and use [feature flags](/feature-flags/) in day to day development to allow for hedging on
  the order of releases (and other good things - see [concurrent development of consecutive releases](/concurrent-development-of-consecutive-releases/))

- If you have more than a couple of developers on the project, you are going to need a hook up a
  [build server](/continuous-integration/) to verify that their commits have **not broken the build** after they land in the trunk, and also when they are ready to be merged back into the trunk from a short-lived feature branch.

- Development teams can casually flex up or down in size (in the trunk) without affecting throughput or quality.
  Proof? [Google do Trunk-Based Development](/game-changers/index.html#google-revealing-their-monorepo-trunk-2016) and
  have **25000 developers and QA automators** in that single [monorepo](/monorepo/) trunk, that in their case can
  [expand or contract](/expanding-contracting-monorepos/) to suit the developer in question.

- People who practice the [GitHub-flow branching model](/alternative-branching-models/index.html#modern-claimed-high-throughput-branching-models) will feel
  that this is quite similar, but there is one small difference around where to release from.

- People who practice the Gitflow branching model will find this **very different**, as will many developers used to
  the popular ClearCase, Subversion, Perforce, StarTeam, VCS [branching models of the past](/alternative-branching-models/index.html#legacy-branching-models).

- [Many publications](/publications/) promote Trunk-Based Development as we describe it here. Those include the best-selling 'Continuous Delivery' and 'DevOps Handbook'. This should not even be controversial anymore!

## History

Trunk-Based Development is not a new branching model. The word 'trunk' is referent to the concept of a growing tree,
where the fattest and longest span is the trunk, not the branches that radiate from it and are of more limited length.

It has been a lesser known branching model of choice since the mid-nineties and considered tactically since the eighties.
The largest of development organizations, like Google (as mentioned) and Facebook practice it at scale.

Over 30 years different [advances to source-control technologies and related tools/techniques](/game-changers/) have made
Trunk-Based Development more (and occasionally less) prevalent, but is has been a branching model that many have stuck 
with through the years.

## This site

This site attempts to collect all the related facts, rationale and techniques for Trunk-Based Development together
in one place, complete with twenty-five diagrams to help explain things. All without using TBD as an acronym
even ~~once~~ twice.
