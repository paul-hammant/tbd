---
date: 2016-06-01T20:10:45+01:00
title: 風格和權衡
weight: 60
---

<style>
figure.floatleft {
	max-width: 30%;
	width: auto\9*0.3; /* ie8 */
	height: auto;
	float: left;
	margin-top: 6px;
}
figure.floatright {
	max-width: 30%;
	width: auto\9*0.3; /* ie8 */
	height: auto;
	float: right;
	margin-top: 6px;	
}
</style>

<!--
There are broadly three styles of trunk-based development as a daily developer activity. Depending on the number of 
developers in the team, the release cadence, and the desired rate of commits (assuming story-sizes that support that), 
you have trade-offs for each of the three:

![](/styles/styles-tradeoffs.png)
-->

存在三種主要的基於主幹的開發風格作為日常開發活動。根據團隊中的開發者數量、發布節奏以及希望達到的提交頻率（假設故事大小支持這一點），每種風格都有其各自的利弊需要權衡。

<p><img srcset="styles-tradeoffs.png 1x,styles-tradeoffs@2x.png 2x"></p>

<!--
## Committing Straight to the Trunk

Suitable for active committer counts between 1 and 100.

{{< figure src="/styles/styles-tradeoffs-l.png" class="floatleft" title="left hand side of the diagram above" >}}

Traditionally Trunk-Based Development meant committing straight to the shared trunk of the VCS in question. And doing so after 
a bunch of steps that together with the commit we will call integration.  

This is a really high throughput way of working, 
but it relies on developers being extremely sure their commit is not about the break the build. If they do, then a manual 
or automatic revert gets the trunk back to a good state, and you hope nobody did a git-pull or svn-up to bring that bad 
commit into their workstation. Or you've engineered it so that does not happen - you publish a known-passing latest commit 
number or hash, and make a wrapper for git-pull (svn-up, etc) to go get that instead of HEAD.

A related challenge is how long "the build" takes to execute by the CI service, versus how frequently the trunk is updated 
with commits for all the committers that could. This is important because if the build fails (CI), there could be following
commits that would pass if it were not for the preceding failing commit. To pick that a part could be a challenge if the 
commit rate is high enough. Some build-cops lock the trunk at the first sign of a breakage. Best of all is a bot that 
reverts specific commits that failed the build, but again that is hard science.  If your build is 10 seconds (start to 
finish), and there is one commit every five minutes, then you are in a good position. If your build is five minutes and 
your team's commits arrive every ten seconds, then you're in hell, and should try something else.

See [committing straight to the trunk](/committing-straight-to-the-trunk/) for more info.
-->


## 直接提交至主幹

適合活躍提交者的數量在 1 到 100 之間。

{{< figure src="/styles/styles-tradeoffs-l.png" class="floatleft" title="上圖的左半邊" >}}

傳統上，主幹開發意味著直接提交到所涉及版本控制系統的共享主幹上。並且在一系列步驟之後進行提交，我們將這些步驟連同提交一起稱為整合。

這種工作方式能夠實現很高的工作效率，前提是開發者必須非常確信它們的提交不會導致建置失敗。如果建置失敗了，可以通過手動或自動的方式恢復，以此保證主幹保持在一個穩定的狀態。同時，你需要確保其他開發者沒有執行了 git-pull 或 svn-up 將那個錯誤的提交拉取至個人電腦環境。為了防止這種情況，可以採取一些預防措施，比如發布一個已知可以成功建置的最新提交的編號或是雜湊值，並且客製化 git-pull 或 svn-up 等命令的封裝，始其默認拉取這個已驗證的提交，而不是最新的提交（HEAD）。

相關的挑戰之一是持續整合服務執行「建置」所需的時間，與主幹被所有可能的提交者更新提交的頻率之間的關係。這一點很重要，因為如果建置失敗了，那麼隨後的提交可能會通過，如果不是因為之前失敗的提交。如果提交速度足夠快，要分辨出是哪一次提交導致建置失敗可能是一個挑戰。有些建置警衛（build-cops）會在出現建置破壞的第一跡象時鎖定主幹。最好的情況是有一個機器人能夠自動恢復那些導致建置失敗的特定提交，但這又是一個複雜的問題。如果你的建置時間是 10 秒（從開始到結束），並且每五分鐘有一次提交，那麼你處於一個不錯的狀態。如果你的建置時間是 5 分鐘，而你的團隊每 10 秒就提交一次，那麼你處於一個非常糟糕的情況，應該嘗試其他方法。

