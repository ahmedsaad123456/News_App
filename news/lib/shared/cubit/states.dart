// Abstract class representing the various states for news-related operations
abstract class NewsStates {}

// Initial state for news-related operations
class NewsInitialState extends NewsStates {}

// State indicating a change in the bottom navigation bar index
class NewsBottomNavState extends NewsStates {}

//==========================================================================================================================================================

// State indicating successful retrieval of business news data
class NewsGetBusinessSuccessState extends NewsStates {}

// State indicating an error while retrieving business news data
class NewsGetBusinessErrorState extends NewsStates {
  final String error;

  NewsGetBusinessErrorState(this.error);
}

// State indicating loading of business news data
class NewsLoadingBusinessState extends NewsStates {}

//==========================================================================================================================================================

// State indicating successful retrieval of sports news data
class NewsGetSportsSuccessState extends NewsStates {}

// State indicating an error while retrieving sports news data
class NewsGetSportsErrorState extends NewsStates {
  final String error;

  NewsGetSportsErrorState(this.error);
}

// State indicating loading of sports news data
class NewsLoadingSportsState extends NewsStates {}

//==========================================================================================================================================================

// State indicating successful retrieval of science news data
class NewsGetScienceSuccessState extends NewsStates {}

// State indicating an error while retrieving science news data
class NewsGetScienceErrorState extends NewsStates {
  final String error;

  NewsGetScienceErrorState(this.error);
}

// State indicating loading of science news data
class NewsLoadingScienceState extends NewsStates {}

//==========================================================================================================================================================

// State indicating successful retrieval of search results
class NewsGetSearchSuccessState extends NewsStates {}

// State indicating an error while retrieving search results
class NewsGetSearchErrorState extends NewsStates {
  final String error;

  NewsGetSearchErrorState(this.error);
}

// State indicating loading of search results
class NewsLoadingSearchState extends NewsStates {}

//==========================================================================================================================================================

// Abstract class representing the various states for dark mode operations
abstract class DarkStates {}

// Initial state for dark mode operations
class DarkInitialState extends DarkStates {}

// State indicating a change in dark mode
class DarkcChangeState extends DarkStates {}
