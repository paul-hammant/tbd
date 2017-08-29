---
date: 2016-08-01T09:42:02+05:00
title: Observed habits
weight: 81
---

## No Code Freeze

Developers living in a Trunk-Based Development reality, mostly do not experience variance in their days or weeks on the 
trunk. In particular, there is no "we're close to a release so let's freeze code", and generally there is no indication 
of a slowdown in proximity to a release.  Sure, a couple of developers out a team might be assigned to bug-fixing closer
to the release but everyone else is going to work at full speed. 

Generally speaking, the trunk is a place to firehose commits into, and the habits of the developers are such that 
everything is ready to go live. If a team is doing 12 releases a year, then a release branch that is cut on the just in time 
basis and is the one that is observed to be 'frozen' because of the absence of developers. Refer [branch for release](/branch-for-release/).

### Every Day is the same

Ignoring meetings, developers commit/push at the same rate and to the same place regardless of the day of the week or 
the week of the month. This is a reinforcement of the "No Code Freeze" rule above. Sure a small subset of the team
may focus on an imminent release (bug fixes in the trunk, cherry-picked to the release branch), but the majority
should be focusing on 'business as usual' implementation of functionality for a future release.

## Quick Reviews

Teams doing Trunk-Based Development, know that their commits/pushes will be scrutinized by others, as soon
as they have landed on the shared trunk. They are keen on bringing that forward, not delaying it, so they may prefer to 
pair-program on code changes. Or they may ask colleagues for a code review at the time the change is submitted to be 
merged into the trunk.

## Chasing HEAD

Trunk-Based Development teams update/pull/sync from the shared trunk often. Many times a day in fact. 

## Running the build locally

Developers practicing Trunk-Based Development run the build before a commit/push in order to not break the build. 
This one practice, for very small teams, allows them to not set up a CI server until later. If they cannot push their 
commits to the shared trunk because someone else beat them to it, they have to do another update/sync/pull then
another build then the push of the revised commit(s). "It worked on my machine" says the developer that does not 
want to confess to breaking the build (assuming quick reliable idempotent builds).

## Facilitating commits

Because everyone in a team is chasing HEAD of the trunk, there could be moment where one change is imagined that
could inconvenience everyone else in some way. Say a big directory rename as part of an extensive rework of the 
source with it. It could be that the developer performing those two, does the rename first and pushes it through to 
the trunk where everyone will get it on the next pull/sync/update. It might be that if separated somehow, the rename
on its own is easier to consume by teammates, with the second being a relatively smaller commit later.

Git and Mercurial track files through their content rather than by directory and file name, so they make light of the 
situation described above, anyway.

## Powering through broken builds

So because of that lazy developer, or the flaky build, or pure accident of timing (Google has a commit every 30 
seconds into their monorepo - there must be quantum entangled commits on a 0.0001% basis), the trunk will be observed 
to be broken occasionally. 

The best implementations are going to perform automatic rollback of a broken commit that lands in the trunk. The 
developer gets notified and they get to fix it quietly on their workstation.

A developer wanting to update/pull/sync from the shared trunk often runs the risk of encountering that 
statistically improbable broken build. They do not want to have the commits that broke the trunk, on their workstation
if they are developing. So what they do is update/pull/sync to the last known good commit, and only go further
ahead when the trunk build is officially repaired. This way they know they can stay 'green' on their workstation. Some 
companies have engineer a system where the last known good commit hash/number is stored in a network share, and a
shell script used for update/pull/sync does so to that instead of HEAD revision.

### Build Cop

If the Continuous Integration server is batching commits to trunk in each build, or the elapsed time for a build is 
long then the a "build cop" role might be required within the team to help sort out build breakages. Sadly that 
means that locking the trunk to prevent further checkins on top of the broken one, might be necessary as some form
of bisecting is performed to work out which commit broke the build and should be rolled back. Obviously a Continuous
Integration server setup that can run one build per commit, is best.

## Shared Nothing

Developers, on their developer workstations, rely on a 'microcosm' setup for the application or service 
they are developing. They can:

* bring up the application on their workstation and play with it. 
* run all unit, integration and functional tests against it locally

Shared nothing requires significant discipline to achieve. It generally means that no TCP-IP leaves the developers 
box, and being able to prove that by running those operations while disconnected from the network.  The 
implementing of the wire mocking (service virtualization) of dependent tiers outside the team, is a given. The highest 
accomplished Trunk-Based Development teams employ mocking of tiers within the same application, in order to make 
tests fast and stable. Technologies such as Mountebank{{< ext url="http://www.mbtest.org" >}} make 
programming working with wire mocking easy. Tiers refer to a layer-cake view of an applications construction, of course.

With a Microcosm strategy which delivers shared nothing for a developer workstation, it is acknowledged that 
non-functional consistency with production has been thrown out of the window and that only functional correctness
is being honored.  This is only really any good for the act of development on a workstation, and the verification of 
that (per commit) by a Continuous Integration daemon.  

Your team will need many named QA environments, and many named 
UAT environments. Each of those with different rules about the frequency of deployment, and even perhaps even 
a temporarily reservation for different reasons. Those environments pull together **real** dependent services 
and integrated applications. As much as possible those environs should not have shared services. 

Companies often make a classic mistake when buying software in that they (say) buy one license for prod, and another 
for all dev, QA, and UAT, meaning the DevOps team had configured it as shared for all those environments, with a 
wide-ranging negative impact on productivity and quality for innumerable and sometimes subtle psychological reasons.

## Common code ownership

Committing to the trunk many times a day requires a broad sense of ownership to code, and a willingness to allow 
developers to contribute changes to sections of an application or service that they have not previously be involved 
with. Allow does come with responsibilities and checks. The former is to standards, and the checks are by the CI server, 
and by humans who should honor to do a speedy code review. That last, for the highest performing teams, means as soon
as the proposed commit is ready.

## Always Release Ready

Not only do developers practicing Trunk-Based Development not break the build with any commit, they also sign up to
being able to go live at short notice. For example, one hour, if the CIO visits and says it is going to happen. That
means there is a bunch of automated tests that come with the build.

## Thin vertical slices

Where possible stories or tasks that have been pulled from the backlog should be achievable by a developer or pair of
developers in a short period of time, and in a small number of commits. They should also transcend all the apparent 
tiers of the stack, and not have to jump between developers with specialized knowledge in order to be able to 
completed. The Agile industry donates the INVEST{{< ext url="https://en.wikipedia.org/wiki/INVEST_(mnemonic)" >}} principle 
as well as "Thin Vertical Slices"{{< ext url="http://www.scruminc.com/wp-content/uploads/2015/06/User-Stories-2.0.pdf" >}} 
for this purpose, and that are great enablers of high throughput commits to the trunk, and always being release ready.
