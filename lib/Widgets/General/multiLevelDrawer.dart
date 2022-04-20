library multilevel_drawer;

import 'package:flutter/material.dart';

class MultiLevelDrawer extends StatefulWidget {
  final Widget header;
  final List<MLMenuItem> children;
  final Color backgroundColor;
  final Color subMenuBackgroundColor;
  final Color divisionColor;
  final Color rippleColor;

  const MultiLevelDrawer(
      {required this.header,
      required this.children,
      required this.backgroundColor,
      required this.divisionColor,
      required this.rippleColor,
     required  this.subMenuBackgroundColor});

  @override
  _MultiLevelDrawerState createState() => _MultiLevelDrawerState();
}

class _MultiLevelDrawerState extends State<MultiLevelDrawer> {
  ScrollController scrollController = ScrollController();
  GlobalKey globalKey = GlobalKey();
  List<double> positions = [];
  List<MLMenuItem> drawerItems = [];
  double? itemSize;
  String? _locale;
  int selectedPosition = -1, lastPosition = 0;
  bool openSubMenu = false;

  @override
  void initState() {
    positions = [0, 0, 0, 0];
    drawerItems = widget.children;
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback(getPositions);
  }

  getPositions(duration) {
    RenderBox? renderBox = globalKey.currentContext?.findRenderObject() as RenderBox;
    double dy = renderBox.localToGlobal(Offset.zero).dy;
    double start = dy - 24;
    double end = renderBox.size.height + start;
    double step = (end - start) / drawerItems.length;
    itemSize = step+20;
    positions = [];
    for (double x = start; x < end; x = x + step) {
      positions.add(x);
    }
    setState(() {});
  }

  openSubDrawer(position) {
    bool isSamePosition = selectedPosition == position;
    setState(() {
      lastPosition = selectedPosition != -1 ? selectedPosition : 0;
      selectedPosition = isSamePosition ? -1 : position;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _locale = Localizations.localeOf(context).languageCode;
    });
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Stack(
        children: <Widget>[
          if (selectedPosition != -1 &&
              drawerItems[selectedPosition].subMenuItems != null) ...[
            _locale == 'en'
                ? AnimatedPositioned(
                    duration: Duration(milliseconds: 200),
                    left: selectedPosition == -1 ? 0 : size.width / 1.8,
                    top: selectedPosition != -1
                        ? positions[selectedPosition]
                        : positions[lastPosition],
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: size.width / 2.3,
                          height: itemSize !*
                              drawerItems[selectedPosition].subMenuItems!.length,
                        ),
                        Positioned(
                          top: 0,
                          left: 10,
                          child: Container(
                            width: size.width / 2.3 - 10,
                            child: Column(
                              children: drawerItems[selectedPosition]
                                  .subMenuItems!
                                  .map<Widget>((subMenuItem) {
                                return _MLChoiceItem(
                                  color: widget.subMenuBackgroundColor ,
                                  divisionColor: widget.divisionColor,
                                  rippleColor: widget.rippleColor,
                                  onTap: () {
                                    subMenuItem.onClick();
                                  },
                                  child: subMenuItem.submenuContent,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 0,
                            left: 0,
                            child: CustomPaint(
                              size: Size(10, itemSize!),
                              painter: _ArrowPainter(
                                  arrowColor: widget.subMenuBackgroundColor),
                            ))
                      ],
                    ))
                : AnimatedPositioned(
                    duration: Duration(milliseconds: 200),
                    right: selectedPosition == -1 ? 0 : size.width /1.8,
                    top: selectedPosition != -1
                        ? positions[selectedPosition]
                        : positions[lastPosition],
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: size.width / 2.3,
                          height: itemSize! *
                              drawerItems[selectedPosition].subMenuItems!.length,
                        ),
                        Positioned(
                          top: 0,
                          right: 10,
                          child: Container(
                            width: size.width / 2.3 - 10,
                            child: Column(
                              children: drawerItems[selectedPosition]
                                  .subMenuItems!
                                  .map<Widget>((subMenuItem) {
                                return _MLChoiceItem(
                                  color: widget.subMenuBackgroundColor ,
                                  divisionColor: widget.divisionColor,
                                  rippleColor: widget.rippleColor,
                                  onTap: () {
                                    subMenuItem.onClick();
                                  },
                                  child: subMenuItem.submenuContent,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 0,
                            right: 0,
                            child: CustomPaint(
                              size: Size(10, itemSize!),
                              painter: _ArrowPainter(
                                  arrowColor: widget.subMenuBackgroundColor),
                            ))
                      ],
                    )),
          ],
          Container(
            decoration: BoxDecoration(
                color: widget.backgroundColor ,
                ),
            width: size.width/1.8 ,
            height: size.height,
            child: Column(
              children: <Widget>[
                widget.header,
                SingleChildScrollView(
                  child: Container(
                    height: size.height-260,
                    key: globalKey,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: drawerItems.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        MLMenuItem item = drawerItems[index];
                        return _MLChoiceItem(
                          leading: item.leading,
                          trailing: item.trailing,
                          width: size.width /12,
                          divisionColor: widget.divisionColor,
                          color:widget.backgroundColor,
                          rippleColor: widget.rippleColor,
                          child: item.content,
                          onTap: () {
                            if (item.subMenuItems != null) {
                              openSubDrawer(index);
                            } else {
                              item.onClick();
                              openSubDrawer(selectedPosition);
                            }
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MLChoiceItem extends StatelessWidget {
  final Function()? onTap;
  final Widget? leading;
  final Widget child;
  final Widget? trailing;
  final Color color;
  final Color rippleColor;
  final Color divisionColor;
  final double ?width;

  const _MLChoiceItem(
      {required this.onTap,
      required this.child,
       this.leading,
       this.trailing,
      required this.color,
      required this.rippleColor,
      required this.divisionColor,
       this.width});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      child: InkWell(
        highlightColor: rippleColor ,
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: divisionColor , width: 1.0))),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              if (leading != null) ...[
                Container(
                  width: width??0 * 0.1,
                  child: leading,
                ),
              ],
              Expanded(
                child: child),
              if (trailing != null) ...[
                Container(
                  width: width??0 * 0.1,
                  child: trailing,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  final Color arrowColor;

  _ArrowPainter({required this.arrowColor});

  @override
  void paint(Canvas canvas, Size size) {
    Color paintColor = arrowColor ;
    Paint paint = Paint()
      ..color = paintColor.withOpacity(0.7)
      ..style = PaintingStyle.fill;
    Path path = Path();
    path.moveTo(0, size.height / 2);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

class MLMenuItem {
  final Widget content;
  final Widget? leading, trailing;
  final Function onClick;
  final List<MLSubmenu>? subMenuItems;

  const MLMenuItem(
      {required this.content,
      required this.onClick,
      this.subMenuItems,
      this.leading,
      this.trailing});
}

class MLSubmenu {
  final Widget submenuContent;
  final Function onClick;

  MLSubmenu({required this.submenuContent, required this.onClick});
}
