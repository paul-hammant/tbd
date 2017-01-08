---
date: 2016-03-09T20:10:46+01:00
title: Continuous Delivery (CD)
weight: 40
---

Continuous Delivery is the practice expanding your Continuous Integration (CI) usage to automatically
re-deploy a proven correct build to a QA or UAT environment. If the bounce time for a deployment is quick enough,
then it could be that you're doing that for every commit that lands in the trunk. The Radiator's pipeline view would 
become:

![](/images/pipelines2.png)

The [best selling book of the same name](/publications/#continuous-delivery-july-27-2010) by Jez Humble and Dave Farley, for many companies. details the 'marching orders' 
for a whole dev-team improvement agenda.

## Continuous Deployment

As Continuous Delivery, but the deployment is to production. Certain types of startups like NetFlix, Etsy and Github
deploy their major application to production with each commit. Companies that have applications/services where 
clients/customers could lose money, are much less likely to *firehose into production*.
