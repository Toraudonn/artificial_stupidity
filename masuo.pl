#############################################################################
#�˥塼��������ǽ����
#	�˥塼����ǽ����Ѥ�����ϡ�
#	���Υե������Ʊ���ǥ��쥯�ȥ��get_news.pl�����֤��Ƥ���������
#	�����åȤ���Ѥ��Ƥ��뤿�ᡢ���ε�ǽ����Ѥ�����硢
#	�����˻��֤��ݤ����������ޤ���
#	�����åȤ����ѤǤ��ʤ��Ķ��Ǥϲ��ιԤ򥳥��Ȥˤ��Ƥ���������
#----------------------------------------------------------------------------
$news_mod='../masuo/get_news.pl';
#----------------------------------------------------------------------------
#�ʲ���������ɬ�פϤ���ޤ���
#############################################################################
# �͹�̵ǽ�ޥ���
$masuover =			'Ver.1.61beta';
#----------------------------------------------------------------------------
# 2002.07.20	1.61b		�����Ȱ�ž��ȼ��URL�����ѹ�
# 2001.10.24	1.60b		������ñ�측����ǽ�ɲ�
#							����åȻ��ѻ��������ե졼�ब���顼�Ȥʤ��Զ��
#							������
# 2001.09.20	1.55b		��������Ƭ��"T"�ξ��ϥ���å��帡���򤷤ʤ��褦
#							������
# 2001.08.06	1.54b		�٤��ʽ�����
# 2001.08.04	1.53b		�����δĶ���˽�������Զ�������
# 2001.06.15	1.50b		��ư�ؽ������ִ���ǽ���ɲá�
# 2001.06.10	1.42b		{masuoversion}�ǥС��������ֵѡ�
# 2001.06.09	1.41b		1.40b�Ǳ����������ȤΤߤξ��˥����Ȥ��֤���
#							���ޤäƤ����Τ�����
# 2001.06.09	1.40b		get_news.pl���б���
# 2001.06.06	1.30		words�ΰ����������С���������ɽ����
#							˺�ѽ�����������ư�ؽ���ǽ���ɲá�
#							��������ñ��μ���{inword*}���ɲá�
# 2001.06.04	1.29		���鵡ǽ��ư��Ƥ��ʤ��ä��Τ�����
# 2001.06.01	1.28		����å����ͭ�����֤������ѹ���
# 2001.06.01	1.27		Init�ǥ��顼��å��������ֵѡ�
# 2001.05.31	1.26		̵�¥롼���ɻ������ɲá�
# 2001.05.31	1.25		{1to100}���ο����Ѵ���̵���ˤʤäƤ����Τ�����
#							���ɽ�������󥯤���褦������
#							����å������������
#							�������ǡ����κ��ɹ��ؿ����ɲá�
#							����¾�Х�������
#							�ǡ����ե�������γ����ե���������
#							<datadir>������ǽ�ˡ�
# 2001.05.30	1.22		ñ�����ե�����Υ��󥯥롼�ɤǡ�
#							Ʊ�쥭���ؤ�ʣ���ե����륤�󥯥롼�ɤ��ǽ�ˡ�
# 2001.05.30	1.21beta	���å����ȥ���å����ξ���򸡺���
# 2001.05.29	1.20beta	����ȯ���Υ��å����б���
#							���鵡ǽ���ɲá�
#							����ɽ�����б���
# 2001.05.24	1.00beta	�͹�̵ǽ���ĥ�Ver.2.30���饤��
#----------------------------------------------------------------------------
#  by ����
#  kuwaperl@sea.plala.or.jp
#  http://www9.plala.or.jp/ulbperl/
#############################################################################
#������ˡ
#	�ƤӽФ����ǡ�
#	require 'jcode.pl';
#	require '../masuo/masuo/masuo.pl';
#	�Τ褦��jcode.pl�����ѤǤ�����֤ˤ��Ƥ���������
#	�ʲ����ƴؿ���ƤӽФ��ޤ���
#	�����
#	$copy = &masuocopy([copymode,code]);
#	�������
#	masuo::init(code,datafile[,fmtfile,terms,ainame,cache,cookie,autofile,auto,dbg]);
#	����������
#	$res = masuo::getRes(request[,name,words,ainame,autooff]);
#	��ñ�춵��
#	$res = masuo::studyWord(key,word[,term]);
#	���ǽ�����˺��
#	$res = masuo::deleteLast();
#	���������ǡ������ɹ�
#	$res = masuo::Reload(reloadKey);
#
#	code=sjis|euc|jis
#		Init��ޤ�ƴؿ��ؤ����ƤΥѥ�᡼����
#		�����ǻ��ꤷ�������ɤǤ���ɬ�פ�����ޤ���
#		�ƴؿ������ֵѤ����ʸ����⤳���ǻ��ꤷ�������ɤˤʤ�ޤ���
#	datafile=�ǡ����ե�����̾��
#	fmtfile=�ե����ޥåȥե�����̾��
#	terms=���ʸ����("|"�Ƕ��ڤä�ʣ�������)
#	ainame=�͹�̵ǽ̾
#	autooff=��ư�ؽ���ǽOFF
#		1=��ư�ؽ���ǽOFF
#	cache=����å���ե�����̾��
#	cookie=0|1
#		1=���å�������
#	autofile=��ư�ؽ���ե�����ѥ�(res.dat����ñ�����ե�����)
#	auto=��ư�ؽ���Ψ(0���100)
#	dbg=0|1
#		1=�ǥХå��⡼��
#	request=��ʸ����
#	name=̾��ʸ����
#	words=ưŪ�ɲåǡ����ʥ���޶��ڤ��
#	key=�ɲ��оݥ���
#	word=�ɲ�ñ��
#	term=���ʸ����(ʣ�������Բ�)
#	reloadKey=���ɹ��оݥ���
#	copymode=(0|1)
#		1=��󥯤ʤ�
#
#	���ƥե�����̾�ϡ�masuo.pl�θƤӽФ���������ץȤ��鸫��
#	���Хѥ��⤷�������Хѥ��ǻ��ꤷ�Ƥ���������
#
#��)
#	require 'jcode.pl';
#	require 'masuo.pl';
#	masuo::init('sjis','../masuo/masuo.dat','','','�狼��','cache.dat',1);
#	$res = masuo::getRes($comment,$name);
#	$res = masuo::studyWord($key,$word);
#	$res = masuo::deleteLast();
#	$cpy = masuo::Copy();
#
#############################################################################
$masuocopy = '�͹�̵ǽ�ޥ���';
#	�����
#	$copy = &masuocopy;
sub masuocopy{
	my $copy=($_[0])?$masuocopy:qq(<a href="http://www9.plala.or.jp/ulbperl/" target="_blank" title="$masuover">$masuocopy</a>);
	$copy="- $copy -";
	my $outCode=($_[1])?$_[1]:'sjis';
	jcode::convert(\$copy,$outCode,'euc');
	return "$copy";
}
sub news_mod{	$news_mod;}
sub masuo_verword{	$masuover;}
##############################################
package masuo;
$news_mod=main::news_mod;
if ($news_mod && -e $news_mod){
	require $news_mod;
}
$dbg=0;
$outCode='';
$datafile='';
$FILE{'study'}='../masuo/study.dat';
$fmtfile='';
$cachefile='';
$use_cache=0;
$CookieName='MASUO';
$keyinp=100;				#������ñ���Ÿ�����Ƹ��������Ψ��0-100��
						#������ñ�측������٤��⤤�ΤǾ����ܤˡ�
