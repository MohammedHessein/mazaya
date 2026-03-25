 import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../config/language/locale_keys.g.dart';
import '../../../../../config/res/assets.gen.dart';
import '../../../../../config/res/config_imports.dart';
import '../../../../../core/base_crud/code/domain/base_domain_imports.dart';
import '../../../../../core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import '../../../../../core/error/failure.dart';
import '../../../../../core/extensions/base_state.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/extensions/text_style_extensions.dart';
import '../../../../../core/extensions/widgets/sized_box_helper.dart';
import '../../../../../core/extensions/widgets/widget_extension.dart';
import '../../../../../core/navigation/navigator.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../../../../core/shared/models/base_model.dart';
import '../../../../../core/widgets/buttons/loading_button.dart';
import '../../../../../core/widgets/custom_messages.dart';
import '../../../../../core/widgets/handling_views/empty_widget.dart';
import '../../../../../core/widgets/pickers/default_bottom_sheet.dart';
import '../../../../../core/widgets/scaffolds/default_scaffold.dart'
    show DefaultScaffold;
import '../../../../../core/widgets/tools/pagination/imports/pagination_imports.dart';
import '../../entity/notification_entity.dart';
import '../../../../../core/notification/notification_service.dart';

part '../view/notifications_screen.dart';
part '../widgets/notification_body.dart';
part '../widgets/notification_card_widget.dart';

part '../cubits/delete_notification_cubit.dart';
part '../cubits/notifications_cubit.dart';

part '../widgets/dialogs/delete_notifications.dart';
