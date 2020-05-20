class Carousel {
  final String desc,link;
  Carousel({this.desc,this.link});

  factory Carousel.fromJson(Map<String,dynamic> json){
    return Carousel(
      desc: json['desc'],
      link: json['image']
    );
  }
}

class Restaurant {
  final String id,
      storeName,
      storePhoto,
      storeAddress,
      storePhone,
      openTime,
      closeTime,
      category;
  final double lat, lng, distance;
  final bool status;

  Restaurant(
      {this.id,
      this.storeName,
      this.storePhoto,
      this.storeAddress,
      this.storePhone,
      this.lat,
      this.lng,
      this.distance,
      this.closeTime,
      this.openTime,
      this.category,
      this.status});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
        id: json['id'],
        storeName: json['name'],
        storeAddress: json['address'],
        storePhoto: json['cover_photo'],
        storePhone: json['phone'],
        closeTime: json['close_time'],
        openTime: json['open_time'],
        distance: json['distance'],
        category: json['category'],
        lat: json['lat'],
        lng: json['lng'],
        status: json['status']
      );
  }
}


class MenuCategory {
  final String menuType;
  final List<Menu> menu;
  MenuCategory({this.menuType, this.menu});

  factory MenuCategory.fromJson(Map<String, dynamic> json) {
    var menus = json['items'];
    var menuList = menus.map<Menu>((menus)=> new Menu.fromJson(menus)).toList();
    return MenuCategory(menuType: json['menu_type'], menu: menuList);
  }
}

class Menu {
  final String name, photo, description;
  final int id,stock,price,promoPrice;
  final bool available, promoStatus;
  int quantity;
  String note;
  Menu(
      {this.id,
      this.name,
      this.available,
      this.description,
      this.photo,
      this.price,
      this.promoPrice,
      this.stock,
      this.promoStatus,
      this.quantity,
      this.note});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      photo: json['photo'],
      promoPrice: json['promo'],
      promoStatus: json['promoStatus'],
      description: json['description'],
      stock: json['stock'],
      available: json['available'],
      quantity: 0,
      note: ""
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "name": this.name,
      "id": this.id,
      "quantity": this.quantity,
    };
  }

    static List encondeToJson(List<Menu>list){
        List jsonList = List();
        list.map((item)=>
          jsonList.add(item.toJson())
        ).toList();
        return jsonList;
    }
}