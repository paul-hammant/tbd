---
date: 2026-10-20T09:00:00+01:00
title: Fast, Green Builds
weight: 64
---

Trunk-Based Development depends on a build that is fast and always green, both on the developer's workstation before a
commit/push, and in Continuous Integration after it. This page gathers the techniques for keeping it that way. Most are
mainstream amongst high-throughput teams. Some, like Test Impact Analysis, should be but are not yet.

## Why it matters

Build time drives the number of commits a developer can do in a day (see [Deciding Factors](/deciding-factors/#build-times)).
A build of a couple of minutes keeps a high pace. A build of 30 minutes or more slows a developer to a few commits a day at best.

Build time also decides who wins the "race to push" on a busy trunk. If someone else pushes while your build is running, you
pull, build and try again. The slower the build, the more often you lose that race (see
[Peak commit frequency](/deciding-factors/#peak-commit-frequency)).

And a slow build is one of the key drivers to other branching models, to repository sharding, and to slower release cadences.

## Local and remote

The same build runs in two places:

1. Locally, before the commit/push is the gate. Developers determine for themselves that their change is good,
   on their workstation or on containers/VMs dedicated to them (see [Running the build locally](/observed-habits/#running-the-build-locally)
   and [The Importance of a Local build](/styles/#the-importance-of-a-local-build)).
2. Remotely, in CI, after the push or before it lands in the trunk (for pull requests and merge queues) is the check
   that catches what the local build could not: bad timing, environment differences, and semantic clashes between changes that
   merged cleanly (see [Continuous Integration](/continuous-integration/)). This is sometimes called a gated build.

Neither is a crutch for the other. A team that git-pushes to find out whether its changes are good has handed its quality
control to the CI daemon, and slowed everyone down when it fails, even if that's a massively parallel cloud infrastructure.

## Fast

### Tiered tests

Keep the build fast by being deliberate about what runs where:

* Compile and pure unit tests first: No threads, sockets or file IO. These run in seconds and are where good builds focus
  their development effort.
* Integration tests minimized: Tests that use threads, listen on sockets or do significant file IO should be as few as possible
  without reducing meaningful coverage. The best trick is changing some integration tests into pure unit tests, which isn't always easy.
  * Component tests as a subclass of integration tests: these map to visible/interactive rectangles of user experience that have a 
    meaningful name like `credit_card_form`. Lower tiers will be mocked and higher tiers bypassed by the testing technology.
  * Service tests as another subclass - nothing interactive or visible about these, but eveything about the wire whether synchornous or 
    async. Still with mocking of lower tiers and bypassing of higher tiers bt the testing tech. 
* A smoke tier before the push, the full-stack suite in CI, and longer tiers on a schedule: Non-functional tests (performance, soak,
  security scanning) usually belong in later pipeline phases, not in the build before every commit.

Fast is say one minute, and slow is ten or above (see [Committing straight to the trunk](/committing-straight-to-the-trunk/#challenges)).

### Mocking and service virtualization

A build that talks to shared databases or other teams' services is slow and fragile. Mocking of tiers within the application, and
wire mocking (service virtualization) of dependencies outside the team, make tests fast and stable, and make the build runnable
disconnected from the network. That is the [Shared Nothing](/observed-habits/#shared-nothing) habit, with cli-friendly service 
virtualization & API mocking tools. Some choices below 

#### Mountebank

Multi-protocol, cross-language service virtualization tool capable of capturing network traffic and running non-modal test doubles.

* **Deployment:** Node.js CLI (`mb`), Docker container (`bbyars/mountebank`).
* **Protocols:** HTTP, HTTPS, TCP, SMTP.
* **Best For:** Cross-platform teams needing multi-protocol support and dynamic JavaScript injection for stubs.

```bash
mb --port 2525 --configfile ./imposters.json
```

#### WireMock (Standalone)

Industry standard for HTTP mock services. While Java-based, its standalone runner and Docker image operate headlessly using REST APIs or static JSON files.

* **Deployment:** Executable JAR, Docker container (`wiremock/wiremock`).
* **Protocols:** HTTP, HTTPS, WebSockets, gRPC (via extensions).
* **Best For:** Advanced request matching, stateful scenarios, and response fault injection.

```bash
docker run -d -p 8080:8080 -v $(pwd)/stubs:/home/wiremock wiremock/wiremock
```

#### Mockoon CLI

Lightweight, fast mock engine powered by Node.js. Configuration files can be generated using the Mockoon desktop UI and executed headlessly in pipelines.

* **Deployment:** Node CLI (`@mockoon/cli`), Docker container (`mockoon/cli`).
* **Protocols:** HTTP, HTTPS.
* **Best For:** Simple setup, quick export from developer desktop UI to CI runner.

```bash
mockoon-cli start --data ./environment.json --port 3000
```

#### Hoverfly

High-performance API simulation tool written in Go with zero external runtime dependencies.

* **Deployment:** Single binary (`hoverfly`), Docker container (`spectolabs/hoverfly`).
* **Protocols:** HTTP, HTTPS (supports transparent proxy capture & replay).
* **Best For:** High-throughput CI/CD pipelines, automated proxy capture and replay workflows.

```bash
hoverfly -import ./simulations.json
```

#### Stoplight Prism

An OpenAPI-driven mock server that instantly generates dynamic responses based strictly on API spec contracts.

* **Deployment:** Node CLI (`@stoplight/prism-cli`), Docker container (`stoplight/prism`).
* **Protocols:** HTTP, HTTPS (REST / OpenAPI 2.0 & 3.x).
* **Best For:** Spec-first workflows where mocks must validate against OpenAPI schemas automatically.

```bash
npx @stoplight/prism-cli mock ./api-spec.yaml
```

#### Microcks

Cloud-native API mocking and testing framework built specifically for containers and Kubernetes environments.

* **Deployment:** CLI (`microcks-cli`), Docker Compose, Helm / K8s Operator.
* **Protocols:** REST, GraphQL, gRPC, WebSockets, AsyncAPI (Kafka).
* **Best For:** Complex microservice architectures, asynchronous/event-driven messaging, and Kubernetes native runners.

```bash
microcks-cli test "API Name:1.0" --microcksURL http://localhost:8080
```

#### Mock Service Worker (MSW)

This one is In-process, whereas the others above are standalone (container, process, VM).

MSW provices API mocking library for Node.js and browser environments that intercepts network requests at the application network layer.

- **Deployment:** In-process Node.js module (npm package) or Browser Service Worker.
- **Protocols:** REST (HTTP/HTTPS), GraphQL.
- **Best For:** JavaScript/TypeScript test runners (Vitest, Jest, Playwright) requiring fast, zero-container, in-process mock execution.

```bash
npx msw init public/ --save
```

### Test Impact Analysis

As a codebase grows, so does its test suite, and the local build gets slower. Teams are tempted to skip it, or to delete
tests, and both of those are bad. Test Impact Analysis (TIA) is a better way out:

1. Run the suite with code coverage instrumentation (in CI, typically) and record which production source files each test exercises.
2. Store that as a map.
3. For a given change, look up the tests that touch the changed files, and run only those before the commit/push.
4. The full suite still runs in CI after the commit.

That subset is usually a small fraction of the whole, so the build before the commit/push gets fast again.

**The costs.** Building the map means running the whole suite instrumented, ideally per test, which is slower than a normal run.
Every commit makes the map slightly stale, so most teams would rebuild it nightly or every N commits. It has to be stored, keyed to
commits and fetched. Coverage can also be noisy, with the same test touching slightly different lines from run to run. The staleness
is an acceptable trade-off, though: a stale map mostly misses brand-new tests and newly introduced coupling, and the full CI run
after the commit catches those soon after.

**Where it pays.** Business applications are wide and shallow: hundreds of features, each test exercising a thin slice, and most
changes touching one slice. The map saves a great deal there. Programming-language implementations (compilers, interpreters, VMs)
are narrow and deep: nearly every test goes through the same core, so a change to that core impacts every test. TIA helps little
there, and tiered suites, tagging tests by language feature, and parallelism are the better tools.

**The alternative to a map.** Without one, developers (and coding agents) guess at the impacted tests from the diff: naming
conventions, callers of what changed, module scope. That works fairly well, but misses coupling that the text of the code doesn't
show: reflection, dependency injection wiring, configuration, serialized formats, and anything across a process boundary. A
coverage-derived map catches those because it records what actually ran.

See "The Rise of Test Impact Analysis" on Martin Fowler's site{{< ext url="https://martinfowler.com/articles/rise-test-impact-analysis.html" >}},
and Paul Hammant's "Reducing Test Times by Only Running Impacted Tests"{{< ext url="https://paulhammant.com/2015/01/11/reducing-test-times-by-only-running-impacted-tests/" >}}
and "Coding Agents Guess Which Tests to Run. They Should Look It Up."{{< ext url="https://paulhammant.com/2026/10/20/agents-guess-which-tests-to-run/" >}}

### Directed graph build systems and remote caches

Build systems like Bazel, Buck and Nx know the dependency graph of the whole source tree, so they omit compile and test steps
that are not affected by a change. They also share recently compiled outputs between machines, so nobody compiles what a colleague
(or a CI agent) already compiled. That works equally well on developer workstations and in CI. See
[Directed graph build systems](/monorepos/#directed-graph-build-systems). 

For build systems that are not directed graph ones, Test Impact Analysis (above) achieves a similar omission of unnecessary test steps. Yes, 
these two are are alternatives, but it is clear that the the directed graph way is superior. Google's in-house monorepo using Blaze/Bazel 
is part of their significant historical competitive advantage.

### Parallelism and sharding

When the work cannot be cut down any further, spread it out. CI infrastructure with a controller and many agents (see
[Controller / Agent CI infrastructure](/continuous-integration/#controller--agent-ci-infrastructure)), elastic cloud
capacity, and test suites split into shards that run concurrently, all shorten the wall-clock time of the build. Google
did this for browser tests with their in-house Selenium farm (see [Game Changers](/game-changers/#selenium-farm-2006)).

## Green (passing rather than failing)

### Tests are never green incorrectly

A test failing when the production code is actually good is common. A test passing when the production code is broken is rare,
at least for well-written tests. So a red build that is often red for no real reason teaches people to ignore red builds. Flaky
tests should be fixed or quarantined quickly, so the build is **always green** unless there is a genuine issue (see
[Tests are never green incorrectly](/continuous-integration/#tests-are-never-green-incorrectly)). Once a build is trusted
like that, it is natural to run it as often as you can.

Tests written by coding agents threaten that claim. A test that has never been seen failing proves nothing, and agents often
write the implementation first and the tests after, skip or fake the "red" step, or write tests that check the implementation's
output against itself. Kent Beck keeps agents to test-driven development with explicit instructions, and watches for them
disabling or deleting tests{{< ext url="https://newsletter.kentbeck.com/p/augmented-coding-beyond-the-vibes" >}}. Birgitta
Böckeler found that prescribing TDD inside the agent loop made little measurable difference to quality, and recommends monitoring
outcomes instead{{< ext url="https://martinfowler.com/articles/exploring-gen-ai/tdd-in-the-agent-loop.html" >}}. Whichever way a team
leans, objective checks in CI catch the problem: mutation testing, which shows whether the tests would notice the code being broken,
and checking that each new test fails against the previous commit, which shows it was red before it was green.

### Verifying before the trunk

Better setups verify each change before it lands in the trunk, rather than after:

* **Per-commit CI with a speculative merge**: build the change as if it had already been merged to trunk (see
  [Game Changers](/game-changers/#traviscis-per-commit-speculative-mergeability-analysis-2012)).
* **Merge queues** (or commit queues): serialize changes, and verify each one against what the trunk will actually be when it lands
  (see [Merge queues go mainstream](/game-changers/#merge-queues-go-mainstream-2023)).
* **Automatic revert** as the backstop: if a commit does break the trunk build, revert it quickly, by a build cop or a bot, rather
  than fix forward while everyone waits (see [Build Cop](/observed-habits/#build-cop)).

## With coding agents

Coding agents make every one of these more pressing. Several agents per developer means more commits racing for HEAD, so the
local build has to be faster still to win. Agents run the build far more often than humans did, so a slow build costs more.
And an agent picking which tests to run is guessing from the diff unless a Test Impact Analysis map is there for it to look
up. See [AI coding agents committing straight to the trunk](/committing-straight-to-the-trunk/#ai-coding-agents-committing-straight-to-the-trunk).
