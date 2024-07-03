---
date: 2016-08-01T09:42:02+05:00
title: 觀察到的習慣
weight: 81
---

<!--
## No Code Freeze

Developers living in a Trunk-Based Development reality, mostly do not experience variance in their days or weeks on the 
trunk. In particular, there is no "we're close to a release so let's freeze code", and generally there is no indication 
of a slowdown in proximity to a release.  Sure, a couple of developers out of a team might be assigned to bug-fixing closer
to the release but everyone else is going to work at full speed. 

Generally speaking, the trunk is a place to firehose commits into, and the habits of the developers are such that 
everything is ready to go live. If a team is doing 12 releases a year, then a release branch that is cut on the just in time 
basis and is the one that is observed to be 'frozen' because of the absence of developers. Refer [branch for release](/branch-for-release/).
-->

## 不需凍結版本

使用主幹開發的日常生活中，開發者每天和每週工作通常不會有太大變化。特別是，沒有「我們即將發布，所以讓我們凍結版本」，通常也不會出現接近發布時，開發速度會變慢的狀況。當然，團隊中的幾個開發者可能會在發布前被分配去修復錯誤，而其他人仍將保持全速工作。

一般來說，主幹是一個快速大量提交的地方，開發者的習慣是確保所有的程式碼都準備好可以隨時上線。如果一個團隊每年發布 12 個版本，那麼按需求建立的發布分支會是唯一會看到是處於「凍結」狀態的，因為開發者不會在那裡繼續開發。請參閱[為發布建立分支](/branch-for-release/)。

<!--
### Every Day is the same

Ignoring meetings, developers commit/push at the same rate and to the same place regardless of the day of the week or 
the week of the month. This is a reinforcement of the "No Code Freeze" rule above. Sure a small subset of the team
may focus on an imminent release (bug fixes in the trunk, cherry-picked to the release branch), but the majority
should be focusing on 'business as usual' implementation of functionality for a future release.
-->

### 不變的日常生活

排除會議的影響，開發者無論周幾或月份的哪一周，提交和推送變更的速度和目標位置[^place]都是一致的。這加強了上述「不需凍結版本」規則。當然，部分團隊成員可能會專注於即將發布的版本（在主幹修復錯誤，以及挑選既有的提交到發布分支），但大多數成員應該專注於「照常進行」的未來版本功能的開發。

[^place]: 目標位置也就是版本控制系統中的分支或程式碼版本庫。

<!--
## Quick Reviews

Teams doing Trunk-Based Development know that their commits/pushes will be scrutinized by others, as soon
as they have landed on the shared trunk. They are keen on bringing that forward, not delaying it, so they may prefer to 
pair-program on code changes. Or they may ask colleagues for a code review at the time the change is submitted to be 
merged into the trunk.
-->

## 快速審查

實踐主幹開發的團隊很清楚，一旦他們的提交被推送到主幹，就會受到其他成員的檢視。他們不想拖延，而是希望能提前進行這項檢查，因此可能更喜歡在程式碼變更的當下進行配對開發，或者在變更提交到主幹合併之前，請同事進行程式碼審查。

<!--
## Chasing HEAD

Trunk-Based Development teams update/pull/sync from the shared trunk often. Many times a day in fact. 
-->

## 緊跟著主幹的最新進度

主幹開發的團隊經常會從主幹同步程式碼到個人電腦。事實上，他們一天可能要做好幾次這樣的動作。

<!--
## Running the build locally

Developers practicing Trunk-Based Development run the build before a commit/push in order to not break the build. 
This one practice, for very small teams, allows them to not set up a CI server until later. If they cannot push their 
commits to the shared trunk because someone else beat them to it then they have to do another update/sync/pull and
another build and push their revised commit(s). "It worked on my machine" says the developer that does not 
want to confess to breaking the build (assuming quick reliable idempotent builds).
-->

## 在本地執行建置

採用主幹開發的開發者在提交或推送之前會先執行建置，以確保不會造成建置失敗。

這項做法對於非常小的團隊來說，可以讓他們在稍後才設置持續整合伺服器。如果因為有人早先一步提交，而無法將提交推送到主幹，那麼他們就必須再次從主幹同步程式碼到個人電腦，然後重新建置並推送修訂後的提交。

「這在我的電腦上是正常的」，這是那些不想承認自己搞砸建置的開發者的說法（假設建置是快速可靠且冪等的）。

<!--
## Facilitating commits

Because everyone in a team is chasing HEAD of the trunk, there could be a moment where one change is imagined that
could inconvenience everyone else in some way. Say a big directory rename as part of an extensive rework of the 
source with it. It could be that the developer performing those two changes does the rename first and pushes it through to 
the trunk where everyone will get it on the next pull/sync/update. It might be that if separated somehow, the rename
on its own is easier to consume by teammates, with the second being a relatively smaller commit later.

Git and Mercurial track files through their content rather than by directory and file name, so they make light of the 
situation described above, anyway.
-->

## 便於提交

