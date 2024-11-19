import 'package:emoshare_diary/common/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<bool?> showConfirmationDialog({
  required BuildContext context,
  required String content,
  String? details,
  required String confirmText,
  required String cancelText,
}) {
  return showDialog<bool?>(
    context: context,
    builder: (_) => AlertDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      content: ClipRRect(
        borderRadius: BorderRadius.circular(18.0),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.72,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 32.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  content,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 18.0),
              if (details != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text(
                    details,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              const SizedBox(height: 24.0),
              Row(
                children: [
                  Flexible(
                    child: GestureDetector(
                      onTap: () => context.pop(false),
                      child: Container(
                        height: 52.0,
                        color: Colors.grey[300],
                        child: Center(
                          child: Text(
                            cancelText,
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: GestureDetector(
                      onTap: () => context.pop(true),
                      child: Container(
                        height: 52.0,
                        color: PRIMARY_COLOR,
                        child: Center(
                          child: Text(
                            confirmText,
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      insetPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
    ),
  );
}

Future<void> showInfoDialog({
  required BuildContext context,
  required String content,
  String? details,
  String? checkMessage,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => AlertDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      content: ClipRRect(
        borderRadius: BorderRadius.circular(18.0),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.72,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 32.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  content,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 18.0),
              if (details != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text(
                    details,
                    textAlign: TextAlign.center,
                  ),
                ),
              const SizedBox(height: 24.0),
              GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  height: 52.0,
                  color: PRIMARY_COLOR,
                  child: Center(
                    child: Text(
                      checkMessage ?? '확인',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      insetPadding: EdgeInsets.zero,
      iconPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
    ),
  );
}
