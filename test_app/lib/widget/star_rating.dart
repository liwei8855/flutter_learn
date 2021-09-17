import 'package:flutter/material.dart';

class OPStarWidget extends StatefulWidget {
  final double rating;
  final double maxRating;
  final int count;
  final double size;
  final Color unselectedColor;
  final Color selectedColor;
  final Widget unselectedImage;
  final Widget selectedImage;

  OPStarWidget(
    this.rating, {
    this.maxRating = 10,
    this.count = 5,
    this.size = 30,
    this.unselectedColor = const Color(0xffbbbbbb),
    this.selectedColor = const Color(0xffff0000),
  }): unselectedImage = Icon(Icons.star_border,color: unselectedColor, size: size),
        selectedImage = Icon(Icons.star,color: selectedColor, size: size,);

  @override
  _OPStarWidgetState createState() => _OPStarWidgetState();
}

class _OPStarWidgetState extends State<OPStarWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: buildUnselectedStars(),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: buildSelectedStars(),
          ),
        ]
    );
  }

  List<Widget> buildUnselectedStars(){
    return List.generate(widget.count, (index)=> widget.unselectedImage );
  }

  List<Widget> buildSelectedStars(){
    //1 创建stars
    List<Widget> stars = [];
    final star = widget.selectedImage;

    // 2.构建满填充的star
    double oneValue = widget.maxRating / widget.count;
    int entireCount = (widget.rating / oneValue).floor();
    for(var i=0; i<entireCount; i++){
      stars.add(star);
    }

    // 3.构建部分填充star
    double leftWidth = ((widget.rating / oneValue)-entireCount)*widget.size;
    final halfStar = ClipRect(
      clipper: OPStarClipper(leftWidth),
      child: star,
    );
    stars.add(halfStar);
    if(stars.length > widget.count){
      return stars.sublist(0,widget.count);
    }
    return stars;
  }
}

class OPStarClipper extends CustomClipper<Rect> {
  double width;

  OPStarClipper(this.width);

  @override
  bool shouldReclip(covariant OPStarClipper oldClipper) {
    return oldClipper.width != this.width;
  }

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, width, size.height);
  }
}