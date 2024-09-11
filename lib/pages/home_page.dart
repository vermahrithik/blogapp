import 'package:blogapp/routing/app_route_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences.getInstance().then((value) => value.remove('isLoggedIn'),);
    context.goNamed(MyAppRouteConstants.loginRouteName);
    // SharedPreferences.getInstance().then((value) => value.setBool('isLoggedIn', true),);
  }


  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('home page',style: TextStyle(color: Colors.white),),
        actions: [
          SizedBox(
            height: 30,
            width: 100,
            child: ElevatedButton(
              onPressed: () {
                signOut();
              },
              child: const Text('SignOut'),
            ),
          ),
          const SizedBox(width: 20,),
        ],
      ),
      body: Center(
        child: SizedBox(
          width: deviceWidth,
          height: deviceHeight,
          child: GridView.builder(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 1.75,crossAxisSpacing: 8,mainAxisSpacing:8,crossAxisCount: deviceWidth>700?4:deviceWidth>500?2:1),
            scrollDirection: Axis.vertical,
              itemCount: 10,
              itemBuilder: (BuildContext context,index){
                return InkWell(
                  onTap: (){
                    context.goNamed(MyAppRouteConstants.addBlogRouteName);
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: deviceHeight>780?400:deviceHeight>480?300:200,
                          // width: MediaQuery.of(context).size.width*0.95,
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(image: AssetImage('images/bali.jpg'),alignment: Alignment.center,fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: deviceHeight>780?400:deviceHeight>480?300:200,
                          // width: MediaQuery.of(context).size.width*0.8,
                          // padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Marine Drive 2',style: TextStyle(color: Colors.white,fontSize: 28,fontWeight: FontWeight.w600),),
                                Text('Marine Drive 2',style: TextStyle(color: Colors.white.withOpacity(0.8),fontSize: 18,fontWeight: FontWeight.w300),),
                                Text('Anthony Prabhakar',style: TextStyle(color: Colors.white.withOpacity(0.6),fontSize: 10,fontWeight: FontWeight.w300),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                );
              }
          ),
        )
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          onPressed: (){
            context.goNamed(MyAppRouteConstants.addBlogRouteName);
          },
          elevation: 2,
          backgroundColor: Colors.cyan,
          child: Icon(Icons.add,color: Colors.white,size: 18,),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
