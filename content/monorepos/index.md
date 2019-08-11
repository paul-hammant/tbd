---
date: 2016-11-01T20:08:11+01:00
title: Monorepos
weight: 111
---

A Monorepo is a specific Trunk-Based Development implementation where the organization in
question puts its source for all applications/services/libraries/frameworks into one trunk and forces developers
to commit together in that trunk - atomically.

Google has the most famous monorepo and they do the above AND force teams to **share code at source level instead of
linking in previously built binaries**. Specifically, they have no version numbers for their own dependencies, just an
implicit 'HEAD'. Indeed, because of lock step upgrades for all, releases from their monorepos mean 'HEAD' **is** their
effective version number. Third-party libraries (like JUnit) will be checked into the repo with a specific version number
(like 4.11), and all teams will use that version if they use it at all.

The deployment and/or release cadences for each application/service/library/frameworks will probably be different
as will the team's structures, methodologies, priorities, story backlogs etc.

The name 'monorepo' is a newer name for a previously unnamed practice that is more than a decade old.

Monorepo implementations deliver a couple of principal goals:

* Acquire as many third-party and in-house dependencies as possible for a build from the **same** source-control repository/branch, and in the
same update/pull/sync operation.
* Keep all teams in agreement on the versions of third-party and in-house dependencies via lock-step upgrades.

And some secondary goals:

* Allow changes to multiple modules via **atomic commits**.
* Allow the extraction of new common dependencies (from existing code) to be achieved in atomic commits.
* Force all developers to focus on the HEAD revisions of files in the trunk
* Allow bisecting towards the root cause of a prod bug to be effected on multiple (potentially dissimilar) modules at the same time

Google and Facebook are the most famous organizations that rest development on a single company-wide trunk, that
fits the monorepo design. Netflix and Uber (iOS application) disclosed in 2017 that they do too. 

{{< warning title="Risk of chaotic directory layout" >}}
Google's co-mingled applications and services site within highly structured and uniform source trees. A Java
developer from one project team instantly recognizes the directory structure for another team's application
or service. That goes across languages too. The design for the directory layout needs to be enforced globally. You can
see that in the way that Buck and Bazel layout trees for production and test code. If you
cannot overhaul the directory structure of your entire repository, you should not entertain a monorepo.
{{< /warning >}}

### Lock-step deployments?

OK, so it is really important to note in a monorepo, that you don't have to do a lock-step deployment of a buildable/releaseable thing just because a dependency was upgraded. What is certain is the next deployment of that application/service will
contain the new dependency. "Next" is still a concern of the development team in
question. Monorepos only say "what" will be released, not "when". 

## Third-party dependencies

With the monorepo model, there is a strong desire to have third-party binaries in source-control too.
You might think that it would be unmanageable for reasons of size. In terms of commit history, Perforce and Subversion do not
mind a terabyte of history of binary files (or more), and Git performed much better when Git-LFS was created. You
could still feel that the HEAD revision of thousands of fine-grained dependencies is too much for a workstation, but
that can be managed via an [expanding and contracting monorepo](/expanding-contracting-monorepos/).

Note:  Python, Java, C++ and other SDKs are installed the regular way on the developer workstation, and not acquired
from the source-control repository/branch.

## In-house dependencies

It could be that your application team depends on something that is made by colleagues from a different team. An
example could be an Object Relational Mapping (ORM) library. For monorepo teams there is a strong wish to depend on
the source of that ORM technology and not a binary. There are multiple reasons for that, but the principal one is that
source control update/pull/sync is the most efficient way for you to keep up with the HEAD of a library on a minute
by minute basis. Thus `MyTeamsApplication` and `TheORMweDepOn` should be in your source tree in your IDE at the same time.
Similarly, another team that depends on `TheORMweDepOn` should have it and `TheirApplication` checked out at the same
time.

## Directed graph build systems

To facilitate monorepos, it is important to have a build system that can omit otherwise buildable things/steps that are not
required for the individual developer's **current** build intention.

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
      (source files)
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

Google has Blaze internally. Ex-Googlers at Facebook (with newfound friends) missed that, wrote
Buck{{< ext url="https://buckbuild.com" >}} and then
open-sourced it. Google then open-sourced a cut-down Blaze as Bazel{{< ext url="https://bazel.build" >}}.
These are the two (three including Blaze) directed graph build systems that allow a large tree of sources to be speedily
subset in a compile/test/make-a-binary way.

The omitting of unnecessary compile/test actions achieved by Buck and Bazel works equally well on developer workstations
and in the CI infrastructure.

There is also the ability to depend on recently compiled object code of colleagues. The recently compiled object code for
provable permutations of sources/dependencies, that is. And that code plucked from the ether (think of a LRU cache available to all
machines in the TCP/IP subnet). That is in place to shorten compile times for prod and test code.

## Recursive build systems

Java's Apache-Maven is the most widely used example. It's predecessor, Ant, is another. Maven more than Ant, pulls
third-party binaries from 'binary repositories', caching them locally. Maven also traverses its tree in a strict
depth first (then breadth) manner. Most recursive build systems can be configured to pull third-party dependencies
from a relative directory in the monorepo. A binary dependency cache outside of the VCS controlled working copy,
is more normal.

The general directory structure for recursive build systems is like so:

