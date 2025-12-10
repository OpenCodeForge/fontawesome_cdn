# FontawesomeCdn

A tiny Rails helper gem to load Font Awesome via CDN and render icons with a simple, explicit API.

Nothing more. Nothing less.

---

## Why this gem?

FontawesomeCdn is intentionally minimal:

- ✅ No asset pipeline integration
- ✅ No SVG handling
- ✅ No JavaScript
- ✅ No configuration files
- ✅ No implicit defaults

You explicitly choose the Font Awesome version, and the gem takes care of:

- generating the correct <link> tag
- adding the correct SRI integrity hash
- providing a small icon view helper