---
date: 2016-11-01T20:08:11+01:00
title: Monorepos
weight: 111
---

A Monorepo, is a specific trunk based development implementation where the organization in 
question puts its source for all applications/service/libraries/frameworks into one trunk, and forces developers 
to commit together in that trunk - atomically.

Google has the most famous monorepo, and they do the above AND force teams to **share code at source level instead of 
linking in previously built binaries**. Specifically, they have no version numbers for their own dependencies, just an 
implicit 'HEAD'. Third party libraries (like JUnit) will be checked into the repo with a specific version number 
(like 4.11), and all teams will use that version if they use it at all.

The deployment and/or release cadences for each applications/service/libraries/frameworks will probably be different 
as will the teams structures, methodologies, priorites, story backlogs etc.

The name 'monorepo' is a newer for a previously unnamed practice that is more than a decade old.

Monorepo implementations deliver a couple of principal goals:

* Acquire as many third-party and in-house dependencies as possible for a build from the **same** source-control repository/branch, and in the 
same update/pull/sync operation.
* Keep all teams in agreement on the versions of third-party and in-house dependencies via lock-step upgrades.

And some secondary goals:

* Allow changes to common dependencies to via atomic commits.
* Allow the extraction of new common dependencies (from existing code) to be achieved in atomic commits.
* Force all developers to focus on the HEAD revisions of files in the trunk

Google and Facebook are the most famous organizations that rest development on a single conpany-wide trunk, that 
fits the monorepo design. 
 
## Third party dependencies

With the monorepo model, there is a strong desire to have third-party binaries in source-control too. 
You might think that it would be unmanageable for reasons of size. In terms of history, Perforce and Subversion do not
mind a terabyte of history of binary files (or more), and Git performed much better when Git-LFS was created. You 
could still feel that the HEAD revision of thousands of fine-grained dependencies is too much for a workstation, but 
that can be managed via 'sparse checkout' techniques (see below).

Note:  Python, Java, C++ and other SDKs are installed the regular way on the developer workstation, and not acquired 
from the source-control repository/branch. 

## In-house dependencies
 
It could be that your application team depends on something that is made by colleagues from a different team. An 
example could be an Object Relational Mapping (ORM) library. For Monorepo teams there is a strong wish to depend on 
the source of that ORM technology, and not a binary. There are multiple reasons for that, but principal one is that 
source control update/pull/sync is the most efficient way for you to keep up with the HEAD of a library on a minute
by minute basis. Thus `MyTeamsApplication` and `TheORMweDepOn` should be in your source tree in your IDE at the same time.
Similarly another team that depends on `TheORMweDepOn` should have it and `TheirApplication` checked out at the same
time.

## Directed graph build systems

To facilitate Monorepos, it is important to have a build system that can omit otherwise buildable things/steps that are not
required for the individual developers **current** build intention. 

The general directory structure for directed graph build systems is like so:

```
root/
    prod_code/
        build_file.xml
        (source files)
        a_directory/
            build_file
            (source files)
            another_directory/
                build_file.xml
                (source files)
        yet_another_directory/
            build_file.xml
    test_code/
        build_file.xml
        (source files)
        a_directory/
            build_file
            (source files)
            another_directory/
                build_file.xml
                (source files)
        yet_another_directory/
            build_file.xml
            (source files)
  ```
  
Obviously, YAML, JSON, TOML or custom grammars are alternatives to XML, for build files.
  
### Contrived example

Two examples:

* I want to run impacted tests locally, relating to the hair-color field I just added to the person page of `MyTeamsApplication`
* I want to run bring up `MyTeamsApplication` locally, so I can play with the hair-color field I just added to the person page 

Not only do you want to omit unnecessary directories/files from your build's activities, you probably also want to omit 
them from your IDE.

### Facebook's Buck and Google's Bazel

Google has Blaze internally. Ex Googlers at Facebook (with newfound friends) missed that, wrote 
Buck{{< ext url="https://buckbuild.com" >}} and then 
open-sourced it. Google then open-sourced a cut-down Blaze as Bazel{{< ext url="https://bazel.build" >}}. 
These are the two (three incl. Blaze) are directed graph build systems that allow a large tree of sources to be speedily 
subset in a compile/test/make-a-binary way. 
 
The omitting of unnecessary compile/test actions achieved by Buck and Bazel works equally well on developer workstations 
and in the CI infrastructure.

There is also the ability to depend on recently compiled object code of colleagues. Recently compiled object code for 
provable permutations of sources/dependencies, that is, and plucked from the ether (think of a LRU cache available to all
machines in the TCP/IP subnet). That is in place to shorten compile times for prod and test code.
 
