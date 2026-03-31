part of '../imports/view_imports.dart';

class ProfileDecorationWidget extends StatelessWidget {
  const ProfileDecorationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ProfileAvatarWidget(),
          20.szH,
          const ProfileInfoWidget(),
        ],
      ),
    );
  }
}
