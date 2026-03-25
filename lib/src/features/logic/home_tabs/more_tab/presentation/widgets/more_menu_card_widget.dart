part of '../imports/view_imports.dart';

class MoreMenuCardWidget extends StatelessWidget {
  final MoreItemEntity menuItem;

  const MoreMenuCardWidget({super.key, required this.menuItem});

  @override
  Widget build(BuildContext context) {
    context.locale;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.border,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppCircular.r2),
      ),
      margin: EdgeInsets.symmetric(vertical: AppMargin.mH4),
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW10,
        vertical: menuItem.useSwitch
            ? ConstantManager.zeroAsDouble
            : AppPadding.pH6,
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: AppMargin.mW8,
        children: [
          if (menuItem.icon.contains('.svg')) ...[
            SvgPicture.asset(
              menuItem.icon,
              width: AppSize.sH35,
              height: AppSize.sH35,
            ),
          ] else ...[
            Image.asset(
              menuItem.icon,
              width: AppSize.sH35,
              height: AppSize.sH35,
            ),
          ],
          Expanded(
            child: Text(
              menuItem.title,
              style: const TextStyle().setMainTextColor.s13.regular,
            ),
          ),
          if (menuItem.useSwitch) ...[
            const _SwitchNotifyWidget(),
          ] else ...[
            if (!menuItem.disableArrow) ...[
              Transform(
                alignment: Alignment.center,
                transform: context.isRight
                    ? Matrix4.rotationY(math.pi)
                    : Matrix4.rotationX(math.pi),
                child: AppAssets.svg.baseSvg.arrowBack.svg(
                  width: AppSize.sH16,
                  height: AppSize.sH16,
                ),
              ),
            ],
          ],
        ],
      ),
    ).onClick(onTap: menuItem.onTap);
  }
}

class _SwitchNotifyWidget extends StatefulWidget {
  const _SwitchNotifyWidget();

  @override
  State<_SwitchNotifyWidget> createState() => _SwitchNotifyWidgetState();
}

class _SwitchNotifyWidgetState extends State<_SwitchNotifyWidget> {
  final ValueNotifier<bool> switchNotifier = ValueNotifier<bool>(
    UserCubit.instance.user.allowNotify,
  );

  @override
  void dispose() {
    switchNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotifiyCubit(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<NotifiyCubit>();
          return ValueListenableBuilder(
            valueListenable: switchNotifier,
            builder: (context, value, child) {
              return BlocBuilder<NotifiyCubit, AsyncState<BaseModel?>>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(
                      child: LoadingIndicator(color: AppColors.main),
                    );
                  } else {
                    return Switch(
                      value: value,
                      onChanged: (value) async {
                        switchNotifier.value = value;
                        await cubit.switchNotifiy(switchNotifier);
                      },
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
