---
date: 2016-02-01T20:08:11+01:00
title: 決定因素
weight: 21
---

<!--
## Release cadence
-->

## 發布週期

<!--
There are many factors that put pressure on the team to lengthen the interval between releases. Here are some.
-->

有許多因素會導致壓力增加，進而使團隊延長發布間隔，以下是其中一些因素：

<!--
### Iteration length
-->

### 迭代長度

<!--
Different Agile teams focus on different iteration lengths. Some teams work at three-week iterations, some two, 
and some one. Some teams do not have an iteration at all - particularly teams doing Continuous Delivery.
-->

不同的敏捷團隊專注於不同的迭代長度。有些團隊每三週進行一次迭代，有些是每兩週，還有一些是每週一次。有些團隊甚至根本沒有迭代 —— 特別是實行持續交付的團隊。

<!--
If you are on a four week, or more iteration length, and each of those four weeks varies with proximity to the 
release and cannot change that you may be in a bind. You may be able to follow the tenets of Trunk-Based Development, 
benefit from a Continuous Integration daemon (as all branching models can), but you are not going to be able to 
get all the way to Continuous Delivery (or Continuous Deployment).
-->

如果你的迭代長度是四週或更長，而且每四週的工作內容隨著發布日期的接近而有所變化，且無法改變，你可能會陷入困境。你可能能夠遵循主幹開發的原則，從持續整合的精神中受益（因為所有的分支模型都可以），但你不太可能實現完全的持續交付（或持續部署）。

<!--
### Waterfall

This one is easy. If you are doing waterfall, you are not close at all to the "do not break the build" mantra required
to do Trunk-Based Development. Consider a short-iteration Agile methodology like Extreme Programming.
-->

### 瀑布式開發模型

這很簡單。如果你正在使用瀑布式開發模型，你距離主幹開發所需的「不要破壞建置」的信條很遠。考慮使用像是極限開發這樣的短週期敏捷方法。

<!--
### Story size

Trunk-Based Development needs you to have small stories/tasks. Optimal is you starting work on a change, should only be a matter
of hours before completing and pushing it forward for code review. Longer than a couple of days, and there is going to be 
pressure to group a bunch of developers on a non-trunk branch and merge back later. Or worse, have developers make 
branches/forks from your in-progress branch. Or worse still, take intermediate merges from your branch, despite your 
change being incomplete.  
-->

### 故事大小

主幹開發需要你擁有小型的故事或任務。理想情況下，你開始進行一項更改的工作，應該在幾小時內完成並提交進行程式碼審查。如果時間超過幾天，就會讓一群開發者在非主幹分支上進行合併時產生壓力。或者，讓開發者從你正在進行的分支中建立分支或分叉出分支。或甚至是，盡管你的更改尚未完成，但進行中的分支會接受中間合併。

<!--
Generally speaking, the whole development team should do whatever it can to break stories/tasks into smaller stories/tasks. 
In Agile, there is an INVEST mnemonic{{< ext url="https://en.wikipedia.org/wiki/INVEST_(mnemonic)" >}} that aids in the splitting
up of stories.
-->

一般來說，開發團隊應盡其所能將任務分解。敏捷開發裡有一個名為 INVEST 的方法 {{< ext url="https://en.wikipedia.org/wiki/INVEST_(mnemonic)" >}} ，有助於將任務分解成更小的顆粒。

<!--
### Build times
-->

### 建置時間

<!--
Keeping build times short is important in that it directly drives the number of commits a developer can do in a day.
If the build time is a couple of minutes, developers are likely to keep a high pace. If the build time is 30 minutes or
worse, developers change pace to match only a couple of commits a day and drop their throughput.
-->

保持建置時間短是很重要的，因為它直接影響了開發者一天內能夠提交的次數。如果建置時間只有幾分鐘，開發者能夠保持高效率。但如果建置時間長達 30 分鐘或更長，開發者的節奏會因此減慢，每天可能只能提交幾次，進而影響他們的工作效率。

<!--
## VCS Technology Choice
-->

## 版本控制系統技術選擇

<!--
Your VCS/source-control technology choice should facilitate update/pull/sync from the team's trunk many times 
a day. The elapsed time for the update/pull/sync should be less than three seconds for the situation where you 
already had latest of everything. It should be no more than fifteen seconds the case of the shared trunk being ahead 
of you. 
-->

你的版本控制或原始碼控制技術選擇應該促進團隊每天從主幹更新、拉取或同步多次。在你已經擁有最新版本的情況下，更新、拉取或同步的過程應該少於 3 秒。如果共享的主幹版本比你的還新，則更新、拉取及同步的時間不應超過 15 秒。

<!--
Older versions of ClearCase and PVCS Dimensions would be 30 minutes for the former and 45 minutes for the latter. 
Double that if two team-mates were simultaneously trying to do the update/pull/sync operation. In that configuration, it 
was completely impossible for teams to practice Trunk-Based Development.
-->

