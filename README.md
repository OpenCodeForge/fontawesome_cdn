# 🎨 FontawesomeCdn

[![Gem Version](https://img.shields.io/gem/v/fontawesome_cdn.svg)](https://rubygems.org/gems/fontawesome_cdn)
[![CI](https://github.com/OpenCodeForge/fontawesome_cdn/actions/workflows/ci.yml/badge.svg)](https://github.com/OpenCodeForge/fontawesome_cdn/actions/workflows/ci.yml)

Simple Rails helpers to load **Font Awesome via CDN or Kit**, and render icons in views.

✅ Supports **Font Awesome Free (CDN)**  
✅ Supports **Font Awesome Pro (Kit)**  
✅ Compatible with **Font Awesome 7**  
✅ Compatible with **Rails 7 and 8**  
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

## 1️⃣ Load Font Awesome in your layout

### **Option A — Load from cdnjs (Font Awesome Free)**

Place inside your `<head>`:

```erb
<%= include_font_awesome "7.0.1" %>
```

This generates:

```html
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css" ...>
```

---

### **Option B — Load a Font Awesome Kit (supports Pro)**

If you have a Font Awesome Pro subscription, you can load your Kit:

```erb
<%= include_font_awesome kit: "YOUR-KIT-ID" %>
```

This generates:

```html
<script src="https://kit.fontawesome.com/YOUR-KIT-ID.js" crossorigin="anonymous"></script>
```

👉 Use this method for **Font Awesome Pro**  
👉 The kit automatically loads your own selection (Pro icons, subsets, etc.)

---

## 2️⃣ Render icons in views

```erb
<%= icon "user" %>
<%= icon "gear", "Settings" %>
<%= icon "trash-can", "Delete", style: :regular %>
<%= icon "github", pack: :brands, class: "fa-2x fa-shake" %>
```

### Options

| Option | Description |
|--------|-------------|
| `style:` | `:solid`, `:regular`, `:light`, `:thin`, `:semibold` (default: `:solid`) |
| `pack:` | Use `:brands` when using Font Awesome Brands |
| `class:` | Additional CSS classes |
| `aria-hidden:` | Passed as-is |

---

## 🧩 Supported Font Awesome versions

These versions are loaded via **cdnjs** and include verified SRI hashes:

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
