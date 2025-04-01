# Coding guidelines
This document is meant to help me remember my takes on programming and to quickly onboard others on what I consider good coding practices. Everything here is subject to change if good enough arguments are provided.

## Java

### Exceptions vs `assert`
When the `assert` keyword should be used:
- To state something that you know is always true but is not so obvious. This acts as a form of documentation.
- To check something that is supposed to never happen, and if it does it means that there is something very wrong in the code.
- To check invariants in your code

When to use exceptions instead:
- When validating parameters passed to public or protected methods and constructors
- When addressing issues that might occur and that we cannot recover from

Quite often code can be restructured in such a way that we don't need to use asserts or exceptions.