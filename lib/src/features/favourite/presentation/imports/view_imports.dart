import 'package:injectable/injectable.dart';
import 'package:mazaya/src/core/error/failure.dart';
import 'package:mazaya/src/core/widgets/cards/app_card.dart';
import 'package:mazaya/src/core/widgets/tools/pagination/imports/pagination_imports.dart';
import 'package:mazaya/src/features/coupons/entity/coupon_entity.dart';
import 'package:mazaya/src/core/network/api_endpoints.dart';
import 'package:mazaya/src/config/res/config_imports.dart';

import '../../../location/imports/location_imports.dart';

import 'package:mazaya/src/core/navigation/navigator.dart';
import 'package:mazaya/src/features/coupons/presentation/view/coupon_details_screen.dart';
import 'package:mazaya/src/core/utils/favorite_manager.dart';
import 'package:mazaya/src/core/shared/cubits/user_cubit/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../cubits/favourite_cubit.dart';
part '../view/favourite_screen.dart';
part '../widgets/favourite_body.dart';
