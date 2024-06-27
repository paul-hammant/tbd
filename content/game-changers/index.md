---
date: 2016-12-01T20:08:11+01:00
title: 變革推動者
weight: 121
---

<!--
Since the early 80's a number of things have pushed best practices **towards** Trunk-Based Development, or **away** from it.

The language in use to describe such things has changed over time. Software Configuration Management (SCM) is used less
today than Version Control Systems (VCS) is. A simpler still term - "Source Control" - seems to be used more recently,
too.

Similarly, 'trunk' and 'branch', have not always been used as terms for controlled code lines that have a common
ancestor, and are eminently (and repeatably) mergeable.
-->

自 80 年代初以來，許多事物推動了最佳實踐**朝向**主幹開發，或**遠離**它。

用來描述這些事物的語言隨著時間而變化。軟體配置管理（SCM）這個詞今天的使用頻率比版本控制系統（VCS）低。一個更簡單的術語「原始碼版本控制」，似乎最近更常被使用。

同樣地，「主幹」和「分支」這些術語也並非一直被用來描述有共同祖先的、且能夠顯著且重複合併的控制程式碼線。

<!--
## Revision Control System - RCS (1982)

![](to_tbd1.png)

RCS was a simple but 'early days' version control technology, by Walter F. Tichy.

In Tichy's 1985 paper
"RCS - A System for Version Control"{{< ext url="https://www.gnu.org/software/rcs/tichy-paper.pdf" >}}, a trunk
focused mode of use is described as a "slender branch". In section 3.1. "When are branches needed?",
he says that you step away from the trunk for four reasons:

<div style="padding-left: 40px"><span style="font-size: 120%">&ldquo;</span>
A young revision tree is slender: It consists of only one branch, called the trunk.<br>
As the tree ages, side branches may form. Branches are needed in the following 4 situations.<br>
Temporary fixes, Distributed development and customer modifications, Parallel development, and Conflicting updates.
</div>

Two of those, Tichy suggests, are temporary branches and would come back to the trunk at the earliest opportunity.

Superficially, RCS allowed multi-branch parallel development, but some teams were very careful and stuck
to a 'slender', or Trunk-Based Development mode of use.

Note: Over time all version control systems would adopt this branch/merge language.
-->

## 版本控制系統 - RCS（1982）

<p><img srcset="to_tbd1.png 1x,to_tbd1@2x.png 2x"></p>

RCS 是由 Walter F. Tichy 所開發的一種簡單但屬於「早期」的版本控制技術。

在 Tichy 的 1985 年論文《RCS - 一個版本控制系統》{{< ext url="https://www.gnu.org/software/rcs/tichy-paper.pdf" >}}中，描述了一種專注於主幹的使用模式，稱為「細長分支」。在第 3.1 節「何時需要分支？」中，他指出有四個理由需要從主幹分開：

<div style="padding-left: 40px"><span style="font-size: 120%">&ldquo;</span>
年輕的修訂樹是細長的：它只包含一個分支，稱為主幹。<br>
隨著樹木的老化，可能會形成側分支。在以下四種情況下需要分支：<br>
臨時修復、分散式開發和客戶修改、平行開發以及衝突更新。
</div>

Tichy 建議，其中兩種情況（臨時修復和分散式開發）屬於臨時分支，儘早合併回主幹。

表面上，RCS 允許多分支的平行開發，但一些團隊非常謹慎，堅持使用「細長」或主幹開發。

Note：隨著時間的推移，所有版本控制系統都會採用這種分支或合併的語言。

<!--
## Concurrent Versions System - CVS (1990)

![](to_tbd1.png)

A handful of scripts created in 1986 by Dick Grune, were fashioned into an initial release of CVS{{< ext url="https://en.wikipedia.org/wiki/Concurrent_Versions_System" >}}
in 1990. For the open source community, CVS was it until Subversion came along years later. The adoption of CVS in the
young open source community spurred its adoption in the enterprise too. While many branching models were possible,
merging was painful and Trunk-Based Development was the sensible choice. Indeed CVS popularized the "trunk" branch name, even if it didn't mandate it.  CVS's flaws were that it did not have atomic commits, its operation over the wire as a centralized client/server VCS was very chatty, and it had cumbersome CVS/ directories all over the checked out code.
-->

## 併發版本控制系統 - CVS (1990)

<p><img srcset="to_tbd1.png 1x,to_tbd1@2x.png 2x"></p>

在 1990 年，由 Dick Grune 在1986年建立的幾個腳本被進一步開發，並正式發布為初始版本的併發版本系統（CVS）{{< ext url="https://en.wikipedia.org/wiki/Concurrent_Versions_System" >}}。對於開源社群來說，在 Subversion 問世之前，CVS 是主流的版本控制系統。CVS 在年輕的開源社群中的採用也促進了其在企業中的應用。雖然有許多分支模型是可能的，但合併過程痛苦且困難，主幹開發成為合理的選擇。實際上，即使 CVS 沒有強制使用，它也普及了「主幹」分支的名稱。CVS 的缺陷在於它沒有原子提交，其作為集中式客戶端及服務器的版本控制系統，CVS 的運作過於繁瑣，並且在檢出的程式碼中到處都是笨重的 CVS 或子目錄來儲存版本控制資訊。

<!--
## Microsoft Secrets book (1995)

![](to_tbd3.png)

Microsoft Secrets: How the World's Most Powerful Software Company Creates Technology, Shapes Markets and Manages
People (Michael Cusumano & Richard Selby, 1995){{< ext url="https://www.amazon.com/Microsoft-Secrets-Powerful-Software-Technology/dp/0684855313" >}}

The book was translated into 14 languages, and a bestseller, and was about practices that solidified within Microsoft
for a few years before.

There's a section in *Microsoft Secrets* dealing with Microsoft's per-developer workflow using Source Library Manager
(SLM) on  a one-branch model (the book does not use the words trunk or branch). SLM (AKA "slime") - was an internal
tool Microsoft used for source-control. The *daily* developer workflow with SLM was:

1. checkout (update/pull/sync or checkout afresh)
2. implement feature
3. build
4. test the feature
5. sync (update/pull)
6. merge
7. build
8. test the feature
9. smoke tests
10. check in (commit/push)
11. makes a daily build from HEAD of the shared main branch

The authors note in the book, that #10 is not always an everyday thing. And the last step, #11, is not per developer, it is
for the designated "buildmeister" within the team, and manual. This workflow was initially pioneered in the Excel group,
and then Word, and then Windows NT, and the timespan for this way of working was from around 1989 through 1995 when the
interviews completed and the book published.

The book also briefly mentions Test Case Manager (TCM) and "Microsoft Test". These were tools for helping developers
manage and record/edit/playback application tests at their workstations. It is not clear if all SLM-using teams
also used these, but the Excel team did (as they maintained the former at least).

These are clearly practices to support teams working in a trunk model.

Notes:

1. Steve McConnell's Rapid Development (1996) also reinforces #11 - make a daily build.

2. In 2000, ex Microsoftee and early blogger Joel Spolsky would extol the virtues of #11 in his famous
"The Joel Test"{{< ext url="https://www.joelonsoftware.com/2000/08/09/the-joel-test-12-steps-to-better-code" >}} posting.
-->

## 微軟秘笈（1995）

<p><img srcset="to_tbd3.png 1x,to_tbd3@2x.png 2x"></p>

《微軟秘笈：全球最強大的軟體公司如何創造技術、塑造市場並管理人員》（Michael Cusumano & Richard Selby，1995）{{< ext url="https://www.amazon.com/Microsoft-Secrets-Powerful-Software-Technology/dp/0684855313" >}}

這本書被翻譯成 14 種語言，是一本暢銷書，描述了在微軟內部鞏固了幾年的實踐。

「微軟秘笈」的一部分內容涉及微軟每個開發者使用原始程式碼套件管理器（SLM）的一個分支模式工作流程（書中沒有使用主幹或分支這些詞）。SLM（也稱為「slime」）是微軟用於原始碼版本控制的內部工具。使用 SLM 的*每日*開發者工作流程如下：

1. checkout（更新、拉取、同步或重新 checkout）
2. 實施功能
3. 建置
4. 測試功能
5. 同步（更新或拉取）
6. 合併
7. 建置
8. 測試功能
9. 煙霧測試
10. 檢入（提交或推送）
11. 從共享主分支的 HEAD 進行每日建置

