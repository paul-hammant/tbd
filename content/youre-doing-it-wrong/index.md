---
date: 2016-09-01T20:08:11+01:00
title: Você está fazendo errado
weight: 91
---

## Merely naming a branch trunk.

Say you are using Subversion, and you accepted its default directory design, when you made a new repository. That will
give you 'trunk', 'tags' and 'branches' as directory names. The mere fact that you have a branch called trunk does not
mean you are doing Trunk-Based Development. "We merge branches back to trunk often" can be heard a lot in the industry,
and if you are grouping multiple developers on those branches of they not deleted after a couple of days, then it is
not the Trunk-Based Development branching model.

## Cherry-pick of bug fixes from release branches to the trunk

All your developers are using a trunk and they are doing the right thing with respect to not breaking the build. Your release
cadence is infrequent enough to allow you to cut a release branch on a just in time basis and then harden that in the run
up to the actual release.

But, if you are fixing bugs on the release branch and merging them down to the trunk you are doing
it wrong. There is a chance you might forget to merge it down, and then there is going to be a regression at the next
release moment (fresh branch cut from the trunk). Then egg on face, and recriminations.

Bugs should be reproduced and fixed on the trunk, and then **cherry-picked** to the release branch. A build should
happen from that, a second confirmation that the issue has been remediated, and that deployment should go live (perhaps
a point release).  If you can not reproduce bugs on the trunk (truly rare), then you have permission to go ahead and
reproduce it on the release branch, fix it there, and merge back.

## Merging rather than cherry-pick to/from a release branch

The developers cut a release branch because their release cadence is low, and they're hardening and certifying the release
there. BUT in the days that lead up to the release, they are also doing general merges up to the release branch from
the trunk. That is not right - it seems like they cut the branch on the wrong day. Maybe the business people on the team
are pushing too hard to make a date.

Cherry-picking every commit since the branch-cut to the branch from the trunk is the same thing of course.

## Duration of 'short-lived' feature branches

The [short-lived feature branch](short-lived-feature-branches) should only last a day or two and never diverge from the trunk enough so that a
merge back is problematic. After the seal of approval from code reviewers and CI
daemons, it should be merged back into the trunk. It should be deleted, as proof of convergence.
The developer in question may then go ahead and make the next short-lived feature branch for the next story/task they're doing.

## Numbers of developers on 'short-lived' feature branches

If there is more that one developer (and the developer's pairing partner) on the same [short-lived feature branch](/short-lived-feature-branches/),
then that branch is at risk of not being short-lived. It is at risk of being more and more like a release branch
under active development, and not short at all.

There is a risk too, that a developer may choose to pull changes to their workstation **from a short-lived feature
branch** rather from the trunk. They may think that the code review for that short-lived feature branch is going to take
too long, or they need the changes before they are ready. Unfortunately, there is no way that the current generation of
code portals can prevent people pulling changes from non-trunk branches.

## Every day not being the same for developers.

Developers take stories or tasks from the backlog, implement them with tests, and push them through code review and quality checks
into the shared trunk. They don't slow down that activity as they get closer to a release date. At least the majority do not. A very
small subset of the development team may focus on the release candidates being made from the release branch (if that
branch exists at all), and towards fixes in the trunk that will be cherry-picked into that branch. For most of the team, though,
every day looks the same. Also proximity to a release does not slow down the rate at which changes are being pushed into the
trunk. **There is certainly no "code freeze" with Trunk-Based Development**, as team leadership focuses on protecting the
majority of developers from the distraction of release preparation. If that protection is missing, something needs
fine-tuning, and the branching model could be it.

## Keeping a single release branch

If you are making a release branch, you should not keep it alive for a series of major releases. You principal
mechanism to land code on that branch is the branch creation itself. After that only cherry picks for bug
fixes as found. Even then they should diminish over time. If release branches is your model then the reality should
be that pressure mounts to create a new release branch (from trunk), and evidence is that there is no more
cherry-picks from trunk to the old release branch. In terms of release you might have witnessed releases 1.1, 1.1.1 and 1.1.2 be done from tags on that release branch, but the cherry picks should diminish to zero over time, and activity reconvene around an newer release branch - for the 1.2 release probably.

## Merge from one release branch to another release branch

We only merge from trunk to release branches (if we branch at all), and then only a small percentage of the
commits to trunk, and only using the cherry-pick method of merging.  Sure, two release branches could be in
play for short periods of time, but the team should cherry-pick merge from trunk to two different branches.
In some VCS tools (Perforce and Subversion) those can be in the same atomic commit, but that is not
strictly necessary.

## Merge everything back from a release branch at the end of the release branch

Bug fixing on the release branch? If yes, then that is covered above. If you are not doing that then you have no need
to merge anything back from the release branch - you can just delete it after you're sure there will not be any more
releases from it.
