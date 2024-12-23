import 'package:flutter/material.dart';
import 'package:meals_application/screens/tabs.dart';
import 'package:meals_application/widget/main_drawer.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  final Map<Filter, bool> currentFilters;

  const FiltersScreen({super.key, required this.currentFilters});

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late Map<Filter, bool> _selectedFilters;

  @override
  void initState() {
    super.initState();
    _selectedFilters = Map.from(widget.currentFilters);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      drawer: MainDrawer(
        onScreenSelected: (String identifier) {
          Navigator.of(context).pop();
          if (identifier == 'Meals') {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => TabsScreen(currentFilters: _selectedFilters),
              ),
            );
          }
        },
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(_selectedFilters);
          return false;
        },
        child: Column(
          children: [
            _buildSwitchListTile(
              title: 'Gluten-Free',
              subtitle: 'Only include gluten-free meals.',
              value: _selectedFilters[Filter.glutenFree]!,
              onChanged: (newValue) {
                setState(() {
                  _selectedFilters[Filter.glutenFree] = newValue;
                });
              },
            ),
            _buildSwitchListTile(
              title: 'Lactose-Free',
              subtitle: 'Only include lactose-free meals.',
              value: _selectedFilters[Filter.lactoseFree]!,
              onChanged: (newValue) {
                setState(() {
                  _selectedFilters[Filter.lactoseFree] = newValue;
                });
              },
            ),
            _buildSwitchListTile(
              title: 'Vegetarian',
              subtitle: 'Only include vegetarian meals.',
              value: _selectedFilters[Filter.vegetarian]!,
              onChanged: (newValue) {
                setState(() {
                  _selectedFilters[Filter.vegetarian] = newValue;
                });
              },
            ),
            _buildSwitchListTile(
              title: 'Vegan',
              subtitle: 'Only include vegan meals.',
              value: _selectedFilters[Filter.vegan]!,
              onChanged: (newValue) {
                setState(() {
                  _selectedFilters[Filter.vegan] = newValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchListTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
          color: Theme.of(context).colorScheme.onBackground,
        ),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
