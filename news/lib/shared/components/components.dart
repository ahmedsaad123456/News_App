import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news/modules/webview/web_view.dart';

//==========================================================================================================================================================

// Widget to build an article item, displayed in a list of articles
Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        // Navigate to the WebViewScreen when the article item is tapped
        navigateTo(context, WebViewScreen(article['url']));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            // Container to display the article image
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(
                  10.0,
                ),
                image: DecorationImage(
                  // Display the article image or a default image if not available
                  image: article['urlToImage'] == null
                      ? const NetworkImage(
                          'https://th.bing.com/th/id/OIP.U7Fc00JILo3voeQOW6MadwHaE8?pid=ImgDet&w=638&h=426&rs=1')
                      : NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: SizedBox(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Display the article title with a maximum of 3 lines
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    // Display the article published date
                    Text(
                      '${article['publishedAt']}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

//==========================================================================================================================================================

// Widget to build a divider line
Widget myDivider() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    );

//==========================================================================================================================================================

// Widget to conditionally build a list of articles
Widget articleBuilder(List<dynamic> list, con, {isSearch = false}) => ConditionalBuilder(
    // Check if the list of articles is not empty
    condition: list.isNotEmpty,
    // Build a ListView with article items separated by dividers
    builder: (context) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          // Build each article item using the buildArticleItem function
          itemBuilder: (context, index) => buildArticleItem(list[index], con),
          // Build a divider between each article item
          separatorBuilder: (context, index) => myDivider(),
          // Set the number of articles to be displayed
          itemCount: list.length,
        ),
    // Display a CircularProgressIndicator if the list is empty and not in search mode
    fallback: (context) => isSearch ? Container() : const Center(child: CircularProgressIndicator()));

//==========================================================================================================================================================

// Widget for a default form field used for user input
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required final String? label,
  required String? Function(String?)? validate,
  required IconData prefix,
  bool isPassword = false,
  IconData? suffix,
  Function()? suffixPressed,
  Function()? onTap,
  var onChange,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onTap: onTap,
      obscureText: isPassword,
      onChanged: onChange, // Callback for when the field value changes
      validator: validate, // Function to validate the field value
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: suffixPressed,
              )
            : null,
        border: const OutlineInputBorder(),
      ),
    );

//==========================================================================================================================================================

// Function to navigate to a new screen
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

//==========================================================================================================================================================
