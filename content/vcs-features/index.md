---
date: 2016-03-01T20:08:11+01:00
title: 版本控制系統的特色
weight: 31
---

<!--
**Desirable VCS features, that is**

To great degree, Trunk-Based Development is possible on any Version Control System (VCS) that does atomic commits (spoiler: all do 
that came after CVS).  Productivity and governance are what divides them, though.
-->

**理想的版本控制系統**

在具有原子提交功能的版本控制系統上都可以實現主幹開發（在 CVS 之後的所有版本控制系統都具備此功能）。然而，生產力和管理是各個版本控制系統之間的區別所在。

<!--
## Productivity

It turns out there are many 
productivity related reasons that teams quit one technology and go to another. It does not matter whether the tool is a commercial
or an open source one. At least to its end users it does not.

By speed we mean two things primarily:

1. The speed at which we can pull/update/sync changes out of a remote server repository
2. The speed at which we can commit/push changes back to that remote server

And three other secondary things that support little and often:

1. Advanced Merging
2. Code Review
3. Continuous Integration
-->

## 生產力

事實上，有許多與生產力相關的原因，將會導致團隊轉移技術。無論這個工具是付費或是開源，在最終使用者眼中並不重要。

速度主要指以下兩個方面：

1. 從遠端伺服器程式碼版本庫中拉取、更新或同步變更的速度。
2. 提交或推送變更回遠端伺服器的速度。

還有其他三個支持「小而頻繁」的次要因素：

1. 進階合併
2. 程式碼審查
3. 持續整合

<!--
### Pull/update/sync speed

If you have at least once done a checkout of the source of the project, any subsequent pull/update/sync is going to bring down 
differences from the previous checkout or update.  If you do two updates back to back quickly, the second one is likely to bring 
down nothing.  The time taken for the version control tool to determine that nothing is due from the remote main 
repository is the biggest clue as to how intrinsically fast it is. 

Technologies that only keep head revision on the checkout, ordinarily have to walk the entire directory structure 
looking for changed files and do handshaking to the server for each one. That is definitely Subversion and its predecessor CVS. 
Batching of those exchanges speeds it up, but there is still a slowdown related to the breadth and depth of the source
tree. Perforce makes the operation faster because the server-side is poised for the sync operation at all times, by 
keeping your tree and which revision you have for each file in RAM. It does this at the cost of maintaining read-only
bits for files (be sure and use an IDE that silently handles the Perforce interactions). Perforce can effectively be much
faster for this back-to-back pull/update/sync test of speed because it kinda already knows the answer to the question.

CVS, Subversion and Perforce offer you the choice of checking out a subdirectory. In a monorepo situation, you would 
consider that a nice feature. At least if you've recursively laid out services and applications within the trunk.

