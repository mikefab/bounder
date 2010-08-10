#!/usr/bin/perl
use CGI qw(:standard);
print header(-charset => 'UTF-8');
use Image::Size;
my %form;

@attributes = qw(num file_name current_folder image_width image_height x1 y1 x2 y2 rotation);

foreach my $p (param()) {
    $form{$p} = param($p);
}

$select_lines=qq(<select size="3"  name = "select_lines" id="select_lines"  onchange="load_lines_onChange();" style = "height:100px;display:inline;width:6em;height:14em;" >);

open(F,"geo/$form{save_path}/$form{file_name}");
undef $/;
$data=<F>;
close F;

$image= $2 if $data=~/(<file>)(.+?)(<)/;

foreach $line(@data=split(/\n/,$data)){
	for(@attributes){
		$$_=undef;
	}
	$num      =$2  if $line=~/(num=")([^\.]+?)(")/;
	$x1       =$2  if $line=~/(x1=")(.+?)(")/;
	$y1       =$2  if $line=~/(y1=")(.+?)(")/;
	$x2       =$2  if $line=~/(x2=")(.+?)(")/;
	$y2       =$2  if $line=~/(y2=")(.+?)(")/;
	$rotation =$2  if $line=~/(rotation=")(.+?)(")/;
	$select_lines.= qq(<option x1="$x1" y1="$y1" x2="$x2" y2="$y2" rotation="$rotation">$num</option>) if $num;
}

$select_lines.="</select>";

if(-e "image/$file"){
	($globe_x, $globe_y) = imgsize("image/$image");
	print qq($select_lines***image/$image***$globe_x);
}else{
	print qq($select_lines);
}
