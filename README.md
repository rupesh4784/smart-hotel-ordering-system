# Smart Hotel Ordering & Queue Management System

A table-side restaurant ordering system: customers scan a table QR code, browse the menu, order, track kitchen status, and pay — no delivery, no driver, just table service digitized.

## Structure (monorepo)

```
mobile/customer_app/       Flutter app (Android first) — customer ordering flow
backend/                   Node.js + Express + MongoDB + Socket.io API
dashboards/kitchen_dashboard/   React (Vite) — kitchen order queue, touch-first
dashboards/owner_dashboard/     React (Vite) — hotel/menu/staff/analytics management
docs/                       Architecture, API spec, DB schema docs
scripts/                    Dev/setup helper scripts
```

## Status

🚧 In active development. See `docs/architecture.md` for the full roadmap and phase plan.

## Branch strategy

- `main` — production-ready code only
- `develop` — integration branch, all features merge here first
- `feature/*`, `bugfix/*`, `hotfix/*` — short-lived work branches

See `docs/git-workflow.md` for the full convention.

## Getting started

Setup instructions per app will be added as each is scaffolded (Phase 2 onward).
