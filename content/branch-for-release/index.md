---
date: 2016-05-05T19:56:50+01:00
title: 為發布建立分支
weight: 55
---

<!--
{{< quote title="Branch: only when necessary, on incompatible policy, late, and instead of freeze" >}}
<span>&mdash; Laura Wingerd & Christopher Seiwald</span><br>
<span style="margin-left: 30px">(1998's High-Level SCM Best Practices white paper from Perforce)</span>
{{< /quote >}}
-->

{{< quote title="分支：只在必要時使用，提交政策不相容時使用，盡可能延遲建立，以及用來取代凍結版本。" >}}
<span>&mdash; Laura Wingerd & Christopher Seiwald</span><br>
<span style="margin-left: 30px">(1998 年《Perforce 版本控制系統的高階軟體配置管理最佳實踐白皮書》)</span>
{{< /quote >}}

<!--
If a team is pushing production releases monthly, then they are also going to have to push bug-fix releases
between planned releases. To facilitate that, it is common for Trunk-Based Development Teams to make a release
branch on a just in time basis - say a few days before the release. That becomes a stable place, given the developers
are still streaming their commits into the trunk at full speed.
-->

如果一個團隊每月進行一次產品發布，他們通常也會在計劃的發布週期內推出錯誤修復版本。為了便於這一過程，基於主幹的開發團隊通常會在發布前幾天根據實際需要建立一個發布分支。這個分支將成為一個穩定的地方，因為開發者仍以全速向主幹提交他們的程式碼。

<!--
The incompatible policy (ref Wingerd & Seiwald above), that the release branch "should not receive continued development work".

![](branch_for_release.png)
([key](/key/))
-->

根據 Wingerd 與 Seiwald 所述，當提交政策不相容時建立分支，即發布分支「不應該繼續接收開發工作」。

<img srcset="branch_for_release.png 1x,branch_for_release@2x.png 2x">([分支圖示的說明](/key/))

<!--
^ Trunk, two and a half release branches, five releases (two planned, three unplanned), and two cherry-pick bug fixes
-->

^ 主幹、兩個完整的發布分支、一個部分完整的發布分支、五次發布（兩次計劃的，三次非計劃的），以及兩次使用 cherry-pick 進行的錯誤修復。

<!--
{{< note title="CD teams do not do release branches" >}}
High throughput, [Continuous Delivery](/continuous-delivery/) teams can ignore this - if they had a lemon in production, they choose a
roll-forward strategy for solving it, meaning the fix for a bug is in the trunk, and the release to production is from the trunk.
{{< /note >}}
-->

{{< note title="持續交付團隊不採用發布分支" >}}
高產出的[持續交付](/continuous-delivery/)團隊可以忽略以下的內容。如果在正式環境中遇到問題，會選擇向前滾動的策略來解決，這意味著錯誤的修復是在主幹中完成的，並且正式環境的發布也直接從主幹進行。
{{< /note >}}

<!--
## Who is committing where?

Developers are committing (green dots) at the highest throughput rate to the trunk, and do not slow up or freeze around a
branch-cut or with proximity to a release. Developers as a group are **not** committing to the release branch (see below).

![](branch_for_release2.png)
([key](/key/))
-->

## 誰在哪裡提交？

開發者們以最高的效率（綠點表示）向主幹提交程式碼，並且在接近建立分支或發布時不會減慢速度或凍結版本。作為一個團體，開發者們**不會**向發布分支提交（見下圖）。

![](branch_for_release2.png)
([分支圖示的說明](/key/))

<!--
The branch cut itself is a commit. Subversion and Perforce would technically have a bigger commit here, but all
VCS systems in use today would count the commit as 'lightweight' in terms of its impact on the history/storage,
and the time taken to create.
-->

建立分支本身就是一次提交。從技術上講，譬如 Subversion 和 Perforce 版本控制系統，在這裡會有一個較大的提交，然而當今使用的版本控制系統都會將這次提交視為「輕量級」，因為它對歷史記錄或儲存的影響很小，且建立所需的時間也很短。

<!--
That red dot is an accidental build break that was fixed (somehow) soon after.
-->

那個紅點是一個意外的建置中斷，不久後（以某種方式）被修復了。

<!--
## Late creation of release branches

Some teams [release from a tag on the trunk](/release-from-trunk/) and do not create a branch at that time. That in
itself is **an alternate practice to this one, "branch for release"**.
-->

## 推遲建立發布分支

有些團隊選擇[從主幹的一個標籤發布](/release-from-trunk/)，而不在發布時建立分支。這本身就是**一種與「為發布建立分支」不同的做法**。

<!--
Those teams wait for a bug that needs fixing for a released, before creating a branch from the release tag (if they are
not going to just issue another release from the trunk).  
-->

這些團隊會等到一個已發布版本出現需要修復的錯誤時，才從該發布標籤建立分支（除非他們不打算直接從主幹發布另一個版本）。

<!--
Brad Appleton points out that many do not realize that branches can be created **retroactively**. That is taken advantage
of here in the case of bugs after "release from a tag", or even changes for point releases.
-->

Brad Appleton 指出，許多人未意識到分支可以**事後**建立。這在「從標籤發布」後遇到的錯誤處理，或者即使是為小版本更新所做的修改中，這種做法都被充分利用了。

<!--
## Fix production bugs on Trunk
-->

## 在主幹上修復正式環境錯誤

<!--
The best practice for Trunk-Based Development teams is to reproduce the bug on the trunk, fix it there with a test,
watch that be verified by the CI server, then cherry-pick that to the release branch and wait for a CI server
focusing on the release branch to verify it there too. Yes, the CI pipeline that guards the trunk is going to
be duplicated to guard active release branches too.
-->

對主幹開發的團隊來說，最佳作法是在主幹上重現錯誤，隨後配合測試進行修復，並確保持續整合常駐程式可以驗證這一項修復。接著，將修復內容透過 cherry-pick 至發布分支，並等待專注於發布分支的持續整合服務同樣確認無誤。是的，用於保護主幹的持續整合流水線，在活動的發布分支上也需要做相同的設置以保護它。

<!--
{{< warning title="A cherry-pick is not a regular merge" >}}
A cherry-pick merge takes a specific commit (or commits) and merges that to the destination branch. It skips
one or more commits that happened before it, but after the branch was cut. All VCS tools track which commits
 have been merged and which ones not, so you can do more cherry picks later.
{{< /warning >}}
-->

{{< warning title="Cherry-pick 不是一般的合併" >}}
Cherry-pick 會從來源分支中挑選特定的提交（或多個提交），並將其合併到目標分支。它會跳過在此之前，但在建立分支之後發生的一個或多個提交。所有版本控制系統工具都會追蹤哪些提交已經合併，哪些尚未合併，因此你可以之後進行更多的 cherry-pick。
{{< /warning >}}

<!--
### Cherry-picks from the trunk to branch ONLY
-->

### Cherry-pick **僅應**從主幹到分支進行。

<!--
You should not fix bugs on the release branch in the expectation of cherry-picking them back to the trunk.
Why? Well in case you forget to do that in the heat of the moment. Forgetting means a regression in production some
weeks later (and someone getting fired). It can happen if things are being fixed in the night by a tired developer who
wants to get back to bed.

![](branch_for_release3.png)
([key](/key/))
-->

你不應該在發布分支上修復錯誤，並期望將它們透過 cherry-pick 操作回到主幹。為什麼呢？因為在緊張的工作情況下，你可能會忘記這麼做。忘記這一步將導致幾週後在正式環境重新出現錯誤，並可能導致某人被解雇。如果事情在夜深人靜時由一位疲憊的開發者修復，他們想要趕快回床上休息，這種情況就可能發生。

<img srcset="branch_for_release3.png 1x,branch_for_release3@2x.png 2x">([分支圖示的說明](/key/))

<!--
This rule for Trunk Based Development remains difficult to accept, even within teams practicing everything else about
Trunk-Based Development. It takes just one regression though for a policy change to be made for the team.
-->

即使在各方面都在實踐主幹開發的團隊中，這條規則對於團隊來說仍然很難接受。然而，只需一次回退錯誤，就足以促使團隊改變政策。

<!--
Of course, sometimes you **absolutely cannot** reproduce the bug on trunk. In that case you have to do it the other way round, despite
everything mentioned above, but understand you have introduced risk of regression.
-->

當然，有時候你**無法**在主幹上重現錯誤。在這種情況下，儘管上述所有提及的，你不得不採取相反的做法，但請理解你已經引入了回退的風險。

<!--
### Google's Rachel Potvin on Cherry picks
-->

### Google 的工程師 Rachel Potvin 談論 Cherry-picks

<!--
In a talk at the @Scale conference in Sept 2015, "Why Google Stores Billions of Lines of Code in a Single Repository",
there was a slide that depicts cherry-picks in a branch diagram:
-->

在 2015 年 9 月舉行的 @Scale 研討會中，Google 的工程師 Rachel Potvin 在一場名為「為什麼 Google 將數十億行程式碼儲存在單一程式碼版本庫中」的演講中，於投影片中展示了一張分支圖，其中描述了 cherry-pick 操作的方法：

![](atscale.png)

<!--
The presenter, Rachel Potvin, said (14 mins in):
-->

演講者 Rachel Potvin 在演講中（14分鐘處）說道：

<!--
"So at Google we do what's called Trunk-Based Development. I should note that it is the combination of Trunk-Based Development with a centralized repository that really defines the monolithic model of source code management. So
what Trunk-Based Development means for us that typically Piper users all work from HEAD or a single copy of the most recent version of the codebase. When developers commit to Piper their changes are immediately visible and usable by other engineers. Branching for development at Google is exceedingly rare and Trunk-Based Development is beneficial partly because you avoid the painful merges that often occur when you need to reconcile long lived branches.  Branches however are used for releases. **So a release branch is typically a snapshot from trunk with an 
optional number of cherry picks that are developed on trunk and then pulled into the branch**."
-->

「在 Google，我們實行的是主幹開發。我應該指出，正是主幹開發與集中式程式碼版本庫的結合，真正定義了原始碼管理的整體模式。對我們來說，主幹開發意味著 Piper（Google 內部使用的程式碼版本工具）使用者直接從 HEAD 進行開發，或者從最新版本的基準程式碼中建立單一的工作副本。當開發者向 Piper 提交時，他們的更改立即讓其他工程師可見且可用。在 Google 為了開發而建立分支是極為罕見的，而主幹開發之所以有益，部分原因是可以避免經常發生合併長期分支時的痛苦。**然而，分支通常用於發布。因此，發布分支通常從主幹的一個快照建立，並可選擇性地將在主幹上開發的若干提交透過 cherry-pick 操作拉入分支中。**」

<!--
We've bolded the cherry-pick bit ourselves.  Readers with beady eyes will note that Rachel alludes to 
dev branches other than trunk for 'rare' reasons. We may cheekily suggest that Google should learn a little more about [Branch by Abstraction](/branch-by-abstraction/).
-->

我們加粗了 cherry-pick 的部分。細心的讀者會注意到 Rachel 提到除了主幹以外的分支是「罕見」的。我們可以俏皮地建議 Google 應該了解更多[抽象分支](/branch-by-abstraction/)。

<!--
### Merge Meister role
-->

### 「合併專家」角色

<!--
The process of merging commits from trunk to the release branch using 'cherry pick' is a role for a single developer
in a team. Or dev pair, if you are doing Extreme Programming. Even then, it is a part time activity. The dev or pair
probably needs to police a list of rules before doing the cherry pick. Rules like which business representative
signed off on the merge. Perhaps the role should also rotate each day.
-->

在團隊中，由單一開發者或兩位開發者（如果實行極限開發）負責使用「cherry-pick」將提交從主幹挑選到發布分支。即使如此，這仍是一項兼職活動。在進行 cherry-pick 前，開發者可能需要檢查一系列規則。例如，哪位業務代表批准了合併。也許這個角色應該每天輪換一次。

<!--
Some teams update a wiki to audit what made it to the release branch after branch cut, and some use ticket system as
this by its nature interrupting and requiring of an audit trail of approvals.
-->

有些團隊更新維基以審核哪些內容在建立分支後進入了發布分支，而有些團隊則使用需求追蹤系統，因為這種做法本質上需要中斷並要求有一個審批的審計軌跡。

<!--
## Patch releases
-->

## 修補程式版本

<!--
It could be that your team has pushed a release out from a release branch, and now has a bug to remediate in
production. If the release cadence suits it, a cherry-pick of a bug fix from the trunk to the release branch
and a point release from the same branch is fine.
-->

可能你的團隊已經從一個發布分支推出了一個版本，現在需要在正式環境中修復一個錯誤。如果發布節奏適合，那麼在主幹上修復的錯誤將透過 cherry-pick 到發布分支，然後從發布分支釋出修復錯誤的小版本號，是很好的作法。

<!--
### Tag instead of branch
-->

### 使用標籤而非分支

<!--
Releasing from a tag on the trunk is a decent optimization for many teams, if possible. The tag could be numbered for
the release (say v1.1.1), and the branch can be avoided completely. Perhaps if there is a bug in production and a branch
is retroactively created from that tag, and the patch release (see above) can happen from there.
-->

如果可能的話，對許多團隊而言，從主幹上透過標籤發布是一種不錯的最佳化方式。標籤可以為發布編號（例如 v1.1.1），從而完全避免使用分支。如果正式環境中出現錯誤，可以從該標籤追溯性地建立一個分支，並且發布修補程式版本（見上文）。

<!--
## Release branch deletion
-->

## 發布分支的刪除

<!--
Release branches are deleted some time after release activity from them ceases. Not immediately, but when it is clear release is no longer in production. Release branches are NOT merged back into trunk.
That is usually when releases from succeeding release branches have gone live. This is a
harmless tidying activity - branches can be undeleted again easily enough in all VCS choices. In git, a tag needs to be created from the released commit before deleting the release branch, since dangling commits will be garbage collected.
-->

發布分支在其發布活動結束後的一段時間內會被刪除。不會立即刪除，直到確定該版本不會在正式環境中運行時，便會進行刪除。發布分支**不會**被合併回主幹。通常是在後續的發布分支已經上線時才進行刪除。在所有的版本控制系統中，這是一項無害的整理活動，分支都可以輕鬆地再次恢復。在 git 中，在刪除發布分支之前，需要從已發布的提交建立一個標籤，因為懸空的提交將會被垃圾回收。

<!--
# References elsewhere
-->

# 其他參考資料

<a id="showHideRefs" href="javascript:toggleRefs();">顯示其他參考資料</a>

<div>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">1998, White Paper</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://www.perforce.com/sites/default/files/pdf/perforce-best-practices.pdf">High-level Best Practices in Software Configuration Management</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">2018, Edward Thompson on MSDN</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://blogs.msdn.microsoft.com/devops/2018/04/19/release-flow-how-we-do-branching-on-the-vsts-team/">Release Flow: How We Do Branching on the VSTS Team</a></td>
        </tr>
    </table>
</div>
