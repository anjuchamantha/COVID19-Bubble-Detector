import '../../../views/pages/Landing/landing_otp.dart';
import '../../../views/pages/Landing/landing_phone_number.dart';
import 'package:flutter/material.dart';

/// Used to change the pages of the Landing Pages
abstract class LandingPageState {
  static LandingPageState initial() {
    return LandingPagePhoneNumberState();
  }

  LandingPageState nextState();
  String current();
}

class LandingPagePhoneNumberState extends LandingPageState {
  @override
  LandingPageState nextState() {
    return LandingPageOtpState();
  }

  @override
  String current() {
    return this.runtimeType.toString();
  }
}

class LandingPageOtpState extends LandingPageState {
  @override
  LandingPageState nextState() {
    return LandingPageStoreOrIndividualState();
  }

  @override
  String current() {
    return this.runtimeType.toString();
  }
}

class LandingPageStoreOrIndividualState extends LandingPageState {
  @override
  LandingPageState nextState() {
    return LandingPageBluetoothState();
  }

  @override
  String current() {
    return this.runtimeType.toString();
  }
}

class LandingPageBluetoothState extends LandingPageState {
  @override
  LandingPageState nextState() {
    // TODO: implement nextState
    throw UnimplementedError();
  }

  @override
  String current() {
    return this.runtimeType.toString();
  }
}
