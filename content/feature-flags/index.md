---
date: 2016-04-01T20:08:11+01:00
title: Feature flags
weight: 41
---

*Feature Flags* é uma técnica definitivamente consagrada em relação ao controle das funcionalidades de uma aplicação ou serviço.

### Um exemplo
Digamos que você tem uma aplicação ou serviço que é executado por linha de comando e contem um método `main`. Sua *feature flag* poderia ser o parâmetro `--withOneClickPurchase` passado via linha de comando durante a incialização da aplicação ou serviço. Este parâmetro poderia ativar linhas de código que permitissem os usuários da aplicação ou serviço usufruirem da funcionalidade "comprar com um clique" patenteada pela Amazon. Porém, sem o parâmetro (sem a *feature flag*), a aplicação conduziria o usuário a funcionalidade do componente "carrinho de compras". Esta é uma das formas de implementação de *flags*. No caso, um caminho implícito (se não foi **a** então o caminho será **b**) adotado pelos desenvolvedores o qual reflete o modelo de negócio. Uma outra possibilidade seria uma declaração explicita que **adiciona** um caminho levando em consideração um outro já existente, o qual poderia ser refletido pelo parâmetro `--allowUsersToUseShoppingCartInsteadOfOneClick`. Ou seja, a implementação pode adotar uma abordagem aditiva.

{{< note title="Flags são Toggles" >}}
O Iluminista (iluminário?) industrial, Martin Fowler, denomina esta técnica de *Feature Toggles*, e escreveu um definição fundamentada acerca disto (ver referências). Entretanto, dado que o termo *Feature Flags* é largamente utilizado pela indústria, iremos continuar utilizando-o.
{{< /note >}}

## Granularidade
Pode ser que a *flag* controle algo grande como um componetne de UI. No caso apresentado anteriormente, `OneClickPurchasing` e `ShoppingCart` seriam os nomes dos componentes. Ainda, pode ser que uma *flag* contemple um contexto mais granular - digamos que Americanos queiram ver  temperaturas em Fahrenheit e outras nacionalidades prefeririam graus em Celcius ou Centrígrados. Assim, teríam-se duas *flags*: `--temp=F` e  `--temp=C`. Por diversão, desenvolvedores adicionariam uma terceira `--temp=K` (Kelvins), por exemplo.

## Implementação

Para alternar-se entre os componentes `OneClickPurchasing` e `ShoppingCart`, a abstração `PurchasingCompleting` 
foi criada. Então, no processo de boot da aplicação a flag `--withOneClickPurchase` seria possível controlar o fluxo do código das seguintes maneiras:

Manualmente (Java):

```java
if args.contains("--withOneClickPurchase") {
  purchasingCompleting = new OneClickPurchasing();
}
```

ou, por injeção de dependência via configuração (Java):

```java
bootContainer.addComponent(classFromName(config.get("purchasingCompleting")));
```

Existem várias maneiras de se implementar *flags* em tempo de execução. Entretanto, se possível, evite condições if/else durante o caminho para ativação/desativação dos componentes. Observe nossa ênfase em uma abstração.

## Pipelines de Integração Contínua

É importante garantir os resultados da permutação das *flags*. Isso significa que testes realizados após a execução de em uma aplicação ou serviço devem ser flexíveis para contemplar os cenários permuta. Em termos de pipelines de Integração Contínua, isso significa que haverá adição de novos testes **após** a fase de testes unitários para cada permuta que faça sentido. Em outras palavras, cada **commit** para o trunk executará mais de um build - provavelmente em uma infraestrutura elástica. 

## *Flags* mutáveis em tempo de execução

Às vezes, *flags* em tempo de inicialização não são suficientes. Digamos que você tem uma linha aéra vendendo passagens online. Você poderia aproveitar o site para também alugar carros de diferentes parcerias - digamos 'Really Cool Rental Cars' (RCRC). No caso, você não tem o controle da estabilidde do sites de seus parceiros. Portanto, você poderia optar por ativar ou desativar um parceiro sem precisar reinicar seu site e viabilizar a equipe de suporte 24&#47;7 a facilidade de operar no ambiente através de *flags*. Nesse caso, o usuário final não notaria a indisponibilidade de parceiros. Exemplo, ao desabilitar a Hertz, o sistema ainda teria Avis e Enterprise como parceiros.

