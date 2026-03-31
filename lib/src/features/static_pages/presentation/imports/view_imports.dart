import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mazaya/src/config/res/config_imports.dart';
import 'package:mazaya/src/core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import 'package:mazaya/src/core/base_crud/code/domain/base_domain_imports.dart';
import 'package:mazaya/src/core/widgets/custom_html_widget.dart';
import 'package:mazaya/src/core/widgets/scaffolds/default_scaffold.dart';
import 'package:mazaya/src/core/widgets/scaffolds/header_config.dart';
import 'package:mazaya/src/core/widgets/tools/bloc_builder/async_bloc_builder.dart';
import 'package:mazaya/src/features/static_pages/entity/static_pages_enum.dart';

part '../view/static_pages_screen.dart';
part '../widgets/static_pages_body.dart';
part '../cubits/static_pages_cubit.dart';
