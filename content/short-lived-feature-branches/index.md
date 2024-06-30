---
date: 2016-06-03T20:10:46+01:00
title: 短期功能分支
weight: 63
---

<!-- sdfsdfsd -->

<!--
This branching model was facilitated with the advent of very lightweight branching that came with Git and Mercurial
in the mid-2000's, though there is evidence that Google were effectively doing the same in their Monorepo for some years before.
-->

這種分支模型得益於 Git 和 Mercurial 在 2000 年代中期帶來的非常輕量級的分支功能，儘管有證據表明 Google 實際上在數年前就已經在他們的單一版本庫中採用了相同的做法。

<!--
Either as branching directly off main, or in a fork of the whole repository. These branches are destined to come
back as "pull requests" into the main/trunk.
-->

無論是直接從主幹建立分支出來，還是在整個程式碼版本庫的分叉中，這些分支最終都會以「拉取請求」的方式回到主幹中。

<!-- wrweresd -->

<!-- 
With the Pull Request (and code review) advance, the cut-off point for team sizes that graduated from "direct to the trunk" to short lived feature branches moved lower.
While it was up to 100 before Git's lightweight branching, it is now up to 15 people. With 16 or more, the team is more
productive with short-lived feature branches, and corresponding CI daemons verifying those in advance of
commits landing in the trunk. 
-->

隨著拉取請求（和程式碼審查）的進步，從「直接提交到主幹」轉移到短期功能分支的團隊規模的上限值降低了。在 Git 輕量級分支之前，這個切換點可以高達 100 人，但現在最多可以是 15 人。對於 16 人或更多的團隊，採用短期功能分支以及相應的持續整合常駐程式提前驗證這些分支，在效率上更為高效，並且當提交進入主幹時也更為可靠。

<!-- 
One key rule is the length of life of the branch before it gets merged and deleted. Simply put, the branch
should only last a couple of days. Any longer than two
days, and there is a risk of the branch becoming a long-lived feature branch (the antithesis of trunk-based development).
-->

有一個關鍵規則是分支在合併和刪除之前，它存在的時間長度。簡單來說，分支應該只存在幾天。如果超過兩天，就存在變成長期功能分支（與基於主幹的開發相反）的風險。

<!-- sdwerfhfsdfsd -->

<!-- 
Another key rule is how many developers are allowed congregate on a short-lived feature branch. Another simple answer:
the developer count should stay at one (or two if pair-programming). These short-lived feature branches are not shared
within a team for general development activity. They may be shared for the purposes of code review, but that is entirely
different to writing production code and tests.

<!-- hrhykj -->

![](/5-min-overview/trunk_pr.png)
-->

另一個關鍵規則是允許多少開發者聚集在一個短期功能分支上。另一個簡單的答案是：開發者數量應該保持在一個（或者如果進行配對開發，則為兩個）。這些短期功能分支不用於團隊內的一般開發活動。它們可以用於程式碼審查，但這完全不同於編寫生產程式碼和測試。

<p><img srcset="/5-min-overview/trunk_pr.png 1x,/5-min-overview/trunk_pr@2x.png 2x"></p>

<!--
Sometimes the community calls these 'task' or 'topic' branches, instead of long-lived feature branch.
-->

有時社群稱這些分支為「任務」或「主題」分支，而不是長期功能分支。

<!--
## Merge directionality
-->

## 合併方向性

<!--
Short-lived feature branches are real branches and merge is a first class concept. In the run-up to completing work
on the short-lived feature branch, you will need to bring it up to date with main (trunk). That is an effective
merge whichever way you do it. Look at the branch at this moment, it may appear to be much younger than it was
before that operation. The changes have to now go back to main (trunk) in another merge operation. In GitHub, for
'pull requests' (or equivalent in other platforms), the user interface may handle that last merged back for you, and even
go as far as to delete the short-lived feature branch.
-->

短期功能分支是真正的分支，合併是第一類概念。在完成短期功能分支上的工作之前，你需要將其與主幹同步。無論你如何執行這個操作，這都是一個有效的合併。觀察此時的分支，它可能看起來比之前的還要新。現在，這些變更必須透過另一個合併操作返回到主幹。在 GitHub 中，對於「拉取請求」（或其他平台中的等效操作），使用者介面可能會為你處理最後的合併操作，甚至可能會刪除短期功能分支。

<!-- rteghfhj -->

<!--
To recap: merges to the short-lived feature branch are allowed to bring it closer to HEAD of main (trunk). Merges
to main (trunk) are allowed only as part of closing out the short-lived feature branch (and just before deleting it).
-->

簡而言之：允許合併到短期功能分支，以使其接近主幹的 HEAD。只有在結束短期功能分支（並在刪除之前）時，才允許將合併提交到主幹。

<!-- rteyyrt -->

<!-- 
## Two developers concurrently doing short-lived feature branches
-->

## 兩個開發者同時進行短期功能分支的開發

