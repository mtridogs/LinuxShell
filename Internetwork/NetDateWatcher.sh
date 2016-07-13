#!/bin/bash
timer=0
data_sum_min=0
while true
do


RX=`ifconfig |grep "RX bytes:" |grep "iB"`
RX=${RX#*s:}
RX=${RX%%(*}
RX=${RX%%.*}

TX=`ifconfig |grep "RX bytes:" |grep "iB"`
TX=${TX##*s:}
TX=${TX%(*}
TX=${TX%%.*}


sleep 2

RXs=`ifconfig |grep "RX bytes:" |grep "iB"`
RXs=${RXs#*s:}
RXs=${RXs%%(*}
#RXs=${RXs%%.*}

TXs=`ifconfig |grep "RX bytes:" |grep "iB"`
TXs=${TXs##*s:}
TXs=${TXs%(*}
#TXs=${TXs%%.*}

RX_sum=`echo "scale=5;${RXs} - ${RX}"|bc`
TX_sum=`echo "scale=5;${TXs} - ${TX}"|bc`

data_sum_20=`echo "scale=5;${RX_sum} + ${TX_sum}"|bc`
data_sum_20=`echo "scale=5;${data_sum_20} / 1024"|bc`
echo `date`"       20s内使用的网络流量为          "$data_sum_20 /KiB
data_sum_min=`echo ${data_sum_20} + ${data_sum_min}|bc`
timer=`expr $timer + 1`

if [ $timer = 3 ];then
echo `date`"       60s内使用的网络流量为          "$data_sum_min /KiB
data_sum_min=0
timer=0
fi
done


