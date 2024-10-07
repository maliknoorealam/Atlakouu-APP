import 'package:atalakou/databases/jobs_service.dart';
import 'package:atalakou/utils/constants.dart';
import 'package:atalakou/widgets/common/back_arrow.dart';
import 'package:atalakou/widgets/lookingforjob/common/bottom_navigation_separate_lfj.dart';
import 'package:atalakou/widgets/lookingforjob/joboffers/job_info_bar.dart';
import 'package:atalakou/widgets/lookingforjob/joboffers/search_button.dart';
import 'package:atalakou/widgets/lookingforjob/joboffers/search_text_fields.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class JobOffersPage extends StatefulWidget {
  const JobOffersPage({super.key});

  @override
  State createState() => _JobOffersPageState();
}

class _JobOffersPageState extends State<JobOffersPage> with SingleTickerProviderStateMixin {
  final TextEditingController _jobDomainController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  List _jobs = [];
  bool _isLoading = false;
  String emptyText = searchForJobs;
  final JobService jobService = Get.find();

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _cityController.dispose();
    _jobDomainController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackArrow(),
        title: const Text(jobOffersAppBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SearchTextFields(
                controller: _jobDomainController, title: jobDomainLabel),
            SearchTextFields(controller: _cityController, title: cityLabel),
            SearchButton(
              onTap: _searchJobs,
            ),
            const SizedBox(height: 20),
            if (_isLoading)
              const Center(
                  child: CircularProgressIndicator(
                    color: navyColor,
                  ))
            else
              Expanded(
                child: _jobs.isNotEmpty
                    ? ListView.builder(
                  itemCount: _jobs.length,
                  itemBuilder: (context, index) {
                    final job = _jobs[index];

                    return AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(1, 0),
                            end: Offset.zero,
                          ).animate(CurvedAnimation(
                            parent: _animationController,
                            curve: Interval(
                              index / _jobs.length,
                              (index + 1) / _jobs.length,
                              curve: Curves.easeOut,
                            ),
                          )),
                          child: child,
                        );
                      },
                      child: JobInfoBar(job: job),
                    );
                  },
                )
                    : Center(
                  child: Text(emptyText),
                ),
              )
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigationLFJ(context),
    );
  }

  Future _searchJobs() async {
    setState(() {
      _isLoading = true;
    });

    await jobService.fetchWithQuery(
      jobDomain: _jobDomainController.text,
      city: _cityController.text,
    );

    setState(() {
      _jobs = jobService.displayedJobs;
      _isLoading = false;
      emptyText = noJobFound;
    });

    // Reset and start the animation
    _animationController.reset();
    _animationController.forward();
  }
}
