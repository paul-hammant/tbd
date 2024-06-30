---
date: 2016-06-05T20:10:46+01:00
title: 持續不斷的程式碼審查
weight: 65
---

<!--
## The high bar today

Continuous Code Review is where the team commits to processing proposed commits (to trunk) from teammates' trunk speedily. 

The idea is that a system (the code portal probably) allows developers to package up commits for code review and get 
that in front of peers quickly. And that peer developers make a commitment to do code reviews objectively and quickly. 

There is a cost to multi-tasking, so maybe someone in the dev team who is between work items at that moment should focus 
on the review before they start new work. With a continuous review ethos, it is critical that code reviews are not 
allowed to back up.

Companies doing Extreme Programming, often allow that pair of eyes to count as a review. Some companies require 
multiple reviews of code. For "the pair as reviewers too" scenario, one might have been enough and that commit will 
land in the trunk, without others looking at it. Five minutes and 20 seconds into Guido van Rossum's famous 2006 Mondrian 
presentation, he states "code review is a best alternative to pair programming", and that it is "basically 
asynchronous pair-programming".

-->

## 今日的高標準

持續不斷的程式碼審查是團隊承諾迅速處理隊友提交到主幹的建議提交的過程。

這個想法是有一個系統允許開發者將提交打包進行程式碼審查，並迅速呈現給程式碼審查人員。同時，程式碼審查人員承諾客觀且迅速地進行程式碼審查。

同時進行多任務處理是有成本的，所以當開發團隊中的某個人在工作項目之間有空檔時，應該先專注於審查程式碼，再開始新的工作。持續審查的精神非常重要，必須確保程式碼審查不會積壓。

在實行極限開發的公司中，通常允許配對開發中的審查者檢查過即算完成審查。有些公司會要求對程式碼進行多次審查。對於「審查者也是配對開發者」的情境，一次審查可能就足夠將提交直接納入主幹，無需其他人再檢查。在 Guido van Rossum 於 2006 年著名的 Mondrian 演講中，他在開始的五分鐘二十秒處提到「程式碼審查是配對開發的最佳替代方案」，並且它基本上是「非同步的配對開發」。

<!--
### Pull Requests (PRs)

The pull-request (PR) model introduced by GitHub is the dominant code review model today. The concept was available 
from GitHub's launch in 2008 and has revolutionized both open source and enterprise software development. Google were
secretly doing the same thing with custom tooling around their Perforce install from about 2005, and Guido's
presentation on Mondrian in 2006 (as mentioned) leaked that to the world (see below).

A PR is one
or more commits towards a goal described in an accompanying piece of text. The act of creating the PR from the branch
signals the end (or a pause) in work, and the wish for the reviewers to get busy (and the CI daemon to wake up and 
build/verify the branch). There are caveats though.

-->
### 拉取請求

GitHub 引入的拉取請求（PR）模型，是當今主導的程式碼審查模型。這一概念自 GitHub 於 2008 年成立時便已存在，並且徹底改變了開源和企業級軟體開發流程和方法。大約從 2005 年開始，Google 也在他們的 Perforce 安裝基礎上使用自定義工具進行了類似的操作，而 Guido 在 2006 年對 Mondrian 的演講（如前所述）則向全世界洩露了這一做法（見下文）。

拉取請求是針對目標進行的一次或多次提交，並在附帶的文字中描述該目標。從分支建立拉取請求的行為代表著工作結束（或暫停），並且希望審查者開始工作（同時 CI 的常駐程式開始建置和驗證分支）。不過，這其中也有需要注意的地方。

<!--
#### Open Source contributions via PRs

These can come from anyone who has an account on GitHub (or equivalent). They will have forked your repository and the 
PR will be about commits that would come back to your repository. They may delete their repository after you consume
their commits. If these are unsolicited you may well
take your time reviewing them. Indeed you may never consume them, if you don't like them. Hardly continuous, but open
source is mostly a volunteer activity.
-->

#### 透過拉取請求貢獻開源項目

這些貢獻可以來自任何擁有 GitHub（或類似平台）帳戶的人。他們將會 fork 你的版本庫，拉取請求將會把提交返回你的程式碼版本庫。在你使用他們的提交之後，他們可能會刪除自己的程式碼版本庫。如果這些拉取請求是主動提供的，你完全可以花時間來審查它們。如果你不喜歡這些提交，你可以選擇不合併。開源大多是出自於志願者的自主性，但是並不會一直有人做這件事。

