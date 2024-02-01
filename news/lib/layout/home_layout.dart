import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/modules/search/search_screen.dart';
import 'package:news/shared/components/components.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';

//==========================================================================================================================================================

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      // Builder for building the UI based on the current state
      builder: (context, state) {
        // Access the NewsCubit instance using the context
        var cubit = NewsCubit.get(context);
        return Scaffold(
          // App bar with title and actions
          appBar: AppBar(
            title: const Text('News App'),
            actions: [
              // Search button to navigate to the SearchScreen
              IconButton(
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
                icon: const Icon(Icons.search),
              ),
              // Button to toggle between light and dark mode
              IconButton(
                onPressed: () {
                  DarkCubit.get(context).changeAppMode();
                },
                icon: const Icon(Icons.brightness_4_outlined),
              ),
            ],
          ),

          // Body of the home layout, displays the current screen based on the index
          body: cubit.screens[cubit.index],

          // Bottom navigation bar for navigating between different screens
          bottomNavigationBar: BottomNavigationBar(

            // Current index of the bottom navigation bar
            currentIndex: cubit.index,
            
            // Callback when an item is tapped
            onTap: (index) {
              cubit.changeIndex(index);
            },
            // Items to be displayed in the bottom navigation bar
            items: cubit.bottomitems,
          ),
        );
      },
    );
  }
}

//==========================================================================================================================================================
