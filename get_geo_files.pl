#!/usr/bin/perl
use CGI qw(:standard);
print header(-charset => 'UTF-8');


foreach my $p (param()) {
    $form{$p} = param($p);
}


$select_geo=qq(<select id="select_geo" name="select_geo" onMouseover="parent.frames['line'].check_word_boxes();" onClick="geo_onClick();" onChange="change_image=1;" "height:100px;width:10em;" size="7">);


#User has requested to see all geo files in a geo directory
#get list of geo files in geo path directory
if($form{'geo_path'}){
  opendir(DIR,"geo/$form{'geo_path'}") || print qq(<script>alert("geo/$form{'geo_path'} : $!");</script>;);
  for(sort readdir DIR){
	next if /^\./;
	next unless /\.(geo)/i ||(-d "$_");
$select_geo.= qq(<option>$_</option>);
  }
}

$select_geo.= qq(</select>);

print "$select_geo";


