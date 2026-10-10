class ApiResponseModel<T> {
  final bool success;
  final String message;
  final T? data;

  ApiResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) create,
  ) {
    return ApiResponseModel<T>(
      success: json['success'] ?? false,
      message: json['message'] as String,
      data: json['data'] != null ? create(json['data']) : null,
    );
  }
}
