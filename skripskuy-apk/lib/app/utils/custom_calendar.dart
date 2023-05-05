import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

DateTime kFirstDay = DateTime(1970, 1, 1);
DateTime kLastDay = DateTime(2100, 1, 1);

extension DateTimeExtension on DateTime {
  DateTime get startOfDay => DateTime(year, month, day);

  DateTime get endOfDay => DateTime(year, month, day, 23, 59);
}

bool isSameDay(DateTime a, DateTime b) {
  if (a == null || b == null) {
    return false;
  }
  return a.year == b.year && a.month == b.month && a.day == b.day;
}

bool isSameMonth(DateTime a, DateTime b) {
  if (a == null || b == null) {
    return false;
  }
  return a.year == b.year && a.month == b.month;
}

class CustomCalendar extends StatelessWidget {
  const CustomCalendar({
    @required this.color,
    this.onChange,
    this.initialDate,
    this.weekFormat = false,
    this.weekStartsMonday = false,
    this.iconColor,
    this.dateStyle,
    this.dayOfWeekStyle,
    this.inactiveDateStyle,
    this.selectedDateStyle,
    this.titleStyle,
    this.locale,
    Key key,
  }) : super(key: key);

  final bool weekFormat;
  final bool weekStartsMonday;
  final Color color;
  final void Function(DateTimeRange) onChange;
  final DateTime initialDate;
  final Color iconColor;
  final TextStyle dateStyle;
  final TextStyle dayOfWeekStyle;
  final TextStyle inactiveDateStyle;
  final TextStyle selectedDateStyle;
  final TextStyle titleStyle;
  final String locale;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomCalendarController>(
        init: CustomCalendarController(
          this.weekFormat,
          this.weekStartsMonday,
          this.color,
          this.onChange,
          this.initialDate,
          this.iconColor,
          this.dateStyle,
          this.dayOfWeekStyle,
          this.inactiveDateStyle,
          this.selectedDateStyle,
          this.titleStyle,
          this.locale,
        ),
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CalendarHeader(
                focusedDay: controller.focusedDay,
                onLeftChevronTap: () =>
                    controller.calendarController.previousPage(),
                onRightChevronTap: () =>
                    controller.calendarController.nextPage(),
                onTodayButtonTap: () {
                  if (!controller.calendarController.visibleDays.any(
                    controller.calendarController.isToday,
                  )) {
                    controller.calendarController.setFocusedDay(DateTime.now());
                    controller.focusedDay = DateTime.now();
                  }
                  ;
                },
                titleStyle: controller.titleStyle,
                iconColor: controller.iconColor,
                locale: controller.locale,
              ),
              TableCalendar(
                calendarController: controller.calendarController,
                startDay: kFirstDay,
                endDay: kLastDay,
                initialCalendarFormat: controller.calendarFormat,
                headerVisible: false,
                locale: controller.locale,
                calendarStyle: CalendarStyle(
                  weekdayStyle: controller.dateStyle,
                  weekendStyle: controller.dateStyle,
                  holidayStyle: controller.dateStyle,
                  eventDayStyle: controller.dateStyle,
                  selectedStyle:
                      const TextStyle(color: Color(0xFFFAFAFA), fontSize: 16.0)
                          .merge(controller.selectedDateStyle),
                  todayStyle:
                      const TextStyle(color: Color(0xFFFAFAFA), fontSize: 16.0)
                          .merge(controller.selectedDateStyle),
                  unavailableStyle: const TextStyle(color: Color(0xFF9E9E9E))
                      .merge(controller.inactiveDateStyle),
                  outsideStyle: const TextStyle(color: Color(0xFF9E9E9E))
                      .merge(controller.inactiveDateStyle),
                  outsideWeekendStyle: const TextStyle(color: Color(0xFF9E9E9E))
                      .merge(controller.inactiveDateStyle),
                  outsideHolidayStyle: const TextStyle(color: Color(0xFF9E9E9E))
                      .merge(controller.inactiveDateStyle),
                  selectedColor: color,
                  todayColor: controller.getlightColor,
                  markersColor: controller.getlightColor,
                  markersMaxAmount: 3,
                  canEventMarkersOverflow: true,
                ),
                availableGestures: AvailableGestures.horizontalSwipe,
                startingDayOfWeek: controller.startingDayOfWeek,
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: const TextStyle(color: Color(0xFF616161))
                      .merge(controller.dayOfWeekStyle),
                  weekendStyle: const TextStyle(color: Color(0xFF616161))
                      .merge(controller.dayOfWeekStyle),
                ),
                holidays: const {},
                onDaySelected: (newSelectedDay, _, __) {
                  if (!isSameDay(
                      controller.selectedDay?.start, newSelectedDay)) {
                    controller.setSelectedDay(newSelectedDay);
                    if (!isSameMonth(controller.focusedDay, newSelectedDay)) {
                      newSelectedDay.isAfter(controller.focusedDay)
                          ? controller.calendarController.nextPage()
                          : controller.calendarController.previousPage();
                      controller.focusedDay = newSelectedDay;
                      controller.calendarController
                          .setFocusedDay(newSelectedDay);
                    }
                    ;
                  }
                },
                onVisibleDaysChanged: (start, end, format) {
                  controller.focusedDay = start.add(end.difference(start) ~/ 2);
                  controller.calendarController
                      .setFocusedDay(controller.focusedDay);
                },
              ),
            ],
          );
        });
  }
}

