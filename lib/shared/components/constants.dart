import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/network/local/chache%20_helper.dart';

void printFullText(String text)
{
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String? token;

void signOut(
    context,
    {required loginScreen}
    )
{
  CacheHelper.removeData(key: 'token').then((value) {
    if(value!) {
      navigateAndReplaceTo(context, loginScreen);}              }
  );

}