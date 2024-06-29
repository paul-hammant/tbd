---
date: 2016-02-01T20:08:11+01:00
title: Deciding factors
weight: 21
---

## Release cadence

There are many factors that put pressure on the team to lengthen the interval between releases. Here are some.

### Iteration length

Different Agile teams focus on different iteration lengths. Some teams work at three-week iterations, some two, 
and some one. Some teams do not have an iteration at all - particularly teams doing Continuous Delivery.

If you are on a four week, or more iteration length, and each of those four weeks varies with proximity to the 
release and cannot change that you may be in a bind. You may be able to follow the tenets of Trunk-Based Development, 
benefit from a Continuous Integration daemon (as all branching models can), but you are not going to be able to 
get all the way to Continuous Delivery (or Continuous Deployment).

### Waterfall

This one is easy. If you are doing waterfall, you are not close at all to the "do not break the build" mantra required
to do Trunk-Based Development. Consider a short-iteration Agile methodology like Extreme Programming.

### Story size

Trunk-Based Development needs you to have small stories/tasks. Optimal is you starting work on a change, should only be a matter
of hours before completing and pushing it forward for code review. Longer than a couple of days, and there is going to be 
pressure to group a bunch of developers on a non-trunk branch and merge back later. Or worse, have developers make 
branches/forks from your in-progress branch. Or worse still, take intermediate merges from your branch, despite your 
change being incomplete.  

Generally speaking, the whole development team should do whatever it can to break stories/tasks into smaller stories/tasks. 
In Agile, there is an INVEST mnemonic{{< ext url="https://en.wikipedia.org/wiki/INVEST_(mnemonic)" >}} that aids in the splitting
up of stories.

### Build times

Keeping build times short is important in that it directly drives the number of commits a developer can do in a day.
If the build time is a couple of minutes, developers are likely to keep a high pace. If the build time is 30 minutes or
worse, developers change pace to match only a couple of commits a day and drop their throughput.

## VCS Technology Choice

Your VCS/source-control technology choice should facilitate update/pull/sync from the team's trunk many times 
a day. The elapsed time for the update/pull/sync should be less than three seconds for the situation where you 
already had latest of everything. It should be no more than fifteen seconds the case of the shared trunk being ahead 
of you. 

Older versions of ClearCase and PVCS Dimensions would be 30 minutes for the former and 45 minutes for the latter. 
Double that if two team-mates were simultaneously trying to do the update/pull/sync operation. In that configuration, it 
was completely impossible for teams to practice Trunk-Based Development.

### Binaries in the Repo?

Depending on how many and how often they update, some SCM/VCS/source-control technologies are better than others. 
Perforce can handle terabytes of binaries and textual source. Subversion aims to. Git can only do large binaries  if 
configured in Git-LFS mode{{< ext url="https://git-lfs.github.com/" >}}.

### Repo size?

It is suggested that Git and Mercurial really should not have a history (ignoring Git-LFS) that exceeds 1GB. There are field reports of clones being 
many times bigger than that and still working, but the development team suggests 1GB as the top limit. In order to use Git 
and push through that ceiling yearly, you might be in a situation where you have to keep archiving a repository, and starting 
a new one with no history to have more head room. Archiving might look like renaming the repository in GitHub, and turning it 
read-only so that all the history, issues, and code review comments are intact. Simpler clone-rationalization strategies might 
include recommending a "--shallow-since" date on cloning, or leveraging more recent partial clone capabilities to clone the full repo 
commit history without getting historical blobs until they are needed.


### Peak commit frequency

In "pure" Git, if a colleague beat you to a commit/push on a branch (their code-review and automated CI passed) when you 
thought you were going to push, Git will inform you that you have to pull first. You pull, and you resolve your merge clashes 
(hopefully none), and then push again. On highly-active repos, you might struggle to find a window open long enough to push in 
this way without encountering the same problem. This is known as the "race to push".

Fork-based "pull requests" and similar branch-based "merge requests" in hosted git services solve this to a degree, with robots 
keeping pull-request branches abreast of `origin:main` automatically as long as no conflicts arise.

If you are using Github as your repository host, [Github Merge Queue](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/configuring-pull-request-merges/managing-a-merge-queue) can help solve the "race to push" problem. This will automate pull request merges into a busy branch to increase velocity.

Even with Pull Requests, however, very high commit frequencies to the shared repo means contention and an artificial 
serialization. Microsoft acknowledged this as one
of the motivations to their Git Virtual File System (~~GitVFS~~ ~~GVFS~~ VFS for Git{{< ext url="https://github.com/Microsoft/VFSForGit" >}} which is Windows only for now).

{{< quote title="Git has critical serialization points that will cause a queue to back up badly" >}}
<span>&mdash; Brian Harry</span><br>
<span style="margin-left: 30px">Refer to Brian's "More on GVFS" blog entry<span class="rref"><a class="inline-ref" style="border-bottom: 0" target="_blank" href="https://blogs.msdn.microsoft.com/bharry/2017/02/07/more-on-gvfs/"><img style="padding: 0 0 0 3px; width: 16px; height: 14px" src="/images/ext.png" alt=""></a></span></span>
{{< /quote >}}

We're sure that within a few years, Git will be able to handle huge scale too. Whether with the Microsoft technologies, or 
something else.

## Conway's Law

The organization creates applications and services that reflect the organization's own structure{{< ext url="https://en.wikipedia.org/wiki/Conway's_law" >}}. 
If your organization feels like this, and a Monorepo does not feel right, then MicroServices could be the direction for you.

## Database migrations

In order to manage database schemas in a Trunk-Based Development way you will need to find a way to handle table-shape changes under source control, and even
manage existing data where new/changed columns have happened. Pramod Sadlage and Scott Amber's book 
"Refactoring Databases: Evolutionary Database Design"{{< ext url="https://www.amazon.com/Refactoring-Databases-Evolutionary-paperback-Addison-Wesley/dp/0321774515" >}}
goes into that much more, as does the [Continuous Delivery](/continuous-delivery/) book.

## Shared code

Trunk-Based Development teams typically have common code ownership rules around contributions to different parts
of the source tree. If they do not have a fully egalitarian system, they have objective rules for contributions to the tree. 
Rules that focus on standards and come with a promise of a prioritized and fair code review. Trunk-Based Development 
teams might have fine-grained write permissions for directories within the trunk, but **never** have any impediment 
to reading files in the trunk - everyone can see everything.

<!-- ## Parallelization

## CI capacity

## QA style

## Environments

### Developer workstations

### Shared services infra

## Code review

## Live config changes

## Tech debt accumulation

## Incident handling

## Backlog management

-->
