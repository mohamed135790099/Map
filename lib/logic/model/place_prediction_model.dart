class PlacePrediction{
  String? mainText;
  String? secondaryText;
  String? placeId;

  PlacePrediction({
   this.mainText,
   this.secondaryText,
   this.placeId,
  });

  PlacePrediction.formJson(Map<String,dynamic>json){
    mainText=json['structured_formatting']['main_text'];
    secondaryText=json['structured_formatting']['secondary_text'];
    placeId=json['place_id'];
  }
}