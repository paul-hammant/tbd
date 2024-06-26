---
date: 2016-09-01T20:08:11+01:00
title: 你這樣做是錯的
weight: 91
---

<!--
## Merely naming a branch trunk.

Say you are using Subversion, and you accepted its default directory design, when you made a new repository. That will
give you 'trunk', 'tags' and 'branches' as directory names. The mere fact that you have a branch called trunk does not
mean you are doing Trunk-Based Development. "We merge branches back to trunk often" can be heard a lot in the industry,
and if you are grouping multiple developers on those branches or they are not deleted after a couple of days, then it is
not the Trunk-Based Development branching model.
-->

## 只是命名一個分支主幹

假設你正在使用 Subversion，並且在建立新程式碼版本庫時接受了其預設目錄設計。這將為你提供「trunk」、「tags」和「branches」作為目錄名稱。你有一個名為 trunk 的分支這一事實並不意味著你正在進行基於主幹的開發。「我們經常將分支合併回主幹」在業界經常聽到，如果你在這些分支上分組了多個開發者，或者他們在幾天後沒有被刪除，那麼這不是基於主幹的開發分支模型。

<!--
## Cherry-pick of bug fixes from release branches to the trunk

All your developers are using a trunk and they are doing the right thing with respect to not breaking the build. Your release
cadence is infrequent enough to allow you to cut a release branch on a just in time basis and then harden that in the run
up to the actual release.

But, if you are fixing bugs on the release branch and merging them down to the trunk you are doing
it wrong. There is a chance you might forget to merge it down, and then there is going to be a regression at the next
release moment (fresh branch cut from the trunk). Then egg on face, and recriminations.

Bugs should be reproduced and fixed on the trunk, and then **cherry-picked** to the release branch. A build should
happen from that, a second confirmation that the issue has been remediated, and that deployment should go live (perhaps
a point release).  If you can not reproduce bugs on the trunk (truly rare), then you have permission to go ahead and
reproduce it on the release branch, fix it there, and merge back.
-->

## 從發布分支到主幹的錯誤修復的 Cherry-pick

你所有的開發者都在使用主幹，並且他們正在做正確的事情而不破壞建置。你的發布節奏不夠頻繁，因此允許你在基礎上即時剪出一個發布分支，然後在實際發布前強化它。

但是，如果你正在修復發布分支上的錯誤並將它們合併到你正在做的主幹上，那麼你就做錯了。你可能會忘記將其合併，然後在下一個發布時刻會出現回歸（從主幹上切下新分支）。結果尷尬丟臉，互相指責。

Bug 應該在主幹上重現並修復，然後 **cherry-pick** 到發布分支。應該基於此進行建置，並再次確認問題已被解決，然後部署應上線（也許是個發布點）。如果你無法在主幹上重現錯誤（確實罕見），那麼你有權繼續並在發布分支上重現它，修復它，然後合併回來。

<!--
## Merging rather than cherry-pick to/from a release branch

The developers cut a release branch because their release cadence is low, and they're hardening and certifying the release
there. BUT in the days that lead up to the release, they are also doing general merges up to the release branch from
the trunk. That is not right - it seems like they cut the branch on the wrong day. Maybe the business people on the team
are pushing too hard to make a date.

Cherry-picking every commit since the branch-cut to the branch from the trunk is the same thing of course.
-->

## 合併，而不是從發布分支中 Cherry-pick

開發者因釋出節奏緩慢而切出了一個發布分支，並在該分支上進行安全強化和驗證工作[^hardening]。**但是**在發布的前幾天，他們也在把主幹的變更合併到發布分支。這是不對的，似乎他們選錯了建立分支的時機。或許團隊中的業務人員推得太緊，以便趕上某個截止日期。
[^hardening]: 安全強化（Hardening）通常指的是透過減少系統的漏洞來保護系統。如果在發布前幾天仍然從主幹合併變更，會破壞之前的安全強化和驗證工作，增加測試負擔和風險。這表明分支建立得過早，應該在開發工作大部分完成後再建立分支，以確保有足夠的時間進行安全強化與驗證。
當然，從建立分支之後，從主幹 cherry-pick 每個提交到該分支也是同樣的事情。

<!--
## Duration of 'short-lived' feature branches

The [short-lived feature branch](/short-lived-feature-branches/) should only last a day or two and never diverge from the trunk enough so that a
merge back is problematic. After the seal of approval from code reviewers and CI
daemons, it should be merged back into the trunk. It should be deleted, as proof of convergence.
The developer in question may then go ahead and make the next short-lived feature branch for the next story/task they're doing.
-->

## 「短期」功能分支的持續時間

[短期功能分支](/short-lived-feature-branches/)應該只持續一兩天，並且不應該與主幹有太多差異，以免合併回來出現問題。在程式碼審查者和 CI 常駐程式批准後，應將其合併回主幹。它應該被刪除，作為收斂的證明。
然後，相關開發者可以繼續為他們正在執行的下一個故事或任務，建立下一個短期功能分支。

<!--
## Numbers of developers on 'short-lived' feature branches

