# Smart Hotel Ordering & Queue Management System — Architecture & Roadmap

---

## 1. Project Roadmap (High-Level)

```
PHASE 0  Architecture + requirements          ← you are here
PHASE 1  GitHub + repo + project scaffolding
PHASE 2  Flutter foundation + design system
PHASE 3  QR scanner + table session
PHASE 4  Hotel + menu (Flutter, mock data)
PHASE 5  Cart
PHASE 6  Bill preview
PHASE 7  Backend foundation (Express skeleton)
PHASE 8  Database + REST APIs
PHASE 9  Connect Flutter ↔ backend (replace mocks)
PHASE 10 Create order end-to-end
PHASE 11 Kitchen dashboard (React)
PHASE 12 Real-time Socket.io
PHASE 13 Order tracking (customer side, live)
PHASE 14 Owner dashboard (React)
PHASE 15 Authentication + role-based access
PHASE 16 Payments (Razorpay)
PHASE 17 Push notifications (FCM)
PHASE 18 Queue / waitlist
PHASE 19 Ratings
PHASE 20 Offline support (kitchen dashboard)
PHASE 21 Testing
PHASE 22 Security hardening
PHASE 23 CI/CD
PHASE 24 Production deployment
```

We build in that order because each phase depends on something the previous one produced (e.g., you can't do real-time order tracking before orders exist in a database, and you can't test payments before orders exist at all). Skipping ahead usually means re-doing work later.

---

## 2. System Architecture (Overview)

```
                          ┌─────────────────────┐
                          │   MongoDB Atlas      │
                          │ (hotels, menu,       │
                          │  orders, users, ...) │
                          └──────────▲───────────┘
                                     │
                          ┌──────────┴───────────┐
                          │   Node.js / Express   │
                          │   REST API + Socket.io│
                          │   (single backend)    │
                          └───┬─────────┬─────────┘
                 REST + WS    │         │   REST + WS
              ┌───────────────┘         └───────────────┐
              │                                          │
   ┌──────────▼──────────┐                   ┌───────────▼───────────┐
   │  Flutter Customer App │                   │  React Dashboards      │
   │  (Android, per table) │                   │  - Kitchen (tablet)    │
   │  - Scans QR            │                   │  - Owner/Manager (web) │
   └─────────────────────┘                   └────────────────────────┘
```

One backend serves three clients: the customer mobile app, the kitchen dashboard, and the owner dashboard. All real-time updates (new order → kitchen, status change → customer) flow through Socket.io rooms scoped per hotel/table, backed by MongoDB as the source of truth.

**Why one backend, not three?** A single API means one source of truth for order state, one auth system, and no data-sync problems between services. Splitting into microservices now would add operational complexity with no benefit at this scale — that's a "future features" item if the system needs to scale to hundreds of hotels.

---

## 3. Technology Stack

| Layer | Choice | Why |
|---|---|---|
| Mobile app | Flutter + Dart | Single codebase, Android-first now, iOS later free |
| Mobile state mgmt | **Riverpod** | Compile-safe DI, testable, no `BuildContext` needed for logic, scales better than `Provider` as feature count grows (see §9) |
| Mobile networking | Dio | Interceptors, cancellation, easier error handling than raw `http` |
| Backend | Node.js + Express | Matches MERN requirement, huge ecosystem, easy Socket.io integration |
| Database | MongoDB + Mongoose | Flexible schema fits menu customizations/add-ons well; document model matches "order with embedded items" naturally |
| Real-time | Socket.io | Battle-tested, room-based broadcasting fits per-hotel/per-table scoping |
| Dashboards | React + Vite | Fast dev loop, matches MERN, good for touch (kitchen) and data-dense (owner) UIs |
| Auth | JWT + bcrypt | Stateless, works cleanly across 3 client types |
| Payments | Razorpay | UPI-first, India-focused, standard for this use case |
| Push notifications | Firebase Cloud Messaging | Cross-platform, integrates with Flutter easily |
| Hosting (later) | Render/Railway (API), MongoDB Atlas (DB), Vercel/Netlify (dashboards), Codemagic (Flutter CI/CD) | Low-ops, good free tiers for MVP stage |

---

## 4. Repository Strategy

**Monorepo.** One GitHub repository containing mobile app, backend, and both dashboards.

Why monorepo over separate repos:
- All three clients depend on the same API contract — a monorepo lets you change an endpoint and its consumers in one PR/commit, instead of coordinating versions across repos.
- Simpler for a solo/small-team project: one clone, one issue tracker, one place to see project history.
- Shared docs (`/docs`) stay next to the code they describe.
- Downside (acceptable at this stage): CI pipelines need path filters so a Flutter change doesn't trigger a React build. We'll set that up in Phase 23.

If the team grows significantly or dashboards need fully independent release cycles, splitting later is straightforward — a monorepo doesn't lock you in.

---

## 5. Repository Folder Structure

