---
date: 2016-03-09T20:08:11+01:00
title: Game Changers
weight: 40
---

Since the 80's a number of things have pushed best practices towards Trunk Based Development or away from it. 

## Subversion's "lightweight" branching (2000&#47;2001)

Compared to the clunky CVS, that is, Subversion had lightweight branching. This made it easier to consider multiple 
branches active in parallel and merged later. Subversion was dogged, however, with an inferior merging model 
until v 1.5 in June 2008, and still has edge-case merge bugs today, like this one 
[![](/images/ext.png)](https://issues.apache.org/jira/browse/SVN-4635).

## Git's "lightweight" branching (2005)

Compared to Subversion, that is, Git had lightweight branching. 
This made it easier to consider multiple branches active in parallel and merged later. Git's merge engine was very 
good too, more able that prior merge technologies, to silently process complexity. As before, this made it easier to 
consider multiple branches.

## Google's internal DevOps

### Mondrian (2006)

Tools for code-reviewers/approvers of proposed contributions to trunk were developed internally in Google in the early 
2000's as a command-line tool. Things would not land in the shared trunk, until everyone agreed. Their culture was that 
such that reviews were speedy. Getting pending commits to the point of rejection or acceptance 
("Looks Good To Me" : LGTM) was almost competitive. Some new Googlers (Nooglers) would pride themselves about taking
on random code-review chores, and being one of a few people that weigh in to the decision moment.

The code review technology marshaled changes for proposed commits to the trunk, and stord them outside the VCS in 
question (in a database probably). To do that the tech would reach into the developer machine and the appropdiate
moment and make a tar.gz of the changes and the meta-data around them, and pull that back to the central system
for global presentation. Anyone could review anything. A review was just on a commit (not a batch of commits). Review
was continuous.

Reviewers could quickly bring the 
marshaled change down to their workstation to play with it, or use it as a basis for counter proposal. They could put 
that back in review again.

In 2006, Guido van Rossum presented one of his bigger contributions - "Mondrian" -
to Googlers. Here he that tech talk on YouTube (previously on GoogleVideos) 
[![](/images/ext.png)](https://www.youtube.com/watch?v=CKjRt48rZGk). Note at the start he says XP practice 
"Pair-Programming" is best, and that code review helps fill the gap for situations where you cannot do it.

After Mondrian, the open source world saw Gerrit [![](/images/ext.png)](https://www.gerritcodereview.com) released 
in its image, and after that Facebookers made Phabricator[![](/images/ext.png)](https://en.wikipedia.org/wiki/Phabricator) 
and released that as open source too.

## Github's entire platform

Github was launched as a portal on February 8, 2008, and feature have been added steadily ever since. The initial 
version contained forks, which was a formal way of expressing the directionality of related DVCS repos, and 
empowering a forgiveness model for unsolicited changes to code (as opposed to a permission model that preceded it
for other portals).

### Pull Requests (2008)

Github added "Pull-Requests" (PRs) on Feb 23rd, 2008 [![](/images/ext.png)](https://github.com/blog/3-oh-yeah-there-s-pull-requests-now),
while in beta, and popularized the entire practice for the industry when they came out of beta in April of that year. 
For source/repo platforms, and VCSs generally, this and "forking generally" was a total game changer, and commercial 
prospects of other companies were decided based on their ability to react to this culture change.

The open-source community for one, could step away from patch-sets that were donated by email (or rudimentarily). 
Pull-Requests changed the dynamics of open source.  Now, the original creator of open source was forced to keep up 
with PRs because if they did not, a fork with more activity and forward momentum, might steal the community. Perhaps 
rightfully so. 