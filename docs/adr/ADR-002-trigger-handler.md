# ADR-002: Abstract TriggerHandler Base Class Pattern

**Status:** Accepted  
**Date:** 2026-05-25  
**Deciders:** SFTest Modernization Team

---

## Context

Trigger logic was embedded directly in handler classes without a recursion guard or a standard dispatch mechanism. This led to infinite-loop risks and inconsistent patterns across objects.

## Decision

Introduce `TriggerHandler` as an abstract `with sharing` base class. It provides:

- A static `Set<String>` recursion guard (`currentlyExecuting`) keyed on handler class name.
- A `run()` method that reads `Trigger.*` context booleans and dispatches to overridable `beforeInsert()`, `afterInsert()`, etc. methods.
- Default no-op implementations for all six context methods so subclasses only override what they need.

All trigger handler classes must extend `TriggerHandler` and call `new MyHandler().run()` from their `.trigger` file.

## Consequences

- Positive: recursion guard prevents re-entrant trigger execution.
- Positive: consistent handler structure across all objects.
- Negative: minor indirection; stack traces include `TriggerHandler.run()`.
