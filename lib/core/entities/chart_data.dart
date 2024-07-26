import 'dart:ui';

class InstallmentData {
  InstallmentData(this.x, this.y, [this.color]);
  final String x;
  final int y;
  final Color? color;
}

class ChartData {
  ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}

//class PolicyInstallment {
//  final int receivedInstallment;
//  final int totaInstallment;

//  Policy(this.receivedInstallment, this.totaInstallment);

//  ChartData getChartData() {
//    return ChartData('Total Installment', totaInstallment.toDouble());
//  }

//  ChartData getReceivedChartData() {
//    return ChartData('Received Installment', receivedInstallment.toDouble());
//  }
//}
