#!/usr/bin/perl
use CGI qw(:standard);
print header(-charset => 'UTF-8');
use Image::Size;
my %form;

foreach my $p (param()) {
    $form{$p} = param($p);
}



open(F,"geo/$form{save_path}/$form{file_name}")|| die "2 can't open geo/$current_path/$file_name $!";
#while($line=<F>){
#	push(@a,$line) unless $line=~/num="$form{num}"/;
#}
undef $/;
$data=<F>;
$data=~s/\n/\^\^\^\^/g;
$data=~s/\^\^\^\^\t*\s*<line num="$form{num}".+?<\/line>//;
close F;
$data=~s/\^\^\^\^/\n/g;
open(F,">geo/$form{save_path}/$form{file_name}")|| die "2 can't open geo/$current_path/$file_name $!";
#open(F,">test2.txt")|| die "2 can't open geo/$current_path/$file_name $!";
print F $data;
close F;
