---
date: 2016-03-09T20:08:11+01:00
title: Monorepos
weight: 30
---

Monorepos is a specific trunk usage that is at least decade older than its name (coined in 2013 (?)).

Monorepo implementations deliver a principal goal:

* Acquire as many dependencies as possible for a build from the same source-control repo/branch

Google and Facebook are the most famous organizations that rest development on a single conpany-wide trunk, that 
fits the monorepo design. 
 
## Third party dependencies
 
If could be that Python/Java/C++ SDKs are installed the regular way and not acquired from the source-control 
repo/branch. 

There is always strong desire to push third-party binaries into the company-wide trunk too (hello Git-LFS). 

## In-house dependencies
 
It could be that your application team depends on something that is made by colleagues from a different team. An 
example could be an Object Relational Mapping (ORM) library. For Monorepo teams there is a strong wish to depend on 
the source of that ORM technology, and not a binary. There are multiple reasons for that, but principal one is that 
source control update/pull/sync is the most efficient way for you to keep up with the HEAD of a library on a minute
by minute basis. Thus `MyTeamsApplication` and `TheORMweDepOn` should be in your source tree in your IDE at the same time.
Similariy another team that depends on `TheORMweDepOn` should have it and `TheirApplication` checked out at the same
time.

## Directed graph build systems

To facilitate Monorepos, it is important to have a build system that can omit buildable things/steps that are not
required for the current individual developers current intention.  Two examples:

* I want to run impacted tests locally, relating to the hair-color field I just added to the person page of `MyTeamsApplication`
* I want to run bring up `MyTeamsApplication` locally, so I can play with the hair-color field I just added to the person page 

Not only do you want to omit unnecessary directories/files from your build's activities, you probably also want to omit 
them from your IDE.

### Buck and Bazel

Google has Blaze internally. Ex Googlers at Facebook (with newfound friends) pined for that, wrote Buck and then 
open-sourced it. Google then open-sourced a cut-down Blaze and Bazel. These are the two (three incl. Blaze) directed
graph build systems that allow a large tree of sources to be speedily subset in a compile/test/make-a-binary way. 
 
The subsetting achieved by Buck and Bazel work equally well on developer workstations, and in the CI infrastructure.

There is also the ability to depend on recently compiled object code of colleagues. Recently compiled object code for 
provable permutations of sources/deps, that is, and plucked from the ether (think of a LRU cache available to all
machines in the TCP/IP subnet). That is in place to shorten compile times for prod and test code.
 
## Too big for your boots 
 
As some point, if you are depending on in-house dependencies at a source level, your checkout could be bigger than 
your workstations hard drive.  Google using some simple scripting modify the checkout on the developers workstation 
to omit the source files/packages that are not needed for the current intentions of the developer. 

### Gcheckout

In Google, A Blaze related technology called 'gcheckout' can modify the mappings between the multi-terrabye HEAD 
revision of company-wide trunk (monorepo) and developers workstation. Thus the source-control tools maintain the 
smallest possible subset of the monorepo on the developers workstation. 

We detailed two intentions above. Here is one more:

* I now want to change `TheORMweDepOn`, because a change to `MyTeamsApplication` needs me to do that.

In Google, rather than feed into the backlog of the team that maintains `TheORMweDepOn` (which may exist as a part 
time committee rather than a team), the developer in question would make the change themselves. Perhaps they'd make 
it in the same commit as the the first usage of it for `MyTeamsApplication`.  In the code review cycle (Google do
common code ownership), the approvers for the `TheORMweDepOn` would see all the changes together. The larger change is 
all acccepted or rejected (to be remediated) atomically.

So our developer was working on `MyTeamsApplication`, which depended on `TheORMweDepOn` (which probably transitively 
depended on other things). Now that developer is going to change `TheORMweDepOn` and that impacts `TheirApplication` 
too. The Blaze related checkout-modifying technology performs an expansion to bring in `TheirApplication` to the 
developers checkout. From that moment on, the developer doing update/pull/sync will bring down minute by minute
changes to those three modules.  For free, the build expands to make sure that the `TheORMweDepOn` changes don't 
break either of `MyTeamsApplication` or `TheirApplication`.
 
# Recursive build systems

Java's Apache-Maven is the most widely used example. It's predecessor, Ant, is another. Maven more than Ant, pulls
third party binaries from 'binary repositories', perhaps caching them locally. Most recursive build systems can
be configured to pull third party dependenciess from a relative directory in the monorepo. That is not conventional 
though.

Recursive build systems mostly have the ability to choose a type of build. For example 'mvn test' to just run tests, 
and not make a binary for distribution. Presently though, these build technologies don't have the ability to follow
a changeable checkout that the likes of gcheckout can control.


<h2 id="refs">References Elsewhere></h2>

Date    | Article
--------|--------

2013-04-09 | [Scaling Trunk Based Development](http://paulhammant.com/2013/04/09/scaling-trunk-based-development/)
2015-05-18 | [Advantages of monolithic version control](http://danluu.com/monorepo/)