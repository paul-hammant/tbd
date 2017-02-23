---
date: 2016-07-05T20:10:46+01:00
title: Concurrent development of consecutive releases
weight: 75
---

Your company wants a stream of major functionality to arrive in the application you are pushing live at a regular 
cadence. Because you are good Extreme Programmers, you know that consecutive development of consecutive releases
is best. However, the effort and length of time needed to complete each of the major pieces of functionality is
large enough to require different project teams cooperating towards that plan. Some of those teams will be within
the same codebase. Some may dependent building services that the application will call. Not everything is equal effort
it seems, yet the business wants a specific rollout, including dates and can plan that even 18 months ahead. They are
so specific because there is an impact on the user community (staff, clients, customers or members of the public).

What you've got is the perfect setup for disaster born from the random bigger pieces bad news that can happen in 
software development. 

One thing was underestimated by 50% and that is determined later rather than sooner. 
Should all of the following releases slip too, assuming the company did not attempt to throw bodies at it in an attempt 
to solve it?

One compelling answer is to change the order of releases. To the business, that could be a relief even if it requires
re-planning and problems around marketing/education given the impacted staff, clients, customers or members of the 
public.

The trouble is that the development teams might have to face a selective unmerge or commenting-out frenzy to support that, depending on
what had merged already. Different branching models have different merge impacts and are either early or late in terms
of keenness for the act of merging. That in itself is disruptive to the business, as they fear and probably witness 
additional delays because of the retooling and new found nerves.

If your team has institutionalized Trunk-Based Development, [Feature Flags](/feature-flags/) and (to a lesser degree) 
[Branch by Abstraction](/branch-by-abstraction/), it is in a perfect position to reorder releases, and only have a small
impact on development team throughput. Choosing Trunk-Based Development, Feature Flags and branch by Abstraction could be said
to be a **hedging strategy** against the costs of larger scheduling changes.

{{< warning title="Consecutive development of consecutive releases is by far superior!" >}}
Every high throughput Extreme Programming team will tell you that finishing and shipping a release before starting work
as a team on the next releasable slice of work is much better than attempting to do concurrent development of 
consecutive releases.  Sure, some teammates (PM, BA, tech leads) are looking a couple of weeks ahead to make sure that
eveything is ready for development and QA automation on a just in time basis, but the majority of the dev team will 
only pick up new release work as the previous one has been pushed into production.
{{< /warning >}} 


# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>

<div>
    <table>
        <tr>
            <td>Date:</td>
            <td valign="top">19 Mar 2013</td>
        </tr>
        <tr>
            <td>Type:</td>
            <td valign="top">Blog Entry</td>
        </tr>
        <tr>
            <td>Link:</td>
            <td valign="top"><a href="http://paulhammant.com/2013/03/19/cost-of-unmerge/">The Cost of Unmerge</a></td>
        </tr>
    </table>
    <br/>
    <table>
        <tr>
            <td>Date:</td>
            <td valign="top">14 Jul 2013</td>
        </tr>
        <tr>
            <td>Type:</td>
            <td valign="top">Blog Entry</td>
        </tr>
        <tr>
            <td>Link:</td>
            <td valign="top"><a href="http://paulhammant.com/2013/07/14/legacy-application-strangulation-case-studies/">Legacy Application Strangulation : Case Studies</a></td>
        </tr>
    </table>
    <br/>
    <table>
        <tr>
            <td>Date:</td>
            <td valign="top">10 Oct 2014</td>
        </tr>
        <tr>
            <td>Type:</td>
            <td valign="top">Conference Talk</td>
        </tr>
        <tr>
            <td>Link:</td>
            <td valign="top"><a href="https://www.perforce.com/merge/2014-sessions/trunk-based-development-enterprise-its-relevance-economics">Trunk-Based Development in the Enterprise - Its Relevance and Economics</a></td>
        </tr>
    </table>
</div>



