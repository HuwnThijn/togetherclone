import 'package:flutter/material.dart';
import 'package:lovejourney/gen/assets.gen.dart';

class KeyBoardWidget extends StatefulWidget {
  const KeyBoardWidget(
      {super.key, required this.onChanged, this.onDelete, this.padding});

  final EdgeInsetsGeometry? padding;

  final Function(int val) onChanged;

  final Function()? onDelete;

  @override
  State<KeyBoardWidget> createState() => _KeyBoardWidgetState();
}

class _KeyBoardWidgetState extends State<KeyBoardWidget> {
  final List<String> keys = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '',
    '0',
    'x'
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 1,
      ),
      padding: widget.padding ??
          const EdgeInsets.symmetric(horizontal: 90, vertical: 30),
      itemCount: keys.length,
      itemBuilder: (context, index) {
        return buildKeyButton(
          label: keys[index],
          onTap: () {
            if (keys[index] != keys.last) {
              widget.onChanged.call(int.parse(keys[index]));
            } else if (keys[index] == keys.last) {
              widget.onDelete?.call();
            }
          },
        );
      },
    );
  }

  Widget buildKeyButton({required String label, required VoidCallback onTap}) {
    return label.isEmpty
        ? const SizedBox()
        : GestureDetector(
            onTap: onTap,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white10,
              ),
              child: label == 'x'
                  ? AssetsClass.icons.circleXmark.svg()
                  : Text(
                      label,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: Colors.white,
                              ),
                    ),
            ),
          );
  }
}
