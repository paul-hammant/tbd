---
date: 2016-06-02T20:10:46+01:00
title: Committing straight to the trunk	
weight: 62
---

Some teams will choose to commit/push straight to the trunk. Most likely it is because they are a small team with each
team member knowing what the others are up to. **Their build is probably fast and relatively exhaustive**, and they 
may well seldom experience a build breakage. If the build does break (post integration into trunk/main) then they most likely 'revert' the 
commit straight away, possibly locking the trunk for a short period of time while that is performed. If the team is 
really small (say three or four), in which case the team might allow someone to fix the build quickly and commit that 
in order to get the build green again.

In the 2000's many Trunk-Based Development teams might have numbered up to 100 committers. They may have been extremely 
rapid with their `reverts` (lock trunk, revert, kick off the CI daemon again, unlock trunk if green again). If there was no build-automation server, they would 
have performed check-in activities that 1997's C3 team{{< ext url="https://en.wikipedia.org/wiki/Chrysler_Comprehensive_Compensation_System" >}} 
would have recognized, because they wanted that human 
assurance that gated check-ins are all that is needed to keep the build green. Namely, developers holding an 
"I/we are checking in now, nobody else should be". They run the full build after bringing their checkout up to date 
and commit/push if green. Indeed that ceremony is a key part of the [Continuous Integration](/continuous-integration/) advances 
and is now part of Agile generally, and Extreme Programming in particular. These days teams doing this practice without AI coding
agents are likely to be much smaller (say less than 16) because of the advent of alternatives (see below). That said, there are still
some large teams working this way.

