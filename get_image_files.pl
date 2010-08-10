#!/usr/bin/perl
use CGI qw(:standard);
use Image::Size;
print header(-charset => 'UTF-8');


foreach my $p (param()) {
    $form{$p} = param($p);
}


$select_image= qq(<select id="select_image" name="select_image" style = "height:100px;width:10em;" size="7" onClick="check_divs_r_on(); document.getElementById('image_name').innerHTML=this.value;" onChange="change_image=1;ModalPopupsConfirm(this.value);">);

#User has requested to see all images in an image directory.
#get list of images in images path

opendir(DIR,"$form{images_path}")|| die "Can't open $images_path: $!";
for(readdir DIR){
	next if /^\./;
	next unless /\.(gif|jpg|png|tif+)/i ||(-d "$_");
	($globe_x, $globe_y) = imgsize("$form{images_path}/$_");
	$select_image.=  qq(<option img_width="$globe_x" img_height="$globe_y">$_</option>);
}

$select_image.= qq(</select>);

print $select_image;


