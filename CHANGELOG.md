# Changelog

All notable changes to this project will be documented in this file.

This project follows [Semantic Versioning](https://semver.org).

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
