import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/data/constants.dart';
import 'package:todo/core/extensions/build_context_ex.dart';
import 'package:todo/core/extensions/num_ext.dart';
import 'package:todo/core/themes/theme.dart';
import 'package:todo/core/utils/snack_alert.dart';
import 'package:todo/core/utils/validation_mixin.dart';
import 'package:todo/views/layouts/scrollable_column.dart';
import 'package:todo/views/pages/authentication/bloc/auth_bloc.dart';
import 'package:todo/views/pages/authentication/view/register_page.dart';
import 'package:todo/views/pages/main_home/main_home.dart';
import 'package:todo/views/pages/setting/bloc/profile_bloc.dart';
import 'package:todo/views/widgets/app_primary_button.dart';
import 'package:todo/views/widgets/app_primary_text_field.dart';
import 'package:todo/views/widgets/social_buttons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static const String route = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ValidationMixin {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  late final AuthBloc _authBloc = context.read<AuthBloc>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void onLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      _authBloc.login(
        email: email.text,
        password: password.text,
      );
    }
  }

  @override
  void dispose() {
    _authBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TodoAppThemeData.whiteColor,
      appBar: AppBar(),
      body: BlocListener<AuthBloc, AuthState>(
        bloc: _authBloc,
        listenWhen: (previous, current) => previous.state != current.state,
        listener: (BuildContext context, state) {
          state.onChangeState(
            onLogin: (userInfo) {
              if (userInfo != null) {
                context.read<ProfileBloc>().setUserInfo(userInfo);
              }

              Navigator.pushNamedAndRemoveUntil(
                context,
                MainHomePage.route,
                (route) => false,
              );
            },
            onFailed: (errorState) => SnackAlert.showSnackBar(errorState.error),
          );
        },
        child: Form(
          key: _formKey,
          child: ScrollableColumn.withSafeArea(
            padding: EdgeInsets.all(defaultPaddingValue),
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              91.verticalSpace,
              Text(
                'Let’s Login',
                style: context.textTheme.headlineMedium?.copyWith(
                  fontSize: 32,
                  color: TodoAppThemeData.blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              16.verticalSpace,
              Text(
                'And notes your idea',
                style: context.textTheme.headlineSmall?.copyWith(
                  fontSize: 16,
                  color: TodoAppThemeData.darkGray,
                  fontWeight: FontWeight.w400,
                ),
              ),
              32.verticalSpace,
              AppPrimaryTextField(
                controller: email,
                labelText: 'Email Address',
                hintText: 'Example: johndoe@gmail.com',
                keyboardType: TextInputType.emailAddress,
                validator: emailValidator,
              ),
              32.verticalSpace,
              AppPrimaryTextField(
                controller: password,
                labelText: 'Password',
                hintText: '********',
                keyboardType: TextInputType.visiblePassword,
                validator: signInPasswordValidator,
                obscureText: true,
              ),
              12.verticalSpace,
              Text(
                'Forgot Password',
                style: context.textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  color: TodoAppThemeData.basePrimary,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
              40.verticalSpace,
              AppPrimaryButton(
                label: 'Let’s Get Started',
                onPressed: onLogin,
              ),
              16.verticalSpace,
              const AppSocialLoginButton(),
              32.verticalSpace,
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Don’t have any account? ',
                    style: context.textTheme.labelMedium?.copyWith(color: TodoAppThemeData.darkGray),
                    children: [
                      TextSpan(
                        text: 'Register here',
                        style: context.textTheme.labelMedium?.copyWith(color: TodoAppThemeData.basePrimary),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, RegisterPage.route);
                          },
                      )
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
