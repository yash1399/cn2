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

$ns duplex-link $n0 $n1 20Mb 10ms DropTail
$ns duplex-link $n2 $n1 10Mb 10ms DropTail
$ns duplex-link $n1 $n4 5Mb 10ms DropTail
$ns duplex-link $n4 $n3 10Mb 10ms DropTail
$ns duplex-link $n4 $n5 1.5Mb 10ms DropTail

$ns duplex-link-op $n0 $n1 orient right-down
$ns duplex-link-op $n2 $n1 orient right-up
$ns duplex-link-op $n1 $n4 orient right
$ns duplex-link-op $n4 $n3 orient right-up
$ns duplex-link-op $n4 $n5 orient right-down

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

#Set Queue Size of link (n2-n5) to 10
#$ns queue-limit $n1 $n4 10

set tcp [new Agent/TCP]
$tcp set class_ 2
$ns attach-agent $n0 $tcp

set ftp [new Application/FTP]
$ftp attach-agent $tcp

set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink

$ns connect $udp $null
$ns connect $tcp $sink

$ns at 0.0 "$ftp start"
$ns at 0.8 "$cbr start"
$ns at 10.0 "finish"

$ns run