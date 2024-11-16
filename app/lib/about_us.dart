import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import 'teaminfo.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AboutUsState();
  }
}

class AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            width: width,
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 80,
                    foregroundColor: Colors.green,
                    backgroundImage: AssetImage('assets/logo.jpg'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Contact Us',
                  style: GoogleFonts.varelaRound(
                      fontSize: 36,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
          const SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              'Contact Us',
              style: GoogleFonts.poppins(fontSize: 22, color: Colors.black),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Row(
              children: [
                const Icon(
                  Icons.email,
                  color: Colors.green,
                ),
                Text(
                  ' Email:  ',
                  style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
                ),
                InkWell(
                  onTap: () async {
                    _launchemailURL('usmanmasud260@gmail.com');
                    setState(() {});
                  },
                  child: const Text(
                    'usmanmasud260@gmail.com',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text(
              'Call Us',
              style: GoogleFonts.poppins(fontSize: 22, color: Colors.black),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Row(
              children: [
                const Icon(
                  Icons.phone,
                  color: Colors.green,
                ),
                Text(
                  'Techinical support: ',
                  style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
                ),
                InkWell(
                  onTap: () => launch("tel://09136335556"),
                  child: const Text(
                    '2349136335556',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Row(
              children: [
                const Icon(
                  Icons.phone,
                  color: Colors.green,
                ),
                Text(
                  'Agro Support: ',
                  style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
                ),
                InkWell(
                  onTap: () => launch("tel://09043238328"),
                  child: const Text(
                    '2349043238328',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          //  Padding(
          //      padding: const EdgeInsets.fromLTRB(10, 0,0,10),
          //      child: Card(
          //        elevation: 5,
          //          child: Padding(
          //              padding: const EdgeInsets.all(10),
          //              child: Text('Recently we have observed the emerging concept of smart farming that makes agriculture more efficient and effective with the help of high-precision algorithms.Our App allows the users to estimate whether the use of pesticides will damage their crop or not . This app also gives user important information like the weather , soil types and tips for good farming . ',style: GoogleFonts.poppins(fontSize:16,color: Colors.black),textAlign: TextAlign.center,),))),
          // // const SizedBox(height: 10,),'
          const SizedBox(
            height: 60,
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TeamInfo()));
                },
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(35),
                      image: const DecorationImage(
                          image: AssetImage('assets/titans.jpeg'))),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchemailURL(String url1) async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: url1,
    );
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
