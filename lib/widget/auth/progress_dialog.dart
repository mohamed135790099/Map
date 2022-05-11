import 'package:flutter/material.dart';
class ProgressDialog extends StatelessWidget {
  final String status;
  const ProgressDialog({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Dialog(
      shape:RoundedRectangleBorder(
        borderRadius:BorderRadius.circular(10),
      ),
      backgroundColor:Colors.white,
      child:Container(
        margin:const EdgeInsets.all(16),
        width:double.infinity,
        decoration:BoxDecoration(
          color:Colors.white54,
          borderRadius:BorderRadius.circular(4),
        ),
        child:Row(
          mainAxisAlignment:MainAxisAlignment.center,
          children:  [
            const CircularProgressIndicator(valueColor:AlwaysStoppedAnimation(Colors.green),),
            const SizedBox(width:30,),
            Text(status,style:const TextStyle(fontSize:14,color:Colors.black,fontWeight:FontWeight.w500,overflow:TextOverflow.ellipsis),),
          ],
        ),
      ),
    );
  }
}
