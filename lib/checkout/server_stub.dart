import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_stripe_demo/constants.dart';

/// Only for demo purposes!
/// Don't you dare do it in real apps!
class Server {
  Future<String> createCheckout() async {
    final auth = 'Bearer $secretKey';
    final body = {
      //'payment_method_types[]': 'card',
       'line_items': [
         {
           'price_data':
           {
             'currency': 'usd',
             'unit_amount': 100,
             'product_data':{
               'name': 'testtovar',
               'description': 'description',
             }
           },
           'quantity': 1,
         }
       ],
      'mode': 'payment',
      'success_url': 'http://localhost:8080/#/success',
      'cancel_url': 'http://localhost:8080/#/cancel',
    };

    try {
      final result = await Dio().post(
        "https://api.stripe.com/v1/checkout/sessions",
        data: body,
        options: Options(
          headers: {HttpHeaders.authorizationHeader: auth},
          contentType: "application/x-www-form-urlencoded",
        ),
      );
      return result.data['id'];
    } on DioError catch (e, s) {
      print(e.response);
      throw e;
    }
  }
}
