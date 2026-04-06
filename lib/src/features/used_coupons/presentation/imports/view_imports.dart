import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:mazaya/src/core/widgets/cards/app_card.dart';
import 'package:mazaya/src/features/coupons/entity/coupon_entity.dart';

import '../../../location/imports/location_imports.dart';
import 'package:mazaya/src/core/network/api_endpoints.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';

import 'package:mazaya/src/features/coupons/presentation/view/coupon_details_screen.dart';
import 'package:mazaya/src/core/navigation/navigator.dart';
import 'package:mazaya/src/core/utils/favorite_manager.dart';

part '../cubits/used_coupons_cubit.dart';
part '../view/used_coupons_screen.dart';
part '../widgets/used_coupons_body.dart';
