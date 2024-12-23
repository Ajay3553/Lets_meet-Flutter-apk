import 'package:flutter/material.dart';

class HomeMeetButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String text;

  HomeMeetButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            width: 75,
            height: 75,
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 10,
                    color: Colors.white.withOpacity(0.06),
                    offset: const Offset(0, 4),
                  )
                ]),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(text,
              style: const TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }
}
