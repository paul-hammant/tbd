---
date: 2016-06-02T20:10:46+01:00
title: Committing straight to the trunk
weight: 62
---

Some teams will choose to commit straight to the trunk. Most likely it is because they are a small team with each
team member knowing what the others are up to. Their build is probably fast, and they could easily seldom experience
a build breakage. If the build does break then they most likely revert the commit straight away, unless the team is 
really small (say three or four), in which case the team might allow someone to fix the build quickly and commit the 
fix in order to get the build green.

In the 2000's Trunk Based Development teams might have numbered up to 100 committers, and would have performed 
checkin activities that the 1997 C3 team would have recognized. Namely developers holding an "I/we are checking in 
now, nobody else should be". They run the full build after bringing their checkout up to date, and commit/push if 
green.

There's a modern alternative, that allows teams to grow much bigger:
[Short-Lived Feature Branches](/short-lived-feature-branches/).