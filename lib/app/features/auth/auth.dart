import 'package:cloud/app/constants/app_colors.dart';
import 'package:cloud/app/features/auth/auth.controller.dart';
import 'package:cloud/app/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Auth extends GetView {
  final AuthPageController controller = Get.put(AuthPageController());

  buildSignIn() {
    return Obx(()=>
       Form(
         key: controller.signInForm,
         child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.greyLight,
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  controller: controller.emailController,
                  validator: (value) => controller.validateEmail(value??""),
                  autovalidateMode:AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    icon: SvgPicture.asset(
                      "assets/icons/user.svg",
                      width: 24,
                      height: 24,
                      color: AppColors.dark,
                    ),
                    hintText: "Email",
                    fillColor: AppColors.dark,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:12),
              decoration: BoxDecoration(
                  color: AppColors.greyLight,
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  controller: controller.passwordController,
                  validator: (value) => (value?.isEmpty??false)?"enter your password":null,
                  autovalidateMode:AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    icon: SvgPicture.asset(
                      "assets/icons/lock.svg",
                      width: 24,
                      height: 24,
                      color: AppColors.dark,
                    ),
                    hintText: "Password",
                    fillColor: AppColors.dark,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
           Padding(
             padding: EdgeInsets.only(top: 24),
             child:  submitButton("Sign in", controller.doSignIn,isLoading: controller.signInLoading.value),
           )
          ],
      ),
       ),
    );
  }

  buildSignUp() {
    return Column();
  }

  @override
  Widget build(BuildContext context) {
    var items = ["Sign In", "sign Up"];

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 24, right: 24, left: 24),
        child: Column(
          children: [
            Row(
              children: [
                InkResponse(
                  onTap: () => Get.back(),
                  child: SvgPicture.asset(
                    "assets/icons/back_navigation.svg",
                    width: 24,
                    height: 24,
                    color: AppColors.dark,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(start: 8),
                  child: Text("back"),
                )
              ],
            ),
            Spacer(
              flex: 1,
            ),
            Flexible(
                flex: 5,
                child: DefaultTabController(
                  length: items.length,
                  child: Column(
                    children: [
                      Container(
                        height: 46,
                        child: Stack(
                          children: [
                            Container(
                              height: 46,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: AppColors.brand.withOpacity(0.5),
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                            TabBar(
                              indicatorColor: AppColors.brand,
                              tabs: List.generate(
                                  items.length,
                                  (index) => Tab(
                                        child: Text(
                                          items[index],
                                          style:
                                              TextStyle(color: AppColors.dark),
                                        ),
                                      )),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: TabBarView(
                            physics: BouncingScrollPhysics(),
                            children: [buildSignIn(), buildSignUp()],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                // Obx(() => buildTab(controller.currentTab.value)),
                )
          ],
        ),
      )),
    );
  }
}
