---
date: 2016-07-08T20:08:11+01:00
title: Estragulação de aplicação
weight: 78
---

Strangulation is a mechanism by which a very large disruptive change is made in an application or service that, does not
disrupt its ability to go live, even while partially complete.  Martin Fowler named this practice (see references below)
after the strangler vines that creep up existing trees, in order to steal sunlight at canopy level of a jungle.

The trick is to have a mechanism to route invocations of logic between the old and new solutions for the same. Say 
you are an Airline, and you had written your first online purchasing experience in Perl. You're now wanting to 
do 'Elixir' and its web framework 'Phoenix'.  

Strangulation is where you would use the Apache server that you doubtless had 
fronting Perl, to **conditionally** route HTTP requests to Erlang/Elixir/Phoenix. Say your first completed milestone
was 'Loyalty Account View/Edit' you would route based on the URLs the browser was seeking pages for. Obviously 
agreeing on URLs (and cookies) is key for the old Perl and new Elixr app. So is deployment in lockstep.

At some point in the strangulation, you might put Elixir in front Apache/Perl and have traffic drop through to it 
instead. That is the residual situation before you delete the last lines of code of Perl and snip that delegation
when the strangulation is complete.

This relates a little to [Branch by Abstraction](/branch-by-abstraction/). Strangulation is a strategy for 
incompatible languages (they are not in the same process), whereas Branch by Abstraction is where the 'from' and 'to' 
languages are the same (say Java -> Java), or compatible (Java -> Scala).

# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>

<div>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">29 Jun 2004, MartinFowler.com article</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://www.martinfowler.com/bliki/StranglerApplication.html">Application Strangulation</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">17 Jan 2006, Blog Entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://scottmark.wordpress.com/2006/01/17/great-architects-are-also-stranglers/">Great Architects Are Also Stranglers</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">14 Jul 2013, Blog Entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://paulhammant.com/2013/07/14/legacy-application-strangulation-case-studies/">Legacy Application Strangulation: Case Studies</a></td>
        </tr>
    </table>
</div>
