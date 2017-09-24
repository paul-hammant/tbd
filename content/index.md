---
date: 2015-01-01T21:07:33+01:00
title: 介绍
type: index
weight: 0
---

<!-- print <h1 style="color: white; padding: 32px 20px 72px; background-image:url(/images/LogoSlim.png); background-repeat: no-repeat; background-size: 100% auto"><span style="background-color: #5677fc">Introduction</span></h1> print -->

## 概述
主干开发是一套代码分支管理策略，开发人员之间通过约定向被指定为“主干”*的分支提交代码，以此抵抗因为长期存在的多分支导致的开发压力。 此举可避免分支合并的困扰，保证随时拥有可发布的版本。

![](trunk1.png)
([key](/key/))


 &ast; Git 中的 *master* 分支


主干开发是助力实现 [持续集成](/continuous-integration/) 和 [持续交付](/continuous-delivery/) 的关键因素。开发团队的成员一天多次地将代码提交到主干分支，满足了持续交付的必要条件。团队的工作在 24 小时内就可以被整合，这保证了代码版本随时处于可发布状态，使得持续交付成为可能。

## 主张

- 你应该使用主干开发而不是 GitFlow 或者其他可能导致特性分支长期存在的分支模型。
- 你可以选择直接向主干分支提交代码的方式（适用于小团队）或者采用 Pull-Request 的方式，只要保证特性分支不能长期存在，并且产品是独立存在的。（the product of a single person.）

## 说明

- 根据团队规模和提交频率，[特性分支](/short-lived-feature-branches/) 可用于合并到主干分支前的代码审查和持续集成。这些特性分支可以让开发人员在代码合并到主干分支之前进行 [持续审查](/continuous-review/)，而对于较小规模的团队，则可以 [直接向主干分支提交](/committing-straight-to-the-trunk/).
- 根据预期的发布频率，你的团队或许需要实时从主干分支创建 [发布分支](/branch-for-release/) 以确保发布版本不会有新的提交，这些分支应该在发布完成后一段时间内删除。另一方面，你的团队也可以选择[从主干分支发布](/release-from-trunk/)而不需要发布分支，并采用“修复前进（fix forward）”的策略进行 bug fix，这种发布策略适用于高吞吐量的团队（high-throughput teams）。
- 团队应熟练掌握并运用[抽象分支](/branch-by-abstraction/) 来实现增长变化，并在日常开发中使用 [特性标签](/feature-flags/) 以确保发布顺序（以及其他好处，详见 [连续发布的协同开发](/concurrent-development-of-consecutive-releases/)）
- 如果你的项目中存在多个开发人员，你将需要一个有钩子（hook）功能的 [构建服务器](/continuous-integration/)，以确保开发人员的本地代码在合并到主干分之后不会破坏构建，同样在特性分支合并到主干分支的环节也应该重复该步骤。
- 在主干分支的保证下，开发团队可以任意扩大或缩小而不影响吞吐量和产品质量，[Google 主干开发](/game-changers/index.html#google-revealing-their-monorepo-trunk-2016) 可以证明，及时在 25000 个开发加测试的环境中，单个 [monorepo](/monorepo/) 的主干开发策略仍可以支持开发团队的 [扩大和收缩](/expanding-contracting-monorepos/) 以适应需求。
- 如果你实践过 [GitHub-flow 分支模型](/alternative-branching-models/index.html#modern-claimed-high-throughput-branching-models) 可能会觉得非常熟悉，但主干开发仍有细微差别主要区别在从何进行发布。
- 如果你过去实践的是 Gitflow 分支模型你将会感受到主干开发的**巨大差异**，在过去使用 ClearCase, Subversion, Perforce, StarTeam, VCS 等 [分支模型](/alternative-branching-models/index.html#legacy-branching-models) 的程序员也会有相似的感受。
- 正如我们所提到的，许多 [出版物](/publications/) 促进了主干开发的发展，包括畅销书籍《持续交付》及《DevOps 手册》，可以说主干开发是毫无争议的最佳实践！

## 历史

主干开发并不是一个新的分支模型，“主干”这个词隐喻了树木生长的场景，树木最粗最长的部位是主干，分支从主干分离出来但是长度有限。

自从九十年代中期以来，主干开发便是一个较为知名的分支模型，自八十年代以来一直被认为是战术。（It has been a lesser known branching model of choice since the mid-nineties and considered tactically since the eighties.）最大规模的开发组织，如Google（如上所述）和 Facebook 都在实践主干开发。

30 多年来， [代码管理技术和工具的演讲和发展](/game-changers/) 得主干开发更加（有时更少）普遍存在，但是多年来一直是许多人坚持的分支模型。

## 关于本站

本站旨在搜集所有和主干分支开发有关的事实和理论依据，以及相应的技术。囊括了 25 张图表用以帮助表达。 All without using TBD as an acronym even ~~once~~ twice.
