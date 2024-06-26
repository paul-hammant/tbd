---
date: 2016-06-02T20:10:46+01:00
title: 直接提交到主幹
weight: 62
---

<!--
Some teams will choose to commit/push straight to the trunk. Most likely it is because they are a small team with each
team member knowing what the others are up to. **Their build is probably fast and relatively exhaustive**, and they 
may well seldom experience a build breakage. If the build does break (post integration into trunk/main) then they most likely 'revert' the 
commit straight away, possibly locking the trunk for a short period of time while that is performed. If the team is 
really small (say three or four), in which case the team might allow someone to fix the build quickly and commit that 
in order to get the build green again.
-->

有些團隊會選擇直接提交或推送到主幹。可能因為他們是一個小型團隊，每個團隊成員都知道其他人在做什麼。他們的建置可能很快，而且相對詳盡，他們可能很少遇到建置中斷的情況。如果建置確實中斷（整合到主幹或主要分支後），那麼他們很可能會立即「還原」該提交，可能在執行此操作時將主幹鎖定一段時間。如果團隊真的很小（比如三個或四個人），在這種情況下，團隊可能允許某人快速修復建置並提交以使建置再次變為綠色。

<!--
In the 2000's many Trunk-Based Development teams might have numbered up to 100 committers. They may have been extremely 
rapid with their `reverts` (lock trunk, revert, kick off the CI daemon again, unlock trunk if green again). If there was no build-automation server, they would 
have performed check-in activities that 1997's C3 team{{< ext url="https://en.wikipedia.org/wiki/Chrysler_Comprehensive_Compensation_System" >}} 
would have recognized, because they wanted that human 
assurance that gated check-ins are all that is needed to keep the build green. Namely, developers holding an 
"I/we are checking in now, nobody else should be". They run the full build after bringing their checkout up to date 
and commit/push if green. Indeed that ceremony is a key part of the [Continuous Integration](/continuous-integration/) advances 
and is now part of Agile generally, and Extreme Programming in particular. These days teams doing this practice are likely 
to be much smaller (say less than 16) because of the advent of alternatives (see below). That said, there are still some large teams 
working this way.
-->

在 2000 年代，許多主幹開發團隊可能有多達 100 個提交者。他們可能非常迅速地進行「還原」（鎖定主幹、還原、重新啟動持續整合常駐程式，如果再次綠色則解鎖主幹）。如果沒有建置自動化服務器，他們將會執行 1997 年 C3 團隊{{< ext url="https://en.wikipedia.org/wiki/Chrysler_Comprehensive_Compensation_System" >}}所認可的檢查活動，因為他們希望得到人工保證，即門控式檢查進入才是保持建置綠色所需的。換句話說，開發者宣稱「我或我們現在正在進行檢查，其他人不應該進行」。他們在將自己的檢出更新到最新後運行完整的建置，如果綠色則提交或推送。事實上，這個儀式是[持續整合](/continuous-integration/)進步的關鍵部分，現在已經成為敏捷開發的一部分，特別是極限開發。現在採用這種做法的團隊可能會小得多（比如少於 16 人），這是因為替代方案的出現（請參見下文）。儘管如此，仍有一些大型團隊以這種方式工作。

<!--
# Benefits

It is easier to objectively verify the correctness of your commits yourself (optimally with a pair-programming partner), then commit/push at moments of convenience. That is, easier than pushing into a code-review system for approval from a teammates that risks being interruptive to their workflow. Indeed there is a greater likelihood that this this style or working becomes a flow of small commits into the trunk, with each of those being an incremental step forward, and perfectly able to go-live itself while the larger story/card remains incomplete.
-->

# 好處

與推送到程式碼審查系統等待團隊成員批准相比，通常可以更容易地與配對編程合作伙伴客觀地驗證提交的正確性。這樣可以在方便的時候提交或推送，而不會打斷團隊成員的工作流程。這種方式更有可能讓工作以小的提交流入主幹，每個提交都是向前的一個增量步驟，完全能夠單獨上線，即使更大的故事或任務尚未完成。

<!--
# Challenges

Committing (and pushing) straight to the trunk has a challenge. Principally, someone could commit/push code that breaks the build, and the server(s) setup to guard Continuous Integration don't catch that for some time after the commit is available for teammates to pull/sync to their dev-workstation for unrelated work.

Risk mitigation is **everyone** running the full build (the same build the CI demon would do) before the commit/push, and only pushing to 
trunk if that passes. **This is an essential integration activity**. This is the habit of the XP teams from the end of the 90's, and there's 
no reason any team would dispense with that in the years since. Indeed, it is valuable for ALL branching models.

If this is locked in as a team requirement, your new challenge is to keep the full build fast. Fast is say one minute, and slow is ten or above. Compile and pure unit tests (no threads, sockets, file IO) is where good builds focus their development effort. Any following "integration test" build steps that use threads, listen on sockets, or do significant file IO should be minimized as far as possible without reducing meaningful coverage. The best trick for that is changing some integration tests into pure unit tests, which isn't always easy.

