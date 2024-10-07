import 'package:atalakou/databases/job_applications_service.dart';
import 'package:atalakou/widgets/common/notifs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../databases/contact_service.dart';
import '../../../utils/constants.dart';

class ApplyButton extends StatefulWidget {
  const ApplyButton({super.key, required this.jobId});

  final String jobId;

  @override
  State<ApplyButton> createState() => _ApplyButtonState();
}

class _ApplyButtonState extends State<ApplyButton> {

  bool buttonDisabled = false;
  Color buttonColor = goldColor;
  ContactService contactService = Get.find();

  @override
  void initState() {
    //Button is disabled if user has already applied for the job
    getButtonStatus(widget.jobId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return  GestureDetector(
      onTap: (){
        if(!buttonDisabled) {
          applyForJob(widget.jobId);
        }
        else{
          showToast(alreadyApplied);
        }
      },
      child: Container(
        margin: const EdgeInsets.all(20),
        height: 80,
        width: size.width,
        decoration: BoxDecoration(
            color: buttonColor,
            borderRadius: BorderRadius.circular(10)
        ),
        child: const Center(child: Text(applyButtonContent,style: TextStyle(fontWeight: FontWeight.w400,
            color: whiteColor,
            fontSize: 28),)),
      ),
    );
  }

  void applyForJob(String jobId) async {
      bool submitted = await JobApplicationsService().submitJobApplication(jobId);
      if(submitted){
        getButtonStatus(jobId);
        await contactService.launchWhatsApp();
        contactService.isLoading.value = false;
      }
  }

  void getButtonStatus(String jobId) async {
    buttonDisabled = await JobApplicationsService().hasUserAlreadyApplied(jobId);
    setState(() {
      buttonColor = buttonDisabled?goldColorWithOpacity:goldColor;
    });
  }
}
