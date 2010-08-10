#!/usr/bin/perl
use CGI qw(:standard);
print header(-charset => 'UTF-8');
use Image::Size;
my %form;

foreach my $p (param()) {
    $form{$p} = param($p);
}
open(F,"geo/$form{save_path}/$form{file_name}")|| die "2 can't open geo/$current_path/$file_name $!";
undef $/;
$data = <F>;
close F;

$data=~s/\n/***/g;
$line=$& if $data=~/(<line num="$form{num}")(.+?)(<\/line>)/;


@lines=split(/\*\*\*/,$line);

foreach $line(@lines){
	$line=~s/^\t*//;
	$line=~s/^\s*//;
	$num=undef;
	$num = $2 if $line=~/(num=")(.+?)(")/;
	$hash{$num}= $line if $num && $num =~/\./;
}
$x2 = $form{x1} + $form{w};
$y2 = $form{y1} + $form{h};

$hash{"$form{num}.$form{word_num}"}=  qq(<word num="$form{num}.$form{word_num}" x1="$form{x1}"  y1="$form{y1}" x2="$x2"  y2="$y2" zoom="$form{zoom} rotation="$form{rotation}" />);


$lines[0]=~s/<\/line>//;
$line= qq(\t\t$lines[0]\n);
for(sort keys%hash){
	$line.=qq(\t\t\t$hash{$_}\n);
}
$line.=qq(\t\t<\/line>);

$data=~s/(\t*\s*<line num="$form{num}".+?<\/line>)/$line/;
$data=~s/\*\*\*/\n/g;
print $hash{"$form{num}.$form{word_num}"};

open(F,">geo/$form{save_path}/$form{file_name}")|| die "3 Can't open geo/$current_path/$file_name: $!";
print F $data;
close F;

__END__	