因為團隊中的每個人都在追蹤主幹的最新版本，所以可能會出現其中一個變更會以某種方式給其他人帶來不便。比如說，作為程式碼大規模重構的一部分，包含進行一個大規模目錄重命名。這種情況下，執行該任務的開發者可能會先進行重新命名，並將其推送到主幹，這樣所有人都會在下一次同步程式碼時獲得這些變更。如果分開進行，單獨執行重新命名可以更容易被團隊成員接受，而後續的小改動則可以稍後提交。

Git 和 Mercurial 通過文件的內容而不是目錄和文件名來追蹤文件，因此它們在上述情況下可以輕鬆應對。

<!--
## Powering through broken builds

So because of that lazy developer, or the flaky build, or pure accident of timing (Google has a commit every 30 
seconds into their monorepo - there must be quantum entangled commits on a 0.0001% basis), the trunk will be observed 
to be broken occasionally. 

The best implementations are going to perform automatic rollback of a broken commit that lands in the trunk. The 
developer gets notified and they get to fix it quietly on their workstation.

A developer wanting to update/pull/sync from the shared trunk often runs the risk of encountering that 
statistically improbable broken build. They do not want to have the commits that broke the trunk, on their workstation
if they are developing. So what they do is update/pull/sync to the last known good commit, and only go further
ahead when the trunk build is officially repaired. This way they know they can stay 'green' on their workstation. Some 
companies engineer a system where the last known good commit hash/number is stored in a network share, and a shell 
script used for update/pull/sync does so to that instead of HEAD revision.
-->

## 克服壞掉的建置

偶爾會在主幹上觀察到建置壞掉的情況，可能是因為某個懶惰的開發者，或純粹的時間巧合（Google 每 30 秒向其單一版本庫提交一次變更——必定有 0.0001% 的提交呈現量子糾纏[^quantum]的狀態）。

[^quantum]: 在這裡是一個比喻，用來描述在大型程式碼本板庫中，由於提交次數頻繁，不同開發者的程式碼變更可能會同時進行，導致一些不可預測的問題。這種現象被比喻為量子糾纏，以突顯其複雜性和不可預測性。

最佳的實踐方法是對於落入主幹的破壞性提交進行自動回滾。開發者會收到通知，然後在其個人電腦上默默修復。

想要從主幹同步程式碼的開發者，常常面臨遇到那些統計上不太可能的破壞性建置風險。如果他們正在進行開發，他們不會希望自己的個人電腦上有導致主幹破壞的提交。因此，他們會將程式碼同步到上一個已知的正確提交，並且只有在主幹上的建置正式修復後才繼續前進。這樣他們就知道自己的個人電腦上可以保持「綠燈」狀態。一些公司會設計一個系統，將上一個已知的正確提交的雜湊值或編號儲存在網路共享中，並且用於同步程式碼的 shell 腳本會使用這個值，而不是 HEAD 版本。

<!--
### Build Cop

If the Continuous Integration server is batching commits to trunk in each build, or the elapsed time for a build is 
long then a "build cop" role might be required within the team to help sort out build breakages. Sadly that 
means that locking the trunk to prevent further checkins on top of the broken one might be necessary as some form
of bisecting is performed to work out which commit broke the build and should be rolled back. Obviously a Continuous
Integration server setup that can run one build per commit is best.
-->

### 建置監督員

如果持續整合伺服器在每次建置中將提交批次推送到主幹，或者建置所需的時間很長，團隊內可能需要一個「建置監督員」角色來幫助解決建置失敗的問題。不幸的是，這意味著可能需要鎖定主幹，以防止在破壞的提交之上進行進一步的檢查，並且需要進行某種形式的二分法來找出哪個提交導致了建置失敗並應該回滾。顯然，能夠每次提交運行一次建置的持續整合伺服器設置是最好的。

<!--
## Shared Nothing

Developers on their workstations rely on a 'microcosm' setup for the application or service 
they are developing. They can:

* bring up the application on their workstation and play with it. 
* run all unit, integration and functional tests against it locally

Shared nothing requires significant discipline to achieve. It generally means that no TCP-IP leaves the developers 
box, and being able to prove that by running those operations while disconnected from the network.  The 
implementing of the wire mocking (service virtualization) of dependent tiers outside the team, is a given. The highest 
accomplished Trunk-Based Development teams employ mocking of tiers within the same application, in order to make 
tests fast and stable. Technologies such as Mountebank{{< ext url="http://www.mbtest.org" >}} make 
programming working with wire mocking easy. Tiers refer to a layer-cake view of an applications construction, of course.

With a Microcosm strategy which delivers shared nothing for a developer workstation, it is acknowledged that 
non-functional consistency with production has been thrown out of the window and that only functional correctness
is being honored.  This is only really any good for the act of development on a workstation, and the verification of 
that (per commit) by a Continuous Integration daemon.  

