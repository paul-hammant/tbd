---
date: 2016-05-03T19:56:50+01:00
title: Branch by Abstraction
weight: 53
---

Branch by Abstraction is a set-piece technique to effect a 'longer to complete' change in the trunk. Say a developer
(or a pair of developers), has a change that is going to take five days to complete. There could easily be pressure to
create a branch for this - somewhere that can be unstable for a period of time before it completes (and gets merged
back somewhere).

There may be some aspect of repetition to the coding activities that makes it longer to complete. No matter, the 
change was predicted as being time-consuming, complex, destabilizing/disruptive to everyone else in the development team.

**Rules:**
 
1. There are also a lot of developers already depending on 
the code that is subject of the 'longer to complete' change, and we do not want them to be slowed down in any way.
2. No commit pushed to the shared repository should jeopardize the ability to go live.

## Ideal steps

For simplicity's sake, let us say there is code that is 'to be replaced', code 'to be introduced'.

1. Introduce an abstraction around the code that is to be replaced, and commit that for all to see.  If needed, this 
can take multiple commits. None of those are allowed to break the build, and all of them could be pushed to the shared
repository in order, and as done.
2. Write a second implementation of the abstraction for the to-be-introduced code, and commit that, but maybe as 
'turned off' within the trunk so that other developers are not depending on it yet. If needed, this can take multiple 
commits as above. The abstraction from #1 may also be occasionally tweaked, but must follow the same rule - do not 
break the build.
3. Flip the software 'off' switch to 'on' for the rest of the team, and commit/push that.
4. Remove the to-be-replaced implementation
5. Remove the abstraction

Hopefully, your team uses an IDE that can perform complex refactoring on sets of checkouts, in a way that running the build 
after each is an uneventful validation of the changes.

## Contrived example

Let's talk about a car having its wheels upgraded. We should never forget that software engineering is 
nothing like conventional construction, and we want to ram that home. At least, it is nothing like conventional 
construction where we are not talking about a production line.

### Rules

1. Mechanics must be able to simultaneously work on the upholstery, engine, etc.
2. The car must be drivable after every change. 

### Steps

All steps are efficiently performed raised up on car jacks/lifts/ramps, before lowering the car to the ground again.

1. One wheel is removed, put in a container that looks pretty much like a wheel (rotates around an axis, 
can bear weight) and replaced on the car. If driven this wheel functions exactly like the 
other three wheels.
2. The wheel-like container gains a second better/desired/alternate wheel, within exactly the same 
physical space (magically). A switch is added inside the car to allow the choice of wheel to be switched conveniently 
- perhaps only before the engine is started, though.
3. The same two operations (#1 and #2) are performed on the other three wheels. Or maybe #1 is done four times, 
followed by #2 four times. The Mechanics experience will guide which is most efficient.
4. After determining that the new wheels are better, the old wheels are removed from the wheel-like containers
and are sent for recycling.
5. The wheel-like containers are also removed from the new wheels, either one by one or all four simultaneously.

At any stage, when lowered from the jacks/lift/ramps, the car could have been driven (a 'ready to go-live' metaphor).

![](cars.png)

We said 'jacks' above, because that's what mechanics use in real life. Software, however, does not follow the rules 
of gravity, or many of the costs of actual construction. With an IDE for a glove, a single finger could reposition 
the car in 3D space to allow easy replacement of the wheels.

## Software example

A documented case is ThoughtWorks' Go CI-daemon. They changed an Object-Relational mapping library (for persistence), 
while not slowing down teammates development activities (rule 1), and not jeopardizing the ability to go live (rule 2).

Going from "iBatis" to "Hibernate" for a bunch of reasons, was their plan.

They:

1. Introduced an abstraction around the classes/components using iBatis directly, and ensured that all 
classes/components indirectly referring to iBatis were changed to refer to the abstraction instead.
2. Wrote a second implementation of the abstraction, introducing Hibernate to the codebase, perhaps tweaking the 
abstraction where needed.
3. Did a tiny commit that turned on Hibernate for all teammates.
4. Removed iBatis, then the abstraction and the on/off old/new switch.

As it happens you could leave the abstraction in place, if your unit tests are able to benefit because of the 
possibility of another seam that can be mocked.

## Secondary benefits

### Cheaply pause and resume 'migrations'

The migration from old to new can be paused and resumed later casually. This is because the build guards the 
second, incomplete, implementation. It does so merely because of a compile stage that turns the abstraction and somewhere 
between 1 to 2 implementation into object code.  If there are unit tests for the two alternates, then even more so.

If on a real branch, the casual restart of the paused initiative is missing. There's possibly an exponential cost of 
restart given the elapsed time since the initiative was paused. 
 
Pause and resume is much more likely in an enterprise development organization that does not have limitless coffers. 
 
### Cancellation of a project is still cheap
 
In the case of abandonment, deleting a real long running feature branch is cheaper, but deletion of a 
branch by abstraction *thing* is only incrementally more expensive. 
 
## Not a panacea
 
Branch by Abstraction does not suit all 'change' situations. 
 
One is when you have got to support old APIs and previous releases for more than a short period of time.  I.e. when your 
dependent customers (or detached clients apps) can choose their own upgrade moment.
 
Some years ago the KDE team was mulling their release 5.0 strategy, and wanting to remain parallel to changes in 4.0, so as not to make 
mistakes that they had done 
previously{{< ext url="http://tech.slashdot.org/story/11/08/07/2128222/KDE-Frameworks-50-In-Development" >}}. TODO: circle back.

## Dedicated website for this procedure
  
In early 2018, a Branch by abstraction was created to further drill into this concept{{< ext url="https://www.branchbyabstraction.com" >}}.
 
## History
 
Teams employed Branch by Abstraction many years before it got its name (Stacy Curl named it in 2007), but it is 
unknown when the first implementation was. Before the adoption of BbA, teams **had to** make a branch for the 
big lengthy disruptive change, or do it with an incredible amount of choreography: "hey everyone, take a week of 
vacation now".
 
With the Branch by Abstraction technique, Trunk-Based Development was less likely to be temporarily or permanently 
abandoned for a multi-branch model.
 
# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>

<div>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">26 Apr 2007, Blog Entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://paulhammant.com/blog/branch_by_abstraction.html">Introducing Branch by Abstraction</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">05 May 2011, ContinuousDelivery.com article</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://continuousdelivery.com/2011/05/make-large-scale-changes-incrementally-with-branch-by-abstraction/">Make Large Scale Changes Incrementally with Branch By Abstraction</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">21 Jun 2013, Blog Entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://www.slideshare.net/cb372/branching-strategies">Branching Strategies: Feature Branches vs Branch by Abstraction</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">14 Oct 2013, Blog entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://www.alwaysagileconsulting.com/articles/application-pattern-verify-branch-by-abstraction">Application Pattern: Verify Branch By Abstraction</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">07 Jan 2014, MartinFowler.com article</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://martinfowler.com/bliki/BranchByAbstraction.html">BranchByAbstraction</a></td>
        </tr>
    </table>
</div>
