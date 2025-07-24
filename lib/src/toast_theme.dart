// riverpod_toast/lib/src/toast_theme.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'toast_type.dart';

/// Global toggle for native-style toast UI
bool useNativeUiGlobally = false;

/// Optional global theme override for all toasts
ToastThemeData? globalToastTheme;

/// Per-toast override priority: localTheme > globalTheme > platform default
class ToastThemeData {
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final double borderRadius;
  final IconData? icon;
  final BoxShadow? boxShadow;

  const ToastThemeData({
    this.backgroundColor,
    this.textStyle,
    this.borderRadius = 8.0,
    this.icon,
    this.boxShadow,
  });
}

/// Defines styling used when native-like UI is requested
Widget Function(String) toastStyleForPlatform(
  BuildContext context,
  ToastType type, {
  ToastThemeData? localTheme,
}) {
  final isIOS = Platform.isIOS;
  final isMacOS = Platform.isMacOS;
  final isAndroid = Platform.isAndroid;
  final isWindows = Platform.isWindows;
  final isLinux = Platform.isLinux;
  // final isDark = Theme.of(context).brightness == Brightness.dark;

  Color background;
  IconData icon;
  BorderRadius radius;

  switch (type) {
    case ToastType.success:
      background = isIOS || isMacOS
          ? Colors.green[600]!
          : Colors.greenAccent[700]!;
      icon = Icons.check_circle;
      break;
    case ToastType.error:
      background = isIOS || isMacOS ? Colors.red[600]! : Colors.redAccent[700]!;
      icon = Icons.error;
      break;
    case ToastType.warning:
      background = isIOS || isMacOS
          ? Colors.orange[700]!
          : Colors.orangeAccent[700]!;
      icon = Icons.warning;
      break;
    case ToastType.info:
      background = isIOS || isMacOS ? Colors.blueGrey : Colors.blueAccent[700]!;
      icon = Icons.info;
      break;
  }

  if (isIOS || isMacOS) {
    radius = BorderRadius.circular(12);
  } else if (isAndroid) {
    radius = BorderRadius.circular(6);
  } else if (isWindows || isLinux) {
    radius = BorderRadius.circular(4);
  } else {
    radius = BorderRadius.circular(8);
  }

  final theme = localTheme ?? globalToastTheme;

  return (String message) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    decoration: BoxDecoration(
      color: theme?.backgroundColor ?? background,
      borderRadius: BorderRadius.circular(
        theme?.borderRadius ?? radius.topLeft.x,
      ),
      boxShadow: [
        theme?.boxShadow ??
            BoxShadow(
              color: Colors.black..withAlpha((0.2 * 255).round()),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(theme?.icon ?? icon, color: Colors.white),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            message,
            style:
                theme?.textStyle ??
                const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ],
    ),
  );
}