A chave para *flags* mutáveis em tempo de execução é a persistência de estado. Por padrão, uma eventual reinicialização da aplicação não traria o estado anterior da *flag* - o sistema deveria armazenar o estado prévio. Isso torna-se ainda mais complicado quando se pensa em uma *flag* permeando processos em nós de um cluster escalado horizontalmente. Uma maneira moderna de resolver isso é manter estado da *flag* em serviços como Consul{{< ext url="https://www.consul.io" >}}, Etcd{{< ext url="https://github.com/coreos/etcd" >}} ou outros equivalentes.

## *Flags* em tempo de compilação (build)

*Flags* em tempo de compilação impactam a aplicação ou serviço a medida que isso esta sendo compilado. Novamente, levando em consideração a *flag* `--withOneClickPurchase`, não seria possível utilizar a funcionalidade "comprar com um clique" se a *flag* não fosse passada como parâmetro durante a compilação da aplicação.

## Testes A/B e betas

Funcionalidaeds desativadas em execução podem ser reativadas e direcionadas para parte dos usuários. Teste A/B (dirigidos a *marketing*) utilizam *Flags* em tempo de execução para isso. Assim, disponibilizando versões beta de uma funcionalidade para determinado grupo de usuáios.

## Débitos técnicos - armadilha

Com o passar do tempo, *Flags* são (i) inseridas no código e (ii) frequentemente esquecidas a medida que o time de desenvolvimento é direcionado a novas entregas. Claro, você precisa de tempo para remover as *flags* e é ai que mora o perigo. Primeiro, a aplicação está funcionando como esperado, mesmo com as *flags* da maneira como estão. Segundo, pode não haver uma cobertura adequada de testes unitários que garantam as mudanças necessárias para a remoção das *flags*. Além disso, o cliente não "liga" para tal débito técnico, reforçando ainda mais a perpetuação do problema. Nesse caso, tente alinhar com o time de negócio um tempo determinado para remover *flags* desnecessárias. Exemplo, um mês após a release é necessário resolver o problema.

## História

Alguns predecessores históricos das *feature toggles/flags*:

- Unified Versioning through Feature Logic (Andreas Zeller and Gregor Snelting, 1996){{< ext url="http://www.cs.tufts.edu/~nr/cs257/archive/andreas-zeller/tr-96-01.pdf" >}} - white paper.
- Configuration Management with Version Sets: A Unified Software Versioning Model and its Applications (Andreas Zeller's, 1997){{< ext url="https://www.st.cs.uni-saarland.de/publications/files/zeller-thesis-1997.pdf" >}} - Ph.D. thesis.

Há uma alerta também: 

- "#ifdef considered harmful" (Henry Spencer and Geoff Collyer, 1992){{< ext url="http://www.literateprogramming.com/ifdefs.pdf" >}} - white paper.

Brad Appleton diz:

<br><div style="padding-left: 45px; padding-right: 45px"><span style="font-size: 150%">&ldquo;</span>
A coisa que eu não gosto acerca de *feature toggles/flags* é quando elas acabam NÃO tendo **vida curta** e nós precisamos revisitar o famoso artigo de Spencer e Collyer. O engraçado é que *feature-branches* começaram da mesma forma. Quando elas foram introduzidas no contexto de *feature-teams* e seus enormes escopos de funcionalidades, *branches* foram criadas para ajudar na concorrência durante o envio de código ao repositório. Então a idéia foi separar *branches* (escalibilidade) a fim de que times integrassem (*merge*) seus códigos na *branch* do time diariamente ou mais frequentemente e COM ao menos uma integração noturna de todas as *feature-branches* [sigh].
</div>

# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>

<div>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">29 Oct 2010, MartinFowler.com article</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://martinfowler.com/bliki/FeatureToggle.html">Feature Toggle</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">30 May 2011, TechCrunch article</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://techcrunch.com/2011/05/30/facebook-source-code">The Next 6 Months Worth Of Features Are In Facebook's Code Right Now, But We Can't See</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">19 Jun 2013, Slides from a talk</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="http://www.slideshare.net/cb372/branching-strategies">Branching Strategies: Feature Branches vs Branch by Abstraction</a></td>
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
            <td style="padding: 2px" valign="top">08 Feb 2016, MartinFowler.com article</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://martinfowler.com/articles/feature-toggles.html">Feature Toggles</a></td>
        </tr>
    </table>
    <table style="border: 0; box-shadow: none">
        <tr>
            <td style="padding: 2px" valign="top">23 May 2017, DevOps.com article</td>
        </tr>
        <tr>
            <td style="border-top: 0px; padding: 2px" valign="top"><a href="https://devops.com/feature-branching-vs-feature-flags-whats-right-tool-job/">Feature Branching vs. Feature Flags: What’s the Right Tool for the Job?</a></td>
        </tr>
    </table>
    
</div>
