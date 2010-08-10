#!/usr/bin/perl
use CGI qw(:standard);
use Image::Size;
print header(-charset => 'UTF-8');


foreach my $p (param()) {
    $form{$p} = param($p);
}


$image=$form{file_name};
$file=$form{file_name}; 
$file=~s/\..{2,3}$/.geo/;
$id = $1 if $file=~/(.+?)(\..{2,3}$)/;

if(-e "image/$image"){
($image_height, $image_width) = imgsize("image/$image");
}else{
($image_height, $image_width) = ($form{image_width}, $form{image_height});
}
unless(-e "geo/$form{save_path}/$file"){
	open(F,">geo/$form{save_path}/$file")|| print "cannot open geo/$form{save_path}/$file: $!";
	print F qq(<entry>\n  <id>$id</id>\n  <file>$image</file>\n  <path>$form{save_path}</path>\n  <source>CRCL</source>\n  <height="$image_height">\n  <width="$image_width">\n  <data>\n\n  </data>\n</entry>);

	close F;
#	print "geo/$form{save_path}/$file created";
}else{
#	print qq(geo/$form{save_path}/$file already exists);
}



