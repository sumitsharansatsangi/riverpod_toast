// riverpod_toast/lib/src/toast_helpers.dart

import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'toast_type.dart';
import 'toast_controller.dart';
import 'toast_theme.dart';

// Public API for common use cases
void showSuccess(
  WidgetRef ref,
  String msg, {
  bool localized = true,
  ToastThemeData? theme,
  Duration? duration,
}) {
  _internalShow(
    ref,
    msg,
    type: ToastType.success,
    localized: localized,
    theme: theme,
    duration: duration,
  );
}

void showError(
  WidgetRef ref,
  String msg, {
  bool localized = true,
  ToastThemeData? theme,
  Duration? duration,
}) {
  _internalShow(
    ref,
    msg,
    type: ToastType.error,
    localized: localized,
    theme: theme,
    duration: duration,
  );
}

void showInfo(
  WidgetRef ref,
  String msg, {
  bool localized = true,
  ToastThemeData? theme,
  Duration? duration,
}) {
  debugPrint("Showing info");
  _internalShow(
    ref,
    msg,
    type: ToastType.info,
    localized: localized,
    theme: theme,
    duration: duration,
  );
}

void showWarning(
  WidgetRef ref,
  String msg, {
  bool localized = true,
  ToastThemeData? theme,
  Duration? duration,
}) {
  _internalShow(
    ref,
    msg,
    type: ToastType.warning,
    localized: localized,
    theme: theme,
    duration: duration,
  );
}

void showProgressToast(WidgetRef ref, String msg, {ToastThemeData? theme}) {
  _read(ref).show(
    msg,
    type: ToastType.info,
    localized: false,
    theme: theme,
    isProgress: true,
    duration: const Duration(
      days: 1,
    ), // effectively indefinite unless manually cleared
  );
}

// Internal fallback for advanced use cases (e.g. ProviderContainer)
void showToastFlexible(
  dynamic refOrContainer,
  String msg, {
  required ToastType type,
  bool localized = true,
  ToastThemeData? theme,
  Duration? duration,
}) {
  _internalShow(
    refOrContainer,
    msg,
    type: type,
    localized: localized,
    theme: theme,
    duration: duration,
  );
}

void _internalShow(
  dynamic refOrContainer,
  String msg, {
  required ToastType type,
  bool localized = true,
  ToastThemeData? theme,
  Duration? duration,
}) {
  final ctrl = _read(refOrContainer);
  ctrl.show(
    msg,
    type: type,
    localized: localized,
    theme: theme,
    duration: duration,
  );
}

ToastController _read(dynamic refOrContainer) {
  if (refOrContainer is WidgetRef) {
    return refOrContainer.read(toastControllerProvider.notifier);
  } else if (refOrContainer is ProviderContainer) {
    return refOrContainer.read(toastControllerProvider.notifier);
  } else {
    throw ArgumentError('Invalid ref or container passed to toast helper');
  }
}
