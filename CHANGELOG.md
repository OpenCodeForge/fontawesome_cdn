# Changelog

All notable changes to this project will be documented in this file.

This project follows [Semantic Versioning](https://semver.org).

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
