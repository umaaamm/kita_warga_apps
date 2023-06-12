class GeneralResponse {
  final String message;

  GeneralResponse(this.message);

  GeneralResponse.fromJson(Map<String, dynamic> json)
      : message = json["message"];
}