作者在書中指出，第 10 步並不是每天都進行的。而最後一步，第 11 步，不是每個開發者都要做的，而是由團隊內指定的「建置大師（buildmeister）」手動完成的。這種工作流程最初由 Excel 團隊開創，然後是 Word 團隊，接著是 Windows NT 團隊，這種工作方式的時間跨度從大約 1989 年到 1995 年間完成訪談並出版這本書。

書中還簡要提到 *Test Case Manager*（TCM）和 *Microsoft Test*。這些是幫助開發者在個人電腦上管理和記錄、編輯或回放應用測試的工具。不清楚所有使用 SLM 的團隊是否都使用這些工具，但 Excel 團隊確實使用（至少維護前者）。

這些顯然是支持團隊在 trunk 模式下工作的實踐。

Notes︰

1. Steve McConnell 的「Rapid Development」（1996年）也強調了第 11 步——進行每日建置。

2. 2000年，前微軟員工和早期部落客 Joel Spolsky 在他的著名文章 *The Joel Test* {{< ext url="https://www.joelonsoftware.com/2000/08/09/the-joel-test-12-steps-to-better-code" >}}中稱讚了第 11 步的優點。

<!--
## NetScape's Tinderbox (1997)

![](to_tbd1.png)

NetScape (now Mozilla) had a service that compiled and tested bits and pieces of their open-source offerings together. That service was
Tinderbox and it debuted for the public to see in 1997. Their source organization was single-branch in the trunk style
managed by CVS, and allowed individual developers to checkout and keep abreast of only the pieces they wanted/needed to. Tinderbox
was the safety net that ensured everything was correct across all the whole trunk. It ran until it wouldn't scale anymore
in 2014{{< ext url="http://oduinn.com/blog/2014/06/04/farewell-to-tinderbox/" >}}.
-->

## NetScape 的 Tinderbox（1997）

<p><img srcset="to_tbd1.png 1x,to_tbd1@2x.png 2x"></p>

NetScape（現在的 Mozilla）有一個服務，將其開源產品的各個部分編譯和測試在一起。這個服務叫做 Tinderbox，於 1997 年首次公開。它們的程式碼組織是單分支的主幹模式，由 CVS 管理，允許各個開發者只 checkout 並關注他們想要或需要的部分。Tinderbox 是一個安全網，確保所有主幹上的程式碼都是正確的。這個服務一直運行到 2014 年，直到它無法再擴展為止{{< ext url="http://oduinn.com/blog/2014/06/04/farewell-to-tinderbox/" >}}。

<!--
## Perforce and ClearCase (1998)

![](away_from_tbd3.png)

Perforce and ClearCase bit into the corporate VCS market significantly. Both, as technologies, were
open to any branching model and implementing teams chose differently. In the end, though, people's newfound willingness
to experiment with multiple parallel active branches won out, and we had some dark years generally for Trunk-Based
Development ahead, even if branch names sometimes included 'trunk'. Both Perforce and ClearCase has decent merge
tracking, but Perforce was much faster on the wire.

Microsoft installed a custom build of Perforce called "Source Depot". It took over from SLM/Slime (mentioned above).
We are not sure, but Microsoft may have embraced the possibility of multiple active branches (rather than
Trunk-Based Development) back then within their Source Depot (SD) setup.

By contrast, Google installed Perforce (see below) and embraced a Trunk-Based Development model with it from the outset.
They rose to every scaling challenge with extra tooling around it, including more than a few actual inventions of
technology and technique (see below).

### Perforce's High-Level SCM Best Practices white paper

Laura Wingerd and Christopher Seiwald penned this widely read paper{{< ext url="https://www.perforce.com/sites/default/files/pdf/perforce-best-practices.pdf" >}}
 that was presented at an SCM conference in Brussels the same year.

The paper alternates between 'trunk' and 'mainline' language, but has many valuable nuggets in
it that help set a foundation for the next ten years of version-control advances.
-->

## Perfore 和 ClearCase（1988）

<p><img srcset="away_from_tbd3.png 1x,away_from_tbd3@2x.png 2x"></p>

Perforce 和 ClearCase 在企業版版本控制系統（VCS）市場上佔據了重要地位。作為技術，兩者都支持任何分支模型，而實施團隊選擇了不同的模式。最終，人們對試驗多個平行活躍分支的新意願占了上風，主幹開發度過了一段黑暗時期，即使有時分支名稱包含「主幹」。兩者都有不錯的合併追蹤功能，但 Perforce 在網路上的速度更快。

微軟安裝了一個名為「Source Depot」的定制版本的 Perforce。它取代了前面提到的 SLM 和 Slime。我們不確定，但微軟當時可能在其 Source Depot (SD) 設置中採用了多個活躍分支的可能性（而非主幹開發）。

相比之下，Google 安裝了 Perforce（見下文），並從一開始就採用了主幹開發模型。他們通過額外的工具解決了每個擴展挑戰，包括不止一些實際的技術和方法發明（見下文）。

### Perforce 的進階 SCM 最佳實踐白皮書

Laura Wingerd 和 Christopher Seiwald 撰寫了這篇廣受閱讀的白皮書{{< ext url="https://www.perforce.com/sites/default/files/pdf/perforce-best-practices.pdf" >}}，並在同年於 Brussels 的一次 SCM 會議上發表。

這篇文章在使用「主幹」和「主線」這兩個詞之間交替，但其中有許多寶貴的見解，有助於為未來十年的版本控制進步奠定基礎。

<!--
## Extreme Programming's Continuous Integration (1999)

![](to_tbd3.png)

Kent Beck{{< ext url="https://en.wikipedia.org/wiki/Kent_Beck" >}} published "Extreme Programming Explained" in 1999.
Picked out that, amongst a bunch of practices for the influential XP methodology, is "Continuous Integration"
that Kent felt was "risk reducing".

He says "Integrate and build the system many times a day, every time a task is completed", and goes on to detail
a reserved workstation, that a developer pair would sidle up at the appropriate moment to prove that their code
contribution was integrateable, and therefore good for teammates to depend on at that moment. That last notification
was often oral at that time "build passes, gang".

He calls out a requirement for "fast integration/build/test cycles". This is key. In fact, every pro Trunk-Based Development
game changer listed in this page was facilitated by faster builds generally (versus a predecessor technique for the team
in question). And, no, faster did not mean delete or comment out automated test execution in the build. Faster meant to reduce
the elapsed time to "a few minutes" (Kent again).

Kent had pioneered (with many industry luminary friends) in 1996 on the famous Chrysler Comprehensive Compensation System
(C3) project. The C3 project used Smalltalk as its language, and OTI's ENVY was the version control tool used. It is
important to note that today's CR-delimited text file systems are blunt instruments compared to the fine-grained
directed graphs with fidelity down to class/method history of each of those. It was more like a multidimensional
database with cross-cutting tags representing HEAD, or someone else's important combination of those three. It was
omnipresent too - a decision made to move HEAD was instantly available without 'update' action to teammates.
-->

## 極限開發的持續整合（1999）

<p><img srcset="to_tbd3.png 1x,to_tbd3@2x.png 2x"></p>

Kent Beck{{< ext url="https://en.wikipedia.org/wiki/Kent_Beck" >}} 於 1999 年出版《極限開發解析》。在這本影響深遠的 XP 方法論中，有很多實踐，其中包括「持續整合」，Kent 認為這是「降低風險」的一種方法。

他說：「每次完成一個任務後，都要多次整合以並建置系統」，並詳細描述了一個保留的工作環境，開發者對在適當的時刻會在這裡證明他們的程式碼是可整合的，因此對團隊成員來說是可靠的。當時，這樣的通知通常是口頭的：「大家，建置通過了」。

他強調了「快速整合、建置和循環測試」的需求。這是關鍵。事實上，這裡列出的每一個有利於主幹開發的重大變革都得益於更快的建置（相對於當時的前一技術）。而且，更快並不意味著刪除或註釋掉建置中的自動化測試執行。更快的意思是將經過時間減少到「幾分鐘」（再次引用 Kent）。

