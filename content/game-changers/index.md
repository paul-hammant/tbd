---
date: 2016-03-09T20:08:11+01:00
title: Game Changers
weight: 40
---

Since the early 80's a number of things have pushed best practices towards Trunk Based Development, or away from it. 

The language in use to describe such things has changed over time. Software Configuration Management (SCM) is used less 
today than Version Control Systems (VCS) is. A simpler still term -"Source Control" - seems to be used more recently, 
too.

Similarly, 'trunk' and 'branch', have not always been used as terms for controlled code lines that have a common
ancestor, and are eminently (and repeatably) mergeable.

## Revision Control System - RCS (1982)

RCS was a simple but 'early days' version control technology, by Walter F. Tichy.

In Tichy's 1985 paper 
"RCS - A System for Version Control"{{< ext url="https://www.gnu.org/software/rcs/tichy-paper.pdf" >}}, a trunk 
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

## Microsoft Secrets book (1995)

Microsoft Secrets: How the World's Most Powerful Software Company Creates Technology, Shapes Markets and Manages 
People (Michael Cusumano & Richard Selby, 1995) {{< ext url="https://www.amazon.com/Microsoft-Secrets-Powerful-Software-Technology/dp/0684855313" >}}

There's a section of the book dealing with Microsoft's per-developer workflow using Source Library Manager (SLM) on 
a one-branch model (the book does not use the words trunk or branch). SLM (AKA "slime") - an Internal Microsoft tool 
for source-control until it was replaced by Source Depot in 1998. That daily, rigorous, developer workflow was:

1. checkout (update/pull/sync or checkout afresh)
2. implement feature 
3. build
4. test the feature
5. sync (update/pull)
6. merge
7. build
8. test the feature
9. smoke tests 
10. check in (commit/push)
11. makes a daily build from HEAD of the shared master branch

The authors note in the book, that #10 isn't always an every day thing. And the last step isn't per developer, it is 
for the designated "build master" within the team, and manual. 

The book also briefly mentions Test Case Manager (TCM) and "Microsoft Test". These were tools for helping developers 
manage and record/edit/playback application tests at their workstations. It isn't clear if all SLM-using teams
also used these, but the Excel team did (as they maintained the former at least).

The book was translated into 14 languages, and was also a best seller. 

These are clearly practices to support teams working in a trunk model.

Note: In 2000, ex Microsoftee and early blogger Joel Spolsky would extol the virtues of #11 in his now famous 
"The Joel Test" {{< ext url="https://www.joelonsoftware.com/2000/08/09/the-joel-test-12-steps-to-better-code" >}}.

## Perforce's High Level SCM Best Practices white paper (1998)

Laura Wingerd and Christopher Seiwald penned this widely read paper{{< ext url="https://www.perforce.com/sites/default/files/pdf/perforce-best-practices.pdf" >}}
 (presented at a SCM conference in Brussels the same year).
 
The paper alternates between 'trunk' and 'mainline' language, but has many valuable nuggets in 
it that help set a foundation for the the next ten years of version-control advances.

## Extreme Programming's Continuous Integration (1999)

Kent Beck{{< ext url="https://en.wikipedia.org/wiki/Kent_Beck" >}} published "Extreme Programming Explained" in 1999. 
Picked out that, amongst a bunch of practices for the influential XP methodology, is "Continuous Integration" 
that Kent felt was "risk reducing".

He says "Integrate and build the system many times a day, every time a task is completed", and goes on to detail 
a reserved workstation, that a developer pair would sidle up at the appropriate moment to prove that their code 
contribution was integrateable, and therefore good for team mates to depend on at that moment. That last notification
was often oral at that time "build passes, gang".

He calls out a requirement for "fast integration/build/test cycles". This is key. In fact, every pro Trunk Based Development 
game changer listed in this page was facilitated by faster builds generally (versus a predecessor technique for the team
in question). And, no, faster did not mean delete or comment out automated test execution in the build. Faster meant reduce 
the elapsed time to "a few minutes" (Kent again).

Kent had pioneered (with many industry luminary friends) in 1996 on the famous Chrysler Comprehensive Compensation System 
(C3) project.

