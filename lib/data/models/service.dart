class Service {
  int? id;
  String? name;
  int? ordinal;
  int? active;

  Service({this.id, this.name, this.ordinal, this.active});

  Service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    ordinal = json['ordinal'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['ordinal'] = ordinal;
    data['active'] = active;
    return data;
  }
}
