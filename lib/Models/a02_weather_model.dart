
import 'dart:convert';

WeatherModel weatherModelFromJson(String str) => WeatherModel.fromJson(json.decode(str));

String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

class WeatherModel {
  Location location;
  CurrentObservation currentObservation;
  List<Forecast> forecasts;

  WeatherModel({
    required this.location,
    required this.currentObservation,
    required this.forecasts,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
    location: Location.fromJson(json["location"]),
    currentObservation: CurrentObservation.fromJson(json["current_observation"]),
    forecasts: List<Forecast>.from(json["forecasts"].map((x) => Forecast.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "location": location.toJson(),
    "current_observation": currentObservation.toJson(),
    "forecasts": List<dynamic>.from(forecasts.map((x) => x.toJson())),
  };
}

class CurrentObservation {
  int pubDate;
  Wind wind;
  Atmosphere atmosphere;
  Astronomy astronomy;
  Condition condition;

  CurrentObservation({
    required this.pubDate,
    required this.wind,
    required this.atmosphere,
    required this.astronomy,
    required this.condition,
  });

  factory CurrentObservation.fromJson(Map<String, dynamic> json) => CurrentObservation(
    pubDate: json["pubDate"],
    wind: Wind.fromJson(json["wind"]),
    atmosphere: Atmosphere.fromJson(json["atmosphere"]),
    astronomy: Astronomy.fromJson(json["astronomy"]),
    condition: Condition.fromJson(json["condition"]),
  );

  Map<String, dynamic> toJson() => {
    "pubDate": pubDate,
    "wind": wind.toJson(),
    "atmosphere": atmosphere.toJson(),
    "astronomy": astronomy.toJson(),
    "condition": condition.toJson(),
  };
}

class Astronomy {
  String sunrise;
  String sunset;

  Astronomy({
    required this.sunrise,
    required this.sunset,
  });

  factory Astronomy.fromJson(Map<String, dynamic> json) => Astronomy(
    sunrise: json["sunrise"],
    sunset: json["sunset"],
  );

  Map<String, dynamic> toJson() => {
    "sunrise": sunrise,
    "sunset": sunset,
  };
}

class Atmosphere {
  int humidity;
  double visibility;
  double pressure;

  Atmosphere({
    required this.humidity,
    required this.visibility,
    required this.pressure,
  });

  factory Atmosphere.fromJson(Map<String, dynamic> json) => Atmosphere(
    humidity: json["humidity"],
    visibility: json["visibility"]?.toDouble(),
    pressure: json["pressure"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "humidity": humidity,
    "visibility": visibility,
    "pressure": pressure,
  };
}

class Condition {
  int temperature;
  String text;
  int code;

  Condition({
    required this.temperature,
    required this.text,
    required this.code,
  });

  factory Condition.fromJson(Map<String, dynamic> json) => Condition(
    temperature: json["temperature"],
    text: json["text"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "temperature": temperature,
    "text": text,
    "code": code,
  };
}

class Wind {
  int chill;
  String direction;
  int speed;

  Wind({
    required this.chill,
    required this.direction,
    required this.speed,
  });

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
    chill: json["chill"],
    direction: json["direction"],
    speed: json["speed"],
  );

  Map<String, dynamic> toJson() => {
    "chill": chill,
    "direction": direction,
    "speed": speed,
  };
}

class Forecast {
  String day;
  int date;
  int high;
  int low;
  String text;
  int code;

  Forecast({
    required this.day,
    required this.date,
    required this.high,
    required this.low,
    required this.text,
    required this.code,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) => Forecast(
    day: json["day"],
    date: json["date"],
    high: json["high"],
    low: json["low"],
    text: json["text"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "date": date,
    "high": high,
    "low": low,
    "text": text,
    "code": code,
  };
}

class Location {
  String city;
  int woeid;
  String country;
  double lat;
  double long;
  String timezoneId;

  Location({
    required this.city,
    required this.woeid,
    required this.country,
    required this.lat,
    required this.long,
    required this.timezoneId,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    city: json["city"],
    woeid: json["woeid"],
    country: json["country"],
    lat: json["lat"]?.toDouble(),
    long: json["long"]?.toDouble(),
    timezoneId: json["timezone_id"],
  );

  Map<String, dynamic> toJson() => {
    "city": city,
    "woeid": woeid,
    "country": country,
    "lat": lat,
    "long": long,
    "timezone_id": timezoneId,
  };
}
