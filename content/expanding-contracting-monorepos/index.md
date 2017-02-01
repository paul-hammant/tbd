---
date: 2016-11-02T20:08:11+01:00
title: Monorepos
weight: 112
---

## Expandable and Contractible Checkouts 
 
As some point, if you are depending on in-house dependencies at a source level and you work for a big company, your 
checkouts could be bigger than your workstation's hard drive. Google's in-house DevOps uses some simple scripting 
modify the checkout on the developers workstation to omit the source files/packages that are not needed for the 
current intentions of the developer. 

### Gcheckout.sh

In Google, a Blaze related technology called 'gcheckout' can modify the mappings between the multi-gigabyte HEAD 
revision of company-wide trunk (monorepo) and developer's own workstation. Thus the source-control tools maintain the 
**smallest possible subset** of the monorepo on the developers workstation, for them to perform their daily work.

### Contrived example

We detailed two intentions for directed graph build systems above, using a contrived application. Here is one more:

* I now want to change `TheORMweDepOn`, because a change to `MyTeamsApplication` needs me to do that.

In Google, rather than feed into the backlog of the team that maintains `TheORMweDepOn` (which may exist as a part 
time committee rather than a team), the developer in question would make the change themselves. Perhaps they had make 
it in the same commit as the first usage of it for `MyTeamsApplication`.  In the code review cycle (Google do
common code ownership), the approvers for the `TheORMweDepOn` would see all the changes together. The larger change is 
all accepted or rejected (to be remediated) atomically.

So our developer was working on `MyTeamsApplication`, which depended on `TheORMweDepOn` (which probably transitively 
depended on other things). Now that developer is going to change `TheORMweDepOn` and that impacts `TheirApplication` 
too. The Blaze related checkout-modifying technology performs an expansion to bring in `TheirApplication` to the 
developers checkout. From that moment on, the developer doing update/pull/sync will bring down minute by minute
changes to those three modules.  For free, the build expands to make sure that the `TheORMweDepOn` changes do not 
break either of `MyTeamsApplication` or `TheirApplication`.
 
### Contrived example 2 

We used 'change the wheel on a car', on the [Branch By Abstraction](branch-by-abstraction/) page for its contrived 
example. It will serve us again here. Wheel is what we want to change. The other team using 'Wheel(s)' is making a 
Segway thing (two wheels and self balancing via high-torque and very responsive motors). Here's the procedure:

![](/images/car_segway.png)  
 
The starting position is two teams working separately, using 'Wheel' (4 for car, 2 for Segway). Without any commits 
happening the engineer changing 'Wheel' for everyone, runs gcheckout (or its equivalent) to modify the source in the 
IDE to the union of Car and Segway (and in-house dependencies). That is marked as step 0. Lets say the
change is quick/easy this time (not requiring Branch By Abstraction) step 1 shows the single commit that changes
wheel for everyone.  After the commit/push, running again shows the application focused team checkout - either 
'Car' or 'Segway'.
 
### Git's Sparse checkouts

Git has a 'sparse checkout' capability, which exactly facilitates this sort of thing. Subversion and Mercurial do too.  
Perforce has a 'client spec' capability that is more or less the same. A team wanting to have their own gcheckout equivalent
would have some scripting around sparse checkouts (or equivalent). 
 
{{< warning title="Risk of chaotic directory layout" >}}
Google's co-mingled applications and services site within highly structured and uniform source trees. A Java 
developer from one project team, instantly recognizes the directory structure for another team's application
or service. That goes across languages too. The design for the directory layout needs to be enforced globally. You can
see that in the way that Buck and Bazel structure things, even for unit, integration and functional tests. If you
cannot overhaul the directory structure of your entire world of project source, do not entertain a monorepo.
{{< /warning >}} 

## Doing this today

If you're willing to go a split history manoeuvre on your monorepo once or twice a year, Git can do the Expandable and 
Contractible monorepo now setup now, using sparse-checkout techniques.  Perforce (with client-specs) has always been able 
to do this. Subversion could too, with its slightly more cumbersome checkout command options.

