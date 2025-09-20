import 'package:wisdom_pos_test/data/models/service.dart';

class ResponseDataService {
  String? status;
  String? message;
  bool? relogin;
  Result? result;

  ResponseDataService({this.status, this.message, this.relogin, this.result});

  ResponseDataService.fromJson(Map<String, dynamic> json) {
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
  List<Service>? service;

  Result({this.service});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['service_'] != null) {
      service = <Service>[];
      json['service_'].forEach((v) {
        service!.add(Service.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (service != null) {
      data['service_'] = service!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
