# Changelog

All notable changes to this project will be documented in this file.

This project follows [Semantic Versioning](https://semver.org).

---

## 1.0.0

This release marks the **first stable version** of FontawesomeCdn.
The public API is now considered stable and will follow Semantic Versioning.

### Changed
- Stabilized the `icon` helper API with a fully class-based approach.
- Removed legacy `style:` and `pack:` options in favor of direct Font Awesome classes.
- Default family and style are now applied automatically via configuration.
- The `classic` family is implicit and no longer rendered as `fa-classic`.
- When using the `brands` family, no style class is automatically injected.

### Added
- Added `fa:` option as a convenience shortcut to pass space-separated Font Awesome tokens
  (automatically prefixed with `fa-`).
- Added global configuration options:
  - `default_family`
  - `default_style`
  - `default_aria_hidden`

### Examples
```erb
<%= icon "user" %>
<%= icon "gear", "Settings" %>
<%= icon "bell", class: "fa-regular fa-2x fa-shake" %>
<%= icon "bell", fa: "regular 2x shake" %>
<%= icon "github", "Source code", fa: "brands", class: "link" %>
```

### Notes
- No validation or conflict resolution is applied when multiple styles or families are provided.
- Users are free to combine classes as needed for experimentation or advanced use cases.
- Versions prior to `1.0.0` should be considered experimental.

---

## 0.3.0

### Changed
- Renamed the `fontawesome_cdn_stylesheet_tag` helper to `include_font_awesome` for clarity and consistency.
- The new `include_font_awesome` helper now supports loading **Font Awesome Kits**, including **Font Awesome Pro**.

### Added
- Added `kit:` option to `include_font_awesome` to load Font Awesome through the official Kit CDN:
  ```erb
  <%= include_font_awesome kit: "YOUR-KIT-ID" %>
  ```

### Behavior
- Using a version number still loads Font Awesome Free from cdnjs:
  ```erb
  <%= include_font_awesome "7.0.1" %>
  ```
- Using `kit:` injects the official Font Awesome Kit `<script>` tag.
- Passing both `version` and `kit:` now raises an error.

### Notes
- Existing functionality is preserved for layouts using CDN-based loading.
- This update enables developers with a **Font Awesome Pro** subscription to load their private icon kits safely and cleanly.

---

## 0.2.0

### Changed
- Simplified the `icon` helper API.
- The helper no longer requires passing full Font Awesome class names (`fa-solid`, `fa-regular`, `fa-brands`).
- Introduced explicit `style:` and `pack:` options (accepted as strings or symbols).

### Before
```erb
<%= icon "fa-solid", "user" %>
<%= icon "fa-regular", "bell" %>
<%= icon "fa-brands", "font-awesome", "Font Awesome" %>
```

### After
```erb
<%= icon "user" %>
<%= icon "gear", "Settings" %>
<%= icon "trash-can", "Delete", style: :regular %>
<%= icon "github", pack: :brands, class: "fa-2x fa-shake" %>
```

### Notes
- `style:` defaults to `"solid"` unless `pack: "brands"` is used.
- Stricter validation prevents invalid style/pack combinations.
- Improved readability and consistency with Font Awesome's official naming.

---

## 0.1.0

### Added
- Initial release
- Rails helper to load Font Awesome from cdnjs with SRI integrity
- Explicit Font Awesome version selection
- `icon` helper to render Font Awesome icons in Rails views
- Support for Font Awesome 7
- Compatibility with Rails 7 and Rails 8
