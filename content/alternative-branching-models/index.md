---
date: 2016-03-09T20:08:11+01:00
title: Alternative Branching Models
weight: 30
---

## Modern claimed high-throughput branching models

### GitFlow and alike

## Legacy branching models

### Mainline

Mainline is a branching model that was promoted for ClearCase implementations. It is the principal branching 
model that Trunk Based Development opposes. Mainline is a branch that will last forever&#10033;. Off that, branches are formed
for teams to do development work on. When that work is complete, a release may happen from that branch, and there's a
**big** merge down to the mainline. On the way to the release, the branch may be frozen. 

So here is the intention, with Mainline:

![](/images/mainline1.png)

When bugs inevitably happen:

![](/images/mainline2.png)

Whenever there's a bug fix there has to be a merge down to the mainline afterwards. There's no 'wrong' in this modified
branch diagram, but you should be able to guess what the worst case branching/merging scenario is. In case you cannot:

![](/images/mainline3.png)

**Merges for the above**

1. Release 1.1 team persuades the release 1.0 team to bring something back to Mainline early (and incomplete) before they cut their branch
1. Release 1.1 team merges the release 1.0 work upon apparent completion
1. Release 1.0 team merges post-release bug fixes back to Mainline, and cross their fingers that the 1.0 branch can truly die now
1. Release 1.2 team persuades the release 1.1 team to bring something back to Mainline early (and incomplete) before they cut their branch
1. Release 1.1 team merges from Mainline, to pick up #3
1. Release 1.2 team merges the release 1.1 work upon apparent completion
1. Release 1.1 team merges post-release bug fixes back to Mainline, and cross their fingers that the 1.0 branch can truly die now
1. Release 1.2 team merges from Mainline, to pick up #7

All of these compromises versus the planned "consecutive development of consecutive releases". In many cases it is worse,
particular when the numbers of developers goes up.

One key thing to note, versus Trunk Based Development, teams doing the Mainline branching model, almost never do cherry 
pick merges for any reason. Instead they're doing a "merge everything which isn't merged already" kind of merge. 
Minimalistically the VCS they are using should have "merge point tracking". At the high end, that should include 
"record only" merges, and normal merges even after that.

&#10033; Companies that choose 'Mainline' wither and die, we claim, so there's no forever.

#### Merges

After the release the code will be merged back en-masse to the mainline. Those
merges may be hard and lengthy. It could be that the team **took merges from** mainline part way through the project. It 
could also be that the team **pushed merges to** mainline part way through the project. 

#### How many branches?

We've just described a two branch model - the mainline and a project branch. It could be that the application in 
question has more that one project in flight at any one time. That would mean more than one project branch, and that
creates pressire for more intermediate merges, and consequentially greater merge difficulty.

#### Always release ready?

Not on your life! Planned work needs to complete, with estimates guiding when that will be. Defects need to be 
eliminated, formal testing phases need to kick in. Here we take the first branch diagram, and overlay red and orange 
and green to show known build-breaks, build passes missing automated tests won't catch hidden defects, 
and green for could go live. At least for the worst performing with with missing or ineffectual automated 
testing run in the CI pipelines:

![](/images/mainline4.png)

### Cascade

![](/images/cascade1.png)

# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>

Date    | Type  | Article
--------|-------|--------
04 Dec 2013 | Blog Entry | [What is Your Branching Model?](http://paulhammant.com/2013/12/04/what_is_your_branching_model/)
05 Apr 2013 | Blog Entry | [What is Trunk Based Development?](http://paulhammant.com/2013/04/05/what-is-trunk-based-development/)
19 Mar 2013 | Blog Entry | [The Cost of Unmerge](http://paulhammant.com/2013/03/19/cost-of-unmerge/)
