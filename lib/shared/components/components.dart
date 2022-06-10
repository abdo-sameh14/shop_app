import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view_screen/web_view_screen.dart';
import 'package:news_app/shared/styles/colors.dart';

Widget buildArticleItem(Map article, context) => InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']));
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),

    child: Row(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        SizedBox(

          width: 160,

          height: 120,

          child: article['urlToImage'] != null? Container(

            decoration: BoxDecoration(

              // color: Colors.deepOrange,

              borderRadius: BorderRadius.circular(15),

              image: DecorationImage(

                  image: NetworkImage(

                    '${article['urlToImage']}'

                  ),

                  fit: BoxFit.cover

              ),

            ),

          ) : Container(

            decoration: BoxDecoration(

              color: Colors.deepOrange,

              borderRadius: BorderRadius.circular(15),

            ),

            child: const Center(

              child: Text(

                'Image Not Found!',

                textAlign: TextAlign.center,

                style: TextStyle(

                  fontSize: 18,

                  color: Colors.white

                )

              ),

            ),

          ),

        ),

        const SizedBox(

          width: 20,

        ),

        Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(

                '${article['title']}',

                maxLines: 3,

                overflow: TextOverflow.ellipsis,

                style: Theme.of(context).textTheme.bodyText1

              ),

              const SizedBox(

                height: 5,

              ),

              Text(

                '${article['publishedAt']}',

                style: Theme.of(context).textTheme.bodyText2

              ),

            ],

          ),

        ),

      ],

    ),

  ),
);

Widget mySeparator() =>Container(
  height: 1,
  width: double.infinity,
  color: Colors.grey[400],
);

Widget buildArticles(list, {bool isSearch = false}) => ConditionalBuilder(
    condition: list.isNotEmpty,
    builder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => mySeparator(),
        itemCount: list.length),
    fallback: (context) => Center(child: isSearch ? Container() : const CircularProgressIndicator()));

Widget defaultTextFormField(
    {bool isPassword = false,
      required String label,
      required TextInputType type,
      required TextEditingController controller,
      void Function(String)? onSubmitted,
      required String validateReturn,
      required IconData prefix,
      IconData? suffix,
      void Function()? suffixButtonFunction,
      void Function()? onTapFunction,
      void Function(String)? onChangeFunction,
      bool border = true,
      InputDecoration? decoration
    }) =>
    TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return validateReturn;
        }
        return null;
      },
      controller: controller,
      onFieldSubmitted: onSubmitted,
      onChanged: onChangeFunction,
      keyboardType: type,
      obscureText: isPassword,
      onTap: onTapFunction,
      // style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        // fillColor: Colors.white,
        // filled: true,
        // enabledBorder: const OutlineInputBorder(
        //   borderSide: BorderSide(
        //       color: Colors.grey
        //   ),
        // ),
        // focusedBorder: const OutlineInputBorder(
        //   borderSide: BorderSide(
        //       color: Color(0xff045c99)
        //   ),
        // ),
        labelText: label,
        // labelStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(prefix,
          // color: Colors.grey[600],
        ),
        suffixIcon: suffix != null ? IconButton(
          icon: Icon(suffix,
          // color: defaultColor,
          ),
          onPressed: suffixButtonFunction,
        )
            : null,
        border: border != true ? null : const OutlineInputBorder(),
      ),
    );

Widget defaultButton(
    {double width = double.infinity,
      Color backgroundColor = defaultColor,
      double radius = 10,
      required void Function()? function,
      required String text,
      double fontSize = 25,
      Color fontColor = Colors.white}) =>
    Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius), color: backgroundColor),
      width: width,
      // color: Colors.lightBlue,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: TextStyle(fontSize: fontSize, color: fontColor),
        ),
      ),
    );

Future navigateTo(context, nextScreen) => Navigator.push(context, MaterialPageRoute(builder: (context) => nextScreen));

Future navigateAndReplaceTo(context, nextScreen) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => nextScreen), (route) => false);