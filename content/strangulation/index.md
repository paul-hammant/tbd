---
date: 2016-07-08T20:08:11+01:00
title: 應用程式的絞殺策略
weight: 78
---

<!--
Strangulation is a mechanism by which a very large disruptive change is made in an application or service that, does not
disrupt its ability to go live, even while partially complete.  Martin Fowler named this practice (see references below)
after the strangler vines that creep up existing trees, in order to steal sunlight at canopy level of a jungle.
-->

應用程式的絞殺是一種機制，通過這種機制可以在應用程式或服務中進行非常大的、會引起混亂的變更，而不會影響其上線的能力，即使這些變更只完成了一部分。Martin Fowler 以爬上現有樹木、在叢林的樹冠層偷取一絲陽光的藤蔓命名了這種作法（見下方參考資料）。

<!--
The trick is to have a mechanism to route invocations of logic between the old and new solutions for the same. Say 
you are an Airline, and you had written your first online purchasing experience in Perl. You're now wanting to 
do 'Elixir' and its web framework 'Phoenix'.  
-->

訣竅在於有一個機制，能夠在舊的解決方案和新的解決方案之間去指揮路由的呼叫。比如說你是一家航空公司，你的第一個線上購買體驗服務是用「Perl」開發的。現在你想要使用「Elixir」以及其框架「Phoenix」。

<!--
Strangulation is where you would use the Apache server that you doubtless had 
fronting Perl, to **conditionally** route HTTP requests to Erlang/Elixir/Phoenix. Say your first completed milestone
was 'Loyalty Account View/Edit' you would route based on the URLs the browser was seeking pages for. Obviously 
agreeing on URLs (and cookies) is key for the old Perl and new Elixr app. So is deployment in lockstep.

At some point in the strangulation, you might put Elixir in front Apache/Perl and have traffic drop through to it 
instead. That is the residual situation before you delete the last lines of code of Perl and snip that delegation
when the strangulation is complete.

This relates a little to [Branch by Abstraction](/branch-by-abstraction/). Strangulation is a strategy for 
incompatible languages (they are not in the same process), whereas Branch by Abstraction is where the 'from' and 'to' 
languages are the same (say Java -> Java), or compatible (Java -> Scala).
-->

絞殺策略是指你會使用 Apache 服務器作為 Perl 的前端，**有條件地**將 HTTP 請求路由到 Erlang、Elixir 或 Phoenix。比如說，你完成的第一個里程碑是「忠誠賬戶查看或編輯」，你會根據瀏覽器請求的 URL 來進行路由。顯然，對於舊的 Perl 應用和新的 Elixir 應用來說，對 URL（和 cookies）達成共識是關鍵，同步部署也是必要的。

在絞殺過程的某一點上，你可能會將 Elixir 置於 Apache 或 Perl 之前，讓流量轉而通過它。這是在刪除 Perl 最後幾行程式碼並在絞殺過程完全完成時終止那一委派之前的過渡狀態。

這與[抽象分支](/branch-by-abstraction/)有些相關。絞殺是針對不兼容語言的策略（因為它們不再同一個處理程序中），而抽象分支適用於「從」一種語言轉換「到」相同（例如 Java -> Java）或兼容的語言（Java -> Scala）。

<!--
# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>
-->

# 其他參考資料

<a id="showHideRefs" href="javascript:toggleRefs();">顯示參考資料</a>

<div>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">29 Jun 2004, MartinFowler.com article</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://www.martinfowler.com/bliki/StranglerApplication.html">Application Strangulation</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">17 Jan 2006, Blog Entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://scottmark.wordpress.com/2006/01/17/great-architects-are-also-stranglers/">Great Architects Are Also Stranglers</a></td>
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
</div>
