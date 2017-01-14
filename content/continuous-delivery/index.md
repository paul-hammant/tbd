---
date: 2016-03-09T20:10:46+01:00
title: Continuous Delivery (CD)
weight: 40
---

Continuous Delivery is the practice expanding your Continuous Integration (CI) usage to automatically
re-deploy a proven build to a QA or UAT environment. If the bounce time for a deployment is quick enough,
then it could be that you're doing that for every commit that lands in the shared trunk. The Radiator's pipeline view would 
become:

![](/images/pipelines2.png)

The [best selling book of the same name](/publications/#continuous-delivery-july-27-2010) by Jez Humble and Dave Farley, 
details the 'marching orders' for many companies, where there is whole dev-team improvement agenda.

TODO Pipelines

## Continuous Deployment

**An automatic push all the way into production; Maybe every commit**

This is a extension of 'Continuous Delivery', but the deployment is to production. Certain types of startups like 
NetFlix, Etsy and Github deploy their major application to production with each commit. Companies that have 
applications/services where  clients/customers could lose money, are much less likely to *firehose into production*.

# References elsewhere

<a id="showHideRefs" href="javascript:toggleRefs();">show references</a>

Date    | Type  | Article
--------|-------|--------
5 Jan 2015 | TheGuardian newspaper on their CD | [Delivering Continuous Delivery, continuously](https://www.theguardian.com/info/developer-blog/2015/jan/05/delivering-continuous-delivery-continuously)




