import 'package:app_rider/logic/model/place_prediction_model.dart';
import 'package:app_rider/logic/provider/search_places.dart';
import 'package:app_rider/widget/searchScreen/prediction_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PredictionListView extends StatefulWidget {
  const PredictionListView({Key? key}) : super(key: key);

  @override
  State<PredictionListView> createState() => _PredictionListViewState();
}

class _PredictionListViewState extends State<PredictionListView> {
  List<PlacePrediction> predictionList = [];

  @override
  Widget build(BuildContext context) {
    setState(() {
      predictionList = Provider.of<SearchPlaceProvider>(context, listen: true).predictionList;
    });
    return (predictionList.isNotEmpty)
        ? Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 2,
              horizontal: 20,
            ),
            child: ListView.separated(
              shrinkWrap:true,
              physics:const ClampingScrollPhysics(),
              itemBuilder:(context, index) => PredictionListTile(predictionLocation:predictionList[index],),
              separatorBuilder:(context,index)=>const Divider(height:1,thickness:1,color:Colors.grey,),
              itemCount: predictionList.length,
            ),
          )
        :  Container();
  }
}
