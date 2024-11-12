import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Aboutus extends StatelessWidget {
  const Aboutus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade400,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'About Us',
          style: GoogleFonts.nunito(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[400],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 10, top: 20),
                child: Text(
                  'Our Journey...',
                  style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Text(
                  "SKF Elixer India Pvt. Ltd.,has pioneered in innovative solutions that assists with production of nutritious grains, purest water &  safer environment.Established in 1987 by Mr.G.Ramakrishna Achar,we are now the global leaders in designing and manufacturing the best-in-class paddy processing plants, water purifiers, and wastewater treatment plants.",
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  'Paddy Processing',
                  style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Text(
                  "S.K.F. Elixer is the first company in India to introduce stainless steel Paddy Processing plants. These sophisticated plants are fully equipped to process any kind of paddy in the world and generate the most exquisite and finest of rice grains.",
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 30.0,
                ),
                child: Text(
                  "Water Purification",
                  style: GoogleFonts.nunito(
                      fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30),
                child: Text(
                  "Armed with thorough research capabilities in the water purification sector, we have also ventured into STP-ETP solutions space. At SKF Elixer, our ethics and commitment motivate us in improving the facilities that cause enormous wastage of water in mills, increased sewage/effluents from rapid urbanization and a strong urge to protect our environment.",
                  style: GoogleFonts.nunito(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text(
                  "Why Choose Us",
                  style: GoogleFonts.nunito(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 30.0,
                  right: 30,
                ),
                child: Text(
                  "SKF Elixer uses advanced technology and latest innovations to stay up to date with the market trends",
                  style: GoogleFonts.nunito(fontSize: 18),
                  textAlign: TextAlign.justify,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Text(
                  "Contact Us",
                  style: GoogleFonts.nunito(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 30.0,
                    ),
                    child: Icon(
                      Icons.call,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "+91 6366 535 990",
                    style: GoogleFonts.nunito(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 30.0),
                    child: Icon(
                      Icons.mail,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "service@skfgrainstech.com",
                    style: GoogleFonts.nunito(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
