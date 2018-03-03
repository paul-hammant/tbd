---
date: 2015-01-05T09:42:02+05:00
title: Contexto
weight: 5
---

<!--A development team wanting to go ahead with Trunk-Based Development have pre-requisite achievements. Once the team has done a few commits in the correct style, other things are now facilitated. We can show this as a layer cake:-->
Um time de desenvolvimento que espera ir em frente com o Desenvolvimento Baseado em *Trunk* precisa atender a um pré-requisito (ver camada inferior na imagem). Ao atendê-lo, torna-se fácil a adoção de abordagens relacionadas a ambientes modernos de desenvolvimento. Tanto o pré-requisito quanto tais abordagens estão representadas na imagem em camadas a seguir:

![](layer_cake.png)

No contexto, DevOps abrange todas as camadas da imagem viabilizando cultura, processos e ferramentas que auxiliam o time de desenvolvimeto a entregar software rápido sem perder qualidade.

## Pré-requisitos para o Desenvolvimento Baseado em *Trunk*

(camada abaixo)

A instalação do seu Sistema de Controle de Versão é uma parte fundamental para a infraestrutura de desenvolvimento que também inclue os laptops e Desktops para construção de testes e execução da aplicação ou serviço em desenvolvimento. Desenvolvedores necessitam que essa camada funcione com os recursos necessários para que a aplicação seja executada de forma adequada. Entretanto, sem a necessidade de prover atributos idênticos ao de produção. Por exemplo, mesma performance do servidor de produção.

Em ambientes DevOps modernos, isso pode estar relacionado com o tema de Infraestrutura como Código (IaC).

##  Desenvolvimento Baseado em *Trunk* facilita 

(Camadas acima)

### Integração Contínua

[Integração Contínua](/continuous-integration/) (IC) tem sido utilizada desde meados da década de 90 em sua moderna encarnação (integração e testes frequentes na base de código compartilhada).

É importante que o leitor entenda que há uma sobreposição entre Desenvolvimento Baseado em *Trunk* e Integração Contínua, conforme definida por seus criadores e escritores. Enquanto o Desenvolvimento Baseado em *Trunk* foca no workflow de código fonte e na disciplina do desenvolvedor, a Integração Contínua além desses aspectos, também foca na necessidade de haver máquinas para automatizar o processo contínuo de integração de código e notificações de problemas relacionados (ex. inviabilidade na construção, report análise de código).

### Entrega Contínua

[Entrega Contínua](/continuous-delivery/) (EC) é uma camada acima, tem sido praticada desde meados da década de 2000 é documentada por Jez Humble e Dave Farley's no livro de mesmo nome em 2010. Este site apresenta um resumo de 5% acerca da prática. O leito deve ir fundo no Livro e o site do mesmo, sem demora.

### Lean Experiments

With CD locked in, continual improvement experiments can happen with a focus on time through "the machine" that is your development and delivery operation. The experiments should draw off the field of science that is "Lean" so that the impact of each experiment can be measured against predictions and decisions made appropriately following it.

Lean Experiments can happen in any development team on any project but work **best** on foundations that 
are solid. Specifically, the solid foundations of Trunk-Based Development, CI, and CD. 

This site does not touch on Lean Experiments beyond this section, but the reader should strive to understand that field of science when the lower layers of the stylized cake are solid.
