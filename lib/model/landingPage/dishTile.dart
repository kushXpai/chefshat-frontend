import 'package:flutter/cupertino.dart';

class dishTile extends StatefulWidget {
  final ScrollController scrollController;
  final List images;

  const dishTile({
    Key? key,
    required this.scrollController,
    required this.images,
  }) : super(key: key);

  @override
  State<dishTile> createState() => _dishTileState();
}

class _dishTileState extends State<dishTile> {
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 210,
      child: ListView.builder(
          controller: widget.scrollController,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: widget.images.length,
          itemBuilder: (context, index) {
            return Container(
              width: 144,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  'assets/landingPagePhotos/${widget.images[index]}',
                  width: 145,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
    );
  }
}
