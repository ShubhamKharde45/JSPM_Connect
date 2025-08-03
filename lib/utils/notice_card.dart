import 'package:flutter/material.dart';
import 'package:jspm_connect/utils/app_container.dart';

class NoticeCard extends StatelessWidget {
  const NoticeCard({super.key, required this.data});

  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    return AppContainer(
      width: MediaQuery.of(context).size.width * 0.9,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(data['type']),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                data['title'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  data['description'],
                  style: TextStyle(
                    fontSize: 15,

                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 15),
          Row(
            children: [
              Icon(Icons.calendar_month, size: 20),
              SizedBox(width: 5),
              Text(
                DateTime.fromMicrosecondsSinceEpoch(
                  data['dateTime'],
                ).toLocal().toString(),

                style: TextStyle(
                  fontSize: 15,

                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
