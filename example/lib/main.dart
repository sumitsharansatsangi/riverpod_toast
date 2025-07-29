import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:riverpod_toast/riverpod_toast.dart';

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

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StyledToast(
      locale: context.locale,
      child: MaterialApp(
        title: 'Toast Demo',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: ToastContextRegistrar(child: const HomePage()),
      ),
    );
  }
}

/// ✅ This registers context AFTER everything is built correctly
class ToastContextRegistrar extends ConsumerStatefulWidget {
  final Widget child;
  const ToastContextRegistrar({super.key, required this.child});

  @override
  ConsumerState<ToastContextRegistrar> createState() =>
      _ToastContextRegistrarState();
}

class _ToastContextRegistrarState extends ConsumerState<ToastContextRegistrar> {
  @override
  void initState() {
    super.initState();
    longTask();
    // Wait until the widget is in the tree
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = ref.read(toastControllerProvider.notifier);
      debugPrint("[TOAST INIT] Registering context: $context");
      controller.registerContext(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  Future<void> longTask() async {
    await Future.delayed(const Duration(seconds: 3));
    showToastFlexible(ref, 'Long task completed!', type: ToastType.success);
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Toast Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                debugPrint("[BUTTON] showSuccess called");
                showSuccess(ref, 'Success!');
              },
              child: const Text('Show Success'),
            ),
            ElevatedButton(
              onPressed: () => showError(ref, 'Something went wrong!'),
              child: const Text('Show Error'),
            ),
            ElevatedButton(
              onPressed: () => showWarning(ref, 'Be careful!'),
              child: const Text('Show Warning'),
            ),
            ElevatedButton(
              onPressed: () => showInfo(ref, 'Here is some info.'),
              child: const Text('Show Info'),
            ),
          ],
        ),
      ),
    );
  }
}
