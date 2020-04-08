class ApiResponse {
  Map<String, dynamic> json;
  String body;
  int httpCode;

  bool get isCorrect => httpCode < 300;

  ApiResponse(this.json, this.body, this.httpCode);
}
