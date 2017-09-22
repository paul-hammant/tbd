---
date: 2016-03-01T20:08:11+01:00
title: 版本控制系统特性
weight: 31
---

**理想的VCS功能，就是**

To great degree, Trunk-Based Development is possible on any Version Control System (VCS) that does atomic commits (spoiler: all do 
that came after CVS).  Productivity and governance are what divides them, though.

在很大程度上，基于进行原子提交的任何版本控制系统（VCS）都可以实现基于主干的开发（剧透：CVS之后都可以）。尽管如此，生产力和管理是划分的。


## Productivity

It turns out there are many 
productivity related reasons that teams quit one technology and go to another. It does not matter whether the tool is a commercial
or an open source one. At least to its end users it does not.

事实证明，有许多生产力相关的原因使得团队放弃了一项技术，而转向另一种技术。这项技术不管是商业用途还是开源，至少对其最终用户来说并不是他们关心的。

By speed we mean two things primarily:

1. The speed at which we can pull/update/sync changes out of a remote server repository
2. The speed at which we can commit/push changes back to that remote server

按速度来讲我们主要是说这两件事：
1. 从远程服务器存储库中拉取/更新/同步更改的速度
2. 向远程服务器提交/推送的速度更改的速度

And three other secondary things that support little and often:

1. Advanced Merging
2. Code Review
3. Continuous Integration

另外还有三个次要的东西，虽然很少但经常发生：
1. 高级合并
2. 代码审查
3. 持续集成


### Pull/update/sync speed

If you have at least once done a checkout of the source of the project, any subsequent pull/update/sync is going to bring down 
differences from the previous checkout or update.  If you do two updates back to back quickly, the second one is likely to bring 
down nothing.  The time taken for the version control tool to determine that nothing is due from the remote master 
repository is the biggest clue as to how intrinsically fast it is. 

如果你至少一次从源代码中检出过，任何后续的拉取/更新/同步操作会将把和上一次检出的差异拉下来。如果您快速地进行两次更新，则第二个更新可能什么也拿不到。版本控制工具有多快可以用它确认远程主仓库没有什么更新所需的时间作为最大的线索。

Technologies that only keep head revision on the checkout, ordinarily have to walk the entire directory structure 
looking for changed files and do handshaking to the server for each one. That is definitely Subversion and its predecessor CVS. 
Batching of those exchanges speeds it up, but there is still a slowdown related to the breadth and depth of the source
tree. Perforce makes the operation faster because the server-side is poised for the sync operation at all times, by 
keeping your tree and which revision you have for each file in RAM. It does this at the cost of maintaining read-only
bits for files (be sure and use an IDE that silently handles the Perforce interactions). Perforce can effectively be much
faster for this back-to-back pull/update/sync test of speed because it kinda already knows the answer to the question.

那些在签出时只保持头版本的技术，通常需要便利整个目录去查找改动的文件并和服务器一一的进行握手。这就是Subversion及其前身CVS。将这些操作打包起来会有一定的速度提升，但源码的广度和深度都会使之变慢。Perforce（译注：一种源码管理软件）和服务器端始终保持同步操作因而操作更快，你的源代码树和每个文件的版本都记录在内存中。它以维护文件的只读位为代价（请确保并使用默认处理Perforce交互的IDE）。Perforce可以有效地快速地进行这种连续的拉取/更新/同步测试的速度，因为它已经知道问题的答案。

CVS, Subversion and Perforce offer you the choice of checking out a subdirectory. In a monorepo situation, you would 
consider that a nice feature. At least if you've recursively laid out services and applications within the trunk.

CVS，Subversion和Perforce提供了检出子目录的功能。在monorepo的情况下，你会认为这是一个很好的功能。至少如果你在主干中重复地布置了服务和应用程序。

