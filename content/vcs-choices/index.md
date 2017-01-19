---
date: 2016-03-09T20:08:11+01:00
title: Version Control System (VCS) - choices
weight: 50
---

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

There is a suggestion that Mercurial for one, is receiving contributions that will allow it to super-achieve on a scale
basis.

### Linux Torvalds presenting Git to Googlers

Back in 2007 Linus Torvalds presented his Bitkeeper inspired Git to Googlers in their Mountain View. 
[See here](https://www.youtube.com/watch?v=4XpnKHJAok8). He'd started making it two years before, and it is now the #1
VCS choice. Google had been running their Monorepo style Trunk for a few years at this point, without regret. Some
Googlers would later extend their Perforce (see below) setup to allow Git operation of local branches on
developer workstations.

### Platform Software Choices

* [Github](https://github.com/) and its enterprise on-premises edition [Github Enterprise](https://enterprise.github.com/home) - Git
* [Gitlab](https://about.gitlab.com/) - Git
* Atlassian's [Bitbucket server](https://www.atlassian.com/software/bitbucket/server) - Git and Mercurial
* [RhodeCode](https://rhodecode.com/) - Git, Mercurial and Subversion
* Various [Collabnet](http://www.collab.net/) products and services.

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

Unlike Git, Perforce isn't ordinarily able to **locally** show history of the files within it. It needs that server 
connection again.

Perforce allows branches to be setup at any sub-directory not just the root one. It also allows read and/or write
permissions to exist at any directory with the large source tree.

A crucial and unmatched feature of Perforce in other VCS technology choices is its 'client spec'. 
More on that in [Monorepos](/monorepos/).

### No Code Review

A standard Perforce install, does not have a code review capability, which is a crucial feature for modern teams.
In the early 2000's Google made custom tooling around their Perforce to have code-review features, and also support
pre-commit verification of commits. The code-review tool they wrote gained a UI called Mondrian - see Guido van 
Rossum talking about it in 2006[![](/images/ext.png)](https://www.youtube.com/watch?v=CKjRt48rZGk). Later on, the 
open source Gerrit was created, and other tools were created too, in 
that style, including Phabricator[![](/images/ext.png)](https://en.wikipedia.org/wiki/Phabricator) from Facebook 
engineers. 

Github for Git came along with the concepts of forks and had a rudimentary 'code review' built in from 
2008[![](/images/ext.png)](https://github.com/blog/42-commit-comments). From that moment it was clear 
that to compete with Github your would need integrated code-review functionality, and Perforce didn't have one. Later 
though, the Perforce people, in partnership with GitLab would launch a portal capability for Perforce that
included code review. It is a VM appliance that interoperates with the canonical 'p4d' server daemon. Not
all existing Perforce licensees have installed it.

### Git Fusion

There's a VM appliance from the Perforce people, that can sit in your infrastructure and mediate between the perforce
server, and your wish to use Git in a Git-idiomatic way on your development workstation.  This mode of operation does not have 
the read-only bit feature, and also maintains

With a Git-fusion clone from a Perforce repository, if a client spec was specified, you get the constrained 
representation of the source tree, complete with history. That's a neat feature. As well as local history, you are 
also no longer restrained by the read-only bit on individual files.

### p4-git

This is very similar to the Git fusion technology, but is not my the Perforce people themselves. It also does not 
require the launching of second server daemon.

### p4-dvcs

Perforce was extended in 2015 to include its own DVCS features. All the features of P4-git but without the Git 
compatibility.

## Subversion

[Website](https://subversion.apache.org/)

Subversion has been in development for 16 years, and was a sorely needed open-source replacement for CVS. It chases some of the
features of Perforce. Nobody has pushed Subversion to the Perforce usage levels, but that is claimed as a possibility.

Note also the Subversion team themselves, don't do trunk based development, despite Subversion have default root directories 
of 'trunk', 'tags' and 'branches' for newly-created repositories.

### No Code Review

Note that Subversion has no local branching capability, and to get code review you need to install third-party servers 
along side it. Google for those[![](/images/ext.png)](https://www.google.com/search?q=subversion+code+review). RhodeCode
(see below) has code review for Subversion build in.

### Git-Svn

There is an extension to Git that allows it to deal with a Subversion backend. a Git-subversion clone can has all the 
local history, local-branching possibilities of Git. That clone from subversion can be many tens of times slower (for 
the same history set), than the equivalent clone from Git.  While the local branching possibilities afforded by this
git enablement, and very handy, there's still no code-review, and you still need make an additional server selection 
(see above).

### Platform Software Choices

* [RhodeCode](https://rhodecode.com/) - Git, Mercurial and Subversion
* Various [Collabnet](http://www.collab.net/) products and services.

## Team Foundation Server - TFS

[Website](https://www.visualstudio.com/tfs/)

Microsoft launched TFS in the mid 2000's. It is said that they have an internal 'SourceDepot' tool that is a special 
version of Perforce compiled for them in the nineties, and that TFS reflects some of the ways of working of that 
technology. It has grown to to be a multifaceted server platform. Perhaps even a one-stop shop for the whole 
enterprise's needs for application lifecycle management.  It is perfectly compatible with a Trunk Based Development 
usage.

## 