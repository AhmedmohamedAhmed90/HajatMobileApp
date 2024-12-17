import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hajat_mobile_app/src/featrues/auth/logic/auth_cubit.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';
import 'package:hajat_mobile_app/src/services/logging/log.dart';
import 'package:hajat_mobile_app/src/utilities/common.dart';
import 'package:hajat_mobile_app/src/utilities/consts.dart';
import 'package:hajat_mobile_app/src/utilities/router.dart';

@RoutePage()
class AuthScreen extends StatefulWidget {
  AuthScreen({super.key, required this.isLogin});
  bool isLogin;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey formKey = GlobalKey<FormState>();
  late TextEditingController passwordController;
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneController;
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  @override
  void initState() {
    passwordController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: Consts.paddingHM,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.isLogin ? 'Login' : 'Sign Up',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Consts.gapM,
                ],
              ),
              Form(
                key: formKey,
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      if (!widget.isLogin)
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    autocorrect: false,
                                    keyboardType: TextInputType.text,
                                    controller: firstNameController,
                                    decoration: InputDecoration(
                                      labelText: 'First Name',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            Consts.borderRadiusM),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'First Name is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Consts.gapS,
                                Expanded(
                                  child: TextFormField(
                                    autocorrect: false,
                                    keyboardType: TextInputType.text,
                                    controller: lastNameController,
                                    decoration: InputDecoration(
                                      labelText: 'Last Name',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            Consts.borderRadiusM),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Last Name is required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Consts.gapS,
                          ],
                        ),
                      TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        maxLength: 10,
                        decoration: InputDecoration(
                          hintText: '09XXXXXXXX',
                          labelText: 'Phone',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Consts.borderRadiusM),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Phone number is required';
                          }
                          return null;
                        },
                      ),
                      Consts.gapM,
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: passwordController,
                        obscureText: isPasswordVisible,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.circular(Consts.borderRadiusM),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is required';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                      Consts.gapM,
                      if (!widget.isLogin)
                        Row(
                          children: [
                            Expanded(
                              child: RichText(
                                maxLines: 3,
                                text: TextSpan(
                                  text: 'I accept the',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  children: [
                                    TextSpan(
                                      text: ' Privacy Policy',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          print('Privacy Policy');
                                          launchURL(
                                              'https://odoo.hajat.com.ly/privacy');
                                        },
                                    ),
                                    TextSpan(
                                      text: ' and',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    TextSpan(
                                      text: ' Terms and Conditions',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          print('Terms and Conditions');
                                          launchURL(
                                              'https://odoo.hajat.com.ly/terms');
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      Consts.gapM,
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: () {
                            if ((formKey.currentState as FormState)
                                .validate()) {
                              if (widget.isLogin) {
                                // login
                                getIt<Log>().info('Login');
                                getIt<AuthCubit>().login(
                                  phoneController.text,
                                  passwordController.text,
                                );
                                context.router.maybePop();
                              } else {
                                // signup
                                getIt<Log>().info('Sign Up');
                                getIt<AuthCubit>().signUp(
                                  firstNameController.text,
                                  lastNameController.text,
                                  phoneController.text,
                                  passwordController.text,
                                  1,
                                );
                                context.router.maybePop();
                              }
                            }
                          },
                          child: Text(widget.isLogin ? 'Login' : 'Sign Up'),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            widget.isLogin = !widget.isLogin;
                          });
                        },
                        child: Text(
                          widget.isLogin
                              ? "Don't have an account? Create Account"
                              : "Already have an account? Sign In",
                        ),
                      ),
                      if (widget.isLogin)
                        TextButton(
                          onPressed: () {
                            if (phoneController.text.isNotEmpty) {
                              context.router.push(ResetPasswordRoute(
                                phone: phoneController.text
                                    .replaceFirst("0", "20"),
                              ));
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Enter Phone Number'),
                                    content: TextFormField(
                                      keyboardType: TextInputType.phone,
                                      controller: phoneController,
                                      maxLength: 10,
                                      decoration: InputDecoration(
                                        hintText: '012XXXXXXXX',
                                        labelText: 'Phone',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              Consts.borderRadiusM),
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          context.router.maybePop();
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context.router.push(
                                              ResetPasswordRoute(
                                            phone: phoneController.text
                                                .replaceFirst("0", "20"),
                                          ));
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: Text(
                            'Forgot Password?',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
