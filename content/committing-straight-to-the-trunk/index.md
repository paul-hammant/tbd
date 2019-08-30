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

# Alternatives to committing straight to the trunk

That modern alternative that allows teams be bigger without having a bottleneck around check-ins:
[Short-Lived Feature Branches](/short-lived-feature-branches/).

There are teams that send patches to review systems like Gerrit and Rietveld, instead of committing/pushing straight to trunk/master. Google pioneered this with their in-house Mondrian system in 2006, and Gerrit and Rietveld were made in the image of that. Facebook's Phabricator is alternative, too. As well as code review, build-automation systems objectively verify the correctness of the proposed changes, leaving you with high confidence that the following merge/integration into trunk/master will yield a similar positive result when the same infrastructure kicks in for CI purposes. 

# Local build - Importance of

In all variants of Trunk-Based Development teams run the full build locally (compile, unit tests, a range of integration tests) and see that pass, **before** declaring 'done' and committing/pushing the work to the eyes of teammates and bots (code review / pull-request), or directly into trunk/master. They do not **at all** rely on build automation to tell the whether their commit(s) were good or bad.
 