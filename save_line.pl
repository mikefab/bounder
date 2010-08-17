#!/usr/bin/perl
use CGI qw(:standard);
print header(-charset => 'UTF-8');
use Image::Size;
my %form;

foreach my $p (param()) {
    $form{$p} = param($p);
}

sub sort_complex{ #sorts a1a -> z2z
	@array = sort{ #$a , $b are fixed
  	($An1, $An, $Anz) = $a =~/([A-Z]*)(\d+)([a-z]*)/;
 	($Bn1, $Bn, $Bnz) = $b =~/([A-Z]*)(\d+)([a-z]*)/;
 	$An1 cmp $Bn1 || $An <=> $Bn || $Anz cmp $Bnz}@{$_[0]};
	return(@array);
}


open(F,"geo/$form{save_path}/$form{file_name}")|| die "2 can't open geo/$current_path/$file_name $!";
undef $/;
$data = <F>;
close F;


$data=~s/<height=""/<height="$form{image_height}"/ if $data=~/<height="">/;
$data=~s/<width=""/<width="$form{image_width}"/    if $data=~/<width="">/;



@parts = split(/<data>/,$data);
$prefix=qq($parts[0]<data>\n);
$data = $parts[1];
@data = split(/<\/data>/,$data);
@data = split(/\n/,$data[0]);
@lines=split(/<\/line>/,$data);

foreach $line(@lines){
	$num=undef;
	$num = $2 if $line=~/(num=")(.+?)(")/;
	$line=~s/\n//;
	push(@line_numbers,$num) if $num;
	$hash{$num}=qq($line<\/line>) if $num;
}

$hash{$form{num}}=~s/\t*\s*<.+?>//;
$hash{$form{num}}=~s/\t*\s*$//;

push(@line_numbers,$form{num});
#sort line numbers by Face, line number, and column.
@line_numbers=sort_complex(\@line_numbers);
$x2 = $form{x1} + $form{w};
$y2 = $form{y1} + $form{h};

$num = $form{num};
$hash{$form{num}}= qq(  <line num="$form{num}" x1="$form{x1}"  y1="$form{y1}" x2="$x2"  y2="$y2" zoom="$form{zoom}" rotation="$form{rotation}">$hash{$form{num}});
$hash{$form{num}}.=qq(<\/line>) if $hash{$form{num}}!~/<\/line>/;





	open(F,">geo/$form{save_path}/$form{file_name}")|| die "3 Can't open geo/$current_path/$file_name: $!";
#	open(F,">test2.txt")|| die "3 Can't open geo/$current_path/$file_name: $!";
	print F qq($prefix);

	for(keys%hash){
		$hash{$_}.="\n";
		$hash{$_}=~s/px//g;
	}

my @line_numbers = grep { ! $seen{$_}++ }@line_numbers;
	for(@line_numbers){
			
		print F qq($hash{$_});
	}
	print F qq(  </data>\n</entry>);
	close F;