Git and Mercurial have a single point of checkout (Git's 'clone' operation) for the whole repository.  There are no sub-directory checkouts 
for these two. All commits since that 
last 'pull' will be pulled down. This happens before the directory walk to determine what has changed locally. As such, that 
pull operation if very fast - there's no chit chat over the wire things, and the stuff on the server-side was already 
zipped and pretty much ready for transfer. This will be the case even for situations where a particular 
file has been changed a dozen times since you last pulled it down via a sync operation.  You might think 
this is costly, but in practice, Git is incredibly fast.
-->

### 拉取、更新或同步速度

如果你曾經 checkout 過一次程式碼版本庫，任何後續的拉取、更新或同步操作都將從之前的 checkout 或更新中帶來差異。如果你快速連續進行兩次更新，第二次更新可能不會帶來任何變更。版本控制工具判斷遠端主要程式碼版無需做任何更新所需的時間，是該工具本身速度快慢的最大線索。

只保留 checkout 版本的技術通常需要遍歷整個目錄結構，尋找變更的文件，並且需要與伺服器確認每個文件的狀態。這就是 Subversion 及其前身 CVS 的典型做法。儘管通過批次處理這些交換操作來加快速度，但與原始碼目錄的廣度和深度仍會造成速度下降。Perforce 使操作更快，因為伺服器端隨時準備同步操作，通過將你的目錄結構和每個文件的修訂版本保存在記憶體中。這需要維持文件的唯讀屬性（請使用能夠自動處理 Perforce 互動的 IDE）。在連續的拉取、更新或同步速度測試中，Perforce 會顯得更快，因為它已經有了答案。

CVS、Subversion 和 Perforce 都提供了 checkout 子目錄的選擇。在單一版本庫的情況下，這是一個不錯的功能。至少在你以遞迴方式在主幹中布局服務和應用程式時，會覺得這個功能非常方便。

Git 和 Mercurial 的 checkout 操作（Git 的「clone」操作）是針對整個倉庫的。這兩者都不支持子目錄 checkout。所有自上次「pull」以來的提交都會被拉取下來。這在確定本地變更的目錄遍歷之前發生。因此，該拉取操作非常快速——不需要在網路上進行冗長的多次通訊，並且服務器端的資料已經被壓縮並準備好傳輸。即使某個文件自上次同步操作以來已經更改了十幾次，情況也是如此。你可能會認為這樣做成本很高，但實際上，Git 的速度非常快。

<!--
### Commit/push speed

Things are more equal here between the tools we highlight as viable.  

Subversion and Perforce send up deltas of changed files to the server. Some directory walking can slow this down. There 
is inevitably a lot of chit-chat on the wire for these operations. 

Git and Mercurial do the same, but before you push to the remote repo it will make you commit locally which is incredibly 
fast. Before you push to the shared remote repository, these two will make you pull first.  

Perforce and Subversion will allow you to commit/push changes to the remote, without necessarily having the latest versions (and 
incidentally all the intervening ones) locally first.  It will only allow that if there was no clash on the lines changed.

Perforce can cheat again, but taking advantage of the read-only bit, and therefore already knows which files definitely 
have **not** changed between the remote main repo and local working copy. It still feels slower than it should be, though.  
-->

### 提交或推送的速度

在這方面，各種工具之間的差異較小。

Subversion 和 Perforce 會將變更文件的差異部分發送到伺服器。有些目錄遍歷可能會使這一過程變慢。這些操作在網路上不可避免地會產生大量通訊。

Git 和 Mercurial 也是如此，但在推送到遠端程式碼版本庫之前，它們會要求你先在本地進行提交，這過程非常快。在推送到共享遠端程式碼版本庫之前，這兩個工具都會要求你先進行拉取操作。

Perforce 和 Subversion 允許你在不必先擁有最新版本（以及所有中間版本）的情況下，將更改提交或推送到遠端伺服器。只要沒有衝突，它們會允許這樣做。

Perforce 可以再次利用唯讀位元來加快操作速度，因為它已經知道哪些文件在遠端程式碼版本庫和本地工作副本之間**肯定沒有**變更。不過，操作速度仍感覺比預期的慢。
<!--
### Three-way merge tools

Developers (hopefully in pairs) are going to have to become skilled in arbitrating over merges for the commits they 
are trying to promote to the remote trunk, as well as the changes they are updating from that it in the case that they 
have work in progress in their working-copy. Trunk-Based Development teams, you see, are merging more often. Albeit 
those are smaller merges, and they are implicitly merged to your working copy.

Perforce's three-way merge tool (P4Merge) is good enough on its own to be attractive to teams using other VCS 
technologies. For those other technologies, P4Merge  is just a config setting away from being usable.  

Semantic merge is the next step up in the science of source-control. See [Plastic SCM](/vcs-choices/index.html#plasticscm).
-->

### 三方合併工具

開發者（希望是成對的）需要熟練地處理合併操作，以解決他們試圖將提交推送到遠端主幹的衝突，同時在他們的工作副本中進行的工作也需要更新。因為使用主幹開發的團隊需要更頻繁地進行合併操作，儘管這些合併較小，但它們隱式地合併到你的工作副本中。

Perforce 的三方合併工具（P4Merge）非常出色，吸引了使用其他版本控制系統技術的團隊。對於其他技術，只需進行一個配置設置，就可以使用 P4Merge。

語義合併是原始碼控制科學的下一步發展。可以參考 [Plastic SCM](/vcs-choices/index.html#plasticscm)。

<!--
### Code Review

Integrated code review turned out to to be the killer feature of VCS tools. This should have been clear from the moment Mondrian
was unveiled by Guido van Rossum (Mr. Python) in a [publicized Google 'tech talk' in 2006](https://www.youtube.com/watch?v=sMql3Di4Kgc). It delivered pre-commit
code reviews to developers and gamified the activity of code review to some degree. Google was
using Perforce back then (they changed to an in-house technology in 2012), and it did not have code review built in, so 
they had to make Mondrian (which was the final form of years of intermediate deliverables for the same). Thus
Mondrian being created tightly coupled code review to the hourly activities of developers on the trunk. 

GitHub (not Git) was next for the non-Google dev world with a built-in code-review tool (and workflow). Again this was 
effectively pre-commit - or at least commit to the main.

There were (and are) other technologies for code review such as Crucible (Atlassian), UpSource (JetBrains), Gerrit, 
Phabricator, but integration into a platform experience is key.  GitLab and RhodeCode are emerging platforms.

Read more in [Game Changers - Google's Mondrian](/game-changers/#googles-internal-devops-2006-onwards) and 
[Game Changers - GitHub's Pull Requests](/game-changers/#githubs-entire-initial-platform-2008).
-->

### 程式碼審查

整合的程式碼審查被證明是版本控制系統工具的殺手級功能。從 Guido van Rossum（Python 之父）在 2006 年的一次 Google 公開的技術演講中介紹 Mondrian 開始，這一點應該就非常明顯（該技術演講的連結：[publicized Google 'tech talk' in 2006](https://www.youtube.com/watch?v=sMql3Di4Kgc)）。它為開發者提供了提交前的程式碼審查，並在一定程度上使程式碼審查變得有趣。當時，Google 使用的是 Perforce（他們在 2012 年轉為內部技術），而 Perforce 本身並未內建程式碼審查功能，所以他們必須開發 Mondrian（這是多年來中間交付成果的最終形式）。因此，Mondrian 將程式碼審查與開發者在主幹上的日常活動緊密結合在一起。

接下來，對於非 Google 開發世界來說，GitHub 成為具有內建程式碼審查工具與工作流程的平台。同樣，這也是在提交之前（或至少在提交到主分支之前）進行的審查。

還有其他的程式碼審查技術，例如：Crucible（Atlassian）、UpSource（JetBrains）、Gerrit、Phabricator，但關鍵在於將其整合到平台體驗中。GitLab 和 RhodeCode 正在成為新興平台。

詳細了解請參閱[變革推廣者 - Google 在 2006 年之後的內部 DevOps](/game-changers/index.html#googles-internal-devops-2006-onwards) 和[變革推廣者 - GitHub 的 Pull Requests](/game-changers/index.html#githubs-entire-initial-platform-2008)。

<!--
### Continuous Integration testing

This goes hand in hand with the Code Review capability. CI Servers kick in for commits are pushed up code review branches, 
or at least against change sets that are entering code review and validate them. The regular build, and maybe some 
additional steps are executed against them and the results of those made available to code reviewers, Facebook has a 
Service Level Agreement to have those complete ten minutes after the commit has been placed in the 'needs code review'
queue.

The reality of VCS platforms today is that they only provided hooks (web-hooks most likely) into other CI servers. The
best combinations of VCS platform and CI server do so for any of the branches in play, including code-review branches 
(forks).
-->

### 持續整合測試

這與程式碼審查功能密不可分。持續整合伺服器會在提交被推送到程式碼審查分支時啟動，或者至少在進入程式碼審查的變更上進行驗證。對這些提交進行常規建置，可能還會執行一些其他步驟，並將這些結果提供給程式碼審查人員。Facebook 在提交放入「需要程式碼審查」隊列後有一項服務水準協議[^sla]，要求在十分鐘內完成這些測試。

如今，版本控制系統平台的現況是，它們只提供了與其他持續整合伺服器的鉤子（hook）（可能是 Web hook）。最好的版本控制系統平台和持續整合伺服器組合可以對所有正在進行的分支進行操作，包括程式碼審查分支（fork）。

[^sla]: 服務水準協議（Service Level Agreement）可參考[什麼是 SLA (服務水準協議)？](https://aws.amazon.com/tw/what-is/service-level-agreement/)一文說明

<!--
## Governance

It turns out that enterprises like the ability to carve up permissions, and set read and write permissions throughout
their repositories.
-->

## 管理

事實證明，企業喜歡能夠對其版本庫進行權限劃分，並設置讀取和寫入權限。

<!--
### fine grained permissions

All VCS usages need users accounts to be able to accept changes back, even if they don't all require accounts in order
to be able to read. In the enterprise user accounts will be required to be able to read too.

The larger the enterprise the more likely it will be that they have permissions carved up in more fine grained ways.
For example "can commit to the trunk, but cannot create release branches" will be common for Trunk-Based Development
teams that make release branches.  Not all VCS technologies support that. Git, for example, does not, but some of the 
portal experiences around it, add the feature. In reality, though, you cannot stop people from making branches in a DVCS,
but you can prevent them from pushing them to the shared repository.

Deeper still, some enterprises will want to set permissions down the directory level within a branch within a repository.
This could be as simple as a gate, to ensure that process is adhered to around checkins, but could also be to guard
some secrets in a Monorepo implementation. That last is counter to some of the "common code ownership" ideals of
modern software engineering though.
-->

### 良好的顆粒度權限

所有版本控制系統使用都需要使用者帳戶能夠接受變更，即使不是所有的使用情況都需要帳戶才能讀取。在企業中，使用者帳戶也需要讀取的權限。

企業規模越大，就越有可能將權限劃分得更精細。例如，對於進行版本控制的團隊而言，「可以提交到主幹，但不能建立發行分支」這樣的權限設置是常見的。不是所有的版本控制系統技術都支援這一點。例如，Git 就不支援，但在其周邊的某些外掛或工具中，可能會新增此功能。然而，在實際情況中，你無法阻止人們在分散式版本控制系統中建立分支，但你可以防止他們將分支推送到共享程式碼版本庫中。

更深入地說，一些企業希望在程式碼版本庫的分支內部的目錄層級上設置權限。這可以是一個簡單的檢查點，以確保在提交時遵守相應的流程，但也可以用於保護單一版本庫實施中的某些機密訊息。然而，這與現代軟體工程中一些「共享程式碼所有權」的理念相抵觸。

<!--
### Size / Scale

Many teams, particularly those with Monorepo configurations or large binary files (like Games companies), want to have 
limitless server-side storage for their repository.  Git and Mercurial are inching towards bigger and bigger 
capacity, but there are still a few snafus to work through - how to cleanly/safely reduce the size of the client side clone
history (while still being able to push changes back to the server) is a challenge.

Microsoft released Git Virtual File System (~~GitVFS~~ ~~GVFS~~ VFS for Git{{< ext url="https://github.com/Microsoft/VFSForGit" >}} - Windows only) in early 2017, to layer on some of the things they had 
become used to in the in-house recompilation of Perforce (SourceDepot - used from 1998 to 201x), as well as native VCS 
of their commercial offering Team Foundation Server (TFS).
-->

### 規模或擴展性

許多團隊，尤其是那些擁有單一版本庫配置或包含大型二進制檔案（例如遊戲公司）的團隊，希望擁有無限的伺服器端儲存空間來存放他們的程式碼版本庫。Git 和 Mercurial 逐漸增加了容量，但仍然存在一些問題需要解決——在不影響推送更改回伺服器的前提下，如何乾淨且安全地減少客戶端 clone 歷史的大小，是一個挑戰。

微軟在 2017 年初推出了 Git 虛擬檔案系統(~~GitVFS~~ ~~GVFS~~ VFS for Git{{< ext url="https://github.com/Microsoft/VFSForGit" >}} - Windows only)，以新增一些他們在內部重新編譯 Perforce （SourceDepot-從 1998 年到 201x 使用）以及他們的商業產品 Team Foundation Server（TFS）的原生版本控制系統所熟悉的功能。
