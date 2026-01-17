class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final String? errorMessage;
  final dynamic responseData;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.errorMessage,
    this.responseData,
  });

  Map<String, dynamic> toJson() {
    return {
      'isSuccess': isSuccess,
      'statusCode': statusCode,
      'errorMessage': errorMessage,
      'responseData': responseData,
    };
  }
}