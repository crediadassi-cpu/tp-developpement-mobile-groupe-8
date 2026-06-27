class MeteoData {
  final double temperature;
  final int humidite;
  final int weatherCode;
  final String time;

  MeteoData({
    required this.temperature,
    required this.humidite,
    required this.weatherCode,
    required this.time,
  });

  factory MeteoData.fromJson(Map<String, dynamic> json) {
    return MeteoData(
      temperature: (json['temperature_2m'] as num).toDouble(),
      humidite: (json['relative_humidity_2m'] as num).toInt(),
      weatherCode: (json['weathercode'] as num).toInt(),
      time: json['time'],
    );
  }

  String get conditionTexte {
    if (weatherCode == 0) return 'Ensoleille';
    if (weatherCode <= 3) return 'Nuageux';
    if (weatherCode >= 51 && weatherCode <= 67) return 'Pluvieux';
    if (weatherCode >= 80 && weatherCode <= 82) return 'Averses';
    if (weatherCode >= 95) return 'Orageux';
    return 'Variable';
  }

  String get dateFormatee {
    final dateTime = DateTime.parse(time);

    return "Mesure du "
        "${dateTime.day.toString().padLeft(2, '0')}/"
        "${dateTime.month.toString().padLeft(2, '0')}/"
        "${dateTime.year} "
        "${dateTime.hour.toString().padLeft(2, '0')}h";
  }
}