Git and Mercurial have a single point of checkout (Git's 'clone' operation) for the whole repository.  There are no sub-directory checkouts 
for these two. All commits since that 
last 'pull' will be pulled down. This happens before the directory walk to determine what has changed locally. As such, that 
pull operation if very fast - there's no chit chat over the wire things, and the stuff on the server-side was already 
zipped and pretty much ready for transfer. This will be the case even for situations where a particular 
file has been changed a dozen times since you last pulled it down via a sync operation.  You might think 
this is costly, but in practice, Git is incredibly fast.

Git和Mercurial为整个代码仓库提供单点签出（Git的“克隆”操作）。这两个工具没有子目录检出的功能。所有在最后那次“拉取”之后的提交将被拉下来。这是在目录遍历之前发生的，以确定在本地发生了什么变化。因此，拉取操作非常快 - 它没有任何其他额外的服务器交互，并且服务器端的东西已经压缩并且准备好传输。即使特定文件自上次通过拉取操作后经过十几次更改，情况也将如此。你可能认为这代价很高的，但在实践中，Git是非常快的。


### Commit/push speed

Things are more equal here between the tools we highlight as viable.  

Subversion and Perforce send up deltas of changed files to the server. Some directory walking can slow this down. There 
is inevitably a lot of chit-chat on the wire for these operations. 

Git and Mercurial do the same, but before you push to the remote repo it will make you commit locally which is incredibly 
fast. Before you push to the shared remote repository, these two will make you pull first.  

Perforce and Subversion will allow you to commit/push changes to the remote, without necessarily having the latest versions (and 
incidentally all the intervening ones) locally first.  It will only allow that if there was no clash on the lines changed.

Perforce can cheat again, but taking advantage of the read-only bit, and therefore already knows which files definitely 
have **not** changed between the remote master repo and local working copy. It still feels slower than it should be, though.  

### Three-way merge tools

Developers (hopefully in pairs) are going to have to become skilled in arbitrating over merges for the commits they 
are trying to promote to the remote trunk, as well as the changes they are updating from that it in the case that they 
have work in progress in their working-copy. Trunk-Based Development teams, you see, are merging more often. Albeit 
those are smaller merges, and they are implicitly merged to your working copy.

Perforce's three-way merge tool (P4Merge) is good enough on its own to be attractive to teams using other VCS 
technologies. For those other technologies, P4Merge  is just a config setting away from being usable.  

Semantic merge is the next step up in the science of source-control. See [Plastic SCM](/vcs-choices/index.html#plasticscm).

### Code Review

Integrated code review turned out to to be the killer feature of VCS tools. This should have been clear from the moment Mondrian
was unveiled by Guide van Rossum (Mr. Python) in a publicized Google 'tech talk' in 2006. It delivered pre-commit
code reviews to developers and gamified the activity of code review to some degree. Google was
using Perforce back then (they changed to an in-house technology in 2012), and it did not have code review build in, so 
they had to make Mondrian (which was the final form of years of intermediate deliverables for the same). Thus
Mondrian being created tightly coupled code review to the hourly activities of developers on the trunk. 

GitHub (not Git) was next for the non-Google dev world with a built in code-review tool (and workflow). Again this was 
effectively pre-commit - or at least commit to the master.

There were (and are) other technologies for code review such as Crucible (Atlassian), UpSource (JetBrains), Gerrit, 
Phabricator, but integration into a platform experience is key.  GitLab and RhodeCode are emerging platforms.

Read more in [Game Changers - Google's Mondrian](/game-changers/index.html#google-s-internal-devops-2006-onwards) and 
[Game Changers - GitHub's Pull Requests](/game-changers/index.html#github-s-entire-platform-2008-onwards).

### Continuous Integration testing

This goes hand in hand with the Code Review capability. CI Servers kick in for commits are pushed up code review branches, 
or at least against change sets that are entering code review and validate them. The regular build, and maybe some 
additional steps are executed against them and the results of those made available to code reviewers, Facebook has a 
Service Level Agreement to have those complete ten minutes after the commit has been placed in the 'needs code review'
queue.

The reality of VCS platforms today is that they only provided hooks (web-hooks most likely) into other CI servers. The
best combinations of VCS platform and CI server do so for any of the branches in play, including code-review branches 
(forks).

## Governance

It turns out that enterprises like the ability to carve up permissions, and set read and write permissions throughout
their repositories.

### fine grained permissions

All VCS usages need users accounts to be able to accept changes back, even if they don't all require accounts in order
to be able to read. In the enterprise user accounts will be required to be able to read too.

The larger the enterprise the more likely it will be that they have permissions carved up in more file grained ways.
For example "can commit to the trunk, but cannot create release branches" will be common for Trunk-Based Development
teams that make release branches.  Not all VCS technologies support that. Git, for example, does not, but some of the 
portal experiences around it, add the feature. In reality, though, you cannot stop people from making branches in a DVCS,
but you can prevent them from pushing them to the shared repository.

Deeper still, some enterprises will want to set permissions down the directory level within a branch within a repository.
This could be as simple as a gate, to ensure that process is adhered to around checkins, but could also be to guard
some secrets in a Monorepo implementation. That last is counter to some of the "common code ownership" ideals of
modern software engineering though.

### Size / Scale

Many teams, particularly those with Monorepo configurations or large binary files (like Games companies), want to have 
limitless server-side storage for their repository.  Git and Mercurial are inching towards bigger and bigger 
capacity, but there are still a few snafus to work through - how to cleanly/safely reduce the size of the client side clone
history (while still being able to push changes back to the server) is a challenge.

Microsoft released Git Virtual File System (~~GitVFS~~ GVFS{{< ext url="https://github.com/Microsoft/GVFS" >}}) in early 2017, to layer on some of the things they had 
become used to in the in-house recompilation of Perforce (SourceDepot - used from 1998 to 201x), as well as native VCS 
of their commercial offering Team Foundation Server (TFS).
