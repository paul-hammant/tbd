---
date: 2016-04-01T20:08:11+01:00
title: 功能標誌
weight: 41
---

<!--
Feature Flags are a time-honored way to control the capabilities of an application or service in a large decisive way. 
-->

功能標誌是一種歷史悠久的方法，以決定性的方式控制應用程式或服務的功能。

<!--
### An Example

Say you have 
an application or service that launches from the command-line that has a `main` method or function. Your feature flag 
could be `--withOneClickPurchase` passed in as a command-line argument. That could activate lines of code in the app to 
do with Amazon's patented one-click purchasing 
experience.  Without that command-line argument, the application would run with a shopping cart component. At least
that's the way the developers coded that application. The 'One Click Purchase' and 'Shopping Cart' alternates are 
probably also the same language that the business people associated with the project use. It gets complicated in 
that flags need not be implicitly a/b or new/old, they could be additive. In our case here, there could also be a
`--allowUsersToUseShoppingCartInsteadOfOneClick` capability. Flags can be additive, you see.
-->

### 一個例子

假設你有一個從命令列啟動的應用程式或服務，該應用程式或服務具有 `main` 方法或函數。你的功能標誌可以是作為命令列參數傳遞的 `--withOneClickPurchase`。這可以啟用應用程式中與亞馬遜專利的一鍵購買體驗相關的程式碼。如果沒有這個命令列參數，應用程式將運行帶有購物車元件的功能。至少開發者是這樣編寫該應用程式的。「一鍵購買」和「購物車」的替代方案可能也是與該專案相關的業務人員使用的相同語言。問題變得複雜的地方在於，標誌不一定是隱含地是 a/b 或新/舊，它們可能是附加的。在我們這裡的例子中，還可以有一個 `--allowUsersToUseShoppingCartInsteadOfOneClick` 的功能。你看，標誌可以是附加的。

<!--
{{< note title="Flags Are Toggles" >}}
Industry Luminary, Martin Fowler, calls this technique 'Feature Toggles', and wrote a foundational definition (see refs below). 
Feature Flags is in wider use by the industry, though, so we're going with that.
{{< /note >}}
-->

{{< note title="標誌即為開關" >}}
行業權威 Martin Fowler 將此技術稱為「功能切換」，並撰寫了一個基礎定義（參見下面的參考資料）。不過，「功能標誌」在業界中更廣泛地使用，所以我們採用這個術語。
{{< /note >}}

<!--
## Granularity

It could be that the flag controls something large like the UI of a component. In our case above we could say that 
`OneClickPurchasing` and `ShoppingCart` are the names of components.  It could be that the granularity of the flag
is much smaller - Say Americans want to see temperatures in degrees Fahrenheit and other nationalities would 
prefer degrees Centigrade/Celsius. We could have a flag `--temp=F` and `--temp=C`. For fun, the developers also added
`--temp=K` (Kelvins).
-->

## 細緻度

功能標誌可以控制著如 UI 元件這樣的大型功能。在我們上述的例子中，可以說 `OneClickPurchasing` 和 `ShoppingCart` 是元件的名稱。功能標誌的細微程度可能更小——例如，美國人希望看到的溫度單位是華氏，而其他國家的人可能偏好攝氏。我們可以設定一個標誌 `--temp=F` 和 `--temp=C`。為了趣味，開發者還加入了 `--temp=K`（Kelvins 凱爾文）。

<!--
## Implementation

For the `OneClickPurchasing` and `ShoppingCart` alternates, it could be that a `PurchasingCompleting` 
abstraction was created. Then at the most primordial boot place that's code controlled, the `--withOneClickPurchase` flag
is acted upon:
-->

## 實作

對於 `OneClickPurchasing` 和 `ShoppingCart` 的替代方案，可能會建立一個抽象的 `PurchasingCompleting` 類別。然後，在由程式碼控制的最初啟動點，執行 `--withOneClickPurchase` 標誌。

<!--
Java, by hand:
-->

Java 手動寫法：

```java
if args.contains("--withOneClickPurchase") {
  purchasingCompleting = new OneClickPurchasing();
}
```

<!--
Java Dependency Injection via config:
-->

透過設定實現 Java 依賴注入寫法：

```java
bootContainer.addComponent(classFromName(config.get("purchasingCompleting")));
```

<!--
There are many more ways of passing flag intentions (or any config) to a runtime.  If you at all can, you want to 
 avoid if/else conditions in the code where a path choice would be made. Hence our emphasis on an abstraction.
-->

還有很多方法可以將標誌意圖（或任何設定）傳遞給執行時的環境。如果可能的話，你應該避免在程式碼中使用 if/else 條件來進行路徑選擇。因此，我們強調使用抽象。

