class Dioresponse {
  final bool error;
  final String message;
  final int code;
  final Map<String, dynamic> data;

  Dioresponse({
    required this.error,
    required this.message,
    required this.code,
    required this.data,
  });
}
