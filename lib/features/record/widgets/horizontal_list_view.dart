import 'package:flutter/material.dart';

class HorizontalListView extends StatefulWidget {
  final List<String> items;

  const HorizontalListView({super.key, required this.items});

  @override
  _HorizontalListViewState createState() => _HorizontalListViewState();
}

class _HorizontalListViewState extends State<HorizontalListView> {
  int _indexSelect = 0;

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
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: _indexSelect == i ? Colors.black : Colors.grey, // Изменение цвета в зависимости от выбранного элемента
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