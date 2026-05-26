# SFTest — Salesforce Apex Modernization

A Salesforce DX project containing refactored Apex classes, Lightning Web Components, flows, and metadata for the SFTest modernization initiative.

---

## Purpose

This repository holds the source-format metadata for a Salesforce org that was modernized to:

- Eliminate known SOQL-injection and CRUD/FLS security vulnerabilities
- Enforce governor-limit-safe bulk patterns across all Apex handlers
- Standardize all Apex classes and metadata to API version 65.0
- Consolidate duplicate flows and remove obsolete artefacts
- Establish a shared `SecurityUtil` enforcement layer and `TestDataFactory` for all test classes

---

## Setup

### Prerequisites

- Salesforce CLI (`sf`) — version 2.x or later
- Java 11+ (for PMD static analysis)
- Node.js 18+ (for LWC Jest tests)

### Scratch Org Quickstart

```bash
# Authenticate to your Dev Hub
sf org login web --set-default-dev-hub

# Create a scratch org
sf org create scratch --definition-file config/project-scratch-def.json --alias sftest-dev --duration-days 30

# Push source
sf project deploy start

# Run all tests
sf apex run test --test-level RunLocalTests --code-coverage --result-format human
```

---

## Architecture

The codebase follows a layered architecture:

```
Triggers → TriggerHandler (base) → Service classes → SecurityUtil (CRUD/FLS)
                                 → Repository/query layer
```

**Key classes:**

| Class | Purpose |
|---|---|
| `SecurityUtil` | Centralised CRUD/FLS enforcement. All service and handler classes call this before DML/SOQL. |
| `SecurityException` | Custom exception thrown by SecurityUtil when access is denied. |
| `TriggerHandler` | Abstract base for all trigger handlers. Provides recursion guard and context dispatch. |
| `AccountHandler1` | Trigger handler for Account. Extends TriggerHandler. |
| `ContactDataService` | Secure replacement for InsecureContactService. Parameterised SOQL, full SecurityUtil integration. |
| `ContactPerformanceHandler` | Bulk-safe Contact processor. Single SOQL + single DML per invocation. |
| `CommunitiesLoginController` | Community login page controller with open-redirect prevention. |
| `CommunitiesLandingController` | Community landing page controller. |
| `ChangePasswordController` | Password change controller with input validation and error handling. |
| `TestDataFactory` | Shared @IsTest factory for Account, Contact, Project_Task__c, and User records. |

---

## Deployment

```bash
# Validate only (no deploy)
sf project deploy validate --source-dir src

# Deploy to sandbox
sf project deploy start --source-dir src --target-org <sandbox-alias>

# Deploy to production (requires passing tests)
sf project deploy start --source-dir src --target-org <prod-alias> --test-level RunLocalTests
```

---

## Testing

```bash
# Run all local tests with coverage
sf apex run test --test-level RunLocalTests --code-coverage --result-format human

# Run specific test class
sf apex run test --class-names SecurityUtilTest --code-coverage

# PMD static analysis
sf scanner run --target src/classes --ruleset ruleset/apex-ruleset.xml --format table
```

**Coverage targets:**
- `SecurityUtil.cls` ≥ 95%
- `ContactDataService.cls`, `AccountHandler1.cls`, `ContactPerformanceHandler.cls`, `CommunitiesLoginController.cls`, `CommunitiesLandingController.cls`, `ChangePasswordController.cls` ≥ 90%
- Org-wide ≥ 85%

---

## ADR Links

Architecture Decision Records are in the `docs/adr/` directory:

- [ADR-001: SecurityUtil as Centralised CRUD/FLS Layer](docs/adr/ADR-001-security-util.md)
- [ADR-002: TriggerHandler Base Class Pattern](docs/adr/ADR-002-trigger-handler.md)
- [ADR-003: ContactDataService Rename and Refactor](docs/adr/ADR-003-contact-data-service.md)
- [ADR-004: API Version 65.0 Standardization](docs/adr/ADR-004-api-version.md)