<!--
## Continuous Integration pipelines

It is important to have CI guard your reasonable expected permutations of flags. That means tests that happen on an
application or service after launching it, should also be adaptable and test what is meaningful for those flag 
permutations. It also means that in terms of CI pipelines there is a fan-out **after** unit tests, for each meaningful
flag permutation. A crude equivalent is to run the whole CI pipeline in parallel for each meaningful flag permutation.
That would mean that each commit in the trunk kicks off more than one build - hopefully from elastic 
infrastructure.
-->

## 持續整合流水線

在持續整合中保護你合理預期的功能標誌排列組合是非常重要的。這表示在應用程式或服務啟動後，應具有適應性，針對那些功能標誌的排列組合進行有意義的測試。這也意味著在持續整合流水線中，在單元測試**之後**會展開每一個有意義的功能標誌排列組合的測試。一個粗略的方法是對每個有意義的功能標誌排列組合並行運行整個持續整合流水線。這將意味著主幹中的每次提交都觸發至少一次的建置——希望這些建置能來自於彈性的基礎設施。

<!--
## Runtime switchable

Sometimes flags set at app launch time is not enough. Say you are an Airline, selling tickets for flights online.
You might also rent out cars in conjunction with a partner - say 'Really Cool Rental Cars' (RCRC). The connection to 
any partner or their up/down status is outside your control, so you might want a switch in the software that works 
without relaunch, to turn "RCRC partner bookings" on or off, and allow the 24&#47;7 support team to flip it if certain 'Runbook' conditions
have been met.  In this case, the end users may not notice if Hertz, Avis, Enterprise, etc are all still amongst
the offerings for that airport at the flight arrival time.
-->

## 可在運行時切換

有時候，僅在應用程式啟動時設定功能標誌是不足夠的。假設你經營一家航空公司，在網路上銷售機票。你可能還會與合作夥伴一起出租汽車——比方說「非常酷的租車公司」（Really Cool Rental Cars，RCRC）。對任何合作夥伴的連接或其上線/下線狀態都不在你的控制範圍內，因此你可能會希望在應用程式中設置一個不需要重新啟動就能運作的開關，以開啟或關閉「RCRC 合作夥伴預訂」，並允許 24&#47;7 支援團隊依據「操作手冊」在滿足特定操作條件時切換標誌。在這種情況下，最終使用者可能不會注意到在抵達機場時，像 Hertz、Avis、Enterprise 等其他知名租車公司是否在航空公司所提供的服務範圍之內。

<!--
Key for Runtime switchable flags is the need for the state to persist. A restart of the application or service should
not set that flag choice back to default - it should retain the previous choice. It gets complicated when you think
about the need for the flag to permeate multiple nodes in a cluster of horizontally scaled sibling processes. For
that last, then holding the flag state in Consul{{< ext url="https://www.consul.io" >}}, 
Etcd{{< ext url="https://github.com/coreos/etcd" >}} (or equivalent) is the modern way.
-->

運行時可切換標誌的關鍵在於狀態的持久性。應用程式或服務的重啟不應該將該標誌選擇重置為預設值，標誌應該保留之前的選擇。當考慮到標誌需要擴散至水平擴展的集群中多個節點時，情況會變得複雜。對於這種情況，將標誌狀態保存在 Consul{{< ext url="https://www.consul.io" >}} 或 Etcd{{< ext url="https://github.com/coreos/etcd" >}} （或其他類似服務）已是現代的做法。

<!--
## Build Flags

Build flags affect the application or service as it is being built. With respect to the `--withOneClickPurchase` flag again,
the application would be incapable at runtime of having that capability if the build were not invoked with the suitable
flag somehow.
-->

## 建置標誌

建置標誌會在應用程式或服務建置時影響其功能。再次以 `--withOneClickPurchase` 標誌為例，如果在建置過程中未以適當的方式引入該標誌，應用程式在執行時將無法具備相應的功能。

<!--
## A/B testing and betas

Pushing code that's turned off into production, allows you to turn it on for ephemeral reasons - you want a subset of 
users to knowingly or unknowingly try it out. A/B testing (driven by marketing) is possible with runtime flags. So is 
having beta versions of functionality/features available to groups.
-->

## A/B 測試與測試版本

將已關閉的程式碼推送至正式環境後，允許你可以因為短暫的原因啟用功能——你希望部分使用者在知情或不知情的情況下進行試用。透過運行時標誌（runtime flags）讓 A/B 測試（由行銷驅動）能夠順利進行。同樣地，也可以向特定群組提供功能的測試版本。

<!--
## Tech Debt - pitfall

