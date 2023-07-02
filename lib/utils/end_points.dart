class ApiEndPoints {
  static const String baseUrl = 'http://192.168.1.22:8000/api/';
  static const String baseUrlimg = 'http://192.168.1.22:8000/storage/posts/';
  static _AuthEndPoints authEndPoints = _AuthEndPoints(); 
  // Use this for android emulator 'http://10.0.2.2/'
  // Use this for android real device with localhost 'http://192.168.1.22/' << Ip Address PC
  // Use this for android real device with Hosting ''
}

class _AuthEndPoints {
  final String loginEmail = 'login';
  final String logoutEmail = 'logout/';
  
  final String park = 'parkir/';
  final String mahasiswa = 'mahasiswa/';
}