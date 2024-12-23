import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals_application/models/meals_data.dart';
import 'package:meals_application/widget/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({super.key,required this.meal,required this.onSelectedMeal});

  final Meal meal;

  String get complexityText{
      return meal.complexity.name[0].toUpperCase() + meal.complexity.name.substring(1);
  }
  String get affordabilityText{
    return meal.affordability.name[0].toUpperCase() + meal.affordability.name.substring(1);
  }

  final void Function(Meal meal) onSelectedMeal;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: (){
          onSelectedMeal(meal);
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
                 left: 0,
                 right: 0,
                 bottom: 0,
                child: Container(
                  color: Colors.grey,
                  padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 44),
                  child:  Column(
                    children: [
                      Text(
                        meal.id,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        softWrap: true
                        ,overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                      ),
                      const SizedBox(height: 12,),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MealItemTrait(icon: Icons.schedule, label: '${meal.duration} Min',),
                            const SizedBox(width: 12,),
                            MealItemTrait(icon: Icons.work, label: complexityText,),
                            const SizedBox(width: 12,),
                            MealItemTrait(icon: Icons.attach_money, label: affordabilityText,),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
