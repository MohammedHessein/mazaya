part of '../imports/view_imports.dart';

class UpdateProfilePhoneFields extends StatelessWidget {
  const UpdateProfilePhoneFields({
    super.key,
    required this.mobileController,
    required this.countryCodeController,
    required this.pickedCountryCode,
    required this.onCountryPickerTap,
  });

  final TextEditingController mobileController;
  final TextEditingController countryCodeController;
  final CountryCode? pickedCountryCode;
  final VoidCallback onCountryPickerTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FieldLabel(label: LocaleKeys.phoneNumber),
              8.szH,
              AppTextField(
                controller: mobileController,
                hint: LocaleKeys.phoneNumber,
                keyboardType: TextInputType.phone,
                validator: (v) => Validators.validatePhone(
                  v,
                  fieldTitle: LocaleKeys.phoneNumber,
                ),
              ),
            ],
          ),
        ),
        15.szW,
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FieldLabel(label: LocaleKeys.countryCode),
              8.szH,
              GestureDetector(
                onTap: onCountryPickerTap,
                child: Container(
                  height: 60.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.border,
                      width: 0.5,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x14000000),
                        offset: Offset(0, 4),
                        blurRadius: 124,
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      if (pickedCountryCode != null) ...[
                        pickedCountryCode!.flagImage(width: 24.w),
                        8.szW,
                        Expanded(
                          child: Text(
                            pickedCountryCode!.localize(context).name,
                            style: context.textStyle.s14.medium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        10.szW,
                        Text(
                          pickedCountryCode!.dialCode,
                          style: context.textStyle.s14.bold,
                        ),
                      ] else if (countryCodeController.text.isNotEmpty) ...[
                        // Fallback if CountryCode search failed but we have a code
                        Text(
                          countryCodeController.text
                              .replaceAll('+', '')
                              .toFlagEmoji,
                          style: context.textStyle.s18,
                        ),
                        8.szW,
                        Text(
                          countryCodeController.text,
                          style: context.textStyle.s14.bold,
                        ),
                      ] else ...[
                        Text(
                          LocaleKeys.enterCountryCode,
                          style: context.textStyle.s14.medium.copyWith(
                            color: AppColors.placeholder,
                          ),
                        ),
                      ],
                      10.szW,
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.primary,
                        size: 18.sp,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
