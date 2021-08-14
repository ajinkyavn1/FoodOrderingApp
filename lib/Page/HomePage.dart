import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fooddelivery/Page/Auth/LoginPage.dart';
import 'package:fooddelivery/blocs/HomePageBloc.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>HomePageBloc(),
      child: HomePageContent(),
    );
  }
}

class HomePageContent extends StatefulWidget {

  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  HomePageBloc _homePageBloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPersistentFrameCallback((timeStamp) {
      _homePageBloc.getCurruntUser();
      _homePageBloc.getCategoryFood();
      _homePageBloc.getRecomendedFoodList();
    });
  }
  @override
  Widget build(BuildContext context) {
    _homePageBloc=Provider.of<HomePageBloc>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.white),
        elevation: 0.0,
        centerTitle: false,
        title: Text("Home", style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 30.0),)
      ),
      drawer: CreateDrawer(),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color:Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              craeteSearchbar(),
              SizedBox(height: 10,),
              CreateBanner(),
            ],
          ),
        ),
      ),
    );
  }

  CreateDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: [
          DrawerHeader(
            child: UserAccountsDrawerHeader(
              accountName:Text(" "),
              accountEmail:Text(_homePageBloc.mFirebaseUser?.email??" "),
              currentAccountPicture: CircleAvatar(backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-IXgusL5qRoPrvn-cXREksmn7_Wv1SMFtTe-xBOUn7AWQdp9fq4xAzj-sOdtLv_NUdo0bUT7atGQhlA&usqp=CAU",),),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.transparent),
            ),
          ),
          ListTile(
            trailing: Icon(CupertinoIcons.forward),
            leading: Icon(CupertinoIcons.home),
            title: Text("Home"),
            onTap: (){},

          ),
          ListTile(
            trailing: Icon(CupertinoIcons.forward),
            leading: Icon(Icons.notes_outlined),
            title: Text("My Orders"),
            onTap: (){},
          ),
          ListTile(
            trailing: Icon(CupertinoIcons.forward),
            leading: Icon(CupertinoIcons.cart),
            title: Text("Cart"),
            onTap: (){},
          ),
          ListTile(
            trailing: Icon(CupertinoIcons.forward),
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: (){
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
            },
          ),
        ],
      ),
    );
  }

  craeteSearchbar() {
    return  Container(
      height: MediaQuery.of(context).size.height*0.08,
      child: Stack(
        children: <Widget>[
          // Replace this container with your Map widget
          Container(

            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                bottomRight:Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 15,
            left: 15,
            child: GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left:18.0),
                          child: Text("Search",style: TextStyle(color: Colors.black45),),
                        )
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: IconButton(icon: Icon(Icons.search,color: Colors.red,), onPressed: null)
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  CreateBanner() {
    final List<Widget> imagesSlides= _homePageBloc.bannerFood.map((item) =>GestureDetector(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Stack(
              children: <Widget>[
                Image.network("https://www.gstatic.com/mobilesdk/160503_mobilesdk/logo/2x/firebase_28dp.png", fit: BoxFit.cover, width: 1000.0),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      '${item.name}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
        ),
      ),
    )
    ).toList();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        child: Column(
           children: [
             CarouselSlider(
                 options:CarouselOptions(
                   autoPlay: true,
                   aspectRatio: 2.0,
                   enlargeCenterPage: true,
                   enlargeStrategy: CenterPageEnlargeStrategy.height,
                 ),
               items: imagesSlides,
             ),
           ],
        ),
      ),
    );
  }
}
