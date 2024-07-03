---
date: 2016-03-02T20:08:11+01:00
title: 版本控制系統的選擇
weight: 32
---

<!--
## Git and Mercurial

See Git's website{{< ext url="https://git-scm.com" >}} and Mercurial's website{{< ext url="https://www.mercurial-scm.org" >}}

Git and Mercurial have been popular DVCS technologies for many years. Portals like GitHub make Git, in particular, the default 
choice for SCM/VCS/source-control. While the Linux Kernel is maintained with Git, and definitely takes advantage 
of the D-Distributed aspect of the DVCS of Git (in that many divergent versions of kernel can exist over 
long periods of time), most enterprises are still going to count a single repository as the principal one, and within 
that a single branch as the long-term "most valuable" code line.

It is perfectly possible to do Trunk-Based Development in a Git repository. By convention 'main' is the long term 
most valuable branch, and once cloned to your local workstation, the repository gains a nickname of 'origin'.
-->

## Git 和 Mercurial

請參閱 Git 的網站{{< ext url="https://git-scm.com" >}}和 Mercurial 的網站{{< ext url="https://www.mercurial-scm.org" >}}

多年來，Git 和 Mercurial 一直是流行的分散式版本控制系統技術。尤其像 GitHub 這樣的平台使 Git 成為 SCM、SVC 或原始碼版本控制的預設選擇。雖然 Linux 核心是用 Git 維護的，並且肯定利用了 Git 的分散式版本控制系統特性（即許多不同的核心版本可以長期存在），但大多數企業仍然會將單個程式碼版本庫視為主要程式碼版本庫，並將其中的單一個分支作為長期「最有價值」的程式碼開發路線。

在 Git 程式碼版本庫中進行主幹開發是完全可能的。按照慣例，「main」是長期最有價值的分支，一旦 clone 到本地的個人電腦，該版本庫就會獲得「origin」的暱稱。

<!--
### Forks

An effective Trunk-Based Development strategy, for Git, depends on the developer maintaining a fork of the origin 
(and of 'main' within), and Pull-Requests being the place that ready to merge commits are code reviewed, **before** being 
consumed back into `origin:main`. Other branching models use the same Pull-Request process for 
code-reviews too - it is the normal way of working with Git since GitHub rolled out the feature.
-->

## Fork

對於 Git 來說，有效的主幹開發策略取決於開發者維護 origin 的一個分叉（以及其中的 main 分支），並且拉取請求是提交的程式碼在被合併進入 `origin:main` **之前**進行審查的地方。其他分支模型也使用相同的拉取請求流程進行程式碼審查——這是自 GitHub 推出該功能以來，使用 Git 的正常工作方式。

<!--
### Size Limits

Historically, Git and Mercurial were not great at maintaining a zipped history size greater that 1GB. Many 
teams have reported that they have a repository size larger than that, so opinions differ. One way that you can reach 
that 1GB ceiling quickly is with larger binaries. As Git keeps history in the zipped repository, even a single larger 
binary that changes frequently can push the total use above 1GB.

With the likes of correctly configured Git-LFS extension to Git, though, the 1GB limit can be avoided or delayed 
many years.

Other ways to limit larger clone sizes in git repos include recommending/specifying a partial cloning date horizon 
with the "--shallow-since" parameter, or using git's more recent Partial-Clone{{< ext url="https://git-scm.com/docs/partial-clone" >}} features, supported in GitLab for 
example, to get the git commit history without getting all the blobs, and instead having the blobs download transparently 
on-demand/as-needed.

Git also has Submodules{{< ext url="https://git-scm.com/docs/git-submodule" >}} and 
Subtrees{{< ext url="https://blogs.atlassian.com/2013/05/alternatives-to-git-submodule-git-subtree" >}} to allow large 
federations of modules, within one cloneable set.  For their 
 Android initiative, Google made Git-repo{{< ext url="http://source.android.com/source/using-repo.html" >}} too.
-->

### 大小限制