sub Copy{
	return main::masuocopy($_[0],$_[1]);
}
#############################################################################
#Init()
#
# 1:�������ܸ쥳����
# 2:�ǡ����ե�����̾
#   �ǡ����ե�����Υѥ�����ꤷ�Ƥ���������
#   ���ꤷ�ʤ����ϡ�Ʊ���ǥ��쥯�ȥ��masuo.dat����Ѥ��ޤ���
# 3:�ե����ޥåȥե�����̾
#   ������ˡ�ϥǡ����ե������Ʊ�ͤǤ������줬���ꤵ��Ƥ���Ȥ��ϡ�
#   1:����ʸ�Ϥ�̵�뤷�ơ��ե����ޥåȥե����뤫�鸵��ʸ�Ϥ��ɤ߹����
#   �����򤷤ޤ���
# 4:���
#	���˴ޤ�ʸ�������ꤷ�ޤ���
# 5:AI̾
#	�͹�̵ǽ�Υ���饯����̾����ꤷ�ޤ���
# 6:����å���
#	����å���ե�����̾����ꤷ�ޤ���
# 7:���å�������
#	1=���å�������
# 8:��ư�ؽ��ե�����
#	��ư�ؽ���Υե�����̾����ꤷ�ޤ���
#	�ǡ����ե�������˼�ư�ؽ��ե�����λ��꤬�������
#	�������ͥ�褷�ޤ���
# 9:��ư�ؽ���Ψ(%)
#	getRes���ƤӽФ��줿�ݤˡ����γ�Ψ�Ǽ�ư�ؽ��ե�����˸�ȯ�����ɲä��ޤ���
# �ǽ�:�⡼��
#	1=�ǥХå�
#############################################################################
sub Init{
&dbgout("#init");
	$jk='';
	@KEY=();
	undef %WORD;
	undef %NEWS;
	undef %INC;
	$cache='';
	$cache2='';
	($_[$#_]) && ($f_dbg=$_[$#_]);
	($_[0]) && ($outCode=$_[0]);
	($_[1]) && ($datafile=$_[1]);
	($_[2]) && ($fmtfile=$_[2]);
	($_[3]) && ($jk=$_[3]);
	($_[5]) && ($cachefile=$_[5]);
	$use_cook=$_[6];
	$FILE{'auto'}=$_[7];
	$autop=$_[8];
	if ($datafile){
		($datafile =~ /(.+\/).+$/) &&
			($datadir = ($1)?$1:'./');
&dbgout("datadir=$datadir");
		my $ret;
		$ret = &loadData($datafile);
		return $ret	if($ret);
	}
	($_[4]) && ($WORD{'wname'}=$_[4]);
&dbgout("cachefile=$cachefile");
&dbgout("jk=$jk");
	$WORD{'masuoversion'}=main::masuo_verword;
	#��������ʥ�����Ĺ�����
	@KEY = sort {length($b)-length($a)} keys(%WORD);
}

#########################################
#getRes()
#
# 1:����ʸ�ϡʤ��ä�����
#	�ָ���ʸ�ϡפ��椫��ǡ����Υ����򸡺����ޤ���
# 2:̾��
#   �ǡ������{name}�Ȥ�����ˡ���̾���פ��֤������ޤ���
#	��ˡ�ȯ����̾�Ȥ��ƻ��Ѥ��ޤ���
# 3:�ɲ�ñ�쥫��޶��ڤ�ꥹ��
#   ����{words}�����ꤷ�ޤ���
#	��ˡ����ü�̾�Ȥ��ƻ��Ѥ��ޤ���
# 4:AI̾
#   �ǡ������{wname}�Ȥ�����ˡ���AI̾�פ��֤������ޤ���
#	��˿͹�̵ǽ�Υ���饯����̾�Ȥ��ƻ��Ѥ��ޤ���
# ���
# masuo::getRes("����ˤ���","����");
#########################################
sub getRes{
	srand;
&dbgout("#getRes");
	my($req,$wn,$ws,$autooff);
	($req,$WORD{'name'},$ws,$wn,$autooff) = @_;
	($wn) && ($WORD{'wname'}=$wn);
	if ($ws){
		jcode::convert(\$ws,'euc',$outCode);
		$WORD{'words'}.=','.$ws;
	}
	$WORD{'words'}.=','.$WORD{'name'};
&dbgout("in=@_");

	#̵�¥롼���޻�
	$req =~ s/\{?msg\}?//g;

	#����å�����ɤ߹���
	if ($cachefile && -e $cachefile && open(CA,$cachefile)){
		$WORD{'cache2'} = $cache2 = <CA>;
		close(CA);
	}
	$use_cook and &get_cook;
&dbgout("cache(cookie)=$cache");
&dbgout("cache(file)=$cache2");

	#����å���κ�����
	my $i=1;
	my $hsc=($cache)?'cache':'cache2';
	while(${$hsc}=~s/#(\d*)\(([^#]+)\)/$2/){
		my $hs=($1)?"reply$1":"reply$i";
		$WORD{$hs}=$2;
		$i++;
	}

	if($fmtfile && -e $fmtfile){
		#�ե����ޥåȥե����뤬���ꤵ��Ƥ������
		#������ʣ��Ԥ򤭤ä����Ȥ��롣
		open(FMT,"< $fmtfile") || return("can't open DAT $fmtfile:$!\n");
		rand($.) < 1 and $req = $_ while <FMT>;
		close(FMT);
		$req=~s/\x0d?\x0a?$//;
	}
	jcode::convert(\$req,'euc',$outCode);
&dbgout("code=$outCode");
	$WORD{'name'} and jcode::convert(\$WORD{'name'},'euc',$outCode);
	$WORD{'wname'} and jcode::convert(\$WORD{'wname'},'euc',$outCode);
#	$WORD{'words'} and jcode::convert(\$WORD{'words'},'euc',$outCode);
	$WORD{'msg'}=$req;

	(!$autooff && $autop && $FILE{'auto'}) && (&autoStudy($FILE{'auto'},$autop,$req));

&dbgout("cache=$cache");
	my $inline = $req;
	$_ = ($inline =~ /^\{.+\}$/)?$inline:'{'.&getkey($inline).'}';
#&dbgout("\$\_=$_");
my $test=$_;
	while(s/\{([^\}]*)\}/&rndword($1)/eg){;};

	if ($_ && $cachefile && -e $cachefile && open(CA,"> $cachefile")){
		print CA $_;
		close(CA);
	}
	$_ and $use_cook and &set_cook($_);
#	s/([^\:])\/\/.*/$1/;
	s/(^|[^\:])\/\/.*/$1/;
	s/#\d\(([^#]+)\)/$1/eg;
#	return result($test."=".$_);
	return result($_);
}
sub result{
	my $res = $_[0];
	jcode::convert(\$res, $outCode,'euc');
	return $res;
}

####ȿ�����������
sub getkey {
&dbgout("#getkey");
	my($req) = $_[0];
	my($olen,$len,$key,$one)=(0,0,'','');
	my $key2;
	my $tmp;
&dbgout("cache=$cache");
&dbgout("req=$req");
	my $keyin = rand(100);
	foreach $one (@KEY){
		my ($o,$c)=split(/\~/,$one,2);
#($c) && (&dbgout("key2/cache/key=$c/$cache/$one"));
#		($c) && ($req =~ /^T/) && ($cache !~ /$c/) && ($cache2 !~ /$c/) && (next);
#		($c) && ($cache !~ /$c/) && ($cache2 !~ /$c/) && ($req !~ /^T/) && (next);
		($c) && ($cache !~ /$c/) && ($cache2 !~ /$c/) && (next);
		($req =~ /^T/) && ($c) && (next);

		#������ñ�����
		if ($keyin<$keyinp && $o =~ /\%([^\%]+)\%/){
			$key2=$1;
			if (defined($WORD{$key2})){
				$WORD{'inword0'}='';
				foreach $tmp (split(/,/,$WORD{$key2})){
					if ($tmp =~ /.+/ && $req =~ /\Q$tmp\E/){
						$WORD{'inword0'}=$tmp;
						$o=~s/\%$key2\%/$tmp/;
						$WORD{$o}=$WORD{$one};
						last;
					}
				}
			}
		}

		if ($req =~ /$o/){
#			$len = length($one);
#			if ($len > $olen){
				$key = $one;
#				$olen = $len;
				for(my $i=1;(${$i}) && ($i<10);$i++){$WORD{"inword$i"}=${$i};}
#			}
			last;
		}
	}
&dbgout("\t#getkey");
	return $key;
}

##### �ǥ�����
sub decode{
	my($org, $tag) = @_;
	$org =~ tr/+/ /;
	$org =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
	$org =~ s/\t//g;
	$org =~ s/\cM//g;
	$org;
}

#######################
#�ǡ����ɤ߹���
#	1:�ǡ����ե�����̾
#######################
sub loadData{
&dbgout("#loadData");
	my $dfile=$_[0];
	my @LIST=();
	my $line;
	my $tjk;

&dbgout("dfile=$dfile");

	open(WD,$dfile) || return("");
	@LIST = <WD>;
	close(WD);

	foreach $line (@LIST){
		($line =~ /^#/) && (next);
		#�����������ʤ��ǡ������ɤ����Ф�
		if ($line =~ /^\@\/([^\/]+)\/\{/){
			my $term=$1;
			my $hit=0;
			(!$jk) && (next);
			foreach $tjk (split(/\|/,$jk)){
				(",$term," =~ /,$tjk,/) && (($hit=1) || (last));
			}
			(!$hit) && (next);
		}
		#���Խ���
		$line=~s/,?\x0d?\x0a?$//;
		#@{file=data.dat}
		if($line =~ /^\@[^\{]*\{(.*)file=(.+)\}/){			# ���󥯥롼��
			my $cap = $1;
			my $f = $2;
			$f =~ s/<datadir>\/*/$datadir/i;
&dbgout("file=$f");
			(-e $f) && &loadData($f);
			($cap) && ($FILE{$cap}=$f);
		}
		elsif($line =~ /^\*{([^=]+)=(.+)\}/){				# �ե�����̾
			$FILE{$1}=$2;
			$FILE{$1}=~s/<datadir>\/*/$datadir/i;
		}
		#@{key},a,b,c...
		elsif($line =~ /^(!?)\@[^\{]*\{([^\}]*)\},(.*)/){	# �ǡ���(@)�ɤ߼�ꡢ��¸
			($1 && !$get_news_required) && next;
			my($w) = $3;
			(my $key = $2) =~ s/^(\d+)://;		# �����Ǥ�:���̻�(����)�ϳ���
			($WORD{$key} .= $w.',') &&  next;
		}
		#@{key}=data.dat		�������ǡ���(@)�ɤ߼�ꡢ��¸
		elsif($line =~ /^\@[^\{]*\{([^\}]*)\}=([^\(]+)(\((\d*)\))?/){
			my $key=$1;
			my $l4=$4;
			if (!$l4 || !$WORD{$key} || int(rand(100)) < $l4){
				my $f = $2;
				$f =~ s/<datadir>\/*/$datadir/i;
				(!$l4) && ($INC{$key}=$f);
				if (-e $f && open(FMT,"< $f")){
&dbgout("include=$f");
#					rand($.) < 1 and $WORD{$key} = $_ while <FMT>;
#					$WORD{$key}=@WLIST[int(rand(@WLIST))];
					my @WLIST=<FMT>;
					my $w;
					close(FMT);
					foreach $w (@WLIST){
						$w=~s/\x0d?\x0a?$//;
						$WORD{$key}.=$w.',';
					}
						$w=~s/,$//;
				}
			}
		}
		elsif($line =~ /^!{([^}]+)}=(.+)/){
#			($news_mod) && ($get_news_required) && ($WORD{$1}=&getNews_socket($2));
			if ($news_mod && $get_news_required){
				$WORD{$1}=$2;
				$NEWS{$1}=1;
			}
		}
	}
&dbgout("\t#loadData");
	return;
}
#####################################################################
#�������ǡ����κ��ɹ�
#	1:����
#	���˳������ǡ����ʳ��Υ��������ꤵ�줿����̵��
#	����Ʊ�쥭�����Ф���ʣ���Υե����뤬�ɤ߹��ޤ�Ƥ����硢
#		�Ǹ���ɤߤ��ޤ줿��Ψ�����ꤵ��Ƥ��ʤ��ե����뤬�оݤˤʤ�
#####################################################################
sub Reload{
	my $key=$_[0];
	jcode::convert(\$key,'euc',$outCode);
	my $file = $INC{$key};
	if ($file && -e $file && open(FMT,"< $file")){
		rand($.) < 1 and $WORD{$key} = $_ while <FMT>;
		close(FMT);
		$WORD{$key}=~s/,?\x0d?\x0a?$//;
	}
}
#######################
#ñ�춵��
#	1:����
#	2:ñ��
#	[3:���]
#	�ʲ��Τ褦�ʥǡ������ɲä���롣
#	@/���/{����},ñ��
#	������ꤷ�ʤ����ϰʲ���
#	@{����},ñ��
#######################
sub studyWord{
	my($key,$word,$term) = @_;

	if ($key eq ''){
		return &result('KEY�����Ϥ���Ƥ��ޤ���KEY�����Ϥ��Ƥ�������');
	}
	if ($word eq ''){
		return &result('ñ�줬���Ϥ���Ƥ��ޤ���ñ������Ϥ��Ƥ�������');
	}

	my($outstr);

	($term) && ($term = '/'.$term.'/');
	$outstr = "\@$term\{$key\},$word";
	jcode::convert(\$outstr, 'euc');
	if (open(DATA,'>>'.$FILE{'study'})){
		print DATA "$outstr\n";
		close(DATA);
		return &result("��$key�פˡ�$word�פ��ɲä��ޤ���");
	} else {
		return &result('���餬�Ǥ��ޤ��󡣴����Ԥ�Ϣ���Ƥ���������');
	}
}

sub autoStudy{
	my($file,$p,$wd)=@_;
	(!-e $file) && (return);
	(int(rand(100)) > $p) && (return);
	($wd=~/^\{[^\}]+\}$/) && (return);
	my $wdtail;
	if ($wd =~ /.+(>|��).+/){
		my @wrdlist = split(/,/,$WORD{'words'});    # �ǡ��������ʬ��(���)
		my($tmp);
		foreach $tmp (@wrdlist){
			if ($wd =~ /(.+)(>|��)$tmp$/){
				$wd=$1;
				$wdtail="��{words}";
				last;
			}
		}
	}
#	$wd =($wd =~ /(.+)(>|��).+/)?"$1��{words}":$wd;
	if ($WORD{'T��;�'}){
		my $from=$WORD{'wname'};
		my @TO = split(/,/,$WORD{'T��;�'});
		my $to= @TO[int(rand(@TO))];
		$wd=~s/$from/$to/g;
		if (-e $FILE{'replace'} && open(REP,$FILE{'replace'})){
			while (<REP>){
				#���Խ���
				s/,?\x0d?\x0a?$//;
				if (/^\@\{([^\}]+)\},(.+)/){
					my ($from,$to)=($1,$2);
					$wd=~s/$from/$to/g;
				}
			}
			close(REP);
		}
	}
	
	if (open(DATA,'>>'.$file)){
		print DATA "$wd$wdtail\n";
		close(DATA);
	}
}

#################################
#�ǽ�����˺��
#	���ֺǶᶵ�餵�줿�ǡ�������
#################################
sub deleteLast{
&dbgout("delete");
	my $ok=0;
	my $v1;
	my $v2;
	if (open(STDY,'+<'.$FILE{'study'})){
		eval{flock(STDY, 2);};
		my(@LIST) = <STDY>;
		if ($#LIST>=0){
			eval{truncate(STDY, 0);};
			seek(STDY, 0, 0);
			for(my $i=0;$i<$#LIST;$i++){
				print STDY $LIST[$i];
			}
			$ok=1;
		}
		close(STDY);
		$ok and $LIST[$#LIST] =~ /^\@[^\{]*\{([^\}]+)\},(.+)/;
		$v1=$1;
		$v2=$2;
	}
	if ($ok){
		return &result("��$v1�פ����$v2�פ�˺��ޤ�����");
	} else {
		return &result('˺����ޤ���');
	}
}

#############################################
#�ʲ���pr_inet.pl������Ѥ��ƽ���
#############################################

sub rndint{                             # ��$i < $j �Υ����å�̵��
	my($i,$j) = @_;
	return int(rand($j-$i+1)) + $i;
}

sub rndword{
&dbgout("#rndword");
  my($key) = $_[0]; my($keyno, $ret);

&dbgout("key=$key");

	($key =~ s/^(\d+)://) && ($keyno = $1) || (undef $keyno);

	$key =~ s/(\d+)(?:to|\.\.)(\d+|num),*(\d*),*([+-]*\d*)/&numform(&rndint($1,$2),$3,$4)/eg and return $key;
	$key =~ s/num,*(\d*),*([+-]*\d*)/&numform($num, $1, $2)/eg and return $key;
	$key =~ s/(.*)-(.*)/&rndcode($1,$2)/eg and return $key;

#������¸�ߤ��ʤ����϶����֤�
	(!defined($WORD{$key})) && (return '');

	($NEWS{$key}) && ($WORD{$key}=&getNews_socket($WORD{$key})) || ($NEWS{$key}=0);
  my @wrdlist = split(/,/,$WORD{$key});    # �ǡ��������ʬ��(���)
#&dbgout("wrdlist=@wrdlist");
  $ret     = @wrdlist[int(rand(@wrdlist))];
#&dbgout("ret=$ret");
  if(defined($keyno)){
    (defined($retword{$key.$keyno})) && ($ret = $retword{$key.$keyno})
                                     || ($retword{$key.$keyno} = $ret);
  }

#̵�¥롼���޻�
$ret = ($ret eq $key)?'':$ret;
&dbgout("\t#rndword");
  return $ret;
}

sub rndcode{
  my ($i, $j) = @_;
  return pack('c',&rndint(ord($i),ord($j)));
}
sub numform{
  my($i, $j1, $r) = @_;
  my $j2;
  ($j1 > 0) || ($j1 = 0);
  $i += $r;
  ($j1 =~ /^0/) && ($i="\$j2 = sprintf(\"%0$j1" . "d\", $i);")
                || ($i="\$j2 = sprintf(\"%$j1"  . "d\", $i);");
  eval $i;
  return ($j2);
}

#################################################################
#####���å��������
sub get_cook{
	my $cookies = $ENV{'HTTP_COOKIE'};
	jcode::convert(\$cookies, 'euc',$outCode);

	my(@pairs) = split(/;/,$cookies);
	foreach $pair (@pairs) {
		my($name, $value) = split(/=/, $pair);
		$name =~ s/ //g;
		$DUMMY{$name} = $value;
	}
	@pairs = split(/,/,$DUMMY{$CookieName});
	foreach $pair (@pairs) {
		my($name, $value) = split(/:/, $pair);
		$COOKIE{$name} = $value;
	}
	$COOKIE{'cache'} ne '' and $cache=$WORD{'cache'}=$COOKIE{'cache'};
	return;
}

#####���å���������
sub set_cook{
	#����ɸ������դȻ��������������å�����ͭ�����¤�
	#�ǽ��񤭹�������꣱�������ꤹ��
	my($c_sec,$c_min,$c_hour,$c_mday,$c_mon,$c_year,$c_wday,$c_yday,$c_isdst) = gmtime(time + 86400);
	#���å��������ա�����򣲷������
	($c_year < 2000) && ($c_year+=($c_year>60)?1900:2000);
	$c_sec  = sprintf("%02d",$c_sec);
	$c_min  = sprintf("%02d",$c_min);
	$c_hour = sprintf("%02d",$c_hour);
	$c_mday = sprintf("%02d",$c_mday);
	$youbi = ('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday') [$c_wday];
	$month = ('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec') [$c_mon];
	$date_gmt = "$youbi, $c_mday\-$month\-$c_year $c_hour:$c_min:$c_sec GMT";

	my $cook=$_[0];
	jcode::tr(\$cook,';,:','������');

	$cook="cache\:$cook";
	jcode::convert(\$cook, $outCode,'euc');
	#���å����˽񤭹���
	print "Set-Cookie: $CookieName=$cook; expires=$date_gmt\n";
	return;
}

#################################################################
sub dbgout{
	(!$f_dbg || !$dbg) && (return);
	my $tmp = $_[0];
	($_[1]) || (jcode::convert(\$tmp,$outCode,'euc'));

	print $tmp."\n";
}
#########################################
sub getNews_socket{
	my ($host,$uri,$b,$e,$da,$db,$max,$cd)=split(/,/,$_[0]);
	return &getNews($host,$uri,80,$b,$e,$da,$db,$max,$cd);
}
#########################################
1;
