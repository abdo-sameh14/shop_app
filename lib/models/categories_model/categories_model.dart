class CategoryModel {
  bool? status;
  CategoryData? data;

  CategoryModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = CategoryData.fromJson(json['data']);

  }
}

class CategoryData {
  int? currentPage;
  late List<CategoryDataList?> data = [];
  late String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  CategoryData.fromJson(Map<String, dynamic> json){
    currentPage = json['current_page'];

    if(json['data'] != null){
      json['data'].forEach((element) {
        data.add(CategoryDataList.fromJson(element));
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


    // data?.add(CategoryDataList.fromJson(json['data']));

      // json['products'].forEach((element) {
      //   products?.add(ProductsData.fromJson(element));
      // });
  }


class CategoryDataList {
  late int id;
  late String name;
  late String image;

  CategoryDataList.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

}