舊版本的 ClearCase 和 PVCS Dimensions 執行更新、拉取或同步等操作可能分別需要 30 分鐘和 45 分鐘。如果兩位團隊成員同時嘗試進行更新、拉取或同步操作，則可能需要將這個時間加倍。在這種配置下，團隊完全無法實踐主幹開發。

<!--
### Binaries in the Repo?
-->

### 版本庫中的二進制文件？

<!-- 
Depending on how many and how often they update, some SCM/VCS/source-control technologies are better than others. 
Perforce can handle terabytes of binaries and textual source. Subversion aims to. Git can only do large binaries  if 
configured in Git-LFS mode{{< ext url="https://git-lfs.github.com/" >}}.
-->

取決於二進制文件的數量和更新頻率，一些程式碼管理（SCM）、版本控制系統（VCS）或原始碼控制技術比其他技術更適合。 Perforce 能夠處理 TB 級別的二進制文件和文字資源。Subversion 致力於實現這一目標。Git 只有在配置了 Git-LFS 模式 {{< ext url="https://git-lfs.github.com/" >}} 時才能處理大型二進制文件。

<!--
### Repo size?
-->

### 版本庫大小？

<!--
It is suggested that Git and Mercurial really should not have a history (ignoring Git-LFS) that exceeds 1GB. There are field reports of clones being 
many times bigger than that and still working, but the development team suggests 1GB as the top limit. In order to use Git 
and push through that ceiling yearly, you might be in a situation where you have to keep archiving a repository, and starting 
a new one with no history to have more head room. Archiving might look like renaming the repository in GitHub, and turning it 
read-only so that all the history, issues, and code review comments are intact. Simpler clone-rationalization strategies might 
include recommending a "--shallow-since" date on cloning, or leveraging more recent partial clone capabilities to clone the full repo 
commit history without getting historical blobs until they are needed.
-->

建議 Git 和 Mercurial 的版本庫歷史（忽略 Git-LFS）不應超過 1 GB 。有一些實際案例報告 clone 版本庫的大小遠遠超過這個限制，但開發團隊建議將 1 GB 作為上限。為了使用 Git 並突破這個限制，你可能會遇到必須不斷對版本庫進行歸檔，並開始一個新的不帶歷史記錄的版本庫以獲得更多空間的情況。歸檔可能看起來像是在 GitHub 中重新命名版本庫，並將其設置為唯讀，以便所有的歷史、問題和程式碼審查評論都保持完整。更簡單的 clone 優化策略可能包括在 clone 時建議使用 `--shallow-since` 日期，或利用更近期的部分 clone 功能來 clone 完整的版本庫提交歷史，直到需要歷史數據才會去獲取歷史二進制大型物件 (blob)。

<!--
### Peak commit frequency
-->

### 提交的最高頻率

<!--
In "pure" Git, if a colleague beat you to a commit/push on a branch (their code-review and automated CI passed) when you 
thought you were going to push, Git will inform you that you have to pull first. You pull, and you resolve your merge clashes 
(hopefully none), and then push again. On highly-active repos, you might struggle to find a window open long enough to push in 
this way without encountering the same problem. This is known as the "race to push".
-->

在「純粹」的 Git 中，如果一位同事在你準備推送時已經提交或推送了一個分支（他們的程式碼審查和自動化持續整合已通過），Git 會通知你必須先進行拉取。你執行拉取操作，解決合併衝突（希望沒有），然後再次推送。在活動頻繁的版本庫中，你可能會很難找到一個足夠長時間的窗口來推送，而不會遇到相同的問題。這被稱為「推送競賽」。

<!--
Fork-based "pull requests" and similar branch-based "merge requests" in hosted git services solve this to a degree, with robots 
keeping pull-request branches abreast of `origin:main` automatically as long as no conflicts arise.
-->

在托管的 Git 服務中，基於分支的「拉取請求」和類似前者的「合併請求」一定程度上解決了這個問題，只要不出現衝突，機器人就會自動保持拉取請求分支與 origin:main 同步。

<!--
If you are using GitHub as your repository host, there is a tool that can help solve the "race to push" problem. It is called Bors-NG{{< ext url="https://github.com/bors-ng/bors-ng" >}} and it is a merge bot for GitHub pull requests. It will take care of merging the latest trunk version into your branch, running all needed tests and merging the result back into the trunk, managing this as a queue and removing these race conditions.
-->

如果你使用 GitHub 當作程式碼版本庫主機，有一個工具可以幫助解決「推送競賽」的問題。這個工具叫作 Bors-NG{{< ext url="https://github.com/bors-ng/bors-ng" >}} ，是 Github 上一個拉取請求的合併提交機器人服務。這個機器人服務將負責將最新的主幹版本合併到你的分支中，運行所有需要的測試，然後將結果合併回主幹中，以佇列方式管理這個過程，消除這些推送競賽。

