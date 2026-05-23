
## [0.4.1] - 2026-05-23 — common widget property fanout (spec 1.3.4) + mcp_bundle 0.4.0 cascade

### Changed (cascade)
- `mcp_bundle` caret bumped from `^0.3.0` to `^0.4.0`. The downstream `UiSection.pages` field switched to `Map<String, PageDefinition>`. `BundleUiWriteAdapter` now hands the in-memory `List<PageDefinition>` it builds to the new `UiSection.fromPagesList` factory, so existing caller code stays unchanged.
- `flutter_mcp_ui_core` caret bumped to `^0.4.1` (mcp_bundle cascade).

### Added
- Every `MCPUIWidgetBuilders.<widget>` static builder gains optional `click` and `tooltip` typed parameters (spec 1.3.4 §2.2). Sourced from `specs/mcp_ui_dsl/spec/1.3/widgets/_common.yaml` and merged by the generator codegen into every widget's parameter set; a widget-declared same-named property still wins. Bundles that omit `click` / `tooltip` are unaffected — additive.

## [0.4.0] - 2026-05-03 - Spec ↔ implementation alignment (1.3.3)

- `MCPUIWidgetBuilders` (`widget_builders.g.dart`) — generated 1:1 from yaml so every spec widget has a builder.
- Action helpers added — `parallelAction` / `sequenceAction` / `cancelAction` / `notificationAction` / `animationAction` / `dialogAction` / `permissionRevokeAction` / `clientClipboard` / `clientNotification` / `clientStorage*`.
- `ApplicationBuilder.i18n / .services / .templateLibraries` fluent setters; `publisher.url` → `website`.
- Channel helpers wrap type-specific fields in `params:`; `channelAction` emits canonical `{type: "channel", action: "channel.<sub>"}`; new `websocketChannel`.
- New code generators: `CCodeGenerator` (single-include `.h` returning escaped JSON `const char*`), `CppCodeGenerator` (single-include `.hpp` with C++11 raw-string `inline std::string` + namespace option).
- Bumps `flutter_mcp_ui_core` to `^0.4.0`.

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