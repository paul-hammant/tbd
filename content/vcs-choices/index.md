---
date: 2016-03-02T20:08:11+01:00
title: 选择版本控制系统
weight: 32
---

## Git and Mercurial
## Git和Mercurial

See Git's website{{< ext url="https://git-scm.com" >}} and Mercurial's website{{< ext url="https://www.mercurial-scm.org" >}}
请参阅Git{{< ext url="https://git-scm.com" >}}的网站和Mercurial的网站{{< ext url="https://www.mercurial-scm.org" >}}


Git and Mercurial have been popular DVCS technologies for many years. Portals like GitHub make Git, in particular, the default 
choice for SCM/SVC/source-control. While the Linux Kernel is maintained with Git, and definitely takes advantage 
of the D-Distributed aspect of the DVCS of Git (in that many divergent versions of kernel can exist over 
long periods of time), most enterprises are still going to count a single repository as the principal one, and within 
that a single branch as the long-term "most valuable" code line.

多年来，Git和Mercurial一直是受欢迎的DVCS技术。像GitHub这样的门户，特别的使用Git作为SCM/SVC/源代码控制的默认选项。虽然Linux内核使用Git进行维护，也利用Git DVCS的D-Distributed方面的优势（因为许多不同版本的内核可能存在很长一段时间），但大多数企业仍然会用以一个仓库作为主，并且用单分支中作为长期“最有价值的”代码。

It is perfectly possible to do Trunk-Based Development in a Git repository. By convention 'master' is the long term 
most valuable branch, and once cloned to your local workstation, the repository gains a nickname of 'origin'.

在Git仓库中完成基于主干的开发是完全可能的。按照惯例，“master”是长期最有价值的分支，一旦克隆到您的本地，仓库就会获得一个叫“origin”的昵称。

### Forks
### Forks

An effective Trunk-Based Development strategy, for Git, depends on the developer maintaining a fork of the origin 
(and of master within), and Pull-Requests being the place that ready to merge commits are code reviewed, **before** being 
consumed back into `origin:master`. Other branching models use the same Pull-Request process for 
code-reviews too - it is the normal way of working with Git since GitHub rolled out the feature.

对于Git而言，有效的基于主干的开发策略是：开发人员维护origin（和master）分支，在代码何如`origin:master`之前，Pull-Requests作为对合并的代码进行代码审查的地方。其他分支模型也使用相同的Pull-Request过程进行代码审查 - 这是GitHub推出功能后常用的Git方法。

### Size Limits
### 容量限制

Historically, Git and Mercurial were not great at maintaining a zipped history size greater that 1GB. Many 
teams have reported that they have a repository size larger than that, so opinions differ. One way that you can reach 
that 1GB ceiling quickly is with larger binaries. As Git keeps history in the zipped repository, even a single larger 
binary that changes frequently can push the total use above 1GB.

历史上，Git和Mercurial并不能很好地维持一个大于1GB的压缩历史。许多团队报告说，他们的存储库大小大于此，所以持有不同的意见。快速达到1GB天花板的一种方法是使用较大的二进制文件。由于Git将压缩存储库中的历史记录保留下来，即使是更改频率更高的二进制数也可以将总使用量推高到1GB以上。

With the likes of correctly configured Git-LFS extension to Git, though, the 1GB limit can be avoided or delayed 
many years.  

尽管如此，为Git正确的配置Git-LFS，可以避免或延迟1GB的限制。

Git also has Submodules{{< ext url="https://git-scm.com/docs/git-submodule" >}} and 
Subtrees{{< ext url="https://blogs.atlassian.com/2013/05/alternatives-to-git-submodule-git-subtree" >}} to allow large 
federations of modules, within one cloneable set.  For their 
 Android initiative, Google made Git-repo{{< ext url="http://source.android.com/source/using-repo.html" >}} too.

 Git还具有子模块{{< ext url="https://git-scm.com/docs/git-submodule" >}}和子树{{< ext url="https://blogs.atlassian.com/2013/05/alternatives-to-git-submodule-git-subtree" >}}，允许在一个可克隆集合内的模块进行大型联合。Google对他们的Android计划，也做了Git-repo。

### Root level branches
### 根级分支

