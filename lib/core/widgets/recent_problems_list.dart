import 'package:flutter/material.dart';

class RecentProblems extends StatefulWidget {
  const RecentProblems({super.key});

  @override
  State<RecentProblems> createState() => _RecentProblemsState();
}

class _RecentProblemsState extends State<RecentProblems> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red, width: .1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Problems",
                style: TextStyle(fontWeight: FontWeight.bold,color: Color(0XFF4682B4)),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  "View all",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0XFF4682B4)),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent, width: .1),
          ),
          height: MediaQuery.of(context).size.height * 0.15,
          width: double.infinity,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 8,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              //String plans = planstate.planlist[index].planName;
              return SizedBox(
                width: MediaQuery.of(context).size.width * .44,
                child: Card(
                  color: Color(0XFF4682B4),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    //decoration: BoxDecoration(
                    //  image: DecorationImage(
                    //    image: AssetImage('assets/images/back1.png'),
                    //    fit: BoxFit.cover,
                    //  ),
                    //),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Recent Problems",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
