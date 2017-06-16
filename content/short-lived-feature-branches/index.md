---
date: 2016-06-03T20:10:46+01:00
title: Short-Lived Feature Branches
weight: 63
---

<!-- sdfsdfsd -->

Este modelo de *branching* foi facilitado com o advento de ramificações muito leves que vieram com Git e Mercurial em meados dos anos 2000, ou como ramificação diretamente do mestre, ou em um _fork_ de todo o repositório. Esses *branch* estão destinados a voltar como _pull requests_ no master / tronco.

<!-- wrweresd -->

Com este avanço, o ponto de corte no tamanho da equipe para "direto para o tronco" abaixou. Embora fosse até 100 antes da ramificação leve de Git, agora é até 15 pessoas. Com 16 ou mais, a equipe é mais produtiva com ramos de recursos de curta duração e os daemons de CI correspondentes, verificando aqueles que antecipam a aterragem no tronco.

Uma regra de chave é o período de vida do ramo antes que ele seja mesclado e excluído. Simplificando, a filial só deve durar alguns dias. Há mais de dois dias, e existe o risco de o ramo se tornar um ramo de longa vida (a antítese do desenvolvimento baseado em tronco).

<!-- sdwerfhfsdfsd -->

Outra regra de chave é a quantidade de desenvolvedores permitidos congregar em um ramo de recursos de curta duração. Outra resposta simples: a contagem do desenvolvedor deve permanecer em uma (ou duas, se for a programação de par). Esses ramos de recursos de curta duração não são compartilhados em uma equipe para atividades de desenvolvimento geral. Eles podem ser compartilhados para fins de revisão de código, mas isso é completamente diferente para escrever código de produção e testes.

<!-- hrhykj -->

![](/5-min-overview/trunk_pr.png)

Sometimes the community calls these 'task' or 'topic' branches, instead of long-lived feature branch.

## Merge directionality

Short-lived feature branches are real branches and merge is a first class concept. In the run up to completing work
on the short-lived feature branch, you will need to bring it up to date with master (trunk). That is an effective
merge whichever way you do it. Look at the branch at this moment, it may appear to be much younger than it was
before that operation. The changes have to now go back to master (trunk) in another merge operation. In GitHub, for
'pull requests' (or equivalent in other platforms), the user interface may handle that last merged back for you, and even
go as far as to delete the short-lived feature branch.

<!-- rteghfhj -->

To recap: merges to the short-lived feature branch are allowed to bring it closer to HEAD of master (trunk). Merges
to master (trunk) are allowed only as part of closing out the short-lived feature branch (and just before deleting) it.

<!-- rteyyrt -->

## Two developers concurrently doing short-lived feature branches

Say two features are being worked on concurrently: features X and Y. Both will take a day to complete, and two developers are
working independently on them. Of four developers if pair-programming is that team's way.  The reality of the merge back to
master/trunk, before the deletion of the short-lived feature branch, is that the a merge of changes **from** master/trunk
is often needed, before the merge **to** master/trunk.

![](slfb_pull-push.png)

Workflows include:

* Attempt to merge to master/trunk and if that's blocked do a merge/pull from master/trunk before attempting the push again.
* Do a speculative merge/pull from master/trunk before attempting any push to master/trunk.

<!-- dwewrerg -->

The latter leaves no trace if there's nothing to merge in from the other branch.

### Workstations included

Really though Developers work on their own workstations. That is both in working copy, and in local clones/branches:

![](slfb_working-copy.png)

<!-- fhtytrerwe -->

The white dots are just general development work, and the green dot is the same but validated by a build that passes, a commit,
and possibly a push to somewhere.

While each developer works, they maintain a local clone of the master/trunk and their own short-lived feature branch only.
Indeed for a period of time, their short-lived feature branch may not yet exist in the shared origin repo.

<!-- qetgrth -->

## Personal preferences

At some point, the short-lived feature branch has to be bought right up to date with master (trunk) in a merge
operation before the result being merged back to trunk (and the branch deleted). There are a number of approaches
for this, and while teams may have a policy, most leave it to personal preference for the developer.

### Git stash

Some people do `git stash` before `git pull` before `git stash pop`. There's a chance that when you `pop` your
working copy may be in a merge clash situation that has to be resolved before you progress. This way will always
result in your change being a single commit, at the HEAD of the branch (as Subversion would always do).

<!-- werregg -->

### Git rebase

Some people do `git rebase`. Refer to a well written Atlassian document on this {{< ext url="https://www.atlassian.com/git/tutorials/merging-vs-rebasing" >}} as well as one from ThoughtBot {{< ext url="https://robots.thoughtbot.com/git-interactive-rebase-squash-amend-rewriting-history" >}} that talks about `squash` too.  Even with this model,
you may encounter a merge clash, and have to resolve that locally before you can push the result anywhere, or do
further merges (to master hopefully).

<!-- wqwedsfsg -->

## Breaking the contract

![](slfb_bad_sharing.png)

If you merged the part-complete short-lived feature branches to anywhere else, then you have broken the
contract of trunk-based development. For short-lived feature branches, these are **not** allowed:

<!-- dgytjffdd -->

1. intermediate merges to master (trunk)
2. merges (intermediate or not) to other people's short-lived feature branches
3. merges (intermediate or not) to any release branches (if you have them)
4. variations of #2 that are direct from/to the developers clone on their workstation

# Alternatives to short-lived feature branches

<!-- qweqwgtht -->

There is a more traditional alternative for smaller teams:
[Committing straight to the trunk](/committing-straight-to-the-trunk/).

# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>

<div>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">26 Apr, 2007, Blog Entry</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://paulhammant.com/blog/branch_by_abstraction.html">Introducing Branch By Abstraction</a></td>
        </tr>
    </table>
</div>
