import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fooddelivery/Model/Categorys.dart';
import 'package:fooddelivery/Model/FoodModel.dart';
import 'package:fooddelivery/Services/Firebase_Helper.dart';
import 'package:fooddelivery/Services/auth_Methods.dart';

class HomePageBloc with ChangeNotifier{
  Firebasehelper mfirebasehelper=Firebasehelper();
  AuthMethods mAuthmethods=AuthMethods();
  List<Categorites> CategoritesList=[];
  List<FoodModel> foodlist=[];
  List<FoodModel> popularFood=[];
  List<FoodModel> bannerFood=[];
 final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  Categorites recentlyCategory = Categorites(image:"https://images.unsplash.com/photo-1571091718767-18b5b1457add?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80",name: "burger",keys: "08");
  Categorites recentlyCategory2 = Categorites(image:"https://img.buzzfeed.com/thumbnailer-prod-us-east-1/video-api/assets/216054.jpg",name: "Pizza",keys: "04");
  Categorites recentlyCategory3 = Categorites(image:"https://static.toiimg.com/thumb/54659021.cms?width=1200&height=1200",name: "french fries",keys: "07");
  Categorites recentlyCategory4 = Categorites(image:"https://i.pinimg.com/originals/3b/b4/ea/3bb4ea708b73c60a11ccd4a7bdbb1524.jpg",name: "kfc chicken",keys: "09");
  FirebaseUser mFirebaseUser;
  getCurruntUser(){
    mAuthmethods.getCurruntUser().then((FirebaseUser curruntuser){
      mFirebaseUser=curruntuser;
      notifyListeners();
    });
  }
  getCategoryFood(){
    CategoritesList.clear();
    mfirebasehelper.getCategories().then((List<Categorites> Flist){
      CategoritesList=Flist;
      notifyListeners();
    });
  }
  getRecomendedFoodList() async{
    mfirebasehelper.fetchallfood().then((List<FoodModel> FList) {
      FList.forEach((FoodModel food) {
        // we are fetching 3 types of foods who's menu id is 05 03 and 07.
        print("data=:::${food.name}");
        if (food.menuId == "05") {
          popularFood.add(food);
        }
        else if (food.menuId == "03") {
          foodlist.add(food);
        }
        else if (food.menuId == "07") {
          bannerFood.add(food);
        }
        notifyListeners();
      });
    });
  }
}