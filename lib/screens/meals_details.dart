import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/meals_data.dart';

class MealsDetailsScreen extends StatelessWidget {
  const MealsDetailsScreen({super.key, required this.meal,required this.onToggleFavourite});

  final Meal meal;
  final void Function(Meal meal) onToggleFavourite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(onPressed: (){
            onToggleFavourite(meal);
          }, icon: const Icon(Icons.favorite))
        ],

      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              height: 300,
              width:double.infinity,
              fit:BoxFit.cover ,
            ),
            const SizedBox(height: 14,),
            Text(
              'Ingredient',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
              const SizedBox(height: 14.0,),
              for(final ingredient in meal.ingredients )
                Text(ingredient,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                 color: Theme.of(context).colorScheme.onBackground,),
                ),
             const SizedBox(height: 24.0,),
             Text(
              'Steps:',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
             const SizedBox(height: 14.0,),
             for(final step in meal.steps )
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: Text(step,textAlign: TextAlign.start,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,),
                ),
              ),


          ],
        ),
      )
    );
  }
}