Kent 於 1996 年在著名的 *Chrysler Comprehensive Compensation System*（C3）專案中率先進行了這方面的實踐，與許多業界著名人士共同合作。C3 專案使用 Smalltalk 作為語言，OTI 的 ENVY 作為版本控制工具。重要的是要注意，今天基於 CR 分隔的文字檔案系統相比於那些具備細顆粒度、精確地追蹤到每個類別和方法歷史的定向圖而言，是相對粗糙的工具。它更像是一個多維資料庫，使用橫向標籤來表示 HEAD 或其他重要組合。而且這些系統是無處不在的，一旦決定移動 HEAD，團隊成員可以立即看到而無需「更新」操作。

<!--
## Continuous Integration paper on MartinFowler.com (2000)

![](to_tbd3.png)

Martin Fowler and Matt Foemmel{{< ext url="http://blog.foemmel.com" >}} wrote an influential article "Continuous
Integration" in 2000{{< ext url="https://www.martinfowler.com/articles/originalContinuousIntegration.html" >}},
calling out this one part of XP. Martin greatly updated it in 2006
{{< ext url="https://www.martinfowler.com/articles/continuousIntegration.html" >}}.
-->

## 於 MartinFowler.com 的持續整合文章（2000）

<p><img srcset="to_tbd3.png 1x,to_tbd3@2x.png 2x"></p>

Martin Fowler 和 Matt Foemmel{{< ext url="http://blog.foemmel.com" >}} 在 2000 年撰寫了一篇影響深遠的文章 *Continuous Integration*{{< ext url="https://www.martinfowler.com/articles/originalContinuousIntegration.html" >}}，指出了極限開發（XP）中的這一部分。Martin 在 2006 年對其進行了大幅更新{{< ext url="https://www.martinfowler.com/articles/continuousIntegration.html" >}}。

<!--
## ThoughtWorks' Cruise Control (2001)

![](to_tbd3.png)

Martin's ThoughtWorks colleagues (Alden Almagro{{< ext url="http://aldenalmagro.com/resume.html" >}},
Paul Julius{{< ext url="http://www.pauljulius.com" >}},
Jason Yip{{< ext url="http://jchyip.blogspot.com" >}}) went on to build the then-dominant
"Cruise Control"{{< ext url="http://cruisecontrol.sourceforge.net" >}} starting in early 2001 (for CVS, StarTeam). This was a
groundbreaking technology and very accessible to companies wanting a machine to fully verify checkins. ThoughtWorks
already had success the year before with the same server design on a client project, and CruiseControl was the
rewrite (from scratch) in order to make it open source. CruiseControl was quite successful in the enterprise and was
and easy decision after teams had read the Continuous Integration paper above.

Early CI servers, including CruiseControl used to have a "quiet period" to make sure they had received every last
element of an intended commit. To facilitate that, only one pair of developers was allowed to checkin at a time. With
CVS the other developers in the team could only do their "cvs up" when CruiseControl had given the green light,
automating that "build passes, gang" oral notification above. A particular non-functional feature to note for
CruiseControl was that it stored its 'pipeline' configuration in source-control. In fact, that was alongside the
project's source and build file - developers could tweak CI configuration in a commit.
-->

## ThoughtWorks 的 Cruise Control（2001）

<p><img srcset="to_tbd3.png 1x,to_tbd3@2x.png 2x"></p>

Martin 的 ThoughtWorks 同事 Alden Almagro{{< ext url="http://aldenalmagro.com/resume.html" >}}、Paul Julius{{< ext url="http://www.pauljulius.com" >}} 和 Jason Yip{{< ext url="http://jchyip.blogspot.com" >}} 在 2001 年初開始開發當時主導市場的 *Cruise Control*{{< ext url="http://cruisecontrol.sourceforge.net" >}}（針對 CVS 和 StarTeam 版本控制系統）。這是一項突破性的技術，非常適合那些希望通過機器完全驗證提交的公司使用。ThoughtWorks 在前一年已經在客戶專案中使用了相同的服務器設計並取得了成功，CruiseControl 是為了開源而重新從頭編寫的版本。CruiseControl 在企業中非常成功，尤其在團隊閱讀了上面的持續整合文章之後，更是成為了不二之選。

早期的持續整合服務器，包括 CruiseControl，通常會有一個「靜默期」來確保接收到所有預期提交的元素。為了實現這一點，當時每次只允許一對開發者進行提交。在使用 CVS 時，團隊中的其他開發者只能在 CruiseControl 發出綠燈後執行「cvs up」，這自動化了上述的「大家，建置通過了」的口頭通知。值得注意的是，CruiseControl 的一個特殊非功能特性是它將其「流水線」配置儲存在原始程式碼控制中。事實上，這與專案的原始程式碼和建置文件放在一起——開發者可以在提交中調整持續整合配置。

<!--
## Apache's Gump

![](to_tbd1.png)

Apache's Gump was built on a similar timeline to CruiseControl but focused more on the binary integration hell of
interdependent Apache (and other) open-source projects. It gave an early warning of integration clashes that were
already or were about to be problematic, for teams. While impressive, it did not gain traction in the enterprise.
This is because enterprises were able to be more buffered from open-source library hell (and the implicit diamond
dependency problem), by limiting the rate at which they upgraded their third-party binary dependencies.

Gump creator, Sam Ruby remembers:

<div style="padding-left: 40px; padding-right: 45px"><span style="font-size: 120%">&ldquo;</span>
The original motivation for Gump wasn't so much continuous<br>
as it was integration - in particular, integration in the large.<br>
Many projects had unit tests but would routinely make changes<br>
that would break their 'contract' and nobody would notice until<br>
well after the changes were released.
</div>
-->

## Apache 的 Gump

<p><img srcset="to_tbd1.png 1x,to_tbd1@2x.png 2x"></p>

Apache 的 Gump 與 CruiseControl 同時期開發，但更多地關注於相互依賴的 Apache（以及其他）開源專案的二進制整合問題。它為團隊提供了早期的整合衝突警告，無論是已經出現的還是即將出現的問題。儘管令人印象深刻，但它並未在企業中獲得廣泛應用。這是因為企業可以通過限制其第三方二進制依賴的升級速度，更好地避免開源套件的問題（以及隱含的鑽石依賴問題）。

Gump 的建立者 Sam Ruby 回憶道：

<div style="padding-left: 40px; padding-right: 45px"><span style="font-size: 120%">&ldquo;</span>
Gump 的初衷並不在於持續性，而是在於整合——特別是大規模的整合。<br>
許多專案都有單元測試，但經常會進行一些更改，這些更改會破壞他們的「契約」，<br>
直到更改發布後很久才有人注意到。
</div>

<!--
## Subversion's "lightweight" branching (2000 through 2001)

![](away_from_tbd1.png)

Karl Fogel helped start Subversion and remembers one early goal was "CVS + atomicity". **The lack of atomicity in CVS
meant that teams had to coordinate as to who was checking in at any one time** and whether they would avoid
accidentally breaking the build as a result. Early CI servers (as mentioned) used to have a "quiet period"
to make sure they had received every last element of an
intended commit, and that was no longer needed for Subversion and its atomic commits.

In comparison to the clunky CVS, Subversion had "lightweight" branching. This made it easier to consider multiple
branches active in parallel and merge the team's changes back later.

Until v1.5 in June 2008, Subversion had an inadequate "merge tracking" capability, eliminating a class of problems
inherent in branching and merging. The internal mechanism of noting the merge tracking was controversial though, and
Subversion still has edge-case merge bugs today. Like this one{{< ext url="https://issues.apache.org/jira/browse/SVN-4635" >}}.

Subversion by default setup a branch called trunk. That said, it allows any branching model to be used.
-->

## Subversion 的「輕量級」分支（2000 至 2001 年）

<p><img srcset="away_from_tbd1.png 1x,away_from_tbd1@2x.png 2x"></p>

Karl Fogel 幫助建立了 Subversion，並記得其早期目標之一是「CVS + 原子性」。**CVS 缺乏原子性，這意味著團隊需要協調誰在任何時刻進行檢入**，以避免意外破壞建置。早期的 CI 服務器（如前所述）通常設有「靜默期」，以確保接收到每一個預期提交的元素，但對於具有原子提交功能的 Subversion 來說，這已經不再需要。

