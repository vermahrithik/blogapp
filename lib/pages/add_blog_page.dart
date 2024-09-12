import 'package:blogapp/blog_repository.dart';
import 'package:blogapp/model/blog_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBlogPage extends StatefulWidget {
  const AddBlogPage({super.key});

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController bloggerController = TextEditingController();

  final BlogRepository blogController = Get.find<BlogRepository>();

  TextEditingController dateController = TextEditingController();
  FocusNode dateFocusNode = FocusNode();

  bool uploaded =false;

  DateTime? picked ;
  late String _date ;
  late List<String> _YYMMDD;
  void _datePicker() async{
    picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
                colorScheme:  const ColorScheme.light(
                  onPrimary: Colors.white,
                  onSurface: Colors.indigo,
                  primary: Colors.indigo,
                ),
                dialogBackgroundColor: Colors.white,
                textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.indigo, textStyle:  TextStyle(
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
        }
    );
    if (picked != null) {
      setState(() {
        picked = picked;
        _date = picked.toString().split(" ").first;
        _YYMMDD=_date.split("-");
        dateController.text= _YYMMDD[0]+"-"+_YYMMDD[1]+"-"+_YYMMDD[2];
      });
      print(picked);
      print(dateController.text);
    }
  }


  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Obx((){
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              blogController.imgUrls.value.isNotEmpty?
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: deviceHeight * 0.41,
                    width: deviceHeight * 0.41,
                    decoration: BoxDecoration(
                        color: Colors.lightGreenAccent,
                        border: Border.all(
                            color: Colors.black,
                            width: 0.5,
                            strokeAlign:
                            CircularProgressIndicator.strokeAlignCenter)),
                    child: Center(
                      child :Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 80,
                              width: 80,
                              child: Image.network('${Uri.parse(blogController.imgUrls.value)}',fit: BoxFit.fitHeight,alignment: Alignment.center,)
                          )
                        ],
                      ),
                    ),
                  ),
                  Transform.translate(
                      offset: const Offset(180, -180),
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: IconButton(
                          onPressed: (){
                            blogController.imgUrls.value="";
                          },
                          style: IconButton.styleFrom(
                              backgroundColor: Colors.lightGreenAccent,
                              padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 0),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                          ),
                          icon: const Icon(Icons.close,color: Colors.red,size: 16,),
                        ),
                      )
                  ),
                ],
              ):GestureDetector(
                  onTap: (){
                    blogController.uploadImage();
                    uploaded = true;
                  },
                  child: Container(
                  height: deviceHeight * 0.41,
                  width: deviceHeight * 0.41,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade500,
                      border: Border.all(
                          color: Colors.black,
                          width: 0.5,
                          strokeAlign:
                          CircularProgressIndicator.strokeAlignCenter)),
                  child: const Center(
                    child :Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.image,size: 20,color: Colors.white,),
                        Text('upload image',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w300),)
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4,),
              SizedBox(
                // height: deviceHeight * 0.05,
                width: deviceWidth * 0.6,
                child: Text(
                  'Title',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 18,
                      fontWeight: FontWeight.w300),
                ),
              ),
              const SizedBox(height: 4,),
              Container(
                  height: deviceHeight * 0.05,
                  width: deviceWidth * 0.6,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          offset: const Offset(1, 2),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                        BoxShadow(
                          color: Colors.white.withOpacity(0.6),
                          offset: const Offset(-1, -2),
                          blurRadius: 2,
                          spreadRadius: 2,
                        )
                      ]
                  ),
                  child: TextFormField(
                    onTap: () {},
                    controller: titleController,
                    // textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(color: Colors.orange),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'bali',
                    ),
                  )),
              const SizedBox(height: 4,),
              SizedBox(
                // height: deviceHeight * 0.05,
                width: deviceWidth * 0.6,
                child: Text(
                  'Description',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(height: 4,),
              Container(
                  height: deviceHeight * 0.05,
                  width: deviceWidth * 0.6,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          offset: const Offset(1, 2),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                        BoxShadow(
                          color: Colors.white.withOpacity(0.6),
                          offset: const Offset(-1, -2),
                          blurRadius: 2,
                          spreadRadius: 2,
                        )
                      ]
                  ),
                  child: TextFormField(
                    onTap: () {},
                    controller: descriptionController,
                    // textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(color: Colors.orange),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'vacation in nature',
                    ),
                  )),
              const SizedBox(height: 4,),
              SizedBox(
                // height: deviceHeight * 0.05,
                width: deviceWidth * 0.6,
                child: Text(
                  'blogger',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(height: 4,),
              Container(
                  height: deviceHeight * 0.05,
                  width: deviceWidth * 0.6,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          offset: const Offset(1, 2),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                        BoxShadow(
                          color: Colors.white.withOpacity(0.6),
                          offset: const Offset(-1, -2),
                          blurRadius: 2,
                          spreadRadius: 2,
                        )
                      ]
                  ),
                  child: TextFormField(
                    onTap: () {},
                    controller: bloggerController,
                    // textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.center,
                    style: const TextStyle(color: Colors.orange),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'alex parker',
                    ),
                  )),
              const SizedBox(height: 16,),
              Stack(
                children: [
                  Container(
                    height: 45,
                    width: deviceWidth*0.61,
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
                      style: TextStyle(
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
                          icon: Icon(Icons.calendar_month_outlined),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        fillColor: Colors.transparent,
                        filled: true,
                        hintText: 'xx-xx-xxxx',
                        hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16,),
              SizedBox(
                height: deviceHeight * 0.05,
                width: deviceWidth * 0.61,
                child: ElevatedButton(
                  onPressed: (){
                    blogController.createBlog(BlogModel(title: titleController.text.toString(), description: descriptionController.text.toString(), blogger: bloggerController.text.toString(), date: dateController.text.toString(),));
                    // addBlog(titleController.text, descriptionController.text, bloggerController.text, dateController.text);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white
                  ),
                  child: const Text('add blog'),
                ),
              ),
              const SizedBox(height: 16,),
              SizedBox(
                height: deviceHeight * 0.05,
                width: deviceWidth * 0.61,
                child: ElevatedButton(
                  onPressed: (){
                    blogController.getAllBlogs();
                    // addBlog(titleController.text, descriptionController.text, bloggerController.text, dateController.text);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white
                  ),
                  child: const Text('fetch blogs'),
                ),
              ),
              const SizedBox(height: 16,),
              SizedBox(
                height: deviceHeight * 0.05,
                width: deviceWidth * 0.61,
                child: ElevatedButton(
                  onPressed: (){
                    blogController.uploadImage();
                    // addBlog(titleController.text, descriptionController.text, bloggerController.text, dateController.text);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white
                  ),
                  child: const Text('upload image'),
                ),
              ),
            ],
          ),
        );
      })
    );
  }
}