從歷史上看，Git 和 Mercurial 並不擅長維護大於 1GB 的壓縮歷史記錄大小。許多團隊報告說他們的程式碼版本庫大小超過了這個限制，因此意見不一。快速達到 1GB 上限的一種方法是使用更大的二進位檔。由於 Git 將歷史記錄保存在壓縮程式碼版本庫中，因此即使是一個經常更改的較大型二進位檔也可以將總使用量推高到 1GB 以上。

但是，通過正確地為 Git 配置 Git-LFS 擴充之類的方法，可以避免或延遲很多年才會達到 1GB 的限制。

在 Git 程式碼版本庫中限制較大 cloning 大小的其他方法包括建議使用 `--shallow-since` 參數指定部分 cloning 日期範圍，或者使用 Git 最新的 Partial-Clone 功能，例如GitLab 支援獲取 Git 提交歷史記錄，而無需獲取所有 blob，而是讓 blob 按需透明地下載。

Git 還具有 submodule {{< ext url="https://git-scm.com/docs/git-submodule" >}}和 subtree {{< ext url="https://blogs.atlassian.com/2013/05/alternatives-to-git-submodule-git-subtree" >}}，以允許在一個可 clone 的集合中進行大型模塊聯合。對於他們的 Android 計劃，Google 也製作了 Git-repo{{< ext url="http://source.android.com/source/using-repo.html" >}}。

<!--
### Root level branches

It'll be clear later why we mention this, but Git and Mercurial maintain branches from the root folder of the 
checkout clone, and maintains a single permission for a user in respect of read and/or write on the branch and/or repository.
-->

### 根級分支

稍後我們會清楚地看到為什麼我們提到這一點，但 Git 和 Mercurial 維護來自 checkout clone 的根資料夾的分支，並為使用者維護有關分支與程式碼版本庫讀寫的單一許可權。

<!--
### Future development


There is a suggestion that Mercurial is receiving contributions that will allow it to push into the very repository
territory the likes of Google needs.

Git and Mercurial don't have branch or directory permissions, but some of the platforms that bundle them, add 
branch permissions.
-->

### 未來發展

有一種說法是，Mercurial 正在接受貢獻，這將使它能夠進入 Google 等公司需要的程式碼版本庫領域。

Git 和 Mercurial 沒有分支或目錄許可權，但使用它們的一些平台會新增分支權限。

<!--
### Linus Torvalds presenting Git to Googlers

Back in 2007, Linus Torvalds presented his Bitkeeper inspired Git to Googlers in their Mountain View office:
 
<div noprint style="position: relative; padding-bottom: 56.25%; padding-top: 30px; height: 0; overflow: hidden;"><iframe src="//www.youtube.com/embed/4XpnKHJAok8" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" allowfullscreen frameborder="0"></iframe></div>
 
-->

<!-- print <img src="linus-git.png"> print -->
<!-- print <br/> print -->
<!-- print <a href="https://youtu.be/4XpnKHJAok8">Video Available at https://youtu.be/4XpnKHJAok8</a> print --> 

<!--
 
He had started making it two years before, and it is now the #1
VCS choice. Google had been running their Monorepo style Trunk for a few years at this point, without regret. Some
Googlers would later extend their Perforce (see below) setup to allow Git operation of local branches on
developer workstations.
-->

### Linus Torvalds 向 Google 員工展示 Git

早在 2007 年，Linus Torvalds 就在 Google 的山景城辦公室向 Google 員工展示了他受 Bitkeeper 啟發的 Git

他兩年前就開始製作它，現在是版本控制系統的首選。在這一點上，Google 已經運行了主幹開發風格幾年了，並且沒有後悔。一些 Google 員工後來擴展了他們的 Perforce（見下文）設置，以允許開發者個人電腦上的本地分支進行 Git 操作。

<!--
### Platform Software Choices

