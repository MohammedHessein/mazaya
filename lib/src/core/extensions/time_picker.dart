import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
 import '../../config/language/locale_keys.g.dart';
import '../../config/res/config_imports.dart';
import 'widgets/sized_box_helper.dart';
import 'text_style_extensions.dart';
import '../navigation/navigator.dart';
import '../widgets/buttons/loading_button.dart';

extension DateTimeFormatHelper on DateTime {
  String get dispalyTimeFormat => DateFormat("hh:mm a", "en_US").format(this);
  String get apiTimeFormat => DateFormat("HH:mm", "en_US").format(this);

  String get dispalyAndApiDateFormat =>
      DateFormat("yyyy-MM-dd", "en_US").format(this);

  bool get checkIsBeforeNow => isBefore(DateTime.now());
  bool get checkIsBeforeNowPlusOneHour =>
      isBefore(DateTime.now().add(const Duration(hours: 1)));

  bool isSameDayOrBefore(DateTime dateTime) {
    return day <= dateTime.day &&
        month <= dateTime.month &&
        year <= dateTime.year;
  }

  bool isSameOrBeforeTime(DateTime dateTime) {
    return hour < dateTime.hour ||
        (hour == dateTime.hour && minute <= dateTime.minute);
  }
}

extension DateTimeOnString on String {
  DateTime get timeFromApi {
    final splitStr = split(' ');
    final date = DateFormat("hh:mm", "en_US").parse(splitStr.first);
    if (splitStr[1].toLowerCase().contains('pm') ||
        splitStr[1].toLowerCase().contains('ev') ||
        splitStr[1].toLowerCase().contains('مسا') ||
        splitStr[1].toLowerCase().contains('م')) {
      return date.copyWith(hour: date.hour + 12);
    } else {
      return date;
    }
  }

  // 12:00:00 for format
  DateTime get timeFromApiFormated {
    return DateFormat("hh:mm:ss", "en_US").parse(this);
  }

  DateTime get dateFromApi {
    return DateFormat("yyyy-MM-dd", "en_US").parse(this);
  }

  String get hoursTimeFromApiFormat {
    if (contains(":")) {
      final hours = DateFormat("hh:mm:ss", "en_US").parse(this).hour.toString();
      final minutes =
          DateFormat("hh:mm:ss", "en_US").parse(this).minute.toString();
      final hasMinuts =
          num.tryParse(minutes) != null && num.tryParse(minutes) != 0;
      return "$hours${!hasMinuts ? "" : ".${(num.tryParse(minutes) ?? 0 / 60).toInt()}"}";
    } else {
      return this;
    }
  }

  String get hoursToTime {
    final str = split('.');
    if (str.length > 1) {
      return "${str.first.padLeft(2, '0')}:${((num.tryParse(str.last) ?? 0) * 60 / 100).toInt().toString().padRight(2, '0')}";
    } else {
      return "${padLeft(2, '0')}:00";
    }
  }
}

class TimePicker {
  static Future<void> timePicker({
    required BuildContext context,
    required String title,
    required Function(DateTime? date) onConfirm,
    DateTime? initialDate,
    DateTime? minDate,
  }) async {
    await _bottomSheet(
      context: context,
      child: CupertinoTimePicker(
        title: title,
        onConfirm: onConfirm,
        initialDate: initialDate,
        minDate: minDate,
      ),
    );
  }

  static String getTimeRemmining({required DateTime date}) {
    // Calculate the difference
    final Duration difference = date.difference(DateTime.now());

    // Format the difference
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final String hours = twoDigits(difference.inHours);
    final String minutes = twoDigits(difference.inMinutes.remainder(60));
    final String seconds = twoDigits(difference.inSeconds.remainder(60));

    return '$hours:$minutes:$seconds';
  }

  static Future _bottomSheet({
    required BuildContext context,
    required Widget child,
  }) {
    return showModalBottomSheet(
      isScrollControlled: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(13.r),
          topRight: Radius.circular(13.r),
        ),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (context) => SizedBox(
        // height: MediaQuery.of(context).size.height * .35,
        child: child,
      ),
    );
  }

  static Future<void> pickDate({
    required BuildContext context,
    required DateTime? value,
    required DateTime minmumDate,
    DateTime? maximumDate,
    String? actionText,
    required String title,
    required Function(DateTime?) onSelectionChanged,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => SingleDatePickerBottomSheet(
        initialDate: value,
        minmumDate: minmumDate,
        maximumDate: maximumDate,
        actionText: actionText ?? LocaleKeys.confirm,
        title: title,
        onSelectionChanged: onSelectionChanged,
      ),
    );
  }
}

