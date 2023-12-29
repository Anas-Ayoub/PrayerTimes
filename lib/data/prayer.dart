class PrayerTimings {
  final int code;
  final String status;
  final List<PrayerData> data;

  PrayerTimings({required this.code, required this.status, required this.data});

  factory PrayerTimings.fromJson(Map<String, dynamic> json) {
    return PrayerTimings(
      code: json['code'],
      status: json['status'],
      data: (json['data'] as List)
          .map((data) => PrayerData.fromJson(data))
          .toList(),
    );
  }
}

class PrayerData {
  final Map<String, String> timings;
  final PrayerDate date;
  final PrayerMeta meta;

  PrayerData({required this.timings, required this.date, required this.meta});

  factory PrayerData.fromJson(Map<String, dynamic> json) {
    return PrayerData(
      timings: (json['timings'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value as String)),
      date: PrayerDate.fromJson(json['date']),
      meta: PrayerMeta.fromJson(json['meta']),
    );
  }
}

class PrayerDate {
  final String readable;
  final String timestamp;
  final Gregorian gregorian;
  final Hijri hijri;

  PrayerDate({
    required this.readable,
    required this.timestamp,
    required this.gregorian,
    required this.hijri,
  });

  factory PrayerDate.fromJson(Map<String, dynamic> json) {
    return PrayerDate(
      readable: json['readable'],
      timestamp: json['timestamp'],
      gregorian: Gregorian.fromJson(json['gregorian']),
      hijri: Hijri.fromJson(json['hijri']),
    );
  }
}

class Gregorian {
  final String date;
  final String format;
  final String day;
  final Map<String, String> weekday;
  final Month month;
  final String year;
  final Designation designation;

  Gregorian({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
  });

  factory Gregorian.fromJson(Map<String, dynamic> json) {
    return Gregorian(
      date: json['date'],
      format: json['format'],
      day: json['day'],
      weekday: (json['weekday'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value as String)),
      month: Month.fromJson(json['month']),
      year: json['year'],
      designation: Designation.fromJson(json['designation']),
    );
  }
}

class Month {
  final int number;
  final String en;
  final String? ar; // Add this property

  Month({required this.number, required this.en, required this.ar});

  factory Month.fromJson(Map<String, dynamic> json) {
    return Month(
      number: json['number'],
      en: json['en'],
      ar: json['ar'],
    );
  }
}

class Designation {
  final String abbreviated;
  final String expanded;

  Designation({required this.abbreviated, required this.expanded});

  factory Designation.fromJson(Map<String, dynamic> json) {
    return Designation(
      abbreviated: json['abbreviated'],
      expanded: json['expanded'],
    );
  }
}

class Hijri {
  final String date;
  final String format;
  final String day;
  final Map<String, String> weekday;
  final Month month;
  final String year;
  final Designation designation;
  final List<dynamic> holidays;

  Hijri({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
    required this.holidays,
  });

  factory Hijri.fromJson(Map<String, dynamic> json) {
    return Hijri(
      date: json['date'],
      format: json['format'],
      day: json['day'],
      weekday: (json['weekday'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value as String)),
      month: Month.fromJson(json['month']),
      year: json['year'],
      designation: Designation.fromJson(json['designation']),
      holidays: json['holidays'],
    );
  }
}

class PrayerMeta {
  final double latitude;
  final double longitude;
  final String timezone;
  final PrayerMethod method;
  final String latitudeAdjustmentMethod;
  final String midnightMode;
  final String school;
  final Map<String, int> offset;

  PrayerMeta({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.method,
    required this.latitudeAdjustmentMethod,
    required this.midnightMode,
    required this.school,
    required this.offset,
  });

  factory PrayerMeta.fromJson(Map<String, dynamic> json) {
    return PrayerMeta(
      latitude: json['latitude'],
      longitude: json['longitude'],
      timezone: json['timezone'],
      method: PrayerMethod.fromJson(json['method']),
      latitudeAdjustmentMethod: json['latitudeAdjustmentMethod'],
      midnightMode: json['midnightMode'],
      school: json['school'],
      offset: (json['offset'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value as int)),
    );
  }
}

class PrayerMethod {
  final int id;
  final String name;
  final Map<String, int> params;
  final PrayerLocation location;

  PrayerMethod({
    required this.id,
    required this.name,
    required this.params,
    required this.location,
  });

  factory PrayerMethod.fromJson(Map<String, dynamic> json) {
    return PrayerMethod(
      id: json['id'],
      name: json['name'],
      params: (json['params'] as Map<String, dynamic>)
          .map((key, value) => MapEntry(key, value as int)),
      location: PrayerLocation.fromJson(json['location']),
    );
  }
}

class PrayerLocation {
  final double latitude;
  final double longitude;

  PrayerLocation({required this.latitude, required this.longitude});

  factory PrayerLocation.fromJson(Map<String, dynamic> json) {
    return PrayerLocation(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
