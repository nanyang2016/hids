#!/usr/bin/perl -w
use strict;
use IO::Socket;
my $sock;
my ($remote, $port, $iaddr, $paddr, $proto, $line);
my $info=0;
for my $remote ('172.27.32.105','10.137.128.209','10.208.159.149','10.134.13.207',
				'10.128.185.41','10.215.159.152','10.223.159.150','10.151.16.149',
				'10.205.93.146','10.212.31.151','10.173.159.148','10.169.225.12',
				'10.170.31.140','10.182.52.49','10.190.48.53','10.252.230.13',
				'10.53.192.14','10.243.128.159','10.116.43.69',
				'219.133.50.100','183.61.54.139','183.57.51.139', '101.226.68.166','111.161.104.100'){
	my $sock = IO::Socket::INET->new(
        PeerAddr => "$remote",
        PeerPort => "9988",
        Type     => SOCK_STREAM,
        Blocking => 1,
        Timeout  => 2,
        Proto    => "tcp");
        if($sock){
                $info = 1;
                $sock->close();
                last;
        }
}
if($info ==1){
	print "CONNECT CONN SERVER SUCC\n";
}else{
	print "CONNECT CONN SERVER FAILED\n";
}