<!--
Say two features are being worked on concurrently: features X and Y. Both will take a day to complete, and two developers are
working independently on them. Or four developers if pair-programming is that team's way.  The reality of the merge back to
main/trunk, before the deletion of the short-lived feature branch, is that a merge of changes **from** main/trunk
is often needed, before the merge **to** main/trunk.

![](slfb_pull-push.png)
-->

假設同時進行兩個功能的開發：功能 X 和功能 Y。兩者都需要一天的時間完成，並且有兩個開發者獨立地進行工作。如果是該團隊的慣例是配對開發，則會有四個開發者。在將短期功能分支合併回主幹或主要分支之前，通常需要先從主幹或主要分支合併到變更，然後才是將變更合併回主幹或主要分支。

<p><img srcset="slfb_pull-push.png 1x,slfb_pull-push@2x.png 2x"></p>

<!--
Workflows include:

* Attempt to merge to main/trunk and if that's blocked do a merge/pull from main/trunk before attempting the push again.
* Do a speculative main/pull from main/trunk before attempting any push to main/trunk.
-->

工作流程包括：

* 嘗試合併到主幹或主要分支。如果被阻止，則在再次嘗試推送之前，從主幹或主要分支進行合併或拉取。
* 在嘗試將任何變更推送到主幹或主要分支之前，從主幹或主要分支進行推測性合併或拉取。

<!-- dwewrerg -->

<!--
The latter leaves no trace if there's nothing to merge in from the other branch.
-->

如果從其他分支中沒有要合併的內容，那麼後者將不會留下任何痕跡。

<!--
### Workstations included
-->
### 包括工作的機器

<!--
Really though Developers work on their own workstations. That is both for their "working copy" as well as their local Git clones complete with branches:

![](slfb_working-copy.png)
-->

實際上，開發者在自己的個人電腦上進行工作。這既包括他們的「工作目錄」，也包括帶有分支的本地 Git 複本。

<p><img srcset="slfb_working-copy.png 1x,slfb_working-copy@2x.png 2x"></p>

<!-- fhtytrerwe -->

<!--
The white dots are just general development work (save files from the IDE), and the green dot is the same but validated by a local  build that passes and a maybe a local commit.
-->

白點表示一般開發工作（從整合開發環境保存文件），綠點則表示通過本地建置驗證並可能進行了本地提交。

<!--
While each developer works, they maintain a local clone of the main/trunk and their own short-lived feature branch only.
Indeed for a period of time, their short-lived feature branch may not yet exist in the shared origin repo.
-->

每個開發者在工作期間，都會維護本地 clone 上的主幹或主要分支，以及他們自己的短期功能分支。事實上，在一段時間內，他們的短期功能分支可能尚未存在於共享的程式碼版本庫中。

<!-- qetgrth -->

<!--
## Personal preferences
-->

## 個人偏好

<!--
At some point, the short-lived feature branch has to be brought right up to date with main (trunk) in a merge
operation before the result being merged back to trunk (and the branch deleted). There are a number of approaches
for this, and while teams may have a policy, some teams leave it to personal preference for the developer. 
-->

在某個時候，短期功能分支必須通過合併操作與主幹同步，然後將結果合併回主幹（並刪除該分支）。有多種方法可以實現這一點，有些團隊有相應的策略，而有些團隊則則將其交由開發者的個人喜好來決定。

<!--
### Git stash
-->

### 暫存提交 (Git stash)

<!-- 
Some people do `git stash` before `git pull` before `git stash pop`. There's a chance that when you `pop` your
working copy may be in a merge clash situation that has to be resolved before you progress. This way will always
result in your change being a single commit, at the HEAD of the branch (as Subversion would always do).
-->

有些人在執行 git pull 之前會先執行 git stash，然後再執行 git stash pop 。這樣做的原因是，當你執行 pop 時，你的工作目錄可能處於合併衝突的情況，而這需要你在下一步之前解決它。這種方法會導致你的更改成為一個單獨的提交，並位於分支的 HEAD（就像 Subversion 做的那樣）。

<!-- werregg -->

<!--
### Git rebase
-->

### 重定提交基底

<!--
Some people do `git rebase`. Refer to a well written Atlassian document on this {{< ext url="https://www.atlassian.com/git/tutorials/merging-vs-rebasing" >}} as well as one from ThoughtBot {{< ext url="https://robots.thoughtbot.com/git-interactive-rebase-squash-amend-rewriting-history" >}} that talks about `squash` too.  Even with this model,
you may encounter a merge clash, and have to resolve that locally before you can push the result anywhere, or do
further merges (to `main` hopefully).
-->

有些人使用 `git rebase`。可以參考 Atlassian 的文章 Merging vs. Rebasing {{< ext url="https://www.atlassian.com/git/tutorials/merging-vs-rebasing" >}} 和 ThoughtBot 的文章 Git Interactive Rebase, Squash, Amend, Rewriting History {{< ext url="https://robots.thoughtbot.com/git-interactive-rebase-squash-amend-rewriting-history" >}} ，這兩篇文章都討論了 squash 的相關內容。

