import 'package:shared_preferences/shared_preferences.dart';

//==========================================================================================================================================================

// Class responsible for caching data using shared preferences
class CacheHelpher {
  // Shared preferences instance
  static SharedPreferences? sharedPre;

  // Method to initialize the shared preferences instance
  static init() async {
    sharedPre = await SharedPreferences.getInstance();
  }

//==========================================================================================================================================================

  // Method to store boolean data in the cache
  static Future<bool> putData({
    required String key, // Key under which the data will be stored
    required bool value, // Boolean value to be stored
  }) async {
    return await sharedPre!.setBool(key, value); // Store the boolean value under the specified key
  }

//==========================================================================================================================================================

  // Method to retrieve boolean data from the cache
  static bool? getData({
    required String key, // Key under which the data is stored
  }) {
    return sharedPre!.getBool(key); // Retrieve and return the boolean value associated with the specified key
  }

//==========================================================================================================================================================
}

//==========================================================================================================================================================
