---
date: 2016-08-01T09:42:02+05:00
title: Observed habits
weight: 81
---

## No Code Freeze

Developers living in a Trunk Based Development reality, mostly do not experience variance in their days or weeks on the 
trunk. In particular, there is no "we're close to a release so let's freeze code", and generally there is no indication 
of a slowdown in proximity to a release.  Sure, a couple of developers out a team might be assigned to bug-fixing closer
to the release but everyone else is going to work at full speed. 

Generally speaking the trunk is a place to firehose commits into, and the habits of the developers are such that 
everything is ready to go live. If a team is doing 12 releases a year, then a release branch that is cut on the just in time 
basis and is the one that is observed to be 'frozen' because of the absence of developers. Refer [branch for release](/branch-for-release/).

### Every Day is the same

Ignoring meetings, developers commit/push at the same rate regardless of the day of the week or the week of the month. 
This is a reinforcement of the No Code Freeze suggestion above.

## Quick Reviews

Teams doing trunk based development, know that their commits/pushes will be scrutinized by others, as soon
as they have landed on the shared trunk. They are keen on bring that forward, not delaying it, so they may prefer to 
pair-program on code changes. Or they may ask colleagues for a code review at the time the change is submitted to be 
merged into the trunk.

## Chasing HEAD

Trunk based development teams update/pull/sync from the shared trunk often. Many times a day in fact. 

## Running the build locally

Developers practicing Trunk Based Development run the build before a commit/push in order to not break the build. 
This one practice, for very small teams, allows them to not setup a CI server until later. If they can't push their 
commits to the shared trunk because someone else beat them to it, they have to do another update/sync/pull then
another build then the push of the revised commit(s). "It worked on my machine" says the developer that does not 
want to confess to breaking the build (assuming quick reliable idempotent builds).

## Powering through broken builds

OK, so because of that lazy developer, or the flaky build, or pure accident of timing (Google has a commit every 30 
seconds into their monorepo - there must be quantum entangled commits on a 0.0001% basis), the trunk will be observed 
to be broken occasionally. There could be an automatic rollback that's about to happen, or a good old fashioned "lock 
the trunk" while the build-cop sorts it out. That last is particularly true in situations where batching of commits in 
CI builds is the reality.

A developer wanting to update/pull/sync from the shared trunk often runs the risk of encountering that 
statistically improbable broken build. They do not want to have the commits that broke the trunk, on their workstation
if they are developing. So what they do is update/pull/sync to the last known good commit, and only go further
ahead when the trunk build is officially repaired. This way they know they can stay 'green' on their workstation.

## Shared Nothing

Developers, on their developer workstations, rely on a 'microcosm' setup for the application or service 
they are developing. They can:

* bring up the application on their workstation and play with it. 
* run all unit, integration and functional tests against it locally

Shared nothing requires significant discipline to achieve. It generally means that no TCP-IP leaves the developers 
box, and being able to prove that by running those operations while disconnected from the network.  The 
implementing of the wire mocking (service virtualization) of dependent tiers outside the team, is a given. The highest 
accomplished Trunk Based Development teams employ mocking of tiers within the same application, in order to make 
tests fast and stable. Technologies such as Mountebank{{< ext url="http://www.mbtest.org" >}} make 
programming working with wire mocking easy. Tiers refers to a layer-cake view of an applications construction, of course.

With a Microcosm strategy which delivers shared nothing for a developer workstation, it is acknowledged that 
non-functional consistency with production has been thrown out of the window and that only functional correctness
is being honored.  This is only really any good for the act of development on a workstation, and the verification of 
that (per commit) by a Continuous Integration daemon.  

Your team will need many named QA environments, and many named 
UAT environments. Each of those with different rules about the frequency of deployment, and even perhaps even 
a temporarily reservation for different reasons. Those environments pull together **real** dependent services 
and integrated applications. As much as possible those environs should not have shared services. 

Companies often make a classic mistake when buying software in that they (say) buy one license for prod, and another 
for all dev, QA and UAT, meaning the DevOps team had configured it as shared for all those environments, with a 
wide-ranging negative impact on productivity and quality for innumerable and sometimes subtle psychological reasons.

## Common code ownership

Committing to the trunk many times a day requires a broad sense of ownership to code, and a willingness to allow 
developers to contribute changes to sections of an application or service that they have not previously be involved 
with. Allow does come with responsibilities and checks. The former is to standards, and the checks are by the CI server, 
and by humans who should honor to do a speedy code review. That last, for the highest performing teams, means as soon
as the proposed commit is ready.