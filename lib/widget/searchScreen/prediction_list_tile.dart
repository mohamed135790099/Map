import 'package:app_rider/logic/model/place_prediction_model.dart';
import 'package:app_rider/logic/provider/search_places.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PredictionListTile extends StatelessWidget {
  final PlacePrediction predictionLocation;

  const PredictionListTile({Key? key, required this.predictionLocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:() async {
        await Provider.of<SearchPlaceProvider>(context,listen:false).getPlaceId(predictionLocation.placeId!, context);
      },
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.add_location,
                size: 30,
                color:Colors.red,
              ),
              const SizedBox(width: 20),
              Expanded(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(
                    predictionLocation.mainText.toString(),
                    style: const TextStyle(
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                        fontFamily: "Brand-Bold"),
                  ),
                   const SizedBox(
                    height: 5,
                   ),
                  Text(
                    predictionLocation.secondaryText.toString(),
                    style: const TextStyle(
                        fontSize: 12,
                        overflow: TextOverflow.ellipsis,
                        fontFamily: "Brand-Regular"),
                  ),
                  const SizedBox(height:12,),
                  ],
              )),
            ],
          ),
        ],
      ),
    );
  }
}
