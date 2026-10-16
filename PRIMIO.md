# JeepPrint

## Overview
Jeep owners pick model and year and see parts that commonly break, ranked by owner reports, with stronger 3D-printable replacements and a downloadable STL for print shops.

## Built vs Coming Soon
- Built: model/year cross-reference, ranked problem parts, part detail with owner comments, dealer vs print price, STL download
- Paywall: free preview (part summary, price compare, why it breaks, fitment, first comment); remaining comments and STL download need the one-time premium_unlimited purchase. Purchases work on Android/iOS builds only; web preview shows a "available in the app" message
- Coming soon (open /soon): 3MF export, Print Shop Finder, Share a Failure, My Garage
- Needs a backend later: user-submitted reports and accounts (data is a local curated catalog)

## Tech Stack & Key Decisions
- share_plus for downloads: native share sheet on mobile, browser file download fallback on web
- STL is generated in-app (services/stl_builder.dart) as an L-bracket blank sized to each part's envelope; real community geometry should replace it
- 3MF needs a zip writer (no archive package), so it is deferred rather than faked
- Single app-global GarageProvider: selection must persist between garage and detail screens
- in_app_purchase with one non-consumable (models/premium_catalog.dart); price comes only from the store. Unlock is cached in shared_preferences and refreshed at launch; Android revokes if the store no longer lists it, iOS keeps the cache. No server receipt verification (needs a backend)
- PremiumProvider is app-global because the unlock gates screens everywhere

## Architecture
- UI → GarageProvider → PartsService → PartsRepository (static catalog) / ExportRepository (share_plus)
- ExportResult lives in models so providers don't import repositories
- Export failures are stored in provider state and shown inline in the download panel

## Conventions
- Routes in router/app_router.dart; coming-soon receives title/desc via query params
- Part images in assets/images/part_*.jpg, one per part

## Key Patterns & Gotchas
- Year dropdown is keyed by model+year so initialValue resets when the model changes

## Design System
- Rugged dark "trail" look: deep olive-black surfaces, amber primary, sage secondary
- Barlow Condensed for headings (automotive feel), Inter for body readability
