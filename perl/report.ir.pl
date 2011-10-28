#!/usr/bin/perl -w
$RM5min=30; $RM5typ=62; $RM5max=95;
$RM6min=25; $RM6typ=41; $RM6max=55;

$SV28_M5=1748;
$SV28_M6=295;
$SV28_Current=100*1e-3;
$SV28_M5W=103;
$SV28_M6W=103;

$SV18_M5=1766;
$SV18_M6=1026;
$SV18_Current=50*1e-3;
$SV18_M5W=103;
$SV18_M6W=95;


$SV28_minV =((($SV28_M5/$SV28_M5W)*$RM5min+($SV28_M6/$SV28_M6W)*$RM6min)*$SV28_Current*1e-3)*1000;
$SV28_minIR=((($SV28_M5/$SV28_M5W)*$RM5min+($SV28_M6/$SV28_M6W)*$RM6min)*$SV28_Current*1e-3)*100/2.8;
$SV28_typV =((($SV28_M5/$SV28_M5W)*$RM5typ+($SV28_M6/$SV28_M6W)*$RM6typ)*$SV28_Current*1e-3)*1000;
$SV28_typIR=((($SV28_M5/$SV28_M5W)*$RM5typ+($SV28_M6/$SV28_M6W)*$RM6typ)*$SV28_Current*1e-3)*100/2.8;
$SV28_maxV =((($SV28_M5/$SV28_M5W)*$RM5max+($SV28_M6/$SV28_M6W)*$RM6max)*$SV28_Current*1e-3)*1000;
$SV28_maxIR=((($SV28_M5/$SV28_M5W)*$RM5max+($SV28_M6/$SV28_M6W)*$RM6max)*$SV28_Current*1e-3)*100/2.8;

$SV18_minV =((($SV18_M5/$SV18_M5W)*$RM5min+($SV18_M6/$SV18_M6W)*$RM6min)*$SV18_Current*1e-3)*1000;
$SV18_minIR=((($SV18_M5/$SV18_M5W)*$RM5min+($SV18_M6/$SV18_M6W)*$RM6min)*$SV18_Current*1e-3)*100/1.8;
$SV18_typV =((($SV18_M5/$SV18_M5W)*$RM5typ+($SV18_M6/$SV18_M6W)*$RM6typ)*$SV18_Current*1e-3)*1000;
$SV18_typIR=((($SV18_M5/$SV18_M5W)*$RM5typ+($SV18_M6/$SV18_M6W)*$RM6typ)*$SV18_Current*1e-3)*100/1.8;
$SV18_maxV =((($SV18_M5/$SV18_M5W)*$RM5max+($SV18_M6/$SV18_M6W)*$RM6max)*$SV18_Current*1e-3)*1000;
$SV18_maxIR=((($SV18_M5/$SV18_M5W)*$RM5max+($SV18_M6/$SV18_M6W)*$RM6max)*$SV18_Current*1e-3)*100/1.8;


print "-------------------------------------------------\n";
print "SV28_minV  = $SV28_minV mV\n";
print "SV28_minIR = $SV28_minIR %\n";
print "SV28_typV  = $SV28_typV mV\n";
print "SV28_typIR = $SV28_typIR %\n";
print "SV28_maxV  = $SV28_maxV mV\n";
print "SV28_maxIR = $SV28_maxIR %\n";
print "--------------------------------------------------\n";
print "SV18_minV  = $SV18_minV mV\n";
print "SV18_minIR = $SV18_minIR %\n";
print "SV18_typV  = $SV18_typV mV\n";
print "SV18_typIR = $SV18_typIR %\n";
print "SV18_maxV  = $SV18_maxV mV\n";
print "SV18_maxIR = $SV18_maxIR %\n";
print "-------------------------------------------------\n";