### Continuous Integration on MartinFowler.com

Martin Fowler and Matt Foemmel{{< ext url="http://blog.foemmel.com" >}} wrote an online article "Continuous 
Integration" in 2000{{< ext url="https://www.martinfowler.com/articles/originalContinuousIntegration.html" >}}, 
calling out this one part of XP. Martin greatly updated it in 2006 
{{< ext url="https://www.martinfowler.com/articles/continuousIntegration.html" >}}. 
 
### ThoughtWorks' Cruise Control 
 
Martin's ThoughtWorks colleagues (Alden Almagro{{< ext url="http://aldenalmagro.com/resume.html" >}}, 
Paul Julias{{< ext url="http://www.pauljulius.com" >}}, 
Jason Yip{{< ext url="http://jchyip.blogspot.com" >}}) went on to build the then-dominant 
"Cruise Control" {{< ext url="http://cruisecontrol.sourceforge.net" >}} starting in early 2001. This was a 
ground breaking technology and very accessible to companies wanting a machine to fully verify checkins. 

Early CI servers, including CruiseControl used to have a "quiet period" to make sure they had received every last 
element of an intended commit. To facilitate that, only one pair of developers was allowed to checkin at a time. With 
CVS the other developers in the team could only do theur "cvs up" when CruiseControl had given the green light, 
automating that "build passes, gang" oral notification above. 

### Apache's Gump

Apache's Gump was built on a similar time line, but focused more on the binary integration hell of 
interdependent Apache (and other) open-source projects. It gave an early warning of integration clashes that were 
already, or were about to be problematic, for teams. While impressive, it use did not gain traction in the enterprise. 
This is because enterprises were able to be more buffered from open-source library hell (and the implicit diamond 
dependency problem), by controlling (limiting) the rate at which the upgraded their third-party binary dependencies.

Sam Ruby remembers:

<div style="padding-left: 45px; padding-right: 45px"/><span style="font-size: 120%">&ldquo;</span>
The original motivation for Gump wasn't so much continuous<br>
as it was integration - in particular, integration in the large.<br>
Many projects had unit tests but would routinely make changes<br>
that would break their 'contract' and nobody would notice until<br> 
well after the changes were released
<span style="font-size: 120%">&rdquo;</span>
</div>

## Subversion's "lightweight" branching (2000&#47;2001)

Karl Fogel helped start Subversion and remembers one early goal was "CVS + atomicity". The lack of atomicity in CVS
means that teams had to coordinate as to who was checking in presently, and whether they'd definably broken the build
afterwards. Early CI servers used to have a "quiet period" to make sure they had recieved every last element of an 
intended commit.

In comparison to the clunky CVS, Subversion had "lightweight" branching. This made it easier to consider multiple 
branches active in parallel and merge the team's changes back later. 

Until v1.5 in June 2008, Subversion had an inadequate "merge tracking" capability. It still has edge-case merge bugs 
today, like this one {{< ext url="https://issues.apache.org/jira/browse/SVN-4635" >}}.

## Git's "lightweight" branching (2005)

In comparison to the clunky Subversion, Git had "lightweight" branching.
This made it easier to consider multiple branches as active (in parallel) and merged back later. Git's merge engine was very 
good too, more able than prior merge technologies, to silently process complexity. 

A critical part of Git was local branching. A developer could make multiple local branches, and even map them to the 
same remote branch. Say one could be a feature, part complete, and another a surprise bug fix to go back first. Or the 
developer could be making alternate implementations of the same complicated thing, to decide later which to push back. 
Git doesn't need a centralized server repo, but enterprise teams are going to have one anyway.

As before, this made it easier to consider multiple branches as a viable team setup.

## Google's internal DevOps - 1998 onwards

Note: Google were practicing Trunk Based Development since the beginning - Craig Silverstein (the first hire) remembers 
setting it up that way. Much of these were secret to Google until much later.

## Home-grown CI and tooling

This was 2002 onwards, but only barely documented outside Google, this the influence is much smaller.

Google is the most famous example of using Scaled CI infrastructure to keep up with commits (one every 30 seconds on 
average) to a single shared trunk. Google's setup would also allow the same infrastructure to verify *proposed* commits.

