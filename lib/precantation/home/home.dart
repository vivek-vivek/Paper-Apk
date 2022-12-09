import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reqress_api/api/services.dart';
import 'package:reqress_api/core/colors.dart';
import 'package:reqress_api/core/constatnts.dart';
import 'package:reqress_api/models/main_api_model.dart';
import '../../models/article_model.dart';
import 'widgets/container_bar_widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // getArticlesFromApi();
    super.initState();
  }

  List<Article>? articleData = [];
  bool isLoading = true;
  String errorMessage = '';
  Future<void> getArticlesFromApi() async {
    MainApiModel? response = await ApiServices().fetchUser();
    if (response != null) {
      
      if (response.articles != null) {
        
        setState(() {
          articleData = response.articles ?? [];
          errorMessage = response.message ?? 'hallo';
          isLoading = false;
        });
      } else {
        try {
          setState(() {
            isLoading = true;
          });
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: kMainThem,
              content: Text(
                "error Message",
                style: TextStyle(color: kBlack),
              ),
            ),
          );
        } on TypeError catch (e) {
          log("🧨");
          log(e.toString());
        }
      }
    } else {
      setState(() {
        isLoading = false;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: kMainThem,
          content: Text("Error Occurred"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: getArticlesFromApi(),
      builder: (context, snapshot) => Container(
        color: kBlack,
        child: Column(
          children: [
            const AppBarWidget(),
            const SizedBox(height: 40),
            Expanded(
              child: isLoading
                  ? ListView.separated(
                      itemBuilder: (context, index) => Container(
                            height: 500,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  Image(
                                    image: NetworkImage(
                                        articleData?[index].urlToImage ?? ''),
                                    height: 200,
                                    width: double.infinity,
                                  ),
                                  Text(
                                    articleData?[index].title ?? ' ',
                                    style: GoogleFonts.anekBangla(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: kWhite),
                                  ),
                                  Text(
                                    articleData?[index].author ?? ' ',
                                    style: GoogleFonts.anekBangla(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: kWhite),
                                  ),
                                  Text(
                                    articleData?[index].description ?? ' ',
                                    style: GoogleFonts.varela(
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.bold,
                                        color: kWhite),
                                  ),
                                  kSizedBox10,
                                  Text(
                                    "23/10/2004",
                                    style: GoogleFonts.anekBangla(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: kWhite),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      separatorBuilder: (context, index) => kSizedBox10,
                      itemCount: articleData?.length ?? 0)
                  : const Center(
                      child: CircularProgressIndicator(color: kWhite)),
            ),
          ],
        ),
      ),
    )
        // isLoading
        // ?
        // : Container(
        //     color: kBlack,
        //     height: double.infinity,
        //     width: double.infinity,
        //     child: const Center(
        //       child: CircularProgressIndicator(
        //         color: kWhite,
        //       ),
        //     ),
        //   ),
        );
  }
}
