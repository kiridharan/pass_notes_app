import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String data;
  final VoidCallback onTap;
  final IconData icon;
  final Color color;
  final Color splashColor;

  const CustomCard(
      {Key key, this.data, this.onTap, this.icon, this.color, this.splashColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      color: color,
      elevation: 20.0,
      child: InkWell(
        splashColor: splashColor,
        onTap: onTap,
        child: SizedBox(
          width: 600,
          height: 200,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  icon,
                  size: 50,
                  color: Colors.white,
                ),
                Center(
                  child: Text(
                    data.toUpperCase(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 27.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