<!--
#### PRs from colleagues

Regardless of branching model, the wish is for the PR to be reviewed fairly quickly. On GitHub (and possibly others) the PR
can come from a fork or a branch in the main repo. There is little difference to the processing of these. In Trunk-Based 
Development teams, the PR should be on a [short-lived feature branch](/short-lived-feature-branches/) and processed very 
quickly by reviews towards merging back to trunk/main. A few minutes for the review is best, and tens of minutes 
acceptable. More than a hour or two, and you are negatively affecting cycle times.

The short-lived feature branch may have received many commits before the developer initiated the pull request. Some 
developers will squash (rebase) the changes into a single commit before starting code review. Some teams have a policy 
in favor of or against squash/rebase. 

{{< note title="Common Code Owners" >}}
Commits being reviewed are never rejected for "Only I am allowed to change source in this package" reasons. Rejections
must be for objective and published reasons.
{{< /note >}}
-->

#### 從同事來的拉取請求

不管使用哪種分支模型，都會希望拉取請求能夠被迅速且公正地審查。在 GitHub（以及可能的其他平台）上，拉取請求可以來自一個分叉或主程式碼庫中的一個分支。
處理這些拉取請求的方式幾乎沒有什麼差別。在使用主幹開發的團隊中，拉取請求應該使用[短期功能分支](/short-lived-feature-branches/)，並且通過審查迅速處理，以便將其合併回主幹或主分支。最好能在幾分鐘內完成審查，幾十分鐘內完成也是可以接受的。如果審查時間超過一兩個小時，那將會對整個週期時間（cycle time）產生負面影響。

短期功能分支在開發者發起拉取請求之前，可能已經有很多提交了。有些開發者會在開始程式碼審查前，把多個修改合併成一個提交（rebase）。有些團隊會有支持或反對這種合併提交的規定。這樣做的目的是為了讓提交的歷史更簡潔，或者保留詳細的修改紀錄以增加透明度。

{{< note title="常見的程式碼擁有者" >}}
正在審查的提交永遠不會因為「只有我被允許在這個套件中修改原始程式碼」的理由而被拒絕。拒絕必須基於客觀且已公開的理由。
{{< /note >}}

<!--
## Enterprise code review - as it was

In enterprises, if code review was done at all prior to 2008, it was done in a batch, and probably a group activity. 
It was often abhorred as it gave a lead developer/architect a moment to set an agenda, round on a large portion of the 
attendees and make sure that their own code flubs were not discussed at all.

Historically, open source teams never had the luxury of procrastinating about code review. They either did code reviews 
as they went (perhaps days were the review cadence, not hours or minutes), or they did not bother at all.
-->

## 企業審查程式碼 — 過往的作法

在企業中，如果 2008 年之前進行程式碼審查，通常是以批次進行，而且是團隊一起來做的活動。這種做法常常讓人不喜，因為它讓領頭的開發者或架構師可以利用這個機會來主導討論，批評很多參與者，並且確保大家不會談到他們自己程式碼上的問題。

從過去到現在，開源團隊都不會去拖延程式碼審查。他們要不就是邊開發邊審查，可能每幾天審查一次，不會按小時或分鐘算，要不就是根本不做審查。

<!--
## See also

See [Game Changers - Google's Mondrian](/game-changers/index.html#google-s-internal-devops-2006-onwards) and 
[Game Changers - GitHub's Pull Requests](/game-changers/index.html#github-s-entire-platform-2008-onwards) for the industry impact of continuous code 
review.
-->

## 了解更多

可以看 [變革推動者 - Google 的 Mondrian](/game-changers/index.html#google-s-internal-devops-2006-onwards) 以及 
[變革推動者 - GitHub 的 Pull Requests](/game-changers/index.html#github-s-entire-platform-2008-onwards) 了解持續程式碼審查對行業的影響。

<!--
# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>
-->

# 其他參考資料 {#references-elsewhere}

<a id="showHideRefs" href="javascript:toggleRefs();">顯示參考資料</a>

<div>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">13 Nov 2014, Blog Article</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://paulhammant.com/2014/11/13/code-review-the-unit-of-work-should-be-a-single-commit/">Code Review - the unit of work should be a single commit</a></td>
        </tr>
    </table>
</div>
