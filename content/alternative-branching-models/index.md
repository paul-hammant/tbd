---
date: 2016-10-01T20:08:11+01:00
title: 替代的分支模型
weight: 101
---

<!--
{{< quote title="Branch: only when necessary, on incompatible policy, late, and instead of freeze" >}}
<span>&mdash; Laura Wingerd & Christopher Seiwald</span><br>
<span style="margin-left: 30px">(1998's High-Level SCM Best Practices white paper from Perforce)</span>
{{< /quote >}}
-->

{{< quote title="分支：僅在必要時建立，遇到不相容的政策或已經過期時，選擇建立分支而不是凍結版本。" >}}
<span>&mdash; Laura Wingerd & Christopher Seiwald</span><br>
<span style="margin-left: 30px">( 1998 年的 Perforce 高層次 SCM 最佳實踐白皮書)</span>
{{< /quote >}}

<!--
## Modern claimed high-throughput branching models
-->

## 現代主張的高吞吐量分支模型

### GitHub Flow

<!--
This is sooooo close to PR-centric Trunk-Based Development. Why? Because it is a branching model that has individual
developers active concurrently in more than one (short-lived) branch (or fork). Or developer pairs, rather than
individuals.

The crucial difference is **where** the release is performed from.

The GitHub flow thing showing a release-from-branch step, before the merge back to the main (trunk):

![](githubflow1.png)
([key](/key/))
-->

這與以 PR 為中心的主幹開發非常接近。為什麼呢？因為這是一種分支模型，其中個別開發者或者是配對開發者同時在多個（短暫存在的）分支（或 fork）中活動。

關鍵的區別在於**從哪裡**進行發布。

GitHub Flow 顯示的是在合併回主幹之前從分支進行發布的步驟：

<img srcset="githubflow1.png 1x,githubflow1@2x.png 2x">([分支圖示的說明](/key/))

<!--
One problem with this is the small risk of regression in the following release - that would be if the release goes out, but 
the branch is never merged back. Another is that it may indeed not have items in it from the trunk that were part of a 
previous release (actually causing a regression).

As the GitHub documentation portrays, review comments are part of the process. They are the speech
bubbles in timeline above followed by another commit, which presumably addressed the review feedback. 

How Trunk-Based Development modifies the GitHub Flow model:

![](../5-min-overview/trunk_pr.png)
([key](/key/))
-->

這裡存在一個問題，那就是如果新版本已經推出，但相應的分支沒有及時合併回主幹，那麼下一個版本可能會小概率出現錯誤重新出現的問題。還有一點是，分支中可能缺少主幹上原本應有的某些東西，這些東西是之前版本中的一部分（這種情況實際上也會造成錯誤重新出現）。

就像 GitHub 文件中所說的，審查評論是流程的一部分。評論在時間線上像對話氣泡一樣出現，之後會有另一個提交，這個提交通常是用來回應審查意見的。

主幹開發如何修改 GitHub Flow 模型：

<img srcset="../5-min-overview/trunk_pr.png 1x,../5-min-overview/trunk_pr@2x.png 2x">([分支圖示的說明](/key/))

<!--
After the dust has settled, and the [short-lived feature branch](/short-lived-feature-branches/) has been deleted, the commits are not smushed together
in a bigger one (as would be the case Subversion and Perforce), they instead zip into their respective places in the
commit history, which is not as linear as we present here:

![](githubflow3.png)
([key](/key/))
-->

當一切塵埃落定，[短期功能分支](/short-lived-feature-branches/)被刪除後，提交的記錄不會像在 Subversion 和 Perforce 中那樣被合併成一個更大的提交。相反，它們會各自排列在提交歷史中的相應位置，這樣的提交歷史並不像我們在這裡展示的那樣線性：

<img srcset="githubflow3.png 1x,githubflow3@2x.png 2x">([分支圖示的說明](/key/))

<!--
Of course, if you rebase/squash your series of commits, they could land in the trunk as a single commit.  Also note that
the review commentary is still available after the branch is deleted, as it should be.  

See the GitHub Flow landing page for more{{< ext url="https://guides.github.com/introduction/flow/" >}}
-->

當然，如果你將一系列提交進行 rebase 或合併（squash），它們可以作為一個單一的提交進入主幹。而且，即使分支被刪除，審查評論也會保留下來。

請參見 GitHub Flow 的登陸頁面了解更多資訊{{< ext url="https://guides.github.com/introduction/flow/" >}}。

<!--
### GitFlow and similar

Git Flow is incompatible with Trunk-Based Development.

There are plenty of people in the modern age that swear by this model, and feel it has plenty of room to scale with few
downsides. It is a branching model that has **groups** of developers active concurrently in more than one branch (or fork).

![](gitflow.png)
([key](/key/))
-->

### GitFlow 及類似流程

GitFlow 是與主幹開發相互矛盾的。

在現代，有許多人推崇這種模型，認為它有很大的擴展空間，並且幾乎沒有缺點。這是一種分支模型，能讓一組開發者可以同時在多個分支（或分叉）上進行活動

<img srcset="gitflow.png 1x,gitflow@2x.png 2x">([分支圖示的說明](/key/))

<!--
- Diagram copied from Vincent Driessen's 2010 article on GitFlow: "A successful Git branching model"{{< ext url="http://nvie.com/posts/a-successful-git-branching-model" >}}

It looks like you'll not be able to do [concurrent development of consecutive releases](/concurrent-development-of-consecutive-releases/)
with this branching model, or the hedging that [Feature Flags](/feature-flags/) and [Branch by Abstraction](/branch-by-abstraction/)
enable.
-->

- 從 Vincent Driessen 2010 年的文章 *A successful Git branching model* 中複製的圖表{{< ext url="http://nvie.com/posts/a-successful-git-branching-model" >}}。

看起來你無法使用這種分支模型進行[連續發布的並行開發](/concurrent-development-of-consecutive-releases/)，或者利用[功能標誌](/feature-flags/)和[抽象分支](/branch-by-abstraction/)來降低風險。

<!--
## Legacy branching models

## More than one trunk

This seems OK, but has many pitfalls. Consider **not** doing this model.

Some have a single repository with many trunks (and many branches - release or not). That is not uncommon with VCS
choices that do not have an upper limit on size (including history). You are at least allowing for atomic commits across many
of those trunks, which can happen if you have a large refactoring, and atomic commits are always desirable.
-->

## 傳統分支模型

## 多個主幹

這表面上看起來沒問題，但有很多陷阱。建議**不要**使用這種模型。

有些人會使用單一版本庫，但包含多個主幹（和許多分支——不論是否為發布分支）。這在沒有大小限制（包括歷史記錄）的版本控制系統中並不少見。這樣做至少允許在多個主幹之間進行原子提交，這在進行大規模重構時會發生，而原子提交始終是可行的。

```
root/    
  module_one/
    branches/
      rel_1.0.0/
      rel_1.1.0/          
    trunk/      
      build_file.xml
      src/
        # 產品程式碼的目錄結構
        # 測試程式碼的目錄結構
  module_two/
    branches/
      rel_1.0.0/
      rel_1.1.0/          
    trunk/      
      build_file.xml
      src/
        # 產品程式碼的目錄結構
        # 測試程式碼的目錄結構
  module_three/
    branches/
      rel_1.0.0/
      rel_1.1.0/          
    trunk/      
      build_file.xml
      src/
        # 產品程式碼的目錄結構
        # 測試程式碼的目錄結構
```

<!--
Many trunks becomes undesirable if you have lock-step release (same cadence) for all the separate trunks in the repo,
and for all of those you
are 'branching for release'. You have made it harder for the larger thing to be build from root. Better would be one
trunk with three modules, and a recursive build system, or one of the modern directed graph build systems like Buck or Bazel:
-->

如果你在倉儲中對所有單獨的主幹採取同步發布（相同節奏），擁有多個主幹變得不理想，並且你需要為這些主幹進行「分支發布」。這會讓從頭建置整個項目變得更難。更好的做法是只有一個主幹，裡面具有三個模組，並使用遞迴建置系統，或現代的有向圖建置系統，比如 Buck 或 Bazel。

```
root/    
  branches/
    rel_1.0.0/
    rel_1.1.0/          
  trunk/      
    module_one/
      build_file.xml
      src/
        # 產品程式碼的目錄結構
        # 測試程式碼的目錄結構
      module_two/
        build_file.xml
        src/
          # 產品程式碼的目錄結構
          # 測試程式碼的目錄結構
      module_three/
        build_file.xml
        src/
          # 產品程式碼的目錄結構
          # 測試程式碼的目錄結構
```



<!--
This way at least, you get to make one branch representing the release (with cherry-picks to it as bugs are eliminated).

Even if you have different release cadences, you can still engineer a trunk this way, you just have to have a build 
system that can reduce to the modules being tested and deployed, skipping those that won't be. See [Monorepos](/monorepos/)
and [expanding and contracting monorepos](/expanding-contracting-monorepos/).
-->

這樣至少你可以建立一個代表發布的分支（隨著錯誤被修復，進行 cherry-pick）。
即使有不同的發布節奏，你也可以這樣設計主幹。只需要一個建置系統，能夠減少正在測試和部署的模組，並且跳過那些不需要的模組。參見[單一版本庫](/monorepos/)和[擴大與收縮單一版本庫](/expanding-contracting-monorepos/)。

<!--
### Mainline

Mainline is diametrically opposite to Trunk-Based Development - do not do this.

Mainline is a branching model that was promoted for ClearCase implementations. It is the principal branching
model that Trunk-Based Development opposes. Mainline is a branch that will last forever&#10033;. Off that, branches are formed
for teams to do development work on. When that work is complete, a release may happen from that branch, and there is a
**big** merge down to the mainline. On the way to the release, the branch may be frozen.

So here is the intention, with Mainline:

![](mainline1.png)
([key](/key/))
-->

### 主線

主線（Mainline）與主幹開發的概念完全相反——不要這樣做。

主線是一個在 ClearCase 實現中推廣的分支模型，它是主幹開發所反對的主要分支模型。主線是一個將永遠存在的分支&#10033;。
基於此，團隊會建立分支來進行開發工作。當工作完成後，可以從該分支進行發布，然後進行一次**大規模**的合併回主幹。在發布過程中，分支可能會被凍結。

這就是主線模型的示意圖：

<img srcset="mainline1.png 1x,mainline1@2x.png 2x">([分支圖示的說明](/key/))

<!--
When bugs inevitably happen:

![](mainline2.png)
([key](/key/))
-->

當錯誤不可避免的發生：

<img srcset="mainline2.png 1x,mainline2@2x.png 2x">([分支圖示的說明](/key/))

<!--
Whenever there is a bug fix there has to be a merge down to the mainline afterward. There's no 'wrong' in this modified
branch diagram, but you should be able to guess what the worst case branching/merging scenario is. In case you cannot:

![](mainline3.png)
([key](/key/))
-->

每次修復錯誤後，必須將其合併到主幹。這個修改後的分支圖沒有錯誤，但你應該能猜到最糟糕的分支/合併情況。如果你猜不到的話：

<img srcset="mainline3.png 1x,mainline3@2x.png 2x">([分支圖示的說明](/key/))

<!--
**Merges for the above**
-->

**針對上述情況的合併**

<!--
1. Release 1.1 team persuades the release 1.0 team to bring something back to Mainline early (and incomplete) before they cut their branch
1. Release 1.1 team merges the release 1.0 work upon apparent completion
1. Release 1.0 team merges post-release bug fixes back to Mainline, and cross their fingers that the 1.0 branch can truly die now
1. Release 1.2 team persuades the release 1.1 team to bring something back to Mainline early (and incomplete) before they cut their branch
1. Release 1.1 team merges from Mainline, to pick up #3
1. Release 1.2 team merges the release 1.1 work upon apparent completion
1. Release 1.1 team merges post-release bug fixes back to Mainline, and cross their fingers that the 1.0 branch can truly die now
1. Release 1.2 team merges from Mainline, to pick up #7

-->

1. 1.1 版本團隊說服 1.0 版本團隊在他們分支之前，將一些東西提前（且不完整）合併回主線。
2. 1.1 版本團隊在 1.0 版本工作看似完成後進行合併。
3. 1.0 版本團隊將發布後的錯誤修復合併回主線，並祈禱 1.0 分支現在可以真正結束。
4. 1.2 版本團隊說服 1.1 版本團隊在他們分支之前，將一些東西提前（且不完整）合併回主線。
5. 1.1 版本團隊從主線進行合併，接收第 3 步的內容。
6. 1.2 版本團隊在 1.1 版本工作看似完成後進行合併。
7. 1.1 版本團隊將發布後的錯誤修復合併回主線，並祈禱 1.0 分支現在可以真正結束。
8. 1.2 版本團隊從主線進行合併，接收第 7 步的內容。

<!--
All of these compromises versus the planned "consecutive development of consecutive releases". In many cases, it is worse,
particular when the numbers of developers go up.

One key thing to note, versus Trunk-Based Development, teams doing the Mainline branching model, almost never do cherry
pick merges for any reason. Instead, they are doing a "merge everything which is not merged already" kind of merge.
Minimalistically the VCS they are using should have "merge point tracking". At the high end, that should include
"record only" merges, and normal merges even after that.

&#10033; Companies that choose 'Mainline' wither and die, we claim, so there is no forever.
-->

所有這些妥協與計劃中的「接連開發連續版本」相違背，在很多情況下會更糟糕，特別是當開發者數量增加時。

有一點需要注意，相比於主幹開發，使用主線分支模型的團隊幾乎從不進行 cherry pick。不管什麼原因，他們都是進行「合併所有尚未合併的內容」這種合併。

最基本的是，他們使用的版本控制系統應該具有「合併點追蹤」功能。在更複雜情況下，還應該包括「僅記錄」合併，以及之後的正常合併。

&#10033; 我們認為，選擇「主線」模型的公司會逐漸衰退甚至消失，所以並不會一直存在。

<!--
#### Merges

After the release, the code will be merged back en masse to the mainline. Those
merges may be hard and lengthy. It could be that the team **took merges from** mainline part way through the project. It
could also be that the team **pushed merges to** mainline part way through the project.
-->

#### 合併

發布之後，程式碼會大量合併回主線。這些合併可能會很困難且耗時。可能團隊在項目進行過程中**從主線進行合併**，也可能團隊**將合併推送到主線**。

<!--
#### How many branches?

We've just described a two branch model - the mainline and a project branch. It could be that the application in
question has more that one project in flight at any one time. That would mean more than one project branch, and that
creates pressure for more intermediate merges, and consequentially greater merge difficulty.
-->

#### 有多少分支？

我們剛剛描述了兩個分支模型－主線和項目分支。可能這個應用在任何時候都有多個正在進行中的項目，這意味著會有多個項目分支，這會帶來更多的中間合併壓力，從而導致合併難度增加。

<!--
#### Always release ready?

Not on your life! Planned work needs to complete, with estimates guiding when that will be. Defects need to be
eliminated, formal testing phases need to kick in. Here we take the first branch diagram, and overlay red and orange
and green to show known build-breaks, build passes missing automated tests will not catch hidden defects,
and green for could go live. At least for the worst performing with missing or ineffectual automated
testing run in the CI pipelines:

![](mainline4.png)
([key](/key/))
-->

#### 隨時準備發布？

根本不可能！計劃的工作需要完成，並且需要有估算來指導何時完成。缺陷需要被消除，正式的測試階段需要啟動。在這裡，我們在第一個分支圖上新增紅色、橙色和綠色來顯示已知的建置中斷、建置通過但缺少自動化測試的情況，這些可能會隱藏缺陷，綠色表示可以上線。至少對於那些缺少或無效的自動化測試在 CI 流水線中運行的最差情況：

<img srcset="mainline4.png 1x,mainline4@2x.png 2x">([分支圖示的說明](/key/))

<!--
### Cascade

Cascade is incompatible with Trunk-Based Development - do not do this.

The idea is that each release has its own branch and that each release team merges from the 'upstream' branch daily.
They only do so if the CI server says the build is green for the upstream, of course.

![](cascade1.png)
([key](/key/))
-->

### 瀑布模型

瀑布模型與主幹開發不兼容——不要這麼做。

這種方法的想法是每個版本都有自己的分支，每個版本團隊每天從「上游（upstream）」分支進行合併。他們只有在 CI 伺服器顯示上游建置通過時才會這樣做。

<img srcset="cascade1.png 1x,cascade1@2x.png 2x">([分支圖示的說明](/key/))

<!--
Problems compound with this model, the more releases being juggled concurrently there are. An upstream butterfly is
a downstream Tsunami of unmergability. Downstream merges begin to get skipped, or abandoned. Or the merge works, but the
code is not right so there is some in-branch fixing, which is not applicable to upstream. Here's the reality (breakages
overlaid again):