```
root/
  build_file.xml
  module_one/
    build_file.xml
    src/
      # prod source directory tree
      # test source directory tree
    module_two/
      build_file.xml
      src/
        # prod source directory tree
        # test source directory tree
  module_three/
    build_file.xml
    src/
      # prod source directory tree
      # test source directory tree
  src/
    # prod source directory tree
    # test source directory tree
```

Again, YAML, JSON, TOML and custom grammars are alternatives to XML for build files.

Recursive build systems mostly have the ability to choose a type of build. For example 'mvn test' to just run tests,
and not make a binary for distribution.


## The diamond dependency problem

What happens when two apps need a different version of a dependency?

For in-house dependencies, where the source is in the same monorepo, then you will not have this situation, as the
team that first wanted the increased functionality, performed it for all teams, keeping everyone at HEAD revision
of it. The concept of version number disappears in this model.

### Third-party dependencies

For third-party dependencies, the same rule applies, everyone upgrades in lock-step. Problems can ensue, of course,
if there are real reasons for team B to not upgrade and team A was insistent. Broken backward compatibility is
one problem.

In 2007, Google tried to upgrade their JUnit from 3.8.x to 4.x and struggled as there was a subtle
backward incompatibility in a small percentage of their usages of it. The change-set became very large, and struggled
to keep up with the rate developers were adding tests.

Because you are doing lock-step upgrades, you only secondarily note the version of the third-party
dependencies, as you check them into source control without version numbers in the filename.  I.e. JUnit goes in as
`third_party/java_testing/junit.jar`.

## Clash of ideologies

Above we contrasted **directed graph** and **recursive** build systems. The former are naturally compatible
with expandable/contractible checkout technologies. The latter not necessarily so.

### Maven

Recursive build systems like maven, have a forward declaration of modules that should be built, like so:

```xml
<modules>
  <module>moduleone</module>
  <module>moduletwo</module>
</modules>
```

Presently, though, these build technologies do not have the ability to follow
a changeable checkout that the likes of gcheckout can control.

Directories `moduleone` and `moduletwo` have to exist in order for the build to work. The idea of expandable/contractible
monorepos, is that trees of buildable things are **calculated or computed** not **explicitly declared**.
In order to deliver that, you would need a feature to be added Maven like so:

```xml
<modules>
  <calculate/> <!--or--> <search/>
</modules>
```

Or you could "hack it" and rewrite your pom.xml files after every expansion or
contraction{{< ext url="http://paulhammant.com/2017/01/27/maven-in-a-google-style-monorepo/" >}}.

## If you decide you want multiple repositories

Wherever you partition code into multiple repositories, you are declaring that you know how to synchronize
files between repositories better than Git, the master of file synchronization. You are taking responsibility
for this job that the very capable Git was willing to do for free.

Sometimes you do know more than Git, and sometimes you do not have a choice. Multiple repositories make
sense when you are building a system from open source repositories, or when projects have separate
development and deployment cadences. While there is no reason that multiple microservices could not share
a single repository, a single repository per microservice is a popular pattern in the microservices community.

[Android Repo](https://source.android.com/setup/develop/repo) is useful for managing multiple Git repositories,
but it works with Gerrit only. For trunk based development and feature branches, there is a
[fork of Android Repo that adds a `repo push` command](https://github.com/wavecomp/git-repo).

### Repository partitioning rules
If you must use multiple repositories, partition them according to these rules:
* Use separate repositories only when the dependency between them can be satisfactorily described
  in terms of a [semantic version](https://semver.org).
* All code for a given package must reside in single repository. Code in other repositories should go into their
  own separate packages. Control the dependencies between the packages using their [semantic versions](https://semver.org).

# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>

<div>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">09 Apr 2013, Blog entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://paulhammant.com/2013/04/09/scaling-trunk-based-development/">Scaling Trunk-Based Development</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">06 May 2013, Blog entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://paulhammant.com/2013/05/06/googles-scaled-trunk-based-development/">Google's Scaled Trunk-Based Development</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">06 Jan 2014, Blog entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://paulhammant.com/2014/01/06/googlers-subset-their-trunk/">Googlers Subset their Trunk</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">08 Jan 2014, Blog entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://paulhammant.com/2014/01/08/googles-vs-facebooks-trunk-based-development/">Google's vs Facebook's Trunk-Based Development</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">10 Apr 2014, Blog entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://paulhammant.com/2014/04/10/cd-the-price-of-admission/">Continuous Delivery: The price of admission..</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">10 Oct 2014, Conference Talk</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://www.perforce.com/merge/2014-sessions/trunk-based-development-enterprise-its-relevance-economics">Trunk-Based Development in the Enterprise - Its Relevance and Economics</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">18 May 2015, Blog entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://danluu.com/monorepo/">Advantages of monolithic version control</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">20 May 2015, Blog entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://paulhammant.com/2015/05/20/turning-bazel-back-into-blaze-for-monorepo-nirvana/">Turning Bazel back into Blaze for monorepo nirvana</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">27 Jan 2017, Blog entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://paulhammant.com/2017/01/27/maven-in-a-google-style-monorepo/">Maven In A Google Style Monorepo</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">6 Mar 2017, Blog entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://eng.uber.com/ios-monorepo/">Faster Together: Uber Engineering’s iOS Monorepo</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">27 Apr 2017, Blog entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://medium.com/netflix-techblog/towards-true-continuous-integration-distributed-repositories-and-dependencies-2a2e3108c051">Towards true continuous integration: distributed repositories and dependencies</a></td>
        </tr>
    </table>
</div>