It'll be clear later why we mention this, but Git and Mercurial maintain branches from the root folder of the 
checkout clone, and maintains a single permission for a user in respect of read and/or write on the branch and/or repository.

你稍后会明白为什么我们提到这一点，Git和Mercurial从分支克隆的根文件夹维护分支，并在分支上或者代码库上为用户保留读写或者其一的权限。

### Future development
### 未来发展

There is a suggestion that Mercurial is receiving contributions that will allow it to push into the very repository
territory the likes of Google needs.

有一个迹象表示Mercurial正在接受一些贡献，这些共享将允许它进入谷歌需求的代码库的领域。

Git and Mercurial don't have branch or directory permissions, but some of the platforms that bundle them, add 
branch permissions.

Git和Mercurial没有分支或目录权限，但是捆绑它们的一些平台添加了分支权限。

### Linux Torvalds presenting Git to Googlers
### Linux Torvalds向Google员工介绍Git

Back in 2007, Linus Torvalds presented his Bitkeeper inspired Git to Googlers in their Mountain View office:

早在2007年，Linus Torvalds就在Mountain View办公室中向Google员工展示了他受Bitkeeper启发而发明的Git：

<div noprint style="position: relative; padding-bottom: 56.25%; padding-top: 30px; height: 0; overflow: hidden;"><iframe src="//www.youtube.com/embed/4XpnKHJAok8" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;" allowfullscreen frameborder="0"></iframe></div>
 
<!-- print <img src="linus-git.png"> print -->
<!-- print <br/> print -->
<!-- print <a href="https://youtu.be/4XpnKHJAok8">Video Available at https://youtu.be/4XpnKHJAok8</a> print --> 
 
He had started making it two years before, and it is now the #1
VCS choice. Google had been running their Monorepo style Trunk for a few years at this point, without regret. Some
Googlers would later extend their Perforce (see below) setup to allow Git operation of local branches on
developer workstations.

两年前他已经开始做了，现在是第一的VCS选择。在这一点上，Google已经运行了Monorepo风格的主干几年，没有任何后悔。一些Google员工稍后会扩展其Perforce（见下文）的设置，以允许Git在开发人员工作站上运行本地分支。

### Platform Software Choices
### 平台软件选择

* GitHub {{< ext url="https://github.com" >}} - Git, cloud 
* GitHub Enterprise {{< ext url="https://enterprise.github.com/home" >}} - Git in GitHub's on-premises edition
* Gitlab {{< ext url="https://about.gitlab.com" >}} - Git, cloud and on-premises install
* Atlassian's Bitbucket server {{< ext url="https://www.atlassian.com/software/bitbucket/server)" >}}- Git and Mercurial
* RhodeCode {{< ext url="https://rhodecode.com" >}} - Git, Mercurial
* Various Collabnet{{< ext url="http://www.collab.net" >}} products and services for Git
* Microsoft's Team Foundation Server{{< ext url="https://www.visualstudio.com/tfs" >}} - git, on-premises install


* GitHub {{< ext url="https://github.com" >}} - Git, 云平台
* GitHub Enterprise {{< ext url="https://enterprise.github.com/home" >}} - GitHub的企业版
* Gitlab {{< ext url="https://about.gitlab.com" >}} - Git, 云平台和企业内部安装
* Atlassian's Bitbucket server {{< ext url="https://www.atlassian.com/software/bitbucket/server)" >}}- Git和Mercurial
* RhodeCode {{< ext url="https://rhodecode.com" >}} - Git, Mercurial
* Various Collabnet{{< ext url="http://www.collab.net" >}} Git产品和服务
* Microsoft's Team Foundation Server{{< ext url="https://www.visualstudio.com/tfs" >}} - git, 企业内部安装

## Perforce
## Perforce

Perforce's website{{< ext url="https://www.perforce.com" >}}

Perforce的网站{{< ext url="https://www.perforce.com" >}}

### Vanilla Perforce

Perforce is a closed-source, industrial strength VCS. Pixar stores everything needed to make a movie in it, and Adidas 
store all their designs in it. Until 2012, Google had their Trunk and many tens of terabytes of history in it.
They moved off it to an in-house solution as they outgrew it. Perforce is peculiar in that its 'p4d' (a single server-side 
executable binary file) is the whole server and does not need to be installed - just executed.

