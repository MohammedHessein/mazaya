part of '../imports/view_imports.dart';

class SwitchNotifyWidget extends StatefulWidget {
  const SwitchNotifyWidget({super.key});

  @override
  State<SwitchNotifyWidget> createState() => SwitchNotifyWidgetState();
}

class SwitchNotifyWidgetState extends State<SwitchNotifyWidget> {
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
    return Builder(
      builder: (context) {
        return ValueListenableBuilder(
          valueListenable: switchNotifier,
          builder: (context, value, child) {
            return Transform.rotate(
              angle: context.isArabic ? math.pi : 0,
              child: Switch(
                value: value,
                onChanged: (value) async {
                  switchNotifier.value = value;
                  // await cubit.switchNotify(switchNotifier);
                },
              ),
            );
          },
        );
      },
    );
  }
}
