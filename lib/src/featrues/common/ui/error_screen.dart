import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hajat_mobile_app/src/utilities/consts.dart';

@RoutePage()
class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: Consts.paddingM,
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HeroIcon(
                HeroIcons.exclamationTriangle,
                style: HeroIconStyle.outline,
                color: Theme.of(context).colorScheme.error,
                size: Consts.iconSizeXXl,
              ),
              Consts.gapVM,
              Text(
                'An error occurred', 
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Consts.gapVS,
              Text(
                message,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey,
                    ),
              ),
              Consts.gapVXL,
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () {
                      context.router.maybePop();
                    },
                    child: Text(
                      'Back',  
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
