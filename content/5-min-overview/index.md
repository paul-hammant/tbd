---
date: 2016-01-01T09:42:02+05:00
title: 五分鐘概覽
weight: 11
---

<!--
## Distance

{{< quote title="Branches create distance between developers and we do not want that" >}}
&mdash; Frank Compagner, Guerrilla Games
{{< /quote >}}

Assuming any network-accessible source control, physical distance is mitigated by AV technologies including 
screen sharing. So we will not worry about that so much these days.

Frank's 'distance' is about the distance to the integration of code from multiple components/modules/sub-teams for a 
binary that could be deployed or shipped. The problematic distance is to code not yet in the single shared branch, 
that might:

* break something unexpected once merged
* be difficult to merge in.
* not show that work was duplicated until it is merged
* not show problems of incompatibility/undesirability that does not break the build

Trunk-Based Development is a branching model that reduces this distance to the minimum. 
 
-->

## 距離

{{< quote title="建立分支會在開發者之間創造距離，而我們不希望這樣" >}}
&mdash; Frank Compagner, Guerrilla Games
{{< /quote >}}

當我們使用能夠透過網路存取程式碼版本控制系統時，實際的物理距離不再是一個大問題。這是因為影音視訊技術，如螢幕共享，不論實際距離如何，我們都可以即時溝通與協作。因此，在現代的開發環境中，我們不太需要擔心團隊成員之間的物理距離所帶來的影響。

Frank 所說的「距離」，指的是開發過程中，多個元件、模組或多個團隊的程式碼如何整合到一個可部署或可發布的二進制檔案中的挑戰。這裡的「距離」並非指物理距離，而是指程式碼整合的難度和複雜性。當整合過程存在這種距離時，可能會遇到以下幾種情況：

* 破壞一些意想不到的功能
* 合併過程會遇到困難
* 重複的工作被執行，直到合併後才被發現
* 直到合併後才發現不兼容或不合適的問題

主幹開發是能夠將距離最小化的分支模型。

<!--
## What it is

{{< note title="Notes" >}}
* Use of "Developers" throughout this site, means "QA-automators" for the same buildable thing, too.
* When we say 'the trunk' on this site, it is just a branch in a single repository that developers in a team are focusing on 
for development. It may be called 'main'. That hints at the fact that the branch in question may literally not be 
called 'trunk' at all.
{{< /note >}}

There are many deciding factors before a development team settles on Trunk-Based Development, but here is a short overview 
of the practices if they do:
-->

## 它是什麼？

{{< note title="Notes" >}}
* 在本網站上，提到「開發者」一詞時，指的是對相同可建置專案進行自動化測試的「測試人員」。
* 在本網站上，提到「主幹」（trunk）時，它實際上指的是團隊中的開發者們，集中進行開發的單一版本庫中的一個分支。該分支可能會稱為「main」，不一定會稱為「trunk」。
{{< /note >}}

在開發團隊決定採用主幹開發之前，有許多決定性因素需要考慮，但如果他們確實選擇這種方式，這裡有一個簡短的實踐概覽：

<!--
### Releasability of work in progress

Trunk-Based Development will always be **release ready**

If an executive manager visited the development team and commanded "Competitor X has launched feature Y, go 
live now with what we have", the worst response would be "give us one hour". The development team might have been very 
busy with tricky or even time-consuming tasks (therefore partially complete), but in an hour, they are able to go live 
with something just stabilized from the trunk. Perhaps they can do it in less than an hour. The rule, though, is to **never break 
the build**, and **always be release ready** because the CIO or the business may surprise you.
-->

### 進行中工作的可發布性

主幹開發始終應該是**隨時可發布的**狀態

如果一位高層經理拜訪開發團隊，並布達命令：「競爭對手 X 已經推出了功能 Y，現在就用我們擁有的東西上線」，更糟的消息是「給我們一小時」。開發團隊當下可能正在忙於解決一些複雜或者需要較長時間才能完成的任務（這意味著這些任務目前只做到一半），但在一小時內要求他們立即上線，他們能夠中挑選一些已達到穩定狀態的功能或程式碼，並將其部署上線。也許他們能在不到一小時內做到。然而，規則是**永遠不要破壞建置**，並且**總是準備好發布**，因為 CIO 或業務部門可能會突然給你帶來驚喜。

