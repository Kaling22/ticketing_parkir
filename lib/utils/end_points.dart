class ApiEndPoints {
  static const String baseUrl = 'https://ticketingparkir.com/api/';
  static const String baseUrl2 = 'https://ticketingparkir.com/api/';
  static const String baseUrlimg = 'https://ticketingparkir.com/storage/posts/';
  static _AuthEndPoints authEndPoints = _AuthEndPoints(); 
  // Use this for android emulator 'http://10.0.2.2/'
  // Use this for android real device with localhost 'http://192.168.1.22/' << Ip Address PC
}

class _AuthEndPoints {
  final String loginEmail = 'login';
  final String logoutEmail = 'logout/';
  
  final String park = 'parkir/';
  final String park2 = 'parkir';
  final String mahasiswa = 'mahasiswa/';
}