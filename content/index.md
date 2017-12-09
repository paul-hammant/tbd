---
date: 2017-12-08T18:07:33-03:00
title: Introdução
type: index
weight: 1
---

<!-- print <h1 style="color: white; padding: 32px 20px 72px; background-image:url(/images/LogoSlim.png); background-repeat: no-repeat; background-size: 100% auto"><span style="background-color: #5677fc">Introduction</span></h1> print -->


## Resumo

Um modelo de *branching* para sistema de controle de versão, onde desenvolvedores efetuam *commits* em uma única *branch* denominada *'trunk'* * e resitem a qualquer pressão para criar *branches* de vida longa ao aplicarem técnicas documentadas. Deste modo, evitam o *merge* infernal, não quebram o *build* e vivem continuamente felizes. 


![](trunk1.png)
([key](/key/))

 &ast; *master*, no contexto do Git

Desenvolvimento Baseado em *Trunk* (Tronco) é um elemento chave da [Integração Contínua](/continuous-integration/). No caso, o modelo é projetado para viabilizar a realização de vários *commits* no *trunk* por dia. Deste modo, auxiliando os times a atenderem ao requisito fundamental onde todos o membros do time devem efetuar o *commit* de suas alterações ao menos uma vez a cada 24 horas. Isso garante uma série de benefícios. Dentre eles, a garantia de que base de código presente no sistema de controle de versão está sempre apta a *releases* sob demanda e o auxílio na adoção da [Entrega Contínua](/continuous-delivery/).

## Afirmações

- Você deve usar Desenvolvimento Baseado em *Trunk* ao invés de GitFlow ou qualquer outro modelo que fomente a criação de *branches* de vida longa.
- Você pode efetuar *commit* direto para o *trunk* (para times pequenos) ou o *pull-request* de *feature branches* de vida curta contendo o trabalho de um único indivíduo.

## Cuidados

- Dependendo do tamanho do time e da quantidade de *commits*, [*feature branches* de vida curta](/short-lived-feature-branches/) são usados para revisão de código (*code-review*) e *build checking* (Integração Contínua) como parte do processo de envio do código ao *trunk*. Tais *branches* permitem que desenvolvedores se empenhem no processo de [Revisão Contínua](/continuous-review/) antes do código ser integrado ao *trunk*. Times muito pequenos podem efetuar [ *commits* diretamente para o *trunk*](/committing-straight-to-the-trunk/).

- Dependendo da cadência de *releases* pretendida, pode haver [*release branches*](/branch-for-release/) geradas imediatamente a partir do *trunk*. Tais *release branches* não permitem *commits* e **serão definitivamente removidas** algum tempo depois da *release*. Alternativamente, *release branches* podem não ser criadas caso o time gere [*releases* a partir do *trunk*](/release-from-trunk/) e adotem a política de "resolver em seguida" para *bug fixes*. Também, times de alta performance geram [*releases* a partir do *trunk*](/release-from-trunk/).

- Times devem ser adeptos a técnica de [*Branch* por abstração](/branch-by-abstraction/) para tarefas longas (ex. no Scrum, tarefas que levam dias para completar) e usar [*feature flags*](/feature-flags/) no dia a dia de desenvolvimento para viabilizar *releases* consecutivas (entre outros benefícios - ver [desenvolvimento concorrente de *releases* consecutivas](/concurrent-development-of-consecutive-releases/)) 

- Se você tem uma certa quantidade de desenvolvedores no projeto, você precisa de um [servidor de build](/continuous-integration/) para verificar se os últimos *commits* **não quebraram o *build***. O mesmo ocorre com o processo de *merge* de *feature branches* de vida curta com o *trunk*.

- Times podem crescer ou diminuir sem afetar o *throughput* ou qualidade. Prova? [Desenvolvimento Baseado no Trunk na Google](/game-changers/index.html#google-revealing-their-monorepo-trunk-2016) contém **25000 desenvolvedores e time de automação de *QA*** em um [monorepo](/monorepo/) *trunk*, o qual pode [expandir ou retrair](/expanding-contracting-monorepos/) com base na necessidade do desenvolvedor.

- Pessoas que praticam o modelo [GitHub-flow](/alternative-branching-models/index.html#modern-claimed-high-throughput-branching-models) irão sentir a similaridade entre os modelos. No entanto, existe uma pequena diferença em torno de onde é gerada a *release*. 

- Pessoas que praticam o modelo Gitflow vão achar isso **muito diferente**, do mesmo modo que muitos desenvolvedores acostumados com [modelos mais antigos](/alternative-branching-models/index.html#legacy-branching-models) como ClearCase, Subversion, Perforce, StarTeam e VCS.

- [Muitas publicações](/publications/) promovem o Desenvolvimento Baseado em *Trunk* como descrito aqui. Entre elas *best-selling* como *'Continuous Delivery'* e *'DevOps Handbook'*. Isso não deve ser mais uma controvérsia!

## História

O modelo de Desenvolvimento Baseado em *Trunk* não é recente. A palavra *'trunk'* é referente ao conceito de uma árvore em crescimento, onde a maior extensão do comprimento e largura estão no tronco e não nos ramos (*branches*) irradiados dele e têm uma maior limitação de tamanho.

Desde meados da década de 90 é pouco considerado entre os modelos. Entretato, sua incidência de uso ocorrem desde a década de 80. As grandes organizações de desenvolvimento como Google (como mencionado) e Facebook praticam o modelo em escala.

Há 30 anos diferentes [avanços em sistemas de controle de versão e ferramentas/técnicas relacionadas](/game-changers/) têm feito Desenvolvimento Baseado em *Trunk* mais (e ocasionamente menos) prevalente, mas isso tem sido um modelo de *branching* que muitos têm se deparado através dos anos.

## O site

Este site tenta coletar todos os fatos, racionais e técnicas para Desenvolvimento Baseado em Trunk em um único local, composto por 25 diagramas para ajudar a explicar coisa. Tudo sem usar TBD como uma sigla mesmo ~~uma~~ duas vezes.