Flags get put into codebases over time and often get forgotten as development teams pivot towards new business deliverables.
Of course, you want to wait a while until it is certain that you are fixed on a toggle state, and that's where the 
problem lies - the application works just fine with the toggle left in place, and the business only really cares
about new priorities. The only saving grace is the fact that you had unit tests for everything, even for code that
is effectively turned off in production. Try to get the business to allow the remediation of flags (and the code
they apply to) a month after the release. Maybe add them to the project's readme with a "review for delete" date.
-->

## 技術債務 - 陷阱

隨著時間的推移，功能標誌會被新增到程式碼中，隨著開發團隊轉向新的業務交付目標時，這些功能標誌經常會被遺忘。當然，你會想等待一段時間，直到確定已經穩定的在某個切換狀態，這就是問題所在——應用程式在切換狀態保持不變的情況下仍然運作良好，而業務部門實際上更關注的是新的業務優先事項。唯一的救贖是，你為所有程式碼，甚至是在正式環境中實際上已被關閉的程式碼都編寫單元測試。試圖說服業務部門同意在發布後一個月內修正標誌（及相關程式碼），或許可以在專案的 readme 中紀錄標誌「審查刪除」的日期。

<!--
## History

Some historical predecessors of feature toggles/flags as we know it today:  
-->

## 歷史

以下是一些我們今天所熟知的功能標誌的歷史前身：

- Unified Versioning through Feature Logic (Andreas Zeller and Gregor Snelting, 1996){{< ext url="http://www.cs.tufts.edu/~nr/cs257/archive/andreas-zeller/tr-96-01.pdf" >}} - white paper.
- Configuration Management with Version Sets: A Unified Software Versioning Model and its Applications (Andreas Zeller's, 1997){{< ext url="https://www.st.cs.uni-saarland.de/publications/files/zeller-thesis-1997.pdf" >}} - Ph.D. thesis.

<!--
There's a warning too: 
-->

同時也有一個警告： 

- "#ifdef considered harmful" (Henry Spencer and Geoff Collyer, 1992){{< ext url="http://www.literateprogramming.com/ifdefs.pdf" >}} - white paper.

<!--
Brad Appleton says:
-->

Brad Appleton 說道︰

<!--
<br><div style="padding-left: 45px; padding-right: 45px"><span style="font-size: 150%">&ldquo;</span>
The thing I do not like about feature-toggles/flags is when they end up NOT being short-lived as intended, 
and we end up having to revisit Spencer and Collyer's famous paper. The funny thing is feature-branches 
started out the same way. When they were first introduced it was for feature-teams using very large features, and the 
purpose of the separate branches was because too many people were trying to commit at the same time to the same branch. 
So the idea was use separate branches (for scale) and teams would integrate to their team-branch daily or more often 
WITH at least nightly integration across all feature-branches [sigh].
</div>
-->

<br><div style="padding-left: 45px; padding-right: 45px"><span style="font-size: 150%">&ldquo;</span>
我不喜歡功能標誌的一點是，這些標誌常常**並非**如預期那樣短暫存在，最終我們不得不重新討論斯賓塞和科利爾的著名論文。有趣的是，功能分支最初也是如此。當功能分支概念最初被引入時，是為了應對開發非常大的功能的團隊需求，而獨立分支之所以設立，是因為太多人同時嘗試向同一分支提交。因此，目的是使用獨立的分支（用於擴展），並且團隊會每天或更頻繁地與他們的團隊分支進行整合，**並**至少每晚在所有的功能分支之間進行一次整合。[嘆氣]
</div>

<!--
# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>
-->

# 其他參考資料

<a id="showHideRefs" href="javascript:toggleRefs();">顯示其他參考</a>

<div>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">29 Oct 2010, MartinFowler.com article</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://martinfowler.com/bliki/FeatureToggle.html">Feature Toggle</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">30 May 2011, TechCrunch article</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://techcrunch.com/2011/05/30/facebook-source-code">The Next 6 Months Worth Of Features Are In Facebook's Code Right Now, But We Can't See</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">19 Jun 2013, Slides from a talk</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://www.slideshare.net/cb372/branching-strategies">Branching Strategies: Feature Branches vs Branch by Abstraction</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">10 Oct 2014, Conference Talk</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://www.perforce.com/merge/2014-sessions/trunk-based-development-enterprise-its-relevance-economics">Trunk-Based Development in the Enterprise - Its Relevance and Economics</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">08 Feb 2016, MartinFowler.com article</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://martinfowler.com/articles/feature-toggles.html">Feature Toggles</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">23 May 2017, DevOps.com article</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://devops.com/feature-branching-vs-feature-flags-whats-right-tool-job/">Feature Branching vs. Feature Flags: What’s the Right Tool for the Job?</a></td>
        </tr>
    </table>
    
</div>
