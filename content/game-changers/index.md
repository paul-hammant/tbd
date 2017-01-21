---
date: 2016-03-09T20:08:11+01:00
title: Game Changers
weight: 40
---

## Pivotal moments

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
marshalled change down to their workstation to play with it, or use it as a basis for counter proposal. They could put 
that back in review again.

In 2006, Guido van Rossum presented one of his bigger contributions - "Mondrian" -
to Googlers. Here he that tech talk on YouTube (previously on GoogleVideos) 
[![](/images/ext.png)](https://www.youtube.com/watch?v=CKjRt48rZGk). Note at the start he says XP practice 
"Pair-Programming" is best, and that code review helps fill the gap for situations where you cannot do it.

After Mondrian, the open source world saw Gerrit [![](/images/ext.png)](https://www.gerritcodereview.com) released 
in its image, and after that Facebookers made Phabricator[![](/images/ext.png)](https://en.wikipedia.org/wiki/Phabricator) 
and released that as open source too.

### Github's pull requests (2008)

Github launched "Pull-Requests" (PRs) in 2008 [![](/images/ext.png)](https://github.com/blog/3-oh-yeah-there-s-pull-requests-now)
and popularized the entire practice for the industry. For source/repo platforms, and VCSs generally, this and
"forking generally" was a total game changer, and commercial prospects of other companies were decided based on their 
ability to react to this culture change.

The open-source community for one, could step away from patch-sets that were donated by email (or rudimentarily). 
Pull-Requests changed the dynamics of open source.  Now, the original creator of open source was forced to keep up 
with PRs because if they did not, a fork with more activity and forward momentum, might steal the community. Perhaps 
rightfully so. 