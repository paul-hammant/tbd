---
date: 2016-03-09T20:08:11+01:00
title: You're doing It Wrong
weight: 0
---

## Merely naming a branch trunk.

Say you are using Subversion, and you accepted its default directory design, when you made a new repository. That will
give you 'trunk', 'tags' and 'branches' as directory names. The mere fact that you have a branch called trunk does not
mean you are doing trunk based development. "We merge branches back to trunk often" can be heard a lot in the industry,
and if you are grouping multiple developers on those branches of they not deleted after a couple of days, then it is 
not the trunk based development branching model.

## Direction of Cherry Pick

All your developers are using a trunk and they're doing the right thing re not breaking the build. Your release 
cadence is infrequent enough to allow you to cut a release branch on a just in time basis, and harden that in the run
up to the actual release. 

If you are fixing the bug on the release branch and merging it down to the trunk you are doing 
it wrong - although there is debate about this. 
There's a chance you might forget to merge it down, and then there's going to be a regression at the next 
release moment (fresh branch cut from trunk).

Bugs should be reproduced and fixed on the trunk, and then **cherry-picked** to the release branch. A build should 
happen from that, a second confirmation that the issue has been remediate, and that deployment should go live (perhaps 
a point release).  If you can't reproduce on the trunk (truly rare), then you've permission to go ahead and reproduce
it on the release branch, fix it there, and merge back.

## Merging rather than cherry-pick to/from a release branch

The developers cut a release branch because their release cadence is low, and they're hardening and certifying the release
there. BUT in the days that lead up to the release, they are also doing general merges up to the release branch from 
the trunk. That is not right - it is like they cut the branch on the wrong day. Maybe the business people on the team
are pushing too hard to make a date.

Cherry picking every commit since the branch-cut to the branch from the trunk is the same thing of course.

## Duration of 'short lived' feature branches

The short-lived feature branch should only last a day or two, and never diverge from the trunk enough so that a 
merge back is problematic. After the seal of approval from code reviewers and CI 
daemons it should be merged back into the trunk. It should be deleted, as proof of convergence.
The developer in question may then go ahead and make the next short-lived feature branch for the next story/task they're doing.

## Numbers of developers on 'short lived' feature branches

If there's more that one developer (and the developer's pairing partner) on the same short-lived feature branch, 
then that branch is at risk of not being short-lived. It is at risk of being more and more like a release branch 
under active development, and not short at all.