* GitHub {{< ext url="https://github.com" >}} - Git, cloud 
* GitHub Enterprise {{< ext url="https://enterprise.github.com/home" >}} - Git in GitHub's on-premises edition
* GitLab {{< ext url="https://about.gitlab.com" >}} - Git, cloud and on-premises install
* Atlassian's Bitbucket server {{< ext url="https://www.atlassian.com/software/bitbucket/server" >}}- Git
* RhodeCode {{< ext url="https://rhodecode.com" >}} - Git, Mercurial and Subversion
* Assembla {{< ext url="https://www.assembla.com" >}} - Git, Mercurial, Perforce and Subversion
* Various Collabnet{{< ext url="http://www.collab.net" >}} products and services for Git
* Microsoft's Visual Studio Team Services{{< ext url="https://visualstudio.microsoft.com/team-services" >}} - Git, cloud
* Microsoft's Team Foundation Server{{< ext url="https://www.visualstudio.com/tfs" >}} - Git in Microsoft's on-premises edition
-->

### 平台軟體選擇

* GitHub {{< ext url="https://github.com" >}} - Git、雲端
* GitHub Enterprise {{< ext url="https://enterprise.github.com/home" >}} - GitHub 本地版中的 Git
* GitLab {{< ext url="https://about.gitlab.com" >}} - Git、雲端和本地安裝
* Atlassian 的 Bitbucket {{< ext url="https://www.atlassian.com/software/bitbucket/server" >}} - Git
* RhodeCode {{< ext url="https://rhodecode.com" >}} - Git、Mercurial 和 Subversion
* Assembla {{< ext url="https://www.assembla.com" >}} - Git、Mercurial、Perforce 和 Subversion
* 適用於 Git 的各種 Collabnet {{< ext url="http://www.collab.net" >}} 產品和服務
* Microsoft 的 Visual Studio Team Services {{< ext url="https://visualstudio.microsoft.com/team-services" >}} - Git、雲端
* Microsoft 的 Team Foundation Server {{< ext url="https://www.visualstudio.com/tfs" >}}- Microsoft 本地版中的 Git

<!--
## Perforce

Perforce's website{{< ext url="https://www.perforce.com" >}}
-->

## Perforce

Perforce 的網站 {{< ext url="https://www.perforce.com" >}}

<!--
### Vanilla Perforce

Perforce is a closed-source, industrial strength VCS. Pixar stores everything needed to make a movie in it, and Adidas 
store all their designs in it. Until 2012, Google had their Trunk and many tens of terabytes of history in it.
They moved off it to an in-house solution as they outgrew it. Perforce is peculiar in that its 'p4d' (a single server-side 
executable binary file) is the whole server and does not need to be installed - just executed.

Perforce is the last VCS technology that ordinarily maintains the read-only bit on the developer workstation. You 
definitely need a plugin for your IDE to handle the wire operations with the server, so you are not confronted with the
fact that source files are read-only. Because the Perforce (p4) client having to involve the server for the flipping of
read-only bits in respect of editing source files, it requires a permanent connection to the server. What that 
facilitates is the speed of operation for very large sets of files on the client. The Perforce server already knows what 
files need to have updated in your working copy, ahead of you doing 'p4 sync' operation. It negates the need for a 
directory traversal looking for locally changed files, and it means the sync operation can be limited to a second or two.

Historically Perforce was not able to **locally** show the history of the files within it. It needed that server 
connection again for history operations. A number of DVCS capabilities in newer versions of Perforce (see below) allow
local history now, though.

Perforce allows branches to be set up at any sub-directory, not just the root one. It also allows read and/or write
permissions to be specified at any directory (or branch) within large and small source trees.
-->

### Vanilla Perforce

Perforce 是一個閉源的工業級版本控制系統。Pixar 將製作電影所需的一切儲存在其中，而 Adidas 則將所有設計儲存在其中。直到 2012 年，Google 都在使用它的主幹，以及數十 TB 的歷史記錄。隨著使用量的增加，他們轉向內部解決方案。Perforce 的獨特之處在於它的「p4d」（單個伺服器端可執行二進位檔）是整個伺服器，不需要安裝 - 只需執行即可。

Perforce 是最後一個通常在開發者個人電腦上維護唯讀位的版本控制系統技術。你絕對需要為你的整合式開發環境安裝外掛來處理與服務器的通訊操作，以便你不會遇到源文件為唯讀的情況。由於 Perforce（p4）客戶端必須涉及與服務器互動來改變編輯源文件的唯讀位，因此它需要與伺服器建立永久連接。這有助於提高用戶端上非常大的檔集的操作速度。Perforce 服務器已經知道哪些文件需要在你的工作副本中進行更新，而不需要你執行「p4 sync」操作。這樣可以避免需要遍歷目錄以尋找本地更改的文件，並且意味著同步操作可以限制在一秒鐘左右。

