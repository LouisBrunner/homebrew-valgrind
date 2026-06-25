# homebrew-valgrind

Homebrew Tap for Valgrind macOS

## Installation

First, tap this repository:

```bash
brew tap LouisBrunner/valgrind
```

Then, install `valgrind`:

```bash
brew install --HEAD LouisBrunner/valgrind/valgrind
```

You can now use `valgrind` as normal.

## Update

Any `brew upgrade` will now correctly rebuild the latest `LouisBrunner/valgrind` instead of the upstream one (which doesn't support latest macOS versions).

```bash
brew upgrade --fetch-HEAD LouisBrunner/valgrind/valgrind
```
