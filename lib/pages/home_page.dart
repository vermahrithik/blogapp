import 'package:blogapp/blog_repository.dart';
import 'package:blogapp/model/blog_model.dart';
import 'package:blogapp/routing/app_route_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final blogController = Get.find<BlogRepository>();

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    SharedPreferences.getInstance().then(
      (value) => value.remove('isLoggedIn'),
    );
    context.goNamed(MyAppRouteConstants.loginRouteName);
    // SharedPreferences.getInstance().then((value) => value.setBool('isLoggedIn', true),);
  }

  Future<void> _refresh() {
    return Future.delayed(
      Duration(seconds: 2),
      () {
        // context.goNamed(MyAppRouteConstants.splashScreenRouteName);
        debugPrint('refreshed content');
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    blogController.fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Colors.black, Colors.transparent
                ]
            ),
          ),
        ),
        title: const Text(
          'home page',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          SizedBox(
            height: 30,
            width: 100,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 0)),
              onPressed: () {
                signOut();
              },
              child: const Text('SignOut'),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Center(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('images/bali.jpg'),alignment: Alignment.center,fit: BoxFit.cover),
            ),
        child: RefreshIndicator(
            onRefresh: _refresh,
            child: Obx(
              () {
                return blogController.dataList.isEmpty
                    ? const Center(child: CircularProgressIndicator(strokeWidth: 8,color: Colors.blue,strokeCap: StrokeCap.round,))
                    : GridView.builder(
                        padding: const EdgeInsets.all(8),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.75,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            crossAxisCount: deviceWidth > 700
                                ? 4
                                : deviceWidth > 500
                                    ? 2
                                    : 1),
                        scrollDirection: Axis.vertical,
                        itemCount: blogController.dataList.length,
                        itemBuilder: (BuildContext context, index) {
                          return InkWell(
                            onTap: () {
                              // // debugPrint("${blogController.dataList[index].id}");
                              // // blogController.blogg =
                              // // blogController.dataList[index];
                              // // blogController.indexx = index.toString();
                              // blogController.fetchParticularDocData("${blogController.dataList[index].id}");
                              showDialog(context: context,
                                  builder: (ctx){
                                return Obx((){
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8)),
                                      alignment: Alignment.center,
                                      content: Container(
                                        width: deviceWidth*0.6,
                                        height: deviceHeight*0.2,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text('do you really want to edit the blog "${blogController.dataList[index].title}"?'),
                                            SizedBox(
                                              height: 25,
                                              width: 100,
                                              child: ElevatedButton(
                                                  onPressed: (){
                                                    Navigator.pop(ctx);
                                                    context.pushNamed(
                                                        MyAppRouteConstants.editBlogRouteName,pathParameters: {'id':'${blogController.dataList[index].id}'});
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      padding: EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                                                      backgroundColor: Colors.amberAccent,
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                      foregroundColor: Colors.white
                                                  ),
                                                  child: Text('Update')
                                              ),
                                            ),
                                            SizedBox(
                                              width: 4,
                                            ),
                                            SizedBox(
                                              width: 100,
                                              height: 25,
                                              child: ElevatedButton(
                                                  onPressed: (){
                                                    Navigator.pop(ctx);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                                                      backgroundColor: Colors.redAccent,
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                      foregroundColor: Colors.white
                                                  ),
                                                  child: Text('cancel')
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                                },
                              );
                            },
                            onLongPress: () {
                              debugPrint(
                                  '${blogController.dataList[index].id}');
                            },
                            child:
                            Stack(alignment: Alignment.center, children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  height: deviceHeight > 780
                                      ? 400
                                      : deviceHeight > 480
                                      ? 300
                                      : 200,
                                  width: MediaQuery.of(context).size.width * 0.95,
                                  // padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.8),
                                    // backgroundBlendMode: BlendMode.color
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  height: deviceHeight > 780
                                      ? 400
                                      : deviceHeight > 480
                                      ? 300
                                      : 200,
                                  width:
                                  MediaQuery.of(context).size.width * 0.95,
                                  decoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  // child: Image.network(blogController.dataList[index].imageUrl.toString()),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                    '${blogController.dataList[index].imageUrl}',
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                    // placeholder: (context, url) =>
                                    //     const Center(child: CircularProgressIndicator(color: Colors.blue,strokeCap: StrokeCap.round,strokeWidth: 8,)),
                                    errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                  ),
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  height: deviceHeight > 780
                                      ? 400
                                      : deviceHeight > 480
                                      ? 300
                                      : 200,
                                  width: MediaQuery.of(context).size.width * 0.95,
                                  // padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.4),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${blogController.dataList[index].title}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: deviceWidth > 700
                                                  ? 18
                                                  : deviceWidth > 500
                                                  ? 23
                                                  : 28,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          '${blogController.dataList[index].description}',
                                          style: TextStyle(
                                              color:
                                              Colors.white.withOpacity(0.8),
                                              fontSize: deviceWidth > 700
                                                  ? 15
                                                  : deviceWidth > 500
                                                  ? 20
                                                  : 25,
                                              fontWeight: FontWeight.w300),
                                        ),
                                        Text(
                                          '${blogController.dataList[index].blogger}',
                                          style: TextStyle(
                                              color:
                                              Colors.white.withOpacity(0.6),
                                              fontSize: deviceWidth > 700
                                                  ? 12
                                                  : deviceWidth > 500
                                                  ? 17
                                                  : 22,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          );
                        });
              },
            )),
      )),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton(
          onPressed: () {
            context.pushNamed(MyAppRouteConstants.addBlogRouteName);
          },
          elevation: 2,
          backgroundColor: Colors.cyan,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 18,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