```
smart-hotel-ordering-system/
│
├── mobile/
│   └── customer_app/              # Flutter project
│
├── backend/                       # Node/Express/Socket.io API
│
├── dashboards/
│   ├── kitchen_dashboard/         # React + Vite
│   └── owner_dashboard/           # React + Vite
│
├── docs/
│   ├── architecture.md
│   ├── api-spec.md
│   └── database-schema.md
│
├── scripts/                       # setup/dev helper scripts
│
├── .gitignore
├── README.md
└── LICENSE
```

### 5.1 Flutter (`mobile/customer_app/lib/`)

```
lib/
├── main.dart
├── app/
│   ├── app.dart
│   ├── routes/
│   ├── theme/                     # design system (Part 6)
│   └── config/                    # env, flavors
├── core/
│   ├── constants/
│   ├── errors/
│   ├── exceptions/
│   ├── network/                   # Dio client, interceptors
│   ├── storage/                   # secure local storage
│   ├── utils/
│   └── services/
├── features/
│   ├── authentication/
│   │   ├── data/{datasources,models,repositories}
│   │   ├── domain/{entities,repositories,usecases}
│   │   └── presentation/{controllers,pages,widgets}
│   ├── qr_scanner/
│   ├── hotel/
│   ├── menu/
│   ├── cart/
│   ├── order/
│   ├── payment/
│   ├── profile/
│   ├── table_session/
│   ├── queue/
│   ├── ratings/
│   └── notifications/
└── shared/
    ├── widgets/
    ├── models/
    └── extensions/
```

Each feature follows the same three-layer split (`data` / `domain` / `presentation`) so once you've learned the pattern in `authentication`, every other feature looks familiar. `core/` holds cross-feature infrastructure; `shared/` holds cross-feature UI/model pieces.

### 5.2 Backend (`backend/`)

```
backend/
├── src/
│   ├── config/          # db connection, env loading
│   ├── controllers/     # HTTP request/response only
│   ├── middleware/       # auth, error handler, validation
│   ├── models/           # Mongoose schemas
│   ├── routes/
│   ├── services/         # business logic
│   ├── repositories/     # DB queries, isolated from services
│   ├── validators/
│   ├── sockets/          # Socket.io event handlers/rooms
│   ├── utils/
│   ├── constants/
│   ├── app.js
│   └── server.js
├── tests/
├── .env / .env.example
├── package.json
└── README.md
```

Request flow: `route → controller → service → repository → model`. Controllers never talk to Mongoose directly — that keeps business logic testable without spinning up Express, and keeps DB query shape changes from leaking into controllers.

### 5.3 Kitchen Dashboard (`dashboards/kitchen_dashboard/src/`)

```
src/
├── components/
├── pages/
├── layouts/
├── services/       # API + socket clients
├── hooks/
├── context/
├── utils/
├── constants/
└── App.jsx
```

### 5.4 Owner Dashboard (`dashboards/owner_dashboard/src/`)

Same shape as the kitchen dashboard — consistency between the two React apps means shared conventions (and eventually shared components, if it makes sense).

---

## 6. Database Architecture

MongoDB, one database, these collections:

| Collection | Purpose |
|---|---|
| `hotels` | Hotel profile, settings, GST/service charge config |
| `tables` | Table number, QR payload, current session status |
| `categories` | Menu categories per hotel |
| `menu_items` | Dishes: name, price, veg/non-veg, add-ons, availability |
| `users` | Customers + staff (role field distinguishes them) |
| `staff` | Extended staff profile linked to `users` (role, hotel) |
| `orders` | Table session's order(s), **embedded** item array |
| `payments` | Payment records linked to orders |
| `queue_slots` | Waitlist entries when tables are full |
| `ratings` | Food/service ratings linked to orders |

