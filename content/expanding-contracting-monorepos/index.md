---
date: 2016-11-02T20:08:11+01:00
title: 擴大或是收縮單一版本庫
weight: 112
---
 
<!-- 
At some point with a monorepo approach to source control (especially with binary dependencies in the source tree), your checkouts 
could be bigger than your local workstation's hard drive. Or even if the checkout is not too big for your hard drive, 
then it might be too much for your IDE, and you do not want to have to abandon it for Vim/Emacs. Or maybe it is not your IDE that 
chokes but rather is something about the build that's too much locally, despite command-line arguments to attempt to
pare it down for a shorter elapsed time.
-->

在某些時候，使用單一版本庫的方式來做原始碼管理（特別是在原始碼樹有二進位相依性），你的 checkout 資料大小可能比你工作電腦的硬碟空間還要大。或者，雖然這個 checkout 對你的工作電腦的硬碟空間來說不大，但對你使用的 IDE 來說太大，並且你不希望為了 Vim/Emacs 的關係放棄這個 checkout。另一種情況是，不是你的 IDE 因為 checkout 太大導致 IDE 卡住 ，而是因為本機的建置太多，儘管已經使用命令列參數試圖將 checkout 縮減以獲得更短的過程時間。

<!--
There is a way to intelligently expand or contract the checkout on your developer workstation, to alleviate all of 
the above.
-->

有一種方法可以智慧地擴大或縮小在你工作機器上的 checkout，以緩解上述所有問題。

## Gcheckout.sh

<!--
Google's in-house DevOps uses some simple scripting to
modify the checkout on the developer's workstation to omit the source files/packages that are not needed for the 
current intentions of the developer. This Blaze related technology is a shell command called 'gcheckout'. It can modify the mappings between the multi-gigabyte HEAD 
revision of company-wide trunk (monorepo) and developer's own workstation. Thus the source-control tools maintain the 
**smallest possible subset** of the monorepo on the developer's workstation, for them to perform their daily work. 
Google and the industry refer to the general feature as 'sparse checkout'.
-->

Google 內部的 DevOps 使用一些簡單的腳本來修改開發者工作電腦上的 checkout，用來從 checkout 移掉一些與開發者開發功能無相關的原始碼檔案以及套件。這個與 Blaze 相關的技術是一個叫作「gcheckout」的 shell 指令。它能調整公司主幹（單一版本庫）的最新版本（其內容大小可能達到數 GB）與開發者工作電腦上的對應關係。因此，原始碼管理工具在開發者工作電腦上維護單一版本庫的**最小子集合**，以便開發者日常工作。Google 以及業界將這個通用性功能稱為「Sparse checkout」。

<!--
You can run `gcheckout` at any time to modify your sparse checkout to be bigger or smaller (or wholly different) for 
different reasons. All of those are operations on your local representation of a larger trunk.
-->

你可以隨時運行 `gcheckout` 來修改你的 sparse checkout，讓 checkout 根據不同的目的來變大或是變小（或完全不同）。所有這些操作都是針對在你的本機上大型主幹紀錄做執行。

<!--
## Contrived example of use
-->

## 人為操作的使用範例

<!--
We detailed two intentions for directed graph build systems above, using a contrived application. Here is one more:

* I now want to change `TheORMweBothDependOn`, because a change to `MyTeamsApplication` requires me to do that.

In Google, rather than feed into the backlog of the team that maintains `TheORMweBothDependOn` (which may exist as a part-time 
committee rather than a team), the developer in question would make the change themselves. Perhaps they had made 
it in the same commit as the first usage of it for `MyTeamsApplication`.  In the code review cycle (Google practices
common code ownership), the approvers for the `TheORMweBothDependOn` would see all the changes together. The larger change is
all accepted or rejected (to be remediated) atomically.

So our developer was working on `MyTeamsApplication`, which depended on `TheORMweBothDependOn` (which probably transitively 
depended on other things). Now that developer is going to change `TheORMweBothDependOn` and that impacts `TheirApplication` 
too. The Blaze related checkout-modifying technology 'gcheckout' performs an expansion to bring in `TheirApplication` to the
developer's checkout. From that moment on, the developer doing update/pull/sync will bring down minute by minute
changes to those three modules.  For free, the build expands to make sure that the `TheORMweBothDependOn` changes do not 
break either of `MyTeamsApplication` or `TheirApplication`.
-->

我們在上面使用了人為的應用詳細說明有向圖建置系統的兩個意圖。這邊再提供一個範例：

* 我現在因為一個對於 `MyTeamsApplication` 的修改，導致需要修改 `TheORMweBothDependOn`

