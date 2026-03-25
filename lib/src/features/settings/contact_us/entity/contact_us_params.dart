import 'package:flutter/widgets.dart';

import '../../../../core/extensions/form_mixin.dart';
import '../../../../core/shared/cubits/user_cubit/user_cubit.dart';

class ContactUsParams with FormMixin {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    messageController.dispose();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {"text": messageController.text};
    if (UserCubit.instance.isUserLoggedIn) {
      json.addAll({
        "name": UserCubit.instance.user.fullName,
        "phone": UserCubit.instance.user.phoneNumber,
      });
    } else {
      json.addAll({
        "name": fullNameController.text,
        "phone": phoneController.text,
      });
    }

    return json;
  }
}
