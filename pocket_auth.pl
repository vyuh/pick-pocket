$ser = 'Pocket';
# $csec $ckey
open( APP, "<.pocket_app");
$ckey=<APP>; chomp $ckey;
$ruri=<APP>; chomp $ruri;

# $meth $prot $host $res @attr @auth @head
$meth='POST'; $prot='https://'; $host='getpocket.com'; $res='/v3/oauth/request';
@head=( 'User-Agent', 'pii_ke', 'Host', $host, 'Content-Type', 'application/x-wwww-form-urlencoded; charset=UTF8', 'Accept', '*/*'); 
@attr=('consumer_key', $ckey, 'redirect_uri', $ruri );

use HTTP::Tiny;
$http = HTTP::Tiny->new("agent", "pii_ke");
$response = $http->post_form( $prot . $host . $res, \@attr, { 'headers' , {@head} });

use Data::Dumper;
die Dumper($response) unless $response->{'success'};
$page=$response->{'content'}; #SERVER #SEND
($code) = $page=~/=([^&]*)/;

$res = '/auth/authorize';
print "please visit the following link, log into $ser & allow us access.\n";
print "Then return here and press enter\n\n";
print $prot . $host . $res . '?request_token='. $code . '&redirect_uri=' . $ruri . '&mobile=1' . "\n";
<>; 
print 'Logging in...' . "\n";

$res='/v3/oauth/authorize';
@attr=('consumer_key', $ckey, 'code', $code );

use HTTP::Tiny;
$http = HTTP::Tiny->new("agent", "pii_ke");
$response = $http->post_form( $prot . $host . $res, \@attr, { 'headers' , {@head} });
die Dumper($response) unless $response->{'success'};
$page=$response->{'content'};
 

@pk= split '&', $page;
($atok, $usr) = map { s/^.*=//; $_ } @pk;

# $atok $usr
open( USR, ">.pocket_usr_$usr");
print USR join "\n", $atok, $usr; #SERVERDB #SAVE

print "welcome " . $usr . "!\n" ; #SERVER #SEND
print "\n$ser Authentication done \n";
