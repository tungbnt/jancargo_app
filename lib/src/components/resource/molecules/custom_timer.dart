import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jancargo_app/src/general/constants/app_styles.dart';
import 'package:jancargo_app/src/util/app_convert.dart';
import 'package:jancargo_app/src/util/app_gap.dart';

import '../../../domain/dtos/time/time_formatter.dart';
import '../../../general/constants/app_colors.dart';

class CountdownScreen extends StatefulWidget {
  const CountdownScreen({super.key, required this.dateTime});
  final String dateTime;

  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  late Timer timer;
  TimerDto dto = TimerDto(day: '00',hour: '00',minutes: '00',second: '00',);
  late DateTime targetDateTime; // Đối tượng DateTime mục tiêu

  @override
  void initState() {
    super.initState();
    _convertTime();
  }
  void _timeConvert({required Duration duration}){
    dto = AppConvert.timeConvert(duration: targetDateTime.difference(DateTime.now()));
  }

  void _convertTime() {
    targetDateTime = AppConvert.convertDateTime(dateString: widget.dateTime);
    _count();
  }

  void _count(){
    // Tạo một timer để cập nhật giao diện mỗi giây
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        // Lấy thời gian hiện tại
        DateTime now = DateTime.now();

        // Tính toán khoảng thời gian còn lại
        Duration remainingTime = targetDateTime.isAfter(now)
            ? targetDateTime.difference(now)
            : Duration(seconds: 0);
        print(remainingTime);
        //convert date time => day,hour...
        _timeConvert(duration: targetDateTime.difference(DateTime.now()));

        // Kiểm tra xem đã đạt được thời gian mục tiêu chưa
        if (remainingTime == 0 ) {
          t.cancel(); // Dừng timer khi đạt thời gian mục tiêu
        }
      });
    });
  }


  @override
  void dispose() {
    timer.cancel(); // Hủy timer khi widget bị dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return customTime();
  }

  Widget customTime(){
    return targetDateTime.isAfter(DateTime.now()) && dto != null ?
    Row(
      children: [
        _boxTimer(dto.day!),
        _space(),
        _boxTimer(dto.hour!),
        _space(),
        _boxTimer(dto.minutes!),
        _space(),
        _boxTimer(dto.second!),
      ],
    ) : Container();
  }

  Widget _boxTimer(String time)=> Container(
    padding: EdgeInsets.symmetric(horizontal: AppGap.w3,vertical: AppGap.w3),
    decoration: BoxDecoration(
      color: AppColors.black03,
      borderRadius: BorderRadius.circular(AppGap.r8),
    ),
    child: Text(
      time,
      style: AppStyles.text6014(),
    ) ,
  );
  Widget _space()=>Text(
    ' : ',
    style: AppStyles.text7016(),
  );
}