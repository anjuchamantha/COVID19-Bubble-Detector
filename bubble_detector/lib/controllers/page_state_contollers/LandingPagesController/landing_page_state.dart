/// Used to change the pages of the Landing Pages
abstract class LandingPageState {
  static LandingPageState initial() {
    return LandingPagePhoneNumberState();
  }

  LandingPageState nextState();
  Type current();
}

class LandingPagePhoneNumberState extends LandingPageState {
  @override
  LandingPageState nextState() {
    return LandingPageOtpState();
  }

  @override
  Type current() {
    return this.runtimeType;
  }
}

class LandingPageOtpState extends LandingPageState {
  @override
  LandingPageState nextState() {
    return LandingPageStoreOrIndividualState();
  }

  @override
  Type current() {
    return this.runtimeType;
  }
}

class LandingPageStoreOrIndividualState extends LandingPageState {
  @override
  LandingPageState nextState() {
    return LandingPageBluetoothState();
  }

  @override
  Type current() {
    return this.runtimeType;
  }
}

class LandingPageBluetoothState extends LandingPageState {
  @override
  LandingPageState nextState() {
    return LandingPageLoadingtate();
  }

  @override
  Type current() {
    return this.runtimeType;
  }
}

class LandingPageLoadingtate extends LandingPageState {
  @override
  LandingPageState nextState() {
    // TODO: implement nextState
    throw UnimplementedError();
  }

  @override
  Type current() {
    return this.runtimeType;
  }
}
