import 'package:example/registrar.dart';
import 'package:example/router.dart';
import 'package:example/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const MyApp1(),
      ),
    ),
  );
}

// Go Router Version
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
        routerConfig: router,
        builder: (context, child) => StyledToast(
        locale: context.locale,
        child: ToastContextRegistrar(child: child!),
      ),
        title: 'Toast Demo',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.system,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      
    );
  }
}

//Without Go Router

class MyApp1 extends ConsumerWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      builder: (context, child) => StyledToast(
        locale: context.locale,
        child: ToastContextRegistrar(child: child!),
      ),
      title: 'Toast Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: HomePage(false),
    );
  }
}
