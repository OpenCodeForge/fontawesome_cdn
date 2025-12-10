# Contributing to FontawesomeCdn

Thank you for your interest in contributing! 🎉  
This project aims to stay **simple, explicit, and focused**.

---

## ✅ Philosophy

Before opening a pull request, please keep in mind:

- The gem must remain **small**
- No asset pipeline integration
- No JavaScript
- No configuration complexity
- CDN-based usage only

If a change adds complexity without clear value, it will likely be declined.

---

## 🛠 Development setup

Clone the repository and install dependencies:

```bash
bundle install
```

Run the test suite:

```bash
bundle exec rspec
```

Run the linter:

```bash
bundle exec rubocop
```

All checks **must be green** before submitting a pull request.

---

## ✅ Tests

- New features must include tests
- Bug fixes should include a regression test
- RSpec is used for testing
- RuboCop must pass with no offenses

---

## 📦 Supported versions

- Ruby: **3.0+**
- Rails: **7.x and 8.x**
- Font Awesome: supported versions listed in the README

---

## 🚀 Pull requests

When submitting a pull request:

1. Keep changes small and focused
2. Explain the **why**, not just the **what**
3. Ensure CI passes
4. Update documentation if needed

---

## 🧾 License

By contributing, you agree that your contributions will be licensed under the MIT License.
