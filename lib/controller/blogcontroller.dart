// import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:blogapp/model/moviedetailmodel.dart';
import 'package:blogapp/model/blog_model.dart';

enum Status {success, loading, failed, networkError}

class MovieController extends GetxController {
  final allMoviesPage = 1.obs;
  final areMoreMoviesAvailable = true.obs;
  final moviesStatus = Status.success.obs;
  final movies = <MovieModel>[].obs;


  Future<void> apiCall() async {

    allMoviesPage.value == 1 ? moviesStatus.value = Status.loading : moviesStatus.value = Status.success;

    if(areMoreMoviesAvailable.value){
      try {
        final dio = Dio();
        debugPrint("Api is calling with : Page : ${allMoviesPage.value}");
        final response = await dio.get(
          'https://api.themoviedb.org/3/trending/movie/day?language=en-US&api_key=7a3bd5d5f83da1324e1bfdf75f2a665c&page=$allMoviesPage',
        );
        debugPrint(response.statusCode.toString());
        if(response.statusCode == 200){
          moviesStatus.value = Status.success;
          areMoreMoviesAvailable.value = response.data['results'].length == 20;
          if(allMoviesPage.value == 1){
            movies.value = response.data['results'].map<MovieModel>((movie)=> MovieModel.fromJson(movie)).toList();
          }else{
            debugPrint("In page WITH CONDITION : ${allMoviesPage.value}");
            movies.addAll(response.data['results'].map<MovieModel>((movie)=> MovieModel.fromJson(movie)).toList());
          }
          allMoviesPage.value++;
          update();
        }
      } catch (e) {
        debugPrint("Error in calling api :: $e");
        moviesStatus.value== Status.failed;
      }
    }else{
      debugPrint("Are more not available movies");
    }

    // debugPrint(movies.toString());
  }
}

// class MovieDetailsController extends GetxController {
//   MovieDetailModel movieDetails = MovieDetailModel();
//   final String id;
//
//   MovieDetailsController({required this.id});
//
//   Future<void> apiDetailCall(String id) async {
//     try {
//       final dio = Dio();
//       final response = await dio.get(
//         'https://api.themoviedb.org/3/movie/$id?api_key=7a3bd5d5f83da1324e1bfdf75f2a665c',
//       );
//       debugPrint("In movie detail page");
//       debugPrint(response.statusCode.toString());
//
//       if(response.statusCode == 200 || response.statusCode == 202){
//         debugPrint("Print Data : ${response.data}");
//         MovieDetailModel data = MovieDetailModel.fromJson(response.data as Map<String,dynamic>);
//         debugPrint("Converted to $data and one vaue : ${data.backdrop_path}" );
//         movieDetails = data;
//         update();
//       }else{
//         debugPrint("SMW");
//       }
//
//     } catch (e) {
//       debugPrint("Error in calling API :: $e");
//     }
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     apiDetailCall(id);
//   }
// }