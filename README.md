# 🎨 FontawesomeCdn

[![Gem Version](https://img.shields.io/gem/v/fontawesome_cdn.svg)](https://rubygems.org/gems/fontawesome_cdn)
[![CI](https://github.com/OpenCodeForge/fontawesome_cdn/actions/workflows/ci.yml/badge.svg)](https://github.com/OpenCodeForge/fontawesome_cdn/actions/workflows/ci.yml)

Simple Rails helpers to load **Font Awesome via CDN or Kit**, and render icons in views.

✅ Supports **Font Awesome Free (CDN)**  
✅ Supports **Font Awesome Pro (Kit)**  
✅ Compatible with **Font Awesome 7**  
✅ Compatible with **Rails 8**  
✅ No asset pipeline required

---

## 📦 Installation

```ruby
gem "fontawesome_cdn"
```

```bash
bundle install
```

---

## 🚀 Usage

### 1️⃣ Load Font Awesome

**Simply add the helper inside the `<head>` of your layout**:

```erb
<!-- app/views/layouts/application.html.erb -->
<head>
  <%= include_font_awesome "7.3.0" %>
</head>
```

👉 Loads Font Awesome from cdnjs  
👉 Recommended for Font Awesome Free

---

#### Alternative — Load a Font Awesome Kit

If you have a Font Awesome Pro subscription, you can load your Kit:

```erb
<%= include_font_awesome kit: "YOUR-KIT-ID" %>
```

👉 Use this method for **Font Awesome Pro**  
👉 The kit automatically loads your own selection (Pro icons, subsets, etc.)

---

### 2️⃣ Render icons (in views)

Basic usage:

```erb
<%= icon "user" %>
<%= icon "gear", "Settings" %>
<%= icon "bell", class: "fa-regular fa-2x fa-shake" %>
```

#### Using the `fa:` shortcut

For convenience, you can use the `fa:` option to pass **space-separated Font Awesome tokens**, automatically prefixed with `fa-`.

```erb
<%= icon "bell", fa: "regular 2x shake" %>
<%= icon "github", "Source code", fa: "brands", class: "link" %>
```

---

## ⚙️ Configuration

FontawesomeCdn allows you to define default icon behavior that will be **automatically applied to all icons**, unless explicitly overridden at render time.

```rb
# config/initializers/fontawesome_cdn.rb
FontawesomeCdn.configure do |config|
  config.default_family = "classic"
  config.default_style  = "solid"
  config.default_aria_hidden = true
end
```

By default, these settings are used to determine which Font Awesome family and style are added to each icon.  
If a family or style is explicitly provided via `class:` or `fa:`, it will be used instead of the defaults.

Defaults:
- `classic` is implicit (no `fa-classic`)
- default style is injected automatically
- `brands` does not inject a style

---

## 🧩 Supported Font Awesome versions

These versions are loaded via **cdnjs** and include verified SRI hashes:

- **7.3.0**
- **7.2.0**
- **7.1.0**
- **7.0.1**
- **7.0.0**
- **6.7.2**

---

## 🔐 Using Font Awesome Pro

To load Pro icons, create a **Kit** in your Font Awesome account:

1. Go to https://fontawesome.com/kits
2. Create a kit
3. Copy your Kit ID
4. Use:

```erb
<%= include_font_awesome kit: "YOUR-KIT-ID" %>
```

> ❗ CDNJS does **not** host Font Awesome Pro — you must use a Kit.

---

## 📄 License

MIT
