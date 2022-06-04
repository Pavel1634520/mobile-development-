import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../domain/recipe.dart';

class DatabaseService {
  final CollectionReference _recipeCollection = FirebaseFirestore.instance
      .collection('recipes');
  final CollectionReference _recipeSchedulesCollection = FirebaseFirestore
      .instance.collection('recipeSchedules');

  Future addOrUpdateRecipe(Recipe recipe) async {
    return await _recipeCollection.doc(recipe.uid).set(recipe.toMap());


  }

  Future addOrUpdateRecipeFavorite(Recipe recipe) async {
    return await _recipeSchedulesCollection.doc(recipe.uid).set(recipe.toMap());


  }

  Stream<Iterable<Recipe>> getRecipes({required String name}) {

    Query query;


        query = _recipeCollection.where('name',isEqualTo: name);

    return query.snapshots().map((QuerySnapshot snapshot) => snapshot.docs.map((DocumentSnapshot doc) =>Recipe.fromJson(doc.id,doc.data as Map <String, dynamic>)));

  }

}