@JS()
library stripe;

import 'package:flutter/material.dart';
import 'package:flutter_stripe_demo/constants.dart';
import 'package:js/js.dart';

import 'server_stub.dart';

void redirectToCheckout(BuildContext _) async {
  final stripe = Stripe(apiKey);
  final id = await Server().createCheckout();
  stripe.redirectToCheckout(CheckoutOptions(
    sessionId: id,
    ));
}

@JS()
class Stripe {
  external Stripe(String key);

  external redirectToCheckout(CheckoutOptions options);
}

@JS()
@anonymous
class CheckoutOptions {
  external List<LineItem> get lineItems;

  external String get mode;

  external String get successUrl;

  external String get cancelUrl;

  external factory CheckoutOptions({
    List<LineItem> lineItems,
    String mode,
    String successUrl,
    String cancelUrl,
    String sessionId,
  });
}

@JS()
@anonymous
class LineItem {
  external String get price;

  external int get quantity;

  external factory LineItem({String price, int quantity});
}