更多資訊請參見[直接提交到主幹](/committing-straight-to-the-trunk/)。

<!--
## Short-Lived Feature Branches

Suitable for active committer counts between 2 and 1000.

{{< figure src="/styles/styles-tradeoffs-c.png" class="floatleft" title="center of the diagram above" >}}

Git and Mercurial delivered truly lightweight branching capability. What that meant was that branches could be very quickly 
created and receive commits that are momentarily divergent from trunk or main (in our case) and then be merged back later
when ready. Then finally, and crucially, the branch that facilitated that short-lived divergence could be deleted quickly
leaving only the the commits added to the effective lined of commits culminating in HEAD for trunk or main.  In that
regard it is identically to the patch review way of working for trunk based development.  That was all just a small 
data point for Git/Mercurial usage, until GitHub launches and had pull-requests as a feature from launch. Built in to that 
was a code review tool. This is a very compelling setup for unsolicited code contributions - making SourceForce and the 
Apache Software Foundation appear ancient, by comparison.

Teams can form around the GitHub pull-request workflow, and still do Trunk-Based Development. What you get (if you've 
attached build automation too), is a trunk or main that's never broken (or 1/1000th as likely to). The trade-off is that 
you have to persuade co-workers to review your commit(s) in a time frame that suits you.  There's a risk that you'd end up 
putting more commits in the pull-request than the straight-to-trunk experts would do. But you don't have to. You could 
stream four separate facilitating commits all the way into the trunk, and later the fifth that would complete/activate the 
feature you were trying to implement as specified by the Agile story/card. Not only is there a risk of more-commits 
than you'd do if you could push directly, there's a risk of taking more time too. If your average story size should be 
one day, a slow-review and slow-build reality for the pull-request way, might push you into multi-day stories/cards, and 
from that be doing the opposite of getting to continuous delivery.

See [short-lived feature branches](/short-lived-feature-branches/) for more info.
-->

## 短期功能分支

適合用於活躍提交者的數量在 2 到 1000 之間，短期功能分支展現出其適宜性。

{{< figure src="/styles/styles-tradeoffs-c.png" class="floatleft" title="上圖的中心部份" >}}

Git 與 Mercurial 賦予了分支以輕量級的特質，使得快速建立分支成為可能，這類分支能暫時從主幹上分離出來，接受提交，並在準備妥當時將其合併回主幹。這樣一來，促成暫時偏離的分支便能迅速被淘汰，只留下那些已經加入主分支 HEAD 的提交紀錄。這種做法與主幹開發的修補程式的審核流程不謀而合。所有這些，直到 GitHub 的出現，尤其是其一開始便提供的拉取請求功能和內建的程式碼審查工具，為程式碼貢獻引入了一種格外引人注目的方式，使得 SourceForce 以及 Apache 軟體基金會的貢獻機制相形見絀。

團隊得以圍繞 GitHub 的拉取請求工作流程建置，同時延續基於主幹的開發模式。引入建置自動化後，便可實現一個錯誤率極低的主幹。這一策略要求你能夠促使同事在合適的時機進行你的提交審核。一個明顯的考慮是，相比於直接對主幹進行提交，你可能會在拉取請求中累積更多的提交。然而，這不是不可避免的，你完全可以通過四個獨立的提交推進至主幹，在適當的時刻通過第五個提交來實現或啟動你根據敏捷故事或卡片所設計的功能。這種方法的一個潛在缺陷是可能增加提交的數量，並且會花費更多時間。如果你的平均任務大小應當在一天內完成，那麼拉取請求的緩慢審核過程和建置可能會使你的任務延期，這與實現持續交付的宗旨相背。

更多資訊請參見[短期功能分支](/short-lived-feature-branches/)。

