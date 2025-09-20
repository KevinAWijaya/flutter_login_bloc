class ResponseLogin {
  String? status;
  String? message;
  bool? relogin;
  Result? result;

  ResponseLogin({this.status, this.message, this.relogin, this.result});

  ResponseLogin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    relogin = json['relogin'];
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['relogin'] = relogin;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  String? accesstoken;
  String? refreshtoken;

  Result({this.accesstoken, this.refreshtoken});

  Result.fromJson(Map<String, dynamic> json) {
    accesstoken = json['accesstoken'];
    refreshtoken = json['refreshtoken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accesstoken'] = accesstoken;
    data['refreshtoken'] = refreshtoken;
    return data;
  }
}
