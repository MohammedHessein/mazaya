import 'package:flutter/animation.dart';

import 'package:mazaya/src/core/navigation/constants/imports_constants.dart';
import 'package:mazaya/src/core/navigation/helper/interfaces/helper_imports.dart';
import 'package:mazaya/src/core/navigation/transition/implementation/rotation/options/rotation_animation_option.dart';

class RotationAnimator extends Animator<double>
    implements TweenBehaviour<double>, CurveBehaviour {
  final RotationAnimationOptions options;

  RotationAnimator(this.options);

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
    final tween = Tween<double>(
      begin: options.begin,
      end: options.end,
    );
    return tween;
  }

  @override
  Animation<double> animator(Animation<double> animation) {
    return setTween().animate(setCurveAnimation(animation));
  }
}