**With agentic coding:** the 100-committer teams of the 2000s and the "less than 16" of today both counted people. An enterprise team
using coding agents can, with the same headcount, be an order of magnitude more productive against its goals, and generate a commit load
that once took one of those 100-committer teams. It is that load (concurrent writers, and the peak commit rate) that this way of working
has to absorb. The 2000s teams absorbed it with fast reverts and
trunk locking. Agentic teams need more: a commit queue, a fast local build with
[Test Impact Analysis](/fast-green-builds/#test-impact-analysis), and agents that talk to each other before touching shared code. See
[AI coding agents committing straight to the trunk](#ai-coding-agents-committing-straight-to-the-trunk) below.

**Startups and scale-ups:** an AI-native startup or scale-up may run at ten times the throughput of the best established enterprise team,
so it meets that load with only a handful of people. It usually has fewer of the governance reasons enterprises have for keeping pull
requests, which makes committing straight to the trunk its natural starting point. The same safety net is needed, though, and needed
sooner: the commit queue, the fast build and the tests have to be in place before the commit rate arrives, not after the trunk has been
broken a few times.

# Benefits

It is easier to objectively verify the correctness of your commits yourself (optimally with a pair-programming partner, or these days with coding agents and an independent AI reviewer), then commit/push at moments of convenience. That is, easier than pushing into a code-review system for approval from a teammates that risks being interruptive to their workflow. Indeed there is a greater likelihood that this this style or working becomes a flow of small commits into the trunk, with each of those being an incremental step forward, and perfectly able to go-live itself while the larger story/card remains incomplete.

# Challenges

Committing (and pushing) straight to the trunk has a challenge. Principally, someone could commit/push code that breaks the build, and the server(s) setup to guard Continuous Integration don't catch that for some time after the commit is available for teammates to pull/sync to their dev-workstation for unrelated work.

Risk mitigation is **everyone** running the full build (the same build the CI demon would do) before the commit/push, and only pushing to 
trunk if that passes. **This is an essential integration activity**. This is the habit of the XP teams from the end of the 90's, and there's 
no reason any team would dispense with that in the years since. Indeed, it is valuable for ALL branching models.

If this is locked in as a team requirement, your new challenge is to keep the full build fast. Fast is say one minute, and slow is ten or above. Compile and pure unit tests (no threads, sockets, file IO) is where good builds focus their development effort. Any following "integration test" build steps that use threads, listen on sockets, or do significant file IO should be minimized as far as possible without reducing meaningful coverage. The best trick for that is changing some integration tests into pure unit tests, which isn't always easy. See [Fast, Green Builds](/fast-green-builds/) for more.

Why the fast build matters even more in this style: with small commits streaming into the trunk, most of the merging happens silently. Two changes that touch the same file in different regions reconcile automatically as "disjoint region" merges and never raise a clash for a human to resolve. That is a good thing - but it is only *textually* clean. Two changes can auto-merge with zero VCS conflict and still break each other in meaning - one renames a function in one region, another adds a caller in another, and the lines never overlapped so nothing flagged it. The merge algorithm cannot catch that class of problem; only the build can. This is the real reason **everyone** running the full build before the push (and fast CI on HEAD right after) is non-negotiable here - it is the only thing standing between a clean-looking auto-merge and a semantically broken trunk, and it works best while the change is small and fresh in the author's mind.

Some teams have revert policies for commits that land in trunk (or main) that are proven as "broken" later in CI. That could be an activity for a build-cop who's going to communicate with the dev team about locking the trunk to achieve that. Or it could be a bot activity and happen instantly, as Google do in-house (35K committers in one trunk).

Some teams have some scripting in place to ensure that developers only pull/sync commits to their dev-workstations that CI has marked as passing. That could be as simple as keeping a commit ID (number or hash depending on your VCS tool) on a website somewhere, and writing a wrapper script for git-pull (or svn up) that ignores commits that happened after that one. Pushing back, with that way of working is harder in Git and Mercurial as they require you to have pulled HEAD revisions before you can push back. Subversion and Perforce don't have that limitation.

# AI coding agents committing straight to the trunk

A developer using AI coding agents may hand several working copies over to them at once. Those could be
[worktrees](/short-lived-feature-branches/#git-worktrees) on one workstation, or one agent might drive many machines, VMs
and containers over SSH, giving one person a lot of concurrency. Agents in those working copies, near or far, may
also talk to each other about what they are doing. If the requirement for a pull request is removed, the branching
model they converge on is the one this page describes, which is how Trunk-Based Development began. What changes is
the scale, and what needs adding to cope with it.

## The branch is just the unpushed commits

Each working copy has a branch only in the sense Subversion users always had one: the difference between that working copy
and HEAD. It may be a named local branch, or a few local commits on top of `main`, but it never needs to exist in the shared
origin repo, and it lives for minutes rather than days. The loop is the XP one, run faster: sync with HEAD, make a small change,
build and test locally, sync again, push. If the push is rejected, rebase and try again. That is
[Chasing HEAD](/observed-habits/#chasing-head) and [Running the build locally](/observed-habits/#running-the-build-locally),
done by something that does not get bored.

## Trunk is the only place things meet

Agents working from many checkouts never merge into each other's working copies. They each integrate with trunk and pick up each
other's work from trunk. The "breaking the contract" rules for
[short-lived feature branches](/short-lived-feature-branches/#breaking-the-contract) still apply, just at a finer grain: nothing goes
sideways, and everything goes through HEAD. That is why a diaspora of machines is fine. Indeed, physical separation is the cleanest
way to get [shared nothing](/observed-habits/#shared-nothing), because there are no ports, databases or container names for working
copies on the same workstation to fight over.

## Contention for HEAD is the new problem

A pair of humans might push a few times an hour. Twenty agents push far more often, and Git's "pull before you push" rule
becomes a race that the slowest local build keeps losing. At that rate you end up where Google and Facebook ended up: a commit
queue (or merge queue). Agents hand their change to a robot that rebases it onto the latest HEAD, builds it (often speculatively and in
batches), then lands it or bounces it back. That robot is the only committer to trunk. This is not a pull request in the human
sense, because no human is a gate. It is a serialization point.

## Agents talking to each other is the check-in ceremony, rebuilt

The C3-era "I/we are checking in now, nobody else should be" ceremony described above, along with teams saying out loud what they
were about to touch, has an equivalent in agents chatting across checkouts: "I'm about to change this interface", "hold off, I'm halfway
through renaming that". That conversation is how clashes get avoided rather than resolved. It is also where
[Branch by Abstraction](/branch-by-abstraction/) and [feature flags](/feature-flags/) come back into their own. Anything bigger than
a single commit is built behind an abstraction or a flag, so that every push is able to go live. The intention can span days, while each
commit is complete in itself.

## Review moves, it doesn't disappear

If you accept code written by AI at the speed AI writes it, then AI has to lead the review of it, with humans as the layer above:
reviewing intent and decisions, spot-checking, arbitrating, and improving the reviewing agent and the checks (see
[AI-led review](/continuous-review/#ai-led-review)). The question is where each of those happens.

Take away the pull request and review has three places to go. Before the commit, it takes the Mondrian/Gerrit shape: one agent reviews
another's patch before it is queued, and objective CI checks gate the queue. After the commit, it is
[continuous review](/continuous-review/): humans read what landed, at their own pace, and act on it with follow-up commits or reverts
rather than approvals.

The third place is at the moment of integration, and it is not a human one. Since the earliest days of version control, two developers who
knew they were working in the same area of code have raced to commit first. The second to commit took the merge-conflict pain, and the
first had none, other than perhaps offering a "sorry" over the cube wall (this was before remote co-workers). Humans never liked being
second, and felt real discomfort doing the merge. Coding agents have had that human failing trained out of them. An agent that loses the
race treats the conflict as something to resolve casually and quickly, without anyone's eyes on a three-way merge tool. To do that well it
has to read and understand both its own change and the one that beat it to trunk, which makes resolving the conflict a review of the
place where the two changes meet. That only covers what the VCS flags as a textual clash, though. Changes that merge cleanly but break
each other in meaning (see "Challenges" above) are still caught only by the build, and the build only catches them if there are tests
(unit, component and service) exercising the code where the two changes meet. A lack of tests is the hole, and agents committing at
volume will find it faster than any human team did. The related peril is the opposite: so many tests, and so many of them slow, that the
local build is too slow to win the race to HEAD and the commit queue backs up. The answer is the same as for human teams, only more
pressing: lots of tests, kept fast, with integration tests turned into pure unit tests wherever that can be done. On top of that,
[Test Impact Analysis](/fast-green-builds/#test-impact-analysis) lets each agent run just the tests its change could affect before pushing,
leaving the full suite to CI.

Whichever of the three places review happens in, the safety net carries more weight: a build per commit, automatic bisecting, and fast
reverts. A [Build Cop](/observed-habits/#build-cop) is a natural job for an agent too.

## In summary

With the pull request requirement removed, coding agents spread over many working copies work the way a high-discipline 1999 XP team
did: local-only branches that live for minutes, integration only via trunk, talking before touching shared code, and flags or
abstractions for anything longer-running. The one modern addition is the commit queue, because no team of humans ever pushed fast
enough to need one.

# Alternatives to committing straight to the trunk

That modern alternative that allows development teams to scale up without having a bottleneck around check-ins or increased risk of broken builds: [Short-Lived Feature Branches](/short-lived-feature-branches/).

There are also teams that send patches to review systems like Gerrit and Rietveld, instead of committing/pushing straight to trunk/main. Google pioneered this with their in-house Mondrian system in 2006, and Gerrit and Rietveld were made in the image of that. Facebook's Phabricator is another that came later. As well as code review, build-automation systems objectively verify the correctness of the proposed changes, leaving you with high confidence that the following merge/integration into trunk/main will yield a similar positive result when the same infrastructure kicks in later for CI purposes. It is important to note that the automation you attach to commits/pushes to non-trunk branches (or patch queue/review systems) is not Continuous Integration itself.

These two alternatives, as well as committing straight to the trunk are compared in [Styles and Trade-offs](/styles/).

# Tooling support

[`tbdflow`](https://github.com/cladam/tbdflow) is a small CLI by Claes Adamsson that codifies a "safe path" for teams committing straight to trunk. It automates `fetch -> rebase` integration with a "WIP Guard" snapshot of the working directory before integration, runs pre-flight CI status checks and a "Conflict Radar" to catch overlapping changes or red builds before they reach the trunk, and injects architectural "breadcrumbs" (intent) into commit bodies so the *why* travels with the *what*. Cross-platform; integrates with Git and GitHub. Claes writes about the reasoning at [cladam.github.io/tags/#tbdflow](https://cladam.github.io/tags/#tbdflow).

