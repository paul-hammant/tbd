---
date: 2016-07-05T20:10:46+01:00
title: 連續發布的並行開發
weight: 75
---

<!--
## Concurrent Development?

Your company wants a stream of major functionality to arrive in the application you are pushing live at a regular 
cadence. Because you are good Extreme Programmers, you know that consecutive development of consecutive releases
is best. However, the effort and length of time needed to complete each major piece of functionality is
large enough to require different project teams cooperating towards that plan. Some of those teams will be within
the same codebase. Some may be dependent services that the application will invoke over the wire. Not everything 
is equal effort it seems, yet the business wants a specific rollout, including dates and can plan that even eighteen 
months ahead. They are very specific because there is an impact on the user community (staff, clients, customers or 
members of the public). Driving departments may include training, marketing, finance.
-->

## 並行開發？

你的公司希望應用程式能夠定期推出一系列的主要功能。作為出色的極限開發者（XP），你們知道連續發布的並行開發是最好的選擇。然而，每個主要功能的工作量和所需時間都很大，需要不同的項目團隊合作完成這個計劃。其中一些團隊將在同一程式碼庫中工作，有些則可能是應用程式需要通過網路呼叫的依賴服務。看起來不是所有工作量都是等價的，但業務希望能夠進行具體的推出計劃，包括日期，並且能夠提前十八個月計劃。他們之所以具體到這個程度，是因為這對用戶群體（員工、客戶、顧客或公眾成員）產生影響。推動部門可能包括培訓、市場營銷與財務。

<!--
## Oops?

What you have got is the perfect setup for disaster born from the random bad news events. Things that can and do 
happen in software development. 

Or perhaps one thing was underestimated by 50% and that is realized later rather than sooner. 
Should all of the following releases slip too, assuming the company did not attempt to throw bodies at it in an attempt 
to solve it? We all know of Fred Brook's Mythical Man-Month{{< ext url="https://books.google.com/books/about/The_Mythical_Man_Month_Anniversary_Editi.html?id=Yq35BY5Fk3gC" >}}
and Edward Yourdon's Death March{{< ext url="https://books.google.com/books/about/Death_March.html?id=FdAZUX9H_gAC" >}}.
-->

## 哎呀？

你們有可能會面臨由隨機壞消息事件引發的一些災難。這些事情在軟體開發中是有可能且確實會發生的。

或許某件事被低估了 50 ％，而這一點比預期的更晚才被察覺。假設公司沒有試圖通過增加人手來解決問題，所有接下來的版本釋出是否也應該延後？我們都知道 Fred Brook 的《人月神話》{{< ext url="https://books.google.com/books/about/The_Mythical_Man_Month_Anniversary_Editi.html?id=Yq35BY5Fk3gC" >}}和 Edward Yourdon 的《死亡行軍》{{< ext url="https://books.google.com/books/about/Death_March.html?id=FdAZUX9H_gAC" >}}。

<!--
## Reorder Releases?

One compelling answer is to change the order of releases. To the business, that could be a relief even if it requires
re-planning and problems around marketing/education given the impacted staff, clients, customers or members of the 
public.
-->

## 重新排序版本發布？

一個有說服力的解決方案是改變版本發布的順序。對於企業來說，即使這需要重新規劃，並且會在市場營銷或教育方面帶來一些問題，考慮到受影響的員工、客戶、顧客或外部成員，這仍然有可能是一種解法。

<!--
## Un-merge?

The trouble is that the development teams might have to face a selective un-merge or commenting-out frenzy to support that, depending on
what had merged already. Different branching models have different merge impacts and are either early or late in terms
of keenness for the act of merging. That in itself is disruptive to the business, as they fear and probably witness 
additional delays because of the retooling and new-found nerves.
-->

## 取消合併？

問題在於，開發團隊可能需要面對選擇性地取消合併或瘋狂註解程式，這取決於已經合併了哪些內容。不同的分支模型對合併的影響各不相同，無論這些合併行為是早還是晚。這本身就對業務造成干擾，因為他們擔心可能會目睹由於重新配置，和新的緊張情緒所導致的額外延遲。

<!--
## Flags, abstractions, and pipelines

