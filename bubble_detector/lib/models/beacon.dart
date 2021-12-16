class BeaconMsg {
  var uuid;
  var major;
  var minor;
  var accuracy;
  var phone;

  BeaconMsg(String uuid, int major, int minor, double accuracy) {
    this.uuid = uuid;
    this.major = major.toString();
    this.minor = minor.toString();
    this.accuracy = accuracy;
    this.phone = buildPhoneNumber(major, minor);
  }

  String buildPhoneNumber(var major, var minor) {
    return "+947" +
        major.toString().padLeft(4, '0') +
        minor.toString().padLeft(4, '0');
  }
}