Perforce是封闭源，工业级的VCS。皮克斯（Pixar）在此存储一切制作电影的东西，而阿迪达斯则将其所有的设计都存储在其中。直到2012年，Google已经有了主干分支和几十TB的历史。当增长越来越快时，Google将这些代码移至内部解决方案。Perforce是特殊的，因为它的“p4d”（单个服务器端可执行二进制文件）是整个服务器，不需要安装 - 直接执行就好了。

Perforce is the last VCS technology that ordinarily maintains the read-only bit on the developer workstation. You 
definitely need a plugin for your IDE to handle the wire operations with the server, so you are not confronted with the
fact that source files are read-only. Because the Perforce (p4) client having to involve the server for the flipping of
read-only bits in respect of editing source files, it requires a permanent connection to the server. What that 
facilitates is the speed of operation for very large sets of files on the client. The Perforce server already knows what 
files need to have updated in your working copy, ahead of you doing 'p4 sync' operation. It negates the need for a 
directory traversal looking for locally changed files, and it means the sync operation can be limited to a second or two.

Perforce是最后一个在开发人员工作站上维护只读位的VCS技术。你必须要一个IDE插件来处理与服务器的有线操作，才您不会面临源文件为只读的事实。由于Perforce（p4）客户端必须要连接到服务器才能翻转只读位，所以就需要永久连接到服务器。这项技术有助于操作客户端上大量文件的运行速度。在您进行“p4同步”操作之前，Perforce服务器已经知道您的工作副本中需要更新哪些文件。它不需要遍历目录以查找本地更改的文件，这意味着同步操作可以限制在一秒钟或两秒。

Historically Perforce was not able to **locally** show the history of the files within it. It needed that server 
connection again for history operations. A number of DVCS capabilities in newer versions of Perforce (see below) allow
local history now, though.

历史上，Perforce无法在本地显示其中的文件的历史记录。它需要再次与服务器连接以进行历史记录操作。但是，较新版本的Perforce（见下文）中的一些DVCS功能可以让本地历史得到实现。

Perforce allows branches to be set up at any sub-directory, not just the root one. It also allows read and/or write
permissions to be specified at any directory (or branch) within large and small source trees.

Perforce允许分支在任何子目录中设置，而不仅仅是根目录。它还允许在大型和小型源代码树中的任何目录（或分支）上指定读取和/或写入权限。

#### No Code Review
#### 没有代码审查

Perforce does not have code-review features integrated into its traditional server daemon. By customizing a modified Gitlab 
called GitSwarm 'side install', Perforce now has a code review capability. It also has it with an alternate side-install 
called just Swarm (a slightly older product), that does not offer the Git capability of GitSwarm, but does add in much
of the team-ware features like code review.

Perforce并没有集成到其传统服务器守护程序中的代码审查功能。通过一个名为GitSwarm的定制修改后的Gitlab安装，现在Perforce具有代码审查功能。它还具有另一种安装方式，即仅仅是Swarm（稍旧的产品），不提供GitSwarm的Git功能，但是添加了许多团队的功能，如代码审查。

### Git Fusion

There's a VM appliance from the Perforce people, that can sit in your infrastructure and mediate between the vanilla Perforce
server, and your wish to use a pure Git workflow on your development workstation.

Perforce人员有一个VM应用，它可以架设在你的基础设施中，容易的在vanilla Perforce服务器之间进行协作。你希望在开发工作站上使用纯Git工作流。

With a Git Fusion clone from a Perforce repository, and client spec was specified, you get the subsetted 
representation of the source tree, complete with history. That's a neat feature. Things checked out through Git Fusion
also are not encumbered by the read-only bit feature.

通过使用来自Perforce资源库的Git Fusion克隆，并指定了客户端规范，您将获得源代码树的子集并同时包含历史记录。这是一个优雅的功能。通过Git Fusion检出的内容也不会受到只读位功能的限制。

GitSwarm kinda replaces this.

GitSwarm有点取而代之。

### p4-git and p4-dvcs
### p4-git和p4-dvcs

P4-git is very similar to the Git Fusion technology but is not made by the Perforce people themselves. It also does not 
require the launching of second server appliance (as Git Fusion does).

P4-git与Git Fusion技术非常相似，但并不是由Perforce的人自己制作的。它也不需要启动第二台服务器设备（Git Fusion需要）。

