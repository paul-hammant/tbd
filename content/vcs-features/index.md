---
date: 2016-03-01T20:08:11+01:00
title: 版本控制系统特性
weight: 31
---

**理想的VCS功能，就是**

To great degree, Trunk-Based Development is possible on any Version Control System (VCS) that does atomic commits (spoiler: all do 
that came after CVS).  Productivity and governance are what divides them, though.

在很大程度上，基于进行原子提交的任何版本控制系统（VCS）都可以实现基于主干的开发（剧透：CVS之后都可以）。尽管如此，生产力和管理在工具间都是不一样的。


## Productivity
## 生产力

It turns out there are many 
productivity related reasons that teams quit one technology and go to another. It does not matter whether the tool is a commercial
or an open source one. At least to its end users it does not.

事实证明，有许多生产力相关的原因使得团队放弃了一项技术，而转向另一种技术。这项技术不管是商业用途还是开源的都无关紧要，至少对其最终用户来说并不是他们关心的。

By speed we mean two things primarily:

1. The speed at which we can pull/update/sync changes out of a remote server repository
2. The speed at which we can commit/push changes back to that remote server

按速度来讲我们主要是说这两件事：
1. 从远程仓库中拉取、更新、同步更改的速度
2. 向远程仓库提交、推送的速度

And three other secondary things that support little and often:

1. Advanced Merging
2. Code Review
3. Continuous Integration

另外还有三个次要的东西，虽然很少但经常发生：
1. 高级合并
2. 代码审查
3. 持续集成

### Pull/update/sync speed
### 拉取、更新、同步的速度

If you have at least once done a checkout of the source of the project, any subsequent pull/update/sync is going to bring down 
differences from the previous checkout or update.  If you do two updates back to back quickly, the second one is likely to bring 
down nothing.  The time taken for the version control tool to determine that nothing is due from the remote master 
repository is the biggest clue as to how intrinsically fast it is. 

如果你至少从源代码中检出过一次，任何后续的拉取、更新、同步操作会将把最新的和上一次检出的差异拉下来。如果你快速地进行两次更新，则第二个更新可能什么也拿不到。版本控制工具确认远程主仓库有没有更新所需的时间可以作为衡量其速度的最大依据。

Technologies that only keep head revision on the checkout, ordinarily have to walk the entire directory structure 
looking for changed files and do handshaking to the server for each one. That is definitely Subversion and its predecessor CVS. 
Batching of those exchanges speeds it up, but there is still a slowdown related to the breadth and depth of the source
tree. Perforce makes the operation faster because the server-side is poised for the sync operation at all times, by 
keeping your tree and which revision you have for each file in RAM. It does this at the cost of maintaining read-only
bits for files (be sure and use an IDE that silently handles the Perforce interactions). Perforce can effectively be much
faster for this back-to-back pull/update/sync test of speed because it kinda already knows the answer to the question.

那些在签出时只保持最新版本的技术，通常需要遍历整个目录去查找改动的文件并和服务器一一的进行握手。这项技术显然是指Subversion及其前身CVS。如果将这些操作打包起来将会有一定的速度提升，但代码树的广度和深度又会使之变慢。Perforce和服务器端始终保持同步操作因而操作更快，你的源代码树和每个文件的版本都记录在内存中。当然它以维护文件的只读位为代价（请确保并使用默认处理Perforce交互的IDE）。Perforce可以有效地快速地进行这种连续的拉取、更新、同步测试，因为它已经知道问题的答案。

CVS, Subversion and Perforce offer you the choice of checking out a subdirectory. In a monorepo situation, you would 
consider that a nice feature. At least if you've recursively laid out services and applications within the trunk.

CVS、Subversion和Perforce提供了检出子目录的功能。在monorepo的情况下，你会认为这是一个很好的功能。至少如果你在主干中重复地放置了服务和应用程序。

