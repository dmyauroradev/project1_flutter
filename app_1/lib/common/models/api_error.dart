import 'dart:convert';

class ApiError {
  final String message;

  ApiError({required this.message});

  // Hàm tạo để khởi tạo ApiError từ JSON
  factory ApiError.fromJson(Map<String, dynamic> json) {
    return ApiError(
      message: json['message'] ??
          'Unknown error', // Dự phòng nếu không có trường 'message'
    );
  }
}

// Hàm phân tích chuỗi JSON thành đối tượng ApiError
ApiError apiErrorFromJson(String str) {
  final jsonData = json.decode(str); // Phân tích chuỗi JSON
  return ApiError.fromJson(jsonData); // Tạo đối tượng ApiError từ JSON
}
