import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dynamic_tabbar/dynamic_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lilac_task/common/contants/Palette.dart';
import 'package:lilac_task/common/contants/image_constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../main.dart';

class CourseDetailsScreen extends StatefulWidget {
  const CourseDetailsScreen({super.key});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  Widget gap = const SizedBox(
    height: 10,
  );

  Widget divider = Divider(
    color: ColorPalette.grey1.withOpacity(0.2),
  );

  bool fav = false;
  List carousalImages = [
    "https://images.pexels.com/photos/914931/pexels-photo-914931.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/864994/pexels-photo-864994.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/1015568/pexels-photo-1015568.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
  ];

  int currentCarousal = 0;

  List tabList = [
    "Course",
    "Eligibility",
    "University",
    "Entrance",
    "Syllabus",
    "Fees"
  ];

  List<TabData> tabs = [
    TabData(
      index: 1,
      title: const Tab(
        child: Text('Course'),
      ),
      content: const Center(child: Text('Content for Tab 1')),
    ),
    TabData(
      index: 2,
      title: const Tab(
        child: Text('Eligibility'),
      ),
      content: const Center(child: Text('Content for Tab 2')),
    ),

    // Add more tabs as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                CarouselSlider(
                    items: List.generate(
                      carousalImages.length,
                      (index) {
                        return Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      carousalImages[index]),
                                  fit: BoxFit.cover)),
                        );
                      },
                    ),
                    options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentCarousal = index;
                          });
                        },
                        autoPlay: true,
                        viewportFraction: 1,
                        height: h * 0.3)),
                Positioned(
                  bottom: 10,
                  left: w * 0.4,
                  child: AnimatedSmoothIndicator(
                    activeIndex: currentCarousal,
                    count: carousalImages.length,
                    effect: const WormEffect(
                        dotColor: ColorPalette.white,
                        activeDotColor: ColorPalette.grey1,
                        dotHeight: 10,
                        dotWidth: 10),
                  ),
                ),
                Positioned(
                    top: 30,
                    left: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(
                            ImageConstants.white_back_button,
                            height: w * 0.08,
                          )),
                    )),
                Positioned(
                    top: 30,
                    right: 30,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              fav = !fav;
                              setState(() {});
                            },
                            child: CircleAvatar(
                              child: fav
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : const Icon(Icons.favorite_border),
                              backgroundColor: ColorPalette.white,
                            ),
                          ),
                        ),
                        const CircleAvatar(
                          child: Icon(Icons.share),
                          backgroundColor: ColorPalette.white,
                        ),
                      ],
                    ))
              ],
            ),
            gap,
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: w * 0.8,
                      child: const Text(
                        "BSc (Hons) Construction Management (top-up) BSc (Hons) Construction ",
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 16),
                      ),
                    ),
                    gap,
                    Row(
                      children: [
                        SvgPicture.asset(
                          ImageConstants.university_icon,
                          height: w * 0.04,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Container(
                              child: const Text(
                            "Lancaster University",
                            style: TextStyle(
                                color: ColorPalette.grey1, fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          )),
                        )
                      ],
                    ),
                    Container(
                      width: w,
                      height: h * 0.25,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DynamicTabBarWidget(
                          indicatorColor: ColorPalette.secondary,
                          dynamicTabs: List.generate(
                            tabList.length,
                            (index) => TabData(
                                index: index,
                                title: Tab(
                                  child: Text(tabList[index]),
                                ),
                                content: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(index == 0
                                        ? "Academically, b.sc (hons) is regarded as being a more standard degree as compared to b.sc (general). Prestigious universities may also demand a rigorous dissertation from every student for completion of the B.Sc. (Hons) course."
                                        : "Content for ${tabList[index]}"),
                                  ),
                                )),
                          ),
                          // optional properties :-----------------------------
                          isScrollable: true,
                          onTabControllerUpdated: (controller) {
                            debugPrint("onTabControllerUpdated");
                          },
                          onTabChanged: (index) {
                            debugPrint("Tab changed: $index");
                          },
                          onAddTabMoveTo: MoveToTab.last,
                          labelStyle:
                              const TextStyle(color: ColorPalette.secondary),
                          // backIcon: Icon(Icons.keyboard_double_arrow_left),
                          // nextIcon: Icon(Icons.keyboard_double_arrow_right),
                          showBackIcon: false,
                          showNextIcon: false,
                          leading: const SizedBox(),

                          trailing: const SizedBox(),
                        ),
                      ),
                    ),
                    divider,
                    gap,
                    const Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: ColorPalette.secondary,
                          child: Icon(
                            CupertinoIcons.checkmark_alt,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Eligibility",
                            style: TextStyle(
                                color: ColorPalette.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        )
                      ],
                    ),
                    gap,
                    Container(
                      width: w,
                      height: h * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w * 0.3),
                        color: ColorPalette.grey5,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Row(
                            children: [
                              Text(
                                "HSE or SSE:",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                " 60",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: ColorPalette.secondary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    gap,
                    Container(
                      width: w,
                      height: h * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w * 0.3),
                        color: ColorPalette.grey5,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Row(
                            children: [
                              Text(
                                "IELTS:",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                " 60",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: ColorPalette.secondary),
                              ),
                              Text(
                                "/ ENGLISH for HSE or SSE:",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                " 65",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: ColorPalette.secondary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    gap,
                    divider,
                    gap,
                    const Row(
                      children: [
                        // CircleAvatar(
                        //   radius: 18,
                        //   backgroundColor: ColorPalette.secondary,
                        //   child: SvgPicture.asset(ImageConstants.info_icon,),
                        // ),

                        CircleAvatar(
                          radius: 18,
                          backgroundColor: ColorPalette.secondary,
                          child: Icon(
                            CupertinoIcons.checkmark_alt,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Course Duration",
                            style: TextStyle(
                                color: ColorPalette.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: w,
                      height: h * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w * 0.3),
                        color: ColorPalette.grey5,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Row(
                            children: [
                              Text(
                                "1 Year and 6 Months",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    gap,
                    divider,
                    gap,
                    Row(
                      children: [
                        // CircleAvatar(
                        //   radius: 18,
                        //   backgroundColor: ColorPalette.secondary,
                        //   child: SvgPicture.asset(ImageConstants.university_icon_white,),
                        // ),

                        CircleAvatar(
                          radius: 18,
                          backgroundColor: ColorPalette.secondary,
                          child: SvgPicture.asset(
                            ImageConstants.info_icon,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Course Intakes",
                            style: TextStyle(
                                color: ColorPalette.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    gap,
                    Row(
                      children: [
                        Container(
                          // width: w,
                          height: h * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(w * 0.3),
                            color: ColorPalette.grey5,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Center(
                              child: Row(
                                children: [
                                  Text(
                                    "2023 January",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            // width: w,
                            height: h * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(w * 0.3),
                              color: ColorPalette.grey5,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Center(
                                child: Row(
                                  children: [
                                    Text(
                                      "2023 March",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    gap,
                    divider,
                    gap,
                    Row(
                      children: [
                        // CircleAvatar(
                        //   radius: 18,
                        //   backgroundColor: ColorPalette.secondary,
                        //   child: SvgPicture.asset(ImageConstants.university_icon_white,),
                        // ),

                        CircleAvatar(
                          radius: 18,
                          backgroundColor: ColorPalette.secondary,
                          child: SvgPicture.asset(
                            ImageConstants.university_icon_white,
                            height: 16,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "University",
                            style: TextStyle(
                                color: ColorPalette.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    gap,
                    const Text(
                      "Lancaster University",
                      style: TextStyle(
                          color: ColorPalette.grey1,
                          fontSize: 16,
                          fontWeight: FontWeight.w900),
                    ),
                    gap,
                    const Text(
                      "Academically, b.sc (hons) is regarded as being a more standard degree as compared to b.sc (general). Prestigious universities may also demand a rigorous dissertation from every student for completion of the B.Sc. (Hons) course.",
                      style: TextStyle(color: ColorPalette.black_grey),
                    ),
                    gap,
                    Row(
                      children: [
                        SvgPicture.asset(
                          ImageConstants.location_pin,
                          height: w * 0.04,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Container(
                              child: const Text(
                            "London, United Kingdom",
                            style: TextStyle(
                                color: ColorPalette.grey1, fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          )),
                        )
                      ],
                    ),
                    gap,
                    Row(
                      children: [
                        SvgPicture.asset(
                          ImageConstants.ranking_icon,
                          height: w * 0.04,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Container(
                              child: const Text(
                            "5th",
                            style: TextStyle(
                                color: ColorPalette.grey1, fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          )),
                        )
                      ],
                    ),
                    gap,
                    Container(
                      width: w,
                      height: h * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w * 0.3),
                        color: ColorPalette.grey5,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: ColorPalette.grey1,
                                child: SvgPicture.asset(
                                  ImageConstants.download_icon,
                                  height: 16,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                "Download University Brochure",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    gap,
                    divider,
                    gap,
                    Row(
                      children: [
                        // CircleAvatar(
                        //   radius: 18,
                        //   backgroundColor: ColorPalette.secondary,
                        //   child: SvgPicture.asset(ImageConstants.university_icon_white,),
                        // ),

                        CircleAvatar(
                          radius: 18,
                          backgroundColor: ColorPalette.secondary,
                          child: SvgPicture.asset(
                            ImageConstants.syllabus_icon,
                            height: 18,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Course Syllabus",
                            style: TextStyle(
                                color: ColorPalette.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    gap,
                    const Text(
                      "Academically, b.sc (hons) is regarded as being a more standard degree as compared to b.sc (general). Prestigious universities may also demand a rigorous dissertation from every student for completion of the B.Sc. (Hons) course.",
                      style: TextStyle(color: ColorPalette.black_grey),
                    ),
                    gap,
                    Container(
                      width: w,
                      height: h * 0.06,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(w * 0.3),
                        color: ColorPalette.grey5,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: ColorPalette.grey1,
                                child: SvgPicture.asset(
                                  ImageConstants.download_icon,
                                  height: 16,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                "Download Course Syllabus",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    gap,
                    divider,
                    gap,
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: ColorPalette.secondary,
                          child: SvgPicture.asset(
                            ImageConstants.fee_icon,
                            height: 18,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Placement",
                            style: TextStyle(
                                color: ColorPalette.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      "Placement assistance provided",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: ColorPalette.black_grey),
                    ),
                    const Text(
                      "Available for leading firms like ABCD, EFGH",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: ColorPalette.black_grey),
                    ),
                    gap,
                    divider,
                    gap,
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: ColorPalette.secondary,
                          child: SvgPicture.asset(
                            ImageConstants.fee_icon,
                            height: 18,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Total fee",
                            style: TextStyle(
                                color: ColorPalette.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    gap,
                    Container(
                      decoration: BoxDecoration(
                          color: ColorPalette.grey5,
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Term",
                                    style: TextStyle(
                                        color: ColorPalette.grey1,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "Fee",
                                    style: TextStyle(
                                        color: ColorPalette.grey1,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "First Year",
                                    style: TextStyle(
                                        color: ColorPalette.black_grey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "₹50000",
                                    style: TextStyle(
                                        color: ColorPalette.black_grey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Second Year",
                                    style: TextStyle(
                                        color: ColorPalette.black_grey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "₹50000",
                                    style: TextStyle(
                                        color: ColorPalette.black_grey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Third Year",
                                    style: TextStyle(
                                        color: ColorPalette.black_grey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "₹50000",
                                    style: TextStyle(
                                        color: ColorPalette.black_grey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                            gap,
                            divider,
                            gap,
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total",
                                    style: TextStyle(
                                        color: ColorPalette.secondary,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "₹150000",
                                    style: TextStyle(
                                        color: ColorPalette.secondary,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    gap,
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: ColorPalette.secondary,
                          child: SvgPicture.asset(
                            ImageConstants.documents_icon,
                            height: 18,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Documents Required",
                            style: TextStyle(
                                color: ColorPalette.primary,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: w,
                      decoration: BoxDecoration(
                          color: ColorPalette.grey5,
                          borderRadius: BorderRadius.circular(15)),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Passport",
                              style: TextStyle(
                                  fontSize: 16, color: ColorPalette.black_grey),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Previous Course Certificates",
                              style: TextStyle(
                                  fontSize: 16, color: ColorPalette.black_grey),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Reference Letter",
                              style: TextStyle(
                                  fontSize: 16, color: ColorPalette.black_grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                    gap,
                    gap,
                    Center(
                      child: Container(
                          width: w * 0.9,
                          height: h * 0.07,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  )),
                                  backgroundColor: const WidgetStatePropertyAll(
                                      ColorPalette.primary)),
                              onPressed: () {},
                              child: const Text(
                                "Get Admission",
                                style: TextStyle(
                                  color: ColorPalette.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ))),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