從歷史上看，Perforce 無法在本地顯示其中檔的歷史記錄。它需要再次建立伺服器連接才能執行歷史記錄操作。不過，較新版本的 Perforce（見下文）中的許多分散式版本控制系統功能現在允許本地歷史記錄。

Perforce 允許在任何子目錄中設置分支，而不僅僅是根目錄。它還允許在大型和小型原始程式碼樹中的任何目錄（或分支）中指定讀取或寫入權限。

<!--
#### No Code Review

Perforce does not have code-review features integrated into its traditional server daemon. By customizing a modified Gitlab 
called GitSwarm 'side install', Perforce now has a code review capability. It also has it with an alternate side-install 
called just Swarm (a slightly older product), that does not offer the Git capability of GitSwarm, but does add in much
of the team-ware features like code review.
-->

#### 無需程式碼審查

Perforce 傳統的伺服器常駐程式並未整合程式碼審查功能。通過自定義修改的 GitLab，稱為 GitSwarm 的外掛，Perforce 現在具有了程式碼審查能力。它也可以透過稱為 Swarm 的外掛（一個稍舊的產品），該產品不提供 GitSwarm 的 Git 功能，但卻新增了許多團隊軟體功能，如程式碼審查。

<!--
### Git Fusion

There's a VM appliance from the Perforce people, that can sit in your infrastructure and mediate between the vanilla Perforce
server, and your wish to use a pure Git workflow on your development workstation.

With a Git Fusion clone from a Perforce repository, and client spec was specified, you get the subsetted 
representation of the source tree, complete with history. That's a neat feature. Things checked out through Git Fusion
also are not encumbered by the read-only bit feature.

GitSwarm kinda replaces this.
-->

### Git Fusion

Perforce 公司提供了一個虛擬機器應用程式，可以放置在你的基礎設施中，並在純淨的 Perforce 伺服器與你在開發個人電腦上使用純 Git 工作流程之間進行調解。

使用來自 Perforce 程式碼版本庫的 Git Fusion clone 並指定了客戶端規範，你可以獲得原始程式碼樹的子集表示形式，並附有歷史記錄。這是一個簡潔的功能。通過 Git Fusion checked 的內容也不受唯讀位特性的限制。

GitSwarm 有點取代它。

<!--
### p4-git and p4-dvcs

P4-git is very similar to the Git Fusion technology but is not made by the Perforce people themselves. It also does not 
require the launching of second server appliance (as Git Fusion does).

In 2015, the perforce technologies were extended to include custom DVCS features. All the features of p4-git but without 
the Git compatibility.

As for Git Fusion, things checked out through p4-git and p4-dvcs are not encumbered by the read-only bit control of p4d.
-->

### p4-git and p4-dvcs

P4-git 與 Git Fusion 技術非常相似，但不是由 Perforce 人自己製作的。它也不需要啟動第二個伺服器設備（就像 Git Fusion 一樣）。

2015年，Perforce技術擴展到包括自定義分散式版本控制系統功能。p4-git 的所有功能，但沒有 Git 相容性。

至於 Git Fusion，通過 p4-git 和 p4-dvcs checked 的內容不受 p4d 的唯讀位控制的阻礙。

<!--
## Subversion

Subversion's website{{< ext url="https://subversion.apache.org" >}}

Subversion (Svn) has been in development for 16 years and was a sorely needed open-source replacement for CVS. It chases some of the
features of Perforce but is developed quite slowly. Nobody has pushed Subversion to the Perforce usage levels, but 
that is claimed as a possibility.

Subversion, like Perforce, has read and write permissions down to the directory and branch.

Interestingly there is a "Subversion vs Git" website{{< ext url="https://svnvsgit.com/" >}} which attempts to counter
some widely held community beliefs about Subversion and how it stacks up to Git.

