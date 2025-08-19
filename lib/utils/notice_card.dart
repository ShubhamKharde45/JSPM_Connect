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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(data["profileUrl"]),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      data['creatorName'],
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: data['priority'] == 1
                            ? Colors.red
                            : data['priority'] == 2
                            ? Colors.yellow
                            : data['priority'] == 3
                            ? Colors.green
                            : Colors.black,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                decoration: BoxDecoration(
                  color: data['priority'] == 1
                      ? Colors.red.withAlpha(90)
                      : data['priority'] == 2
                      ? Colors.yellow.withAlpha(90)
                      : data['priority'] == 3
                      ? Colors.green.withAlpha(90)
                      : Colors.black.withAlpha(90),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(child: Text(data['type'])),
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
