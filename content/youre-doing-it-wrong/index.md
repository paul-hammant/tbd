---
date: 2016-03-09T20:08:11+01:00
title: You're doing It Wrong
weight: 0
---

## Merely naming a branch trunk.

Say you're using Subversion, and you accepted its default directory design, when you made a new repository. That will
give you 'trunk', 'tags' and 'branches' as directory names. The mere fact that you have a branch called trunk does not
mean you're doing trunk based development. "We merge branches back to trunk often" is heard a lot in the industry,
and if you're grouping multiple developers on those branches of they not deleted after a couple of days, then it is 
not the trunk based development branching model.

## Direction of Cherry Pick (or merge)

All your developers are using a trunk and they're doing the right thing re not breaking the build. Your release 
cadence is infrequent enough to allow you to cut a release branch on a just in time basis, and harden that in the run
up to the actual release. 

If you're fixing the bug on the release branch and merging it down to the trunk you're doing 
it wrong. There's a chance you might forget to merge it down, and then there's going to be a regression at the next 
release moment (fresh branch cut from trunk).

Bugs should be reproduced and fixed on the trunk, and then **cherry-picked** to the release branch. A build should 
happen from that, a second confirmation that the issue has been remediate, and that deployment should go live (perhaps 
a point release).  If you can't reproduce on the trunk (truly rare), then you've permission to go ahead and reproduce
it on the release branch, fix it there, and merge back.

## Duration of 'short lived' feature branches

The short-lived feature branch should only last a day or two. After the seal of approval from code reviewers and CI 
daemons it should be merged into the trunk. The short-lived feature branch should be deleted, as proof of convergence.
You may then go ahead and make the next short-lived feature branch for the next story/task you're doing.

## Numbers of developers on 'short lived' feature branches

If there's more that you (and you're pairing partner) on the same short-lived feature branch, then that branch is at 
risk of not being short-lived, and more like a release branch under active development.
