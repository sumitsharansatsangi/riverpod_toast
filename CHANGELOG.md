# CHANGELOG

## [0.1.0-dev.1] - 2025-07-23

### 🎉 Initial Release
- Riverpod v3-native toast management system
- Overlay-based toast rendering using `flutter_styled_toast`
- Support for:
  - Dark mode & adaptive themes
  - Platform-aware native-looking UI
  - MotionToast-style animation toggle (`useMotionToast`)
  - Manual dismiss & progress toasts
  - Global config + per-toast override
  - Easy localization integration
  - Queueing logic (one toast at a time)
- Exposed helper methods: `showSuccess`, `showError`, `showWarning`, `showInfo`, `showProgressToast`

---