Your team will need many named QA environments, and many named 
user acceptance testing (UAT) environments. Each of those with different rules about the frequency of deployment, and even perhaps even 
a temporarily reservation for different reasons. Those environments pull together **real** dependent services 
and integrated applications. As much as possible those environments should not have shared services. 

Companies often make a classic mistake when buying software in that they (say) buy one license for prod, and another 
for all dev, QA, and UAT, meaning the DevOps team had configured it as shared for all those environments, with a 
wide-ranging negative impact on productivity and quality for innumerable and sometimes subtle psychological reasons.
-->

## 無共享依賴

開發者在他們的個人電腦上依賴一個專為他們正在開發的應用程式或服務設置的「微觀」環境。他們可以：

* 在他們的個人電腦上啟動應用程式並與之互動。
* 在本地運行所有單元測試、整合測試和功能測試。

無共享外部依賴需要相當嚴格的紀律才能實現。通常意味著開發者的電腦不會通過 TCP-IP 連接外部網路，並且可以通過在離線狀態下運行這些操作來證明這一點。實現對外部團隊的依賴層進行線上模擬（service virtualization）是必要的。最成功的主幹開發團隊在同一應用程式內部使用模擬層，以使測試快速且穩定。Mountebank{{< ext url="http://www.mbtest.org" >}} 等技術使得與線上模擬相關的程式設計變得容易。當然，層級指的是應用程式結構的層級結構。

採用微觀環境策略為開發者的個人電腦提供不需共享外部依賴的開發環境，意味著產品的非功能性需求會被拋在一旁，只有功能正確性才會被重視。這種作法主要適用於個人電腦上的開發活動，以及持續整合常駐程式對每次提交進行的驗證。

你的團隊將需要許多具名的 QA 環境和許多具名的使用者驗收測試（UAT）環境。每個環境都有不同的部署頻率規則，甚至可能有不同的原因暫時保留。這些環境整合了**真實**的依賴服務和整合應用程式。盡可能避免這些環境共享服務。

企業在購買軟體時往往犯了一個典型的錯誤，比如在正式環境購買一個許可證，而在所有開發、QA 和 UAT 環境購買另一個許可證，這意味著 DevOps 團隊將其配置為所有這些環境的共享資源，對生產力和品質產生了廣泛且多種微妙的負面影響。

<!--
## Common code ownership

Committing to the trunk many times a day requires a broad sense of ownership to code, and a willingness to allow 
developers to contribute changes to sections of an application or service that they have not previously be involved 
with. This privilege does come with responsibilities and checks. The former is to standards, and the checks are by the CI server, 
and by humans who should honor to do a speedy code review. That last, for the highest performing teams, means as soon
as the proposed commit is ready.
-->

## 共同的程式碼所有權

一天多次向主幹提交變更需要對程式碼有廣泛的所有權感，以及願意讓開發者對他們之前未涉及的應用程式或服務部分進行變更的意願。這種特權是伴隨著責任和檢查的。責任意味著程式碼必須符合標準，而檢查的部分是由持續整合伺服器，以及那些負責快速審查程式碼的人進行。最後，對於表現最好的團隊來說，這意味著一但提交準備就緒，就應立即進行審查。

<!--
## Always Release Ready

Not only do developers practicing Trunk-Based Development not break the build with any commit, they also sign up to
being able to go live at short notice. For example, one hour, if the CIO visits and says it is going to happen. That
means there is a bunch of automated tests that come with the build.
-->

## 永遠準備好發布

實行主幹開發的開發者不僅不會因為任何提交而導致建置失敗，他們還願意隨時準備上線。例如，如果資訊長（CIO）來訪並表示立即上線，他們可以在一小時內準備就緒。這意味著建置包含了一系列的自動化測試。

<!--
## Thin vertical slices

Where possible stories or tasks that have been pulled from the backlog should be achievable by a developer or pair of
developers in a short period of time, and in a small number of commits. They should also transcend all the apparent 
tiers of the stack, and not have to jump between developers with specialized knowledge in order to be able to 
completed. The Agile industry donates the INVEST{{< ext url="https://en.wikipedia.org/wiki/INVEST_(mnemonic)" >}} principle 
as well as "Thin Vertical Slices"{{< ext url="http://www.scruminc.com/wp-content/uploads/2015/06/User-Stories-2.0.pdf" >}} 
for this purpose, and that are great enablers of high throughput commits to the trunk, and always being release ready.
-->

## 細小的垂直切片

在可能的情況下，從待辦事項清單中提取的任務或故事，應該在短時間內由一位開發者或一對開發者完成，並且只需提交少量的變更。這些任務還應該跨越整個軟體堆疊的各個層次，而不需要依賴具有專業知識的開發者才能完成。敏捷行業提供了 INVEST {{< ext url="https://en.wikipedia.org/wiki/INVEST_(mnemonic)" >}} 原則以及「細小的垂直切片」{{< ext url="http://www.scruminc.com/wp-content/uploads/2015/06/User-Stories-2.0.pdf" >}} 的概念，這些是促進高產能提交到主幹並始終保持發布準備就緒的重要推動者。
