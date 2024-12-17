import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hajat_mobile_app/src/featrues/auth/logic/reset_password_cubit.dart';
import 'package:hajat_mobile_app/src/featrues/common/ui/error_card.dart';
import 'package:hajat_mobile_app/src/utilities/consts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

@RoutePage()
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key, required this.phone});
  final String phone;

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late ResetPasswordCubit cubit;
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    cubit = ResetPasswordCubit(widget.phone);
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
          bloc: cubit,
          builder: (context, state) {
            return state.maybeWhen(
              error: (message) => Center(
                child: ErrorCard(
                  message: message,
                  onClose: () {
                    context.router.maybePop();
                  },
                ),
              ),
              otpSent: () {
                // otp form
                return Center(
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
                        'We have sent a one-time password to your phone.',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Consts.gapVS,
                      Text(
                        widget.phone.replaceFirst("20", "0"),
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
                              borderColor:
                                  Theme.of(context).colorScheme.primary,
                              focusBorderColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            onCompleted: (pin) {
                              cubit.verifyOtp(pin);
                            },
                          ),
                        ),
                      ),
                      Consts.gapVM,
                    ],
                  ),
                );
              },
              otpVerified: (resetToken) {
                // new password form
                return Center(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Enter New Password',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Consts.gapVL,
                        Padding(
                          padding: Consts.paddingHXL,
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(Consts.borderRadiusM),
                              ),
                              suffixIcon: IconButton(
                                icon: HeroIcon(isPasswordVisible
                                    ? HeroIcons.eyeSlash
                                    : HeroIcons.eye),
                                onPressed: () {
                                  setState(() {
                                    isPasswordVisible = !isPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            controller: passwordController,
                            obscureText: !isPasswordVisible,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Password is required';
                              } else if (value.length < 6) {
                                return 'Password too short';
                              }
                            },
                          ),
                        ),
                        Consts.gapVM,

                        Container(
                          padding: Consts.paddingHXL,
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit.resetPasswordWithToken(
                                    passwordController.text, resetToken);
                              }
                            },
                            child: Text('Reset Password'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              success: () {
                // success message
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const HeroIcon(
                        HeroIcons.checkCircle,
                        size: 100,
                        color: Colors.green,
                      ),
                      Consts.gapXL,
                      Text('Password reset successful',
                          style: Theme.of(context).textTheme.titleLarge),
                      Consts.gapVM,
                      Container(
                        width: double.infinity,
                        padding: Consts.paddingHXL,
                        child: OutlinedButton(
                          onPressed: () {
                            context.router.maybePop();
                          },
                          child: Text('Back'),
                        ),
                      ),
                    ],
                  ),
                );
              },
              orElse: () => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
