---
date: 2015-01-05T09:42:02+05:00
title: Contexto
weight: 5
---

<!--A development team wanting to go ahead with Trunk-Based Development have pre-requisite achievements. Once the team has done a few commits in the correct style, other things are now facilitated. We can show this as a layer cake:-->
Um time de desenvolvimento que espera ir em frente com o Desenvolvimento Baseado em *Trunk* precisa atender a um pré-requisito. Ao atendê-lo, o time facilita a adoção de outras metodologias. É possível apresentar tais elementos em uma imagem em camadas:

![](layer_cake.png)

No contexto, DevOps abrange todas as camadas da imagem viabilizando cultura, processos e ferramentas que auxiliem o time de desenvolvimeto a entregar software rápido sem perder qualidade.

## Pré-requisitos para o Desenvolvimento Baseado em *Trunk*

(camada abaixo)

A instalação do seu Sistema de Controle de Versão é uma parte fundamental para a infraestrutura de desenvolvimento que também inclue laptops e Desktops para construir testes e executar a aplicação ou serviço sendo desenvolvido. Desenvolvedores necessitam que essa camada funcione com os recursos necessários para que a aplicação seja executada de forma adequada. Entretanto, sem a necessidade prover atributos semelhantes ao de produção. Por exemplo, mesma performance do servidor de produção.

Em ambientes DevOps modernos, isso deve estar relacionado com Infraestrutura como Código (IaC).

## Trunk-Based Development facilitates

(Camadas acima)

### Integração Contínua

[Integração Contínua](/continuous-integration/) (IC) tem sido utilizada desde meados da década de 90 em sua moderna encarnação (integração e testes frequentes na base de código compartilhada).

É importante que o leitor entenda que há uma certa confusão entre Desenvolvimento Baseado em *Trunk* e Integração Contínua, conforme definida por seus criadores e escritores. Enquanto o Desenvolvimento Baseado em *Trunk* foca no workflow de código fonte e na disciplina do desenvolvedor, a Integração Contínua além desses aspectos, também foca na necessidade de haver máquinas para automatizar o processo contínuo de integração de código e notificações de problemas relacionados (ex. inviabilidade na construção, report análise de código).

### Entrega Contínua

[Entrega Contínua](/continuous-delivery/) (CD) 
is a layer on top of that, has been practiced since the mid-2000's, and 
documented in Jez Humble and Dave Farley's book of the same name in 2010.  This site gives a 5% summary of the 
practice. The reader should dive into the Book and associated site, without delay.

### Lean Experiments

With CD locked in, continual improvement experiments can happen with a focus on time through "the machine" that is your 
development and delivery operation. The experiments should draw off the field of science that is "Lean" so that the 
impact of each experiment can be measured against predictions and decisions made appropriately following it.

Lean Experiments can happen in any development team on any project but work **best** on foundations that 
are solid. Specifically, the solid foundations of Trunk-Based Development, CI, and CD. 

This site does not touch on Lean Experiments beyond this section, but the reader should strive to understand that field
of science when the lower layers of the stylized cake are solid.
