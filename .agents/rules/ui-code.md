---
paths:
  - "Assets/Scripts/UI/**"
---

# UI Code Standards (Unity C#)

- **Read-Only / State Independence**: UI views must NEVER own or directly mutate game state. They subscribe to gameplay state changes and emit player command intents.
- **Localization Ready**: Never hardcode player-facing text strings in C# code. Route all labels through Unity's Localization package or string tables.
- **Navigation Support**: Ensure UI menus support keyboard, gamepad, and mouse navigation cleanly without mouse-only deadlocks.
- **Separate Canvases (UGUI)**: Separate dynamic frequently redrawn elements (e.g. animated health bars) from static HUD elements onto separate Canvases to prevent full-screen canvas rebuilds.
- **Raycast Target Management**: Turn off `Raycast Target` on static images, backgrounds, and decorative text.
