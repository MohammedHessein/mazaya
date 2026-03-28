import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mazaya/src/config/res/assets.gen.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/notification/notification_service.dart';
import 'package:mazaya/src/core/widgets/navigation_bar/navigation_bar.dart';
import 'package:mazaya/src/core/widgets/scaffolds/default_scaffold.dart';
import 'package:mazaya/src/core/widgets/universal_media/enums.dart';
import 'package:mazaya/src/features/coupons/presentation/cubits/coupons_cubit.dart';
import 'package:mazaya/src/features/coupons/presentation/view/coupons_view.dart';
import 'package:mazaya/src/features/home/presentation/view/home_screen.dart';
import 'package:mazaya/src/features/main/entity/main_params.dart';
import 'package:mazaya/src/features/more/presentation/imports/view_imports.dart';

import '../../../../config/language/locale_keys.g.dart';

export '../view/main_screen.dart';
export '../widgets/main_body.dart';
