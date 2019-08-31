---
date: 2016-06-02T20:10:46+01:00
title: Committing straight to the trunk
weight: 62
---

Some teams will choose to commit straight to the trunk. Most likely it is because they are a small team with each
team member knowing what the others are up to. **Their build is probably fast and relatively exhaustive**, and they 
may well seldom experience a build breakage. If the build does break (post integration into trunk/master) then they most likely 'revert' the 
commit straight away, possibly locking the trunk for a short period of time while that is performed. If the team is 
really small (say three or four), in which case the team might allow someone to fix the build quickly and commit that 
in order to get the build green again.

In the 2000's many Trunk-Based Development teams might have numbered up to 100 committers. They may have been extremely 
rapid with their `reverts` (lock trunk, revert, kick off the CI daemon again, unlock trunk if green again). If not would 
have performed check-in activities that the 1997 C3 team would have recognized, because they wanted that human 
assurance that gated check-ins are all that is needed to keep the build green. Namely, developers holding an 
"I/we are checking in now, nobody else should be". They run the full build after bringing their checkout up to date 
and commit/push if green. Indeed that ceremony is a key part of the [Continuous Integration](/continuous-integration/) advances 
and is now part of Agile generally, and Extreme Programming in particular. These days teams doing this practice are likely 
to be much smaller (say less than 16) because of the advent of a modern alternative, but there are still some large teams 
working this way.

# Challenges

Committing (and pushing) straight to the trunk has a challenge. Principally, someone could commit/push code that breaks the build, and the server(s) setup to guard Continuous Integration don't catch that for some time after the commit is available for teammates to pull/sync to their dev-workstation for unrelated work.

Risk mitigation is **everyone** running the full build (the same build the CI demon would do) before the commit/push, and only pushing to 
trunk if that passes. **This is essential pre-integration**. This is the habit of the XP teams from the end of the 90's, and there's no reason any team would dispense with that in the years since. Indeed, it is valuable for ALL branching models.

If this is locked in as a team requirement, your new challenge is to keep the full build fast. Fast is say one minute, and slow is ten or above. Compile and pure unit tests (no threads, sockets, file IO) is where good builds focus their development effort. Any following "integration test" build steps that use threads, listen on sockets, or do significant file IO should be minimized as far as possible without reducing meaningful coverage. The best trick for that is changing some integration tests into pure unit tests, which isn't always easy.

Some teams have revert policies for commits that land in trunk/master that are proven as "broken" later in CI. That could be an activity for a build-cop who's going to communicate with the dev team about locking the trunk to achieve that. Or it could be a bot activity and happen instantly, as Google do in-house (35K committers in one trunk).

Some teams have some scripting in place to ensure that developers only pull/sync commits to their dev-workstations that CI has marked as passing. That could be as simple as keeping a commit ID (number or hash depending on your VCS tool) on a website somewhere, and writing a wrapper script for git-pull (or svn up) that ignores commits that happened after that one. Pushing back, with that way of working is harder in Git and Mercurial as they requires you to have pulled HEAD revison before you can push back. Subversion and Perforce don't have that limitation.

# Local build - Importance of

In all variants of Trunk-Based Development teams run the full build locally (compile, unit tests, a range of integration tests) and see that pass, **before** declaring 'done' and committing/pushing the work to the eyes of teammates and bots (code review / pull-request), or directly into trunk/master. They do not **at all** use build automation as a crutch in order to determine whether their commit(s) were good or bad. Instead that determine that themselves on their dev workstation or containers/VMs that are dedicated to them, and do so **before** the push something towards code review and bot scrutiny.  As mentioned above keeping this build fast is very important, and not having a fast build is one of the key drivers to other branching models and repo sharding. Indeed it is one of the key drivers to slower release cadences too.

# Alternatives to committing straight to the trunk

That modern alternative that allows teams be bigger without having a bottleneck around check-ins:
[Short-Lived Feature Branches](/short-lived-feature-branches/).

There are teams that send patches to review systems like Gerrit and Rietveld, instead of committing/pushing straight to trunk/master. Google pioneered this with their in-house Mondrian system in 2006, and Gerrit and Rietveld were made in the image of that. Facebook's Phabricator is alternative, too. As well as code review, build-automation systems objectively verify the correctness of the proposed changes, leaving you with high confidence that the following merge/integration into trunk/master will yield a similar positive result when the same infrastructure kicks in for CI purposes. 

 