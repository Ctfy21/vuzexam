
class Globals{
  static String prefsSavedData = 'gaImagliga1';

  static int index = 0;

  static String heroesUrl = 'https://apiforexamflutter-ajzg293a.b4a.run/heroes';

  static String imagesUrl = 'https://apiforexamflutter-ajzg293a.b4a.run/pro_players'; 

  static int getIndex(List list){
    var result = index % (list.length - 1);
    index++;
    return result;
  }
}