相比於笨重的 CVS，Subversion 提供了「輕量級」分支。這使得考慮多個平行活躍的分支並在後期合併團隊的變更變得更加容易。

直到 2008 年 6 月的 v1.5 版本，Subversion 的「合併追蹤」能力仍不夠完善，這消除了分支和合併固有的一類問題。然而，記錄合併追蹤的內部機制是有爭議的，並且 Subversion 到今天仍然存在一些邊緣情況的合併錯誤。例如這個{{< ext url="https://issues.apache.org/jira/browse/SVN-4635" >}}。

Subversion 默認設置了一個名為主幹的分支。也就是說，它允許使用任何分支模型。

<!--
## Git's "lightweight" branching (2005)

![](away_from_tbd3.png)

In comparison to the clunky Subversion, Git had "lightweight" branching.
This made it easier to consider multiple branches as active (in parallel) and merged back later. Git's merge engine
was very good too, and had merge tracking from the start. It was more able than prior merge technologies to
silently process complexity.

A critical part of Git was local branching. A developer could make multiple local branches, and even map them to the
same remote branch. Say one could be a feature, part complete and another a surprise bug fix to go back first. Or the
developer could be making alternate implementations of the same complicated thing, to decide later which to push back.
Git does not need a centralized server repo, but enterprise teams are going to have one anyway.

Lastly, Git came with a capability to rewrite history. Although this was a general feature, it is where the history
around your local HEAD is rewritten before you push it back to the shared repository, that is of interest. Say your
Agile story was four tasks and there for four local commits, you can effectively squash those into one commit
before you push it back to the shared repository. There are pros and cons to that, but having the choice is cool.

Generally, Git made it much easier to consider multiple branches as a viable team setup.
-->

## Git 的 輕量分支 (2005)

<p><img srcset="away_from_tbd3.png 1x,away_from_tbd3@2x.png 2x"></p>

相較於笨重的 Subversion ， Git 具有「輕量級」的分支模型。這使得同時開多個活躍分支並且稍候再合併回來更容易。 Git 的合併引擎也非常好，並且能夠從提交起點做合併追蹤。它比之前的合併技術更能夠無痛地處理複雜的問題。

Git 的關鍵功能是 Git 能夠在開發者本機建立分支。一位開發者能夠在自己的開發機器上建立多個分支，甚至可以把這多個分支的上游指定到相同的遠端分支。比如，其中一個是功能分支，部份是完整的分支，另一個則是用來做意外的錯誤修復，需要具有最高的優先合併權限。或是開發者可以先建立一個複雜功能的替代實作，稍候再決定要把哪個推回去。 Git 不需要集中式的伺服器來存放程式碼版本庫，但企業級的團隊仍然會使用一個。

最後，Git 具備改寫提交歷史紀錄的能力。儘管這是一個通用的功能，Git 能夠改寫的提交歷史紀錄是指在開發者本機的 HEAD 指標附近還沒推送到遠端共享程式碼版本庫這部份。假設你的 Agile 故事包含四個任務，因此有四個本機的提交，你可以在推送回共享的程式碼版本庫前有效率地把四個提交壓縮成一個提交。這樣做有利有弊，但有選擇是一件很棒的事情。

總之， Git 使得我們更容易把多重分支並行視為一個可行的團隊配置。

<!--
## Google's internal DevOps (2006 onwards)

Google's DevOps quest started in 1998, but was only really shared externally from 2006 onwards.

![](to_tbd3_but_secret.png)

Note: Google were practicing Trunk-Based Development since the beginning - Craig Silverstein (the first hire) remembers
setting it up that way. Much of these were secret to Google until much later, including their recommendations for a
70:20:10 ratio for small:medium:large tests, where 'small' were sub-1ms unit tests (no threading, no I/O), 'medium'
were unit tests that didn't qualify for *small* (and probably did TCP/IP headlessly to something), with 'large' being
slower more costly Selenium functional tests. Pyramid like, and in the early to mid-2000's.

### Home-grown CI and tooling

This was 2002 onwards, but only barely documented outside Google, thus the influence is much smaller.

Google is the most famous example of using Scaled CI infrastructure to keep up with commits (one every 30 seconds on
average) to a single shared trunk. Google's setup would also allow the same infrastructure to verify *proposed* commits.

Their VCS technology, at the outset, was Perforce, and it did not have an ability
to effectively do CI on commits that had not yet landed in the trunk. So Google made their own tooling for this and
pending commits were plucked from developer workstations for verification (and code review - see "Mondrian" below).
After its initial creation, Google's now "Google3" setup, gained a UI, Mondrian (see below)
which made the results of the pre-commit CI verification very clear.

### Mondrian (2006)

![](to_tbd3.png)

Tools for code-reviewers/approvers of proposed contributions to trunk were developed internally at Google in the early
2000's as a command-line tool and part of "Google 3". Things would not land in the shared trunk until everyone agreed.
Their culture was that such that reviews were speedy. Getting pending commits to the point of rejection or acceptance
("Looks Good To Me": LGTM) was almost competitive. Some new Googlers (Nooglers) would pride themselves about taking
on random code-review chores and being one of a few people that weigh into the decision moment.

The code review technology marshaled changes for proposed commits to the trunk and stored them outside the VCS in
question (in a database probably). To do that the tech would reach into the developer machine at the appropriate
moment and make a tar.gz of the changes and the meta-data around them, and pull that back to the central system
for global presentation. Anyone could review anything. A review was just on a commit (not a batch of commits). Therefore
code review was continuous.

Reviewers could quickly bring the
marshaled change down to their workstation to play with it, or use it as a basis for a counter proposal. They could put
that back in review again.

In 2006, Guido van Rossum presented one of his bigger contributions - "Mondrian" -
to Googlers. Here is that 'tech talk' on YouTube:

<div noprint style="position: relative; padding-bottom: 56.25%; padding-top: 30px; height: 0; overflow: hidden;"><iframe src="https://www.youtube.com/embed/sMql3Di4Kgc" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" allowfullscreen="" frameborder="0"></iframe></div>
-->

<!-- print <img src="mondrian.png"> print -->
<!-- print <br/> print -->
<!-- print <a href="https://youtu.be/sMql3Di4Kgc">Video Available at https://youtu.be/sMql3Di4Kgc</a> print -->


<!--
Note at the start he says XP practice
"Pair-Programming" is best, and that code review helps fill the gap for situations where you cannot do it.

See Rietveld and Gerrit further on, for continuations of the Mondrian story.


### Selenium Farm (2006)

![](to_tbd2.png)

Google CI infrastructure was expanded to have **a second tier of elastic infrastructure**, for scaled Selenium/WebDriver
testing.

This "Selenium Farm" (internal cloud) was also available to developers at their desks, who just wanted to run such tests against a stood-up
version of what they were working on. Teams who had to run Firefox (etc) on their own desktop on a Friday, were able
to lease one or more Firefox browsers  in parallel on a Monday, and no longer lock up their developer workstations.

Other companies since have been able to deploy their own Selenium-Grid internally or
leverage one of the online services for elastic Selenium testing.
-->

## Google 在 2006 年之後的內部 DevOps

Google 對 DevOps 的探索開始於西元 1998 年，但直到西元 2006 年後開正式對外分享。

<p><img srcset="to_tbd3_but_secret.png 1x,to_tbd3_but_secret@2x.png 2x"></p>

註記：Google 從一開始就在實踐主幹開發 — Craig Silerstein（第一位員工）記得當時就是這樣設置的。其中許多內容直到很晚之後才對外公開，包括他們對於 小:中:大 測試比例的建議為 70:20:10 ，其中的「小」測試是指小於 1 毫秒的單元測試（無執行緒，無 I/O ），「中」測試是指不適用於「小」測試的單元測試（可能會使用 TCP/IP 連接到某個地方），而「大」測試則是更慢、成本更高的 Selenium 功能測試。這種金字塔式的結構出現在 2000 年代初期到中期。 

### 自家開發的持續整合（CI）與工具

這是從西元 2002 年開始的，但在 Google 以外幾乎沒有被充分記錄，因此影響力要小得多。

Google 最有名的例子就是使用擴展的持續整合（CI）架構來應對快速提交（平均每 30 秒一個提交）到單一共享主幹。Google 的設置還允許相同的架構能夠驗證每個要合併的提交。

