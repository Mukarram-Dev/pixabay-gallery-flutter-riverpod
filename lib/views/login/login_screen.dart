import 'package:pixabay_gallery/config/assets/image_assets.dart';
import 'package:pixabay_gallery/config/components/custom_button.dart';
import 'package:pixabay_gallery/config/components/custom_dialog_widget.dart';
import 'package:pixabay_gallery/config/components/custom_text_field.dart';
import 'package:pixabay_gallery/config/routes/routes_name.dart';
import 'package:pixabay_gallery/config/theme/colors.dart';
import 'package:pixabay_gallery/config/theme/text_theme_style.dart';
import 'package:pixabay_gallery/utils/gaps.dart';
import 'package:pixabay_gallery/utils/utils.dart';
import 'package:pixabay_gallery/views/login/widgets/password_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final emailFocusNode = useFocusNode();
    final passwordController = useTextEditingController();
    final passwordFocusNode = useFocusNode();

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
                        )),
                    Gaps.verticalGapOf(40),
                    Text(
                      'Hello there 👋',
                      style: AppTextStyles.textHeading(),
                    ),
                    Flexible(
                      child: Text(
                        'Please enter your email and password to logIn.',
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
                            'Email',
                            style: AppTextStyles.textLabel(),
                          ),
                          Gaps.verticalGapOf(5),
                          CustomTextFieldWidget(
                            controller: emailController,
                            textInputType: TextInputType.emailAddress,
                            hintTitle: 'john@gmail.com',
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
                            onFieldSubmitted: (p0) => Utils.fieldFocusChange(
                              context,
                              emailFocusNode,
                              passwordFocusNode,
                            ),
                          ),
                          Gaps.verticalGapOf(20),
                          Text(
                            'Password',
                            style: AppTextStyles.textLabel(),
                          ),
                          Gaps.verticalGapOf(5),
                          PasswordTextFieldWidget(
                            passwordController: passwordController,
                            passwordFocusNode: passwordFocusNode,
                          ),
                        ],
                      ),
                    ),
                    Gaps.verticalGapOf(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text('Forget Password?',
                              style: AppTextStyles.textLabel(
                                  color: AppColors.primaryColor)),
                        ),
                      ],
                    ),
                    Gaps.verticalGapOf(50),
                    CustomButtonWidget(
                      width: double.infinity,
                      height: 60,
                      title: 'Sign in',
                      onPress: () {
                        if (formKey.currentState!.validate()) {
                          CustomDialogWidget.dialogLoading(
                              msg: 'Signing...', context: context);

                          // authController.signInWithEmailAndPassword(
                          //   context,
                          //   emailController.text.trim(),
                          //   passwordController.text.trim(),
                          // );
                        }
                      },
                    ),
                    Gaps.verticalGapOf(15),
                    Align(
                      alignment: Alignment.center,
                      child: Text.rich(
                        TextSpan(
                          text: 'No account?',
                          style: AppTextStyles.textBody(),
                          children: [
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => GoRouter.of(context)
                                      .pushNamed(RouteName.signUpRoute),
                                text: ' Partner with tamam',
                                style: AppTextStyles.textBodyItalic(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor)),
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
