import 'package:flutter/material.dart';
import 'package:hajat_mobile_app/src/utilities/consts.dart';

class AlertWidget extends StatelessWidget {
  const AlertWidget({
    super.key,
    required this.title,
    required this.message,
    this.onRetry,
    this.image,
  });

  final String title;
  final String message;
  final String? image;
  final Function()? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (image != null)
            Image.asset(
              image!,
              width: 125,
              height: 125,
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
              child: Text(
                'Retry',  
              ),
            ),
        ],
      ),
    );
  }
}
