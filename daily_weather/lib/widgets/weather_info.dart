// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:daily_weather/utils/utils.dart';
import 'package:daily_weather/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:daily_weather/providers/weather_provider.dart';
import 'package:daily_weather/widgets/image_data.dart';
import '../utils/app_colors.dart';

class CurrentWeatherContainer extends StatefulWidget {
  String fetchMethod;
  CurrentWeatherContainer({
    Key? key,
    required this.fetchMethod,
  }) : super(key: key);

  @override
  State<CurrentWeatherContainer> createState() =>
      _CurrentWeatherContainerState();
}

class _CurrentWeatherContainerState extends State<CurrentWeatherContainer> {
  var today = DateTime.now();
  var formattedDate = "Saturday, Jan,12";
  var listOfColors = [
    Colors.amber,
    Colors.purple,
    Colors.deepOrange,
    Colors.green,
    Colors.indigo,
    Colors.amber[700],
    Colors.amber[700],
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var provider = Provider.of<WeatherProvider>(context);

    return FutureBuilder(
      future: widget.fetchMethod == 'UserLocation'
          ? provider.getWeatherInfoByLatLang()
          : provider.getWeatherInfoByCityName(widget.fetchMethod),
      builder: (context, snapshot) {
        var dailyForecast = widget.fetchMethod != 'UserLocation'
            ? provider.listWeatherModel
            : provider.listWeatherModelLatLang;

        if (snapshot.hasError) {
          return CustomErrorWidget(error_msg: snapshot.error.toString());
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Column(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.50,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[850],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dailyForecast[0].cityName ?? 'Cairo',
                      style: TextStyle(color: AppColor.titleBlue, fontSize: 25),
                    ),
                    Text(
                      DateFormat.MMMMEEEEd()
                          .format(DateTime.parse(dailyForecast[0].dtTxt!)),
                      style:
                          const TextStyle(color: AppColor.grey, fontSize: 15),
                    ),
                    Image.asset(getImageCode(dailyForecast[0].iconCode!)),
                    Text(
                      dailyForecast[0].main ?? 'Cloudy',
                      style: TextStyle(color: AppColor.titleBlue, fontSize: 20),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      "${dailyForecast[0].temp!.round().toString()}??C",
                      style: TextStyle(
                          fontSize: 45,
                          color: AppColor.titleBlue,
                          fontWeight: FontWeight.bold),
                    ),
                    // SizedBox(height: size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/h.png',
                          height: 35,
                        ),
                        Text(
                          "${dailyForecast[0].maxTemp!.round().toString()}??C",
                          style: const TextStyle(
                              color: AppColor.grey, fontSize: 18),
                        ),
                        const SizedBox(width: 80),
                        Image.asset(
                          'assets/images/l.png',
                          height: 35,
                        ),
                        Text(
                          '${dailyForecast[0].minTemp!.round().toString()}??C',
                          style: const TextStyle(
                              color: AppColor.grey, fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ImageData(
                          aseetPath: 'assets/images/w.png',
                          data: '${dailyForecast[0].windSpeed!.round()}Km/h',
                          label: 'Wind',
                        ),
                        ImageData(
                          aseetPath: 'assets/images/atmospheric.png',
                          data: '${dailyForecast[0].pressure}hPa',
                          label: 'pressure',
                        ),
                        ImageData(
                          aseetPath: 'assets/images/hu.png',
                          data: '${dailyForecast[0].humidity}%',
                          label: 'Humidity',
                        )
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: ListView.builder(
                    itemCount: dailyForecast.length - 1,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, index) {
                      index += (index == dailyForecast.length - 1) ? 0 : 1;

                      formattedDate = DateFormat.MMMMEEEEd()
                          .format(today.add(Duration(days: index)))
                          .toString();
                      return Container(
                        width: 200,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                            color: Colors.grey[850],
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: listOfColors[index]!, //New
                                blurRadius: 6.0,
                              )
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              formattedDate,
                              style: TextStyle(
                                  color: AppColor.titleBlue, fontSize: 17),
                            ),
                            Image.asset(
                              "assets/images/01d.png",
                              width: 100,
                            ),
                            Text(
                              dailyForecast[index].main ?? 'Cloudy',
                              style: TextStyle(
                                  color: AppColor.titleBlue, fontSize: 20),
                            ),
                            SizedBox(height: size.height * 0.02),
                            Text(
                              "${dailyForecast[index].temp!.round()}??C",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: AppColor.titleBlue,
                                  fontWeight: FontWeight.bold),
                            ),
                            // SizedBox(height: size.height * 0.02),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
