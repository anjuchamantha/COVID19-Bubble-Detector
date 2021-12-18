class ContactUser {
  String phone;
  double distance;
  DateTime dateTime;
  var userId;
  var firebaseToken;
  var isStore;
  var name;

  ContactUser(this.phone, this.dateTime, this.distance);

  updateUserData(String name, String userId, String token, bool isStore) {
    this.name = name;
    this.userId = userId;
    this.firebaseToken = token;
    this.isStore = isStore;
  }
}
