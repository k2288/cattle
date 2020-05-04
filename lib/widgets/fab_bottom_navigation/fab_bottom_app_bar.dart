import 'package:flutter/material.dart';

class FABBottomAppBarItem {
  FABBottomAppBarItem({this.iconData, this.text});
  IconData iconData;
  String text;
}


class FabBottomAppBar extends StatefulWidget {
  FabBottomAppBar({
    this.items,
    this.centerItemText,
    this.height: 60.0,
    this.iconSize: 24.0,
    this.backgroundColor,
    this.color,
    this.selectedColor,
    this.onTabSelected,
  });
  final List<FABBottomAppBarItem> items;
  final String centerItemText;
  final double height;
  final double iconSize;
  final Color backgroundColor;
  final Color color;
  final Color selectedColor;
  final ValueChanged<int> onTabSelected;
  @override
  _FabBottomAppBarState createState() => _FabBottomAppBarState();
}

class _FabBottomAppBarState extends State<FabBottomAppBar> {

  int _selectedIndex = 0;

  _updateIndex(int index){
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> items = List.generate(widget.items.length, (int index){
      return _buildTabItem(
        item:widget.items[index],
        index:index,
        onPressed:_updateIndex
      );
    });

    return BottomAppBar(

      shape: CircularNotchedRectangle(),
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items,
        ),
      ),
    );
  }

  Widget _buildTabItem({
    FABBottomAppBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    Color color = _selectedIndex == index ? widget.selectedColor : widget.color;
    return Expanded(
      child: SizedBox(
        height: widget.height,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(item.iconData, color: color, size: widget.iconSize),
                item.text!=""?
                Text(
                  item.text,
                  style: TextStyle(color: color),
                ):Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}