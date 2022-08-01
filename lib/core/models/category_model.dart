class CategoriesModel {
  bool? status;

  Data? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];

    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<Datas>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;

  String? path;
  int? perPage;

  int? to;
  int? total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Datas>[];
      json['data'].forEach((v) {
        data!.add(Datas.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];

    path = json['path'];
    perPage = json['per_page'];

    to = json['to'];
    total = json['total'];
  }
}

class Datas {
  int? id;
  String? name;
  String? image;

  Datas.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
