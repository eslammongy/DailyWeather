// ignore: constant_identifier_names

const String ApiKey = "ca4f047ebf37d1d9d7dfebb4100bd981";
const String baseUrl = "https://api.openweathermap.org/data/2.5/";

String getImageCode(String weatherDesc) {
  switch (weatherDesc) {
    case '01d':
      return "assets/images/01d.png";

    case '01n':
      return "assets/images/01n.png";

    case '02d':
      return "assets/images/02d.png";

    case '02n':
      return "assets/images/02n.png";

    case '03d':
    case '04d':
      return "assets/images/04d.png";

    case '03n':
    case '04n':
      return "assets/images/03d.png";

    case '09d':
    case '09n':
      return "assets/images/09d.png";

    case '10d':
      return "assets/images/10d.png";

    case '10n':
      return "assets/images/10n.png";

    case '11d':
    case '11n':
      return "assets/images/11d.png";

    case '13n':
    case '13d':
      return "assets/images/13d.png";

    case '50d':
      return "assets/images/50d.png";

    case '50n':
      return "assets/images/50n.png";

    default:
      return "assets/images/01d.png";
  }
}
