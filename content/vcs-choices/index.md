---
date: 2016-03-09T20:08:11+01:00
title: Version Control System - choices
weight: 50
---

## Git and Mercurial

Git and Mercurial have been popular DVCS technologies for many years. Portals like Github make Git the default 
choice for SCM/SVC/source-control.  While the Linux Kernel is maintained with Git, and definately takes advantage 
of the D-Distributed aspect of the DVCS of Git (in that many divergent versions of kernel can exist over 
long periods of time), most enterprises are still going to count a single repo as the principal one, and within 
that a single branch as the long-term "most valuable" codeline.

It is perfectly possible to do Trunk Based Development in a Git repository. By convention 'master' is the long term 
most valuable branch, and once cloned to your local workstation, the repo gains a nickname of 'origin'.

An effective Trunk Based Development strategy, for Git, depends on the developer maintaining a fork of the origin 
(and of master within), and Pull-Requests being the place that ready to merge commits are code reviewed, before being 
consumed back into origin:master.

Historically, Git and Mercurial were not great at maintaining a zipped history size greater that 1GB. Many 
teams have reported that they have a repository size larger than that, so opinions differ. One way that you can reach 
that 1GB ceiling quickly is with larger binaries. As Git keeps history in the zipped repository, even a single larger 
binary that changes frequently can push the total use above 1GB.

With the likes of correctly configured Git-LFS extension to Git, though, the 1GB limit can be avoided or delayed 
many years.  

It'll be clear later why we mention this, but Git and Mercurial maintain branches from the root folder of the 
checkout clone, and maintains a single permission for a user in respect of Read and/or write on the branch and/or repo.

There is a suggestion that Mercurial for one, is recieving contributions that will allow it to super-achieve on a scale
basis.

## Perforce

Perforce is an industrial strength VCS. Pixar store everything needed to make a movie in it, and Addidas store all their 
designs in it.  Until 2012, Google had their Trunk in it, and only moved off it because their non-functional needs
exceeded it.

Perforce is the last VCS technology that ordinarily maintains the read-only bit on the developer workstation. You 
definately need a plugin for your IDE to handle the wire operations with the server, so you are not confronted with the
fact that source files are read-only. Because the Perforce (p4) client having to involve the server for the flipping of
read only bits in respect of editing source files, it requires a permanent connection to the server.

Unlike Git, Perforce isn't ordinarily able to locally show history of the files, within it. It needs that server 
connection again.

Perforce allows branches to be setup at any sub-directory not just the root one. It also allows read and/or write
permissions to exist at any directory with the large source tree.

A crucial and unmatched feature of Perforce is the 'client spec'. More on that in [Monorepos](/monorepos/).

### Git Fusion

There's a VM applicance from the Perforce people, that can sit in your infrastructre and mediate between the perforce
server, and your wish to use Git in a Git-idiomatic way on your dev workstation.  This mode of operation doesn't have 
the read-only bit feature, and also maintains

With a Git-fusion clone from a Perforce repository, if a client spec was specified, you get the constrained 
representation of the source tree, complete with history. That's a neat feature. As well as local history, you are 
also no longer restrained by the read-only bit on individual files.

### p4-git

This is very similar to the Git fusion technology, but is not my the Perforce people themselves. It also doesn't 
require the launching of second server daemon.

### p4-dvcs

Perforce was extended in 2015 to include it's own DVCS features. All the features of P4-git but without the Git 
compatibility.

## Subversion

Subversion has been in development for 16 years, and was a sorely needed replacement for CVS. It chases some of the
features of Perforce. Nobody has pushed Subversion to the Perforce usage levels, but that is claimed as a possibility.

Note: the Subversion team themselves, don't do trunk based development, despite Subversion have default root directories 
of 'trunk', 'tags' and 'branches' for newly-created repositories.

### Git-Svn

There is an extension to Git that allows it to deal with a Subversion backend. a Git-subversion clone can has all the 
local history, local-branching possibilities of Git. That Clone from subversion can be many tens of times slower (for 
the same history set), than the equivalent clone from Git.


