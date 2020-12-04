set ns [new Simulator]

#Define different colors for data flows (for NAM)
$ns color 1 Blue
$ns color 2 Red

set nf [open out.nam w]
$ns namtrace-all $nf

set nt [open out.tr w]
$ns trace-all $nt

proc finish {} {
        global ns nf
        $ns flush-trace
        close $nf
        exec nam out.nam &
        exit 0
        }

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]
set n9 [$ns node]
set n10 [$ns node]
set n11 [$ns node]
set n12 [$ns node]


$ns duplex-link $n0 $n1 20Mb 10ms DropTail
$ns duplex-link $n7 $n3 1.5Mb 10ms DropTail
$ns duplex-link $n0 $n8 1.5Mb 10ms DropTail
$ns duplex-link $n9 $n2 1.5Mb 10ms DropTail
$ns duplex-link $n11 $n2 1.5Mb 10ms DropTail

$ns queue-limit $n1 $n4 10


$ns duplex-link-op $n1 $n4 queuePos 0.5
set udp [new Agent/UDP]
$udp set class_ 1
$ns attach-agent $n2 $udp

set cbr [new Application/Traffic/CBR]
$cbr set interval_ 0.0005
$cbr attach-agent $udp
#$cbr set packetsize_ 1000
#$cbr set rate_ 1Mb

set null [new Agent/Null]
$ns attach-agent $n5 $null


#set Queue Size of link (n2-n5) to 10
#$ns queue-limit $n1 $n4 10

set udp1 [new Agent/UDP]
$udp1 set class_ 1
$ns attach-agent $n6 $udp1 

set cbr1 [new Application/Traffic/CBR]
$cbr1 set interval_ 0.0005
$cbr1 attach-agent $udp1
#$cbr set packetsize_ 1000
#$cbr set rate_ 1Mb

set null1 [new Agent/Null]
$ns attach-agent $n8 $null1

set udp2 [new Agent/UDP]
$udp set class_ 1
$ns attach-agent $n7 $udp2

set cbr2 [new Application/Traffic/CBR]
$cbr2 set interval_ 0.0005
$cbr2 attach-agent $udp2
#$cbr set packetsize_ 1000
#$cbr set rate_ 1Mb

set null2 [new Agent/Null]
$ns attach-agent $n3 $null2


set tcp [new Agent/TCP]
$tcp set class_ 2
$ns attach-agent $n0 $tcp

set ftp [new Application/FTP]
$ftp attach-agent $tcp

set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink

$ns connect $udp $null
$ns connect $udp1 $null1
$ns connect $udp2 $null2
$ns connect $tcp $sink

$ns at 0.0 "$ftp start"
$ns at 0.8 "$cbr start"
$ns at 10.0 "finish"

$ns at 0.0 "$n2 label TCPSender"
$ns at 0.0 "$n5 label Receiver"
$ns at 0.0 "$n6 label TCPSender"
$ns at 0.0 "$n8 label Receiver"
$ns at 0.0 "$n7 label TCPSender"
$ns at 0.0 "$n3 label Receiver"

$ns runs duplex-link $n2 $n1 10Mb 10ms DropTail
$ns duplex-link $n1 $n4 5Mb 10ms DropTail
$ns duplex-link $n4 $n3 10Mb 10ms DropTail
$ns duplex-link $n4 $n5 1.5Mb 10ms DropTail
$ns duplex-link $n1 $n12 1.5Mb 10ms DropTail
$ns duplex-link $n3 $n6 1.5Mb 10ms DropTail
$ns duplex-link $n6 $n8 1.5Mb 10ms DropTail
$ns duplex-link $n7 $n10 1.5Mb 10ms DropTail
$ns duplex-link $n4 $n9 1.5Mb 10ms DropTail
$ns duplex-link $n10 $n5 1.5Mb 10ms DropTail
$ns duplex-link $n12 $n11 1.5Mb 10ms DropTail
$ns duplex-link $n7 $n3 1.5Mb 10ms DropTail
$ns duplex-link $n0 $n8 1.5Mb 10ms DropTail
$ns duplex-link $n9 $n2 1.5Mb 10ms DropTail
$ns duplex-link $n11 $n2 1.5Mb 10ms DropTail

$ns queue-limit $n1 $n4 10


$ns duplex-link-op $n1 $n4 queuePos 0.5
set udp [new Agent/UDP]
$udp set class_ 1
$ns attach-agent $n2 $udp

set cbr [new Application/Traffic/CBR]
$cbr set interval_ 0.0005
$cbr attach-agent $udp
#$cbr set packetsize_ 1000
#$cbr set rate_ 1Mb

set null [new Agent/Null]
$ns attach-agent $n5 $null


#set Queue Size of link (n2-n5) to 10
#$ns queue-limit $n1 $n4 10

set udp1 [new Agent/UDP]
$udp1 set class_ 1
$ns attach-agent $n6 $udp1 

set cbr1 [new Application/Traffic/CBR]
$cbr1 set interval_ 0.0005
$cbr1 attach-agent $udp1
#$cbr set packetsize_ 1000
#$cbr set rate_ 1Mb

set null1 [new Agent/Null]
$ns attach-agent $n8 $null1

set udp2 [new Agent/UDP]
$udp set class_ 1
$ns attach-agent $n7 $udp2

set cbr2 [new Application/Traffic/CBR]
$cbr2 set interval_ 0.0005
$cbr2 attach-agent $udp2
#$cbr set packetsize_ 1000
#$cbr set rate_ 1Mb

set null2 [new Agent/Null]
$ns attach-agent $n3 $null2


set tcp [new Agent/TCP]
$tcp set class_ 2
$ns attach-agent $n0 $tcp

set ftp [new Application/FTP]
$ftp attach-agent $tcp

set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink

$ns connect $udp $null
$ns connect $udp1 $null1
$ns connect $udp2 $null2
$ns connect $tcp $sink

$ns at 0.0 "$ftp start"
$ns at 0.8 "$cbr start"
$ns at 10.0 "finish"

$ns at 0.0 "$n2 label TCPSender"
$ns at 0.0 "$n5 label Receiver"
$ns at 0.0 "$n6 label TCPSender"
$ns at 0.0 "$n8 label Receiver"
$ns at 0.0 "$n7 label TCPSender"
$ns at 0.0 "$n3 label Receiver"

$ns run
