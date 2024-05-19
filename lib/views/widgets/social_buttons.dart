// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/core/data/app_assets.dart';
import 'package:todo/core/data/constants.dart';
import 'package:todo/core/enums/auth_type.dart';
import 'package:todo/core/extensions/build_context_ex.dart';
import 'package:todo/core/extensions/num_ext.dart';
import 'package:todo/core/themes/theme.dart';
import 'package:todo/core/utils/snack_alert.dart';
import 'package:todo/models/auth_result.dart';
import 'package:todo/models/user_data.dart';
import 'package:todo/repositories/social_auth_repository.dart';
import 'package:todo/repositories/user_repository.dart';
import 'package:todo/views/pages/main_home/main_home.dart';
import 'package:todo/views/pages/setting/bloc/profile_bloc.dart';
import 'package:todo/views/widgets/loading_indicator.dart';

class AppSocialLoginButton extends StatefulWidget {
  const AppSocialLoginButton({super.key});

  @override
  State<AppSocialLoginButton> createState() => _AppSocialLoginButtonState();
}

class _AppSocialLoginButtonState extends State<AppSocialLoginButton> {
  SocialAuthRepository auth = SocialAuthRepository();

  final LoadingIndicator _loader = LoadingIndicator.instance;

  final UserRepository _userRepo = UserRepository();

  Future<void> onContinue(AuthType type) async {
    _loader.show();

    AuthResult? result;

    switch (type) {
      case AuthType.google:
        result = await auth.signInWithGoogle();
        break;
      case AuthType.facebook:
        result = await auth.signInWithFacebook();
        break;
      default:
        break;
    }

    if (result == null) {
      _loader.hide();
      return;
    }

    if (result.status) {
      preferences.uid = result.user?.uid ?? '';

      UserData user = UserData(
        authType: type,
        email: result.user?.email,
        name: result.user?.displayName,
        uid: result.user?.uid,
        createdAt: DateTime.now(),
      );

      UserData? userInfo = await _userRepo.getUserByEmail(result.user?.email);

      if (userInfo == null) {
        preferences.uid = result.user?.uid ?? '';
        await _userRepo.createUser(user);
        context.read<ProfileBloc>().setUserInfo(user);
      } else {
        context.read<ProfileBloc>().setUserInfo(userInfo);
      }

      _loader.hide();

      Navigator.pushReplacementNamed(
        context,
        MainHomePage.route,
      );
    } else {
      _loader.hide();

      SnackAlert.showSnackBar(result.message ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            const Expanded(child: Divider(color: Color(0xffA09F99))),
            const SizedBox(width: 16),
            Text(
              'Or',
              style: context.textTheme.headlineMedium?.copyWith(
                fontSize: 12,
                color: TodoAppThemeData.darkGray,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(child: Divider(color: Color(0xffA09F99))),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(onTap: () => onContinue.call(AuthType.google), icon: AppAssets.google),
            36.horizontalSpace,
            _buildButton(onTap: () => onContinue.call(AuthType.facebook), icon: AppAssets.fb),
          ],
        ),
      ],
    );
  }

  Widget _buildButton({required VoidCallback onTap, required String icon}) {
    return GestureDetector(onTap: onTap, child: SvgPicture.asset(icon));
  }
}
