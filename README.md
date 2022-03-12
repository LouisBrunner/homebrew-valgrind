# homebrew-valgrind
Homebrew Tap for Valgrind macOS. 

**Note that macOS 11+ and the M1 chip are currently not supported!**

## Installation

First, tap this repository:
```
brew tap LouisBrunner/valgrind
```

Then, install `valgrind`:
```
brew install --HEAD LouisBrunner/valgrind/valgrind
```

You can now use `valgrind` as normal.

## Update

Any `brew upgrade` will now correctly rebuild the latest `LouisBrunner/valgrind` instead of the upstream one (which doesn't support latest macOS versions).

```
brew upgrade --fetch-HEAD LouisBrunner/valgrind/valgrind
```
