import 'dart:io';
import 'package:blogapp/model/blog_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';

class BlogRepository extends GetxController {
  static BlogRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // adding blog to collection :
  createBlog(BlogModel blog) async {
    await _db
        .collection('blogs')
        .add(blog.toJson())
        .whenComplete(() => debugPrint('success'))
        .catchError((error, stackTrace) {
      debugPrint('error inside : ${error.toString()}');
      // debugPrint('error outside : ${error.toString()}');
      return error.toString();
    });
  }

  // fetching blogs from collection :
  Future<List<BlogModel>> getAllBlogs() async {
    final snapshot = await _db.collection('blogs').get();
    final blogData =
        snapshot.docs.map((e) => BlogModel.fromJson(e.data())).toList();
    debugPrint('${blogData.map((e) => e.title).toList()}');
    return blogData;
  }

  final firebaseStorage = FirebaseStorage.instance;

  final imgUrls ="".obs;

  final isLoading = false.obs;
  final isUploading = false.obs;

  Future<void> fetchImages() async {
    isLoading.value = true;
    final ListResult result =
        await firebaseStorage.ref('uploaded_images/').listAll();
    final url =
        await Future.wait(result.items.map((ref) => ref.getDownloadURL()));
    imgUrls.value = url[0];
    isLoading.value = false;
  }
  /// download particular image , link :
  /// https://firebasestorage.googleapis.com/v0/b/blogapp-9a39e.appspot.com/o/uploaded_images%2F2024-09-12T14%3A45%3A20.628.jpg?alt=media&token=77590917-8f30-488e-89d6-9fa540e11cb5

  // if(KIsWeb){
  //
  // }
  /// ------------------------------------------------------------
  // Future<void> uploadImage() async {
  //   _isUploading = true;
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //   final defaultPlatform = TargetPlatform.windows;
  //   if(defaultPlatform == TargetPlatform.windows){
  //     if (image == null) {
  //       return;
  //     }
  //     File file = File(image.path);
  //
  //     try {
  //       String filePath = 'uploaded_images/${DateTime.now()}.jpg';
  //
  //       await firebaseStorage.ref(filePath).putFile(file);
  //
  //       String downloadUrl = await firebaseStorage.ref(filePath).getDownloadURL();
  //       _imgUrls.add(downloadUrl);
  //     } catch (e) {
  //       print("Error uploading..$e");
  //     } finally {
  //       _isUploading = false;
  //     }
  //   }
  // }

  Future<void> uploadImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    }

    try {
      isUploading.value = true;
      // For web platform
      if (kIsWeb) {
        final fileBytes = await image.readAsBytes();
        String filePath = 'uploaded_images/${DateTime.now().toIso8601String()}.jpg';

        await firebaseStorage.ref(filePath).putData(fileBytes,SettableMetadata(contentType: 'image/jpeg'));

        String downloadUrl = await firebaseStorage.ref(filePath).getDownloadURL();
        imgUrls.value = downloadUrl;
        debugPrint('uploaded from if(kWeb) ${imgUrls.value}');
      }
      // For mobile and desktop platforms
      else {
        File file = File(image.path);
        String filePath = 'uploaded_images/${DateTime.now()}.jpg';

        await firebaseStorage.ref(filePath).putFile(file);

        String downloadUrl = await firebaseStorage.ref(filePath).getDownloadURL();
        imgUrls.value = downloadUrl;
        debugPrint('uploaded from else{}');
      }
    } catch (e) {
      print("Error uploading..$e");
    } finally {
      isUploading.value = false;
    }
  }

}
