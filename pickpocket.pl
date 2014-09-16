#!/usr/bin/perl
$ser = 'Pocket';
open( APP, "<.pocket_app");
$ckey=<APP>; chomp $ckey;
$ruri=<APP>; chomp $ruri;

open( USR, "<.pocket_usr");
$atok=<USR>; chomp $atok;
$usr=<USR>; chomp $usr;

$prot='https://'; $host='getpocket.com';
$res=shift;
@attr=('consumer_key', $ckey, 'access_token', $atok );
push @attr, @ARGV;
@head=( 'User-Agent', 'pii_ke', 'Host', $host, 'Content-Type', 'application/x-wwww-form-urlencoded; charset=UTF8', 'Accept', '*/*'); 

use HTTP::Tiny;
$http = HTTP::Tiny->new("agent", "pii_ke");
$response = $http->post_form( $prot . $host . $res, {@attr}, { 'headers' , {@head} });
use Data::Dumper;
die Dumper($response) unless $response->{'success'};
$page=$response->{'content'};
 
print $page;
print "\n";
