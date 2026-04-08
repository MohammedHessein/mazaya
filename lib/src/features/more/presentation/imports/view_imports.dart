import 'dart:io';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:injectable/injectable.dart';

import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/assets.gen.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
export 'package:mazaya/src/config/res/config_imports.dart';

import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/get_base_name_and_id/get_base_name_and_id_cubit.dart';
import 'package:mazaya/src/core/extensions/base_state.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/core/extensions/widgets/sized_box_helper.dart';
import 'package:mazaya/src/core/extensions/widgets/widget_extension.dart';
import 'package:mazaya/src/core/helpers/image_helper.dart';
import 'package:mazaya/src/core/helpers/validators.dart';
import 'package:mazaya/src/core/navigation/navigator.dart';
import 'package:mazaya/src/core/network/api_endpoints.dart';
import 'package:mazaya/src/core/shared/cubits/user_cubit/user_cubit.dart';
import 'package:mazaya/src/core/shared/models/base_model.dart';
import 'package:mazaya/src/core/shared/models/user_model.dart';
import 'package:mazaya/src/core/widgets/buttons/action_tile.dart';
import 'package:mazaya/src/core/widgets/buttons/loading_button.dart';
import 'package:mazaya/src/core/widgets/custom_messages.dart';
import 'package:mazaya/src/core/widgets/fields/drop_downs/app_drop_down/app_dropdown.dart';
import 'package:mazaya/src/core/widgets/fields/text_fields/app_text_field.dart';
import 'package:mazaya/src/core/widgets/fields/text_fields/field_label.dart';
import 'package:mazaya/src/core/widgets/fields/text_fields/form_field.dart';
import 'package:mazaya/src/core/widgets/pickers/default_bottom_sheet.dart';
import 'package:mazaya/src/core/widgets/scaffolds/app_header_sliver.dart';
import 'package:mazaya/src/core/widgets/scaffolds/default_scaffold.dart';
import 'package:mazaya/src/core/widgets/scaffolds/header_config.dart';
import 'package:mazaya/src/core/widgets/scaffolds/scaffold_top_row.dart';
import 'package:mazaya/src/core/widgets/universal_media/enums.dart';
import 'package:mazaya/src/core/widgets/tools/bloc_builder/async_bloc_builder.dart';
import 'package:mazaya/src/features/location/presentation/cubits/update_profile_cubit.dart';
import 'package:mazaya/src/features/more/entity/more_menu_item_entity.dart';

import 'package:mazaya/src/core/widgets/icon_widget.dart';
import 'package:mazaya/src/core/widgets/web_view/webview_screen.dart';

import '../cubits/app_setting_cubit.dart';
export '../cubits/app_setting_cubit.dart';
import '../../model/app_setting_model.dart';
export '../../model/app_setting_model.dart';



import '../cubits/logout_cubit.dart';
import '../widgets/logout_bottom_sheet.dart';
import '../widgets/delete_account_bottom_sheet.dart';
export '../widgets/logout_bottom_sheet.dart';
export '../widgets/delete_account_bottom_sheet.dart';

part '../cubits/delete_account_cubit.dart';
part '../cubits/update_photo_cubit.dart';
part '../widgets/membership_card.dart';
part '../widgets/more_menu_card_widget.dart';
part '../widgets/more_tab_body.dart';
part '../widgets/profile_header_sliver.dart';
part '../widgets/profile_avatar_widget.dart';
part '../widgets/profile_info_widget.dart';
part '../widgets/profile_decoration_widget.dart';
part '../widgets/switch_notify_widget.dart';
part '../widgets/update_profile_body.dart';
part '../widgets/update_photo_model_sheet.dart';
part '../view/update_profile_view.dart';
