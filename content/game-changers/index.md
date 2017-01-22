---
date: 2016-03-09T20:08:11+01:00
title: Game Changers
weight: 40
---

Since the 80's a number of things have pushed best practices towards Trunk Based Development, or away from it. 

## RCS - simple but early days

RCS was Revision Control System, by Walter F. Tichy.

In Tichy's 1985 paper 
"RCS - A System for Version Control"[![](/images/ext.png)](https://www.gnu.org/software/rcs/tichy-paper.pdf), a trunk 
focused mode of use is described as a "slender branch", and that you stepped away from it for four reasons:

<br><div style="padding-left: 45px; padding-right: 45px"/><span style="font-size: 150%">&ldquo;</span>
<b>Section 3.1. When are branches needed?</b><br>
A young revision tree is slender: It consists of only one branch, called the trunk.<br>
As the tree ages, side branches may form. Branches are needed in the following 4 situations.<br>
&nbsp;&nbsp;&nbsp;&nbsp;Temporary fixes [...]<br>
&nbsp;&nbsp;&nbsp;&nbsp;Distributed development and customer modifications [...]<br>
&nbsp;&nbsp;&nbsp;&nbsp;Parallel development [...]<br>
&nbsp;&nbsp;&nbsp;&nbsp;Conflicting updates [...]<br>
</div>
 
Two of those, Tichy suggests, are temporary branches and would come back to the trunk at the earliest opportunity. 

Superficially, RCS allowed multi-branch parallel development, but some teams were very careful and stuck
to a 'slender', or Trunk Based Development mode of use.

## Subversion's "lightweight" branching (2000&#47;2001)

Karl Fogel helped start Subversion and remembers one early goal was "CVS + atomicity". The lack of atomicity in CVS
means that teams had to coordinate as to who was checking in presently, and whether they'd definably broken the build
afterwards. Early CI servers used to have a "quiet period" to make sure they had recieved every last element of an 
intended commit.

In comparison to the clunky CVS, Subversion had "lightweight" branching. This made it easier to consider multiple 
branches active in parallel and merge the team's changes back later. 

Until v1.5 in June 2008, Subversion had an inadequate "merge tracking" capability. It still has edge-case merge bugs 
today, like this one [![](/images/ext.png)](https://issues.apache.org/jira/browse/SVN-4635).

## Git's "lightweight" branching (2005)

In comparison to the clunky Subversion, Git had "lightweight" branching.
This made it easier to consider multiple branches as active (in parallel) and merged back later. Git's merge engine was very 
good too, more able than prior merge technologies, to silently process complexity. 

A critical part of Git was local branching. A developer could make multiple local branches, and even map them to the 
same remote branch. Say one could be a feature, part complete, and another a surprise bug fix to go back first. Or the 
developer could be making alternate implementations of the same complicated thing, to decide later which to push back. 
Git doesn't need a centralized server repo, but enterprise teams are going to have one anyway.

As before, this made it easier to consider multiple branches as a viable team setup.

## Google's internal DevOps

Note: Google were practicing Trunk Based Development since the beginning - Craig Silverstein (the first hire) remembers 
setting it up that way.

## Home-grown CI and tooling (2002 onwards)

Google is the most famous example of using Scaled CI infrastructure to keep up with commits (one every 30 seconds on 
average) to a single shared trunk. Google's setup would also allow the same infrastructure to verify *proposed* commits.

Their VCS technology in the early 2000's when they engineered this was Perforce, and it did not have an ability
to effectively do CI on commits that had not yet landed in the trunk. So Google made their own tooling for this and
pending commits were plucked from developer workstations for verification (and code review - see "Mondrian" below). 
After its initial creation, Google's now "Google3" setup, gained a UI Mondrian (as mentioned) 
which made the results of the pre-commit CI verification very clear. 

### Mondrian (2006)

Tools for code-reviewers/approvers of proposed contributions to trunk were developed internally in Google in the early 
2000's as a command-line tool and part of "Google 3". Things would not land in the shared trunk, until everyone agreed. Their culture was that 
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

### Google's Selenium Farm (2006)

Google CI infrastructure was expanded to have **a second tier of elastic infrastructure**, for scaled Selenium/WebDriver 
testing.

This "Selenium Farm" (internal cloud) was also available to developers at their desks, who just wanted to run such tests against a stood-up
version of what they were working on. Teams who had to run Firefox (etc) on their own desktop on a Friday, were able 
to lease one or more Firefoxs browsers  in parallel on a Monday, and no longer lock up their developer workstations.

Other companies since, have been able to deploy their own Selenium-Grid internally or
leverage one of the online services for elastic Selenium testing.

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

A few years later (with the help of third parties like TravisCI).
"build passes" and "build fails" badges were woven into the Github UI. This made it was clear whether the proposed PR 
would break the build or not were it to be merged into trunk. This combination was a game changer, and 
forced the entire VCS industry to take note, and plan equivalents.

## PlasticSCM's semantic merge (2013)

Plastic's semantic diff and merge capability was launched in April 2013 [![](/images/ext.png)](https://www.infoq.com/news/2013/04/Semantic-Merge), 
It allowed a greatly reduced diffs for multi-branch situations. If merges between 
branches are required, and larger code changes (like refactorings) are desired, then incrementally, multi-branch
development is easier. But Trunk Based Development's commits are more elegant too, because of it.

## Travis-CI's Github integration and pass/fail badges (2013)

Travis... ? TODO

# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>

Date    | Type  | Article
--------|-------|--------
23 Apr 2015 | Blog entry | [The origins of Trunk Based Development](http://paulhammant.com/2015/04/23/the-origins-of-trunk-based-development/)