<!--
#### Where releases happen

A key facilitating rule is that Trunk-Based Development teams exclusively **either** release directly from the 
trunk - see [release from trunk](/release-from-trunk/), **or** they make a branch from the trunk specifically for 
the actual release. See [Branch for release](/branch-for-release/).
Teams with a higher release cadence do the former, and those with a lower release cadence do the latter. 
-->

#### 發布在哪裡進行？

一個關鍵的協助發布的原則是，採用主幹開發的團隊要麼直接從主幹發布 - 參見[從主幹發布](/release-from-trunk/)，**或者**他們專門從主幹建立一個分支用於實際的發布。參見[為發布建立分支](/branch-for-release/)。發布頻率較高的團隊採用前者方法，而發布頻率較低的團隊則採用後者方法。

<!--
### Checking out / cloning

All developers in a team working on an application/service, clone and checkout from the trunk. They will 
update/pull/sync from that branch many times a day, **knowing** that the build passes. Their fast 
source-control system means that their delays are a matter of a few seconds for this operation. They are now 
integrating their teammates' commits on an hour-by-hour basis.
-->

### checkout 或 clone

所有團隊中的開發者在開發一個應用程式或服務時，都會從主幹進行 clone 和 checkout 的操作。他們會在一天之內多次從該分支進行更新、拉取或同步的操作，**也確信**建置會是成功的。因為程式碼版本控制系統運行的非常快速，在進行上述操作時，僅需要耗時數秒就能完成。由於這樣的高效率，使得團隊能夠實現更加緊密的整合流程，他們能夠每小時就整合隊友的最新提交，確保他們的工作始終與主幹保持同步。

<!--
### Committing

Similarly, developers completing a piece of development work (changes to source code), that does not 
break the build, will commit it back to the trunk. That it does not break the build should be provable. The granularity of that commit (how many a developer 
would implicitly do a day) can vary and is learned through experience, but commits are typically small.

The developer needs to run the build, to prove that they did not break anything with the commit **before** the commit
is pushed anywhere. They might have to do an update/pull/sync before they commit/push the changes back to the team's 
version control server, and additional builds too. There's a risk of a race condition there, but let us assume that is not 
going to happen for most teams.
-->

### 提交

同樣地，當開發者完成了一項開發工作（對程式碼的變更），而這項工作並不會破壞建置時，他們會將把它提交回主幹。這個提交不會破壞建置應該是可以被證明的。這次提交的細節程度（一個開發者一天內隱式進行多少次提交）可能會有所不同，這是通過經驗學習的，但通常提交範圍都是小的。

開發者需要執行建置，以證明他們的提交沒有破壞任何東西，然後才能將提交推送到任何地方。在他們提交或推送更改回團隊的程式碼版本控制系統**之前**，他們可能需要先進行更新、拉取或同步，並且還需要進行額外的建置。這裡存在推送競賽[^race-condition]的風險，但讓我們假設對於大多數團隊來說，這種情況不會發生。

[^race-condition]: 推送競賽（Race condition）指的是多個操作在沒有適當同步的情況下同時訪問某些資源，導致結果無法預測或者出現錯誤的情況。在這個情境中，如果兩個或更多的開發者同時嘗試提交他們的更改，可能會導致一個推送競賽，從而影響最終的程式碼合併結果。

<!--
### Code Reviews

The developer needs to get the commit reviewed. Some teams will count the fact that the code was 'pair programmed' 
as an automatic review. Other teams will follow a conventional design where the commit is marshaled
for review before landing in the trunk. In modern portal solutions, marshaled nearly always means a branch/fork (Pull
Request) that is visible to the team.

![](trunk_pr.png)
([key](/key/))

^ the speech bubbles are stylized code review comments

Code review branches can (and should) be 
deleted after the code review is complete and be very short-lived. This is tricky for teams new to Trunk Based 
Development. 

Note: You want to keep 
the commentary/approval/rejection that is part of the review for historical and auditing purposes, but you do not want to 
keep the branch. Specifically, you do not want the developers to focus on the branch after the code review and merge back
to the trunk.
-->