In 2015, the perforce technologies were extended to include custom DVCS features. All the features of p4-git but without 
the Git compatibility.

在2015年，perforce技术被扩展到包括定制DVCS功能。p4-git的所有功能都没有Git的兼容性。

As for Git Fusion, things checked out through p4-git and p4-dvcs are not encumbered by the read-only bit control of p4d.

对于Git Fusion，通过p4-git和p4-dvcs检出的内容不受p4d的只读位控制的影响。

## Subversion

Subversion's website{{< ext url="https://subversion.apache.org" >}}
Subversion的网站{{< ext url="https://subversion.apache.org" >}}

Subversion (Svn) has been in development for 16 years and was a sorely needed open-source replacement for CVS. It chases some of the
features of Perforce but is developed quite slowly. Nobody has pushed Subversion to the Perforce usage levels, but 
that is claimed as a possibility.

Subversion（Svn）已经开发了16年，是CVS开源替代品。它试图追逐Perforce的一些功能，但发展相当缓慢。还没有人将Subversion使用到Perforce的级别，但这被认为是一种可能性。

Subversion, like Perforce, has read and write permissions down to the directory and branch.

Subversion，像Perforce，具有具体到目录和分支的读写权限管理。

Interestingly there is a "Subversion vs Git" website{{< ext url="https://svnvsgit.com/" >}} which attempts to counter
some widely held community beliefs about Subversion and how it stacks up to Git.

有趣的是，有一个“Subversion vs Git”的网站{{< ext url="https://svnvsgit.com/" >}}试图反驳一些广为之人的关于Subversion以及它如何与进行比较Git。

Note also that the Subversion team themselves, do not do Trunk-Based Development, despite Subversion have default root directories 
of 'trunk', 'tags' and 'branches' for newly-created repositories.

还要注意，Subversion团队本身，不要做基于主干的开发，尽管Subversion新建仓库的默认根目录是的“trunk”，“tags”和“branches”。

### No Code Review
### 没有代码审查

Note that Subversion has no local branching capability, and to get code review you need to install third-party servers 
along side it. Or, a better choice, use a platform that integrates code review like those below.

请注意，Subversion没有本地分支功能，要进行代码审查，你需要为它安装第三方服务器。或者，一个更好的选择，使用一个集成代码审查的平台，如下所示。

### Git-Svn

There is an extension to Git that allows it to deal with a Subversion backend. A Git-subversion clone has all the 
local history, local-branching possibilities of Git. The local branching possibilities afforded by this 
mode of operation are very handy, and it should work easily with whatever Svn hosting platform you installed.

Git有一个扩展，它允许以Subversion作为后端。Git-subversion克隆具有Git的本地历史、本地分支的可能性。通过这种操作提供的本地分支机制使用起来非常方便，并且你可以轻松地安装在任何安装的Svn托管的平台。

Note: That clone from subversion can be many tens of times slower, 
than the equivalent clone from Git, because it is recreating the zipped Git history on the client-side as in
uses the classic Subversion wire protocol, which is more chatty. Indeed the initial clone of years of commits for a 
reasonably sized team can take many hours. 

注意：来自subversion的克隆比Git的等效克隆慢几十倍，因为它在客户端需要重新创建压缩的Git历史记录，需要使用经典的Subversion协议。该协议与服务器有更多的额外的交互。事实上，对于合理规模的团队来说，可能需要话费很多时间来克隆一个有几年的提交仓库。

### Platform Software Choices
### 平台软件选择

* RhodeCode{{< ext url="https://rhodecode.com" >}} - installable on-premises
* Various Collabnet{{< ext url="http://www.collab.net" >}} products and services.
* ProjectLocker{{< ext url="http://projectlocker.com" >}} - cloud
* Deveo{{< ext url="https://deveo.com/svn-hosting" >}} - cloud
* RiouxSvn{{< ext url="https://riouxsvn.com" >}} - cloud
* SilkSvn{{< ext url="https://sliksvn.com" >}} - cloud
* Assembla{{< ext url="https://www.assembla.com/subversion" >}} - cloud and installable on-premises
* XP-dev{{< ext url="https://xp-dev.com" >}} - cloud
* Codeplex{{< ext url="https://www.codeplex.com" >}} - cloud