在開始時，他們的版本控制系統是 Perforce，並沒有辦法有效率地去對還沒有進入主幹的提交執行 CI。因此，Google 製作了自己的工具從開發者工作機器提取待處理的提交進行驗證（以及程式碼審查 — 請參照下文的「Mondrian」）。從最初的建立之後，Google 的「Google3」的設置新增了一個使用者介面，Mondrian（請參照下文），使得 pre-commit 這個 CI 驗證結果非常清晰。

### Mondrian (2006)

<p><img srcset="to_tbd3.png 1x,to_tbd3@2x.png 2x"></p>

在西元 2000 年初期，Google 內部開發了給程式碼審查著或程式碼批准者使用的工具。這是一個命令列介面工具，也是「Google3」的一部份。在所有人同意之前，提交不會進入共享主幹。他們的文化是，審查者速度很快。將待處理的提交推進到被接受或被拒絕的狀態(LGTM 代表「看起來不錯」)是很多人搶著做的。有些 Google 的新員工（Nooglers）會自豪地承擔隨機的程式碼審查任務，並成為少數參與決策時刻的人之一。

這個程式碼審查技術會把要合併到主幹的變更提交儲存在版本控制系統之外的地方（可能是放在資料庫）。為了達成這點，這個技術會在適當的時機存取開發者主機，把修改變更打包成 tar.gz 這樣的壓縮文件丟回中央系統來處理。任何人都可以審查任何內容。一個審查只針對一個提交（不是批次的提交）。因此，程式碼審查是連續進行的。

審查者可以快速將整理後的更改下載到自己的工作電腦上處理，或者以此為基礎做接續的審查建議。他們可以再度把修改審查一次。

在西元 2006 年，Guido van Rossum 向 Google 員工展示他的一項重要貢獻 — *Mondrian*。這是在 Youtube 上的技術演講：

<div noprint style="position: relative; padding-bottom: 56.25%; padding-top: 30px; height: 0; overflow: hidden;"><iframe src="https://www.youtube.com/embed/sMql3Di4Kgc" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" allowfullscreen="" frameborder="0"></iframe></div>

<!-- print <img src="mondrian.png"> print -->
<!-- print <br/> print -->
<!-- print <a href="https://youtu.be/sMql3Di4Kgc">影片連結在此 https://youtu.be/sMql3Di4Kgc</a> print -->

注意，在演講一開始，他提到 XP 實踐中「配對開發」是最好的，並且程式碼審查有助於補足無法進行配對開發的情況。

另外可以查看 Rietveld 與 Gerrit，這些是 Mondrian 故事的延伸。

### Selenium Farm (2006)

<p><img srcset="to_tbd2.png 1x,to_tbd2@2x.png 2x"></p>

Google CI 架構被擴展，增加了**第二層彈性基礎架構**，用於擴展的 Selenium 或 WebDriver 測試。

這個「Selenium Farm」（內部雲）也可以供開發者在他們的桌機上運行這些測試，他們只是想對他們正在開發的版本運行這些測試。那些必須在周五在自己桌機運行 Firefox 的團隊，能夠在周一可以平行執行至少一個以上的 Firefox 瀏覽器而不會被他們開發者的工作機器鎖定。

其他公司此後也能夠在內部部署自己的 Selenium 網格，或者利用線上服務進行彈性的 Selenium 測試。

<!--
## Branch by Abstraction technique (2007)

![](to_tbd3.png)

Paul Hammant blogged about a 2005 ThoughtWorks client engagement in a Bank of America software development team,
that used the Branch by Abstraction technique{{< ext url="http://paulhammant.com/blog/branch_by_abstraction.html" >}}.
Whereas many had previously used this technique to avoid longer version-control branches in a trunk model, this was the
first time it had been detailed online and given a name (by Stacy Curl).
-->

## 抽象分支技術（2007）

<p><img srcset="to_tbd3.png 1x,to_tbd3@2x.png 2x"></p>

Paul Hammant 在自己的 blog 中提到了 2005 年 ThoughtWorks 與美國銀行軟體開發團隊的合作案例，該團隊使用了分支抽象技術{{< ext url="http://paulhammant.com/blog/branch_by_abstraction.html" >}}。儘管在此之前許多人已經使用這個技術來避免長期功能分支出現於主幹開發中，但這是第一次在網上詳細介紹並給予了一個名字（由 Stacy Curl 命名）。

<!--
## GitHub's entire initial platform (2008)

![](away_from_tbd2.png)

GitHub was launched as a portal on February 8, 2008, and features have been added steadily ever since. The initial
version contained forks, which was a formal way of expressing the directionality of related DVCS repositories, and
promoting a forgiveness model for unsolicited changes to source code (as opposed to the permission model that preceded it
for other portals).

### Pull Requests (2008)

GitHub added "Pull-Requests" (PRs) on Feb 23rd, 2008{{< ext url="https://github.com/blog/3-oh-yeah-there-s-pull-requests-now" >}},
while in beta, and popularized the entire practice for the industry when they came out of beta in April of that year.
For source/repo platforms, and VCSs generally, this and "forking generally" was a total game changer, and commercial
prospects of other companies were decided based on their ability to react to this culture change.

#### Code Review built in

Pull Requests came with an ability to leave code review comments for the contribution. That meant that "upstream"
receivers of contributions could parry them with feedback, rather than consume them and fix them which was common
previously.

#### No more clunky patch sets

