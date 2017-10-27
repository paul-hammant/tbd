---
date: 2016-05-03T19:56:50+01:00
title: 抽象分支
weight: 53
---

Branch by Abstraction is a set-piece technique to effect a 'longer to complete' change in the trunk. Say a developer
(or a pair of developers), has a change that is going to take five days to complete. There could easily be pressure to
create a branch for this - somewhere that can be unstable for a period of time before it completes (and gets merged
back somewhere).

抽象分支是一组影响主干中“以后完成”这类变化的一系列技术。比如有一个（或一组）开发人员，有一个修改需要5天完成。简单地创建一个分支很有压力 - 这个地方在完成之前会有一段时间不太稳定（后面再合并回来）。

There may be some aspect of repetition to the coding activities that makes it longer to complete. No matter, the 
change was predicted as being time-consuming, complex, destabilizing/disruptive to everyone else in the development team.
可能有某些重复，使得编码需要更长时间才能完成。无论如何，对开发团队里的每个人来说，修改都被预测为耗时复杂的，且具有破坏性/颠覆性。

**Rules:**
 
1. There are also a lot of developers already depending on 
the code that is subject of the 'longer to complete' change, and we do not want them to be slowed down in any way.
 有很多开发人员已经依赖于需要较长时间才能完成修改的代码，我们不希望以任何方式延缓他们的开发
2. No commit pushed to the shared repository should jeopardize the ability to go live.
不把提交push到共享的代码库会危及到go live的能力 

## Ideal steps
理想步骤  
For simplicity's sake, let us say there is code that is 'to be replaced', code 'to be introduced'.
为简单起见，假设这里有一份将要被替换的代码，一份将要被引入的代码。

1. Introduce an abstraction around the code that is to be replaced, and commit that for all to see.  If needed, this 
can take multiple commits. None of those are allowed to break the build, and all of them could be pushed to the shared
repository in order, and as done.
在将要被替换的代码附近引入抽象，然后提交它，这样所有人都可以看到。如果有需要，这可以是多个提交。这些提交都不能破坏build，然后依次被push到共享代码库，就完成了。
2. Write a second implementation of the abstraction for the to-be-introduced code, and commit that, but maybe as 
'turned off' within the trunk so that other developers are not depending on it yet. If needed, this can take multiple 
commits as above. The abstraction from #1 may also be occasionally tweaked, but must follow the same rule - do not 
break the build.
为**将要被引入**的代码写第二次实现的抽象，然后提交。但在主干上可能是关闭状态所以其他开发人员暂时不依赖于它。如果需要的话，这可能像上面那样需要多次提交。第一步的抽象也可能偶然被调整，但必须遵循同样的原则：不能破坏build。
3. Flip the software 'off' switch to 'on' for the rest of the team, and commit/push that.
为剩下的团队翻转软件的“关闭”到“打开”，然后提交/push。
4. Remove the to-be-replaced implementation
删除**将要被替换**实现
5. Remove the abstraction
删除抽象

Hopefully, your team uses an IDE that can perform complex refactorings on sets on checkouts, in a way that running the build 
after each is an uneventful validation of the refactorings.
你的团队使用IDE来做复杂的重构，在某种程度上，在每次后运行build是重构的**静态**验证。
## Contrived example
人为的例子  
Let's talk about a car having its wheels upgraded. We should never forget that software engineering is 
nothing like conventional construction, and we want to ram that home. At least, it is nothing like conventional 
construction where we are not talking about a production line.
让我们来谈谈轮子升级的一辆汽车，我们不应该忘记软件工程并不像传统的建筑，我们希望ram that home。至少，它没有像传统建筑在那我们并不会谈到生产线。

### Rules

1. Mechanics must be able to simultaneously work on the upholstery, engine, etc.  
 力学必须能够和内饰，引擎等同时工作。  
2. The car must be drivable after every change.   
 汽车必须在每次更改后可以行使。  

### Steps

All steps are efficiently performed raised up on car jacks/lifts/ramps, before lowering the car to the ground again.
在汽车再次降低到地面之前，所有的步骤都有效地在汽车千斤顶/举起/斜坡执行升高