Their VCS technology in the early 2000's when they engineered this was Perforce, and it did not have an ability
to effectively do CI on commits that had not yet landed in the trunk. So Google made their own tooling for this and
pending commits were plucked from developer workstations for verification (and code review - see "Mondrian" below). 
After its initial creation, Google's now "Google3" setup, gained a UI Mondrian (as mentioned) 
which made the results of the pre-commit CI verification very clear. 

### Mondrian (2006)

Tools for code-reviewers/approvers of proposed contributions to trunk were developed internally in Google in the early 
2000's as a command-line tool and part of "Google 3". Things would not land in the shared trunk, until everyone agreed. 
Their culture was that such that reviews were speedy. Getting pending commits to the point of rejection or acceptance 
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
{{< ext url="https://www.youtube.com/watch?v=CKjRt48rZGk" >}}. Note at the start he says XP practice 
"Pair-Programming" is best, and that code review helps fill the gap for situations where you cannot do it.

After Mondrian, the open source world saw Gerrit {{< ext url="https://www.gerritcodereview.com" >}} released 
in its image, and after that Facebookers made Phabricator{{< ext url="https://en.wikipedia.org/wiki/Phabricator" >}}
and released that as open source too.

### Google's Selenium Farm (2006)

Google CI infrastructure was expanded to have **a second tier of elastic infrastructure**, for scaled Selenium/WebDriver 
testing.

This "Selenium Farm" (internal cloud) was also available to developers at their desks, who just wanted to run such tests against a stood-up
version of what they were working on. Teams who had to run Firefox (etc) on their own desktop on a Friday, were able 
to lease one or more Firefoxes browsers  in parallel on a Monday, and no longer lock up their developer workstations.

Other companies since, have been able to deploy their own Selenium-Grid internally or
leverage one of the online services for elastic Selenium testing.

## Branch by Abstraction technique (2007)

Paul Hammant blogged about a 2005 ThoughtWorks client engagement in a Bank of America software development team, 
that used the Branch by Abstraction technique {{< ext url="http://paulhammant.com/blog/branch_by_abstraction.html" >}}.
Whereas many had previously used this technique to avoid longer version-control branches in a trunk model, this was the 
first time it had been detailed online, and given a name (by Stacy Curl).

## Github's entire platform - 2008 onwards

Github was launched as a portal on February 8, 2008, and feature have been added steadily ever since. The initial 
version contained forks, which was a formal way of expressing the directionality of related DVCS repos, and 
empowering a forgiveness model for unsolicited changes to code (as opposed to a permission model that preceded it
for other portals).

### Pull Requests (2008)

Github added "Pull-Requests" (PRs) on Feb 23rd, 2008 {{< ext url="https://github.com/blog/3-oh-yeah-there-s-pull-requests-now" >}},
while in beta, and popularized the entire practice for the industry when they came out of beta in April of that year. 
For source/repo platforms, and VCSs generally, this and "forking generally" was a total game changer, and commercial 
prospects of other companies were decided based on their ability to react to this culture change.

The open-source community for one, could step away from patch-sets that were donated by email (or rudimentarily). 
Pull-Requests changed the dynamics of open source.  Now, the original creator of open source was forced to keep up 
with PRs because if they did not, a fork with more activity and forward momentum, might steal the community. Perhaps 
rightfully so. 

This forced the entire VCS industry to take note, and plan equivalents. It greatly facilitated multi-branch 
development for teams of course.

## Continuous Delivery Book (2010)

Jez Humble{{< ext url="https://continuousdelivery.com" >}} and Dave 
Farley{{< ext url="http://www.continuous-delivery.co.uk" >}} wrote this influential book after a 
ThoughtWorks project in London that finished in 2007. 
The client was AOL - enough time has passed to share that. DevOps advances were
being made across the industry, but a critical aspect was that the prescribed go-live date was tight, given the known
amount of work to be completed before then. Tight enough to want to compress the classic 'coding slows down, and 
exhaustive user acceptance testing starts' phase of a project. The team had to pull the trigger on plenty of 
automated steps, to allow faster feedback loops, including a high confidence in the quality of commits, from only 
minutes before.  CI pipelines and delta-scripts for database table-shape migrations, in particular, were focused on.

