---
date: 2016-03-09T20:10:46+01:00
title: Concurrent development of consecutive releases
weight: 40
---

Your company wants a stream of major functionality to arrive in the application you're pushing live at a regular 
cadence. Because you're good Extreme Programmers, you know that consecutive development of consecutive releases
is best. However, the effort and length of time needed to complete each of the major pieces of functionality is
large enough to require different project teams cooperating towards that plan. Some of those teams will be within
the same codebase. Some may dependant building services that the application will call. Not everything is equal effort
it seems, yet the business wants a specific rollout, including dates and can plan that even 18 months ahead. They're
so specific because there's an impact on the the user community (staff, clients, customers or members of the public).

What you've got is the perfect setup for disaster born from the random bigger pieces bad news that can happen in 
software development. 

One thing was under estimated by 50% and that is determined later rather than sooner. 
Should all of the following releases slip too, assuming the company did not attempt to throw bodies at it in an attempt 
to solve it?

One compelling answer is to change the order of releases. The the business, that could be a relief even if it requires
re-planning and problems around marketting/education given the impacted staff, clients, customers or members of the 
public.

The trouble is that the dev teams, might have to face an un-merge or commenting-out frenzy to support that, depending on
what had merged already. Different branching models have different merge impacts, and are either early or late in terms
of keenness for the act of merging. That in itself is disruptive to the business, as they fear and probably witness 
additional delays because of the retooling and new found nerves.

If your team has institutionalized Trunk Based Development, [Feature Flags](/feature-flags/) and (to a lesser degree) 
[Branch by Abstraction](/branch-by-abstraction/), it is in a perfect position to reorder releases, and only have a small
impact on dev team throughput. Choosing Trunk Based Development, Feature Flags and branch by Abstraction could be said
to be a hedging strategy against the costs of larger scheduling changes.

# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>

Date    | Type  | Article
--------|-------|--------
19 Mar 2013 | Blog Entry | [The Cost of Unmerge](http://paulhammant.com/2013/03/19/cost-of-unmerge/)
14 Jul 2013 | Blog Entry | [Legacy Application Strangulation : Case Studies](http://paulhammant.com/2013/07/14/legacy-application-strangulation-case-studies/)
10 Oct 2014 | Conference Talk | [Trunk Based Development in the Enterprise - Its Relevance and Economics](https://www.perforce.com/merge/2014-sessions/trunk-based-development-enterprise-its-relevance-economics)



