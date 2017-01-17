---
date: 2016-03-09T19:56:50+01:00
title: Branch by Abstraction
weight: 30
---

Branch by Abstraction is a set-piece technique to effect a 'longer to complete' change in the trunk. Say a developer
(or a pair of developers), has a change that is going to take five days to complete. There could easily be pressure to
create a branch for this - somewhere that can be unstable for a period of time before it completes (and get's merged
back somewhere).

There may be some aspect of repetition to the coding activities that makes it a longer to complete. No matter, the 
change was predicted as being time consuming, complex, destabilizing/disruptive to every else in the dev team.

**Rules:**
 
1. There's also a lot of developers already depending on 
the code that is subject of the 'longer to complete' change, and we don't want them to be sloweed down in any way.
2. No commit pushed to the shared repo should jeopardize the ability to go live.

## Ideal steps

For simplicity's sake, let us say there is code that is 'to be replaced', code 'to be introduced'.

1. Introduce an abstraction around the code that is to be replaced, and commit that for all to see.  If needed, this 
can take multiple commits. None of those are allowed to break the build, and all of them could be pushed to the shared
repo in order, and as done.
2. Write a second implementation of the abstraction for the to be introduced code, and commit that, but maybe as 
'turned off' within the trunk so that other developers are not depending on it yet. If needed, this can take multiple 
commits as above. The abstraction from #1 may also be occasionally tweaked, but must follow the same rule - don't 
break the build.
3. Flip the software 'off' switch to 'on' for the rest of the team, and commit/push that.
4. Remove the to be replaced implementation
5. Remove the abstraction

Hopefully your team IDE that can perform complex refactorings on sets on checkouts in a way that running the build 
after each is an uneventful validation of the refactorings.

## Contrived example

Lets talk about a car having its wheels upgraded. We should never forget that software engineering is 
nothing like conventional construction, and we want to ram that home. At least, it is nothing like conventional 
construction where we are not talking about a production line.

### Rules

1. Mechanics must be able to simultaneously work on the upholstery, engine, etc.
2. The car must be drivable after every change. 

### Steps

All steps are efficiently performed up on car jacks/lifts/ramps, before lowering the car to the groung again.

1. One wheel is removed, put in a container that looks pretty much like a wheel (rotates around an axis, 
can bear weight) and replaced on the car. If driven this wheel functions exactly like the 
other three wheels.
2. The wheel-like container gains a second better/desired/alternate wheel, within exactly the same 
physical space (magically). A switch is added inside the car to allow the choice of wheel to be switched conveniently 
- perhaps only before the engine is started though.
3. The same two operations (#1 and #2) are performed on the other three wheels. Or maybe #1 is done four times, 
followed by #2 four times. The Mechanics experience will guide which is most efficient.
4. After determining that the new wheels are better, the old wheels are removed from the wheel-like containers
and are send for recycling.
5. The wheel-like containers are also removed from the new wheels, either one by one or all four simultaneously.

At any stage, when lowered from the jacks/lift/ramps, the car could have been driven (a 'ready to go-live' metaphor).

![](/images/cars.png)

We said 'jacks' above, because that's what mechanics use in real life. Software however does not follow the rules 
gravity, or many of the costs of actual construction. With an IDE for a glove, a single finger could reposition 
the car in 3D space to allow easy replacement of the  wheels.

## Software example

A documented case, is ThoughtWorks' Go CI-daemon. They changed an Object-Relational mapping library (for persistence), 
while not slowing down team mates development activities (rule 1), and not jeopardising the ability to go live (rule 2).

Going from "iBatis" to "Hibernate" for a bunch of reasons, was their plan.

They:

1. Introduced an abstraction around the classes/components using iBatis directly, and ensured that all 
classes/components indirectly referring to iBatis were change to refer to the abstraction instead.
2. Wrote a second implementation of the abstraction, introcing Hibernate to the codebase, perhaps tweaking the 
abstraction where needed.
3. Did a tiny commit to turn on Hibernate for all team mates.
4. Removed iBatis, then the abstraction and the on/off old/new switch.

As it happens you could leave the abstraction in place, if your unit tests are able to benefit because of the 
possibility of another seam that can be mocked.

## Secondary benefits

The migration from old to new can be paused, and resumed later casually. This is because the build guards the 
second, incomplete, implementation. It does so merely because of a compile stage that turns the abstraction and somewhere 
between 1 to 2 implementation into object code.  If there are unit tests for the two alternates, then even more so.

If on a real branch, the casual restart of the paused initiative is missing. There's possibly an exponential cost of 
restart given the elapsed time since the initiative was paused. 
 
In the case of abandonment, a real branch is cheaper, but the abstraction is only incrementally more expensive to 
delete. Besides pause and resume are much more likely in an enterprise development organisation that does nt have 
limitless coffers.
 
## History
 
Teams employed Branch by Abstraction many years before it got its name (Stacy Curl named it in 2007), but it is 
unknown when the first implementation was. Before the adoption of BbA, teams had to make a branch. In Walter F. Tichy's 1985 paper 
"RCS - A System for Version Control"[![](/images/ext.png)](https://www.gnu.org/software/rcs/tichy-paper.pdf), a trunk 
focused model is described as "slender branch", and that you stepped away from it for four reasons:

<br><div style="padding-left: 45px"/><span style="font-size: 150%">&ldquo;</span>
<b>Section 3.1. When are branches needed?</b><br>
A young revision tree is slender: It consists of only one branch, called the trunk.<br>
As the tree ages, side branches may form. Branches are needed in the following 4 situations.<br>
&nbsp;&nbsp;&nbsp;&nbsp;Temporary fixes [...]<br>
&nbsp;&nbsp;&nbsp;&nbsp;Distributed development and customer modifications [...]<br>
&nbsp;&nbsp;&nbsp;&nbsp;Parallel development [...]<br>
&nbsp;&nbsp;&nbsp;&nbsp;Conflicting updates [...]<br>
</div>
 
Two of those, Tichy suggests, are temporary branches and would come back to the trunk at the earliest opportunity. 
 
With the Branch by Abstraction technique, Trunk Based Development was less likely to be abandoned for a 
multi-branch model, whether long term or temporarily.
 
# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>

Date    | Type  | Article
--------|-------|--------
26 Apr 2007 | Blog entry | [Introducing Branch by Abstraction](http://paulhammant.com/blog/branch_by_abstraction.html)
21 Jun 2013 | Blog entry | [Branching Strategies: Feature Branches vs Branch by Abstraction](http://www.slideshare.net/cb372/branching-strategies)
07 Jan 2014 | MartinFowler.com article | [BranchByAbstraction](https://martinfowler.com/bliki/BranchByAbstraction.html)
05 May 2011 | ContinuousDelivery.com article | [Make Large Scale Changes Incrementally with Branch By Abstraction](https://continuousdelivery.com/2011/05/make-large-scale-changes-incrementally-with-branch-by-abstraction/)
