# flutter_mcp_ui_generator

JSON generation toolkit for the Flutter MCP UI runtime. Programmatically create UI definitions with templates, helpers, and a fluent API. Implements the **MCP UI DSL 1.4** specification.

## Features

- **Widget builders** — one static builder per spec widget: **158**, generated from the widget registry so a gap between spec and generator is a build error rather than silent drift.
- **Identity actions** — `identityPromoteAction` / `identityReleaseAction` (spec §8.9.3), and `origin(connectionId)` for naming the origin that serves a definition (§1.9).
- **Material 3 theme helpers** — `themeDefinition`, `themeColors` (28-role + 6 semantic + seed + state layer), `themeTypography` (15-role), `themeSpacing` (9-step 8pt grid + layout aliases), `themeShape` (7-family), `themeElevation` (6-level with shadow + tint).
- **Binding helpers** — `themeColor`, `themeShapeValue`, `themeElevationValue`, plus state and bundle binding helpers.
- **Pre-built patterns** — forms, dashboards, lists.
- **Light/dark mode** support out of the box.

## Quick Start

```dart
import 'package:flutter_mcp_ui_generator/flutter_mcp_ui_generator.dart';

final home = MCPUIJsonGenerator.page(
  title: 'Home',
  content: MCPUIJsonGenerator.linear(
    direction: 'vertical',
    children: [
      MCPUIJsonGenerator.text('Hello'),
      MCPUIJsonGenerator.button(
        label: 'Click',
        click: MCPUIJsonGenerator.toolAction('greet'),
      ),
    ],
  ),
);

final app = MCPUIJsonGenerator.application(
  title: 'My App',
  version: '1.0.0',
  routes: {'/': 'ui://pages/home'},
  theme: MCPUIJsonGenerator.themeDefinition(
    color: MCPUIJsonGenerator.themeColors(seed: '#3F51B5'),
    typography: MCPUIJsonGenerator.themeTypography(),
    spacing: MCPUIJsonGenerator.themeSpacing(),
  ).toJson(),
);
```

## Support

- [Issue Tracker](https://github.com/app-appplayer/flutter_mcp_ui_generator/issues)
- [Discussions](https://github.com/app-appplayer/flutter_mcp_ui_generator/discussions)

## License

MIT — see [LICENSE](LICENSE).
