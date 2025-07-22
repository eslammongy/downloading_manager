import 'package:downloading_manager/core/utils/helper.dart';
import 'package:flutter/material.dart';

class ListViewAnimation extends StatefulWidget {
  const ListViewAnimation({super.key});

  @override
  State<ListViewAnimation> createState() => _ListViewAnimationState();
}

class _ListViewAnimationState extends State<ListViewAnimation> {
  double width = 0;
  bool myAnimation = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        myAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 34, 36, 49),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const Center(
              child: Text(
                "ListView Animation",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: dataItems.length,
              itemBuilder: (context, index) {
                final myUser = dataItems[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedContainer(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    duration: Duration(milliseconds: 200 + (index * 100)),
                    curve: Curves.decelerate,
                    transform: Matrix4.translationValues(
                      myAnimation ? 0 : width,
                      0,
                      0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: AssetImage(myUser.image),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                myUser.name,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(myUser.name),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
// now we add the animation 
// that's it for today vide thanks for watching.