# Git Workflow

## Branches

| Branch | Purpose |
|---|---|
| `main` | Always production-ready. Only merged into via `develop` (releases) or `hotfix/*` (emergencies). |
| `develop` | Integration branch. All feature branches merge here first. |
| `feature/*` | One branch per feature/screen/module. Branches off `develop`. |
| `bugfix/*` | Non-urgent fixes found during development. Branches off `develop`. |
| `hotfix/*` | Urgent production fixes. Branches off `main`, merges into both `main` and `develop`. |

## Rule: always branch before starting new work

Never commit directly to `develop` or `main`. Every phase/feature gets its own branch:

```bash
git checkout develop
git pull origin develop
git checkout -b feature/flutter-project-scaffold
# ... do the work, commit ...
git push -u origin feature/flutter-project-scaffold
# open a PR into develop on GitHub
```

Naming examples:

```
feature/repo-scaffold
feature/flutter-design-system
feature/flutter-qr-scanner
feature/menu-screen
feature/cart
feature/backend-scaffold
feature/order-api
feature/socket-order-status
bugfix/qr-scanner-crash-on-invalid-code
hotfix/payment-webhook-signature-check
```

## Commit convention (Conventional Commits)

```
feat: add QR scanner screen
fix: handle invalid table QR
refactor: centralize API client
docs: update setup instructions
chore: scaffold monorepo folder structure
test: add unit tests for cart repository
```

Format: `<type>: <short, imperative description>`

Types used in this project: `feat`, `fix`, `refactor`, `docs`, `chore`, `test`.

## Merging

- Feature branches merge into `develop` via Pull Request (even solo — keeps a reviewable history).
- `develop` merges into `main` when a set of features is stable enough to call a release.
- Delete feature branches after merge to keep the branch list clean.
