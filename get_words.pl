#!/usr/bin/perl
use CGI qw(:standard);
print header(-charset => 'UTF-8');
use Image::Size;
my %form;

foreach my $p (param()) {
    $form{$p} = param($p);
}

$words= qq(var words={);

open(F,"geo/$form{save_path}/$form{file_name}")|| die "2 can't open geo/$current_path/$file_name $!";
while($line=<F>){
	$num=undef; $x1=undef; $x2=undef; $y1=undef; $y2=undef;
	$num = $2 if $line=~/(num=")(\d+\.\d+)(")/;
	$x1       =$2  if $line=~/(x1=")(.+?)(")/;
	$y1       =$2  if $line=~/(y1=")(.+?)(")/;
	$x2       =$2  if $line=~/(x2=")(.+?)(")/;
	$y2       =$2  if $line=~/(y2=")(.+?)(")/;
	$words.= qq("$num" : {'x1' : $x1, "y1" : $y1, "x2" : $x2, "y2" : $y2 },) if $num;

}
close F;	
$words=~s/,$/}/;
print $words;