class SingleDatePickerBottomSheet extends StatefulWidget {
  const SingleDatePickerBottomSheet({
    super.key,
    required this.onSelectionChanged,
    required this.title,
    required this.actionText,
    required this.initialDate,
    required this.minmumDate,
    required this.maximumDate,
  });
  final void Function(DateTime?) onSelectionChanged;
  final DateTime? initialDate;
  final DateTime? maximumDate;
  final DateTime? minmumDate;
  final String title;
  final String actionText;
  @override
  State<SingleDatePickerBottomSheet> createState() =>
      _SingleDatePickerBottomSheetState();
}

class _SingleDatePickerBottomSheetState
    extends State<SingleDatePickerBottomSheet> {
  late final DateTime minmum = widget.minmumDate?.copyWith(
        hour: 0,
        minute: 0,
        second: 0,
        millisecond: 0,
        microsecond: 0,
      ) ??
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0,
          0, 0);

  late final ValueNotifier<DateTime?> _selectedDate = ValueNotifier(
      (widget.initialDate?.isBefore(minmum) ?? true)
          ? minmum
          : widget.initialDate);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Column(children: [
              16.h.szH,
              Row(
                children: [
                  InkWell(
                    onTap: () => Go.back(),
                    child: const Icon(
                      Icons.close,
                      color: AppColors.black,
                    ),
                  ),
                  8.w.szW,
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle().s16.bold,
                    ),
                  ),
                ],
              ),
              20.w.szW,
              Localizations.override(
                context: context,
                // locale: const Locale("en"),
                child: ValueListenableBuilder(
                  valueListenable: _selectedDate,
                  builder: (context, value, child) {
                    return SizedBox(
                      height: 200.h,
                      child: CupertinoDatePicker(
                        initialDateTime:
                            !(widget.initialDate?.isBefore(minmum) ?? true)
                                ? widget.initialDate
                                : minmum,
                        minimumDate:
                            (widget.initialDate?.isBefore(minmum) ?? false)
                                ? widget.initialDate
                                : minmum,
                        maximumDate: widget.maximumDate,
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (date) {
                          _selectedDate.value = date;
                        },
                      ),
                    );
                  },
                ),
              ),
            ]),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: LoadingButton(
                title: widget.actionText,
                onTap: () async {
                  final date = _selectedDate.value!;
                  Go.back();
                  widget.onSelectionChanged(
                    DateTime(date.year, date.month, date.day),
                  );
                },
              ),
            ),
          ),
          20.h.szH,
        ],
      ),
    );
  }
}

class CupertinoTimePicker extends StatefulWidget {
  const CupertinoTimePicker({
    super.key,
    required this.title,
    required this.onConfirm,
    this.initialDate,
    this.minDate,
  });
  final String title;
  final void Function(DateTime? date) onConfirm;
  final DateTime? initialDate;
  final DateTime? minDate;
  @override
  State<CupertinoTimePicker> createState() => _CupertinoTimePickerState();
}

class _CupertinoTimePickerState extends State<CupertinoTimePicker> {
  @override
  Widget build(BuildContext context) {
    DateTime currentDate = widget.initialDate ?? DateTime.now();
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle().regular.s16.setHintColor,
                ),
              ],
            ),
          ),
          Flexible(
            child: Localizations.override(
              context: context,
              locale: const Locale("en"),
              child: CupertinoDatePicker(
                initialDateTime: widget.initialDate,
                mode: CupertinoDatePickerMode.time,
                minimumDate: widget.minDate,
                onDateTimeChanged: (date) {
                  currentDate = date;
                },
              ),
            ),
          ),
          SafeArea(
            child: LoadingButton(
              title: LocaleKeys.confirm,
              onTap: () async {
                Go.back();
                widget.onConfirm(currentDate);
              },
            ),
          ),
          20.h.szH,
        ],
      ),
    );
  }
}
