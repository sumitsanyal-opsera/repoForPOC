# ADR-003: InsecureContactService Renamed to ContactDataService

**Status:** Accepted  
**Date:** 2026-05-25  
**Deciders:** SFTest Modernization Team

---

## Context

`InsecureContactService` used dynamic SOQL with string concatenation, creating SOQL injection vulnerabilities. The class name itself advertised the insecurity.

## Decision

Replace `InsecureContactService` with `ContactDataService`:

- All dynamic SOQL replaced with bind-variable queries.
- `SecurityUtil.checkObjectAccess` called before every query and DML operation.
- `SecurityUtil.stripInaccessible` applied to all query results.
- The old class is retained in source control history but not deployed.

## Consequences

- Positive: SOQL injection eliminated; CRUD/FLS enforced.
- Positive: name reflects the class's purpose rather than its former deficiency.
- Negative: any callers of `InsecureContactService` must be updated to use `ContactDataService`.
