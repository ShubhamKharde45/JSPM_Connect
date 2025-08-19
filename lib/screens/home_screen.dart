import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jspm_connect/services/auth/user_role_provider.dart';
import 'package:jspm_connect/utils/app_container.dart';
import 'package:jspm_connect/utils/notice_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String userRole = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userRole = ref.watch(userRoleProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("JSPM Notice Board"),
        centerTitle: true,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.inversePrimary,
          fontSize: 20,
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    fillColor: Theme.of(context).colorScheme.primary,
                    filled: true,
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.15,
                padding: EdgeInsets.only(right: 10),
                color: Theme.of(context).colorScheme.primary,
                child: Icon(Icons.sort),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("Notices")
                  .where('visibleTo', arrayContainsAny: [userRole, "All"])
                  .orderBy('dateTime', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData ||
                    snapshot.hasError ||
                    snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      "No notices",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  );
                }

                final docs = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;

                    return GestureDetector(
                      onTap: () {
                        showBottomSheet(
                          elevation: 0,
                          enableDrag: true,
                          showDragHandle: true,
                          context: context,
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          builder: (context) => AppContainer(
                            height: MediaQuery.of(context).size.height * 0.8,
                            width: MediaQuery.of(context).size.width * 0.9,

                            // color: Theme.of(context).colorScheme.secondary,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 10,
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 40,
                                          width: 40,
                                          padding: EdgeInsets.symmetric(
                                            vertical: 10,
                                            horizontal: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                data["profileUrl"],
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              100,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: Text(
                                            data['creatorName'],
                                            style: TextStyle(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.inversePrimary,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      data['title'],
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.inversePrimary,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      data['description'],
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.inversePrimary,
                                      ),
                                    ),
                                    SizedBox(height: 30),
                                    Text(
                                      data['attachmentUrl'] ?? "No attachment",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.inversePrimary,
                                      ),
                                    ),
                                    SizedBox(height: 10),
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
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.inversePrimary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 40),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: NoticeCard(data: data),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
