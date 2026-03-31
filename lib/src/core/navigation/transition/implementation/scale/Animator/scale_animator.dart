import 'package:flutter/animation.dart';

import 'package:mazaya/src/core/navigation/constants/imports_constants.dart';
import 'package:mazaya/src/core/navigation/helper/interfaces/helper_imports.dart';
import 'package:mazaya/src/core/navigation/transition/implementation/scale/options/scale_animation_option.dart';

class ScaleAnimator extends Animator<double>
    implements CurveBehaviour, TweenBehaviour<double> {
  final ScaleAnimationOptions options;

  ScaleAnimator(this.options);

  @override
  CurvedAnimation setCurveAnimation(Animation<double> animation) {
    return CurvedAnimation(
      parent: animation,
      curve: options.curve ?? RouterConstants.transitionCurve,
      reverseCurve:
          options.reverseCurve ?? RouterConstants.reverseTransitionCurve,
    );
  }

  @override
  Tween<double> setTween() {
    return Tween<double>(begin: options.begin, end: options.end);
  }

  @override
  Animation<double> animator(Animation<double> animation) {
    return setTween().animate(setCurveAnimation(animation));
  }
}
