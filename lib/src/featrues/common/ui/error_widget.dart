import 'package:flutter/material.dart';
import 'package:hajat_mobile_app/src/utilities/consts.dart';

class ErrorrWidget extends StatelessWidget {
  const ErrorrWidget({
    super.key,
    required this.title,
    required this.message,
    this.onRetry,
  });
  final String title;
  final String message;
  final Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error,
            size: 50,
           
          ),
          Consts.gapVM,
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Consts.gapVS,
          Text(
            message, 
            style: Theme.of(context).textTheme.titleSmall,
          ),
          if (onRetry != null) Consts.gapVM,
          if (onRetry != null)
            FilledButton(
              onPressed: onRetry,
              child: const Text(
                'Retry', 
              ),
            ),
        ],
      ),
    );
  }
}
