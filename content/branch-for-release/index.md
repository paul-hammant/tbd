---
date: 2016-05-05T19:56:50+01:00
title: 发布分支
weight: 55
---

{{< quote title="分支: 仅在必要时使用，用于隔离不兼容的开发，或是需要延迟发布的功能，而不需要冻结代码（ on incompatible policy, late, and instead of freeze）" >}}
<span>&mdash; Laura Wingerd & Christopher Seiwald</span><br>
<span style="margin-left: 30px">(1998's High-Level SCM Best Practices white paper from Perforce)</span>
{{< /quote >}}

如果一个团队的产品按月发布，那么他们必然还要在计划发布的间隙进行 bug-fix 的发布。为了适应这个需求，通常实施主干分支开发的团队会在发布前几天拉出一个发布分支，以保留线上环境的代码，同时不影响其他开发继续往主干分支上提交代码。

If a team is pushing production releases monthly, then they are also going to have to push bug-fix releases
between planned releases. To facilitate that, it is common for Trunk-Based Development Teams to make a release
branch on a just in time basis - say a few days before the release. That becomes a stable place, given the developers
are still streaming their commits into the trunk at full speed.

隔离不兼容代码（参见上文 Wingerd & Seiwald 引述），发布分支不应当继续承载新功能开发。

The incompatible policy (ref Wingerd & Seiwald above), that the release branch "should not receive continued development work".

![](branch_for_release.png)
([key](/key/))

^ 主干，两个半发布分支分支，五次发布（两次计划发布，三次非计划的发布），以及两次 cherry-pick 的 bug-fix。

^ Trunk, two and a half release branches, five releases (two planned, three unplanned), and two cherry-pick bug fixes



{{< note title="持续交付团队不需要发布分支" >}}

高效的[持续交付团队](/continuous-delivery/)可以忽略这部分内容 —— 如果他们在生产环境发现了 bug，他们可以以持续发布的方式修复它，这意味着 bug-fix 的提交也在主干分支，所以的发布也在主干分支进行。

High throughput, [Continuous Delivery](/continuous-delivery/) teams can ignore this - if they had a lemon in production, they choose a
roll-forward strategy for solving it, meaning the fix for a bug is in the trunk, and the release to production is from the trunk.
{{< /note >}}

## 谁提交到了哪？

## Who is committing where?

开发人员向主干分支高频次提交代码（绿色圆点）且不会收到发布的影响，一旦有发布分支存在，开发人员将**不会**在发布分支提交（如下图所示）。

Developers are committing (green dots) at the highest throughput rate to the trunk, and do not slow up or freeze around a
branch-cut or with proximity to a release. Developers as a group are **not** commiting to the release branch (see below).

![](branch_for_release2.png)
([key](/key/))

分支的切分本身就是一个提交，Subversion 和 Perforce 由于技术原因会在这里产生一个稍大一些的提交，但是我们今天所用的所有代码版本管理工具就它对历史存储和创建时间而言，都倾向于认为这是一次轻量级的提交。

图中红色圆点表示一次坏提交，在构建被破坏后立即被后面的提交修复了。

The branch cut itself is a commit. Subversion and Perforce would technically have a bigger commit here, but all
VCS systems in use today would count the commit as 'lightweight' in terms of its impact on the history/storage,
and the time taken to create.

That red dot is an accidental build break that was fixed (somehow) soon after.

## 推迟创建发布分支

## Late creation of release branches

一些团队在主干分支上打上标签，并[从主干分支发布](/release-from-trunk/)而不需要创建发布分支，对他们而言**发布分支是一个可选方案**。

Some teams [release from a tag on the trunk](/release-from-trunk/) and do not create a branch at that time. That in
itself is **an alternate practice to this one, "branch for release"**.

这样的团队只在需要 fix bug，且不能在主干分支上做 bug fix 的时候才创建发布分支。

Those teams wait for a bug that needs fixing for a released, before creating a branch from the release tag (if they are
not going to just issue another release from the trunk).  

Brad Appleton 指出很多团队没有意识到可以从历史提交中创建分支，沿用这样的策略我们可以由“从分支（branch）发布”变为更轻量级的“从标签（tag）发布”，甚至“从提交（commit）发布”

Brad Appleton points out that many do not realize that branches can be created **retroactively**. That is taken advantage
of here in the case of bugs after "release from a tag", or even changes for point releases.

## 在主干分支做线上 bug fix

## Fix production bugs on Trunk

按照主干开发的最佳实践应该是在主干分支上重现 bug，并在主干分支修复和测试，通过持续集成再 cherry-pick 到发布分支，等待发布分支的持续集成再一步验证，在进入生产环境。是的，持续集成流水线需要在发布分支也复制一份。

The best practice for Trunk-Based Development teams is to reproduce the bug on the trunk, fix it there with a test,
watch that be verified by the CI server, then cherry-pick that to the release branch and wait for a CI server
focusing on the release branch to verify it there too. Yes, the CI pipeline that guards the trunk is going to
be duplicated to guard active release branches too.

{{< warning title="Cherry-pick 不是完全合并" >}}

Cherry-pick 可以选择性地将提交合并到目标分支而剔除掉那些我们不需要的提交，完成一次 cheery pick 后，VCS 工具会记录那些提交被合并那些没有，而你则可以继续做更多 cherry pick。 

A cherry-pick merge takes a specific commit (or commits) and merges that to the destination branch. It skips
one or more commits that happened before it, but after the branch was cut. All VCS tools track which commits
 have been merged and which ones not, so you can do more cherry picks later.
{{< /warning >}}

### 仅从主干 cherry pick 提交到其他分支

### Cherry-picks from the trunk to branch ONLY

所有bug fix 的应该先提交到主干分支再被 cherry pick 到发布分支，以此预防线上 bug fix 过后忘记将 bug fix 的提交合并回主干分支。试想深夜你终于将一个 bug fix 发布到了线上环境而赶着回去睡觉，很可能第二天来上班就忘记了这个在发布分支上的提价，而这个被“暂时 fix 住的 bug”要等到下次发布时才会被发现。

You should not fix bugs on the release branch in the expectation of cherry-picking them back to the trunk.
Why? Well in case you forget to do that in the heat of the moment. Forgetting means a regression in production some
weeks later (and someone getting fired). It can happen if things are being fixed in the night by a tired developer who
wants to get back to bed.

![](branch_for_release3.png)
([key](/key/))

这条规则可能实施起来会比较困难，几乎在所有实践主干开发的团队中都是如此，尽管需要团队做出改变，但你只需要一次回归即可。

This rule for Trunk Based Development remains difficult to accept, even within teams practicing everything else about
Trunk-Based Development. It takes just one regression though for a policy change to be made for the team.

当然，有时候你并不能在主干分支重现 bug，这种情况你可以不一定按照以上的说法去做，但你需要明白这个时候你已经引入了回归风险。

Of course, sometimes you **absolutely cannot** reproduce the bug on trunk. In that case you have to do it the other way round, despite
everything mentioned above, but understand you have introduced risk of regression.

### Google 工程师 Rachel Potvin 介绍 Cherry picks

### Google's Rachel Potvin on Cherry picks

在 2015年9月，@Scale conference 发表了一个主题为“为啥么谷歌把数十亿代码都放到一个仓库中” 的演讲，这是一页描绘 cherry-pick 的 keynote:

In a talk at the @Scale conference in Sept 2015, "Why Google Stores Billions of Lines of Code in a Single Repository",
there was a slide that depicts cherry-picks in a branch diagram:

![](atscale.png)

在这次演讲中，Rachel Potvin 说到（14分钟处）：

The presenter, Rachel Potvin, said (14 mins in):

“在谷歌，我们做了所谓的主干开发。值得一提的是，这是主干开发与集中存储仓库的集合，他真正定义了源代码管理的单一模型。主干开发对我们而言是Piper（谷歌内部使用代码版本工具）用户通常可以从代码头部进行开发，也可以是最新版本的代码库的单一副本。 当开发向Piper提交代码时，他们的提交会立即可见并被其他工程师使用。在 Google 分支开发非常罕见，主干开发是有益的，部分原因是你避免了合并长期存在的分支时的痛苦。 然而分支可以用于发行。 因此，发布分支通常是来自主干分支的快照，再在主干分支选择性地 cherry pick 到发布分支进行发布。

"So at Google we do what's called Trunk-Based Development. I should note that it is the combination of Trunk-Based Development with a centralized repository that really defines the monolithic model of source code management. So
what Trunk-Based Development means for us that typically Piper users all work from HEAD or a single copy of the most recent version of the codebase. When developers commit to Piper their changes are immediately visible and usable by other engineers. Branching for development at Google is exceedingly rare and Trunk-Based Development is beneficial partly because you avoid the painful merges that often occur when you need to reconcile long lived branches.  Branches however are used for releases. **So a release branch is typically a snapshot from trunk with an 
optional number of cherry picks that are developed on trunk and then pulled into the branch**."

我们大胆地选择了 cherry pick，细心的读者可能会注意到 Rachel 用了”罕见“这个词形容了主干分支以外的分支，我们可以大胆地建议谷歌应该多了解一下[抽象分支](/branch-by-abstraction/)。

We've bolded the cherry-pick bit ourselves.  Readers with beady eyes will note that Rachel alludes to 
dev branches other than trunk for 'rare' reasons. We may cheekily suggest that Google should learn a little more about [Branch by Abstraction](/branch-by-abstraction/).

### Merge Meister role

The process of merging commits from trunk to the release branch using 'cherry pick' is a role for a single developer
in a team. Or dev pair, if you are doing Extreme Programming. Even then, it is a part time activity. The dev or pair
probably needs to police a list of rules before doing the cherry pick. Rules like which business representative
signed off on the merge. Perhaps the role should also rotate each day.

Some teams update a wiki to audit what made it to the release branch after branch cut, and some use ticket system as
this by its nature interrupting and requiring of an audit trail of approvals.

## Patch releases

It could be that your team has pushed a release out from a release branch, and now has a bug to remediate in
production. If the release cadence suits it, a cherry-pick of a bug fix from the trunk to the release branch
and a point release from the same branch is fine.

### Tag instead of branch

Releasing from a tag on the trunk is a decent optimization for many teams, if possible. The tag could be numbered for
the release (say v1.1.1), and the branch can be avoided completely. Perhaps if there is a bug in production and a branch
is retroactively created from that tag, and the patch release (see above) can happen from there.

## Release branch deletion

Release branches are deleted some time after release activity from them ceases. Not immediately, but when it is clear release is no longer in production.
That is usually when releases from succeeding release branches have gone live. This is a
harmless tidying activity - branches can be undeleted again easily enough in all VCS choices.

# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>

<div>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">1998, White Paper</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://www.perforce.com/sites/default/files/pdf/perforce-best-practices.pdf">High-level Best Practices in Software Configuration Management</a></td>
        </tr>
    </table>
</div>
