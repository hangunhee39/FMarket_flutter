class ErrorResponse {
  final String? status;
  final String? code;
  final String? message;

  ErrorResponse(
      {this.message = 'SUCCESS', this.code = "0000", this.status = '',});
}
