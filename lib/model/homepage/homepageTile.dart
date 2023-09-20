import 'package:flutter/material.dart';

class homepageTile extends StatefulWidget {
  final ScrollController scrollController;
  final List images;

  const homepageTile({
    Key? key,
    required this.scrollController,
    required this.images,
  }) : super(key: key);

  @override
  State<homepageTile> createState() => _homepageTileState();
}

class _homepageTileState extends State<homepageTile> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: width * 10 / 15, // Adjust this height as needed
      child: ListView.builder(
        controller: widget.scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: 6, // Adjust the number of images
        itemBuilder: (context, index) {
          return Container(
            width: width * 13 / 15, // Adjust the width as needed
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.blue, // Adjust the container's decoration
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image.asset(
                '${widget.images[index]}',
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
