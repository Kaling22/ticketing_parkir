class ApiEndPoints {
  static final String baseUrl = 'http://10.0.2.2:8000/api/';
  static final String baseUrlimg = 'http://10.0.2.2:8000/storage/posts/';
  static _AuthEndPoints authEndPoints = _AuthEndPoints(); 
}

class _AuthEndPoints {
  final String loginEmail = 'login';
  final String logoutEmail = 'logout';
  
  final String park = 'parkir/';
  final String mahasiswa = 'mahasiswa/';
}