<!--
## Coupled "Patch Review" System

Suitable for active committer counts between 2 and 40,000.

"We do Trunk-Based Development" - Googler Rachel Potvin - @Scale keynote, Sept 2015 (14 mins in):

![](/branch-for-release/atscale.png)

{{< figure src="/styles/styles-tradeoffs-r.png" class="floatright" title="right hand side of the diagram above" >}}

Perhaps before others in the early 2000's, Google hit a ceiling on how many developers could commit to a trunk in a monorepo, 
without tripping each other up. That would be build-breakages mostly, but also commits that wouldn't be up to coding standards
even if the build still passed.  Say Google managed to get 1000 developers and QA automators working in with commits straight 
into the trunk, before deciding that something needed to gate that. What resulted was a patch review system that would
ultimately be called Mondrian and be announced to the world in 2006 at a tech talk in Mountain View.  This was a system that
Google had written to augment Perforce (the VCS they used up to 2012), to provide a place where code could be reviewed per-commit, and
also build-automation results could be collated. 

Today, patch review systems include Gerrit, Rietveld and Phabricator. The latter by Facebook, and the first two with Googler 
involvement.  These are not branches of course, they are held outside source-control in a relational schema. Their reason 
for existence is to marshal pending changes, before they arrive in trunk/main and to guarantee they are good to be 
integrated.
-->

## 結合「修補程式審查」系統

適用於活躍提交者數量在 2 到 40,000 之間。

*我們實行基於主幹的開發方式* - Google 員工 Rachel Potvin - @Scale 主題演講，2015 年 9 月（14分鐘處）：

![](/branch-for-release/atscale.png)

{{< figure src="/styles/styles-tradeoffs-r.png" class="floatleft" title="上圖的右半邊" >}}

在2000年代早期，Google 可能是首批遇到一個問題的公司，即當單一版本庫（Monorepo）中向主幹提交程式碼的開發者數量達到一定規模時，開始出現相互干擾的情況。這主要體現在建置失敗上，但即使建置成功，提交的程式碼也可能沒達到程式碼風格標準。
在決定需要一個控制機制之前，Google 設法讓 1000 名開發者和 QA 自動化測試人員能夠直接向主幹提交程式碼。隨後，Google 引入了修補程式審查系統，命名為 Mondrian，並於 2006 年在山景城的一場技術講座中對外公布。這是一個 Google 開發的系統，旨在擴展 Perforce（直到 2012 年都是 Google 使用的版本控制系統），提供了一個平台用於進行逐次提交的程式碼審查，並匯總建置自動化的結果。

如今，程式碼審查系統包括 Gerrit、Rietveld 和 Phabricator，其中後者由 Facebook 開發，前兩者得到了 Google 的參與。這些系統並不直接作為程式碼的分支直接存在於版本控制系統中，而是在資料庫中以關聯模式外部管理程式碼變更。它們的目的是在變更進入主幹分支之前進行管理，並確保這些變更可以被整合。

<!--
## The Importance of a Local build

In all variants of Trunk-Based Development teams run the full build locally (compile, unit tests, a range of integration tests) and see that it pass, **before** declaring 'done' and committing/pushing the work to the eyes of teammates and bots (code review / pull-request), or directly into trunk/main. They do not **at all** use build automation as a crutch in order to determine whether their commit(s) were good or bad. Instead they determine that themselves on their dev workstation or containers/VMs that are dedicated to them, and do so **before** pushing something towards code review and bot scrutiny.  As mentioned above keeping this build fast is very important, and not having a fast build is one of the key drivers to other branching models and repo sharding. Indeed it is one of the key drivers to slower release cadences too.
-->

## 本機建置的重要性

在所有變體的主幹開發中，團隊會在本機運行完整的建置（編譯、單元測試或一系列整合測試），並確認一切通過後，才宣布完成，提交或推送工作以供團隊成員和機器人（程式碼審查或拉取請求）的查看，或直接合併到主幹中。他們絕不會**全然**依賴建置自動化來判斷他們的提交是好是壞。相反，他們在自己的開發用的個人電腦或專屬於他們的容器或虛擬機上自行判斷，並且一定要在推送到程式碼審查和機器人審查**之前**做到這一點。正如上面提到的，保持建置速度的快速非常重要，而沒有快速建置是導致其他分支模型和版本庫分割的主要原因之一。實際上，這也是導致發布節奏放慢的主要原因之一。

