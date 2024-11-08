enum ApiStatus { success, failure }

class ApiResponse<T> {
  final ApiStatus status;
  final T? data;
  final String? message;

  ApiResponse({
    required this.status,
    this.data,
    this.message,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic)? fromJson,
  ) {
    final dynamic jsonData = json['data'];

    if (jsonData is List) {
      return ApiResponse<T>(
        status: json['status'].toString().toLowerCase() == 'success'
            ? ApiStatus.success
            : ApiStatus.failure,
        data: fromJson?.call(jsonData),
        message: json['message'],
      );
    }
    final data = jsonData != null ? fromJson!(jsonData) : null;
    return ApiResponse<T>(
      status: json['status'].toString().toLowerCase() == 'success'
          ? ApiStatus.success
          : ApiStatus.failure,
      data: data,
      message: json['message'],
    );
  }

  bool get isSuccess => status == ApiStatus.success;
}
