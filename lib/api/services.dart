// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import 'package:reqress_api/core/urls.dart';

// import 'models.dart';

// class Services {
// // 1. Create get function
//   List email = [];
//   Future<dynamic> fetchUser(int? index) async {
//     try {
//       log("step- 1 : *parsing the uri\n' ");
//       var url = Uri.parse(basePort);

//       log("step- 2 : get response frm json \n'");
//       var response = await http.get(url);

// // 2. check status condition?
//       log("step- 3 : *check status condition \n'");
//       if (response.statusCode == 200 || response.statusCode == 201) {
// // 3. json decoding
//         log("step- 4 : *json decoding \n'");
//         var respData = await json.decode(response.body);
//         var deepData = respData['data'][index]['email'];
//         log("message");

//         log(email[index!]);

//         log("step -5 : *result \n'");
//         var result = UserModel.fromJson(respData);
//         email.add(result);

//         log("step -6 : *returned \n'");
//         return deepData;
//       } else {
//         log("else condition worked \n");
//         return null;
//       }
//     } on TypeError catch (e) {
//       log("TypeError catch  worked\t🧨 \n");
//       log(e.stackTrace.toString());
//     } catch (e) {
//       log("catch clause worked\t🧨 \n");
//       log(e.toString());
//     }
//     log('returned from out \n');
//     return null;
//   }
// }

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
      var parsedUrl = Uri.parse(basePortUrl);
      var response = await http.get(parsedUrl);
      var responseDecode = json.decode(response.body);

      if (response.statusCode >= 200 || response.statusCode <= 299) {
        return MainApiModel.fromJson(responseDecode);
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
      
      log(err.toString());
      return MainApiModel(message: "Unknown Error!");
    }
  }
}
