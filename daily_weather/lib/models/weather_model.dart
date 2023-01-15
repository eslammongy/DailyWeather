class WeatherModel {
  int? id;
  int? time;
  String? dtTxt;
  int? sunrise;
  int? sunset;
  int? pressure;
  int? humidity;
  String? description;
  String? iconCode;
  String? main;
  String? cityName;
  dynamic windSpeed;
  double? temp;
  double? maxTemp;
  double? minTemp;
  List<WeatherModel>? forecast;

  WeatherModel(
      {this.id,
      this.time,
      this.sunrise,
      this.sunset,
      this.pressure,
      this.humidity,
      this.description,
      this.iconCode,
      this.main,
      this.cityName,
      this.windSpeed,
      this.temp,
      this.dtTxt,
      this.maxTemp,
      this.minTemp,
      this.forecast});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    return WeatherModel(
      id: weather['id'],
      time: json['dt'],
      dtTxt: json['dt_txt'],
      description: weather['description'],
      iconCode: weather['icon'],
      main: weather['main'],
      cityName: json['city'],
      temp: json['main']['temp'],
      maxTemp: json['main']['temp_max'],
      minTemp: json['main']['temp_min'],
      sunrise: json['city']['sunrise'],
      pressure: json['main']['pressure'],
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
          dtTxt: item['dt_txt'],
          temp: item['main']['temp'],
          maxTemp: item['main']['temp_max'],
          minTemp: item['main']['temp_min'],
          description: item['weather'][0]['description'],
          main: item['weather'][0]['main'],
          iconCode: item['weather'][0]['icon'],
          humidity: item['main']['humidity'],
          windSpeed: item['wind']['speed'],
          sunrise: json['city']['sunrise'],
          pressure: item['main']['pressure'],
          cityName: json['city']['name']));
    }
    return weathers;
  }
}
