# Naming Conventions — SFTest Salesforce Project

## Apex Classes

| Pattern | Example | Notes |
|---|---|---|
| `PascalCase` | `ContactDataService` | All classes, interfaces, enums |
| `*Handler` suffix | `AccountHandler1` | Trigger handler classes (extend TriggerHandler) |
| `*Service` suffix | `ContactDataService` | Service/business-logic classes |
| `*Util` suffix | `SecurityUtil` | Utility/helper classes |
| `*Test` suffix | `SecurityUtilTest` | All `@IsTest` classes |
| `*Exception` suffix | `SecurityException` | Custom exception classes |
| `*Factory` suffix | `TestDataFactory` | Test data builder classes |

## Apex Methods

- `camelCase` for all method names: `checkObjectAccess`, `getContactsByLastName`
- `@TestVisible` helper methods prefixed with their purpose: `sanitiseStartUrl`, `sanitiseDisplayType`

## Apex Variables

- `camelCase` for local variables and parameters
- `UPPER_SNAKE_CASE` for static final constants: `MIN_PASSWORD_LENGTH`, `ALLOWED_DISPLAY_TYPES`
- Instance variables use `camelCase` with no prefix

## Salesforce Objects and Fields

- Custom objects: `PascalCase__c` — `Project_Task__c`, `Candidate__c`
- Custom fields: `PascalCase__c` — `DueDate__c`, `Status__c`
- No `Dummy`, `Test`, or placeholder names in production metadata

## Branches

| Pattern | Purpose |
|---|---|
| `main` | Production-ready baseline |
| `wo/WO-XXX` | Single work order feature branch |
| `fix/XXX` | Hotfix branch |

## Commits

Format: `[WO-XXX] <type>: <short description>`

Types: `feat`, `fix`, `refactor`, `chore`, `docs`, `test`, `security`

Example: `[WO-007] feat: implement SecurityUtil with CRUD/FLS enforcement`

## Flows

- Descriptive names in `Snake_Case`: `New_Lead`, `Account_Support_Request_Path`
- No `Test_Flow`, `New_Lead_1`, `New_Lead-2` style duplicates
- All flows at API 65.0

## LWC Components

- `camelCase` directory and file names: `pocTestComponent`
- All reactive properties use implicit reactivity (no `@track`)
- `js-meta.xml` must include `masterLabel` and `description`
