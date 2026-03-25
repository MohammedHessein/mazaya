import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../config/language/locale_keys.g.dart' show LocaleKeys;
import '../../../../../config/res/assets.gen.dart';
import '../../../../../config/res/config_imports.dart';
import '../../../../../core/base_crud/code/domain/base_domain_imports.dart';
import '../../../../../core/widgets/scaffolds/default_scaffold.dart';
import '../../../../../core/widgets/tools/bloc_builder/async_bloc_builder.dart';
import '../../entity/faqs.dart';
import '../../../../../core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import '../../../../../core/extensions/text_style_extensions.dart';
import '../../../../../core/network/api_endpoints.dart';

part '../view/faqs_view.dart';
part '../widgets/faqs_body.dart';
part '../widgets/faq_card_widget.dart';
part '../cubits/faqs_cubit.dart';
