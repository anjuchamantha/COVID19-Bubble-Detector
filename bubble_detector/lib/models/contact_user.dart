class ContactUser {
  String phone;
  double distance;
  DateTime dateTime;
  var userId;
  var firebaseToken;
  var isStore;

  ContactUser(this.phone, this.dateTime, this.distance);

  updateUserData(String userId, String token) {
    this.userId = userId;
    this.firebaseToken = token;
  }
}
