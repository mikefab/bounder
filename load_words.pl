#!/usr/bin/perl
use CGI qw(:standard);
print header(-charset => 'UTF-8');
use Image::Size;
my %form;

@attributes = qw(num file_name current_folder image_width image_height x1 y1 x2 y2 rotation);

foreach my $p (param()) {
    $form{$p} = param($p);
}

$select_words=qq(<select size="3"  name = "select_words" id="select_words"  onchange="load_words_onChange();" style = "height:100px;display:inline;width:6em;height:14em;" >);

open(F,"geo/$form{save_path}/$form{file_name}");
undef $/;
$data=<F>;
close F;



#$words = $2 if $data

foreach $line(@data=split(/\n/,$data)){
	for(@attributes){
		$$_=undef;
	}
	$num      =$2  if $line=~/(num="$form{num}\.)(.+?)(")/;
	$x1       =$2  if $line=~/(x1=")(.+?)(")/;
	$y1       =$2  if $line=~/(y1=")(.+?)(")/;
	$x2       =$2  if $line=~/(x2=")(.+?)(")/;
	$y2       =$2  if $line=~/(y2=")(.+?)(")/;

	$select_words.= qq(<option value = "$form{num}.$num" line="$form{num}" x1="$x1" y1="$y1" x2="$x2" y2="$y2">$num</option>) if $num;
}

$select_words.="</select>";

print $select_words;
