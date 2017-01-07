---
date: 2017-01-05T09:42:02+05:00
title: Five Minute Overview
weight: 10
---

## Distance

"Branches create distance between developers and we don't want that"

    - Frank Compagner, Guerrilla Games

Physical distance can be mitigated by, screen sharing, so we won't worry about that.

Frank's distance is about the integration of code from multiple components/modules/sub-teams towards a binary that 
could be deployed or shipped. It has connotations of time, planned and unplanned. It has connotations of difficulty 
- of late merge perhaps.

## Always release ready

Trunk Based Development is a branching model that reduces the distance to the max. Practioners are able to face 
their management and say that they are always "release ready".

There are many deciding factors, before a dev team settles on Trunk Based Development, but here's a short overview 
of the practices:

## What it is

{{< note title="Notes" >}}

* Use of "Developers" throughout this site, means "QA-automators" for the same builable thing, too.

* When we say 'the trunk' on this site, it is just a branch in a single repo that developers in a team are focussing on 
for development. It may be called 'master'. That hints at the fact that the branch in qustion may not literally be 
called 'trunk' at all.

{{< /note >}}

### Checking out / cloning

All developers that contibute to a binary application/service in a team clone and checkout from the trunk. They will 
update/pull/sync from that branch a many times a day, knowing that the build within it works perfectly. Their fast 
source-control system means that there delays are a matter of a few seconds for this operastion. They are now 
integrating their team-mates commits on an hour by hour basis.

### Committing

Similarly, developers completing a piece of development work (changes to source code), that provably doesn't 
break the build, will commit it back to the trunk. The granularity of that commit (how many a developer 
would implictly do a day) can vary, and is learned through experience.

The developer needs to run the build, to prove that they didn't break anything with the commit. They might have to do 
a update/pull/sync before they commit/push the changes back to the team's version control server, and additional 
builds too. There's a risk a race condition there, but lets assume there's not for most teams.

### Code Reviews

The developer needs to get the commit reviewed. Some teams will count the fact that the code was developed according 
to pair programming as an automatic review. Others will follow a conventional design where the commit is marshalled
for review before landing in the trunk. 

Marshalled nearly always means a branch in a place that is visible to the team. These branches can (and should) be 
deleted after the code review is complete, meaning they are very short lived. This nuanced. You want to keep 
the commentary/approval/rejection from  the review for historical and auditing purposes, but you don't want to 
keep the branch. Specifically, you don't want to developers to focus on the branch after the review.

## A safety net

[Continuous Integation](/continuous-integration/) (CI) daemons are setup to watch the trunk (and the short lives feature 
branches used in review), and as quickly and completely as possible loudly/visibly inform the team that the trunk
 is broken.  Some teams will lock the trunk, and roll-back changes. Others will allow the CI daemon to do that 
 automatically.
 
## Dev team commitments

As stated, developers are pledging to be rigorous and not break the build. They're also going to need to consider 
the impact of their potentially larger commits, especially where renames or moves were wholescale, and adopt techniques
to allow those changes to be more easily consumed by team mates.