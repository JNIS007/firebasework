import 'package:flutter/material.dart';


class RoundButton extends StatelessWidget {
  const RoundButton({Key? key,
    required this.title,
    required this.onTap,
    this.loading = false
  }) : super(key: key);

  final String title ;
  final bool loading;
  final VoidCallback onTap;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(

          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(10)
        ),

        child: Center
          (
            child: loading? CircularProgressIndicator(
              strokeWidth: 3, color: Colors.white,
            ) : Text(
              title, style: TextStyle(color: Colors.white),
            )
        )
      ),
    );
  }
}
