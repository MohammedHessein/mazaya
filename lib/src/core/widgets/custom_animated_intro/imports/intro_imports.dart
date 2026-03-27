import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';

import 'package:mazaya/src/config/language/languages.dart';
import 'package:mazaya/src/config/language/locale_keys.g.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/features/main/presentation/imports/view_imports.dart';
import 'package:mazaya/src/core/extensions/context_extension.dart';
import 'package:mazaya/src/core/extensions/text_style_extensions.dart';
import 'package:mazaya/src/core/navigation/navigator.dart';
import 'package:mazaya/src/core/widgets/buttons/default_button.dart';

part '../intro_carousel_widget.dart.dart';
part '../intro_component_widget.dart';
part '../intro_section_widget.dart';
part '../models/intro_dto.dart';
part '../operations/intro_clipper.dart';
part '../operations/intro_edge_operation.dart';
