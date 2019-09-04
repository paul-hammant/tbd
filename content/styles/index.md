---
date: 2016-06-01T20:10:45+01:00
title: Styles and Trade-offs
weight: 60
---

There are broadly three styles of trunk-based development as a daily developer activity. Depending on the number of 
developers in the team, the release cadence, and the desired rate of commits (assuming story-sizes that support that), 
you have trade-offs for each of the three:

![](/styles/styles-tradeoffs.png)

## Straight to Trunk

(left hand side of the diagram above)

Traditionally Trunk-Based Development meant committing straight to the shared trunk of the VCS in question. And doing so after 
a bunch of steps that together with the commit we will call integration.  

This is a really high throughput way of working, 
but it relies on developers being very confident their commit is not about the break the build. If they do, then a manual 
or automatic revert gets the trunk back to a good state, and you hope nobody did a git-pull or svn-up to bring that bad 
code into their workstation. Or you've engineered it so that does not happen - you publish known-passing latest commit 
number or hash.

## Coupled Patch Review System

(center of the diagram above)

"We do Trunk-Based Development" - Googler Rachel Potvin - @Scale keynote, Sept 2015 (14 mins in):

![](/branch-for-release/atscale.png)

Perhaps before others in the early 2000's, Google hit a ceiling on how many developers could commit to a trunk in a monorepo, 
without tripping each other up. That would be build-breakages mostly, but also commits that wouldn't be up to coding standards
even if the build still passed.  Say Google managed to get 1000 developers and QA automators working in with commits straight 
into the trunk, before deciding that something needed to gate that. What resulted was a patch review system that would
ultimately be called Mondrian and be announced to the world in 2006 at a tech talk in Mountain View.  This was a system that
Google had written to augment Perforce (the VCS they used up to 2012), to provide a place where code could be reviewed per-commit, and
also build-automation results could collated. 

Today, patch review systems include Gerrit, Rietveld and Phabrictor The latter by Facebook, and the first two with Googler 
involvement.  These are not branches of course, they are held outside source-control in a relational schema. Their reason 
for existence is to marshal pending change.

## Short-Lived Feature Branches

(right hand side of the diagram above)

Git and Mercurial delivered truly lightweight branching capability. What that meant was that branches could be very quickly 
created and receive commits that are momentarily divergent from trunk or master (in our case) and then be merged back later
when ready. Then finally, and crucially, the branch that facilitated that short-lived divergence could be deleted quickly
leaving only the the commits added to the effective lined of commits culminating in HEAD for trunk or master.  In that
regard it is identically to the patch review way of working for trunk based development.  That was all just a small 
datapoint for Git/Mercurial usage, until GitHub launches and had pull-requests as a feature from launch. Built in to that 
was a code review tool. This is a very compelling setup for unsolicited code contributions - making SourceForce and the 
Apache Software Foundation appear ancient, by comparison.

Teams can form around the GitHub pull-request workflow, and still do Trunk-Based Development. What you get (if you've 
attached build automation too), is a trunk or master that's never broken (or 1/1000th as likely to). The tradeoff is that 
you have to persuade co-workers to review your commit(s) in a timeframe that suits you.  There's a risk that you'd end up 
putting more commits in the pull-request that the straight-to-trunk experts would do. And you don't have to - you could 
stream four separate facilitating commits all the way into the trunk, and later the fifth that would complete/activate the 
feature you were trying to implement that the Agile story/card specified. Not only is there a risk of more-commits 
than you'd do if you could push directly, there's a risk of taking more time too. If your average story size should be 
one day, a slow-review and slow-build reality for the pull-request way, might push you into multi-day stories/cards, and 
from that be doing the opposite of getting to continuous delivery.

## Tradeoffs


