import 'package:flutter/material.dart';

class HorizontalListView extends StatefulWidget {
  final List<String> items;
  final Function(String)? onItemSelected;
  final int selectIndex;
  const HorizontalListView({
    super.key,
    required this.items,
    this.onItemSelected, required this.selectIndex,
  });

  @override
  _HorizontalListViewState createState() => _HorizontalListViewState();
}

class _HorizontalListViewState extends State<HorizontalListView> {
  int _indexSelect = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, i) => const Divider(),
      itemCount: widget.items.length,
      itemBuilder: (context, i) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _indexSelect = i;
            });
            if (widget.onItemSelected != null) {
              widget.onItemSelected!(widget.items[i]);
            }
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: (_indexSelect == i && _indexSelect != -1  && widget.selectIndex!=-1) ? Colors.black : Colors.grey, // Изменение цвета в зависимости от выбранного элемента
            child: SizedBox(
              width: 100,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.items[i],
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white.withOpacity(1)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

