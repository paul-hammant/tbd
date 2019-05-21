---
date: 2016-06-02T20:10:46+01:00
title: Committing straight to the trunk
weight: 62
---

Some teams will choose to commit straight to the trunk. Most likely it is because they are a small team with each
team member knowing what the others are up to. **Their build is probably fast and relatively exhaustive**, and they 
may well seldom experience a build breakage. If the build does break (post commit) then they most likely 'revert' the 
commit straight away, possibly locking the trunk for a short period of time while that is sorted out. The team may be 
really small (say three or four), in which case the team might allow someone to fix the build quickly and commit the 
fix in order to get the build green again.

In the 2000's Trunk-Based Development teams might have numbered up to 100 committers. They may have been extremely 
rapid with their `reverts` (lock trunk, revert, kick off the CI daemon again, unlock trunk if green again). If not would 
have performed check-in activities that the 1997 C3 team would have recognized, because they wanted that human 
assurance that gated check-ins are all that is needed to keep the build green. Namely, developers holding an 
"I/we are checking in now, nobody else should be". They run the full build after bringing their checkout up to date 
and commit/push if green. Indeed that ceremony is a key part of the [Continuous Integration](/continuous-integration/) advances 
and is now part of Agile generally, and Extreme Programming in particular. These days teams doing this practice are likely 
to be much smaller (say less than 16) because of the advent of a modern alternative.

# Alternatives to committing straight to the trunk

That modern alternative that allows teams be bigger without having a bottleneck around check-ins:
[Short-Lived Feature Branches](/short-lived-feature-branches/).
