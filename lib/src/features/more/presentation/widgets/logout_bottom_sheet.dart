import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/assets.gen.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';
import 'package:mazaya/src/core/navigation/navigator.dart';
import 'package:mazaya/src/core/shared/cubits/user_cubit/user_cubit.dart';
import 'package:mazaya/src/core/widgets/buttons/loading_button.dart';
import 'package:mazaya/src/core/widgets/universal_media/universal_media_widget.dart';
import 'package:mazaya/src/features/auth/login/imports/login_imports.dart';

import '../cubits/logout_cubit.dart';

class LogoutBottomSheet extends StatelessWidget {
  const LogoutBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        UniversalMediaWidget(
          path: AppAssets.svg.baseSvg.logoutDialog.path,
          height: 120.h,
          fit: BoxFit.contain,
        ),
        AppSize.sH16.szH,
        Text(LocaleKeys.logoutConfirmation, style: context.textStyle.s18.bold),
        AppSize.sH10.szH,
        Text(
          LocaleKeys.logoutDesc,
          textAlign: TextAlign.center,
          style: context.textStyle.s14.setHintColor,
        ),
        AppSize.sH24.szH,
        Row(
          children: [
            Expanded(
              child: LoadingButton(
                title: LocaleKeys.cancel,
                color: AppColors.lightGray,
                textColor: AppColors.hintText,
                borderSide: const BorderSide(color: AppColors.lightGray),
                onTap: () async => Go.back(),
              ),
            ),
            AppSize.sW10.szW,
            Expanded(
              child: LoadingButton(
                title: LocaleKeys.logoutConfirm,
                color: AppColors.error,
                onTap: () async => await context.read<LogoutCubit>().logout(
                  successEmitter: (data) {
                    UserCubit.instance.logout();
                    Go.offAll(const LoginScreen());
                  },
                ),
              ),
            ),
          ],
        ),
        AppSize.sH10.szH,
      ],
    );
  }
}
