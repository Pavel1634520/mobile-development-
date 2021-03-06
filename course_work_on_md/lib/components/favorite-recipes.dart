import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_work_on_md/components/blurryDialog.dart';
import 'package:course_work_on_md/domain/authuser.dart';
import 'package:course_work_on_md/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/recipe.dart';


void _clearIsOnline(String docID){
  FirebaseFirestore.instance.collection('recipeSchedules').doc(docID).update({'isOnline': 'false'});
}


class FavoriteRecipes extends StatefulWidget {
  @override
  State<FavoriteRecipes> createState() => _RecipesListState();
}

class _RecipesListState extends State<FavoriteRecipes> {


  DatabaseService  db = DatabaseService();
  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('recipeSchedules')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Text('');

          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Colors.blue[200],
                margin: const EdgeInsets.only(
                    left: 10, right: 10, top: 12, bottom: 3),
                child: ListTile(
                  trailing: IconButton(
                    icon: Icon(
                      Icons.more,
                      color: Colors.blue,
                      size: 33,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MoreRecipe(
                                  title: snapshot.data!.docs[index].get('title'),
                                  miniDescription: snapshot.data!.docs[index]
                                      .get('miniDescription'),
                                  description: snapshot.data!.docs[index]
                                      .get('description'),
                                  ingredients: snapshot.data!.docs[index]
                                      .get('ingredients'),
                                  complexity: snapshot.data!.docs[index]
                                      .get('complexity'))));

                    },
                  ),
                  title: Text(snapshot.data!.docs[index].get('title')),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MoreRecipe(
                                title: snapshot.data!.docs[index].get('title'),
                                miniDescription: snapshot.data!.docs[index]
                                    .get('miniDescription'),
                                description: snapshot.data!.docs[index]
                                    .get('description'),
                                ingredients: snapshot.data!.docs[index]
                                    .get('ingredients'),
                                complexity: snapshot.data!.docs[index]
                                    .get('complexity'))));
                  },
                  subtitle: Column(
                    children: [
                      Text(snapshot.data!.docs[index].get('miniDescription')),
                      Subtitle(
                          context, snapshot.data!.docs[index].get('complexity'))
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}

class MoreRecipe extends StatelessWidget {
  final String title;
  final String miniDescription;
  final String description;
  final String ingredients;
  final String complexity;

  const MoreRecipe({
    Key? key,
    required this.title,
    required this.miniDescription,
    required this.description,
    required this.ingredients,
    required this.complexity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text('???????????? ??????????????????????????',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        Text(
                          '\n $description',
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          "??????????????????????:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          " $ingredients",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            "?????????????????? ??????????????????????????:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Subtitle(context, complexity),
                        ],
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget Subtitle(BuildContext context, String complexity) {
  Color color = Colors.grey;
  double indicatorLevel = 0;

  switch (complexity) {
    case '???????????? ??????????????????':
      color = Colors.greenAccent;
      indicatorLevel = 0.25;
      break;
    case '?????????????? ??????????????????':
      color = Colors.yellow;
      indicatorLevel = 0.50;
      break;
    case '?????????????? ??????????????????':
      color = Colors.orange;
      indicatorLevel = 0.75;
      break;
    case '???????????????????? ????????????':
      color = Colors.red;
      indicatorLevel = 1;
      break;
  }
  return Row(
    children: [
      Expanded(
          flex: 1,
          child: LinearProgressIndicator(
              backgroundColor: Colors.white,
              value: indicatorLevel,
              valueColor: AlwaysStoppedAnimation(color))),
      SizedBox(
        width: 10,
      ),
      Expanded(flex: 4, child: Text(complexity))
    ],
  );
}