Git and Mercurial have a single point of checkout (Git's 'clone' operation) for the whole repository.  There are no sub-directory checkouts 
for these two. All commits since that 
last 'pull' will be pulled down. This happens before the directory walk to determine what has changed locally. As such, that 
pull operation if very fast - there's no chit chat over the wire things, and the stuff on the server-side was already 
zipped and pretty much ready for transfer. This will be the case even for situations where a particular 
file has been changed a dozen times since you last pulled it down via a sync operation.  You might think 
this is costly, but in practice, Git is incredibly fast.

Git和Mercurial为整个代码仓库提供单点签出（Git的“克隆”操作），但这两个工具并没有子目录检出的功能。最后那次“拉取”之后的所有提交将被拉下来。这个操作是在目录遍历之前发生的，以确定在本地发生了什么变化。因此，拉取操作非常快 - 它没有任何其他额外的服务器交互，并且服务器端的东西已经压缩并且准备好传输。即使特定文件自上次拉取操作后经过十几次更改，情况也是如此。你可能认为这代价很高的，但在实践中，Git是非常快的。


### Commit/push speed
### 提交、推送的速度

Things are more equal here between the tools we highlight as viable.  

针对提交、推送的速度，这些提到的工具之间基本相同。

Subversion and Perforce send up deltas of changed files to the server. Some directory walking can slow this down. There 
is inevitably a lot of chit-chat on the wire for these operations. 

Subversion和Perforce将有修改的文件的差异发送到服务器。在这个过程中，目录的遍历操作会减慢这个速度。此外还不可避免地会和服务器有一些额外的通讯。

Git and Mercurial do the same, but before you push to the remote repo it will make you commit locally which is incredibly 
fast. Before you push to the shared remote repository, these two will make you pull first.

Git和Mercurial也是一样的，但是在推送到远程仓库之前，它允许你在本地以非常快的速度提交。在推送到共享的远程仓库之前，这两个工具要求你首先进行拉取操作。

Perforce and Subversion will allow you to commit/push changes to the remote, without necessarily having the latest versions (and 
incidentally all the intervening ones) locally first.  It will only allow that if there was no clash on the lines changed.

Perforce和Subversion允许提交、推送更改到远程仓库，而本地不必一定有最新版本（和中间版本）。这种操作只有在没有发生行冲突时才行。

Perforce can cheat again, but taking advantage of the read-only bit, and therefore already knows which files definitely 
have **not** changed between the remote master repo and local working copy. It still feels slower than it should be, though.  

Perforce再次取巧，它利用只读位，因此已经知道远程主仓库和本地工作副本之间哪些文件没有更改。但实际上仍然会感觉比想象的要慢。

### Three-way merge tools
### 三路合并工具

Developers (hopefully in pairs) are going to have to become skilled in arbitrating over merges for the commits they 
are trying to promote to the remote trunk, as well as the changes they are updating from that it in the case that they 
have work in progress in their working-copy. Trunk-Based Development teams, you see, are merging more often. Albeit 
those are smaller merges, and they are implicitly merged to your working copy.

开发人员（希望是结对的）必须熟练掌握如何与推送到远端主干的提交进行合并，也必须掌握如何与本地工作副本中正在进行中的更改进行合并。你会看到实行主干开发的团队会更频繁地合并。这些都是较小的合并，它们被隐含地合并到你的工作副本。

Perforce's three-way merge tool (P4Merge) is good enough on its own to be attractive to teams using other VCS 
technologies. For those other technologies, P4Merge  is just a config setting away from being usable.  

Perforce的三向合并工具（P4Merge）本身就足够好，对使用其他VCS技术的团队来说是有吸引力的。但对于其他技术而言，P4Merge只是一个没有实用性的配置选项而已。

Semantic merge is the next step up in the science of source-control. See [Plastic SCM](/vcs-choices/index.html#plasticscm).

语义合并是源代码管理科学的下一步。请参阅[Plastic SCM](/vcs-choices/index.html#plasticscm)。

### Code Review
### 代码审查

Integrated code review turned out to to be the killer feature of VCS tools. This should have been clear from the moment Mondrian
was unveiled by Guide van Rossum (Mr. Python) in a publicized Google 'tech talk' in 2006. It delivered pre-commit
code reviews to developers and gamified the activity of code review to some degree. Google was
using Perforce back then (they changed to an in-house technology in 2012), and it did not have code review build in, so 
they had to make Mondrian (which was the final form of years of intermediate deliverables for the same). Thus
Mondrian being created tightly coupled code review to the hourly activities of developers on the trunk. 

集成代码审查是VCS工具的杀手锏。这一点应该从2006年的“Google技术讲座”中Guide van Rossum (Mr. Python)发布的Mondrian开始。它向开发者提供了预提交代码审查，并在某种程度上让代码审查活动游戏化。Google当时正在使用Perforce（他们在2012年改为使用内部技术），但这个工具并没有代码审查。所以他们不得不创造出Mondrian（这是多年来中间交付成果的最终形式）。因此，Mondrian建立起紧密耦合的代码审查，以便支持每时每刻在主干分支上的开发人员。

GitHub (not Git) was next for the non-Google dev world with a built in code-review tool (and workflow). Again this was 
effectively pre-commit - or at least commit to the master.

接下来，GitHub（不是Git）通过内置的代码审查工具（和工作流程）为非Google开发者世界服务。这又是有效地预提交 - 或至少提交给主分支。

There were (and are) other technologies for code review such as Crucible (Atlassian), UpSource (JetBrains), Gerrit, 
Phabricator, but integration into a platform experience is key.  GitLab and RhodeCode are emerging platforms.

过去和现在都有其他技术的代码进行审查，如Crucible（Atlassian）、UpSource（JetBrains）、Gerrit、Phabricator，但整合到平台的体验是其中的关键。GitLab和RhodeCode是新兴平台。

Read more in [Game Changers - Google's Mondrian](/game-changers/index.html#google-s-internal-devops-2006-onwards) and 
[Game Changers - GitHub's Pull Requests](/game-changers/index.html#github-s-entire-platform-2008-onwards).

阅读更多：[Game Changers - Google's Mondrian](/game-changers/index.html#google-s-internal-devops-2006-onwards)和 [Game Changers - GitHub's Pull Requests](/game-changers/index.html#github-s-entire-platform-2008-onwards).

### Continuous Integration testing
### 持续集成测试

This goes hand in hand with the Code Review capability. CI Servers kick in for commits are pushed up code review branches, 
or at least against change sets that are entering code review and validate them. The regular build, and maybe some 
additional steps are executed against them and the results of those made available to code reviewers, Facebook has a 
Service Level Agreement to have those complete ten minutes after the commit has been placed in the 'needs code review'
queue.

持续集成测试与代码审查功能相辅相成。变更被推送代码审查分支时，或者至少在进入代码审查的变更时，CI服务器开始工作并验证这些变更。这些变更经过常规构建，或者更多的其他步骤。代码审阅者都可以查看行结果。Facebook提供了服务级别的协议，它规定提交放在“需求代码审查”队列之后十分钟内就必须要完成构建工作。

The reality of VCS platforms today is that they only provided hooks (web-hooks most likely) into other CI servers. The
best combinations of VCS platform and CI server do so for any of the branches in play, including code-review branches 
(forks).

在现实生活中，VCS平台的只提供钩子（可能的是基于web的钩子）给其他CI服务器。对于任何分支（包括代码审查分支（forks）），VCS平台和CI服务器的相互合作都是最好的。

## Governance
## 管治

It turns out that enterprises like the ability to carve up permissions, and set read and write permissions throughout
their repositories.

事实证明，企业喜欢划分权限的能力，并在代码库中设置读写权限。

### fine grained permissions
### 细粒度权限

All VCS usages need users accounts to be able to accept changes back, even if they don't all require accounts in order
to be able to read. In the enterprise user accounts will be required to be able to read too.

所有VCS的使用都需要用户帐户才能接受更改，即使它们并不都需要帐户以便能够读取。在企业用户帐户中，则必须要能够读取。

The larger the enterprise the more likely it will be that they have permissions carved up in more file grained ways.
For example "can commit to the trunk, but cannot create release branches" will be common for Trunk-Based Development
teams that make release branches.  Not all VCS technologies support that. Git, for example, does not, but some of the 
portal experiences around it, add the feature. In reality, though, you cannot stop people from making branches in a DVCS,
but you can prevent them from pushing them to the shared repository.

企业越大，他们越有可能以文件粒度的方式进行权限划分。例如，对于基于主干开发的团队来说，“可以提交到主干，但不能创建发行分支”将是比较常见的。但并非所有的VCS技术都支持。例如，Git不会，但一些门户网站对此有经验并且增加了这种功能。实际上，你不能阻止人们在DVCS中创建分支，但可以防止他们将其推送到共享仓库。

Deeper still, some enterprises will want to set permissions down the directory level within a branch within a repository.
This could be as simple as a gate, to ensure that process is adhered to around checkins, but could also be to guard
some secrets in a Monorepo implementation. That last is counter to some of the "common code ownership" ideals of
modern software engineering though.

更深层次上，一些企业希望在仓库中的一个分支中的目录级别下设置权限。这可能就像一个门一样简单，以确保这个过程在提交时发挥作用，也可以在Monorepo实现中保护一些秘密。最后这一点与现代软件工程中的“共同代码所有权”理念相反。

### Size / Scale
### 大小、扩展

Many teams, particularly those with Monorepo configurations or large binary files (like Games companies), want to have 
limitless server-side storage for their repository.  Git and Mercurial are inching towards bigger and bigger 
capacity, but there are still a few snafus to work through - how to cleanly/safely reduce the size of the client side clone
history (while still being able to push changes back to the server) is a challenge.

许多团队，特别是Monorepo配置或大型二进制文件（如游戏公司）的团队希望为其仓库提供无限的服务器端存储。Git和Mercurial正在努力实现更大的容量，但还有一些工作要做 - 如何干净/安全地减少客户端克隆历史的大小（同时仍然可以将更改推回到服务器）仍是一个挑战。

Microsoft released Git Virtual File System (~~GitVFS~~ GVFS{{< ext url="https://github.com/Microsoft/GVFS" >}}) in early 2017, to layer on some of the things they had 
become used to in the in-house recompilation of Perforce (SourceDepot - used from 1998 to 201x), as well as native VCS 
of their commercial offering Team Foundation Server (TFS).

微软在2071年早些时候发布了Git虚拟文件系统(~~GitVFS~~ GVFS{{< ext url="https://github.com/Microsoft/GVFS" >}})，它构建在他们在内部重编译Perforce的项目（SourceDepot - 从1998年至201x使用的）以及其商业性产品Team Foundation Server（TFS）的原生VCS之上。