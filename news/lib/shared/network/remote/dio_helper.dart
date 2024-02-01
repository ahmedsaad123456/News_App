// Import the dio package for making HTTP requests
import 'package:dio/dio.dart';

//==========================================================================================================================================================

// Class responsible for making HTTP requests using Dio
class DioHelper {
  // Dio instance for making HTTP requests
  static Dio? dio;

//==========================================================================================================================================================

  // Method to initialize Dio with base options
  static init() {
    // Create a new Dio instance with base options including base URL and error handling settings
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org/', // Base URL for API requests
        receiveDataWhenStatusError: true, // Receive response data even when the request returns an error status code
      ),
    );
  }

  //==========================================================================================================================================================

  // Method to make a GET request and retrieve data from the specified URL with query parameters
  static Future<Response> getData({
    required String url, // URL for the GET request
    required Map<String, dynamic> query, // Query parameters to be included in the request
  }) async {
    return await dio!.get(url, queryParameters: query); // Send the GET request with the specified URL and query parameters, and return the response
  }

  //==========================================================================================================================================================
}

//==========================================================================================================================================================


// url : https://newsapi.org/v2/top-headlines?country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca

// baseUrl : https://newsapi.org/
// method : v2/top-headlines?
// queryParameters : country=eg&category=business&apiKey=65f7f556ec76449fa7dc7c0069f040ca