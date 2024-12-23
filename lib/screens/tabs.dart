import 'package:flutter/material.dart';
import 'package:meals_application/data/data.dart';
import 'package:meals_application/models/meals_data.dart';
import 'package:meals_application/screens/categories.dart';
import 'package:meals_application/screens/meals.dart';
import 'package:meals_application/widget/main_drawer.dart';
import 'filters.dart';

const initialFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favouriteMealList = [];
  late Map<Filter, bool> _selectedFilter;

  @override
  void initState() {
    super.initState();
    _selectedFilter = Map.from(widget.currentFilters);
  }

  void showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleFavouriteMealStatus(Meal favoriteMeal) {
    final isExisting = _favouriteMealList.contains(favoriteMeal);
    if (isExisting) {
      setState(() {
        _favouriteMealList.remove(favoriteMeal);
      });
      showInfoMessage("Meal is no longer in favorites");
    } else {
      setState(() {
        _favouriteMealList.add(favoriteMeal);
      });
      showInfoMessage("Meal is added to favorites");
    }
  }

  void _selectPage(int pageIndex) {
    setState(() {
      _selectedPageIndex = pageIndex;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'Filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => FiltersScreen(currentFilters: _selectedFilter),
        ),
      );
      setState(() {
        _selectedFilter = result ?? initialFilter;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal) {
      if (_selectedFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedFilter[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedFilter[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedFilter[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleFavouriteMealStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favouriteMealList,
        onToggleFavorite: _toggleFavouriteMealStatus,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(onScreenSelected: _setScreen),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