在 Google 內部，與其會把上面的修改需求放到維護 `TheORMweBothDependOn` 團隊的待辦事項（通常可能是一個臨時的委員會而不是一個固定的團隊），要修改需求的開發者會選擇自己修改。也許他們在第一次使用 `MyTeamsApplication` 的同一次 commit 就已經進行了修改。在程式碼審核的週期中（Google 實踐了共有程式碼所有權），對於 `TheORMweBothDependOn` 功能的審核人將會一起查看所有變更。這些更大的改動將會全部一起被接受或是全部一起被拒絕（被修復）。

所以當我們的開發者在處理 `MyTeamsApplication` 這個依賴於 `TheORMweBothDependOn` 功能模組（這個可能間接地依賴於其他東西）。現在開發者將要修改 `TheORMweBothDependOn` 也將會影響到 `TheirApplication`。與 Blaze 相關的修改 checkout 技術「gcheckout」執行擴大，將 `TheirApplication` 加入開發者的 checkout 。從這刻起，進行更新或拉取或者同步的開發者將會每分鐘逐步把這以上三個模組的變更下載到自己的工作電腦。免費的建置擴充版本確保 `TheORMweBothDependOn` 的變更不會破壞 `MyTeamsApplication` 或 `TheirApplication` 的功能。

<!--
### Directory structure and working copy.

If I ran `gcheckout` with MyTeamsApplication+TheirApplication as the parameter I would get working copy that looked like:
-->

### 資料夾結構以及工作區副本

如果我把 MyTeamsApplication+TheirApplication 當參數執行 `gcheckout`，我會在工作區副本得到以下結構：

```txt
root/
  java/
    BUILD
    com/
      BUILD
      google/
        BUILD
        myteamsapplication/
          BUILD
          MyTeamsApplication.java  // and hundreds of other packages and source files
        theirapplication/
          BUILD
          TheirApplication.java  // and hundreds of other packages and source files
        theormwebothdependon/
          BUILD
          TheORMweBothDependOn.java  // and hundreds of other packages and source files
  java_test/
    BUILD
    com/
      BUILD
      google/
        BUILD
        myteamsapplication/
          BUILD
          MyTeamsApplicationTest.java  // and hundreds of other packages and source files
        theirapplication/
          BUILD
          TheirApplicationTest.java  // and hundreds of other packages and source files
        theormwebothdependon/
          BUILD
          TheORMweBothDependOnTest.java  // and hundreds of other packages and source files
```

<!--
If I ran `gcheckout` with MyTeamsApplication as the parameter I would get working copy that looked like:
-->

如果我把 MyTeamsApplication 當參數執行 `gcheckout`，我會在工作區副本得到以下結構：

```txt
root/
  java/
    BUILD
    com/
      BUILD
      google/
        BUILD
        myteamsapplication/
          BUILD
          MyTeamsApplication.java  // and hundreds of other packages and source files
        theormwebothdependon/
          BUILD
          TheORMweBothDependOn.java  // and hundreds of other packages and source files
  java_test/
    BUILD
    com/
      BUILD
      google/
        BUILD
        myteamsapplication/
          BUILD
          MyTeamsApplicationTest.java  // and hundreds of other packages and source files
        theormwebothdependon/
          BUILD
          TheORMweBothDependOnTest.java  // and hundreds of other packages and source files
```

<!--
If I ran `gcheckout` with TheORMweBothDependOn as the parameter I would get working copy that looked like:
-->

如果我把 TheirApplication 當參數執行 `gcheckout`，我會在工作區副本得到以下結構：

```txt
root/
  java/
    BUILD
    com/
      BUILD
      google/
        BUILD
        theormwebothdependon/
          BUILD
          TheORMweBothDependOn.java  // and hundreds of other packages and source files
  java_test/
    BUILD
    com/
      BUILD
      google/
        BUILD
        theormwebothdependon/
          BUILD
          TheORMweBothDependOnTest.java  // and hundreds of other packages and source files
```

<!--
You can keep rerunning the `gcheckout` to expand or contract your working copy to meet your current goals.
-->

你可以持續重新執行 gcheckout，來擴大或縮小你的工作副本，以滿足你當前的目標。

<!--
## Contrived example of use #2

We used 'change the wheel on a car', on the [Branch By Abstraction](/branch-by-abstraction/) page for its contrived 
example. It will serve us again here. The wheel is what we want to change. The other team using 'Wheel(s)' is making a 
Segway thing (two wheels and self-balancing via high-torque and very responsive motors). Here's the procedure:

![](car_segway.png)  
-->

## 人為操作的使用範例 #2

