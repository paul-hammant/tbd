---
date: 2016-03-09T20:08:11+01:00
title: Version Control System (VCS) - choices
weight: 50
---

## The importance of integrated code review

Commercial VCS technologies and platforms were disrupted with the advent of gated code reviews that were coupled 
to a mechanism to quickly consume (merge) the contribution. Code review for "committers" would have been disruptive 
enough, but when it arrived it arrived for unknown (to the dev team) contributors by way of "forks".

All VCS technologies and platforms are measured by their adherance to forks, pull requests, integrated code review
and possibly hooks into CI servers.

Read more in [Game Changes Review - Google's Mondrian](/game-changers/#mondrian-2006) and 
[Game Changers - Github's Pull Requests](/game-changers/#pull-requests-2008).

## Git and Mercurial

[Git website](https://git-scm.com/) and [Mercurial website](https://www.mercurial-scm.org/)

Git and Mercurial have been popular DVCS technologies for many years. Portals like Github make Git the default 
choice for SCM/SVC/source-control.  While the Linux Kernel is maintained with Git, and definitely takes advantage 
of the D-Distributed aspect of the DVCS of Git (in that many divergent versions of kernel can exist over 
long periods of time), most enterprises are still going to count a single repository as the principal one, and within 
that a single branch as the long-term "most valuable" code line.

It is perfectly possible to do Trunk Based Development in a Git repository. By convention 'master' is the long term 
most valuable branch, and once cloned to your local workstation, the repository gains a nickname of 'origin'.

An effective Trunk Based Development strategy, for Git, depends on the developer maintaining a fork of the origin 
(and of master within), and Pull-Requests being the place that ready to merge commits are code reviewed, **before** being 
consumed back into origin:master. Other branching models use the same Pull-Request process for 
code-reviews too - it is the normal way of working with Git since GitHub rolled out the feature.

Historically, Git and Mercurial were not great at maintaining a zipped history size greater that 1GB. Many 
teams have reported that they have a repository size larger than that, so opinions differ. One way that you can reach 
that 1GB ceiling quickly is with larger binaries. As Git keeps history in the zipped repository, even a single larger 
binary that changes frequently can push the total use above 1GB.

With the likes of correctly configured Git-LFS extension to Git, though, the 1GB limit can be avoided or delayed 
many years.  

It'll be clear later why we mention this, but Git and Mercurial maintain branches from the root folder of the 
checkout clone, and maintains a single permission for a user in respect of Read and/or write on the branch and/or repository.

There is a suggestion that Mercurial is receiving contributions that will allow it to push into the very repository
territory the likes of Google needs.

Git and Mercurial don't have branch or directory permissions, but some of the platforms that bundle them, add 
branch permissions.

### Linux Torvalds presenting Git to Googlers

Back in 2007 Linus Torvalds presented his Bitkeeper inspired Git to Googlers in their Mountain View. 
[See here](https://www.youtube.com/watch?v=4XpnKHJAok8). He had started making it two years before, and it is now the #1
VCS choice. Google had been running their Monorepo style Trunk for a few years at this point, without regret. Some
Googlers would later extend their Perforce (see below) setup to allow Git operation of local branches on
developer workstations.

### Platform Software Choices

* [Github](https://github.com/) - Git, cloud 
* [Github Enterprise](https://enterprise.github.com/home) - Git in Github's on-premises edition
* [Gitlab](https://about.gitlab.com/) - Git, cloud and on-premises install
* Atlassian's [Bitbucket server](https://www.atlassian.com/software/bitbucket/server) - Git and Mercurial
* [RhodeCode](https://rhodecode.com/) - Git, Mercurial
* Various [Collabnet](http://www.collab.net/) products and services for Git
* Microsoft's [Team Foundation Server](https://www.visualstudio.com/tfs/) - git, on-premises install

## Perforce

[Website](https://www.perforce.com/)

Perforce is a closed-source, industrial strength VCS. Pixar store everything needed to make a movie in it, and Addidas 
store all their designs in it.  Until 2012, Google had their Trunk in it, and moved off to an in-house solution it 
because their non-functional needs exceeded it. Perforce is peculiar in that 'p4d' (a single server-side executable 
binary file) is the whole server and does not need to be installed - just executed.

Perforce is the last VCS technology that ordinarily maintains the read-only bit on the developer workstation. You 
definitely need a plugin for your IDE to handle the wire operations with the server, so you are not confronted with the
fact that source files are read-only. Because the Perforce (p4) client having to involve the server for the flipping of
read only bits in respect of editing source files, it requires a permanent connection to the server.

Unlike Git, Perforce is not ordinarily able to **locally** show history of the files within it. It needs that server 
connection again.

Perforce allows branches to be setup at any sub-directory not just the root one. It also allows read and/or write
permissions to exist at any directory (or branch) within large and small source trees.

A crucial and unmatched feature of Perforce in other VCS technology choices is its 'client spec'. 
More on that in [Monorepos](/monorepos/).

### No Code Review

Perforce does not have code-review features integrated into its server daemon. By customizing a GitSwarm (Gitlab) 
'side install', Perforce now has a code review capability.

### Git Fusion

There's a VM appliance from the Perforce people, that can sit in your infrastructure and mediate between the perforce
server, and your wish to use Git in an idiomatic way on your development workstation.

With a Git-fusion clone from a Perforce repository, and client spec was specified, you get the subsetted 
representation of the source tree, complete with history. That's a neat feature. 

GitSwarm kinda replaces this.

### p4-git and p4-dvcs

P4-git is very similar to the Git fusion technology, but is not my the Perforce people themselves. It also does not 
require the launching of second server applicance.

In 2015, the perforce technolgies were extended to include custom DVCS features. All the features of P4-git but without the Git 
compatibility.

## Subversion

[Website](https://subversion.apache.org/)

Subversion (Svn) has been in development for 16 years, and was a sorely needed open-source replacement for CVS. It chases some of the
features of Perforce, but is developed quite slowly. Nobody has pushed Subversion to the Perforce usage levels, but 
that is claimed as a possibility.

Note also the Subversion team themselves, do not do trunk based development, despite Subversion have default root directories 
of 'trunk', 'tags' and 'branches' for newly-created repositories.

Subversion, like Perforce, has read and write permissions down to the directory and branch.

Interestingly there is a "Subversion vs Git" website{{< ext url="https://svnvsgit.com/" >}}. It does not have a 
feedback/contact mechanism in order suggest updates (some claims are out of date).

### No Code Review

Note that Subversion has no local branching capability, and to get code review you need to install third-party servers 
along side it or (better choice) use a platform that integrates code review like RhodeCode.

### Git-Svn

There is an extension to Git that allows it to deal with a Subversion backend. a Git-subversion clone can has all the 
local history, local-branching possibilities of Git. That clone from subversion can be many tens of times slower (for 
the same history set), than the equivalent clone from Git. The local branching possibilities afforded by this
mode of operation are very handy, and it should work easily with whatever Svn hosting platform you installed.

### Platform Software Choices

* [RhodeCode](https://rhodecode.com/) - installable on premises
* Various [Collabnet](http://www.collab.net/) products and services.
* [ProjectLocker](http://projectlocker.com/) - cloud
* [Deveo](https://deveo.com/svn-hosting/) - cloud
* [RiouxSvn](https://riouxsvn.com/) - cloud
* [SilkSvn](https://sliksvn.com/) - cloud
* [Assembla](https://www.assembla.com/subversion/) - cloud and installable on premises
* [XP-dev](https://xp-dev.com/) - cloud
* [Codeplex](https://www.codeplex.com/) - cloud

## Team Foundation Server - TFS

[Website](https://www.visualstudio.com/tfs/)

Microsoft launched TFS in the mid 2000's with a **custom VCS technology** "TFVC". It is said that they have an internal 
'SourceDepot' tool that is a special version of Perforce compiled for them in the nineties, and that TFS reflects some 
of the ways of working of that technology. It has grown to to be a multifaceted server platform. Perhaps even a 
one-stop shop for the whole enterprise's needs for application lifecycle management.  It is perfectly compatible with 
a Trunk Based Development usage.

## PlasticSCM

[Website](https://www.plasticscm.com/)

PlasticSCM is a modern DVCS like Git and Mercurial. It is compatible with Trunk Based Development and quite 
self-contained (has integrated code review, etc). It is also the first modern VCS to have semantic merge - it understands 
select programming languages and the refactorings developers perform on them. For example "move method", where that
method is 50 lines long, isn't 50 lines added and 50 deleted in one commit, it is a much more *exact* and terse diff
representation.