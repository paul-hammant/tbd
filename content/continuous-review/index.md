---
date: 2016-06-05T20:10:46+01:00
title: Continuous Code Review 
weight: 65
---

## The high bar today

Continuous Code Review is where the team commits to processing proposed commits (to trunk) from team-mates trunk speedily. 

The idea is that a system (the code portal probably) allows developers to package up commits for code review and get 
that in front of peers quickly. And that peer developers make a commitment to do code reviews objectively and quickly. 

There is a cost to multi-tasking, so maybe someone in the dev team who is between work items at that moment should focus 
on the review before they start new work. With a continuous review ethos, it is critical that code reviews are not 
allowed to back up.

Companies doing Extreme Programming, often allow that pair of eyes to count as a review. Some companies require 
multiple reviews of code. For "the pair as reviewers too" scenario, one might have ben enough and that commit will 
land in the trunk, without others looking at it. Five minutes and 20 seconds into Guido van Rossum's famous 2006 presenation, 
he states "code review is a best alternative to pair programming", and that it is "basically asynchronous pair-programming".

### Pull Requests

The pull-request (PR) model introduced by GitHub is the dominant code review model today. It is a branch, but a personal
one and short-lived. It may suffer many commits before the developer feels the task is complete and initiates a PR 
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

See [Game Changers - Google's Mondrian](/game-changers/index.html#google-s-internal-devops-1998-onwards) and 
[Game Changers - GitHub's Pull Requests](/game-changers/index.html#github-s-entire-platform-2008-onwards) for the industry impact of continuous code 
review.

# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>

<div>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">13 Nov 2014, Blog Article</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://paulhammant.com/2014/11/13/code-review-the-unit-of-work-should-be-a-single-commit/">Code Review - the unit of work should be a single commit</a></td>
        </tr>
    </table>
</div>