
class Globals{
  static int index = 0;

  static String heroesUrl = 'https://api.opendota.com/api/heroes';

  static String imagesUrl = 'https://api.opendota.com/api/proPlayers'; 

  static int getIndex(List list){
    var result = index % (list.length - 1);
    index++;
    return result;
  }
}