Note also that the Subversion team themselves, do not do Trunk-Based Development, despite Subversion have default root directories 
of 'trunk', 'tags' and 'branches' for newly-created repositories.
-->

## Subversion

Subversion 的網站 {{< ext url="https://subversion.apache.org" >}}

Subversion（Svn）已經開發了 16 年，是協作版本系統急需的開源替代品。它追逐 Perforce 的一些功能，但開發速度相當緩慢。沒有人將 Subversion 推向 Perforce 的使用水準，但聲稱這是一種可能性。

Subversion 和 Perforce 一樣，具有對目錄和分支的讀寫許可權。

有趣的是，有一個「Subversion vs Git」網站 {{< ext url="https://svnvsgit.com/" >}} 試圖反駁一些廣泛持有的社群對 Subversion 的看法，以及它如何與 Git 相提並論。

還要注意的是，Subversion 團隊本身並不進行基於主幹的開發，儘管 Subversion 為新建立的程式碼版本庫提供了預設的根目錄 trunk、tags 和 branches。

<!--
### No Code Review

Note that Subversion has no local branching capability, and to get code review you need to install third-party servers 
along side it. Or, a better choice, use a platform that integrates code review like those below.
-->

### 無需程式碼審查

請注意，Subversion 沒有本地分支功能，要進行程式碼審查，你需要在它旁邊安裝第三方伺服器。或者，更好的選擇是使用整合程式碼審查的平台，如下所示。

<!--
### Git-Svn

There is an extension to Git that allows it to deal with a Subversion backend. A Git-subversion clone has all the 
local history, local-branching possibilities of Git. The local branching possibilities afforded by this 
mode of operation are very handy, and it should work easily with whatever Svn hosting platform you installed.

Note: That clone from subversion can be many tens of times slower, 
than the equivalent clone from Git, because it is recreating the zipped Git history on the client-side as in
uses the classic Subversion wire protocol, which is more chatty. Indeed the initial clone of years of commits for a 
reasonably sized team can take many hours. 
-->

### Git-Svn

有一個 Git 的擴展可以讓它處理 Subversion 的後端。一個 Git-subversion 的複本擁有所有 Git 的本地歷史、本地分支的可能性。這種操作模式所提供的本地分支可能性非常方便，它應該可以輕鬆地與你安裝的任何 Svn 主機平台一起使用。

註：從 Subversion 複製的 clone 版本可能比從 Git 複製的相等版本慢許多倍，因為它在客戶端重新建立了壓縮的 Git 歷史，就像使用經典的 Subversion 線路協定一樣，這更加冗長。實際上，對於一個規模合理的團隊多年的提交，初始 clone 可能需要花費許多小時。

<!--
### Platform Software Choices

* RhodeCode{{< ext url="https://rhodecode.com" >}} - installable on-premises
* Various Collabnet{{< ext url="http://www.collab.net" >}} products and services.
* ProjectLocker{{< ext url="http://projectlocker.com" >}} - cloud
* Deveo{{< ext url="https://deveo.com/svn-hosting" >}} - cloud
* RiouxSvn{{< ext url="https://riouxsvn.com" >}} - cloud
* SilkSvn{{< ext url="https://sliksvn.com" >}} - cloud
* Assembla{{< ext url="https://www.assembla.com/subversion" >}} - cloud and installable on-premises
* XP-dev{{< ext url="https://xp-dev.com" >}} - cloud
* Codeplex{{< ext url="https://www.codeplex.com" >}} - cloud
-->

### 平台軟體選擇

* RhodeCode {{< ext url="https://rhodecode.com" >}} - 可本地安裝
* Various Collabnet {{< ext url="http://www.collab.net" >}} 產品和服務
* ProjectLocker {{< ext url="http://projectlocker.com" >}} - 雲端
* Deveo {{< ext url="https://deveo.com/svn-hosting" >}} - 雲端
* RiouxSvn {{< ext url="https://riouxsvn.com" >}} - 雲端
* SilkSvn {{< ext url="https://sliksvn.com" >}} - 雲端
* Assembla {{< ext url="https://www.assembla.com/subversion" >}} - 雲端和可本地安裝 on-premises
* XP-dev {{< ext url="https://xp-dev.com" >}} - 雲端
* Codeplex {{< ext url="https://www.codeplex.com" >}} - 雲端