The 2010 'Continuous Delivery' book is the best selling result. It has been translated into three languages since, and 
both authors now have careers that further deliver/describe the benefits for clients.

Dan North{{< ext url="https://dannorth.net" >}} (Mr BDD), Chris Read{{< ext url="https://www.linkedin.com/in/devopscread" >}} 
(an unsung DevOps pioneer) and Sam Newman{{< ext url="http://samnewman.io" >}} were also key the AOL advances. 
Dan North gave a deeper account of the mission at GOTO in 2014{{< ext url="https://speakerdeck.com/tastapod/the-birth-of-devops" >}} 
(no video sadly) and was interviewed later by InfoQ{{< ext url="https://www.infoq.com/news/2014/07/birth-cd-devops" >}}.

A mission a year or so before that for UK retailer Dixons, saw Sam and Dave accumulate a number of other 
DevOps emergent practices, they'd get to reuse and refine on the AOL mission.

## HP LaserJet Book (2012)

Gary Gruver, Mike Young, and Pat Fulghum wrote
[A Practical Approach To Large Scale Agile Development](https://www.amazon.com/dp/0321821726) to describe the multi-year
 transformation programme in the HP LaserJet Firmware division. In 2008, there were over 400 engineers dotted around
 the world working on over 10 million lines of printer firmware code in the HP LaserJet Firmware division. There
 were 10+ long-lived release feature branches (one for each product variant), with 1 week required for a build and
 6 weeks required for manual regression testing. The engineers spent 25% of their time working on product support i.e.
 merging features between branches and only 5% of their time on new features.

 For the next couple of years, HP committed to a huge investment in Trunk Based Development and
 Continuous Integration. All product variants were re-architected as a single product on Git master, per-variant
 features extracted into XML config files, all engineers worldwide were given the same virtual machine for development,
 and a huge multi-tier continuous build process was fully automated in-house. The results were outstanding, with build
 time reduced to 1 hour and manual testing replaced with a 24 hour fully automated test suite including printing
 test pages. 10-15 builds could be produced a day, engineers spent 5% of their time not 25% on product support and 40%
 of their time not 5% of their time on new features. That is an 8x increase in productivity for 400 engineers.

## PlasticSCM's semantic merge (2013)

Plastic's semantic diff and merge capability was launched in April 2013 
{{< ext url="https://www.infoq.com/news/2013/04/Semantic-Merge" >}}, It allowed a greatly reduced diffs for 
multi-branch situations. 

Other source-control tools are not doing semantic diff/merge yet (2017), but they should be.

If merges between branches are required, and larger 
code changes (like refactorings) are desired, then multi-branch development is a little easier with this. However, Trunk Based 
Development's commits are more elegant too, because of it, and in the fullness of time, it might make
on techniques like Branch by Abstraction easier, or reduce the need for it, if merge contflicts happen less often
(according to source-control) for something in 2012 that would have been a definite clash.

## Travis-CI's Github integration and pass/fail badges (2013)

(TODO - not sure if Travis were first or popularizing of this)

In 2013, TravisCI provided easy integrations into Github's platform run CI builds for Pull Requests and the general
state of HEAD on any branch. This was visually indicated with "build passes" and 
"build fails" badges were inserted into the Github UI. This made it was clear whether the proposed PR 
would break the build or not were it to be merged into trunk. 

# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>

Other than the references inline (above) ...

Date    | Type  | Article
--------|-------|--------
13 Nov 2013 | Talk | [A Practical Approach to Large Scale Agile Development](https://www.youtube.com/watch?v=2QGYEwghRSM)
14 Jan 2015 | Blog entry | [From 2½ Days to 2½ Seconds - the Birth of DevOps](http://dizzythinks.net/from-212-days-to-212-seconds-the-birth-of-devops.html)
23 Apr 2015 | Blog entry | [The origins of Trunk Based Development](http://paulhammant.com/2015/04/23/the-origins-of-trunk-based-development/)