* RhodeCode{{< ext url="https://rhodecode.com" >}} - 内部可安装
* Various Collabnet{{< ext url="http://www.collab.net" >}} 产品和服务
* ProjectLocker{{< ext url="http://projectlocker.com" >}} - 云服务
* Deveo{{< ext url="https://deveo.com/svn-hosting" >}} - 云服务
* RiouxSvn{{< ext url="https://riouxsvn.com" >}} - 云服务
* SilkSvn{{< ext url="https://sliksvn.com" >}} - 云服务
* Assembla{{< ext url="https://www.assembla.com/subversion" >}} - 云服务和内部安装
* XP-dev{{< ext url="https://xp-dev.com" >}} - 云服务
* Codeplex{{< ext url="https://www.codeplex.com" >}} - 云服务

## Team Foundation Server - TFS

TFS's website{{< ext url="https://www.visualstudio.com/tfs" >}}
TFS的网站{{< ext url="https://www.visualstudio.com/tfs" >}}

Microsoft launched TFS in the mid-2000's with a **custom VCS technology** "TFVC". It is said that they have an internal 
'SourceDepot' tool that is a special version of Perforce compiled for them in the nineties, and that TFS reflects some 
of the ways of working of that technology. It has grown to be a multifaceted server platform. Perhaps even a 
one-stop shop for the whole enterprise's needs for application lifecycle management.  More recently with TFS, 
Microsoft encouraged a use of Git within it, rather than then proprietary VCS they initially developed.

微软在2005年左右推出了一款 ***定制VCS技术*** “TFVC”的TFS。据说他们内部有一个叫做“SourceDepot”工具，这是一个在九十年代编写的特殊版本的Perforce，而TFS反映了这种技术的一些工作方式。TFS已经变为一个多方面的服务器平台。甚至是一个一站式的企业应用程序生命周期管理工具。最近在TFS中，微软鼓励在其中使用Git，而不是最初开发的专有VCS。

TFS is perfectly compatible with a Trunk-Based Development usage.

TFS与基于主干的开发使用完全兼容。

Note: Microsoft are donating back to the Git community with a Git Virtual File System, which allows some Monorepo 
usage for Git{{< ext url="https://github.com/Microsoft/GVFS" >}}.

注意：Microsoft正在向Git社区捐赠Git虚拟文件系统，这将允许Monorepo的一些用法在Git上实现。

## PlasticSCM

Platic's website{{< ext url="https://www.plasticscm.com" >}}
Platic的网站{{< ext url="https://www.plasticscm.com" >}}

PlasticSCM is a modern DVCS like Git and Mercurial, but closed-source. It is compatible with Trunk-Based Development and quite 
self-contained (has integrated code review, etc). Plastic is very good with bigger binaries and comes with an 
intuitive "Branch Explorer" to see the evolution of branches, view diffs, execute merges, etc. For sizes of individual
repositories, multiple terabytes is not unheard of. A least for some of the games-industry customers.

PlasticSCM是像Git和Mercurial这样的现代DVCS，但是封闭源代码。它与基于主干的开发兼容，并且功能非常齐全（已集成代码审查等）。Plastic对大的二进制文件支持得很好，并配有一个直观的“分支资源管理器”，以查看分支的演进、查看差异、执行合并等。对于单个仓库的大小，多个T字节已不是什么新闻。至少对于一些游戏行业的客户。
 
It is also the first modern VCS to have semantic merge - it understands 
select programming languages and the refactorings developers perform on them. For example "move method", where that
method is 50 lines long, is not 50 lines added and 50 deleted in one commit, it is a much more *exact* and terse diff
representation. 

它也是第一个具有语义合并的现代VCS，它理解代码所用的编程语言和开发人员进行重构。例如“移动方法”，其中该方法是50行长，在一个提交中不添加50行并删除50行，这是一个更加 *精确* 和简洁的差异表示。

Plastic even calmly handles a situation where one developer moves a method within a source, and another simultaneously 
changes the contents of the method in its former location. Plastic does not consider that a clash at all, and just does 
the merge quietly - the method moves and is changed in its new location.

Plastic甚至能够平静地处理开发者移动源文件的方法和另一个同时改变其原来位置中的方法的内容的情况。它并不认为这是一个冲突，而是平静地融合在一起 - 该方法移动到新的位置并改变。