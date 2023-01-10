import 'package:daily_weather/widgets/image_data.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CurrentWeatherContainer extends StatelessWidget {
  const CurrentWeatherContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          width: size.width,
          height: size.height * 0.50,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                style:
                    const TextStyle(color: AppColor.lightBlack, fontSize: 22),
              ),
              Text(
                '12/05/2022',
                style: const TextStyle(color: AppColor.grey, fontSize: 15),
              ),
              Image.asset('assets/images/02n.png'),
              Text(
                'Cloudy',
                style:
                    const TextStyle(color: AppColor.lightBlack, fontSize: 20),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                '96°',
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
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
                    style: const TextStyle(color: AppColor.grey, fontSize: 18),
                  ),
                  const SizedBox(width: 40),
                  Image.asset(
                    'assets/images/l.png',
                    height: 35,
                  ),
                  Text(
                    '52°',
                    style: const TextStyle(color: AppColor.grey, fontSize: 18),
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
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                style:
                    const TextStyle(color: AppColor.lightBlack, fontSize: 15),
              ),
              Image.asset(
                'assets/images/02n.png',
                width: 100,
              ),
              Text(
                'Cloudy',
                style:
                    const TextStyle(color: AppColor.lightBlack, fontSize: 20),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                '96°',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              // SizedBox(height: size.height * 0.02),
            ],
          ),
        ),
      ],
    );
  }
}
