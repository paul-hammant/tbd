---
date: 2016-03-09T20:08:11+01:00
title: Strangler Applications
weight: 40
---

Strangulation is a mechanism by which a very large disruptive change is made in an application or service that, does not
disrupt its ability to go live, even while partially complete.  Martin Fowler named this practice (see refrences below)
after the strangler vines that creep up existing trees, in order to steal sunlight at canopy level of a jungle.

The trick is to have a mechanism to route invocations of logic between the old and new solutions for the same. Say 
you're and Airline, and you'd written your first online purchasing experience in Perl. You're now wanting to 
do 'Elixr' and its web framework 'Phoenix'.  

Strangulation is where you'd use the Apache server that your doubtless had 
fronting Perl, to **conditionally** route HTTP requests to Erlang/Elixr/Phoenix. Say your first completed milestone
was 'Loyalty Account View/Edit' you would route based on the URLs the browser was seeking pages for. Obviously 
agreeing on URLs (and cookies) is key for the old Perl and new Elixr app. So is deployment in lockstep.

At some point in the strangulation, you might put Elixr in front Apache/Perl and have traffic drop through to it 
instead. That is the residual situation before you delete the last lines of code of Perl and snip that delegation
when the strangulation is complete.

This relates a little to [Branch by Abstraction](branch-by-abstraction/). Strangulation is a strategy for 
incompatible languages (they are not in the same process), whereas Branch by Abstaction is where the 'from' and 'to' 
languages are the same (say Java -> Java), or compatible (Java -> Scala).

Date    | Type  | Article
--------|-------|--------
29 Jun 2004 | MartinFowler.com artcile | [Application Strangulation](https://www.martinfowler.com/bliki/StranglerApplication.html)
17 Jan 2006 | Blog Entry | [Great Architects Are Also Stranglers](https://scottmark.wordpress.com/2006/01/17/great-architects-are-also-stranglers/)
14 Jul 2013 | Conference Talk | [Legacy Application Strangulation : Case Studies](http://paulhammant.com/2013/07/14/legacy-application-strangulation-case-studies/)

