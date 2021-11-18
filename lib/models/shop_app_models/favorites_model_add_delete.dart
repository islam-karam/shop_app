class FavoritesModelAddAndDelete{
  bool status;
  String message;
  FavoritesModelAddAndDelete.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
  }

}