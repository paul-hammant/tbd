---
date: 2017-01-05T09:42:02+05:00
title: Observed Habits
weight: 10
---

## No Code Freeze

Developers living in a Trunk Based Development reality, mostly don't experience variance in their days or weeks on the 
trunk. In particular there's no "we're close to a release so let's freeze code", and generally there's no indication 
of a slow down in proximity to a release.  Sure, a couple of devs out a team might be assigned to bug-fixing closer
to the release but everyone else is going to work at full speed.

### Every Day is the same

Ignoring meetings, Developers commit/push at the same rate regardless of the day of the week or the week of the month. 

## Quick Reviews

Teams doing trunk based development, know that they their commits/pushes are up for the scrutiny by others, as soon
as they've landed on the shared trunk. They're keen bring that forward, not delay it, so they may prefer to 
pair-program on changes, or ask colleages for a code review at the time the change is submitted to be merged into
the trunk.

## Chasing HEAD

Trunk based development teams update/pull/sync from the shared trunk often. Many times a day in fact. 

## Running the build locally

Developers practicing Trunk Based Development run the build before a commit/push in order to not break the build. 
This one prctice, for very small teams, allows them to not setup a CI daemon until later. If they can't push their 
commits to the shared trunk because someone else beat them to it, they have to do another update/sync/pull then
another build then the push of the revised commit(s). "Ir worked on my machine" says the developers that doesn't 
want to confess to breaking the build (assuming quick reliable idempotent builds).

## Powering through broken builds

OK, so because of that lazy developer, or the flaky build, or pure accident of timing (Google has a commit every 30 
seconds into their monorepo - there must be quantum entangled commits on a 0.0001% basis), the trunk will be observed 
to be broken occassionally. There could be an automatic rollback that's about to happen, or a good old fashioned "lock 
the trunk" while the build-cop sorts it out. That last is particulatly true in situations where batching of commits in 
CI builds is the reality.

So the developer wanting to update/pull/sync from the shared trunk often, runs the risk of encountering that 
statisticly improbable broken build. They don't want to have the commits that broke the trunk, on theor workstation
if they are developing. So what they do is update/pull/sync to the last known good commit, and only go further
ahead when the trunk build is officially repaired.  This way they know they can stay 'green' on their workstation.