1. One wheel is removed, put in a container that looks pretty much like a wheel (rotates around an axis, 
can bear weight) and replaced on the car. If driven this wheel functions exactly like the 
other three wheels.  
一个车轮被取出，放进一个看起来很像轮子的容器中（饶轴旋转时，可承受重量）在汽车中取代。如果车轮这个轮子的功能就像其它三个车轮一样。
2. The wheel-like container gains a second better/desired/alternate wheel, within exactly the same 
physical space (magically). A switch is added inside the car to allow the choice of wheel to be switched conveniently perhaps only before the engine is started, though.  
这个车轮状的容器 第二个更好的/所需的/备用轮，完全相同的物理空间内。添加了一个允许方便切换选择车轮的开关-虽然或许只在引擎发动之前。
3. The same two operations (#1 and #2) are performed on the other three wheels. Or maybe #1 is done four times, 
followed by #2 four times. The Mechanics experience will guide which is most efficient.   
相同的两个操作（第一步和第二步）在另外三个轮子进行。或者可能第一步做4次，第二步也做四次。力学经验将指导出哪种是最有效的。
4. After determining that the new wheels are better, the old wheels are removed from the wheel-like containers and are send for recycling.  
确定新的车轮更好后，把旧车轮从车轮状的容器中取出并送出回收。
5. The wheel-like containers are also removed from the new wheels, either one by one or all four simultaneously.
车轮状的容器也从新车轮那取出，可以一个一个取，也可以四个同时取出。

At any stage, when lowered from the jacks/lift/ramps, the car could have been driven (a 'ready to go-live' metaphor).  
在任何阶段，当从**下降时**，汽车可以一直发动（比喻ready to go-live）。

![](cars.png)

We said 'jacks' above, because that's what mechanics use in real life. Software, however, does not follow the rules 
of gravity, or many of the costs of actual construction. With an IDE for a glove, a single finger could reposition 
the car in 3D space to allow easy replacement of the wheels.   
我们上文所说的千斤顶，是因为这是力学在现实生活中的应用。但软件并不遵守动力定律，或者很多实际结构的cost。随着IDE的普及，一根手指可以重新定义三维空间的汽车，以便于更换车轮。
## Software example
## 软件的例子
A documented case is ThoughtWorks' Go CI-daemon. They changed an Object-Relational mapping library (for persistence), 
while not slowing down teammates development activities (rule 1), and not jeopardizing the ability to go live (rule 2).
一个记录的案例是ThoughtWorks的Go CI-daemon。他们改变了一个对象关系映射库（用于持久化），而不是减慢队友开发活动（规则1），而不会危及生存能力（规则2）。
Going from "iBatis" to "Hibernate" for a bunch of reasons, was their plan.
出于一系列原因，他们的计划是从“iBatis”到“Hibernate”。

They:

1. Introduced an abstraction around the classes/components using iBatis directly, and ensured that all 
classes/components indirectly referring to iBatis were changed to refer to the abstraction instead.  
直接引用了使用iBatis的类/组件的抽象化，并且确保间接引用iBatis的所有类/组件都被改为引用抽象。
2. Wrote a second implementation of the abstraction, introducing Hibernate to the codebase, perhaps tweaking the 
abstraction where needed.  
写了第二个抽象的实现，将Hibernate引入到代码库中，也许在需要的时候调整抽象。
3. Did a tiny commit that turned on Hibernate for all teammates.   
小步提交，为所有队友打开了Hibernate。  
4. Removed iBatis, then the abstraction and the on/off old/new switch.  
删除iBatis，然后是抽象和开/关、旧/新开关。

As it happens you could leave the abstraction in place, if your unit tests are able to benefit because of the 
possibility of another seam that can be mocked.   
发生这种情况，您可以离开抽象，如果您的单元测试能够受益，因为可能会mock另一个接缝。

## Secondary benefits
第二个好处
### Cheaply pause and resume 'migrations'
方便地暂停和恢复“迁移”  
The migration from old to new can be paused and resumed later casually. This is because the build guards the 
second, incomplete, implementation. It does so merely because of a compile stage that turns the abstraction and somewhere 
between 1 to 2 implementation into object code.  If there are unit tests for the two alternates, then even more so.

从旧到新的迁移可以暂停，随后重新开始。这是因为构建守卫了第二个不完整的实现。它只是因为一个编译阶段，将抽象和1到2之间的实现转换为对象代码。如果有两个候补的单元测试，那么更是如此。

If on a real branch, the casual restart of the paused initiative is missing. There's possibly an exponential cost of 
restart given the elapsed time since the initiative was paused. 

如果在一个真正的分支，没有随意重启的暂停启动。自从暂停启动计划以来经过的时间，可能会出现指数的重新启动成本。
 
Pause and resume is much more likely in an enterprise development organization that does not have limitless coffers. 

在没有无限的库房的企业开发组织中，暂停和恢复更有可能。
 
### Cancellation of a project is still cheap
项目的取消依然方便
In the case of abandonment, deleting a real long running feature branch is cheaper, but deletion of a 
branch by abstraction *thing* is only incrementally more expensive. 
在放弃的情况下，删除一个真正的长时间运行的功能分支是更方便的，但是通过抽象* thing *删除分支只是递增地更昂贵。
 
## Not a panacea
并非万能
 
Branch by Abstraction does not suit all 'change' situations.  
抽象分支不适用于所有的“变化”情况。 
 
One is when you have got to support old APIs and previous releases for more than a short period of time.  I.e. when your 
dependent customers (or detached clients apps) can choose their own upgrade moment.

一个是当你必须支持旧的API和以前的版本超过很短的时间。即当您的依赖客户（或分离的客户端应用程序）可以选择自己的升级时刻。
 
Some years ago the KDE team was mulling their release 5.0 strategy, and wanting to remain parallel to changes in 4.0, so as not to make 
mistakes that they had done 
previously{{< ext url="http://tech.slashdot.org/story/11/08/07/2128222/KDE-Frameworks-50-In-Development" >}}. TODO: circle back.  
几年前，KDE团队正在研究5.0版本的战略，并希望与4.0的变化保持平行，以免造成他们以前犯过的错误
 
## History
 
Teams employed Branch by Abstraction many years before it got its name (Stacy Curl named it in 2007), but it is 
unknown when the first implementation was. Before the adoption of BbA, teams **had to** make a branch for the 
big lengthy disruptive change, or do it with an incredible amount of choreography: "hey everyone, take a week of 
vacation now".

团队在抽签之前多年采用分支机构（Stacy Curl在2007年命名），但第一个实施是未知的。在采用BbA之前，团队**必须为长时间的破坏性变化做出分支，或者用不可思议的编排来做：“嘿，每个人都要花一周的假期”。
 
With the Branch by Abstraction technique, Trunk-Based Development was less likely to be temporarily or permanently 
abandoned for a multi-branch model.  
采用抽象分支技术，基于主干的开发不太可能因为多分支模型被暂时或永久地弃用。
 
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
