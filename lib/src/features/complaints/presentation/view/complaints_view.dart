import 'package:flutter/material.dart';
import 'package:mazaya/src/core/helpers/validators.dart';
import 'package:mazaya/src/core/shared/cubits/user_cubit/user_cubit.dart';
import 'package:mazaya/src/core/widgets/fields/text_fields/app_text_field.dart';
import 'package:mazaya/src/core/widgets/fields/text_fields/field_label.dart';
import 'package:mazaya/src/core/widgets/scaffolds/default_scaffold.dart';
import 'package:mazaya/src/core/widgets/universal_media/enums.dart';
import 'package:mazaya/src/features/complaints/presentation/cubits/complaints_cubit.dart';
import 'package:mazaya/src/features/coupons/presentation/view/view_imports.dart';

import '../../../../core/widgets/scaffolds/header_config.dart';

class ComplaintsView extends StatefulWidget {
  const ComplaintsView({super.key});

  @override
  State<ComplaintsView> createState() => _ComplaintsViewState();
}

class _ComplaintsViewState extends State<ComplaintsView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final user = UserCubit.instance.user;
    _nameController.text = user.name;
    _emailController.text = user.email;
    _phoneController.text = user.mobile;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector<ComplaintsCubit>(),
      child: DefaultScaffold(
        header: HeaderConfig(
          title: LocaleKeys.complaints,
          type: ScaffoldHeaderType.standard,
          showBackButton: false,
        ),
        slivers: [
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: AppPadding.pW20),
            sliver: SliverToBoxAdapter(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.szH,
                    FieldLabel(label: LocaleKeys.name),
                    8.szH,
                    AppTextField(
                      controller: _nameController,
                      hint: LocaleKeys.name,
                      validator: (v) => Validators.validateName(v),
                    ),
                    20.szH,
                    FieldLabel(label: LocaleKeys.email),
                    8.szH,
                    AppTextField(
                      controller: _emailController,
                      hint: LocaleKeys.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) => Validators.validateEmail(v),
                    ),
                    20.szH,
                    FieldLabel(label: LocaleKeys.phoneNumber),
                    8.szH,
                    AppTextField(
                      controller: _phoneController,
                      hint: LocaleKeys.phoneNumber,
                      keyboardType: TextInputType.phone,
                      validator: (v) => Validators.validatePhone(v),
                    ),
                    20.szH,
                    FieldLabel(label: LocaleKeys.messageLabel),
                    8.szH,
                    AppTextField(
                      controller: _messageController,
                      hint: LocaleKeys.messageHint,
                      maxLines: 5,
                      validator: (v) => Validators.validateMessage(v),
                    ),
                    90.szH,
                    BlocBuilder<ComplaintsCubit, AsyncState>(
                      builder: (context, state) {
                        return Center(
                          child: LoadingButton(
                            title: LocaleKeys.sendBtn,
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                await context
                                    .read<ComplaintsCubit>()
                                    .submitComplaint(
                                      name: _nameController.text,
                                      email: _emailController.text,
                                      phone: _phoneController.text,
                                      message: _messageController.text,
                                    );
                              }
                            },
                          ),
                        );
                      },
                    ),
                    40.szH,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
