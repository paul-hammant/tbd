---
date: 2016-03-09T20:10:46+01:00
title: Continuous Code Review 
weight: 42
---

Continuous Code Review is where the the team commits to processing team-mates proposed commits to trunk speedily. 
The idea is that a system (the code portal probably) allows developers to package up commits for code review and get 
that in front of peers quickly. The peer commitment is that the code review is objective and fair.  

{{< note title="Common Code Owners" >}}
Commits being reviewed are never rejected for "Only I am allowed to change source in this package" reasons. Rejections
must be for objective reasons.
{{< /note >}}

## Pivotal moments

### Mondrian (2006)

Tools for code-reviewers/approvers of proposed contributions to trunk were developed internally in Google in the early 
2000's. Things would not land in the trunk, until everyone agreed. Their culuture was that such that reviews to the 
point of rejection or acceptance ("Looks Good To Me" : LGTM) were speedy.  

In 2006, Guido van Rossum presented one of his bigger contributions
to Google - Mondrian. Here he is a Youtube tech talk he gave on it 
[![](/images/ext.png)](https://www.youtube.com/watch?v=CKjRt48rZGk). Note at the start he says Pair-programming is 
best, and that code review helps fill the gap for situations where you cannot do it.

Mondrian marshaled changes in a pre-commit state, but only to the trunk. Other developers could quickly bring the 
marshalled change down to their workstation to play with it, or use it as a basis for counter proposal (and put that 
back in review)

### Github's pull requests (2008)

Github launched "Pull-Requests" in 2008 [![](/images/ext.png)](https://github.com/blog/3-oh-yeah-there-s-pull-requests-now)
and popularized the entire practice for the industry. For source/repo platforms, and VCSs generally, this was a total game
changer, and commercial prospects of other companies were decided based on ability to react.

The open-source community for one, could step away from patch-sets donated by email.

## Code Review as it used to be

In enterprises, if code review was done at all it was done in a batch, and probably a group activity. It was often 
abhorred as it gave a lead developer/architect a moment to set an agenda round on a large portion of the attendees
and and make sure that theor own code flubs were not discussed.



