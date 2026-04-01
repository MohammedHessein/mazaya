import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mazaya/src/core/shared/cubits/user_cubit/user_cubit.dart';
import 'package:mazaya/src/core/widgets/universal_media/universal_media_widget.dart';
import 'package:mazaya/src/features/location/imports/location_imports.dart';

import '../../../auth/login/imports/login_imports.dart';
import '../../../settings/presentation/imports/view_imports.dart';

class DeleteAccountBottomSheet extends StatelessWidget {
  const DeleteAccountBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        UniversalMediaWidget(
          path: AppAssets.svg.baseSvg.deleteAccount.path,
          height: 120.h,
          fit: BoxFit.contain,
        ),
        Text(
          LocaleKeys.deleteAccountConfirmation,
          style: context.textStyle.s18.bold,
        ),
        10.szH,
        Text(
          LocaleKeys.deleteAccountDesc,
          textAlign: TextAlign.center,
          style: context.textStyle.s14.setHintColor,
        ),
        24.szH,
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
            10.szW,
            Expanded(
              child: LoadingButton(
                title: LocaleKeys.deleteAccountConfirm,
                color: AppColors.error,
                onTap: () async =>
                    context.read<DeleteAccountCubit>().deleteAccount(
                      successEmitter: (data) {
                        UserCubit.instance.logout(clearOnboarding: true);
                        Go.offAll(const LoginScreen());
                      },
                    ),
              ),
            ),
          ],
        ),
        10.szH,
      ],
    );
  }
}