<!--
Even with Pull Requests, however, very high commit frequencies to the shared repo means contention and an artificial 
serialization. Microsoft acknowledged this as one
of the motivations to their Git Virtual File System (~~GitVFS~~ ~~GVFS~~ VFS for Git{{< ext url="https://github.com/Microsoft/VFSForGit" >}} which is Windows only for now).
-->

然而，即使使用了拉取請求，對共享版本庫進行非常高的提交頻率也意味著競爭和人工序列化。微軟承認這是他們 Git 虛擬文件系統（Git Virtual File System）{{< ext url="https://github.com/Microsoft/VFSForGit" >}} 的動機之一（現在僅適用於 Windows ）。

<!--
{{< quote title="Git has critical serialization points that will cause a queue to back up badly" >}}
<span>&mdash; Brian Harry</span><br>
<span style="margin-left: 30px">Refer to Brian's "More on GVFS" blog entry<span class="rref"><a class="inline-ref" style="border-bottom: 0" target="_blank" href="https://blogs.msdn.microsoft.com/bharry/2017/02/07/more-on-gvfs/"><img style="padding: 0 0 0 3px; width: 16px; height: 14px" src="/images/ext.png" alt=""></a></span></span>
{{< /quote >}}
-->

{{< quote title="Git 存在一些關鍵的序列化點，可能會導致隊列嚴重堵塞。" >}}
<span>&mdash; Brian Harry</span><br>
<span style="margin-left: 30px">Refer to Brian's "More on GVFS" blog entry<span class="rref"><a class="inline-ref" style="border-bottom: 0" target="_blank" href="https://blogs.msdn.microsoft.com/bharry/2017/02/07/more-on-gvfs/"><img style="padding: 0 0 0 3px; width: 16px; height: 14px" src="/images/ext.png" alt=""></a></span></span>
{{< /quote >}}

<!--
We're sure that within a few years, Git will be able to handle huge scale too. Whether with the Microsoft technologies, or 
something else.
-->

我們可以肯定，在未來幾年內，Git 也將能夠處理大規模項目。無論是使用微軟的技術還是其他技術。

<!--
## Conway's Law
-->

## 康威定律

<!--
The organization creates applications and services that reflect the organization's own structure{{< ext url="https://en.wikipedia.org/wiki/Conway's_law" >}}. 
If your organization feels like this, and a Monorepo does not feel right, then MicroServices could be the direction for you.
-->

組織建立的應用程式和服務反映了組織自身的結構 {{< ext url="https://en.wikipedia.org/wiki/Conway's_law" >}} 。如果你的組織是這樣的話，而單一版本庫（Monorepo）感覺不適合，那麼微服務（Microservices）可能是你的方向。

<!-- 
## Database migrations
-->

## 資料庫遷移

<!-- 
In order to manage database schemas in a Trunk-Based Development way you will need to find a way to handle table-shape changes under source control, and even
manage existing data where new/changed columns have happened. Pramod Sadlage and Scott Amber's book 
"Refactoring Databases: Evolutionary Database Design"{{< ext url="https://www.amazon.com/Refactoring-Databases-Evolutionary-paperback-Addison-Wesley/dp/0321774515" >}}
goes into that much more, as does the [Continuous Delivery](/continuous-delivery/) book.
-->

為了以主幹開發的方式管理資料庫架構，你需要找到一種方式來處理資料表結構的變更，甚至是在發生新增或修改欄位的資料表中，管理其中已有的資料。 Pramod Sadlage 和 Scott Amber 的書《Refactoring Databases: Evolutionary Database Design》{{< ext url="https://www.amazon.com/Refactoring-Databases-Evolutionary-paperback-Addison-Wesley/dp/0321774515" >}} 以及 《[Continuous Delivery]((/continuous-delivery/))》 書籍更深入地探討了這一點。

<!-- 
## Shared code
-->

## 共享程式碼

<!--
Trunk-Based Development teams typically have common code ownership rules around contributions to different parts
of the source tree. If they do not have a fully egalitarian system, they have objective rules for contributions to the tree. 
Rules that focus on standards and come with a promise of a prioritized and fair code review. Trunk-Based Development 
teams might have fine-grained write permissions for directories within the trunk, but **never** have any impediment 
to reading files in the trunk - everyone can see everything.
-->

主幹開發團隊通常對於原始程式碼樹不同部分的貢獻有共同的程式碼所有權規則。如果沒有完全平等的系統，他們會為原始程式碼樹的貢獻制定客觀的規則。這些規則專注於標準並承諾進行優先和公平的程式碼審查。主幹開發團隊可能會對主幹內的目錄設置細粒度的寫入權限，但對於讀取主幹中的文件絕對不會有任何障礙 —— 每個人都可以看到所有內容。

<!-- ## Parallelization

## CI capacity

## QA style

## Environments

### Developer workstations

### Shared services infra

## Code review

## Live config changes

## Tech debt accumulation

## Incident handling

## Backlog management

-->
