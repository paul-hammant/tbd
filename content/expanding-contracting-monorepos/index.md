---
date: 2016-11-02T20:08:11+01:00
title: Expanding Contracting Monorepos
weight: 112
---
 
At some point with a monorepo approach to source control (especially with binary dependencies in the source tree), your checkouts 
could be bigger than your local workstation's hard drive. Or even if the checkout is not too big for your hard drive, 
then it might be too much for your IDE, and you do not want to have to abandon it for Vim/Emacs. Or maybe it is not your IDE that 
chokes but rather is something about the build that's too much locally, despite command-line arguments to attempt to
pare it down for a shorter elapsed time.

There is a way to intelligently expand or contract the checkout on your developer workstation, to alleviate all of 
the above.

## Gcheckout.sh

Google's in-house DevOps uses some simple scripting to
modify the checkout on the developer's workstation to omit the source files/packages that are not needed for the 
current intentions of the developer. This Blaze related technology is a shell command called 'gcheckout'. It can modify the mappings between the multi-gigabyte HEAD 
revision of company-wide trunk (monorepo) and developer's own workstation. Thus the source-control tools maintain the 
**smallest possible subset** of the monorepo on the developer's workstation, for them to perform their daily work. 
Google and the industry refer to the general feature as 'sparse checkout'.

You can run `gcheckout` at any time to modify your sparse checkout to be bigger or smaller (or wholly different) for 
different reasons. All of those are operations on your local representation of a larger trunk.

## Contrived example of use

We detailed two intentions for directed graph build systems above, using a contrived application. Here is one more:

* I now want to change `TheORMweBothDependOn`, because a change to `MyTeamsApplication` requires me to do that.

In Google, rather than feed into the backlog of the team that maintains `TheORMweBothDependOn` (which may exist as a part-time 
committee rather than a team), the developer in question would make the change themselves. Perhaps they had made 
it in the same commit as the first usage of it for `MyTeamsApplication`.  In the code review cycle (Google practices
common code ownership), the approvers for the `TheORMweBothDependOn` would see all the changes together. The larger change is
all accepted or rejected (to be remediated) atomically.

So our developer was working on `MyTeamsApplication`, which depended on `TheORMweBothDependOn` (which probably transitively 
depended on other things). Now that developer is going to change `TheORMweBothDependOn` and that impacts `TheirApplication` 
too. The Blaze related checkout-modifying technology 'gcheckout' performs an expansion to bring in `TheirApplication` to the
developer's checkout. From that moment on, the developer doing update/pull/sync will bring down minute by minute
changes to those three modules.  For free, the build expands to make sure that the `TheORMweBothDependOn` changes do not 
break either of `MyTeamsApplication` or `TheirApplication`.

### Directory structure and working copy.

If I ran `gcheckout` with MyTeamsApplication+TheirApplication as the parameter I would get working copy that looked like:

```txt
root/
  java/
    BUILD
    com/
      BUILD
      google/
        BUILD
        myteamsapplication/
          BUILD
          MyTeamsApplication.java  // and hundreds of other packages and source files
        theirapplication/
          BUILD
          TheirApplication.java  // and hundreds of other packages and source files
        theormwebothdependon/
          BUILD
          TheORMweBothDependOn.java  // and hundreds of other packages and source files
  java_test/
    BUILD
    com/
      BUILD
      google/
        BUILD
        myteamsapplication/
          BUILD
          MyTeamsApplicationTest.java  // and hundreds of other packages and source files
        theirapplication/
          BUILD
          TheirApplicationTest.java  // and hundreds of other packages and source files
        theormwebothdependon/
          BUILD
          TheORMweBothDependOnTest.java  // and hundreds of other packages and source files
```

If I ran `gcheckout` with MyTeamsApplication as the parameter I would get working copy that looked like:

```txt
root/
  java/
    BUILD
    com/
      BUILD
      google/
        BUILD
        myteamsapplication/
          BUILD
          MyTeamsApplication.java  // and hundreds of other packages and source files
        theormwebothdependon/
          BUILD
          TheORMweBothDependOn.java  // and hundreds of other packages and source files
  java_test/
    BUILD
    com/
      BUILD
      google/
        BUILD
        myteamsapplication/
          BUILD
          MyTeamsApplicationTest.java  // and hundreds of other packages and source files
        theormwebothdependon/
          BUILD
          TheORMweBothDependOnTest.java  // and hundreds of other packages and source files
```

If I ran `gcheckout` with TheORMweBothDependOn as the parameter I would get working copy that looked like:

```txt
root/
  java/
    BUILD
    com/
      BUILD
      google/
        BUILD
        theormwebothdependon/
          BUILD
          TheORMweBothDependOn.java  // and hundreds of other packages and source files
  java_test/
    BUILD
    com/
      BUILD
      google/
        BUILD
        theormwebothdependon/
          BUILD
          TheORMweBothDependOnTest.java  // and hundreds of other packages and source files
```

You can keep rerunning the `gcheckout` to expand or contract your working copy to meet your current goals.

## Contrived example of use #2

We used 'change the wheel on a car', on the [Branch By Abstraction](/branch-by-abstraction/) page for its contrived 
example. It will serve us again here. The wheel is what we want to change. The other team using 'Wheel(s)' is making a 
Segway thing (two wheels and self-balancing via high-torque and very responsive motors). Here's the procedure:

![](car_segway.png)  
 
The starting position is two teams working separately, using 'Wheel' (4 for cars, 2 for Segways). Without any commits 
happening the engineer changing 'Wheel' for everyone, runs gcheckout (or its equivalent) to modify the source in the 
IDE to the union of Car and Segway (and in-house dependencies). That is marked as step 0. Let us say the
change is quick/easy this time (not requiring Branch By Abstraction) step 1 shows the single commit that changes
the wheel implementation for everyone.  After the commit/push, running again shows the application focused team checkout - either 
'Car' or 'Segway'.
 
## Git's Sparse checkouts

Git has a 'sparse checkout' capability, which exactly facilitates this sort of thing. Subversion and Mercurial do too.  
Perforce has a 'client spec' capability that is more or less the same. A team wanting to have their own gcheckout equivalent
would have some scripting around sparse checkouts (or equivalent). 
 
### Using Git this way today

If you're willing to go a 'split history' maneuver on your monorepo once or twice a year, Git can do the expandable and 
contractible monorepo setup today. 

## Perforce's client-specs

Perforce has a 'client spec' (alternatively 'view') that is accessed via the client command or UI. Amongst other things, it 
allows a checkout to be a subset of the directories/files available within the branch. A list of globbed includes and 
excludes is the format. You would script this (as Google did until 2012) to have a directed graph driven 
expandable/contractible checkout.

## PlasticSCM's cloaked.conf

As Perforce, but via 'cloaked.conf' file.

## Subversion's sparse-checkouts

Subversion has a 'sparse checkout' capability. You do a series of checkout operations at various directory levels in order
to create the mapping, so is less atomic or centrally configured than the others.  They have made also made a 'viewspec' script
{{< ext url="http://svn.apache.org/repos/asf/subversion/trunk/tools/client-side/svn-viewspec.py" >}}
to allow the reshaping of the working copy to happen in a more declarative way.
