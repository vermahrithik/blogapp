import 'package:flutter/material.dart';

class AddBlogPage extends StatefulWidget {
  const AddBlogPage({super.key});

  @override
  State<AddBlogPage> createState() => _AddBlogPageState();
}

class _AddBlogPageState extends State<AddBlogPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: deviceHeight * 0.41,
              width: deviceHeight * 0.41,
              decoration: BoxDecoration(
                  color: Colors.grey.shade500,
                  border: Border.all(
                      color: Colors.black,
                      width: 0.5,
                      strokeAlign:
                          CircularProgressIndicator.strokeAlignCenter)),
            child: Center(
              child :Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image,size: 20,color: Colors.white,),
                  Text('upload image',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w300),)
                ],
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
            const SizedBox(height: 16,),
            SizedBox(
              height: deviceHeight * 0.05,
              width: deviceWidth * 0.61,
              child: ElevatedButton(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white
                ),
                child: const Text('add blog'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
