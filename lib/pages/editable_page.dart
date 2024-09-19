import 'package:blogapp/blog_repository.dart';
import 'package:blogapp/model/blog_model.dart';
import 'package:blogapp/routing/app_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class EditBlogPage extends StatefulWidget {
  final id;
  const EditBlogPage(this.id, {super.key});

  @override
  State<EditBlogPage> createState() => EditBlogPageState();
}

class EditBlogPageState extends State<EditBlogPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController bloggerController = TextEditingController();

  TextEditingController dateController = TextEditingController();
  FocusNode dateFocusNode = FocusNode();

  final blogController = Get.find<BlogRepository>();

  bool uploaded = false;
  static BuildContext? get ctx =>
      MyAppRouter.router.routerDelegate.navigatorKey.currentContext;
  DateTime? picked;
  late String _date;
  late List<String> _YYMMDD;

  void _datePicker() async {
    picked = await showDatePicker(
        context: context,
        initialDate: blogController.blogg.date!.isEmpty
            ? DateTime.now()
            : DateTime.parse(blogController.blogg.date.toString()),
        // initialDate: DateTime.now(),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(
                  onPrimary: Colors.white,
                  onSurface: Colors.indigo,
                  primary: Colors.indigo,
                ),
                dialogBackgroundColor: Colors.white,
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.indigo,
                        textStyle: const TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Colors.white,
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(50))))),
            child: child!,
          );
        });
    if (picked != null) {
      setState(() {
        picked = picked;
        _date = picked.toString().split(" ").first;
        _YYMMDD = _date.split("-");
        dateController.text = _YYMMDD[0] + "-" + _YYMMDD[1] + "-" + _YYMMDD[2];
      });
      print(picked);
      print(dateController.text);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // blogController.blogg = blogController.get;
    blogController.setBlogData = BlogModel();
    blogController.fetchParticularDocData(widget.id).then((value) {
        if (value == true) {
          titleController.text = blogController.blogg.title ?? '';
          descriptionController.text = blogController.blogg.description ?? '';
          bloggerController.text = blogController.blogg.blogger ?? '';
        } else {}
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    // titleController.text = blogController.blogg.title!;
    // descriptionController.text = blogController.blogg.description!;
    // bloggerController.text = blogController.blogg.blogger!;
    // descriptionController.text = blogController.dataList[int.parse(blogController.indexx.toString())].description!;
    return Scaffold(
      appBar: AppBar(
        title: ElevatedButton(
          onPressed: () {
            // blogController.ctxr = ctx as Rx<Rx<BuildContext?>>;
            debugPrint('scaffoldmessenger \n $ctx');
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('button clicked')));
          },
          child: const Center(child: Icon(Icons.add)),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(child: GetBuilder<BlogRepository>(builder: (controller) {
          if(controller.blogg.id != null){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                blogController.blogg.imageUrl != null
                    ? Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        height: deviceHeight * 0.25,
                        width: deviceHeight * 0.25,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                        ),
                        child: Center(
                          child: CachedNetworkImage(
                            imageUrl:
                            '${blogController.blogg.imageUrl}',
                            fit: BoxFit.fitWidth,
                            width: deviceHeight*0.25,
                            alignment: Alignment.center,
                            placeholder: (context, url) =>
                            Center(child: const CircularProgressIndicator(color: Colors.blue,strokeCap: StrokeCap.round,strokeWidth: 5,)),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                    : GestureDetector(
                  onTap: () {
                    blogController.uploadImage();
                    uploaded = true;
                  },
                  child: Container(
                    height: deviceHeight * 0.25,
                    width: deviceHeight * 0.25,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade500,
                        border: Border.all(
                            color: Colors.black,
                            width: 0.5,
                            strokeAlign: CircularProgressIndicator
                                .strokeAlignCenter)),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            size: 20,
                            color: Colors.white,
                          ),
                          Text(
                            'upload image',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  // height: deviceHeight * 0.05,
                  width: deviceWidth * 0.55,
                  child: Text(
                    'Title',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                    height: deviceHeight * 0.05,
                    width: deviceWidth * 0.55,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.24),
                          offset: const Offset(0, 0),
                        ),
                        BoxShadow(
                          color: Colors.white.withOpacity(1),
                          offset: const Offset(0, 0),
                          spreadRadius: -5,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: TextFormField(
                      onTap: () {},
                      // initialValue: blogController.blogg.title!,
                      controller: titleController,
                      // textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(color: Colors.orange),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'bali',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 5, vertical: 15),
                      ),
                    )),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  // height: deviceHeight * 0.05,
                  width: deviceWidth * 0.55,
                  child: Text(
                    'Description',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                    height: deviceHeight * 0.05,
                    width: deviceWidth * 0.55,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.24),
                          offset: const Offset(0, 0),
                        ),
                        BoxShadow(
                          color: Colors.white.withOpacity(1),
                          offset: const Offset(0, 0),
                          spreadRadius: -5,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: TextFormField(
                      onTap: () {},
                      // initialValue: blogController.blogg.description!,
                      controller: descriptionController,
                      // textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(color: Colors.orange),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'vacation in nature',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 5, vertical: 15),
                      ),
                    )),
                const SizedBox(
                  height: 4,
                ),
                SizedBox(
                  // height: deviceHeight * 0.05,
                  width: deviceWidth * 0.55,
                  child: Text(
                    'blogger',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                    height: deviceHeight * 0.05,
                    width: deviceWidth * 0.55,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.24),
                          offset: const Offset(0, 0),
                        ),
                        BoxShadow(
                          color: Colors.white.withOpacity(1),
                          offset: const Offset(0, 0),
                          spreadRadius: -5,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: TextFormField(
                      onTap: () {},
                      // initialValue: blogController.blogg.blogger!,
                      controller: bloggerController,
                      // textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(color: Colors.orange),
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'alex parker',
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 5, vertical: 15)),
                    )),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  // height: deviceHeight * 0.05,
                  width: deviceWidth * 0.55,
                  child: Text(
                    'date',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  height: 45,
                  width: deviceWidth * 0.55,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.24),
                        offset: const Offset(0, 0),
                      ),
                      BoxShadow(
                        color: Colors.white.withOpacity(1),
                        offset: const Offset(0, 0),
                        spreadRadius: -5,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: TextField(
                    focusNode: dateFocusNode,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                    cursorColor: Colors.grey,
                    controller: dateController,
                    obscureText: false,
                    minLines: 1,
                    maxLines: 1,
                    onTap: _datePicker,
                    readOnly: true,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: _datePicker,
                        icon: const Icon(Icons.calendar_month_outlined),
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      fillColor: Colors.transparent,
                      filled: true,
                      hintText: blogController.blogg.date,
                      hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(0.8),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                /// add_blog_Button : adding blog to firebase_firestore collection named "blogs"

                SizedBox(
                  height: deviceHeight * 0.05,
                  width: deviceWidth * 0.55,
                  child: ElevatedButton(
                    onPressed: () {
                      if (titleController.text.isNotEmpty &&
                          descriptionController.text.isNotEmpty &&
                          bloggerController.text.isNotEmpty &&
                          blogController.imgUrls.value.isNotEmpty) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Obx(() {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(8)),
                                alignment: Alignment.center,
                                content: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    blogController.imgUrls.isNotEmpty
                                        ? Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          height:
                                          deviceHeight * 0.2,
                                          width: deviceHeight * 0.2,
                                          decoration: BoxDecoration(
                                              color: Colors
                                                  .lightGreenAccent,
                                              border: Border.all(
                                                  color:
                                                  Colors.black,
                                                  width: 0.5,
                                                  strokeAlign:
                                                  CircularProgressIndicator
                                                      .strokeAlignCenter)),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .center,
                                              children: [
                                                SizedBox(
                                                    height: 80,
                                                    width: 80,
                                                    child:
                                                    CachedNetworkImage(
                                                      imageUrl:
                                                      '${blogController.imgUrls}',
                                                      fit: BoxFit
                                                          .fitHeight,
                                                      placeholder: (context,
                                                          url) =>
                                                      const CircularProgressIndicator(),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                        Transform.translate(
                                            offset: const Offset(
                                                90, -90),
                                            child: SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: IconButton(
                                                onPressed: () {
                                                  blogController
                                                      .imgUrls
                                                      .value = "";
                                                },
                                                style: IconButton.styleFrom(
                                                    backgroundColor:
                                                    Colors
                                                        .lightGreenAccent,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal:
                                                        0,
                                                        vertical:
                                                        0),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            8))),
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                  size: 16,
                                                ),
                                              ),
                                            )),
                                      ],
                                    )
                                        : GestureDetector(
                                      onTap: () {
                                        blogController
                                            .uploadImage();
                                        uploaded = true;
                                      },
                                      child: Container(
                                        height: deviceHeight * 0.2,
                                        width: deviceHeight * 0.2,
                                        decoration: BoxDecoration(
                                            color: Colors
                                                .grey.shade500,
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 0.5,
                                                strokeAlign:
                                                CircularProgressIndicator
                                                    .strokeAlignCenter)),
                                        child: const Center(
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .center,
                                            children: [
                                              Icon(
                                                Icons.image,
                                                size: 20,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                'upload image',
                                                style: TextStyle(
                                                    color: Colors
                                                        .white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                    FontWeight
                                                        .w300),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    SizedBox(
                                      // height: deviceHeight * 0.05,
                                      width: deviceWidth * 0.6,
                                      child: Text(
                                        'Title',
                                        style: TextStyle(
                                            color: Colors.black
                                                .withOpacity(0.8),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Container(
                                        height: deviceHeight * 0.05,
                                        width: deviceWidth * 0.6,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                offset:
                                                const Offset(1, 2),
                                                blurRadius: 10,
                                                spreadRadius: 2,
                                              ),
                                              BoxShadow(
                                                color: Colors.white
                                                    .withOpacity(0.6),
                                                offset:
                                                const Offset(-1, -2),
                                                blurRadius: 2,
                                                spreadRadius: 2,
                                              )
                                            ]),
                                        child: TextFormField(
                                          onTap: () {},
                                          controller: titleController,
                                          // textAlign: TextAlign.start,
                                          textAlignVertical:
                                          TextAlignVertical.center,
                                          style: const TextStyle(
                                              color: Colors.orange),
                                          decoration:
                                          const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'bali',
                                          ),
                                        )),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    SizedBox(
                                      // height: deviceHeight * 0.05,
                                      width: deviceWidth * 0.6,
                                      child: Text(
                                        'Description',
                                        style: TextStyle(
                                          color: Colors.black
                                              .withOpacity(0.8),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Container(
                                        height: deviceHeight * 0.05,
                                        width: deviceWidth * 0.6,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                offset:
                                                const Offset(1, 2),
                                                blurRadius: 10,
                                                spreadRadius: 2,
                                              ),
                                              BoxShadow(
                                                color: Colors.white
                                                    .withOpacity(0.6),
                                                offset:
                                                const Offset(-1, -2),
                                                blurRadius: 2,
                                                spreadRadius: 2,
                                              )
                                            ]),
                                        child: TextFormField(
                                          onTap: () {},
                                          controller:
                                          descriptionController,
                                          // textAlign: TextAlign.start,
                                          textAlignVertical:
                                          TextAlignVertical.center,
                                          style: const TextStyle(
                                              color: Colors.orange),
                                          decoration:
                                          const InputDecoration(
                                            border: InputBorder.none,
                                            hintText:
                                            'vacation in nature',
                                          ),
                                        )),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    SizedBox(
                                      // height: deviceHeight * 0.05,
                                      width: deviceWidth * 0.6,
                                      child: Text(
                                        'blogger',
                                        style: TextStyle(
                                          color: Colors.black
                                              .withOpacity(0.8),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Container(
                                        height: deviceHeight * 0.05,
                                        width: deviceWidth * 0.6,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.4),
                                                offset:
                                                const Offset(1, 2),
                                                blurRadius: 10,
                                                spreadRadius: 2,
                                              ),
                                              BoxShadow(
                                                color: Colors.white
                                                    .withOpacity(0.6),
                                                offset:
                                                const Offset(-1, -2),
                                                blurRadius: 2,
                                                spreadRadius: 2,
                                              )
                                            ]),
                                        child: TextFormField(
                                          onTap: () {},
                                          controller: bloggerController,
                                          // textAlign: TextAlign.start,
                                          textAlignVertical:
                                          TextAlignVertical.center,
                                          style: const TextStyle(
                                              color: Colors.orange),
                                          decoration:
                                          const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'alex parker',
                                          ),
                                        )),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    SizedBox(
                                      // height: deviceHeight * 0.05,
                                      width: deviceWidth * 0.6,
                                      child: Text(
                                        'date',
                                        style: TextStyle(
                                          color: Colors.black
                                              .withOpacity(0.8),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          height: 45,
                                          width: deviceWidth * 0.55,
                                          decoration: BoxDecoration(
                                            color: Colors.white
                                                .withOpacity(0.15),
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.24),
                                                offset:
                                                const Offset(0, 0),
                                              ),
                                              BoxShadow(
                                                color: Colors.white
                                                    .withOpacity(1),
                                                offset:
                                                const Offset(0, 0),
                                                spreadRadius: -5,
                                                blurRadius: 5,
                                              ),
                                            ],
                                          ),
                                          child: TextField(
                                            focusNode: dateFocusNode,
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            cursorColor: Colors.grey,
                                            controller: dateController,
                                            obscureText: false,
                                            minLines: 1,
                                            maxLines: 1,
                                            onTap: _datePicker,
                                            readOnly: true,
                                            decoration: InputDecoration(
                                              suffixIcon: IconButton(
                                                onPressed: _datePicker,
                                                icon: const Icon(Icons
                                                    .calendar_month_outlined),
                                              ),
                                              contentPadding:
                                              const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 15.0),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8),
                                              ),
                                              enabledBorder:
                                              OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8),
                                                borderSide:
                                                const BorderSide(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              focusedBorder:
                                              OutlineInputBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    8),
                                                borderSide:
                                                const BorderSide(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                              fillColor:
                                              Colors.transparent,
                                              filled: true,
                                              hintText: 'YYYY-MM-DD',
                                              hintStyle: TextStyle(
                                                color: Colors.grey
                                                    .withOpacity(0.8),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    SizedBox(
                                      height: deviceHeight * 0.05,
                                      width: deviceWidth * 0.55,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          blogController.createBlog(
                                              BlogModel(
                                                  title: titleController
                                                      .text
                                                      .toString(),
                                                  description:
                                                  descriptionController
                                                      .text
                                                      .toString(),
                                                  blogger: bloggerController
                                                      .text
                                                      .toString(),
                                                  date:
                                                  dateController
                                                      .text
                                                      .toString(),
                                                  imageUrl: blogController
                                                      .imgUrls
                                                      .toString()));
                                          blogController.imgUrls.value =
                                          "";
                                          titleController.text = "";
                                          descriptionController.text = "";
                                          bloggerController.text = "";
                                          context.pop();
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  4),
                                            ),
                                            backgroundColor: Colors.green,
                                            foregroundColor:
                                            Colors.white),
                                        child: const Text('add blog'),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    SizedBox(
                                      height: deviceHeight * 0.05,
                                      width: deviceWidth * 0.55,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // blogController.createBlog(BlogModel(title: titleController.text.toString(), description: descriptionController.text.toString(), blogger: bloggerController.text.toString(), date: dateController.text.toString(),imageUrl: blogController.imgUrls.toString()));
                                          context.pop();
                                          blogController.imgUrls.value =
                                          "";
                                          titleController.text = "";
                                          descriptionController.text = "";
                                          bloggerController.text = "";
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  4),
                                            ),
                                            backgroundColor: Colors.red,
                                            foregroundColor:
                                            Colors.white),
                                        child: const Text('Cancel'),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                          },
                        );
                      } else {
                        ScaffoldMessenger(
                            child: SnackBar(
                              content: const Text('enter data first!'),
                              backgroundColor: Colors.red,
                              action: SnackBarAction(
                                onPressed: () {
                                  context.pop(context);
                                },
                                label: 'Close',
                              ),
                            ));
                        // Get.snackbar('data error', 'enter data first!',
                        //     backgroundColor: Colors.red.withOpacity(0.8),
                        //     barBlur: 4,
                        //     colorText: Colors.white,
                        //     boxShadows: [
                        //       BoxShadow(
                        //           color: Colors.white.withOpacity(0.5),
                        //           offset: Offset(-2, -2),
                        //           blurRadius: 4,
                        //           spreadRadius: 1),
                        //       BoxShadow(
                        //           color: Colors.grey.withOpacity(0.5),
                        //           offset: Offset(2, 2),
                        //           blurRadius: 4,
                        //           spreadRadius: 1)
                        //     ]);
                        debugPrint('enter data first');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white),
                    child: const Text('add blog'),
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                /// fetch_All_Blogs_Button : fetching all blogs from firebase_firestore

                SizedBox(
                  height: deviceHeight * 0.05,
                  width: deviceWidth * 0.55,
                  child: ElevatedButton(
                    onPressed: () {
                      blogController.getAllBlogs();
                      // addBlog(titleController.text, descriptionController.text, bloggerController.text, dateController.text);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white),
                    child: const Text('fetch blogs'),
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                /// Upload_Button : upload image to firebase_storage

                SizedBox(
                  height: deviceHeight * 0.05,
                  width: deviceWidth * 0.55,
                  child: ElevatedButton(
                    onPressed: () {
                      blogController.uploadImage();
                      // addBlog(titleController.text, descriptionController.text, bloggerController.text, dateController.text);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white),
                    child: const Text('upload image'),
                  ),
                ),

                /// test :
                ElevatedButton(
                    onPressed: () {
                      debugPrint("${blogController.blogg}");
                    },
                    child: Text(
                        "fetch this document ${blogController.blogg.title}"))
              ],
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },)),
      ),
    );
  }
}
