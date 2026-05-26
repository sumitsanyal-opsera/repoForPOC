# ADR-001: SecurityUtil as Centralised CRUD/FLS Enforcement Layer

**Status:** Accepted  
**Date:** 2026-05-25  
**Deciders:** SFTest Modernization Team

---

## Context

Multiple Apex classes performed DML and SOQL without checking whether the running user had Create, Read, Update, Delete (CRUD) or field-level security (FLS) access. This violated Salesforce security best practices and created potential data-exposure and data-corruption risks.

## Decision

Introduce a single `SecurityUtil` class (`with sharing`) that centralises all CRUD/FLS checks:

- `checkObjectAccess(SObjectType, String operation)` — throws `SecurityException` if the user lacks the required object permission.
- `checkFieldAccess(SObjectField, String operation)` — throws `SecurityException` if the user lacks field access.
- `stripInaccessible(AccessType, List<SObject>)` — strips fields the user cannot read before they are returned to callers.

All service classes and trigger handlers must call `SecurityUtil` before any SOQL or DML.

## Consequences

- Positive: single point of enforcement; easy to audit; consistent error type (`SecurityException`).
- Positive: `stripInaccessible` ensures no FLS bypass on query results.
- Negative: slight performance overhead for describe calls (mitigated by platform caching).