<!--
## Team Foundation Server - TFS

TFS's website{{< ext url="https://www.visualstudio.com/tfs" >}}

Microsoft launched TFS in the mid-2000's with a **custom VCS technology** "TFVC". It is said that they have an internal 
'SourceDepot' tool that is a special version of Perforce compiled for them in the nineties, and that TFS reflects some 
of the ways of working of that technology. It has grown to be a multifaceted server platform. Perhaps even a 
one-stop shop for the whole enterprise's needs for application lifecycle management.  More recently with TFS, 
Microsoft encouraged a use of Git within it, rather than then proprietary VCS they initially developed.

TFS is perfectly compatible with a Trunk-Based Development usage.

Note: Microsoft are donating back to the Git community with a Git Virtual File System, which allows some Monorepo 
usage for Git{{< ext url="https://github.com/Microsoft/VFSForGit" >}}.
-->

## Team Foundation Server - TFS

TFS 的網站 {{< ext url="https://www.visualstudio.com/tfs" >}}

Microsoft 於 2000 年代中期推出了 TFS，採用了一種自定義的版本控制系統技術「TFVC」。據說他們在九十年代開發了一個內部工具「SourceDepot」，這是一個特殊版本的 Perforce，而 TFS 反映了那個技術的一些工作方式。它已發展成為一個多面向的伺服器平台。也許甚至是企業整個應用生命週期管理需求的一站式解決方案。最近，Microsoft 在 TFS 中鼓勵使用 Git，而不是他們最初開發的專有版本控制系統。

TFS 與基於主幹的開發使用方式完全兼容。

註：Microsoft 正在向 Git 社群捐贈 Git 虛擬文件系統，它允許 Git 的某些單一版本庫使用 {{< ext url="https://github.com/Microsoft/VFSForGit" >}}。

<!--
## PlasticSCM

Plastic's website{{< ext url="https://www.plasticscm.com" >}}

PlasticSCM is a modern DVCS like Git and Mercurial, but closed-source. It is compatible with Trunk-Based Development and quite 
self-contained (has integrated code review, etc). Plastic is very good with bigger binaries and comes with an 
intuitive "Branch Explorer" to see the evolution of branches, view diffs, execute merges, etc. For sizes of individual
repositories, multiple terabytes is not unheard of. A least for some of the games-industry customers.
 
It is also the first modern VCS to have semantic merge - it understands 
select programming languages and the refactorings developers perform on them. For example "move method", where that
method is 50 lines long, is not 50 lines added and 50 deleted in one commit, it is a much more *exact* and terse diff
representation. 

Plastic even calmly handles a situation where one developer moves a method within a source, and another simultaneously 
changes the contents of the method in its former location. Plastic does not consider that a clash at all, and just does 
the merge quietly - the method moves and is changed in its new location.
-->

## PlasticSCM

Plastic 的網站 {{< ext url="https://www.plasticscm.com" >}}

PlasticSCM 是一個現代的分散式版本控制系統，類似於 Git 和 Mercurial，但都是閉源的。它與基於主幹的開發相容，並且非常獨立（整合了程式碼審查等）。Plastic 非常適合處理更大的二進位檔，並帶有直觀的「分支瀏覽器」，可以查看分支的演變、查看差異、執行合併等。對於單個程式碼版本庫的大小，數 TB 並非聞所未聞。至少對於一些遊戲行業的客戶來說。

它也是第一個具有語義合併的現代版本控制系統——它理解選定的程式設計語言以及開發者對它們執行的重構。例如，「分支瀏覽器」，該方法長 50 行，不是一次提交新增 50 行和刪除 50 行，而是更精確和簡潔的差異表示。

Plastic 甚至可以冷靜地處理這樣一種情況：一個開發者在源中移動一個方法，而另一個開發者同時更改方法在其先前位置的內容。Plastic 根本不認為這是衝突，只是悄悄地進行合併——方法在其新位置移動並更改。
