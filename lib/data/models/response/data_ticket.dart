import 'package:wisdom_pos_test/data/models/ticket.dart';

class ResponseDataTicket {
  String? status;
  String? message;
  bool? relogin;
  Result? result;

  ResponseDataTicket({this.status, this.message, this.relogin, this.result});

  ResponseDataTicket.fromJson(Map<String, dynamic> json) {
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
  List<Ticket>? ticket;

  Result({this.ticket});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['ticket_'] != null) {
      ticket = <Ticket>[];
      json['ticket_'].forEach((v) {
        ticket!.add(Ticket.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ticket != null) {
      data['ticket_'] = ticket!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
