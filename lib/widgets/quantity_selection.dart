import 'package:flutter/material.dart';

class QuantitySelection extends StatefulWidget {
  const QuantitySelection({super.key, required this.onQuantitySelected});
  final Function(int) onQuantitySelected;

  @override
  State<QuantitySelection> createState() => _QuantitySelectionState();
}

int quantity = 1;

class _QuantitySelectionState extends State<QuantitySelection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              setState(() {
                widget.onQuantitySelected(quantity);
              });
            },
            icon: Icon(
              Icons.remove,
            )),
        Text(
          '${quantity}',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.black),
        ),
        IconButton(
            onPressed: () {
              setState(() {
                quantity++;
                widget.onQuantitySelected(quantity);
              });
            },
            icon: Icon(
              Icons.add,
            )),
      ],
    );
  }
}
