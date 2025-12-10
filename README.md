# 🎨 FontawesomeCdn

[![Gem Version](https://img.shields.io/gem/v/fontawesome_cdn.svg)](https://rubygems.org/gems/fontawesome_cdn)
[![CI](https://github.com/OpenCodeForge/fontawesome_cdn/actions/workflows/ci.yml/badge.svg)](https://github.com/OpenCodeForge/fontawesome_cdn/actions/workflows/ci.yml)

Simple Rails helpers to load **Font Awesome via CDN** and render icons in views.

✅ Compatible with **Font Awesome 7**  
✅ Compatible with **Rails 8**  
✅ No asset pipeline  
✅ No JavaScript


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

### Load Font Awesome (layout)

Place this helper in your layout, inside `<head>`.

```erb
<%= fontawesome_cdn_stylesheet_tag "7.0.1" %>
```

---

### Render icons (views)

Use this helper anywhere in your views or partials.

```erb
<%= icon "fa-solid", "user" %>
<%= icon "fa-regular", "bell", class: "fa-2x" %>
<%= icon "fa-brands", "font-awesome", "Font Awesome" %>
```

---

## ✅ Supported Font Awesome versions

Font Awesome is loaded directly from **cdnjs**.

**Supported versions** (with verified SRI):

- ✅ **7.0.1**
- ✅ **7.0.0**
- ✅ **6.7.2**

---

## 📄 License

MIT
