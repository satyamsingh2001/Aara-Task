import 'package:aara_task/const/const_container.dart';
import 'package:aara_task/style/colors/colors_const.dart';
import 'package:aara_task/style/text_styles/textstyle_const.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../const/const_string.dart';
import '../../services/apis/emoi_api.dart';
import '../controllers/image_controller.dart';
import '../models/emoji_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImageController imageController = Get.put(ImageController());

  late Future<List<SimpleEmoji>> futureEmojiList;

  @override
  void initState() {
    super.initState();
    futureEmojiList = fetchEmojiList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary100,
      appBar: AppBar(
        backgroundColor: AppColors.secondary100,
        centerTitle: true,
        leading: const Icon(
          Icons.arrow_back,
          color: AppColors.white,
        ),
        title: Text(
          "Xcellence PVT LTD Company, Lucknow",
          style: AppTextStyles.kBody15SemiboldTextStyle
              .copyWith(color: AppColors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GetBuilder<ImageController>(
                    builder: (imageController) => InkWell(
                      onTap: () async {
                        await imageController.pickedProfile(ImageSource.gallery);
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: imageController.profile != null
                                ? FileImage(imageController.profile!)
                                : const AssetImage(pic) as ImageProvider,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Satyam Singh",
                        style: AppTextStyles.kBody17SemiboldTextStyle
                            .copyWith(color: AppColors.white),
                      ),
                      Text(
                        "Developer",
                        style: AppTextStyles.kBody15RegularTextStyle
                            .copyWith(color: AppColors.white),
                      ),
                    ],
                  )
                ],
              ),
              ConstantContainer(
                height: Get.height * .25,
                width: Get.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "How's the ",
                          style: AppTextStyles.kBody20SemiboldTextStyle
                              .copyWith(color: AppColors.white),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Mood\n',
                              style: AppTextStyles.kBody20SemiboldTextStyle
                                  .copyWith(color: AppColors.primary),
                            ),
                            TextSpan(
                              text: 'Today?',
                              style: AppTextStyles.kBody20SemiboldTextStyle
                                  .copyWith(color: AppColors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: Get.height * 0.1,
                        width: Get.width,
                        child: FutureBuilder<List<SimpleEmoji>>(
                          future: futureEmojiList,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}',style: const TextStyle(color: AppColors.white),);
                            } else {
                              List<SimpleEmoji>? emojiList = snapshot.data;
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  SimpleEmoji emoji = emojiList![index];
                                  return Text(
                                    emoji.character,
                                    style: AppTextStyles.kLargeTitleTextStyle,
                                  );
                                },
                              );
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const Divider(
                color: AppColors.white,
                thickness: 1.5,
              ),
              Row(
                children: [
                  Text(
                    SimpleEmoji(character: "😀").character,
                    style: AppTextStyles.kHeading3TextStyle,
                  ),
                  Text(
                    "  Team Mood  ",
                    style: AppTextStyles.kBody17RegularTextStyle
                        .copyWith(color: AppColors.white),
                  ),
                  const Expanded(
                    child: Divider(
                      color: AppColors.white,
                      thickness: 1.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ConstantContainer(
                  height: Get.height * .13,
                  width: Get.width,
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: ' " ',
                                style: AppTextStyles.kHeading1TextStyle
                                    .copyWith(color: AppColors.primary),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'The team is feeling good\n     today',
                                    style: AppTextStyles.kBody20SemiboldTextStyle
                                        .copyWith(color: AppColors.white),
                                  ),
                                  TextSpan(
                                    text: ' "',
                                    style: AppTextStyles.kHeading1TextStyle
                                        .copyWith(color: AppColors.primary),
                                  ),
                                ],
                              ),
                            ),
                          ]))),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: Get.height*0.25,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(show: true),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: AppColors.white90, width: 1),
                    ),
                    minX: 0,
                    maxX: 9,
                    minY: 0,
                    maxY: 5,
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          const FlSpot(0, 4),
                          const FlSpot(2, 5),
                          const FlSpot(3, 0),
                          const FlSpot(4, 5),
                          const FlSpot(5, 3),
                          const FlSpot(6, 4),
                          const FlSpot(7, 4),
                          const FlSpot(8, 3),
                          const FlSpot(9, 5),
                        ],
                        isCurved: false,
                        colors: [Colors.green],
                        dotData: FlDotData(show: true),
                        belowBarData: BarAreaData(show: false),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