即便使用這種模型，你仍然會遇到合併衝突。在推送結果之前，必須在本地解決衝突，或者執行進一步合併（希望是到 main 分支）。

<!-- wqwedsfsg -->

<!--
## Pitfalls
-->

## 問題和陷阱

<!--
Working towards a pull request can sometimes make you look past the power of streaming a series of small commits into trunk for 
the benefit of all. High-throughput XP teams from the end of the 90's onward would stream tens of commits a day (per pair) 
into the trunk. Each commit would be an incremental step forward and able to go live as is, were the team to change plans
to do so.  A mistake in thinking for this way of working, is one pull-request for one Agile story/card (and no more). Getting 
out of that mind trap would be to practice (say) a pull-request for refactoring and see that integrated/merged into the trunk,
then a pull-request for a piece of new functionality (and integrated into trunk), then perhaps another refactoring (trunk 
integrated again). And for those three pull-requests they shared the same Story/card association, but perhaps had different 
short-lived branch names - each of which was deleted after merge/integration.
-->

專注於拉取請求有時會讓你忽略用一系列小的提交流進入主幹的優勢，而這個優勢可以使所有人受益。從 90 年代末開始，高產量的 XP 團隊每天（每對開發者）會將數十個提交進入主幹。如果團隊改變計劃的話，每個提交都是一個遞增的前進步驟，並且能夠按原樣上線。這種工作方式的一個錯誤思維是，每個敏捷故事或卡片只對應一個拉取請求（僅此而已）。要擺脫這種思維陷阱，可以練習（例如）為重構進行一個拉取請求，並將其整合或合併到主幹中，接著再為一個新功能進行一個拉取請求（並將其整合到主幹中），然後再進行另一個重構（再次整合到主幹中）。對於這三個拉取請求，它們共享相同的故事或卡片關聯，但可能有不同的短期分支名稱——每個分支在合併或整合後都會被刪除。

<!--
## Breaking the contract

![](slfb_bad_sharing.png)
-->

## 違反約束

<p><img srcset="slfb_bad_sharing.png 1x,slfb_bad_sharing@2x.png 2x"></p>

<!--
If you merged the part-complete short-lived feature branches to anywhere else, then you have broken the
contract of trunk-based development. For short-lived feature branches, these are **not** allowed:
-->

如果你將部分完成的短期功能分支合併到其他地方，那麼你已經違反了主幹開發的約束。對於短期功能分支，不允許這些操作：

<!-- dgytjffdd -->

<!--
1. intermediate merges to main (trunk) - at least where the commit was not able to go live on its own 
2. merges (intermediate or not) to other people's short-lived feature branches
3. merges (intermediate or not) to any release branches (if you have them)
4. variations of #2 that are direct from/to the developers clone on their workstation
5. other developers joining you on your short-lived feature branches - at least who are not your pair-programming partner.
-->

1. 執行到一半時，合併到主幹（或主要分支），至少在提交無法獨立投入生產環境時是不允許的。
2. （無論任何方式）合併到其他人的短暫功能分支是不允許的。
3. （無論任何方式）合併到任何發布分支（如果有的話）是不允許的。
4. 直接從或往開發者個人電腦上的複本進行合併是不允許的。
5. 除非是你的配對開發夥伴，其他開發者加入你的短期功能分支是不允許的。

<!--
# Alternatives to short-lived feature branches
-->

# 短期功能分支的替代方案

<!-- qweqwgtht -->

<!--
There is a more traditional alternative for smaller teams:
[Committing straight to the trunk](/committing-straight-to-the-trunk/). Many people still prefer this way of working, and if the whole team can do it without blowing up the build server, then great job team.
-->

對於小型團隊來說，還有一個更傳統的替代方案：[直接提交到主幹](/committing-straight-to-the-trunk/) 。許多人仍然喜歡這種工作方式，如果整個團隊都能夠在不損壞建置伺服器的情況下進行，那麼代表團隊做得很好。

<!--
There is also the patch-review way of working that was outlined in Google's use of Mondrian (2006), and consequentially delivered for non-Google teams with open source tools Gerrit and Rietveld (2007/8). 
-->

還有一種是對提交修改審查的工作方式，這是在 Google 的 Mondrian（2006年）中概述的，隨後使用開源工具 Gerrit 和 Rietveld (2007-2008 年) 為非 Google 團隊提供了這種方式。

<!--
These two alternatives, as well as short-lived feature branches are compared in [Styles and Trade-offs](/styles/). 
-->

這兩種替代方案以及短期功能分支在 [風格和折衷](/styles) 中進行了比較。

<!--
# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>
-->

# 其他參考資料 {#references-elsewhere}

<a id="showHideRefs" href="javascript:toggleRefs();">顯示參考資料</a>

<div>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">26 Apr, 2007, Blog Entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://paulhammant.com/blog/branch_by_abstraction.html">Introducing Branch By Abstraction</a></td>
        </tr>
    </table>
</div>  
