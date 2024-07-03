---
date: 2016-05-06T19:56:50+01:00
title: 從主幹發布
weight: 56
---

<!--
Teams with a very high release cadence do not need (and cannot use) release branches at all. They have to release from
the trunk.

![](release_from_trunk.png)
([key](/key/))
-->

發布節奏非常高的團隊根本不需要（也無法使用）發布分支。他們必須從主幹發布。

<img srcset="release_from_trunk.png 1x,release_from_trunk@2x.png 2x">([分支圖示的說明](/key/))

<!--
It is most likely that such teams do not use a Dewey-decimal release numbering scheme, and instead have something
referent to the commit number or date and time.  They probably also choose to roll forward and fix the bug on the
trunk as if it were a feature, albeit as quickly as possible.
-->

這些團隊很可能不會使用杜威十進位版本號方案，而是採用與提交號碼或日期時間有關的方案。他們可能會選擇向前推進，並在主幹上修復錯誤，像處理新功能一樣快速地進行修復。

<!--
Here's what stylized commits look like:

![](release_from_trunk2.png)
([key](/key/))
-->

提交的風格像看起來像是：

![](release_from_trunk2.png)
([分支圖示的說明](/key/))

<!--
No slow down around a release and bug fixes inline.

Teams with one release a day (or less) **might** still make a branch, to cherry-pick the bug-fix to
and release from:

![](release_from_trunk3.png)
([key](/key/))
-->

發布過程中不會被拖延，錯誤修復會在流程中同步進行。

每天（或更少）發布一次的團隊**或許**仍然會建立一個分支，以便挑選錯誤修復並從該分支發布：

![](release_from_trunk3.png)
([分支圖示的說明](/key/))

<!--
{{< note title="Branches can be made retroactively" >}}
Newbies to source-control systems often forget that you don't have to make a branch because you think you might need
it in the future. For any source-control technology made today, you can choose the revision in the past to branch
from. The outcome is exactly the same as if you had made it at the time.
{{< /note >}}
-->

{{< note title="分支可以事後建立" >}}
新手經常會忘記，使用原始碼版本控制系統時，不必因為覺得將來可能會需要而建立一個分支。對於任何現代原始碼版本控制技術，你都可以選擇從過去的某個修訂版本開始新分支。這樣的結果與當時就建立分支是完全相同的。
{{< /note >}}
