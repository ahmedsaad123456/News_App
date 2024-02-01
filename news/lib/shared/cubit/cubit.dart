import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/business/business_screen.dart';
import 'package:news/modules/science/science_screen.dart';
import 'package:news/modules/sports/sports_screen.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/shared/network/local/cache_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';

//==========================================================================================================================================================
// Cubit responsible for managing state related to news screens and data fetching

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  // Static method to get NewsCubit instance from context
  static NewsCubit get(context) => BlocProvider.of(context);

  // List of screens to be displayed in the bottom navigation bar
  List<Widget> screens = [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
  ];

  int index = 0; // Index of the current screen

  // List of BottomNavigationBarItems for the bottom navigation bar
  List<BottomNavigationBarItem> bottomitems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: 'Business'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];

  //==========================================================================================================================================================
  // Method to change the index of the current screen
  void changeIndex(int newIndex) {
    index = newIndex;
    emit(NewsBottomNavState());
  }

  //==========================================================================================================================================================
  // Methods to fetch data for different categories: business, sports, and science
  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsLoadingBusinessState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      emit(NewsGetBusinessErrorState(error));
    });
  }

  List<dynamic> sports = [];
  void getsports() {
    emit(NewsLoadingSportsState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      sports = value.data['articles'];
      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      emit(NewsGetSportsErrorState(error));
    });
  }

  List<dynamic> science = [];
  void getScience() {
    emit(NewsLoadingScienceState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      science = value.data['articles'];
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      emit(NewsGetScienceErrorState(error));
    });
  }

  //==========================================================================================================================================================
  // Method to fetch search results
  List<dynamic> search = [];
  void getSearch(String value) async {
    emit(NewsLoadingSearchState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': value,
        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      emit(NewsGetSearchErrorState(error));
    });
  }
}

//==========================================================================================================================================================

// Cubit responsible for managing dark mode state
class DarkCubit extends Cubit<DarkStates> {
  DarkCubit() : super(DarkInitialState());

  // Static method to get DarkCubit instance from context
  static DarkCubit get(context) => BlocProvider.of(context);

  bool isDark = false; // Current dark mode state

  // Method to toggle dark mode
  void changeAppMode({bool? isShared}) {
    if (isShared != null) {
      isDark = isShared;
      emit(DarkcChangeState());
    } else {
      isDark = !isDark;

      // Save the new dark mode state to local storage
      CacheHelpher.putData(key: 'isDark', value: isDark).then((value) {
        emit(DarkcChangeState());
      });
    }
  }
}

//==========================================================================================================================================================
