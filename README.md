# riverpod_toast

`riverpod_toast` is a modular, high-performance toast system built with Riverpod v3 and `flutter_styled_toast`.

## ✨ Features
- Overlay-based toast display
- Riverpod-based logic
- Localization-ready
- Adaptive dark/light theming
- Tap-to-dismiss
- Throttling and deduplication

## ✅ Usage

1. Register context:
```dart
ref.read(toastControllerProvider.notifier).registerContext(context);
```

2. Show toast:
```dart
showSuccess(ref, 'toast_success');
```

Add this to your `pubspec.yaml`:
```yaml
dependencies:
  riverpod_toast:
    path: ./packages/riverpod_toast
```


# 🍞 riverpod_toast

> **Elegant, flexible, and context-free toast notifications for Flutter, powered by Riverpod & Styled Toast.**

---

### 🚀 Tagline

**"RiverpodToast — Show toasts anywhere, powered by Riverpod and overlay magic."**

---

### 🎯 Overview

`riverpod_toast` is a reusable Flutter toast system designed for real-world apps.  
Built on top of `flutter_styled_toast`, `Riverpod`, and `EasyLocalization`, it gives you:

- Queueing
- Deduplication
- Adaptive dark mode styling
- Context-free invocation
- Global customization
- Easy integration with localization

---

### ✨ Features

✅ **Context-free toast** — Show toast from anywhere in your app logic, no need for BuildContext  
✅ **Toast queue** — Handles multiple toast requests without overlap  
✅ **Smart deduplication** — Prevents spamming the same toast repeatedly  
✅ **Dark mode support** — Auto-styled based on current theme  
✅ **Riverpod-based state** — Full control, observability, and testability  
✅ **Modular** — Easily reusable in any Flutter app  
✅ **Custom animations & positioning** — Built on top of `flutter_styled_toast`  
✅ **EasyLocalization integration** — Optional auto-localized messages  
✅ **No external dependencies like `fluttertoast`**

---

### ⚖️ Comparison

| Feature | `riverpod_toast` | `ScaffoldMessenger` | `fluttertoast` |
|--------|------------------|----------------------|-----------------|
| No context needed | ✅ | ❌ | ✅ |
| Works in overlays/dialogs | ✅ | ❌ | ✅ |
| Queueing | ✅ | ❌ | ❌ |
| Deduplication | ✅ | ❌ | ❌ |
| EasyLocalization support | ✅ | ❌ | ❌ |
| Riverpod integration | ✅ | ❌ | ❌ |
| Custom animation & styling | ✅ | ⚠️ | ⚠️ |
| Platform-native support | ❌ | ✅ | ✅ |
| Built-in Material Design feel | ⚠️ | ✅ | ❌ |

---

### 🧩 Installation

```bash
flutter pub add riverpod_toast
````

Make sure to also have:
(see example/pubspec.yaml)
```yaml
dependencies:
  flutter_riverpod: ^3.0.0
  riverpod_annotation: ^3.0.0
  easy_localization: ^3.0.8
  flutter_styled_toast: ^2.2.1
  build_runner:
  riverpod_generator:
```

---

### 🛠️ Setup

#### 1. Wrap your app with `ProviderScope` and `EasyLocalization`

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const MyApp(),
      ),
    ),
  );
}
```

#### 2. Register context after `StyledToast` is mounted

```dart
class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StyledToast(
      locale: context.locale,
      child: MaterialApp(
        home: ToastContextRegistrar(
          child: const HomePage(),
        ),
      ),
    );
  }
}

class ToastContextRegistrar extends ConsumerStatefulWidget {
  final Widget child;
  const ToastContextRegistrar({required this.child});

  @override
  ConsumerState<ToastContextRegistrar> createState() => _ToastContextRegistrarState();
}

class _ToastContextRegistrarState extends ConsumerState<ToastContextRegistrar> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(toastControllerProvider.notifier).registerContext(context);
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
```

---

### ✅ Usage

In any widget or service:

```dart
showSuccess(ref, 'Operation successful');
showError(ref, 'Something went wrong!');
showWarning(ref, 'Be careful!');
showInfo(ref, 'This is an info message');
```

> You don’t need to pass `context` — it’s already registered via Riverpod.

---

### 🌓 Dark Mode & Styling

Toasts adapt automatically based on the theme.
You can customize animations, padding, colors, border radius, etc., by editing `ToastController._buildToastWidget(...)`.

---

### 🌐 Localization

If you're using `EasyLocalization`, toast messages can be translated automatically:

```dart
showSuccess(ref, 'msg_operation_successful'.tr());
```

You can also configure whether a message should be treated as localized using the `localized` flag in `show()`.

---

### 🧪 Testing & Debugging

You can inspect the internal queue using:

```dart
final queue = ref.watch(toastControllerProvider);
```

Logs are printed during registration, deduplication, and toast display.

---

### 📦 Folder Structure

* `lib/riverpod_toast.dart`: main export
* `src/toast_controller.dart`: Riverpod notifier with queue/dedupe logic
* `src/toast_type.dart`: enum for toast types
* `src/toast_helpers.dart`: exposed functions like `showSuccess()`

---

### 🔮 Coming Soon

✅ `ToastScope` widget — auto-registers context with no boilerplate
✅ Actionable toasts — support for actions like `UNDO`, `RETRY`, etc.
✅ Global fallback to `ScaffoldMessenger` if overlay not available
✅ Adaptive styling hooks for Material 3 & platform UI
✅ Configuration builder for themes, durations, animation styles
✅ Optional `ToastTheme` override per toast
✅ Support for persistent toasts with dismiss buttons

---

### 🤝 Contribution

Feel free to open issues or submit PRs.
We’re keeping this package modular, Riverpod-native, and customizable.

---

### 📄 License

MIT — use freely for personal or commercial projects.

---

Made with ❤️ by \[sumitsharansatsangi].



