import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/data/constants.dart';
import 'package:todo/core/extensions/build_context_ex.dart';
import 'package:todo/core/extensions/num_ext.dart';
import 'package:todo/core/themes/theme.dart';
import 'package:todo/core/utils/snack_alert.dart';
import 'package:todo/core/utils/validation_mixin.dart';
import 'package:todo/views/layouts/layouts.dart';
import 'package:todo/views/pages/authentication/bloc/auth_bloc.dart';
import 'package:todo/views/pages/main_home/main_home.dart';
import 'package:todo/views/pages/setting/bloc/profile_bloc.dart';
import 'package:todo/views/widgets/app_bars.dart';
import 'package:todo/views/widgets/app_primary_button.dart';
import 'package:todo/views/widgets/app_primary_text_field.dart';
import 'package:todo/views/widgets/social_buttons.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  static const String route = '/register';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with ValidationMixin {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController reEnterPassword = TextEditingController();

  late final AuthBloc _authBloc = context.read<AuthBloc>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void onRegister() {
    if (_formKey.currentState?.validate() ?? false) {
      _authBloc.register(
        name: name.text,
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
      appBar: buildAppBar(context),
      body: BlocListener<AuthBloc, AuthState>(
        bloc: _authBloc,
        listenWhen: (previous, current) => previous.state != current.state,
        listener: (BuildContext context, state) {
          state.onChangeState(
            onRegister: (userInfo) {
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
              Text(
                'Register',
                style: context.textTheme.headlineMedium?.copyWith(
                  fontSize: 32,
                  color: TodoAppThemeData.blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              16.verticalSpace,
              Text(
                'And start taking notes',
                style: context.textTheme.headlineSmall?.copyWith(
                  fontSize: 16,
                  color: TodoAppThemeData.darkGray,
                  fontWeight: FontWeight.w400,
                ),
              ),
              32.verticalSpace,
              AppPrimaryTextField(
                controller: name,
                labelText: 'Full Name',
                hintText: 'Example: John Doe',
                keyboardType: TextInputType.name,
                validator: nameValidator,
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
                validator: passwordValidator,
                obscureText: true,
              ),
              32.verticalSpace,
              AppPrimaryTextField(
                controller: reEnterPassword,
                labelText: 'Retype Password',
                hintText: '********',
                keyboardType: TextInputType.visiblePassword,
                validator: (value) => confirmPasswordValidator(password.text, value),
                obscureText: true,
              ),
              40.verticalSpace,
              AppPrimaryButton(
                label: 'Register',
                onPressed: onRegister,
              ),
              16.verticalSpace,
              const AppSocialLoginButton(),
              32.verticalSpace,
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: context.textTheme.labelMedium?.copyWith(color: TodoAppThemeData.darkGray),
                    children: [
                      TextSpan(
                        text: 'Login here',
                        style: context.textTheme.labelMedium?.copyWith(color: TodoAppThemeData.basePrimary),
                        recognizer: TapGestureRecognizer()..onTap = () => Navigator.pop(context),
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

  buildAppBar(BuildContext context) {
    return BackButtonAppBar(context, backTitle: 'Back to Login');
  }
}
