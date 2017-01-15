---
date: 2016-03-09T19:56:50+01:00
title: Branch for Release
weight: 35
---

{{< quote title="Branch: only when necessary, on incompatible policy, late, and instead of freeze" >}}
<span>&mdash; Laura Wingerd & Christopher Seiwald</span><br>
<span style="margin-left: 30px">(1998's High Level SCM Best Practices Whitepaper from Perforce)</span>
{{< /quote >}}

If a team is pushing production releases monthly, then they are also going to have to push bug-fix releases 
between planned releases. To facilitate that, it is common for Trunk Based Development Teams to make a release
branch on a just in time basis - say a few days before the release. That becomes a stable place, given the developers
are still streaming their commits into the trunk at full speed. 

![](/images/branch_for_release.png)

^ Trunk, two release branches, three releases, and a bug-fix

{{< note title="CD teams don't do release branches" >}}
High throughtput, Continous Delivery teams can ignore this - if they had a lemon in production, they choose a 
roll-forward strategy for solving it, meaning the fix for a bug is in trunk, and the release is from trunk.
{{< /note >}}

## Fix production bugs on Trunk

The best practice for Trunk Based Development teams is to reproduce the bug on the trunk, fix it there with a test, 
watch that be verified by the CI daemon, then cherry-pick that to the release branch and wait for a CI daemon 
focusing on the release branch to verify it there too.  Yes, the CI pipeline that guards the trunk is going to
be duplicated to guard active release branches too.

### Late branch creation

Some teams released from a tag on the trunk. In those cases, a branch is late created from the trunk first, and only
because of a bug at all.

### Directionality of cherry-pick

This one is controversial even within teams practicing everything else about Trunk Based Development: you shouldn't 
fix bugs on the release in the expectation of cherry-picking them back to the trunk, in case you forget to do that.
Forgetting means a regression in production some weeks later (and someone getting fired). It can happen if things
are being fixed in the night by a tired develop who wants to get back to bed.

Of course, sometimes you can't reproduce the bug on trunk, so you have to do it the other way round.

## Release branch deletion

You really should delete release branches when releases from succeeding release branches have gone to prod. 

# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>

Date    | Type  | Article
--------|-------|--------
1998 | White Paper | [High-level Best Practices in Software Con guration Management](https://www.perforce.com/sites/default/files/pdf/perforce-best-practices.pdf)
 