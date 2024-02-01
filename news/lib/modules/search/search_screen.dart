import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/components/components.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';

//==========================================================================================================================================================

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      // Builder for building the UI based on the current state
      builder: (context, state) {
        // Access the NewsCubit instance using the context
        var list = NewsCubit.get(context).search;
        return Scaffold(
          // App bar without any title
          appBar: AppBar(),
          // Body of the search screen, consisting of a text field for search input
          // and a list of search results (articles) displayed using articleBuilder
          body: Column(
            children: [
              // Search input field with validation and onChange callback to fetch search results
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  label: 'Search',
                  // Validation function to ensure search is not empty
                  validate: (value) {
                    if (value!.isEmpty) {
                      return 'Search must not be empty';
                    }
                    return null;
                  },
                  prefix: Icons.search,
                  // onChange callback to trigger search when input changes
                  onChange: (value) {
                    NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),
              // Display the search results using articleBuilder
              Expanded(
                child: articleBuilder(list, context, isSearch: true),
              ),
            ],
          ),
        );
      },
    );
  }
}

//==========================================================================================================================================================
