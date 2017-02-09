---
date: 2016-05-06T19:56:50+01:00
title: Release from trunk
weight: 56
---

Teams with a very high release cadence do not need (and cannot use) release branches at all. They have to release from
the trunk.

![](/images/release_from_trunk.png)

It is most likely that such teams do not use a Dewey-decimal release numbering scheme, and instead have something
referent to the commit number or date and time.  They probably also choose to roll forward and fix the bug on the
trunk as if it were a feature, albeit as quickly as possible.

Here's what stylized commits look like:

![](/images/release_from_trunk2.png)

No slow down around a release, and bug fixes inline.

Teams with one release a day (or less) **might** still make a branch, to cherry-pick the bug-fix to
and release from:

![](/images/release_from_trunk3.png)

{{< note title="Branches can be made retroactively" >}}
Newbies to source-control systems often forget that you don't have to make a branch because you think you might need
it in the future. For any source-control technology made today, you can choose the revision in the past to branch
from. The outcome is exactly the same as if you had made it at the time.
{{< /note >}}
