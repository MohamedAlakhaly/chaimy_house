// import 'package:dio/dio.dart';
// import 'package:refugee_app/models/static/home/forecast_weather.module.dart';
// import 'package:refugee_app/models/static/home/weather.module.dart';

// class WeatherService {
//   final Dio _dio = Dio();
//   final String _apiKey = '656981db5ce6c97ee6ae43d51320fa87';

//   Future<List<WeatherModel>> fetchMainWeather(String city) async {
//     String url =
//         'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$_apiKey&units=metric';

//     final response = await _dio.get(url);
//     List dataList = response.data['list'];
//     return dataList.map((e) => WeatherModel.fromJson(e)).toList();
//   }

//   Future<List<ForecastWeather>> fetchForecastWeather(String city) async {
//     String url =
//         'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$_apiKey&units=metric';

//     final response = await _dio.get(url);
//     List dataList = response.data['list'];
//     return dataList.map((e) => ForecastWeather.fromJson(e)).toList();
//   }
// }
