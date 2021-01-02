import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import 'env.dart';

class ApiClient {
  get({
    @required String url,
    Map<String, String> param,
    Map<String, String> headers,
    @required ValueChanged callback(int code, String message, dynamic json),
  }) async {
    var uri = Uri.https(Env.baseUrl, url, param);

    http.get(Env.baseUrl+url, headers: headers).then((response) {
      print("GET ${response.statusCode}\n"
          "uri $uri\n"
          "${response.statusCode == 200 ? "" : "${response.body}"}");
      final dynamic res = jsonDecode(response.body);
      callback(response.statusCode,
          response.statusCode == 200 ? 'Request Sukses' : res["message"], res);
    }).catchError((e) {
      print(uri.toString());
      print(e);

      callback(400, "Terjadi kesalahan", null);
    });
  }

}
