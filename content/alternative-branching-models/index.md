---
date: 2016-03-09T20:08:11+01:00
title: Alternative Branching Models
weight: 30
---

## Modern claimed high-throughput branching models

### GitFlow and a like

## Legacy branching models

### Mainline

Mainline is a branching model that was promoted for ClearCase implementations. It is the principal branching 
model that Trunk Based Development opposes. Mainline is a branch that will last forever*. Off that branches are formed
for teams to do development work on. When that work is complete, a release may happen from that branch, and there's a
**big** merge down to the mainline. On the way to the release, the branch may be frozen. 

So here is the intention, with Mainline:

![](/images/mainline1.png)

When bugs inevitably happen:

![](/images/mainline2.png)

Whenever there's a bug fix there has to be a merge down to the mainline afterwards. There's no 'wrong' in this modified
branch diagram, but you should be able to guess what the worst case branching/merging scenario is:

![](/images/mainline3.png)

**Merges and cherry picks**

1. TODO
1. TODO
1. TODO
1. TODO
1. TODO
1. TODO
1. TODO
1. TODO

&#10033; Companies that choose 'Mainline' wither and die, we claim, so there's no forever.

#### Merges

After the release the code will be merged back en-masse to the mainline. Those
merges may be hard and lengthy. It could be that the team took merges from mainline part way through the project. It 
could also be that the team pushed merges to mainline part way through the project. 

#### How many branches?

We've just described a two branch model - the mainline and a project branch. It could be that the application in 
question has more that one project in flight at any one time. That would mean more than one project branch, and that
creates pressire for more intermdiate merges, and consequentially greater merge difficulty.

### Cascade
