class SearchModel {
  bool? status;
  String? message;
  SearchData? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? SearchData.fromJson(json['data']) : null;
  }

}

class SearchData {
  int? currentPage;
  late List<Data?> data = [];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;


  SearchData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

}



class Data {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'] ?? 0;
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}
