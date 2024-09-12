// import 'package:cloud_firestore/cloud_firestore.dart';
//
// final _db = FirebaseFirestore.instance;
//
// Future<void> addBlog(String title, String description, String blogger, String date) {
//   CollectionReference blogs = _db.collection('blogs');
//
//   return blogs.add({
//     'title': title,
//     'description': description,
//     'blogger': blogger,
//     'date': date,
//   })
//       .then((value) => print("Blog added successfully!"))
//       .catchError((error) => print("Failed to add blog: $error"));
// }
//
// Future<void> fetchBlogs() {
//   CollectionReference blogs = _db.collection('blogs');
//
//   return blogs.get()
//       .then((QuerySnapshot snapshot) {
//     snapshot.docs.forEach((doc) {
//       print('${doc.id} => ${doc.data()}');
//     });
//   })
//       .catchError((error) => print("Failed to fetch blogs: $error"));
// }