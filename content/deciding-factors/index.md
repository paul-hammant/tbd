---
date: 2016-03-09T20:08:11+01:00
title: Deciding factors
weight: 30
---

# Release cadence

## Iteration length

Different Agile teams focus on different iteration lengths. Some teams work at three-week iterations, some two, 
and some one. Some teams do not have an iteration at all - particularly ones doing Continuous Delivery.

If you are on a four week, or more iteration length, and each of those four weeks varies with proximity to the 
release and cannot change that you may be in a bind. You may be able follow the tenants of Trunk Based Development, 
benefit from a Continuous Integration daemon (as all branching models can), but you are not doing to be able to 
get all the way to Continuous Delivery (or Continuous Deployment).

## Waterfall

This one is easy. If you are doing waterfall, you are not close at all to the "do not break the build" mantra required
to do Trunk Based Development. Consider a short-iteration Agile methodology.

## Story size

Trunk Based Development needs you to have small stories/tasks. You starting work on a task, should only be matter
of hours before completing and and pushing it forward for code review. Longer than that, and there is going to be 
pressure to group a bunch of developers on a non-trunk branch, or worse have developers make branches/forks from your 
branch, or worse still take intermediate merges from your branch, despite your task not being complete.  

Generally speaking the whole development team should do what ever it can do break stories/tasks into smaller stories/tasks. 
In Agile, there is a INVEST mnemonic{{< ext url="https://en.wikipedia.org/wiki/INVEST_(mnemonic)" >}} that aids in the splitting
up or stories.

# SCM Technology Choice

You're SCM/VCS/source-control technology choice should facilitate update/pull/sync from the team's trunk many times 
a day. The elapsed time for the update/pull/sync should be less than three seconds for the situation where you 
already had latest of everything.  It should be no more than fifteen seconds the case of the shared trunk being ahead 
of you. 

Older versions of ClearCase and PVCS Dimensions would be 30 minutes for the former and 45 minutes for the latter. 
Double that if two team-mates were simultaneously trying to do the update/pull/sync operation. In that configuration, it 
was complete impossible for teams to choose to do trunk based development.

## Binaries in the Repo?

Depending on how many and how often they update, some SCM/VCS/source-control technologies are better than others. 
Perforce can handle terabytes of binaries and textual source. Subversion aims to. Git can only do so if configured in
Git-LFS mode.

## Repo size?

Git and Mercurial want to constrain repository history (ignoring Git-LFS) to 1GB. There are field reports of clones being 
many times bigger than that and still working, but the development team suggests 1GB as the top limit. In order to use Git 
and push through that ceiling yearly, you might be in a situation where you have to keep archiving a repository, and starting 
a new one with no history to have more head room.  Archiving might look like renaming the repository in Github, and turning it 
read-only so that all the history, issues, and code review comments are intact.

## Peak commit frequency

In Git if a colleague beat you to a commit/push on a branch (their code-review and automated CI passed). When you 
thought you were going to push, but Git informed you that you had to pull first, you might struggle to find a window 
to catch up and push ahead without encountering the same problem. Forks make that easier, and robots keeping 
pull-request branches abreast of origin:master help a lot.

# Conways Law

The org making applications and services that reflect the organization's own structure{{< ext url="https://en.wikipedia.org/wiki/Conway's_law" >}}. 
If your organization feels like this, and a Monorepo does not feel right, then MicroServices could the direction for you.

# Database migrations

In order get into the Trunk Based Development way, you'll need to find a way to handle table-shape changes, and even
population of existing rows where new/changed columns happen. Pramod Sadlage and Scott Amber's book 
"Refactoring Databases: Evolutionary Database Design"{{< ext url="https://www.amazon.com/Refactoring-Databases-Evolutionary-paperback-Addison-Wesley/dp/0321774515" >}}
goes into that much more, as does the [Continuous Delivery](/continuous-delivery/) book.

# Shared code

Trunk Based Development teams typically have common code ownership rules around contributions to different parts
of the source tree. If they do not have a full egalitarian system, they have objecting rules for the tree, that focus
on standards, and come with a promise of a prioritized and fair code review.

# Build times

Keeping build times short is key.

<!-- ## Parallelization

# CI capacity

# QA style

# Environments

## Developer workstations

## Shared services infra

# Code review

# Live config changes

# Tech debt accumulation

# Incident handling

# Backlog management

-->