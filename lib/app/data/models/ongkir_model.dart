class Ongkir {
  String? code;
  String? name;
  List<Costs>? costs;

  Ongkir({this.code, this.name, this.costs});

  Ongkir.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    if (json['costs'] != null) {
      costs = <Costs>[];
      json['costs'].forEach((v) {
        costs?.add(Costs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['code'] = code;
    data['name'] = name;
    if (costs != null) {
      data['costs'] = costs?.map((v) => v.toJson()).toList();
    }
    return data;
  }

  static List<Ongkir> fromJsonList(List list) {
    if (list.length == 0) return List<Ongkir>.empty();
    return list.map((item) => Ongkir.fromJson(item)).toList();
  }
}

class Costs {
  String? service;
  String? description;
  List<Cost>? cost;

  Costs({this.service, this.description, this.cost});

  Costs.fromJson(Map<String, dynamic> json) {
    service = json['service'];
    description = json['description'];
    if (json['cost'] != null) {
      cost = <Cost>[];
      json['cost'].forEach((v) {
        cost?.add(Cost.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['service'] = service;
    data['description'] = description;
    if (cost != null) {
      data['cost'] = cost?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cost {
  int? value;
  String? etd;
  String? note;

  Cost({this.value, this.etd, this.note});

  Cost.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    etd = json['etd'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['value'] = value;
    data['etd'] = etd;
    data['note'] = note;
    return data;
  }
}
