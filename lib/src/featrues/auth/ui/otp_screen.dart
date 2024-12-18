import 'package:flutter/material.dart';
import 'package:hajat_mobile_app/src/featrues/auth/logic/auth_cubit.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';
import 'package:hajat_mobile_app/src/utilities/common.dart';
import 'package:hajat_mobile_app/src/utilities/consts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key, this.isOtpWrong = false});
  bool isOtpWrong = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              HeroIcon(
                        HeroIcons.key,
                        size: 100,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      Consts.gapM,
            Text(
              'Enter OTP',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Consts.gapVS,
            Text(
              'OTP Description',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Consts.gapVM,
            Padding(
              padding: Consts.paddingHXL,
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: OTPTextField(
                  length: 6,
                  width: double.infinity,
                  textFieldAlignment: MainAxisAlignment.spaceAround,
                  fieldStyle: FieldStyle.underline,
                  otpFieldStyle: OtpFieldStyle(
                    borderColor: Theme.of(context).colorScheme.primary,
                    focusBorderColor: Theme.of(context).colorScheme.primary,
                  ),
                  onCompleted: (pin) {
                    getIt<AuthCubit>().verifyOtp(pin);
                  },
                ),
              ),
            ),
            Consts.gapVM,
            if (isOtpWrong)
              Text(
                'OTP is Wrong',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
              ),
          ],
        ),
      ),
    );
  }
}
