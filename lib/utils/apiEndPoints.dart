class ApiEndPoints {
  static final String baseUrl = 'http://localhost:3222/';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = 'register';
  final String loginEmail = 'login';
}
