import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_application/screens/meals_details.dart';
import 'package:meals_application/widget/meal_item.dart';

import '../models/meals_data.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    required this.onToggleFavorite,
  });

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;
  void selectMeal(BuildContext context,Meal meal){
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>MealsDetailsScreen(meal: meal,onToggleFavourite: onToggleFavorite,)));
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    // Handle the empty state
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Nothing Here',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            Text(
              'Try selecting another category',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ],
        ),
      );
    } else {
      // Handle the non-empty state
      content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) => MealItem(meal: meals[index],onSelectedMeal: (meal){
           selectMeal(context, meal);
        },),
      );
    }
      
      if (title==null) {
        return content;
        
      }  
    
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
