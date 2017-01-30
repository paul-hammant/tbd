---
date: 2016-05-05T19:56:50+01:00
title: Branch for release
weight: 55
---

{{< quote title="Branch: only when necessary, on incompatible policy, late, and instead of freeze" >}}
<span>&mdash; Laura Wingerd & Christopher Seiwald</span><br>
<span style="margin-left: 30px">(1998's High Level SCM Best Practices white paper from Perforce)</span>
{{< /quote >}}

If a team is pushing production releases monthly, then they are also going to have to push bug-fix releases 
between planned releases. To facilitate that, it is common for Trunk Based Development Teams to make a release
branch on a just in time basis - say a few days before the release. That becomes a stable place, given the developers
are still streaming their commits into the trunk at full speed. 

The incompatible policy (ref Wingerd & Seiwald above), that the release branch "should not receive continued development work".

![](/images/branch_for_release.png)

^ Trunk, two release branches, three releases, and a bug-fix

{{< note title="CD teams do not do release branches" >}}
High throughput, [Continuous Delivery](/continuous-delivery/) teams can ignore this - if they had a lemon in production, they choose a 
roll-forward strategy for solving it, meaning the fix for a bug is in trunk, and the release is from trunk.
{{< /note >}}

## Who's committing where?

Developers are committing (green dots) at the highest throughput rate to the trunk, and don't slow up around a branch-cut.

![](/images/branch_for_release2.png)

The branch cut itself is a commit. Subversion and Perforce would technically have a bigger commit here, but all
VCS systems in use today would count the commit as lightweight in terms of it's impact on the history/storage.

That red dot is an accidental build break that was fixed (somehow) soon after.

## Fix production bugs on Trunk

The best practice for Trunk Based Development teams is to reproduce the bug on the trunk, fix it there with a test, 
watch that be verified by the CI server, then cherry-pick that to the release branch and wait for a CI server 
focusing on the release branch to verify it there too. Yes, the CI pipeline that guards the trunk is going to
be duplicated to guard active release branches too.

{{< warning title="Cherry pick is not a regular merge" >}}
A cherry pick merge takes a specific commit (or commits) and merges that to the destination branch. It skips 
one more more commits that happened before it, but after the branch was cut.
{{< /warning >}}

### Late branch creation

Some teams [release from a tag on the trunk](/release-from-trunk/), and do not create a branch at that time. That in 
itself is **an alternate practice to this one, "branch for release"**.

Those teams wait for a bug that needs fixing for a released, before creating a branch from the release tag (if they are
not going to just issue another release from the trunk).  

Brad Appleton points out that many do not realize that branches can be created **retroactively**. That is taken advantage 
of here in the case of bugs after "release from tag", or even changes for point release.

### Directionality of cherry-pick

This one is controversial even within teams practicing everything else about Trunk Based Development: you should not 
fix bugs on the release in the expectation of cherry-picking them back to the trunk, in case you forget to do that.
Forgetting means a regression in production some weeks later (and someone getting fired). It can happen if things
are being fixed in the night by a tired develop who wants to get back to bed.

Of course, sometimes you cannot reproduce the bug on trunk, so you have to do it the other way round.

## Release branch deletion

You really should delete release branches when releases from succeeding release branches have gone to prod. This is a 
harmless tidying activity - branches can be undeleted again quite easily.

# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>

Date    | Type  | Article
--------|-------|--------
1998 | White Paper | [High-level Best Practices in Software Configuration Management](https://www.perforce.com/sites/default/files/pdf/perforce-best-practices.pdf)
 