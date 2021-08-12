class FoodModel{
  String description;
  String discount;
  String image;
  String menuId;
  String name;
  String price;
  String keys;

  FoodModel(this.description, this.discount, this.image, this.menuId, this.name,
      this.price, this.keys);
  Map toMap(FoodModel foodModel){
    var data=Map<String, dynamic>();
    data['description']=foodModel.description;
    data['image']=foodModel.image;
    data['menuId']=foodModel.menuId;
    data['name']=foodModel.price;
    data['discount']=foodModel.discount;
    data['price']=foodModel.price;
    data['keys']=foodModel.keys;
    return data;
  }
  FoodModel.fromMap(Map<dynamic,dynamic> mapdaata){
    this.description=mapdaata['description'];
    this.image=mapdaata['image'];
    this.menuId=mapdaata['menuId'];
    this.name=mapdaata['name'];
    this.discount=mapdaata['discount'];
    this.price=mapdaata['price'];
    this.keys=mapdaata['keys'];
  }
}