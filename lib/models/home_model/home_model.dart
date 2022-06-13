class HomeModel {
  bool? status;
  HomeData? data;

  HomeModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = HomeData.fromJson(json['data']);
  }
}

class HomeData {
  late List<BannersData?> banners = [];
  late List<ProductsData?> products= [];

  HomeData.fromJson(Map<String, dynamic> json){

    if(json['banners'] != null){
      json['banners'].forEach((element) {
        banners.add(BannersData.fromJson(element));
      });
    }

    if(json['products'] != null){
      json['products'].forEach((element) {
        products.add(ProductsData.fromJson(element));
      });
    }


    // banners?.add(BannersData.fromJson(json['banners']));

      // json['products'].forEach((element) {
      //   products?.add(ProductsData.fromJson(element));
      // });
  }
}

class BannersData {
  late int id;
  late String image;

  BannersData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    image = json['image'];
  }

}

class ProductsData {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool inFavorites;
  late bool inCart;

  ProductsData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}