Some teams have revert policies for commits that land in trunk (or main) that are proven as "broken" later in CI. That could be an activity for a build-cop who's going to communicate with the dev team about locking the trunk to achieve that. Or it could be a bot activity and happen instantly, as Google do in-house (35K committers in one trunk).

Some teams have some scripting in place to ensure that developers only pull/sync commits to their dev-workstations that CI has marked as passing. That could be as simple as keeping a commit ID (number or hash depending on your VCS tool) on a website somewhere, and writing a wrapper script for git-pull (or svn up) that ignores commits that happened after that one. Pushing back, with that way of working is harder in Git and Mercurial as they requires you to have pulled HEAD revision before you can push back. Subversion and Perforce don't have that limitation.
-->

# 挑戰

直接提交（和推送）到主幹面臨一個挑戰。主要的挑戰是，有人可能提交或推送了破壞建置的程式碼，而設置來保護持續整合的伺服器在提交後一段時間內可能不會立即發現，而這段時間內其他團隊成員可以同步到他們的開發主機進行無關的工作。

風險減輕的方法是所有人在提或推送之前運行完整的建置（與持續整合守護程序執行的相同建置），只有在通過該建置後才推送到主幹。這是一項必要的整合活動。這是 90 年代末期 XP 團隊的習慣，至今沒有任何理由讓任何團隊放棄這一點。事實上，這對於所有分支模型都是有價值的。

如果將這作為團隊要求，新的挑戰就是確保完整的建置速度快。快速的意思是大約一分鐘，慢速是十分鐘或更長。編譯和純單元測試（沒有執行緒、Socket、檔案輸入輸出）是良好建置的開發工作重點所在。任何後續的「整合測試」建置步驟，如果使用執行緒、監聽 Socket 或進行大量檔案輸入輸出，都應該盡可能減少，而不降低實際覆蓋範圍。其中一個最好的技巧是將一些整合測試轉換為純單元測試，這並不容易。

有些團隊對於後來在持續整合中被證明為「破壞」的提交在主幹（或主要分支）上有還原政策。這可能是由一名建置管理員執行的活動，他將與開發團隊溝通以鎖定主幹來實現這一點。或者這可能是一項機器人活動，並立即發生，就像 Google 在內部所做的一樣（一個主幹有 35K 個提交者）。

有些團隊會執行一些腳本，來確保開發者同步到個人電腦的提交是經過持續整合標記為通過的。這可能就像在某個網站上保留提交識別代號（根據你的版本控制工具是數字還是哈希值），並編寫一個包裝腳本用於 git-pull（或 svn up），忽略那之後發生的提交。在這種工作方式下，向後推送在 Git 和 Mercurial 中更加困難，因為它們要求你在向後推送之前必須拉取 HEAD 修訂版。Subversion 和 Perforce 沒有這個限制。

<!--
# Alternatives to committing straight to the trunk

That modern alternative that allows development teams to scale up without having a bottleneck around check-ins or increased risk of broken builds: [Short-Lived Feature Branches](/short-lived-feature-branches/).

There are also teams that send patches to review systems like Gerrit and Rietveld, instead of committing/pushing straight to trunk/main. Google pioneered this with their in-house Mondrian system in 2006, and Gerrit and Rietveld were made in the image of that. Facebook's Phabricator is another that came later. As well as code review, build-automation systems objectively verify the correctness of the proposed changes, leaving you with high confidence that the following merge/integration into trunk/main will yield a similar positive result when the same infrastructure kicks in later for CI purposes. It is important to note that the automation you attach to commits/pushes to non-trunk branches (or patch queue/review systems) is not Continuous Integration itself.

These two alternatives, as well as committing straight to the trunk are compared in [Styles and Trade-offs](/styles/).  
-->

# 不直接提交到主幹的替代方案

現代的替代方案允許開發團隊擴展，而無需在檢查提交或增加損壞建置的風險方面出現瓶頸：[短期功能分支](/short-lived-feature-branches/)。

還有一些團隊將差異修改發送到像 Gerrit 和 Rietveld 這樣的審查系統，而不是直接提交或推送到主幹或主要分支。 Google 在 2006 年率先在內部使用 Mondrian 系統開創了這一模式，而 Gerrit 和 Rietveld 則是仿照它而製作的。Facebook 的 Phabricator 是稍後出現的另一種類似系統。除了程式碼審查外，建置自動化系統客觀驗證了所提出更改的正確性，使你對隨後將其合併或整合到主幹或主要分支後的持續整合目的而言具有很高的信心，當後續的相同基礎設施用於持續整合時，將會產生類似的正面結果。重要的是要注意，你附加到提交或推送到非主幹分支（或差異修改隊列及審查系統）的自動化不是持續整合本身。

這兩種替代方案，以及直接提交到主幹或主要分支，都在[風格和折衷](/styles/)中進行了比較。
