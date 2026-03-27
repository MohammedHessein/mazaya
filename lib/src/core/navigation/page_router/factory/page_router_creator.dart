import 'package:flutter/material.dart';

import 'package:mazaya/src/core/navigation/constants/imports_constants.dart';
import 'package:mazaya/src/core/navigation/helper/interfaces/helper_imports.dart';

abstract class PageRouterCreator {
  Route<T> create<T>(
    Widget page, {
    RouteSettings? settings,
    TransitionType? transition,
    AnimationOption? animationOptions,
  });
}
