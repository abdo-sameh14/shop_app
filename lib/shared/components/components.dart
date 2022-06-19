import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/modules/web_view_screen/web_view_screen.dart';
import 'package:news_app/shared/styles/colors.dart';

import '../../layout/home_screen/home_cubit.dart';
import '../../models/favourites_model/get_fav_model.dart';

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
          text,
          style: TextStyle(fontSize: fontSize, color: fontColor),
        ),
      ),
    );

Future navigateTo(context, nextScreen) => Navigator.push(context, MaterialPageRoute(builder: (context) => nextScreen));

Future navigateAndReplaceTo(context, nextScreen) =>
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => nextScreen), (route) => false);

void showToast({
  required String? msg,
  required ToastStates state
}){
  Fluttertoast.showToast(
      msg: msg!,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

enum ToastStates {success, error, warning}

Color? chooseToastColor(ToastStates state){
  Color? color;
  switch(state){
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}


Widget buildProductItem(model, context){
  var cubit = HomeScreenCubit.get(context);
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: SizedBox(
      height: 120,
      // width: double.infinity,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.end,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 120,
            height: 120,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    model.image!,
                  ),
                  // fit: BoxFit.cover,
                  // width: double.infinity,
                  // height: 200,
                  // width: 120,
                ),
                if (model!.discount > 0) Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  color: Colors.red.withOpacity(0.9),
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white
                    ),

                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      height: 1.3,
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      model.price.toString(),
                      style: const TextStyle(
                        color: defaultColor,
                        fontSize: 14,
                        // fontWeight: FontWeight.w500
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (model!.discount > 0) Text(
                      model.oldPrice.toString(),
                      style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    const Spacer(),
                    CircleAvatar(
                      backgroundColor: cubit.favourites[model.id]! ? defaultColor : Colors.grey,
                      child: IconButton(onPressed: (){
                        cubit.userFavourites(model.id);
                        // print(model.id);
                        // print(model.inFavorites);
                      },
                        iconSize: 18,
                        icon: const Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                          // size: 20,
                        ),
                        // padding: EdgeInsets.all(0),
                      ),
                    )

                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    ),
  );
}