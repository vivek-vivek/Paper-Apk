import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../models/main_api_model.dart';

class ApiServices {
  final basePortUrl =
      "https://newsapi.org/v2/everything?q=apple&from=2022-12-08&to=2022-12-08&sortBy=popularity&apiKey=72ece38b526c41c5ad974f971fcaa9fa";
  Future<MainApiModel?> fetchUser() async {
    try {
      // var parsedUrl = Uri.parse(basePortUrl);
      // var response = await http.get(parsedUrl);
      // var responseDecode = json.decode(response.body);
      Response response = await Dio().get(basePortUrl);
      log(response.toString());

      if (response.statusCode! >= 200 || response.statusCode! <= 299) {
        return MainApiModel.fromJson(response.data);
      } else {
        return MainApiModel(message: 'Blah Blah Blah !!!');
      }
    } on SocketException catch (err) {
      log('No Internet connection 😑');
      log(err.toString());
      return MainApiModel(message: 'No Internet connection 😑');
    } on HttpException catch (err) {
      log("Couldn't find the post 😱");
      log(err.toString());
      return MainApiModel(message: "Couldn't find the post 😱");
    } on FormatException catch (err) {
      log("Bad response format 👎");
      log(err.toString());
      return MainApiModel(message: "Bad response format 👎");
    } catch (err) {
      if (err is DioError) {
        if (err.response?.data == null) {
          return MainApiModel(message: 'Something went wrong!');
        }
        return MainApiModel(
          message: err.response!.data['message'],
        );
      } else {
        return MainApiModel(message: err.toString());
      }
      // log(err.toString());
      // return MainApiModel(message: "Unknown Error!");
    }
  }
}
