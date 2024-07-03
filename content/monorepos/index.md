---
date: 2016-11-01T20:08:11+01:00
title: 單一版本庫
weight: 111
---

<!--
A Monorepo is a specific Trunk-Based Development implementation where the organization in
question puts its source for all applications/services/libraries/frameworks into one trunk and forces developers
to commit together in that trunk - atomically.
-->

單一版本庫是一種特定的主幹開發實現方式，其中組織將其所有應用程式、服務、套件或框架的原始程式碼放入一個主幹中，並強制開發者一起在該主幹中進行原子化的提交。

<!--
Google has the most famous monorepo and they do the above AND force teams to **share code at source level instead of
linking in previously built binaries**. Specifically, they have no version numbers for their own dependencies, just an
implicit 'HEAD'. Indeed, because of lock step upgrades for all, releases from their monorepos mean 'HEAD' **is** their
effective version number. Third-party libraries (like JUnit) will be checked into the repo with a specific version number
(like 4.11), and all teams will use that version if they use it at all.
-->

Google 擁有最著名的單一版本庫，他們不僅進行上述作法，還強制團隊**在原始程式碼層面共享程式碼，而不是連結先前建置的二進位檔案**。具體來說，他們自己的依賴沒有版本號，只有一個隱含的「HEAD」。的確，因為所有人都進行同步升級，從他們的單一版本庫中發布的內容意味著「HEAD」**就是**他們的實際版本號。第三方程式套件（如 JUnit）將以特定版本號（如 4.11）被檢入倉庫，如果所有團隊要使用它，則都會使用那個版本。

<!--
The deployment and/or release cadences for each application/service/library/frameworks will probably be different
as will the team's structures, methodologies, priorities, story backlogs etc.
-->

每個應用程式、服務、套件、框架的部署或發布節奏很可能會有所不同，團隊的結構、方法論、優先順序、故事待辦清單等也將如此。

<!--
The name 'monorepo' is a newer name for a previously unnamed practice that is more than a decade old.
-->

**單一版本庫**（monorepo）這個名稱是近年來新出現的，用來稱呼一種已經存在十多年的、之前未被命名的實踐方式。

<!--
Monorepo implementations deliver a couple of principal goals:

* Acquire as many third-party and in-house dependencies as possible for a build from the **same** source-control repository/branch, and in the
same update/pull/sync operation.
* Keep all teams in agreement on the versions of third-party and in-house dependencies via lock-step upgrades.
-->

單一版本庫實施主要達成以下幾個目標：

* 統一來源管理依賴，盡可能從**同一個**控制版本庫或分支獲取建置所需的所有第三方和內部依賴，並在同一個更新、拉取或同步操作中完成。
* 版本統一升級，通過同步更新（lock-step upgrade），保持所有團隊對第三方和內部依賴的版本保持一致。

<!--
And some secondary goals:

* Allow changes to multiple modules via **atomic commits**.
* Allow the extraction of new common dependencies (from existing code) to be achieved in atomic commits.
* Force all developers to focus on the HEAD revisions of files in the trunk
* Allow bisecting towards the root cause of a prod bug to be effected on multiple (potentially dissimilar) modules at the same time
-->

以及一些次要目標：

* 通過**原子提交**[^atomic-commit]允許對多個專案程式碼進行更改，原子提交確保了所有變更是一起成功或一起失敗，從而避免了部分更新帶來的不一。
* 允許通過原子提交實現從現有程式碼中提取新的共同依賴，在不破壞現有功能的前提下，從一個或多個模組中建立抽象並重構程式碼，通過原子提交實施這些變更。
* 強制所有開發者專注於主幹中文件的 HEAD 修訂版本，在單一版本庫中，鼓勵開發者始終與最新的程式碼版本工作，減少了老舊程式碼或分支帶來的維護問題。
* 允許同時對多個（可能不相同的）模組進行根因分析，以找到正式環境中的錯誤。在發現正式環境中的問題時，可以更快地通過提交紀錄歷史追溯多個模組的更改。


