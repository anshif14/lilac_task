import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lilac_task/common/contants/Palette.dart';
import 'package:lilac_task/common/contants/image_constants.dart';
import 'package:lilac_task/features/featured%20Course/screens/course_details_screen.dart';

import '../../../main.dart';

class FeaturedCourseScreen extends StatefulWidget {
  final String accessToken;
  const FeaturedCourseScreen({super.key, required this.accessToken});

  @override
  State<FeaturedCourseScreen> createState() => _FeaturedCourseScreenState();
}

class _FeaturedCourseScreenState extends State<FeaturedCourseScreen> {
  List<dynamic> featuredCourses = [];

  ScrollController scrollController = ScrollController();
  int currentPage = 1;

  void fetchData(int page) async {
    featuredCourses.addAll([1,2,3,4,5,6,7,8,90,]);


    // Implement your API call to fetch data for page `page`
    // Update the `courses` list with the fetched data
    setState(() {});
  }
  void listenToScroll() {
    if (scrollController.position.pixels >= scrollController.position.maxScrollExtent) {
      // Load more data if needed

      print("scrolled");
      fetchData(currentPage);
      setState(() {

      });
    }
  }



  Future<void> fetchFeaturedCourses() async {
    final response = await http.get(
      Uri.parse(
          'https://test.gslstudent.lilacinfotech.com/api/landing/home/featuredCourse'),
      headers: {
        'Authorization': 'Bearer ${widget.accessToken}',
      },
    );

    final data = jsonDecode(response.body);
    print("Response code ${response.statusCode}");
    print(data);
    setState(() {
      // featuredCourses = data;
    });
  }

  @override
  void initState() {
    fetchFeaturedCourses();
    fetchData(3);
    print(featuredCourses);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Featured Courses",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        backgroundColor: ColorPalette.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(CupertinoIcons.left_chevron)),
        actions: [
          GestureDetector(
              child: SvgPicture.asset(
            ImageConstants.search_icon,
            height: w * 0.065,
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                child: SvgPicture.asset(
              ImageConstants.sort_icon,
              height: w * 0.065,
            )),
          )
        ],
      ),
      body: NotificationListener(
        onNotification: (notification) {
          if (notification is ScrollEndNotification)
          {
          listenToScroll();
          }
          return true;
        },
        child: GridView.builder(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          itemCount: featuredCourses.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.82, crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 8
        
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, CupertinoPageRoute(builder: (context) => const CourseDetailsScreen(),));
                },
                child: Container(
                  // color: Colors.red,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: ColorPalette.white,
                      boxShadow: [
                        const BoxShadow(
                            color: Color(0xd000000),
                            offset: Offset(0, 8),
                            blurRadius: 10)
                      ]),
        
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      'https://images.pexels.com/photos/927451/pexels-photo-927451.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
                                  fit: BoxFit.cover),
                              color: ColorPalette.white,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(16),
                                topLeft: Radius.circular(16),
                              )),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: ColorPalette.white.withOpacity(0.8)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              ImageConstants.location_icon,
                                              height: w * 0.03,
                                            ),
                                            const Text(
                                              "London",
                                              style: TextStyle(
                                                  color: ColorPalette.grey1,
                                                  fontSize: 10),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: ColorPalette.white),
                                      child: const Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Text(
                                          "\$50000",
                                          style: TextStyle(
                                              color: ColorPalette.grey1,
                                              fontSize: 10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          )
        
        
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(ImageConstants.university_icon,height: w*0.04,),
                                    Expanded(
                                      child: Container(
        
                                          child: const Text("  Lancaster University",style: TextStyle(color: ColorPalette.grey1,fontSize: 14),overflow: TextOverflow.ellipsis,)),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 5,),
                                Container(
                                // color: Colors.red,
        
        
                                    child:
                                    RichText(
                                      text: const TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'BSc Construction\n',
                                            style: TextStyle(
                                                fontSize: 14,fontWeight: FontWeight.w700
                                            ,color: Color(0xff0E0106)
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'Management (top-up)\n',
        
                                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700
                                                ,color: Color(0xff0E0106)
        
                                            ),
                                          ),
                                          TextSpan(
                                            text: 'BSc (Hons)...',
                                            style: TextStyle(
                                            color: Color(0xff0E0106),
        
                                                fontSize: 14,fontWeight: FontWeight.w700, overflow: TextOverflow.ellipsis),
                                          ),
                                        ],
                                      ),
                                    )
        
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      backgroundColor: ColorPalette.white,
    );
  }
}