<!--
## Choosing a style

While it is best to keep developer teams small, sometime there are business pressures to grow a dev team in order to do 
more in parallel. Indeed, with monorepo configurations that could be more dev teams sharing one repo, even if they
have their own release cadences, and separate team organization to other teams.

If Google had (say) 1000 committers doing "straight to the trunk" for a single monorepo back in 2002, should you?  No, not 
since alternates are now possible. If Google had the Mondrian of 2006 back in 2002, they would have moved to that way of working sooner. 

What is the cut off point today?  Super skilled XP era developers who are in charge of dev teams and can train developers in the applicable 
way of working, might say the cut-off is now 100 committers. People who've only ever know the pull-request way of working may 
suggest 10 committers is the cut off point. They may even make a case for 2 committers.  You could well be in a world 
where quorums naturally form within teams, leading to new development directions to be effectively set.  In Google, it was 
employee #1 Craig Silverstein who initially held Google to the monorepo and trunk-based development. And he perhaps did 
that despite quorums forming and group wishes to do something else.

A list of trade-offs are:

* Whether your build technology needs to build 'everything' for every commit. Google's Blaze (Bazel in opensource-land) does not.
* Whether your source-control system has a push/pull bottleneck and whether you've reached that with all the committers in one repo
* The median build duration, versus that commit rate.
* How often your build-automation infra falls behind the commits/pull-requests that need to be compiled/tested.
* Whether your developers can avoid using the automated builds as a crutch
* Whether follow-up commits are a workable way of addressing things that need improvements
* Whether the developers are good at separating refactoring commits from functional commits, and indeed "baby commits" generally.
* Whether your team can handle code-review feedback **after** commit/push to trunk/main or not
 
 
-->

## 選擇一種風格

雖然最好保持開發團隊的規模小型化，但有時業務壓力會促使團隊擴大，以便能夠平行處理更多的工作。的確，在單一版本庫的配置中，可能會有更多的開發團隊共用一個版本庫，即使他們有自己的發布節奏，以及與其他團隊不同的組織架構。

如果說在 2002 年，Google 就有（比方說）1000 名提交者「直接提交到主幹」於一個單一版本庫中，那你應該這麼做嗎？不，因為現在有其他可行的選擇。如果 Google 在 2002 年就擁有了 2006 年的 Mondrian，他們肯定會更早地轉向那種工作方式。

今天的分水嶺在哪裡？掌管開發團隊並能指導成員以適當方法工作的極限開發（XP）專家，可能會說現在的界限是 100 名提交者。那些只知道拉取請求工作方式的人可能會建議 10 名提交者就是界限。他們甚至可能為 2 名提交者的情況下進行辯護。你可能確實處於一個團隊內部自然形成法定人數，導致有效設置新的開發方向的世界中。在 Google，是第一位員工 Craig Silverstein 最初堅持 Google 使用單一版本庫和主幹開發的。儘管法定人數形成並且團體希望做其他事情，他或許還是堅持了這種做法。

一系列的權衡包括：

* 你的建置技術是否需要對每次提交「全部」建置。Google 的 Blaze（在開源領域中為 Bazel）就不需要這樣做。
* 你的程式碼控制系統是否存在 push 或 pull 瓶頸，以及你是否已經因為一個版本庫中所有提交者的操作而達到這個瓶頸。
* 平均建置持續時間與提交率的對比。
* 你的建置自動化基礎設施跟不上需要編譯、測試的提交或拉取請求的頻率有多高。
* 你的開發者是否能避免將自動建置作為依賴。
* 後續提交是否是一種可行的方式來處理需要改進的事項。
* 開發者是否擅長將重構提交與功能性提交分開，以及通常意義上的「小提交」。
* 你的團隊是否能夠在提交或 push 到主幹**之後**處理程式碼審查反饋。