If your team has institutionalized Trunk-Based Development, [Feature Flags](/feature-flags/) pluggable components based
on abstractions (not a world apart from [Branch by Abstraction](/branch-by-abstraction/)), it is in a perfect position 
to reorder releases, and only have a small impact on the throughput of the development team. 
-->

## 功能標誌、抽象分支和流水線

如果你的團隊已經制定了主幹開發，[功能標誌](/feature-flags/)基於抽象的可插拔元件（與[抽象分支](/branch-by-abstraction/)概念雷同），這使其完美地處於重新排序發布的位置，並且只對開發團隊的吞吐量產生較小的影響。

<!--
### Case study

In a real-life case study for an airline in 2012, late in development for the planned release a partner said that they could 
not, in fact, meet that date. Their side of the integration was not going to be ready. The airline was code complete but now had to 
reorder releases. The development team's management feared some downtime while the mess was sorted out. The team in question
was able to spin up a new CI pipeline, with the flags/toggles flipped to show the new permutation of features. 
The new CI pipeline confirmed what they had already seen on the command-line build, that there were failures in the 
automated tests (and something in a page did not quite look right anyway). A couple of quick fixes later, and the development 
team assured the airline's management that the releases could reasonably happen in any order.

Choosing Trunk-Based Development, [Feature Flags](/feature-flags/) and [Branch by Abstraction](/branch-by-abstraction/) 
could be said to be a **hedging strategy** against the costs of larger scheduling changes.

{{< warning title="Consecutive development of consecutive releases is by far superior!" >}}
Every high throughput Extreme Programming team will tell you that finishing and shipping a release before starting work
as a team on the next releasable slice of work is much better than attempting to do concurrent development of 
consecutive releases.  Sure, some teammates (PM, BA, tech leads) are looking a couple of weeks ahead to make sure that
everything is ready for development and QA automation on a just in time basis but the majority of the dev team will 
only pick up new release work as the previous one has been pushed into production.
{{< /warning >}} 
-->

### 案例研究

在 2012 年一個航空公司的實際案例研究中，當計劃發布進入開發的後期階段時，一個合作夥伴表示他們實際上無法在該日期前完成。他們的整合部分還沒有準備好。航空公司的程式碼已經完成，但現在必須重新安排發布順序。開發團隊的管理層擔心在整理混亂情況時可能會有一些停機時間。該團隊設法啟動一個新的持續整合（CI）流水線，並照調整切換功能標誌或開關以顯示功能的新排列。新的 CI 流水線證實了他們在命令列建置中已經看到的情況，即自動化測試中存在失敗（而且頁面中的某些內容看起來並不完全正確）。經過幾次快速修復後，開發團隊向航空公司的管理層保證，版本發布可以合理地以任何順序進行發布。

選擇主幹開發、[功能標誌](/feature-flags/)和[抽象分支](/branch-by-abstraction/)可以被說是對更大調度變更成本的**避險策略**。

{{< warning title="連續發布的連續開發遠優於其他！" >}}
每個高產能的極限開發團隊都會告訴你，先完成並發布一個版本，然後再開始下一個可發布的工作階段，比同時進行連續版本的並行開發要好得多。當然，一些團隊成員（產品經理、業務分析師、技術領導）會提前幾週確保一切準備就續，以便在正確的時間進行開發和品質保證自動化，但大部分開發團隊只會在前一個版本被推送到正式環境後才開始進行新的發布工作。
{{< /warning >}}


<!--
# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>
-->

# 其他參考資料 {#references-elsewhere}

<a id="showHideRefs" href="javascript:toggleRefs();">顯示參考資料</a>

<div>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">19 Mar 2013, Blog Entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://paulhammant.com/2013/03/19/cost-of-unmerge/">The Cost of Unmerge</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">14 Jul 2013, Blog Entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://paulhammant.com/2013/07/14/legacy-application-strangulation-case-studies/">Legacy Application Strangulation: Case Studies</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">10 Oct 2014, Conference Talk</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://www.perforce.com/resources/trunk-based-development-enterprise">Trunk-Based Development in the Enterprise - Its Relevance and Economics</a></td>
        </tr>
    </table>
</div>