If there is more that one developer (and the developer's pairing partner) on the same [short-lived feature branch](/short-lived-feature-branches/),
then that branch is at risk of not being short-lived. It is at risk of being more and more like a release branch
under active development, and not short at all.

There is a risk too, that a developer may choose to pull changes to their workstation **from a short-lived feature
branch** rather from the trunk. They may think that the code review for that short-lived feature branch is going to take
too long, or they need the changes before they are ready. Unfortunately, there is no way that the current generation of
code portals can prevent people pulling changes from non-trunk branches.
-->

## 「短期」功能分支的開發者數量

如果同一個[短期功能分支](/short-lived-feature-branches/)上有多位開發者（以及開發者的配對夥伴），那麼該分支就面臨不短暫的風險。它面臨著越來越像正在積極開發的發布分支的風險，而且一點也不短。

還存在一個風險，開發者可能會選擇**從短期功能分支**將變更拉取到他們的個人電腦。他們可能認為該短期功能分支的程式碼審查會花費太長時間，或者他們需要在準備好之前進行更改。不幸的是，目前的程式碼入口網站無法阻止人們從非主幹分支拉取更改。

<!--
## Every day not being the same for developers.

Developers take stories or tasks from the backlog, implement them with tests, and push them through code review and quality checks
into the shared trunk. They don't slow down that activity as they get closer to a release date. At least the majority do not. A very
small subset of the development team may focus on the release candidates being made from the release branch (if that
branch exists at all), and towards fixes in the trunk that will be cherry-picked into that branch. For most of the team, though,
every day looks the same. Also proximity to a release does not slow down the rate at which changes are being pushed into the
trunk. **There is certainly no "code freeze" with Trunk-Based Development**, as team leadership focuses on protecting the
majority of developers from the distraction of release preparation. If that protection is missing, something needs
fine-tuning, and the branching model could be it.
-->

## 對開發者來說，每一天都不一樣。

開發者從待辦事項中獲取故事或任務，實現它們並完成測試，然後透過程式碼審查和品質檢查將它們推送到共享主幹。隨著發布日期的臨近，他們不會放慢這項活動。至少大多數人不這麼認為。開發團隊的一小部分人可能會專注於從發布分支（如果該分支存在）製作的候選版本，並且專注於位在主幹、將被 cherry-pick 到該分支中的修復。然而，對於團隊的大多數成員來說，每一天看起來都是一樣的。此外，接近發布版本並不會減慢將變更推送到主幹的速度。**基於主幹的開發當然不會出現「程式碼凍結」**，因為團隊領導的重點是保護大多數開發者免受發布準備的干擾。如果缺少這種保護，則需要進行一些微調，而分支模型可能是其中之一。

<!--
## Keeping a single release branch

If you are making a release branch, you should not keep it alive for a series of major releases. You principal
mechanism to land code on that branch is the branch creation itself. After that only cherry picks for bug
fixes as found. Even then they should diminish over time. If release branches is your model then the reality should
be that pressure mounts to create a new release branch (from trunk), and evidence is that there is no more
cherry-picks from trunk to the old release branch. In terms of release you might have witnessed releases 1.1, 1.1.1 and 1.1.2 be done from tags on that release branch, but the cherry picks should diminish to zero over time, and activity reconvene around an newer release branch - for the 1.2 release probably.
-->

## 保留單一發布分支

如果你正在建立一個發布分支，那麼你不應該在一系列主要版本中保持它的活動狀態。將程式碼放置在該分支上的主要機制是分支建立本身。之後，只挑選所發現的錯誤修復。即使這樣，它們也會隨著時間的推移而減少。如果發布分支是你的模型，那麼現實情況應該是壓力會促使建立一個新的發布分支（從主幹），並且證據表明再也沒有從主幹到舊發布分支的挑選。就發布而言，你可能已經見證了版本 1.1 、 1.1.1 和 1.1.2 是透過該發布分支上的標籤完成的，但隨著時間的推移，cherry-pick 應該會減少到零，並圍繞較新的發布分支重新開展活動——大概是發布版本 1.2。

<!--
## Merge from one release branch to another release branch

We only merge from trunk to release branches (if we branch at all), and then only a small percentage of the
commits to trunk, and only using the cherry-pick method of merging.  Sure, two release branches could be in
play for short periods of time, but the team should cherry-pick merge from trunk to two different branches.
In some VCS tools (Perforce and Subversion) those can be in the same atomic commit, but that is not
strictly necessary.
-->

## 從一個發布分支合併到另一個發布分支

我們只從主幹合併到發布分支（如果我們有分支的話），然後只有一小部分提交到主幹，並且只使用 cherry-pick 的合併方法。當然，兩個發布分支可能會在短時間內發揮作用，但團隊應該從主幹 cherry-pick 合併到兩個不同的分支。在某些 VCS 工具（Perforce 和 Subversion）中，它們可以位於同一原子提交中，但這並不是絕對必要的。

<!--
## Merge everything back from a release branch at the end of the release branch

Bug fixing on the release branch? If yes, then that is covered above. If you are not doing that then you have no need
to merge anything back from the release branch - you can just delete it after you're sure there will not be any more
releases from it.
-->

## 在發布分支結束時將所有內容從發布分支合併回去主幹

發布分支上的錯誤修復？如果是，那麼上面已經介紹了。如果你不這樣做，那麼你無需從發布分支合併任何內容 - 你可以在確定不再有任何發布後將其刪除。