[^atomic-commit]: 原子提交（Atomic commit）是一種最佳實踐，指的是在版本控制系統中，將所有相關變更作為一個不可分割的單元進行提交。這樣的提交要麼全部成功，要麼全部失敗，確保在版本庫中不會出現部分或不完整的變更。為了實踐原子提交，應確保提交前測試所有更改，確保提交的完整性。將大範圍的更改分解為更小、更可管理的提交，以便每次提交都只解決一個特定的問題或新增一個特定的功能。
參考來源 [Perforce - 8 Version Control Best Practices](https://www.perforce.com/blog/vcs/8-version-control-best-practices)


<!--
Google and Facebook are the most famous organizations that rest development on a single company-wide trunk, that
fits the monorepo design. Netflix and Uber (iOS application) disclosed in 2017 that they do too. 

{{< warning title="Risk of chaotic directory layout" >}}
Google's co-mingled applications and services sit within highly structured and uniform source trees. A Java
developer from one project team instantly recognizes the directory structure for another team's application
or service. That goes across languages too. The design for the directory layout needs to be enforced globally. You can
see that in the way that Buck and Bazel layout trees for production and test code. If you
cannot overhaul the directory structure of your entire repository, you should not entertain a monorepo.
{{< /warning >}}
-->

Google 和 Facebook 是最著名的幾家採用單一公司級主幹開發的組織，這種方式符合單一版本庫的設計理念。Netflix 和 Uber (針對其 iOS 應用)在2017年也公開表示他們採用了相同的方法。

{{< warning title="目錄布局可能的混亂風險" >}}
Google 的混合應用程式和服務位於高度結構化且統一的程式碼目錄中。來自一個專案團隊的 Java 開發者立刻可以識別出其他團隊應用程式或服務的目錄結構。這種情況在不同程式語言中也是通用的。目錄布局的設計需要全局統一執行。你可以從 Buck 和 Bazel 為產品程式碼和測試程式碼布局樹的方式中看出這一點。如果你無法徹底改革整個版本庫的目錄結構，那麼你不應該採用單一版本庫。
{{< /warning >}}

<!--
### Lock-step deployments?

OK, so it is really important to note in a monorepo, that you don't have to do a lock-step deployment of a buildable/releaseable thing just because a dependency was upgraded. What is certain is the next deployment of that application/service will
contain the new dependency. "Next" is still a concern of the development team in
question. Monorepos only say "what" will be released, not "when". 
-->

### 同步部署？[^lock-step-deployments]

在使用單一版本庫時，有一點非常重要，僅僅因為一個依賴升級了，並不意味著你必須進行一個同步的部署。可以確定的是，該應用程式或服務的下一次部署將會包含這個新的依賴。至於「下一次」何時發生，仍然取決於相關的開發團隊。單一版本庫僅指名了將要發布的內容（「What」），而不是發布的時間（「When」）。

[^lock-step-deployments]: 同步部署（lock-step deployments），即所有系統元件或服務需要同時更新到新版本的作法。這種作法在某些組織中用於確保一統的各個部分保持同步。

<!--
## Third-party dependencies

With the monorepo model, there is a strong desire to have third-party binaries in source-control too.
You might think that it would be unmanageable for reasons of size. In terms of commit history, Perforce and Subversion do not
mind a terabyte of history of binary files (or more), and Git performed much better when Git-LFS was created. You
could still feel that the HEAD revision of thousands of fine-grained dependencies is too much for a workstation, but
that can be managed via an [expanding and contracting monorepo](/expanding-contracting-monorepos/).

Note:  Python, Java, C++ and other SDKs are installed the regular way on the developer workstation, and not acquired
from the source-control repository/branch.
-->

## 第三方依賴

在單一版本庫模型中，人們強烈希望將第三方依賴的二進制檔案也放入程式碼版本控制中。你可能認為由於檔案大小的原因會難以管理。在提交歷史方面，Perforce 和 Subversion 不介意管理達到一兆位元組（或更多）的二進制檔案歷史，而當 Git-LFS 被建立後，Git 的表現有了顯著提升。你仍然可能覺得數千個細粒度依賴的 HEAD 版本對於本地個人電腦來說太多，但這可以通過一個可擴展和可收縮的單一版本庫來管理（即開發者可以選擇同步和下載他們需要的部分）。

注意：Python、Java、C++和其他 SDK 仍按照常規方式在開發者個人電腦上安裝，而不是從版本控制庫或分支獲取。

<!--
## In-house dependencies

It could be that your application team depends on something that is made by colleagues from a different team. An
example could be an Object Relational Mapping (ORM) library. For monorepo teams there is a strong wish to depend on
the source of that ORM technology and not a binary. There are multiple reasons for that, but the principal one is that
source control update/pull/sync is the most efficient way for you to keep up with the HEAD of a library on a minute
by minute basis. Thus `MyTeamsApplication` and `TheORMweDepOn` should be in your source tree in your IDE at the same time.
Similarly, another team that depends on `TheORMweDepOn` should have it and `TheirApplication` checked out at the same
time.
-->

## 公司的內部依賴

當不同團隊於同一間公司中開發各自的專案時，他們可能會相互依賴對方開發的程式碼或套件。以物件關係映射（ORM）為例，對於使用單一版本庫的團隊會傾向於直接依賴該 ORM 技術的程式碼，而非其編譯後的二進制檔案。這種作法的主要原因是，通過版本控制系統進行更新、拉取或同步操作，可以即時跟蹤到每分鐘的更新，從而最高效地保持與版本控制庫的同步。例如，如果一個團隊正在開發一個名為`MyTeamsApplication` 的專案，並且依賴於另一個團隊開發的 `TheORMweDepOn` ORM 程式碼，那麼這兩個專案應該同時檢出於該團隊的 IDE 中。同樣，依賴 `TheORMweDepOn` 的另一個團隊也應該同時檢出 `TheirApplication` 和 `TheORMweDepOn`，以減少因版本不一致導致的問題。

<!--
## Directed graph build systems

To facilitate monorepos, it is important to have a build system that can omit otherwise buildable things/steps that are not
required for the individual developer's **current** build intention.

The general directory structure for directed graph build systems is like so:

```
root/
  prod_code/
    build_file.xml
    (source files)
    a_directory/
      build_file
      (source files)
      another_directory/
        build_file.xml
        (source files)
    yet_another_directory/
      build_file.xml
      (source files)
  test_code/
    build_file.xml
    (source files)
    a_directory/
      build_file
      (source files)
      another_directory/
        build_file.xml
        (source files)
    yet_another_directory/
      build_file.xml
      (source files)
```

Obviously, YAML, JSON, TOML or custom grammars are alternatives to XML, for build files.
-->

## 有向圖建置系統

為了便於使用單一版本庫，重要的是要有一個建置系統，該系統可以省略對於個別開發者**當前**建置意圖不必要的其他可建置的元件或步驟，從而優化建置過程並減少不必要的建置負擔。

有向圖建置系統通過明確定義依賴關係和建置路徑，因此有向圖建置系統的常見目錄結構如下︰

```
root/
  prod_code/
    build_file.xml
    (source files)
    a_directory/
      build_file
      (source files)
      another_directory/
        build_file.xml
        (source files)
    yet_another_directory/
      build_file.xml
      (source files)
  test_code/
    build_file.xml
    (source files)
    a_directory/
      build_file
      (source files)
      another_directory/
        build_file.xml
        (source files)
    yet_another_directory/
      build_file.xml
      (source files)
```

顯然，YAML、JSON、TOML 或自定義語法是 XML 的替代方案，用於建置文件。[^directed-graph-build-systems]

[^directed-graph-build-systems]: 有向圖建置系統的目錄結構通常包含兩大部份︰產品程式碼（prod_code）與測試程式碼（test_code）。每個部份都包含一系列的原始程式碼與如何建置相應目錄下的建置文件（例如目錄中的`build_file.xml`或上述提到的 XML、JSON 等），這些建置文件定義如何建置這些原始程式碼。

<!--
### Contrived example

Two examples:

* I want to run impacted tests locally, relating to the hair-color field I just added to the person page of `MyTeamsApplication`
* I want to run bring up `MyTeamsApplication` locally, so I can play with the hair-color field I just added to the person page

Not only do you want to omit unnecessary directories/files from your build's activities, you probably also want to omit
them from your IDE.
-->

### 人為的例子

這裡有兩個例子︰

+ 我剛剛新增髮色欄位到 `MyTeamsApplication` 的人物頁面，我想在本機執行受影響的測試。

* 我想在本機啟動 `MyTeamsApplication`，這樣我就可以操作我剛新增到人物頁面的髮色欄位。

不僅你希望從建置活動中省略不必要的目錄/檔案，你可能還希望從你的 IDE 中省略它們。

<!--
### Facebook's Buck and Google's Bazel

Google has Blaze internally. Ex-Googlers at Facebook (with newfound friends) missed that, wrote
Buck{{< ext url="https://buckbuild.com" >}} and then
open-sourced it. Google then open-sourced a cut-down Blaze as Bazel{{< ext url="https://bazel.build" >}}.
These are the two (three including Blaze) directed graph build systems that allow a large tree of sources to be speedily
subset in a compile/test/make-a-binary way.

The omitting of unnecessary compile/test actions achieved by Buck and Bazel works equally well on developer workstations
and in the CI infrastructure.

There is also the ability to depend on recently compiled object code of colleagues. The recently compiled object code for
provable permutations of sources/dependencies, that is. And that code plucked from the ether (think of a LRU cache available to all
machines in the TCP/IP subnet). That is in place to shorten compile times for prod and test code.
-->

### Facebook 的 Buck 和 Google 的 Bazel

Google 內部有一個名為 Blaze 的系統。前 Google 員工轉職至 Facebook （與新朋友合作）後，因懷念這個系統，因此他們建立了 Buck{{< ext url="https://buckbuild.com" >}}，並隨後將其開源。之後，Google 也將一個簡化版的 Blaze 以 Bazel{{< ext url="https://bazel.build" >}} 的形式開源。這三個（包括 Blaze）有向圖建置系統能夠迅速地對一個龐大的程式碼樹進行編譯、測試或產生二進位檔案的分割。

Buck 和 Bazel 省略不必要的編譯與測試操作，在開發者的個人電腦和 CI 基礎設施上同樣有效。

此外，還能依賴於同事最近編譯的物件程式碼。也就是說，這些物件程式碼是對原始程式碼或依賴專案的可證明的排列所編譯出來的。這些程式碼從網路中獲取（想像一下，一個對所有位於同一個 TCP/IP 子網路中的機器可用的 LRU 快取策略）。這樣做的目的是為了縮短產品程式和測試程式的編譯時間。

<!--
## Recursive build systems

Java's Apache-Maven is the most widely used example. It's predecessor, Ant, is another. Maven more than Ant, pulls
third-party binaries from 'binary repositories', caching them locally. Maven also traverses its tree in a strict
depth first (then breadth) manner. Most recursive build systems can be configured to pull third-party dependencies
from a relative directory in the monorepo. A binary dependency cache outside of the VCS controlled working copy,
is more normal.

The general directory structure for recursive build systems is like so:

```
root/
  build_file.xml
  module_one/
    build_file.xml
    src/
      # prod source directory tree
      # test source directory tree
    module_two/
      build_file.xml
      src/
        # prod source directory tree
        # test source directory tree
  module_three/
    build_file.xml
    src/
      # prod source directory tree
      # test source directory tree
  src/
    # prod source directory tree
    # test source directory tree
```

Again, YAML, JSON, TOML and custom grammars are alternatives to XML for build files.

Recursive build systems mostly have the ability to choose a type of build. For example 'mvn test' to just run tests,
and not make a binary for distribution.
-->

## 遞迴式建置系統

Java 的 Apache-Maven 是最廣泛使用的例子。它的前身 Ant 也是另一個例子。Maven 相比於 Ant，更多地從「二進位檔案倉庫」中拉取第三方二進位檔案，並在本機進行快取。Maven 也以嚴格的深度優先（然後是廣度優先）方式遍歷其樹狀結構。大多數遞迴式建置系統可以配置從單一版本庫中的相對目錄中拉取第三方依賴。一個位於版本控制系統管理之外的二進位依賴快取更為常見。

遞迴式建置系統的一般目錄結構如下：

```
root/
  build_file.xml
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
  src/
    # 產品程式碼的目錄結構
    # 測試程式碼的目錄結構
```

再次強調，YAML、JSON、TOML 及自定義語法是 XML 的替代選擇用於建置文件。

遞迴式建置系統大多具有選擇建置類型的能力。例如使用「mvn test」僅用於執行專案中定義的測試案例，而不會進行整個專案的完整建置流程，即不會產生最終的可執行檔案或套件庫檔案。有助於開發者在開發過程中，不需要完整建置整個專案，就能頻繁執行測試來驗證程式碼更改的正確性。這樣可以節省時間，專注於測試的執行與結果分析。

<!--
## The diamond dependency problem

What happens when two apps need a different version of a dependency?

For in-house dependencies, where the source is in the same monorepo, then you will not have this situation, as the
team that first wanted the increased functionality, performed it for all teams, keeping everyone at HEAD revision
of it. The concept of version number disappears in this model.
-->

## 鑽石依賴問題

當兩個或多個應用程式依賴於同一個依賴專案的不同版本時，會發生什麼問題？

對於內部依賴，如果原始程式碼在同一個單一版本庫中，就不會出現這種情況，因為第一個需要增強功能的團隊會為所有團隊進行更新，使每個人都保持在它的最新修訂版。在這種模型中，版本號的概念消失了。

<!--
### Third-party dependencies

For third-party dependencies, the same rule applies, everyone upgrades in lock-step. Problems can ensue, of course,
if there are real reasons for team B to not upgrade and team A was insistent. Broken backward compatibility is
one problem.

In 2007, Google tried to upgrade their JUnit from 3.8.x to 4.x and struggled as there was a subtle
backward incompatibility in a small percentage of their usages of it. The change-set became very large, and struggled
to keep up with the rate developers were adding tests.

Because you are doing lock-step upgrades, you only secondarily note the version of the third-party
dependencies, as you check them into source control without version numbers in the filename.  I.e. JUnit goes in as
`third_party/java_testing/junit.jar`.
-->

### 第三方依賴

對於第三方依賴，同樣的規則適用，每個人都必須同步升級。當然，如果團隊 B 有充分的理由不進行升級而團隊 A 堅持升級時，則可能會出現問題。向後不兼容性是一個問題。

2007年，Google 嘗試將他們的 JUnit 從 3.8.x 升級到 4.x，但由於存在微妙的向後不兼容性，在他們使用中的一小部分出現了問題，造成更改範疇變得非常大，並且很難跟上開發者新增測試的速度。

因為你正在進行同步升級[^lock-step-upgrade]，而且你將第三方依賴提交程式碼版本控制時，不在檔案名稱中包含版本號，所以你只是次要地注意到第三方依賴的版本。例如，JUnit 作為 `third_party/java_testing/junit.jar` 被儲存。這種做法簡化了版本管理，但要求開發團隊在引入或更新依賴時保持高度的協調。

[^lock-step-upgrade]: 同步升級（lock-step upgrade），即所有團隊需要同時更新到第三方依賴的新版本。

<!--
## Clash of ideologies

Above we contrasted **directed graph** and **recursive** build systems. The former are naturally compatible
with expandable/contractible checkout technologies. The latter not necessarily so.
-->

## 意識形態的衝突

在前文中，我們對比了**有向圖**和**遞迴式**建置系統。前者與可擴展且可收縮的 checkout 技術自然兼容，後者則不必然如此。

<!--
### Maven

Recursive build systems like maven, have a forward declaration of modules that should be built, like so:

```xml
<modules>
  <module>moduleone</module>
  <module>moduletwo</module>
</modules>
```

Presently, though, these build technologies do not have the ability to follow
a changeable checkout that the likes of gcheckout can control.

Directories `moduleone` and `moduletwo` have to exist in order for the build to work. The idea of expandable/contractible
monorepos, is that trees of buildable things are **calculated or computed** not **explicitly declared**.
In order to deliver that, you would need a feature to be added Maven like so:

```xml
<modules>
  <calculate/> <!-or-> <search/>
</modules>
```

Or you could "hack it" and rewrite your pom.xml files after every expansion or
contraction{{< ext url="http://paulhammant.com/2017/01/27/maven-in-a-google-style-monorepo/" >}}.
-->

### Maven

像 Maven 這樣的遞迴式建置系統，擁有一個需要建置的模組的前向模組聲明，如以下的 pom.xml 所示[^pom.xml]︰

```xml
<modules>
  <module>moduleone</module>
  <module>moduletwo</module>
</modules>
```

[^pom.xml]: 如 XML 所示，用以告訴 Maven 當前專案包含兩個子模組，分別是 `moduleone` 和 `moduletwo`。Maven 會在建置過程中查找與這些模組名稱對應的目錄，並在這些目錄中找尋各自的 pom.xml 檔案來執行相應的建置命令。

然而，目前這些建置技術還沒有能力跟隨像 gcheckout 這樣的可變 checkout 控制。

為了使建置工作正常進行，目錄 `moduleone` 和 `moduletwo` 必須存在。可擴展/可收縮單一版本庫的理念是，可建置事物的樹是**計算或搜索得出的**，而不是**明確聲明的**。為了實現這一點，你需要向 Maven 新增類似這樣的功能︰

```xml
<modules>
  <calculate/> <!--或者--> <search/>
</modules>
```

或者你可以「駭客攻擊[^hack-it]」，在每次擴展或收縮後動態地重寫 pom.xml 檔案{{< ext url="http://paulhammant.com/2017/01/27/maven-in-a-google-style-monorepo/" >}}，以反映新的模組結構。

[^hack-it]: 駭客攻擊（hack it）方法是指在每次單一版本庫發生擴展或收縮時，手動重寫 pom.xml。這是一種臨時的解決方案，用於解決 Maven 當前不支持動態調整專案結構的限制。

<!--
## If you decide you do multiple repos instead of a monorepo

In this case, the repository separation should be **no more fine grained** than the applications and services which have separate deployment cadences.

Traditionally, when using microservices the result is exactly that case: a deployable microservice in its own repository. There is no reason why hundreds of microservices could not be in the same monorepo, but one repo per microservice is conventional with the microservices community.

That said, Googlers have made Android Repo{{< ext url="https://source.android.com/setup/develop/repo" >}} to deliver the best of both worlds. This technology works with Gerrit for code review. And there's a fork of that called Git-Repo{{< ext url="https://github.com/wavecomp/git-repo" >}}, that has additional Git workflow features.

Lastly, Microsoft in their movement away from legacy VCS choices and branching models, have made VFS For Git{{< ext url="https://github.com/microsoft/VFSForGit" >}} which purports to solve many of the same scale problems of Git.
-->

## 如果你決定使用多個版本庫而不是單一版本庫

在這種情況下，版本庫的分割**不應比應用程式和服務各自的部署結構更細緻**。

傳統上，在使用微服務架構時，通常就是這種情況︰每個可部署的微服務都有自己的版本庫。雖然沒有理由不將數百個微服務放在同一個單一版本庫中，但是每個微服務一個版本庫在微服務社群中是常規作法。

儘管如此，Google 開發了 Android Repo {{< ext url="https://source.android.com/setup/develop/repo" >}} 來提供兩全其美的解決方案。這項技術與 Gerrit 一起用於程式碼審查。此外，還有一個稱為 Git-Repo 的分支，它增加了額外的 Git 工作流程特性。

最後，Microsoft 在他們從傳統版本控制系統和分支模型轉變過程中，建立了 VFS For Git{{< ext url="https://github.com/microsoft/VFSForGit" >}}，該工具旨在解決 Git 的許多相同規模問題。

<!--
# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>
-->

# 其他參考資料 {#references-elsewhere}

<a id="showHideRefs" href="javascript:toggleRefs();">顯示參考資料</a>

<div>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">09 Apr 2013, Blog entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://paulhammant.com/2013/04/09/scaling-trunk-based-development/">Scaling Trunk-Based Development</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">06 May 2013, Blog entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://paulhammant.com/2013/05/06/googles-scaled-trunk-based-development/">Google's Scaled Trunk-Based Development</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">06 Jan 2014, Blog entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://paulhammant.com/2014/01/06/googlers-subset-their-trunk/">Googlers Subset their Trunk</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">08 Jan 2014, Blog entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://paulhammant.com/2014/01/08/googles-vs-facebooks-trunk-based-development/">Google's vs Facebook's Trunk-Based Development</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">10 Apr 2014, Blog entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://paulhammant.com/2014/04/10/cd-the-price-of-admission/">Continuous Delivery: The price of admission..</a></td>
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
            <td style="padding: 2px" valign="top">18 May 2015, Blog entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://danluu.com/monorepo/">Advantages of monolithic version control</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">20 May 2015, Blog entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://paulhammant.com/2015/05/20/turning-bazel-back-into-blaze-for-monorepo-nirvana/">Turning Bazel back into Blaze for monorepo nirvana</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">27 Jan 2017, Blog entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://paulhammant.com/2017/01/27/maven-in-a-google-style-monorepo/">Maven In A Google Style Monorepo</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">6 Mar 2017, Blog entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://eng.uber.com/ios-monorepo/">Faster Together: Uber Engineering’s iOS Monorepo</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">27 Apr 2017, Blog entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://medium.com/netflix-techblog/towards-true-continuous-integration-distributed-repositories-and-dependencies-2a2e3108c051">Towards true continuous integration: distributed repositories and dependencies</a></td>
        </tr>
    </table>
</div>