## Recursive build systems

Java's Apache-Maven is the most widely used example. It's predecessor, Ant, is another. Maven more than Ant, pulls
third party binaries from 'binary repositories', caching them locally. Most recursive build systems can
be configured to pull third party dependencies from a relative directory in the monorepo. That is not conventional 
though.

The general directory structure for recursive build systems is like so:

```
root/
    build_file.xml
    module_one/
        build_file.xml
        src/
            (prod source directory tree)
            (test source directory tree)
        module_two/
            build_file.xml
            src/
                (prod source directory tree)
                (test source directory tree)
    module_three/
        build_file.xml
        src/
            (prod source directory tree)
            (test source directory tree)
    src/
        (prod source directory tree)
        (test source directory tree)

```

Again, YAML, JSON, TOML and custom grammars are alternatives to XML for build files.

Recursive build systems mostly have the ability to choose a type of build. For example 'mvn test' to just run tests, 
and not make a binary for distribution.
 
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
 
## The diamond dependency problem
 
What happens when two apps need different version of a dependency? 

For in-house dependencies, where the source is in the same monorepo, then you will not have ths situation, as the 
team that first wanted the increased functionality, performed it for all teams, keeping everyone at HEAD revision 
of it. The concept of version number disappears in this model.

### Third party dependencies

For third-party dependencies, the same rules applies, everyone upgrades in lock-step. Problems can ensure, of course, 
if there are real reasons for team B to not upgrade and team A was insistent. Broken backwards compatibility is 
one problem. 

In 2007, Google tried to upgrade their JUnit from 3.8.x to 4.x and struggled as there was a subtle 
backwards incompatibility in a small percentage of their uses of it. The change-set was very large, and presumably 
the both the IDE and the javac compiled buckled to some degree.

Because you are doing lock-step upgrades, you only secondarily note the version of the third party 
dependencies, as you check them in to source control without version numbers in the file name.  I.e. JUnit goes in as
`third_party/java_testing/junit.jar`.

## Clash of ideologies

Above we contrasted **directed graph** and **recursive** build systems. The former are naturally compatible
with expandable/collapsible checkout technologies. The latter not necessarily so.

### Maven
 
Recursive build systems like maven, have a forward declaration of modules that should be built, like so:

```xml
<modules>
  <module>moduleone</module>
  <module>moduletwo</module>
</modules>
```

Presently though, these build technologies do not have the ability to follow
a changeable checkout that the likes of gcheckout can control.

Directories `moduleone` and `moduletwo` have to exist in order for the build to work. The idea of expandable/collapsible 
monorepos, is that trees of buildable things are **calculated or computed** not **explicitly declared**. 
In order to deliver that, you would need a feature to be added Maven like so:

```xml
<modules>
  <calculate/> <!--or--> <search/>
</modules>
```

Or you could "hack it" and rewrite your pom.xml files after every expansion or 
contraction{{< ext url="http://paulhammant.com/2017/01/27/maven-in-a-google-style-monorepo/" >}}.

# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>

Date    | Type  | Article
--------|-------|--------
09 Apr 2013 | Blog entry | [Scaling Trunk Based Development](http://paulhammant.com/2013/04/09/scaling-trunk-based-development/)
06 May 2013 | Blog entry | [Google's Scaled Trunk Based Development](http://paulhammant.com/2013/05/06/googles-scaled-trunk-based-development/)
06 Jan 2014 | Blog entry | [Googlers Subset their Trunk](http://paulhammant.com/2014/01/06/googlers-subset-their-trunk/)
08 Jan 2014 | Blog entry | [Google's vs Facebook's Trunk Based Development](http://paulhammant.com/2014/01/08/googles-vs-facebooks-trunk-based-development/)
10 Apr 2014 | Blog entry | [Continuous Delivery: The price of admission..](http://paulhammant.com/2014/04/10/cd-the-price-of-admission/)
10 Oct 2014 | Conference Talk | [Trunk Based Development in the Enterprise - Its Relevance and Economics](https://www.perforce.com/merge/2014-sessions/trunk-based-development-enterprise-its-relevance-economics)
18 May 2015 | Blog entry | [Advantages of monolithic version control](http://danluu.com/monorepo/)
20 May 2015 | Blog entry | [Turning Bazel back into Blaze for monorepo nirvana](http://paulhammant.com/2015/05/20/turning-bazel-back-into-blaze-for-monorepo-nirvana/)
27 Jan 2017 | Blog entry | [Maven In A Google Style Monorepo](http://paulhammant.com/2017/01/27/maven-in-a-google-style-monorepo/)
