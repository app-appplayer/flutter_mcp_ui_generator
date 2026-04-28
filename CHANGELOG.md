
## [0.3.0] - 2026-04-28 - MCP UI DSL 1.3 (Material 3 Helpers)

### Changed (breaking)
- **`themeDefinition(...)`** new helper produces a strongly-typed `core.ThemeDefinition` covering all 14 token domains. Replaces legacy `themeConfig(...)` 5-section helper.
- **`themeColors(...)`** rewritten for M3 28-role + 6 semantic + `seed` + `stateLayer`. Seed-only calls let the runtime derive the rest via HCT.
- **`themeTypography(...)`** rewritten for M3 15-role with canonical type-scale defaults.
- **`themeSpacing(...)`** rewritten for the 9-step 8pt grid plus optional layout aliases. Larger-step keys now follow `2xl / 3xl / 4xl`.
- **`themeElevation(...)`** rewritten for M3 6-level with `{shadow, tint}` records.
- Binding helpers now resolve to the new theme paths (`theme.color.<slot>`, `theme.shape.<family>`, `theme.elevation.<level>.shadow`).
- License changed from Apache-2.0 to MIT.

### Added
- **`themeShape(...)`** — new M3 7-family helper.
- New dependency: `mcp_bundle ^0.3.0`.

### Removed
- `themeBorderRadiusValue` binding helper.

## 0.2.4

* Bug fixes

## 0.2.3

* Bug fixes

## 0.2.2

## 0.2.1

### Bug Fixes
- Fixed app generator to use pub.dev packages instead of git URLs
- Added configurable runtime version support

## 0.2.0

### Refactoring
- Major internal refactoring for improved maintainability
- Enhanced code organization and structure
- Improved type safety and validation
- Better separation of concerns

## 0.1.0

### Initial Release

- JSON generation toolkit for creating UI definitions
- Widget templates for all 77+ supported widgets
- Fluent Builder API for programmatic UI construction
- Pre-built UI patterns (forms, dashboards, lists)
- Complete theme system with light/dark mode support
- Theme binding expressions
- Application configuration generator
- Type-safe widget property generation
- Support for all widget categories
- JSON export with formatting
- Based on MCP UI DSL v1.0 specification