class User{
  String _id;
  String _name;
  String _pwd;
  String _token;

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get name => _name;

  String get pwd => _pwd;

  set pwd(String value) {
    _pwd = value;
  }

  set name(String value) {
    _name = value;
  }

  String get token => _token;

  set token(String value) {
    _token = value;
  }
}