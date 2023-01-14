// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:daily_weather/models/weather_model.dart';
import 'package:daily_weather/providers/weather_provider.dart';
import 'package:daily_weather/widgets/image_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../utils/app_colors.dart';

class CurrentWeatherContainer extends StatefulWidget {
  const CurrentWeatherContainer({super.key});

  @override
  State<CurrentWeatherContainer> createState() =>
      _CurrentWeatherContainerState();
}

class _CurrentWeatherContainerState extends State<CurrentWeatherContainer> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var provider = Provider.of<WeatherProvider>(context);

    return FutureBuilder(
      future: provider.getWeatherInfo(),
      builder: (context, snapshot) {
        var dailyForecast = provider.weatherModels;
        if (snapshot.hasError) {
          return const Center(
            child: Text("Opps! Try again later!"),
          );
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
                  color: AppColor.snowWhite,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dailyForecast[0].cityName ?? 'Cairo',
                      style: const TextStyle(
                          color: AppColor.lightBlack, fontSize: 22),
                    ),
                    Text(
                      DateFormat.MMMMEEEEd()
                          .format(DateTime.parse(dailyForecast[0].dtTxt!)),
                      style:
                          const TextStyle(color: AppColor.grey, fontSize: 15),
                    ),
                    Image.asset('assets/images/02n.png'),
                    Text(
                      dailyForecast[0].main ?? 'Cloudy',
                      style: const TextStyle(
                          color: AppColor.lightBlack, fontSize: 20),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      "${dailyForecast[0].temp!.round().toString()}ºC",
                      style:
                          TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
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
                          "${dailyForecast[0].maxTemp!.round().toString()}ºC",
                          style: const TextStyle(
                              color: AppColor.grey, fontSize: 18),
                        ),
                        const SizedBox(width: 40),
                        Image.asset(
                          'assets/images/l.png',
                          height: 35,
                        ),
                        Text(
                          '${dailyForecast[0].minTemp!.round().toString()}ºC',
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
                          data: '${dailyForecast[0].windSpeed.toString()}Km/h',
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
                child: ListView.builder(
                  itemCount: 6,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, index) {
                    var date = DateTime.fromMillisecondsSinceEpoch(
                        dailyForecast[index].time! * 1000);
                    var formattedDate = DateFormat.MMMMEEEEd().format(date);

                    return Container(
                      width: 200,
                      height: size.height * 0.35,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(31, 162, 162, 162),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            formattedDate,
                            style: const TextStyle(
                                color: AppColor.lightBlack, fontSize: 15),
                          ),
                          Image.asset(
                            'assets/images/02n.png',
                            width: 100,
                          ),
                          Text(
                            dailyForecast[index].main ?? 'Cloudy',
                            style: const TextStyle(
                                color: AppColor.lightBlack, fontSize: 20),
                          ),
                          SizedBox(height: size.height * 0.02),
                          Text(
                            "${dailyForecast[index].temp!.round()}ºC",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          // SizedBox(height: size.height * 0.02),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
