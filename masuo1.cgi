#!/usr/bin/perl
#######################################################
# masuo.pl�e�X�g�p�X�N���v�g
#	2001.06.01	Ver.1.00
#######################################################
require './jcode.pl';
require './masuo.pl';
$srpt='masuo1.cgi';
#=========================================�ݒ肱������
$ainame='���';
$log=10;			#���O�s���i���Ȗڂɂ��Ă��������B�j
$logFileDir = '/home/haru/public_html/masuo/conv';
#=========================================�ݒ肱���܂�

masuo::Init('sjis','./masuo.dat','','',$ainame,'',1,0);

$FORM{'name'} = '�w�Дԍ��������';
&form_deco;

	$c= masuo::Copy(0,'sjis');
	if ($FORM{'msg1'}){
		$FORM{'msg0'}= masuo::getRes($FORM{'msg1'},$FORM{'name'});
		if (!$FORM{'msg0'}){
			$FORM{'msg0'}= masuo::getRes('{�Ԏ���}',$FORM{'name'});
		}
	}

print <<'_HEAD_';
Content-Type: text/html; charset=Shift_JIS
Content-Language: ja
Pragma: no-cache
Cache-Control: no-cache

<html lang="jp">
<head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=Shift_JIS">
<title>�l�H���\�}�X�I�e�X�g</title>
</head>
<script langage="javascript" type="text/javascript">
<!--
function setfocus(){
	document.test.msg1.focus();
}
function check(){
	if (document.test.msg1.value == ""){
		setfocus();
		return false;
	}
	return true;
}
// -->
</script>
<body onLoad="setfocus();">
�l�H���\�ƑΘb�ł��B
    <br>
    �e�X�g����l�ցF�w�Дԍ�������Ă��������D�i������̂��߁C���O���c���Ă��܂��D<br>
    <br>
    �ݒ�F���Ȃ��̓����w���̔ޏ��i��񂩁j�Ƙb���Ă��܂��B���C�t���Ă����Ă��������B<br>
    <br>
    ��񂩂̓����F���[�����Ƃ������D���ł��B
  �@<br>
_HEAD_

print <<"_FORM_";
<form action="$srpt" METHOD="POST" name="test" onSubmit="return check()">
<input type="text" name="name" size="10" value="$FORM{'name'}" />
<input type="text" name="msg1" size="50" value="" />
<input type="submit" value="���M" />
_FORM_

for($i=1;$i<$log;$i++){
	$next1=$i+1;
	$h1='msg'.int($i-1);
	print "<input type=hidden name=msg$next1 value=\"$FORM{$h1}\" />\n";
}

print <<'_LOG_';
</form>
_LOG_

for($i=0;$i<$log;$i+=2){
	$h1="msg$i";
	$h2='msg'.int($i+1);
	(!$FORM{$h1}) && (last);
	print "<hr>$ainame �� $FORM{$h1}\n";
	print "<hr>$FORM{'name'} �� $FORM{$h2}\n";
}

#append log

if( $FORM{'name'} =~ /^[0-9]+$/ ){
    if(!-d $logFileDir ){ mkdir $logFileDir, 0777; }
    my $logfile = $logFileDir."/".$FORM{'name'};
    my ($sec,$min,$hour,$mday,$mon,$year,undef,undef,undef) =localtime(time);
    my $str = sprintf( "%02d��%02d��%02d��%02d��%02d�b", $mon + 1, $mday, $hour, $min, $sec);
    open (APPEND_OUTPUT, ">>$logfile" );
    print APPEND_OUTPUT "$str$FORM{'name'}��$FORM{msg1}\n                    $ainame��$FORM{msg0}\n";
    close APPEND_OUTPUT;
    chmod 0777, $logfile;
    print "<hr>log($logfile)<hr>";
}

#print "<hr>";
#print "NEW => $FORM{msg0} $FORM{msg1}";
#print "<hr>";

print <<"_FOOT_";
<hr>
$c
</body>
</html>
_FOOT_
exit;

## �t�H�[������̃f�[�^����
sub form_deco {
	if ($ENV{'REQUEST_METHOD'} eq "POST") { read(STDIN, $buffer, $ENV{'CONTENT_LENGTH'}); }
	else { $buffer = $ENV{'QUERY_STRING'}; }

	@pairs = split(/&/,$buffer);
	foreach $pair (@pairs) {
		($name, $value) = split(/=/, $pair);
		$value =~ tr/+/ /;
		$value =~ s/\cM//g;
		$value =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
		$value =~ s/\r|\n//g;
#		&jcode'convert(*value,'sjis');
		$FORM{$name} = $value;
	}
}
