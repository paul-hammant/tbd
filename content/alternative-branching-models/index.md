---
date: 2016-03-09T20:08:11+01:00
title: Alternative Branching Models
weight: 30
---

## Modern claimed high-throughput branching models

### GitFlow and similar

There are plenty in the modern age that swear by this model, and feel it has plenty of room to scale with few 
downsides:

![](/images/gitflow.png)

- Diagram copied from Vincent Driessen's 2010 article on GitFlow: "A successful Git branching model"{{< ext url="http://nvie.com/posts/a-successful-git-branching-model" >}}

I looks like you'll not be able to do [concurrent development of consecutive releases](/concurrent-development-of-consecutive-releases/) 
with this branching model, or the hedging that [Feature Flags](/feature-flags/) and [Branch by Abstraction](/branch_by_abstraction/)
enable.

### Github flow

This is sooooo close to PR-centric Trunk Based Development.
 
Here's the crucial difference. Whereas for their release-from-branch step:

![](/images/githubflow1.png)

As Github portray, review comments are part of the process. Of course they are - they're speech bubbles in timeline 
above followed by another commit (presumably 132 columns end of line versus 80 prevailed). How Trunk Based Development 
modifies the Github Flow model:

![](/images/githubflow2.png)

After the dust has settled, and the short-lived feature branch has been deleted, the commits are not smushed together
in a bigger one (as would be the case Subversion and Perforce), the instead zip into their respective places in the 
commit history, which is not as linear as we present here:

![](/images/githubflow3.png)

Of course if your rebase/squash your series of commits, they could land in the trunk as a single commit.  Also note that 
the review commentary is still available after the branch is deleted, as it should be.  

See the Github Flow landing page for more{{< ext url="https://guides.github.com/introduction/flow/" >}}

## Legacy branching models

### Mainline

Mainline is a branching model that was promoted for ClearCase implementations. It is the principal branching 
model that Trunk Based Development opposes. Mainline is a branch that will last forever&#10033;. Off that, branches are formed
for teams to do development work on. When that work is complete, a release may happen from that branch, and there is a
**big** merge down to the mainline. On the way to the release, the branch may be frozen. 

So here is the intention, with Mainline:

![](/images/mainline1.png)

When bugs inevitably happen:

![](/images/mainline2.png)

Whenever there is a bug fix there has to be a merge down to the mainline afterwards. There's no 'wrong' in this modified
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
pick merges for any reason. Instead they're doing a "merge everything which is not merged already" kind of merge. 
Minimalistically the VCS they are using should have "merge point tracking". At the high end, that should include 
"record only" merges, and normal merges even after that.

&#10033; Companies that choose 'Mainline' wither and die, we claim, so there is no forever.

#### Merges

After the release the code will be merged back en masse to the mainline. Those
merges may be hard and lengthy. It could be that the team **took merges from** mainline part way through the project. It 
could also be that the team **pushed merges to** mainline part way through the project. 

#### How many branches?

We've just described a two branch model - the mainline and a project branch. It could be that the application in 
question has more that one project in flight at any one time. That would mean more than one project branch, and that
creates pressure for more intermediate merges, and consequentially greater merge difficulty.

#### Always release ready?

Not on your life! Planned work needs to complete, with estimates guiding when that will be. Defects need to be 
eliminated, formal testing phases need to kick in. Here we take the first branch diagram, and overlay red and orange 
and green to show known build-breaks, build passes missing automated tests will not catch hidden defects, 
and green for could go live. At least for the worst performing with missing or ineffectual automated 
testing run in the CI pipelines:

![](/images/mainline4.png)

### Cascade

The idea is that each release has its own branch, and that each release team merges from the 'upstream' branch daily.
They only do so if the CI server says the build is green for the upstream, of course.

![](/images/cascade1.png)

Problems compound with this model, the more releases being juggled concurrently there are. An upstream butterfly, is 
a downstream Tsunami of unmergability. Downstream merged begin to get skipped, or abandoned. Or the merge works, but the
code is not right so there is some in-branch fixing, which is not applicable to upstream. Here's the reality (breakages
overlaid again):

![](/images/cascade2.png)

Remember, the merges are never cherry picks in this model - they are sweeps of everything 
not merged yet (or upto an chosen commit number in order to make it more bite sized).

Of course only larger organizations have to worry 
about [concurrent development of consecutive releases](/concurrent-development-of-consecutive-releases/), and many 
would argue that the application is too large anyway (and that microservices is the solution).

# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>

Date    | Type  | Article
--------|-------|--------
04 Dec 2013 | Blog Entry | [What is Your Branching Model?](http://paulhammant.com/2013/12/04/what_is_your_branching_model/)
05 Apr 2013 | Blog Entry | [What is Trunk Based Development?](http://paulhammant.com/2013/04/05/what-is-trunk-based-development/)
19 Mar 2013 | Blog Entry | [The Cost of Unmerge](http://paulhammant.com/2013/03/19/cost-of-unmerge/)
15 Oct 2015 | InfoQ Interview | [More Feature Branching Means Less Continuous Integration](https://www.infoq.com/news/2015/10/branching-continuous-integration)
03 May 2015 | Blog Entry | [GitFlow considered harmful](http://endoflineblog.com/gitflow-considered-harmful)