GitHub's PR system used real branches in Git, and the forks aspect took advantage of the 'D' distributed in DVCS
(albeit distributed to somewhere else in GitHub's server-side directory structure).

The open-source community for one could now step away from patch-sets that were donated by email (or other rudimentary mechanisms).
This forced the entire VCS industry to take note, and plan equivalents, or commit to withering in terms of market
share. It greatly facilitated multi-branch development for teams of course, including (sadly) multiple long-lived
branches.

Pull-Requests changed the dynamics of open source. Now, the original creator of open source was forced to keep up
with PRs because if they did not, one fork with more activity and forward momentum, might steal the community. Perhaps
rightfully so.

#### Timing

In terms of timing GitHub's PR-centric code review was available for open-source use a couple of months before
Google's Rietveld was released, but a 18 months or so after Mondrian was presented in a tech talk that was put out on 
video.google.com.  A few years later Google turned off video.google.com and moved the Mondrian tech-talk video to Youtube 
with its 2006 heritage being a mere note in the "Published on Aug 22, 2012" posting.

### Rietveld code Review (2008)

After Mondrian and while at Google, Guido released Rietveld{{< ext url="https://github.com/rietveld-codereview/rietveld" >}}
in its image (May, 2008) and a fork of that the Gerrit{{< ext url="https://www.gerritcodereview.com" >}} (Oct, 2008) gained a lot of
interest. Facebookers went on to make a similar Phabricator{{< ext url="https://en.wikipedia.org/wiki/Phabricator" >}}
and released that as open source too (Oct, 2010).
-->

## GitHub 的整個初始平台（2008）

<p><img srcset="away_from_tbd2.png 1x,away_from_tbd2@2x.png 2x"></p>

GitHub 在西元 2008 年二月八號建立一個入口網站，並自那時以來不斷增加功能。最初的版本包含了分岔，這是一種表達與 DVCS 相關程式碼版本庫變化方向的正式方式，並且促進了一種處理非授權方式變更程式碼的寬恕模式（與其相對就是在 GitHub 出現前入口網站所使用的權限模式）。

### Pull Requests（2008）

GitHub 在西元 2008 年 2 月 23 日在測試階段新增了「Pull-Requests」（PR）功能{{< ext url="https://github.com/blog/3-oh-yeah-there-s-pull-requests-now" >}}，並且在同年 4 月正式發布時將這一功能推廣至整個業界。對於原始碼、程式碼版本庫平台與版本控制系統來說，這個動作與「forking generally」是個殺手級應用足以改變整個市場。其他公司的商業前景也取決於它們對於這一次文化變革的應變能力。

#### 內建的程式碼審查

Pull Requests 具有留下程式碼審查評論的功能。這代表「上游」的接收者可以對貢獻做反饋，而不是像之前那樣直接接受並修復它們。

#### 不再需要巨大的修補集合

GitHub 的 PR 系統使用了 Git 中的真實分支，而 fork 功能則利用了分散式版本控制系統（DVCS）的「D」（分散式），儘管是分散到 GitHub 伺服器端目錄結構中的其他地方。

開源社群首先可以擺脫透過信件來做貢獻（或是其他簡陋機制）的修補集合。這迫使整個版本控制系統（VCS）行業注意到這點，並且做出對應的計劃，否則就會在市場佔有率上萎縮。這很大地促進團隊的多分支開發模型發展，包括（遺憾地是）多個長期分支模型。

Pull-Requests 改變了開源社群的動態。現在，開源專案的原始創作者被迫要跟上使用 PRs 的開源方式。因為如果不這樣做，一個活動更頻繁、前進動力更強的分支可能會偷走整個社群。也許確實如此。

#### 時機點

在發布的時機點上，GitHub 的 PR 中心化程式碼審查功能在開源專案中釋出的時間比 Google 的 Rietveld 發布早了幾個月，但比 Mondrian 在技術講座中展示並在 video.google.com 上發布晚了大約 18 個月。幾年後，Google 關閉了 video.google.com，並將 Mondrian 技術講座視頻移至 YouTube，上面標註了西元 2006 年的歷史背景，但在「Published on Aug 22, 2012」的發布訊息中僅作為一個註腳。

### Rietveld 程式碼審查（2008）

在 Mondrain 之後，Guido 在 Google 工作期間發布了 Rietveld{{< ext url="https://github.com/rietveld-codereview/rietveld" >}}，這是基於 Mondrain 映像檔（西元 2008 年 5 月）來做開發的。隨後，Gerrit{{< ext url="https://www.gerritcodereview.com" >}}（西元 2008 年 10 月）這個基於 Mondrain 的一個分支獲得很大的關注。Facebook 也開發了一個類似的工具 Phabricator{{< ext url="https://en.wikipedia.org/wiki/Phabricator" >}}，並於 2010 年 10 月將其作為開源專案發布。

<!--
## Continuous Delivery Book (2010)

![](to_tbd2.png)

See [Publications - Continuous Delivery](/publications/index.html#continuous-delivery-july-27-2010)

Jez Humble{{< ext url="https://continuousdelivery.com" >}} and Dave
Farley{{< ext url="http://www.continuous-delivery.co.uk" >}} wrote this influential book after a
ThoughtWorks project in London that finished in 2007.
The client was AOL - enough time has passed to share that. Specific DevOps advances were
being made across the industry, but a critical aspect of this mission was that the prescribed go-live date was tight, given the known
amount of work to be completed before then. Tight enough to want to compress the classic 'coding slows down, and
exhaustive user acceptance testing starts' phase of a project. The team had to pull the trigger on plenty of
automated steps, to allow faster feedback loops. This allowed then to have a high confidence in the quality of commits, from only
minutes before. CI pipelines and delta-scripts for database table-shape migrations, in particular, were focused on.

The 2010 'Continuous Delivery' book is the bestselling result. It has been translated into three languages since, and
both authors now have careers that further deliver/describe the benefits for clients. The book ties the foundational
aspects of DevOps, Continuous Integration pipelines, and tight lean-inspired feedback loops together to get a broad
and deep definition of how we should develop software collectively in 2010 and onwards.

Anecdotally the pipelines thinking captures a linear representation of Mike Cohn's famous "Test Pyramid" from his 2009 book,
"Succeeding with Agile"{{< ext url="https://www.amazon.com/gp/product/0321579364" >}}. See Mike's blog entry a month
later too{{< ext url="https://www.mountaingoatsoftware.com/blog/the-forgotten-layer-of-the-test-automation-pyramid" >}},
as well as Martin's recap in 2012{{< ext url="https://martinfowler.com/bliki/TestPyramid.html" >}}.

Dan North{{< ext url="https://dannorth.net" >}} (Mr. BDD), Chris Read{{< ext url="https://www.linkedin.com/in/devopscread" >}}
(an unsung DevOps pioneer) and Sam Newman{{< ext url="http://samnewman.io" >}} were also key in the AOL advances.
Dan North gave a deeper account of the mission at GOTO in 2014{{< ext url="https://speakerdeck.com/tastapod/the-birth-of-devops" >}}
(no video sadly) and was interviewed later by InfoQ{{< ext url="https://www.infoq.com/news/2014/07/birth-cd-devops" >}}.

A year or so before that mission, Sam and Dave were on a different client, UK retailer 'Dixons'. They were part of a team rolling out  
emergent DevOps practices, which they would get to reuse and refine on the following AOL mission. Standouts were:

1. making the test environments have consistent behavior with production environments (very close by not quite 'Infrastructure as Code')
2. QA automation technologies setup by the dev team
3. inducting/co-locating individual QAs with the dev team
4. Test Driven Development (TDD)
5. Acceptance Test Driven development (ATDD)
6. a CI pipeline that included performance tests
7. a focus of team dynamics for high throughput
-->

## 持續交付書籍（2010）

<p><img srcset="to_tbd2.png 1x,to_tbd2@2x.png 2x"></p>

請參閱[出版品 - Continuous Delivery](/publications/index.html#continuous-delivery-july-27-2010)。

Jez Humble{{< ext url="https://continuousdelivery.com" >}} 與 Dave Farley{{< ext url="http://www.continuous-delivery.co.uk" >}} 在西元 2007 年完成一個位於倫敦的 ThoughtWorks 專案後，寫了這本具有影響力的書。客戶是 AOL — 時間過去地足夠久了，可以透露這個細節。當時業界正在進行特定的 DevOps 進展，但是考慮到在上限日期要完成的工作量，這個專案的一個關鍵的點是預定的上線日期非常緊迫。如此緊迫，以至於不得不壓縮專案中經典的「減緩撰寫程式碼」，並且開始全面使用者驗搜測試的階段。團隊必須要觸發許多自動化步驟，來達到更快的反饋循環。這讓他們對剛剛提交的程式碼質量有很高的信心。他們特別專注於 CI 流水線和資料庫表結構遷移的差異腳本。

西元 2010 年的《Continuous Delivery》書是這一結果的暢銷作品。從此之後，這本書已經被翻譯成三種語言，兩位作者現在也在各自的職業生涯中進一步為客戶傳遞和描述這些益處。這本書將 DevOps 的基礎概念與持續整合的 pipelines 以及緊密的精實反饋循環結合在一起，給出了在西元 2010 年及之後如何多人協做開發軟體一個廣泛而深刻的定義。

據說，流水線的思維方式捕捉到了 Mike Cohn 在他西元 2009 年出版的《Succeeding with Agile》{{< ext url="https://www.amazon.com/gp/product/0321579364" >}}一書中的著名*測試金字塔*線性表達式。請參閱 Mike 一個月後的部落格文章{{< ext url="https://www.mountaingoatsoftware.com/blog/the-forgotten-layer-of-the-test-automation-pyramid" >}}，以及在 Martin 西元 2012 年的回顧{{< ext url="https://martinfowler.com/bliki/TestPyramid.html" >}}。

Dan North{{< ext url="https://dannorth.net" >}}（BDD 之父），Chris Read{{< ext url="https://www.linkedin.com/in/devopscread" >}}（一位未被歌誦的 DevOps 先驅）和 Sam Newman{{< ext url="http://samnewman.io" >}} 在 AOL 的進展中也扮演了重要的角色。Dan North 在西元 2014 年的 GOTO 大會上更深入介紹了這個理念{{< ext url="https://speakerdeck.com/tastapod/the-birth-of-devops" >}}（可惜當時沒有錄影），並在後來接受了 InfoQ 的採訪{{< ext url="https://www.infoq.com/news/2014/07/birth-cd-devops" >}}。

在那次活動的前一年，Sam 與 Dave 在另一個客戶—英國零售商「Dixons」。他們是當時團隊的一部份，該團隊正在推出新興的 DevOps 實踐，並在隨後的 AOL 任務中能夠重複使用與改進。突出的亮點有以下：

1. 讓測試環境與正式環境的行為保持一致（非常接近，但上未達到「以程式碼來版控基礎設施（Infrastructure as Code）」)
2. 開發團隊設置 QA 自動化技術
3. 將個別的 QA 人員引導並合併到開發團隊內
4. 測試驅動開發（TDD）
5. 驗收測試驅動開發（ATDD）
6. 把效能測試加入 CI pipeline 中
7. 專注於團隊動態來產出

<!--
## Travis-CI's GitHub integration and pass/fail badges (2011)

![](to_tbd1.png)

In 2011, Travis-CI{{< ext url="https://travis-ci.com/" >}} provided easy integrations into GitHub's platform run CI
builds for Pull Requests and the general state of HEAD on any branch. This was visually indicated with "build passes" and
"build fails" badges were inserted into the GitHub UI{{< ext url="https://docs.travis-ci.com/user/status-images/" >}}.
This made it was clear whether the proposed PR would break the build or not were it to be merged into trunk.
-->

## Travis-CI 的 GitHub 整合與成功與失敗的徽章（2011）

<p><img srcset="to_tbd1.png 1x,to_tbd1@2x.png 2x"></p>

在西元 2011 年，Travis-CI{{< ext url="https://travis-ci.com/" >}} 提供了簡易整合到 GitHub 平台的能力，可以對 Pull Requests 與任意分支上的 HEAD 進行 CI 建置。這個建置結果會以「build passes」與「build fails」徽章形式顯示在 GitHub 的 UI 中{{< ext url="https://docs.travis-ci.com/user/status-images/" >}}。這樣一來，就能夠清楚地在合併到主幹之前知道要被審核的 PR 是否會在合併到之後會不會破壞建置。

<!--
## Microservices (2011 and 2012)

The emergence of micro-services as small buildable/deployable things that are glued together with TCP/IP (and
XML/YAML/DNS configuration) reinforced "many small repositories" (they kind of reinforce each other really), while this can be
done with any branching model, the non-trunk models probably had the mindshare. Monorepos were out completely. A
possibility from monorepos teams sharing code and source level a HEAD revision, positively laughed it. The history
page of Wikipedia lists multiple people concurrently pushing the same emergent micro-service
idea{{< ext url="https://en.wikipedia.org/wiki/Microservices#History" >}}.
-->

## 微服務（2011 與 2012）

微服務的出現，也就是那個可以獨立建置與部署的小型服務，通過 TCP/IP（以及 XML、YAML 或 DNS 的配置）進行整合，強化了「多個小型程式碼版本庫」的概念（兩者其實是互相強化）。雖然可以使用任何分支模型來實現，但是非主幹的分支模型可能更受到關注。單一版本庫完全被拋棄。從單一版本庫的團隊分享出來程式碼與原始碼 HEAD 的修訂版本來看，這種想法被完全否定。維基百科的歷史頁面列出了多個人同時推動這個新興的微服務理念{{< ext url="https://en.wikipedia.org/wiki/Microservices#History" >}}。

<!--
## Case Study: A Practical Approach To Large-Scale Agile Development (2012)

![](to_tbd1.png)

Gary Gruver, Mike Young, and Pat Fulghum wrote
"A Practical Approach To Large-Scale Agile Development"{{< ext url="https://www.amazon.com/dp/0321821726" >}}
to describe the multi-year
 transformation programme in the HP LaserJet Firmware division. In 2008, there were over 400 engineers dotted around
 the world working on over 10 million lines of printer firmware code in the HP LaserJet Firmware division. There
 were 10+ long-lived release feature branches (one for each product variant), with 1 week required for a build and
 6 weeks required for manual regression testing. The engineers spent 25% of their time working on product support i.e.
 merging features between branches and only 5% of their time on new features.

 For the next couple of years, HP committed to a huge investment in Trunk-Based Development and
 Continuous Integration. All product variants were re-architected as a single product on a Git super-repo, per-variant
 features extracted into XML config files, all engineers worldwide were given the same virtual machine for development,
 and a huge multi-tier continuous build process was fully automated in-house. The results were outstanding, with build
 time reduced to 1 hour and manual testing replaced with a 24 hour fully automated test suite including printing
 test pages. 10-15 builds could be produced a day, engineers spent 5% of their time not 25% on product support and 40%
 of their time not 5% of their time on new features. That is an 8x increase in productivity for 400 engineers.
-->

## 案例研究： 大規模敏捷開發的實際方法（2012）

<p><img srcset="to_tbd1.png 1x,to_tbd1@2x.png 2x"></p>

Gary Gruver、Mike Young 和 Pat Fulghum 共同著作的《A Practical Approach To Large-Scale Agile Development》描述了 HP LaserJet 軔體部門進行的多年轉型計劃。在西元 2008 年，HP LaserJet 軔體部門有超過 400 名工程師，分佈在世界各地，處理著超過一千萬行印表機軔體的程式碼。當時，有超過 10 個以上的長期存在的發布功能分支（每個分支代表一個產品），一次建置需要一周，手動做回歸測試則需要六周。工程師們花費 25% 的時間在分支之間合併功能，而只剩下 5% 的時間用於開發新功能。

在接下來的幾年中，HP 致力於在主幹開發與持續整合方面進行大量投資。全部的產品變體被重新設計為單一產品在一個 Git 的超級程式碼版本庫，每個變體的功能都被提取到 XML 的配置檔案中。全球的工程師都使用相同的虛擬機器進行開發，並且內部完全自動化一個巨大多層次的持續建置流程。這些措施帶來了卓越的成果：建置時間縮短到 1 小時，手動測試被 24 小時全自動測試套件取代，包括列印測試頁。每天可以產生 10 到 15 次建置，工程師花費在產品支持上的時間從 25% 降到 5%，而在新功能開發上的時間從 5% 增加到 40%。這意味著 400 名工程師的生產力提高了 8 倍。

<!--
## TravisCI's per-commit speculative mergeability analysis (2012)

![](to_tbd1.png)

TravisCI was the first{{< ext url="https://blog.travis-ci.com/announcing-pull-request-support" >}} CI service to 
automatically predict a GitHub pull-request's mergeability AND build success/failure 
as if they had landed in main/trunk. Specifically:

1. a speculative merge back to the main/trunk/mainline - only into working-copy as it is for analysis only
2. all the classic compile/unit-test/integration-test/functional-test steps of the regular build, in situ

The speculative merge is discarded every time after #1 (if it can't merge) or #2 (regardless) -
the actual merge result is never pushed off the build server to the remote (in Git terms). It is only the "is this
buildable and mergeable or not" notification that was desired from the exercise.

This feature of TravisCI is for [short-lived feature branches](/short-lived-feature-branches/), 
it is clear now that teams should do
this CI setup **regardless of their branching model**. Yes, even the long-lived branching models also benefit from this,
though they'll be challenged to stay 'green' the whole time, and remain eminently and automatically mergeable back to
the mainline/main.

A few months later, Team City implemented the same feature - {{< ext url="http://tech.labs.oliverwyman.com/blog/2013/01/13/continuous-integration-for-github-pull-requests-with-teamcity/" >}}, 
and a year later Snap-CI also did{{< ext url="https://blog.snap-ci.com/blog/2013/11/07/automatic-branch-tracking-and-integration/" >}} 

What is a reality
in 2017 is that the high bar is every commit, **every branch**, with that speculative merge, and elastically scaled so
that the notification is within seconds of pushing the commit to the shared VCS. Back in 2001 (CruiseControl) we were batching
commits, we would wait a little while to allow checkins to finish (particularly for the non-atomic CVS), and humans would
have to pick apart who actually broke the build.

Surely teams not doing Trunk-Based Development would turn on this speculative merge and build capability for every branch and soon after plan their migration to Trunk-Based Development.
-->

## TravisCI 的每次提交推測可合併性分析（2012）

<p><img srcset="to_tbd1.png 1x,to_tbd1@2x.png 2x"></p>

TravisCI 是第一個自動預測 GitHub 拉取請求可合併性與預測合併到主幹後會建置成功或建置失敗的持續整合服務{{< ext url="https://blog.travis-ci.com/announcing-pull-request-support" >}}。其特點如下：

1. 對主幹分支進行預測可合併性—只有在工作副本中進行分析。
2. 執行正規建置的所有步驟，包括編譯、單元測試、整合測試與功能測試。

每次預測性合併在步驟 #1（如果無法合併）或是步驟 #2（無論結果如何）後都會被丟棄—實際的合併結果永遠不會從建置伺服器推送到遠端（以Git 的術語來說）。這個練習只需要「是否能夠建置與是否能夠合併」的通知。

這項功能適用於[短期功能分支](/short-lived-feature-branches/)。現在很明顯，不論團隊採用哪種分支模型，都應該採用這個持續整合的設定。是的，即使是長期分支模型也能從中受益，雖然要隨時保持「綠色」狀態並且隨時可自動合併回主分支是一件不容易的事情。

幾個月後，Team City 實現了相同的功能—{{< ext url="http://tech.labs.oliverwyman.com/blog/2013/01/13/continuous-integration-for-github-pull-requests-with-teamcity/" >}}。一年後， Snap-CI 也實現了這個功能{{< ext url="https://blog.snap-ci.com/blog/2013/11/07/automatic-branch-tracking-and-integration/" >}}。

在西元 2017 年，現實的情況是每次提交、**每個分支**都應該進行預測性合併，並且彈性擴展，來達到在提交推送到共享的版本控制系統幾秒內收到通知。回到西元 2010 年，（CruiseControl）我們會批次提交，等待一段時間讓提交可被檢核完成（特別是針對非原子性的 CVS），並且需要人工地去判斷是哪些提交破壞了建置。

肯定的是，即使是不做主幹開發的團隊也會為每個分支開啟預測性合併與建置的功能，並且在不久後機會遷移到主幹開發。

<!--
## PlasticSCM's semantic merge (2013)

![](away_from_tbd1.png)

Plastic's semantic diff and merge{{< ext url="http://semanticmerge.com/" >}} capability was launched in March
2013{{< ext url="https://www.infoq.com/news/2013/04/Semantic-Merge" >}}. It allowed a greatly reduced diff for
refactoring commits.

If merges between branches are required, and larger
code changes (like refactorings) are desired, then multi-branch development is a little easier with this. However, Trunk Based
Development's commits are more elegant too, because of it, and in the fullness of time, it might make
on techniques like Branch by Abstraction easier, or reduce the need for it, if merge conflicts happen less often
(according to source-control) for something in 2012 that would have been a definite clash.

Other source-control tools are not doing semantic diff/merge yet (2017), but they should be. Semantic merge is
just as useful for Trunk-Based Development and multi-branch models. It means that there are less likely to be clash
situations for commits a developer wants to do. Maybe that last vision is not quite complete yet, but there's a direction
 to go in now.
-->

## Plastic 的語意合併（2013）

<p><img srcset="away_from_tbd1.png 1x,away_from_tbd1@2x.png 2x"></p>

Plastic 的語意差異與合併功能{{< ext url="http://semanticmerge.com/" >}}於西元 2013 年三月推出{{< ext url="https://www.infoq.com/news/2013/04/Semantic-Merge" >}}。這項功能允許在進行重構提交時大幅減少差異。

如果需要在多個分支間進行合併，並且需要進行範圍比較大的程式碼修改（比如重構），使用多個分支模型開發會更容易達成。然而，語意合併技術也使得主幹開發更加優雅。隨著時間的推移，它可能會讓像抽象分支這樣的技術更容易使用，或者在合併衝突的減少情況下（基於原始碼控制），減少這種技術的需求。

其他原始碼控制工具（截至西元 2017年）還沒有實現語意差異與語意合併的功能，但他們應該這樣做。語意合併對於主幹開發與多分支模型同樣有用。語意合併意味著讓開發者希望提交的程式碼修改更不容易發生衝突。也許這種願景還不完全成熟，但現在已經有了一個明確的方向。

<!--
## Google revealing their Monorepo Trunk (2016)

![](to_tbd3.png)

In none other than the Association for Computing Machinery's magazine, Googlers Rachel Potvin and Josh Levenberg share
how Google arranges for 95% (25,000) of its software developers to share one trunk in "Why Google Stores Billions of
Lines of Code in a Single Repository"{{< ext url="http://cacm.acm.org/magazines/2016/7/204032-why-google-stores-billions-of-lines-of-code-in-a-single-repository/fulltext" >}}.
They use a [Monorepo](/monorepos/) variant of a trunk, with internal code shared at **source level**, for high-throughput,
low-defect delivery of multiple applications and services. Each application/service has a release cadence chosen by the dev+biz
team in question. Yes, everything works just fine.

A couple of months later, Rachel Potvin presented at the @Scale Conference on the same topic{{< ext url="https://youtu.be/W71BTkUbdqE" >}} - "Why Google Stores Billions of Lines of Code in a
Single Repository":

<div noprint style="position: relative; padding-bottom: 56.25%; padding-top: 30px; height: 0; overflow: hidden;"><iframe src="https://www.youtube.com/embed/W71BTkUbdqE" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" allowfullscreen="" frameborder="0"></iframe></div>
-->
<!-- print <img src="google-tbd.png"> print -->
<!-- print <br/> print -->

## Google 展示他們的單一版本庫主幹（2016）

<p><img srcset="to_tbd3.png 1x,to_tbd3@2x.png 2x"></p>

在 ACM[^acm] 的雜誌上，Google 的員工 Rachel Potvin 和 Josh Levenberg 分享了 Google 如何安排 95%（25000 名）軟體開發者共享一個主幹的做法。請參閱*為何 Google 把十億行程式碼儲存在一個單一版本庫內*{{< ext url="http://cacm.acm.org/magazines/2016/7/204032-why-google-stores-billions-of-lines-of-code-in-a-single-repository/fulltext" >}}。他們使用的是[單一版本庫](/monorepos/)變體的主幹，內部程式碼在**原始碼層面**共享，來達成高產出與低出錯率交付多個應用與服務。每個應用與服務的發布節奏由開發團隊與業務團隊自行決定。是的，一切都運行地很好。

幾個月後， Rachel Potvin 在 @Scale 會議上針對同一個主題進行演講{{< ext url="https://youtu.be/W71BTkUbdqE" >}}—「為何 Google 把十億行程式碼儲存在一個單一版本庫內」：

<div noprint style="position: relative; padding-bottom: 56.25%; padding-top: 30px; height: 0; overflow: hidden;"><iframe src="https://www.youtube.com/embed/W71BTkUbdqE" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" allowfullscreen="" frameborder="0"></iframe></div>
<!-- print <img src="google-tbd.png"> print -->
<!-- print <br/> print -->

[^acm]: [電腦協會](https://zh.wikipedia.org/zh-tw/%E8%AE%A1%E7%AE%97%E6%9C%BA%E5%8D%8F%E4%BC%9A)（英語：Association for Computing Machinery，簡稱ACM）是一個世界性的電腦從業員專業組織。

<!--
## Microsoft's Git Virtual File System (2017)

![](to_tbd1.png)

Microsoft released ~~GitVFS~~ GVFS in early 2017 on GitHub{{< ext url="https://github.com/Microsoft/GVFS" >}}.

This new technology deserves time and analysis before the full impact is determined. There is a suggestion from Brian Harry's
blog{{< ext url="https://blogs.msdn.microsoft.com/bharry/2017/02/07/more-on-gvfs" >}} that branch reduction was one of
the motivators.
-->

## Microsoft 的 Git 虛擬檔案系統（2017）

<p><img srcset="to_tbd1.png 1x,to_tbd1@2x.png 2x"></p>

Microsoft 在西元 2017 年初在 GitHub 上發布了 ~~GitVFS~~ GVFS{{< ext url="https://github.com/Microsoft/GVFS" >}}。

這項新技術值得深入研究與分析，來確定其全面性的影響。根據 Brian Harry 的部落格文章{{< ext url="https://blogs.msdn.microsoft.com/bharry/2017/02/07/more-on-gvfs" >}}說法，減少分支是其中一個動機。

<!--
# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>
-->

# 其他參考資料

<a id="showHideRefs" href="javascript:toggleRefs();">顯示其他參考</a>

<div>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">13 Nov 2013, Talk</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://www.youtube.com/watch?v=2QGYEwghRSM">A Practical Approach to Large Scale Agile Development</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">14 Jan 2015, Blog entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://dizzythinks.net/from-212-days-to-212-seconds-the-birth-of-devops.html">From 2½ Days to 2½ Seconds - the Birth of DevOps</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">23 Apr 2015, Blog entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://paulhammant.com/2015/04/23/the-origins-of-trunk-based-development/">The origins of Trunk-Based Development</a></td>
        </tr>
    </table>
</div>
