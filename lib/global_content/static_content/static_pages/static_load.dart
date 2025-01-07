import 'package:flutter/material.dart';

/*
intermediary loading page
 */

class StaticLoad extends StatelessWidget {
  StaticLoad({super.key});
  bool gif = true;
  @override
  Widget build(BuildContext context){
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SizedBox(
        width: mediaQuery.size.width,
        height: mediaQuery.size.height,
        child: ClipRect(
          child: FittedBox(
              fit: BoxFit.cover,
              child: Stack(
                children: [
                  Image.asset('assets/images/placeholder.png'),
                  StatefulBuilder(builder: (context, setState){
                    Future.delayed(const Duration(milliseconds: 3600), (){
                      setState(() {
                        gif = false;
                      });
                    });
                    if(gif){
                      return Image.asset('assets/images/loading.gif');
                    }
                    return Container();
                  })
                ],
              )
          ),
        ),
      ),
    );
  }
}