**Why embed order items instead of a separate `order_items` collection?** Items always load and update together with their parent order, and MongoDB documents are read/written atomically — embedding avoids extra round-trips and join-like queries for the single most frequent operation in the system (reading/updating an active order). We'll only pull something into its own collection when it's queried independently at scale (e.g., analytics might later read from a denormalized `order_items` view — that's a future optimization, not a Phase 8 concern).

Example shape (illustrative, full schema + indexes come in Phase 8):

```
orders {
  hotel_id, table_id, user_id,
  items: [{ menu_item_id, name, quantity, price, customizations, status }],
  status,            // placed → accepted → preparing → ready → served
  total_amount,
  payment_status,
  created_at, updated_at
}
```

Each collection's schema, validation rules, indexes, and relationships will be explained individually before we write the Mongoose models in Phase 8 — not dumped all at once.

---

## 7. API Architecture

RESTful, versioned implicitly via `/api/...` for now (explicit `/api/v1/` can be added if we ever need to break compatibility). Grouped by domain:

```
Auth
  POST   /api/auth/register
  POST   /api/auth/login

Hotel & Menu
  GET    /api/hotels/:hotelId
  GET    /api/hotels/:hotelId/menu
  GET    /api/categories
  GET    /api/menu-items

Orders
  POST   /api/orders
  GET    /api/orders/:id
  PATCH  /api/orders/:id/status
  POST   /api/orders/:id/items
  POST   /api/orders/:id/request-bill

Payments
  POST   /api/payments/create
  POST   /api/payments/webhook

Ratings
  POST   /api/ratings

Queue
  GET    /api/queue
  POST   /api/queue/book
```

Plus dashboard-specific endpoints (hotel/table/staff/menu management for the owner dashboard, order-queue endpoints for kitchen) defined in full in Phase 8/11/14. Every endpoint will ship with request body, response body, status codes, and auth/role requirements documented in `docs/api-spec.md` before we implement it — not after.

---

## 8. Authentication Architecture

- JWT-based, stateless.
- `bcrypt` for password hashing.
- Roles: `customer`, `cook`, `waiter`, `manager`, `owner`.
- Role-based middleware on protected routes — a `cook` token cannot hit owner-only endpoints, a `customer` token cannot hit kitchen endpoints.
- Customers scanning a QR code get a lightweight **table session** rather than full account registration (frictionless ordering is the priority) — optional account/login can layer on top for order history, saved ratings, etc.
- Refresh tokens: evaluated in Phase 15 once we see how long table sessions realistically last; may not be necessary for short-lived customer sessions, but staff logins (long shifts) will likely want them.

---

## 9. State Management Architecture (Flutter)

**Choice: Riverpod.**

Why Riverpod over Provider:
- Riverpod doesn't require `BuildContext` to read state, which makes services/repositories/controllers easier to unit test in isolation — important since you're learning clean architecture patterns here.
- Compile-time safety: typos in provider names fail at compile time, not runtime.
- Scales more predictably as the app grows past a handful of features (we have 11 features planned) — dependency graphs between providers are explicit.
- `provider` package is fine for smaller apps, but Riverpod is its spiritual successor built to fix exactly the pain points that show up once an app has this many screens/features.

We'll use one state-management approach consistently across every feature — no mixing `setState`-heavy widgets with Riverpod controllers in the same feature.

---

## 10. Environment Configuration Strategy

Three environments: **development, staging, production** — each with its own API base URL, app name, and (later) Firebase config/app ID, so a build for one environment can never accidentally talk to another's data.

```
.env.development   → http://localhost:5000/api
.env.staging        → https://staging-api.example.com/api
.env.production      → https://api.example.com/api
```

- Flutter: build flavors (`dev`/`staging`/`prod`) select the right `.env` file and app icon/name at build time — no runtime `if` statements guessing the environment.
- Backend: `.env` (gitignored) + `.env.example` (committed, no real values) so the required variables are documented without leaking secrets.
- Secrets (API keys, Razorpay keys, JWT secret) never live in source code — they're injected via environment variables locally and via CI/CD secret stores (GitHub Actions secrets / Codemagic environment groups) later.

---

## 11. Git / GitHub Workflow

Branches:

```
main                 # production-ready only
develop              # integration branch
feature/*            # e.g. feature/flutter-qr-scanner
bugfix/*
hotfix/*
```

Commit convention (Conventional Commits):

```
feat: add QR scanner screen
fix: handle invalid table QR
refactor: centralize API client
docs: update setup instructions
```

Flow: branch off `develop` → PR back into `develop` → periodically merge `develop` → `main` for releases. `hotfix/*` branches off `main` directly for urgent production fixes.

---

## 12. MVP Definition

The smallest version that's a genuinely usable product end-to-end:

**Customer app:** QR scan → view menu → add to cart → place order → track status (placed/accepted/preparing/ready/served) → request bill → pay at counter (cash) — **no online payment yet**.

**Kitchen dashboard:** Login → live order queue → accept order → mark items ready.

**Owner dashboard:** Hotel setup → table + QR management → menu management → live order monitoring.

**Deliberately excluded from MVP:** Razorpay/UPI payment, push notifications, queue/waitlist, ratings, offline sync, multilingual UI, analytics/reports. These are all real, planned features (Phases 16–20) — just not required to prove the core loop works.

This maps to Phases 0–15 roughly; Phases 16 onward are post-MVP.

---

## 13. Future Features (Post-MVP, Post-Phase-24)

- Multi-hotel chains / multi-branch owner accounts
- iOS release
- Loyalty points / repeat-customer discounts
- Inventory management tied to "out of stock" marking
- Advanced analytics (peak hours, best-selling items, table turnover time)
- SMS/WhatsApp order confirmations
- Split billing per customer at a table
- Voice-based ordering assistant

---

## Progress Tracker

**Completed:** Architecture, roadmap, folder structures, DB/API/auth/state-mgmt decisions.
**Next:** Phase 1 — GitHub repo + project scaffolding (awaiting your go-ahead).

**Known open decisions (will confirm before Phase 8):** exact Mongoose index strategy for `orders`/`menu_items`; whether refresh tokens are needed for staff sessions.
