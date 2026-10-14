import 'dart:developer';

import 'package:jwt_decoder/jwt_decoder.dart';

void checkTokenData(String token) {
  Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

  log('Decoded Data: $decodedToken');

  String userId = decodedToken['id'];
  String userRole = decodedToken['role'];

  log('User ID: $userId');
  log('User Role: $userRole');

  bool hasExpired = JwtDecoder.isExpired(token);
  if (hasExpired) {
    log('টোকেনটির মেয়াদ শেষ! আবার লগইন করতে হবে।');
  } else {
    log('টোকেনটি সচল আছে।');
  }

  Duration remainingTime = JwtDecoder.getRemainingTime(token);
  log('মেয়াদ শেষ হতে বাকি আছে: $remainingTime');
}
