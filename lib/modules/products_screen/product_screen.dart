import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/home_screen/home_cubit.dart';
import 'package:news_app/layout/home_screen/home_states.dart';
import 'package:news_app/models/categories_model/categories_model.dart';
import 'package:news_app/models/home_model/home_model.dart';
import 'package:news_app/shared/styles/colors.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({Key? key}) : super(key: key);

  // var cubit = HomeScreenCubit.get(context);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenCubit, HomeScreenStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeScreenCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.homeModel != null && cubit.categoryModel != null,
            builder: (context) {
              return productsBuilder(cubit.homeModel!, context);
            },
            fallback: (context) {
              return const Center(child: CircularProgressIndicator());
            });
      },
    );
  }

  Widget productsBuilder (HomeModel model, context){
    var categoryModel = HomeScreenCubit.get(context).categoryModel?.data?.data;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: CarouselSlider(
                items: model.data?.banners.map((e) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage('${e?.image}')
                      )
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  initialPage: 0,
                  height: 250,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                  enlargeCenterPage: true,
                  pauseAutoPlayOnManualNavigate: true,
                  pauseAutoPlayOnTouch: true,
                  enableInfiniteScroll: true,
                  scrollPhysics: const BouncingScrollPhysics(),
                )),
          ),
          const Text(
            'Categories',
            style: TextStyle(
              color: defaultColor,
              fontSize: 25
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 100,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => buildCatItem(categoryModel![index]!),
              separatorBuilder: (context, index) => const SizedBox(
                width: 5,
                ),
              itemCount: categoryModel!.length),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'New Products',
            style: TextStyle(
              color: defaultColor,
              fontSize: 25
            ),
          ),
          gridViewBuilder(model.data!)
        ],
      ),
    );
  }

  Widget buildCatItem(CategoryDataList model){
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        Container(
          width: 100,
          color: Colors.black.withOpacity(0.7),
          child: Text(
            model.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget gridViewBuilder(HomeData model){
    return Container(
      color: Colors.grey[300],
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        mainAxisSpacing: 1,
        crossAxisSpacing: 1,
        childAspectRatio: 1 / 1.58,
        crossAxisCount: 2,
        children:
          List.generate(
              model.products.length,
              (index) => buildGridProduct(model.products[index]!),
          )
        ,

      ),
    );

  }

  Widget buildGridProduct(ProductsData model){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image(
                    image: NetworkImage(
                    model.image,
                  ),
                    // fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                ),
                if (model.discount > 0) Container(
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
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      height: 1.3,
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: const TextStyle(
                            color: defaultColor,
                            fontSize: 14,
                            // fontWeight: FontWeight.w500
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.discount > 0) Text(
                        '${model.oldPrice.round()}',
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      const Spacer(),
                      IconButton(onPressed: (){
                        print('pressed');
                      },
                        iconSize: 18,
                        icon: const Icon(
                            Icons.favorite_border,
                            // size: 20,
                          ),
                        // padding: EdgeInsets.all(0),
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
}
