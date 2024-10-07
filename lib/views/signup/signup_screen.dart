import 'package:pixabay_gallery/config/assets/image_assets.dart';
import 'package:pixabay_gallery/config/components/custom_button.dart';
import 'package:pixabay_gallery/config/components/custom_dialog_widget.dart';
import 'package:pixabay_gallery/config/components/custom_text_field.dart';
import 'package:pixabay_gallery/config/theme/colors.dart';
import 'package:pixabay_gallery/config/theme/text_theme_style.dart';
import 'package:pixabay_gallery/utils/gaps.dart';
import 'package:pixabay_gallery/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends HookWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final telephoneController = useTextEditingController();
    final emailController = useTextEditingController();
    final fullnameController = useTextEditingController();

    // final authController = useAuthProvider(authControllerProvider.notifier);
    final formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Gaps.verticalGapOf(20),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        child: Image.asset(
                          height: Utils.getScreenHeight(context) * 0.15,
                          width: Utils.getScreenHeight(context) * 0.15,
                          ImageAssets.appLogo,
                        ),
                      ),
                    ),
                    Gaps.verticalGapOf(40),
                    Text(
                      'Hello there 👋',
                      style: AppTextStyles.textHeading(),
                    ),
                    Flexible(
                      child: Text(
                        'Ready to grow your business with tamam?',
                        style: AppTextStyles.textBody(),
                      ),
                    ),
                    Gaps.verticalGapOf(40),
                    Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Full Name',
                            style: AppTextStyles.textLabel(),
                          ),
                          Gaps.verticalGapOf(5),
                          CustomTextFieldWidget(
                            controller: emailController,
                            textInputType: TextInputType.emailAddress,
                            hintTitle: 'John Smith',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Please Enter Your Full Name");
                              }
                              return null;
                            },
                          ),
                          Gaps.verticalGapOf(20),
                          Text(
                            'Email',
                            style: AppTextStyles.textLabel(),
                          ),
                          Gaps.verticalGapOf(5),
                          CustomTextFieldWidget(
                            controller: emailController,
                            textInputType: TextInputType.emailAddress,
                            hintTitle: 'johnsmith@gmail.com',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Please Enter Your Email");
                              }
                              // reg expression for email validation
                              else if (!RegExp(
                                      "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("Please Enter a valid email");
                              }
                              return null;
                            },
                          ),
                          Gaps.verticalGapOf(20),
                          Text(
                            'Phone No',
                            style: AppTextStyles.textLabel(),
                          ),
                          Gaps.verticalGapOf(5),
                          CustomTextFieldWidget(
                            controller: emailController,
                            textInputType: TextInputType.emailAddress,
                            hintTitle: '+971',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Please Enter Your Phone No");
                              }

                              return null;
                            },
                          ),
                          Gaps.verticalGapOf(20),
                          Text(
                            'Business Type',
                            style: AppTextStyles.textLabel(),
                          ),
                          Gaps.verticalGapOf(5),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.grey1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Business Type',
                                    style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                  Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Gaps.verticalGapOf(40),
                    CustomButtonWidget(
                      width: double.infinity,
                      height: 60,
                      title: 'Register',
                      onPress: () async {
                        if (formKey.currentState!.validate() &&
                            validatePassword(fullnameController.text,
                                telephoneController.text, context)!) {
                          CustomDialogWidget.dialogLoading(
                              msg: 'Creating Account...', context: context);

                          // await authController.signUpWithEmailAndPassword(
                          //     context,
                          //     emailController.text.trim(),
                          //     passwordController.text.trim());
                        }
                      },
                    ),
                    Gaps.verticalGapOf(15),
                    Align(
                      alignment: Alignment.center,
                      child: Text.rich(
                        TextSpan(
                          text: 'Already have an account?',
                          style: AppTextStyles.textBody(),
                          children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => context.pop(),
                                text: ' Sign in',
                                style: AppTextStyles.textBodyItalic(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          )),
    );
  }
}

String? validateName(String? value) {
  if (value!.isEmpty) {
    return "Full Name cannot be Empty";
  }
  if (value.length < 3) {
    return "Enter Valid name (Min. 3 Characters)";
  }
  return null;
}

String? validatePhone(String? value) {
  if (value == null || value.isEmpty) {
    return "Phone number cannot be empty";
  }
  if (!RegExp(r'^\d+$').hasMatch(value)) {
    return "Phone number can only contain digits";
  }
  if (value.length < 10 || value.length > 15) {
    return "Enter a valid phone number (10-15 digits)";
  }
  return null;
}

String? validateEmail(String? value) {
  if (value!.isEmpty) {
    return "Please Enter Your Email";
  }
  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
    return "Please Enter a valid email";
  }
  return null;
}

bool? validatePassword(String? value, String? val2, BuildContext context) {
  if (value == val2) {
    return true;
  } else {
    Utils.flushBarErrorMessage('Password not same', context);
    return false;
  }
}
