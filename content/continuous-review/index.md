---
date: 2016-06-05T20:10:46+01:00
title: Continuous Code Review 
weight: 65
---

## The high bar today

Continuous Code Review is where the team commits to processing team-mates proposed commits to trunk speedily. 
The idea is that a system (the code portal probably) allows developers to package up commits for code review and get 
that in front of peers quickly. That peer developers make a commitment to do code reviews objectively and quickly. 
There is a cost to multi-tasking, so maybe someone in the dev team who is between work items at that moment should focus 
on the review before they start new work. With a continuous review ethos, it is critical that code reviews are not 
allowed to back up.

### Pull Requests

The pull-request (PR) model introduced by Github is the dominant code review model today. It is a branch, but a personal
one and short-lived. It may suffer many commits before the developer feels the task is complete, and initiates a PR 
which triggers code review (and the CI daemon to wake up and build/verify the branch). The temporary branch may have
received many commits before the developer initiated the pull request. Some developers will squash (rebase) the
changes into a single commit before starting code review. Some teams have a policy in favor of or against squash/rebase. 

{{< note title="Common Code Owners" >}}
Commits being reviewed are never rejected for "Only I am allowed to change source in this package" reasons. Rejections
must be for objective reasons.
{{< /note >}}

## Enterprise code review - as it was

In enterprises, if code review was done at all prior to 2008, it was done in a batch, and probably a group activity. 
It was often abhorred as it gave a lead developer/architect a moment to set an agenda, round on a large portion of the 
attendees and make sure that their own code flubs were not discussed at all.

Historically, open source teams never had the luxury of procrastinating about code review. They either did code reviews as they went 
(perhaps days were the review cadence, not hours or minutes), or they didn't bother at all.

## See also

See [Game Changes - Google's Mondrian](/game-changers/index.html#mondrian-2006) and 
[Game Changes - Github's Pull Requests](/game-changers/index.html#pull-requests-2008) for the industry impact of continuous code 
review.

# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>

Date    | Type  | Article
--------|-------|--------
13 Nov 2014 | Blog Article | [Code Review - the unit of work should be a single commit](http://paulhammant.com/2014/11/13/code-review-the-unit-of-work-should-be-a-single-commit/)