class Users{
  String uid;
  String phone;
  String email;
  String password;

  Users(this.uid, this.phone, this.email, this.password);
  Map toMap(Users users){
    var data=Map<String,dynamic>();
    data['uid']=users.uid;
    data['phone']=users.phone;
    data['email']=users.email;
    data['password']=users.password;
    return data;
  }
  Users.fromMap(Map<String,dynamic> mapData){
    this.uid=mapData['uid'];
    this.phone=mapData['phone'];
    this.email=mapData['email'];
    this.password=mapData['password'];
  }
}