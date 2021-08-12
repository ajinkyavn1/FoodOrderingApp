class Request{
  String address;
  Map foodList;
  String name;
  String uid;
  String status;
  String total;
  Request(this.address, this.foodList, this.name, this.uid, this.status,
      this.total);
  Map toMap(Request request){
    var data=Map<String,dynamic>();
    data['address']=request.address;
    data['foodList']=request.foodList;
    data['name']=request.name;
    data['uid']=request.uid;
    data['status']=request.status;
    data['total']=request.total;
    return data;
  }
  Request.fromMap(Map<dynamic,dynamic> mapdata){
    this.address=mapdata['address'];
    this.foodList=mapdata['foodList'];
    this.name=mapdata['name'];
    this.uid=mapdata['uid'];
    this.status=mapdata['status'];
    this.total=mapdata['total'];
  }
}