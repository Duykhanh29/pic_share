import 'package:intl/intl.dart';

class DateUtils {
  static String formatDate(String? inputDate, {String? format = 'dd/MM/yyyy'}) {
    // Parse the input date string into a DateTime object
    DateTime? parsedDate = DateTime.tryParse(inputDate ?? '');

    if (parsedDate == null) return '';

    // Create a DateFormat for the desired output format
    DateFormat outputFormat = DateFormat(format);

    // Format the DateTime into the desired format
    String formattedDate = outputFormat.format(parsedDate);

    return formattedDate;
  }

  static DateTime timeStringToDateTime(String time) {
    return DateFormat('hh:mm').parse(time);
  }

  static String dateToDateAndTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  static String dateToDateAndTime2(DateTime dateTime) {
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }

  static String convertDateToDateString(DateTime dateTime) {
    return DateFormat.yMd().format(dateTime);
  }

  static convertDateTimeToHourString(DateTime dateTime) {
    return DateFormat.j().format(dateTime);
  }

  static String isoStringToLocalString(String dateTime) {
    return DateFormat('yyyy-MM-dd HH:mm:ss')
        .format(DateTime.parse(dateTime).toLocal());
  }

  static String stringToLocalDateOnly(String dateTime) {
    return DateFormat('dd MMM yyyy')
        .format(DateFormat('yyyy-MM-dd').parse(dateTime));
  }

  static DateTime convertStringTimeToDate(String time) {
    return DateFormat('HH:mm').parse(time);
  }

  static String _timeFormatter() {
    return 'hh:mm';
  }

  static String localDateToIsoStringAMPM(DateTime dateTime) {
    return DateFormat('d MMM, yyyy ${_timeFormatter()}')
        .format(dateTime.toLocal());
  }

  static String localToIsoString(DateTime dateTime) {
    return DateFormat('d MMMM, yyyy ').format(dateTime.toLocal());
  }

  static String customTime(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime justNow = now.subtract(const Duration(minutes: 1));
    DateTime localDateTime = dateTime.toLocal();

    if (!localDateTime.difference(justNow).isNegative) {
      return 'just now';
    }

    String roughTimeString = DateFormat('jm').format(dateTime);

    if (localDateTime.day == now.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return roughTimeString;
    }

    DateTime yesterday = now.subtract(const Duration(days: 1));

    if (localDateTime.day == yesterday.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return 'yesterday';
    }

    if (now.difference(localDateTime).inDays < 4) {
      String weekday = DateFormat('EEEE').format(dateTime.toLocal());

      return weekday;
    }

    return localDateToIsoStringAMPM(dateTime);
  }

  static String formatDateTimeToString(String time) {
    DateTime dateTime = DateTime.parse(time).toLocal();
    DateTime now = DateTime.now().toLocal();

    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      return DateFormat('HH:mm').format(dateTime);
    } else {
      return DateFormat('HH:mm dd/MM/yyyy').format(dateTime);
    }
  }

  static String formatDateTimeToDateString(String time) {
    DateTime dateTime = DateTime.parse(time).toLocal();
    DateTime now = DateTime.now().toLocal();

    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      return DateFormat('HH:mm').format(dateTime);
    } else {
      return DateFormat('dd/MM/yyyy').format(dateTime);
    }
  }

  static String chatTime(DateTime time) {
    if (time.day == DateTime.now().day) {
      return DateFormat.jm().format(time);
    } else {
      return DateFormat.yMd().format(time);
    }
  }

  static DateTime intToDateTime(int millisecondsSinceEpoch) {
    return DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
  }

  static DateTime intSecondsToDateTime(int secondsSinceEpoch) {
    return DateTime.fromMillisecondsSinceEpoch(secondsSinceEpoch * 1000);
  }

  static String getStringCurrentTimeInHourAndMinutes() {
    return DateFormat.Hm().format(DateTime.now());
  }

  static DateTime convertStringToDateTime(String? date) {
    return date == null
        ? DateTime.now().toLocal()
        : DateTime.parse(date).toLocal();
  }

  static String stringToDate(String dateTime) {
    return DateFormat.yMd().format(DateTime.parse(dateTime));
  }
}