class CustomCalendarController extends GetxController {
  final bool weekFormat;
  final bool weekStartsMonday;
  final Color color;
  final void Function(DateTimeRange) onChange;
  final DateTime initialDate;
  final Color iconColor;
  final TextStyle dateStyle;
  final TextStyle dayOfWeekStyle;
  final TextStyle inactiveDateStyle;
  final TextStyle selectedDateStyle;
  final TextStyle titleStyle;
  final String locale;

  static const Cubic pageAnimationCurve = Curves.easeInOut;
  static const Duration pageAnimationDuration = Duration(milliseconds: 350);

  DateTime focusedDay;
  DateTimeRange selectedDay;
  CalendarController calendarController;

  CustomCalendarController(
    this.weekFormat,
    this.weekStartsMonday,
    this.color,
    this.onChange,
    this.initialDate,
    this.iconColor,
    this.dateStyle,
    this.dayOfWeekStyle,
    this.inactiveDateStyle,
    this.selectedDateStyle,
    this.titleStyle,
    this.locale,
  );

  CalendarFormat get calendarFormat =>
      weekFormat ? CalendarFormat.week : CalendarFormat.month;

  StartingDayOfWeek get startingDayOfWeek =>
      weekStartsMonday ? StartingDayOfWeek.monday : StartingDayOfWeek.sunday;

  Color get getColor => color;

  Color get getlightColor => color.withOpacity(0.85);

  Color get getlighterColor => color.withOpacity(0.60);

  void setSelectedDay(
    DateTime newSelectedDay, [
    DateTime newSelectedEnd,
  ]) {
    final newRange = newSelectedDay == null
        ? null
        : DateTimeRange(
            start: newSelectedDay.startOfDay,
            end: newSelectedEnd ?? newSelectedDay.endOfDay,
          );
    selectedDay = newRange;
    calendarController.setSelectedDay(newSelectedDay);
    onChange.call(newRange);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    focusedDay = initialDate ?? DateTime.now();
    selectedDay = DateTimeRange(
      start: initialDate?.startOfDay ?? DateTime.now().startOfDay,
      end: initialDate?.endOfDay ?? DateTime.now().endOfDay,
    );
    calendarController = CalendarController();
    SchedulerBinding.instance
        .addPostFrameCallback((_) => setSelectedDay(selectedDay.start));
  }
}

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({
    @required this.focusedDay,
    @required this.onLeftChevronTap,
    @required this.onRightChevronTap,
    @required this.onTodayButtonTap,
    this.iconColor,
    this.clearButtonVisible = false,
    this.onClearButtonTap,
    this.titleStyle,
    this.locale,
    Key key,
  }) : super(key: key);

  final bool clearButtonVisible;
  final DateTime focusedDay;
  final VoidCallback onClearButtonTap;
  final VoidCallback onLeftChevronTap;
  final VoidCallback onRightChevronTap;
  final VoidCallback onTodayButtonTap;
  final Color iconColor;
  final TextStyle titleStyle;
  final String locale;

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(),
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                DateFormat.yMMMM(locale).format(focusedDay),
                style: const TextStyle(fontSize: 17).merge(titleStyle),
              ),
            ),
            if (clearButtonVisible)
              CustomCalendarIconButton(
                icon: Icon(Icons.clear, color: iconColor),
                onTap: onClearButtonTap,
              ),
            CustomCalendarIconButton(
              icon: Icon(Icons.calendar_today, color: iconColor),
              onTap: onTodayButtonTap,
            ),
            CustomCalendarIconButton(
              icon: Icon(Icons.chevron_left, color: iconColor),
              onTap: onLeftChevronTap,
            ),
            CustomCalendarIconButton(
              icon: Icon(Icons.chevron_right, color: iconColor),
              onTap: onRightChevronTap,
            ),
          ],
        ),
      );
}

class CustomCalendarIconButton extends StatelessWidget {
  const CustomCalendarIconButton({
    @required this.icon,
    this.onTap,
    this.margin = const EdgeInsets.symmetric(horizontal: 4),
    this.padding = const EdgeInsets.all(10),
    Key key,
  }) : super(key: key);

  final Icon icon;
  final VoidCallback onTap;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => Padding(
        padding: margin,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(100),
          child: Padding(
            padding: padding,
            child: Icon(
              icon.icon,
              color: icon.color,
              size: icon.size,
            ),
          ),
        ),
      );
}