### 程式碼審查

開發者需要讓提交的程式碼接受審查。有些團隊會認為「配對程式設計」 就等同於自動完成了程式碼審查。而其他團隊則會採用傳統的方法，在提交程式碼到主幹之前進行審查。在現代的系統解決方案中，審查幾乎總是意味著建立一個分支或分叉（拉取請求），讓團隊成員可以看到。

<img srcset="trunk_pr.png 1x,trunk_pr@2x.png 2x">([分支圖示的說明](/key/))

^ 圖中的對話框是以特殊風格呈現的程式碼審查評論。

程式碼審查的分支在審查完成後可以（也應該）被刪除，並且生命週期非常短暫。對於剛開始使用主幹開發的團隊來說，這可能會有些困難。

註：你希望保留審查過程中的評論、批准或拒絕等記錄，以供歷史回顧和審計之用，但你不想保留那個分支。具體來說，你不希望開發者在程式碼審查完成並合併回主幹後，還專注於那個分支。

<!--
## A safety net

[Continuous Integration](/continuous-integration/) (CI) daemons are set up to watch the trunk (and the 
[short-lived feature branches](/short-lived-feature-branches/) used in review), and as quickly and completely as possible 
loudly/visibly inform the team that the trunk is broken.  Some teams will lock the trunk and roll-back changes. Others 
will allow the CI server to do that automatically.

![](5trunk1.png)
([key](/key/))

The high bar is verifying the commit before it lands in the trunk. Short-lived Pull Request branches are the modern
place for that.
 
-->

## 防護網

[持續整合](/continuous-integration/)（CI）會設置常駐程式來監控主幹（和用於審查的[短期功能分支](/short-lived-feature-branches/)），並盡可能快速且全面地向團隊大聲且明顯地通報主幹出現問題。有些團隊會鎖定主幹並退回變更。有些團隊則允許持續整合服務器自動做這件事。

<img srcset="5trunk1.png 1x,5trunk1@2x.png 2x">([分支圖示的說明](/key/))

更高的標準是在提交合併到主幹之前進行驗證。在現在軟體開發中，偏向使用短期的拉取請求分支來進行這樣的驗證。

<!--
## Developer team commitments

As stated, developers are pledging to be rigorous and not break the build. They're also going to need to consider 
the impact of their potentially larger commits, especially where renames or moves were wholesale, and adopt techniques
to allow those changes to be more easily consumed by teammates.
-->

## 開發團隊的責任

如前面所述，開發者已承諾嚴格執行，他們將不會使建置過程失敗。此外，他們必須要意識到他們的大規模提交可能會對專案產生重大影響，尤其是當進行大量的重命名或文件移動時。因此，開發者需要採用相應的技巧和方法，以確保他們的改動可以被其他團隊成員更輕鬆地接受和整合。

<!--
## Drilling into 'Distance'

Problematic 'distance' has a few tangible examples:

* Late merges of development that happened more than a couple of days ago
  * Difficult merges in particular
* A breaking build that lowers development team throughput, and diverts resources while it is being fixed
-->

## 深入瞭解「距離」

「距離」這一概念性問題有幾個具體的例子：

* 遲來的合併，如果在開發工作的幾天後才合併到主幹，可能會造成問題。
  * 特別是那些難以合併的情況。
* 如果建置過程出現問題，不僅會降低開發團隊的工作效率，而且在修復建置問題期間還需要額外投入資源。

<!--
# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>
-->

# 其他參考資料 {#references-elsewhere}

<a id="showHideRefs" href="javascript:toggleRefs();">顯示參考資料</a>

<div>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">03 Sep 2009, MartinFowler.com article</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://martinfowler.com/bliki/FeatureBranch.html">FeatureBranch</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">16 Jun 2015, Blog Entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://www.alwaysagileconsulting.com/articles/organisation-pattern-trunk-based-development">Organization Pattern: Trunk-Based Development</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">04 Oct 2016, Blog Entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://www.michielrook.nl/2016/10/branches-considered-harmful/">Branches considered harmful</a></td>
        </tr>
    </table>
</div>


