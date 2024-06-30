---
date: 2016-07-01T20:10:46+01:00
title: 持續交付
weight: 71
---

<!--
Continuous Delivery is the practice expanding your Continuous Integration (CI) usage to automatically
re-deploy a proven build to a QA or UAT environment. If the bounce time for a deployment is quick enough,
then it could be that you are doing that for every commit that lands in the shared trunk. The Radiator's pipeline view would 
become:

![](pipelines2.png)
-->

持續交付（Continuous Delivery）是一種做法，它延伸了持續整合（CI）的應用，以自動地將經過驗證的建置版本重新部署到 QA 或 UAT 環境中。如果部署的恢復時間足夠快，那麼對於每一次提交到共享主幹的更改，都可以進行這樣的操作。在這種情況下，Radiator 的流水線視圖將變為：

<p><img srcset="pipelines2.png 1x,pipelines2@2x.png 2x"></p>

<!--
The [bestselling book of the same name](/publications/index.html#continuous-delivery-july-27-2010) by Jez Humble and Dave Farley, 
details the 'marching orders' for many companies, where there is whole dev-team improvement agenda.
-->

<!--
{{< warning title="A Layer above Trunk-Based Development" >}}
Continuous Delivery is a broad multifaceted subject, that sits on top of Trunk-Based Development as a practice. This
website and this page, in particular, is not going to give it justice. Head on over to 
`ContinuousDelivery.com`{{< ext url="https://continuousdelivery.com" >}} and understand too that "lean experiments" are the part 
of CD and not so much the concern of Trunk-Based Development.
{{< /warning >}}
-->

{{< warning title="以主幹開發為基礎" >}}
這本由 Jez Humble 和 Dave Farley 共同撰寫的暢銷書《Continuous Delivery》，詳細說明了許多公司的做法，其中包含了整個開發團隊的改進計畫。持續交付是一個很廣泛的主題，它以主幹開發的實作為基礎。 本網站及此頁面對其介紹可能不夠全面。可以前往 `ContinuousDelivery.com`{{< ext url="https://continuousdelivery.com" >}} 深入了解，並要注意「精實實驗」是持續交付的一部分，而非主幹開發的主要關注點。
{{< /warning >}}

<!--
## Continuous Deployment

**An automatic push all the way into production; Maybe every commit**

This is an extension of 'Continuous Delivery', but the deployment is to production. Certain types of startups like 
Netflix, Etsy and GitHub deploy their major application to production with each commit. Companies that have 
applications/services where  clients/customers could lose money are much less likely to *firehose into production*.
-->

## 持續部署

**自動推送到正式環境；或許每次提交都會進行**

這是「持續交付」的延伸，指部署到正式環境。像 Netflix、Etsy 和 GitHub 這樣的某些類型的初創公司會在每次提交時將其主要應用部署到正式環境。那些擁有可能直接導致客戶損失金錢服務的公司，則不太可能*大量直接部署到正式環境*。

<!--
# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>
-->

# 其他參考資料 {#references-elsewhere}

<a id="showHideRefs" href="javascript:toggleRefs();">顯示參考資料</a>

<div>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">2010, Jez Humble's Continuous Delivery portal</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://continuousdelivery.com/">ContinuousDelivery.com</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">5 Jan 2015, TheGuardian newspaper on their CD</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://www.theguardian.com/info/developer-blog/2015/jan/05/delivering-continuous-delivery-continuously">Delivering Continuous Delivery, continuously</a></td>
        </tr>
    </table>
</div>