我們在[抽象分支](/branch-by-abstraction/)頁面使用「幫車子換輪子」當作人為操作範例。這邊我們再度使用這個例子。車輪就是我們想要更改的東西。另一個正在使用「輪子」的團隊正在製作一種 Segway 產品（兩個輪子，並通過高扭矩和非常靈敏的馬達自我平衡）。以下是流程：

<p><img srcset="car_segway.png 1x,car_segway@2x.png 2x"></p>
 
<!-- 
The starting position is two teams working separately, using 'Wheel' (4 for cars, 2 for Segways). Without any commits 
happening the engineer changing 'Wheel' for everyone, runs gcheckout (or its equivalent) to modify the source in the 
IDE to the union of Car and Segway (and in-house dependencies). That is marked as step 0. Let us say the
change is quick/easy this time (not requiring Branch By Abstraction) step 1 shows the single commit that changes
the wheel implementation for everyone.  After the commit/push, running again shows the application focused team checkout - either 
'Car' or 'Segway'.
 
-->

起始位置是兩個團隊分別工作，使用「輪子」（汽車使用 4 個，Segways 使用 2 個）。再還沒有任何 commits 的情況下，為了所有人改變「輪子」的工程師，執行 gcheckout（或者其他類似的工具），將 IDE 中的源始碼修改為汽車和 Segway（以及內部依賴項）的聯集。這個被標為步驟 0，變更很快或很容易（不需要使用 Branch By Abstraction），步驟 1 顯示了改變所有人輪子的單次 commit。在這次 commit 或是 push 之後，再度運行將顯示出現在應用團隊所專注的 checkout — 可能是「汽車」或是「Segway」。

<!--
## Git's Sparse checkouts

Git has a 'sparse checkout' capability, which exactly facilitates this sort of thing. Subversion and Mercurial do too.  
Perforce has a 'client spec' capability that is more or less the same. A team wanting to have their own gcheckout equivalent
would have some scripting around sparse checkouts (or equivalent). 
-->
 
## Git 的 Sparse checkout

Git 有一個「sparse checkout」功能，確實有助於實現這種情況。Subversion 與 Mercurial 也有類似的功能。Perforce 則具有一個「client spec」功能，能達到類似的效果。一個團隊若想要擁有自己的 gcheckout 等效工具，則需要圍繞稀疏 checkout（或相應的功能）進行一些腳本編寫。

<!--
### Using Git this way today

If you're willing to go a 'split history' maneuver on your monorepo once or twice a year, Git can do the expandable and 
contractible monorepo setup today. 
-->

### 現在使用 Git 的這種方法

如果你願意每年願意對你的單一版本庫進行一兩次「分割歷史」的操作，Git 今天就可以實現可擴大和可收縮的單一版本庫設置。

<!--
## Perforce's client-specs

Perforce has a 'client spec' (alternatively 'view') that is accessed via the client command or UI. Amongst other things, it 
allows a checkout to be a subset of the directories/files available within the branch. A list of globbed includes and 
excludes is the format. You would script this (as Google did until 2012) to have a directed graph driven 
expandable/contractible checkout.
-->

## Perforce 的 client-spec

Perforce 具有一個「client spec」功能（或是稱為「view」），可以通過客戶端命令或 UI 存取。除了其他功能外，這個工具允許一個 checkout 可以是該分支可用資料夾或檔案的子集合。格式為包含和排除的全局列表。你可以編寫腳本（如同 Google 在 2012 之前做的那樣），用來產生一個基於有向圖的可擴大及可收縮的 checkout。

<!--
## PlasticSCM's cloaked.conf

As Perforce, but via 'cloaked.conf' file.
-->

## PlasticSCM 的 cloaked.conf

如同 Perforce，但由透過「cloaked.conf」檔案達成。

<!-- 
## Subversion's sparse-checkouts

Subversion has a 'sparse checkout' capability. You do a series of checkout operations at various directory levels in order
to create the mapping, so is less atomic or centrally configured than the others.  They have made also made a 'viewspec' script
{{< ext url="http://svn.apache.org/repos/asf/subversion/trunk/tools/client-side/svn-viewspec.py" >}}
to allow the reshaping of the working copy to happen in a more declarative way.
-->

## Subversion 的 sparse-checkouts

Subversion 有一個「sparse checkout」功能。你需要在不同階層資料夾執行一系列的 checkout 操作，來產生對應，因此，比其他工具比較不具有操作原子性與統一設定。他們還制作了一個「viewspec」腳本 {{< ext url="http://svn.apache.org/repos/asf/subversion/trunk/tools/client-side/svn-viewspec.py" >}} ，以更具聲明性的方式允許對工作副本進行重塑。
