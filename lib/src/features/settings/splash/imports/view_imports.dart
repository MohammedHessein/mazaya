import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/res/assets.gen.dart';
import '../../../../config/res/config_imports.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/navigation/navigator.dart';
import '../../../../core/network/network_service.dart';
import '../../../../core/shared/cubits/user_cubit/user_cubit.dart';
import '../../../logic/home/presentation/imports/view_imports.dart';
import '../../intro/presentation/imports/view_imports.dart';

part '../cubit/splash_state.dart';
part '../cubit/splash_cubit.dart';
part '../screens/splash_screen.dart';
