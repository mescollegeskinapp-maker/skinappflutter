import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackPage extends StatefulWidget {
  FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  double _rating=2;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar.new(title: Text('feedback')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(spacing: 10,
        children: [

          RatingBar.builder(
            initialRating: _rating,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemSize: 40,
            itemPadding: EdgeInsetsGeometry.symmetric(horizontal: 2),
            itemBuilder: (context, index) => Icon(Icons.star, color: Colors.yellow,), 
          onRatingUpdate: (rating){
            setState(() {
              _rating=rating;
            });
          }),
          TextFormField(
            maxLines: 5,
            decoration: InputDecoration(
              hintText: 'Type your feedback here...',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))
            ),
          ),
          ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 157, 203, 211),foregroundColor: const Color.fromARGB(255, 20, 19, 19)),
                onPressed: (){}, child: Text('send'))
          
        ],
    

      ),
    ));
    
  }
}