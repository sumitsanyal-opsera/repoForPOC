# ADR-004: Standardise All Apex Metadata to API Version 65.0

**Status:** Accepted  
**Date:** 2026-05-25  
**Deciders:** SFTest Modernization Team

---

## Context

Apex classes and LWC components spanned API versions 49.0 to 65.0. Older versions miss five years of platform improvements (e.g., improved SOQL security, `Security.stripInaccessible` GA, LWC reactivity model changes).

## Decision

All `.cls-meta.xml` and `.js-meta.xml` files must specify `<apiVersion>65.0</apiVersion>`. The `sfdx-project.json` `sourceApiVersion` is set to `65.0` to enforce this for future source push/pull operations.

## Consequences

- Positive: consistent behavior across all classes; access to latest platform APIs.
- Positive: `sf scanner` and PMD report accurate results against a single API baseline.
- Negative: any API-version-specific behavior differences must be tested before production deployment.
