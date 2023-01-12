// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:daily_weather/models/weather_model.dart';
import 'package:daily_weather/providers/weather_provider.dart';
import 'package:daily_weather/widgets/image_data.dart';
import 'package:flutter/material.dart';
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
  void initState() {
    super.initState();
    //getCurrentWeatherInfo();
  }

  getCurrentWeatherInfo() async {
    await Provider.of<WeatherProvider>(context, listen: false).getWeatherInfo();
  }

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
                      'Cairo',
                      style: const TextStyle(
                          color: AppColor.lightBlack, fontSize: 22),
                    ),
                    Text(
                      dailyForecast[0].dtTxt ?? "12/05/2022",
                      style:
                          const TextStyle(color: AppColor.grey, fontSize: 15),
                    ),
                    Image.asset('assets/images/02n.png'),
                    Text(
                      dailyForecast[0].description ?? 'Cloudy',
                      style: const TextStyle(
                          color: AppColor.lightBlack, fontSize: 20),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      dailyForecast[0].temp.toString(),
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
                          '68°',
                          style: const TextStyle(
                              color: AppColor.grey, fontSize: 18),
                        ),
                        const SizedBox(width: 40),
                        Image.asset(
                          'assets/images/l.png',
                          height: 35,
                        ),
                        Text(
                          '52°',
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
                          data: '12Km/h',
                          label: 'Wind',
                        ),
                        ImageData(
                          aseetPath: 'assets/images/c.png',
                          data: '22%',
                          label: 'Clouds',
                        ),
                        ImageData(
                          aseetPath: 'assets/images/hu.png',
                          data: '22%',
                          label: 'Humidity',
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: 200,
                height: size.height * 0.35,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(31, 162, 162, 162),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '12/05/2022',
                      style: const TextStyle(
                          color: AppColor.lightBlack, fontSize: 15),
                    ),
                    Image.asset(
                      'assets/images/02n.png',
                      width: 100,
                    ),
                    Text(
                      'Cloudy',
                      style: const TextStyle(
                          color: AppColor.lightBlack, fontSize: 20),
                    ),
                    SizedBox(height: size.height * 0.02),
                    Text(
                      '96°',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    // SizedBox(height: size.height * 0.02),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
