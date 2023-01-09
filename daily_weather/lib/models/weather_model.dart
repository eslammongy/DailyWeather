class WeatherModel {
  int? id;
  int? time;
  int? sunrise;
  int? sunset;
  int? humidity;
  String? description;
  String? iconCode;
  String? main;
  String? cityName;
  double? windSpeed;
  double? temp;
  double? maxTemp;
  double? minTemp;
  List<WeatherModel>? forecast;

  WeatherModel(
      {this.id,
      this.time,
      this.sunrise,
      this.sunset,
      this.humidity,
      this.description,
      this.iconCode,
      this.main,
      this.cityName,
      this.windSpeed,
      this.temp,
      this.maxTemp,
      this.minTemp,
      this.forecast});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    return WeatherModel(
      id: weather['id'],
      time: json['dt'],
      description: weather['description'],
      iconCode: weather['icon'],
      main: weather['main'],
      cityName: json['name'],
      temp: json['main']['temp'],
      maxTemp: json['main']['temp_max'],
      minTemp: json['main']['temp_min'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
    );
  }

  static List<WeatherModel> fromForecastJson(Map<String, dynamic> json) {
    final weathers = <WeatherModel>[];
    for (final item in json['list']) {
      weathers.add(WeatherModel(
        time: item['dt'],
        cityName: item['name'],
        temp: item['main']['temp'],
        maxTemp: item['main']['temp_max'],
        minTemp: item['main']['temp_min'],
        sunrise: item['sys']['sunrise'],
        sunset: item['sys']['sunset'],
        humidity: item['main']['humidity'],
        windSpeed: item['wind']['speed'],
        description: item['weather'][0]['description'],
        main: item['weather'][0]['main'],
      ));
    }
    return weathers;
  }

  @override
  String toString() {
    return "Date $time Temp $temp";
  }
}