![](cascade2.png)
([key](/key/))
-->

這種模型存在的問題會隨著同時處理的發布版本數量增加而加劇。上游的變化可能會導致下游難以合併的巨大變動。下游的合併開始被跳過或放棄。或者合併成功，但程式碼錯誤，因此需要在分支內進行修復，而這些修復對上游並不適用。現實情況如下（再次疊加顯示的中斷情況）：

<img srcset="cascade2.png 1x,cascade2@2x.png 2x">([分支圖示的說明](/key/))

<!--
Remember, the merges are never cherry-picks in this model - they are sweeps of everything
not merged yet (or up to an chosen commit number in order to make it more bite-sized).

Of course only larger organizations have to worry
about the [concurrent development of consecutive releases](/concurrent-development-of-consecutive-releases/), and many
would argue that the application is too large anyway (and that microservices are the solution).
-->

請記住，在這個模型中，合併從來不是 cherry-pick ——而是合併所有尚未合併的內容（或者合併到選定的提交號碼，以便更易於處理）。

當然，只有較大的組織才需要擔心[連續發布的並行開發](/concurrent-development-of-consecutive-releases/)，而且許多人可能會認為應用程式本身過於龐大（而微服務是解決方案）。

<!--
## CI (dis)proof of your branching model

Here's an idea. Configure your CI Server to focus on every branch, regardless of branching model. Specifically to do
per-commit builds, and do that speculative merge analysis described in [game changers](/game-changers/index.html#snap-ci-s-per-commit-speculative-mergeability-analysis-2013).

If everything is green everywhere, then you're in a position to always be release ready, but very few teams are going
to see green instead of red for this CI server enthusiasm
-->

## 持續整合對你的分支模型的證明或反駁

這裡有個想法。配置你的 CI 伺服器，無論使用的是什麼分支模型都讓它關注每個分支。具體來說，對每個提交進行建置，並進行[變革推動者](https://game-changers/index.html#snap-ci-s-per-commit-speculative-mergeability-analysis-2013)中描述的推測可合併性分析。

如果所有地方都是綠色的，那麼你就可以隨時準備好發布。但是，很少有團隊能在 CI 伺服器的積極建置和分析下看到綠燈，而不是紅燈。

<!--
# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>
-->

# 其他參考資料

<a id="showHideRefs" href="javascript:toggleRefs();">顯示參考資料</a>

<div>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">31 Aug 2011, Blog Entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://scottchacon.com/2011/08/31/github-flow.html">GitHub Flow</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">04 Dec 2013, Blog Entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://paulhammant.com/2013/12/04/what_is_your_branching_model/">What is Your Branching Model?</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">05 Apr 2013, Blog Entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://paulhammant.com/2013/04/05/what-is-trunk-based-development/">What is Trunk-Based Development?</a></td>
        </tr>
    </table>
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
            <td style="padding: 2px" valign="top">15 Oct 2015, InfoQ Interview</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://www.infoq.com/news/2015/10/branching-continuous-integration">More Feature Branching Means Less Continuous Integration</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">03 May 2015, Blog Entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://endoflineblog.com/gitflow-considered-harmful">GitFlow considered harmful</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">08 Jan 2016, Blog Entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://dan.bodar.com/2016/01/08/gitflow-hmmmm/">GITFLOW HMMMM</a></td>
        </tr>
    </table>
</div>

