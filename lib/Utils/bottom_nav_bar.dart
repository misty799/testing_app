import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final List _tabIcons;
  final int activeIndex;
  final ValueChanged<int> onTabChanged;
  const NavBar({
    required Key key,
    required List tabIcons,
    required this.activeIndex,
    required this.onTabChanged,
  })  : _tabIcons = tabIcons,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(_tabIcons.length, (index) {
          return NavBarItem(
            icon: _tabIcons[index],
            index: index,
            activeIndex: activeIndex,
            onTabChanged: onTabChanged,
          );
        }),
      ),
    );
  }
}

class NavBarItem extends StatefulWidget {
  final int index;
  final int activeIndex;
  final dynamic icon;
  final ValueChanged<int> onTabChanged;
  // ignore: use_key_in_widget_constructors
  const NavBarItem({
    this.icon,
    required this.index,
    required this.activeIndex,
    required this.onTabChanged,
  });

  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 1,
      upperBound: 1,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onTap() {
    // change currentIndex to this tab's index
    if (widget.index != widget.activeIndex) {
      widget.onTabChanged(widget.index);
      _controller.forward().then((value) => _controller.reverse());
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(widget.icon['icon'],
              color:
                  widget.activeIndex == widget.index ? Colors.blue[800] : null),
          // Spacer(),
          Text(
            widget.icon['title'],
            style: TextStyle(
                color: widget.activeIndex == widget.index
                    ? Colors.blue[800]
                    : Colors.grey),
          ),
        ],
      ),
    );
  }
}
