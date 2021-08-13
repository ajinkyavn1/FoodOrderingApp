import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fooddelivery/Model/Categorys.dart';
import 'package:fooddelivery/Model/FoodModel.dart';
import 'package:fooddelivery/Model/Request.dart';
import 'package:fooddelivery/Services/auth_Methods.dart';
class Firebasehelper{
  static final FirebaseDatabase _database=FirebaseDatabase.instance;
  static final DatabaseReference _OrderdatabaseReference=_database.reference().child("Orders");
  static final DatabaseReference _CatageroiesdatabaseReference=_database.reference().child("Category");
  static final DatabaseReference _FooddatabaseReference=_database.reference().child("Foods");
  Future<List<FoodModel>> fetchallfood()async{
    List<FoodModel>FoodList=<FoodModel>[];
   DatabaseReference fooddatabaseReference=_database.reference().child("Foods");
   await fooddatabaseReference.once().then((DataSnapshot snap){
     var keys=snap.value.key;
     var data=snap.value;
     FoodList.clear();
     for(var indivisualData in keys){
       FoodModel foodModel=new FoodModel(
           data[indivisualData]['description'],
           data[indivisualData]['discount'],
           data[indivisualData]['image'],
           data[indivisualData]['menuId'],
           data[indivisualData]['name'],
           data[indivisualData]['price'],
           indivisualData.toString()
       );
       FoodList.add(foodModel);
     }
    });
   return FoodList;
  }
  Future<List<FoodModel>> getSpecifiedFood(String query)async{
    List<FoodModel> Food=<FoodModel> [];
    await _FooddatabaseReference.once().then((DataSnapshot snapshot){
      var key=snapshot.value.keys;
      var data=snapshot.value;
      Food.clear();
      for(var indivisualData in key){
        FoodModel food=new FoodModel(
            data[indivisualData]['description'],
            data[indivisualData]['discount'],
            data[indivisualData]['image'],
            data[indivisualData]['menuId'],
            data[indivisualData]['name'],
            data[indivisualData]['price'],
            indivisualData.toString()
        );
       if(food.menuId==query)
           Food.add(food);
      }
      return Food;
    });
  }
  Future<bool> placeOrder(Request request)async{
    await _OrderdatabaseReference.child(request.uid).push().set(request.toMap(request));
    return true;
  }
  Future<Categorites> getCategories()async{
    List<Categorites> CategoryList=[];
    await _CatageroiesdatabaseReference.once().then((DataSnapshot snapshot){
      var keys=snapshot.value.keys;
      var data=snapshot.value;
      for(var da in keys){
        Categorites cateList=new Categorites(
          data[da]['image'],
          data[da]['name'],
          da.toString()
          );
        CategoryList.add(cateList);
      }
    });
    return CategoryList;
  }

  Future<List<Request>> fetchOrders(FirebaseUser curruntuser){
    List<Request> requestList=[];
    DatabaseReference fooddatabaseReferenc=_OrderdatabaseReference.child(curruntuser);
    await fooddatabaseReferenc.once().then((DataSnapshot snap){
      var key=snap.value.keys;
      var data=snap.value;
      requestList.clear();
      for(var da in key){
        Request request=Request(
          data[da]['address'],
          data[da]['foodList'],
          data[da]['name'],
          data[da]['uid'],
          data[da]['status'],
          data[da]['total'],
          
        );
        requestList.add(request);
      }
    });
    return requestList;
  }
  Future<void> addOrder(String totalPrice,List<FoodModel orderedFoodList,String Name,String Address)async{
    FirebaseUser user=await AuthMethods().getCurruntUser();
    String uidtext=user.uid;
    String statustext="0";
    String totaltxt=totalPrice.toString();
    Map aux=new Map<String,dynamic>();
     orderedFoodList.forEach((food){
      aux[food.keys] = food.toMap(food);
    });
    Request request=new Request(
      Address,
      aux,
      Name,
      uidtext, 
      statustext,
      totaltxt);
     await _OrderdatabaseReference.child(request.uid).set(request.toMap(request)).then((value){
      //  DatabaseSql
     });
  }
 
}