#############################################################################
#ニュース取得機能設定
#	ニュース機能を使用する場合は、
#	このファイルと同じディレクトリにget_news.plを設置してください。
#	ソケットを使用しているため、この機能を使用した場合、
#	処理に時間が掛かる事があります。
#	ソケットが使用できない環境では下の行をコメントにしてください。
#----------------------------------------------------------------------------
$news_mod='../masuo/get_news.pl';
#----------------------------------------------------------------------------
#以下、修正の必要はありません。
#############################################################################
# 人工無能マスオ
$masuover =			'Ver.1.61beta';
#----------------------------------------------------------------------------
# 2002.07.20	1.61b		サイト移転に伴うURL等の変更
# 2001.10.24	1.60b		キー内単語検索機能追加
#							チャット使用時、上部フレームがエラーとなる不具合
#							を修正。
# 2001.09.20	1.55b		キーの先頭が"T"の場合はキャッシュ検索をしないよう
#							修正。
# 2001.08.06	1.54b		細かな修正。
# 2001.08.04	1.53b		一部の環境で暴走する不具合を修正。
# 2001.06.15	1.50b		自動学習時の置換機能を追加。
# 2001.06.10	1.42b		{masuoversion}でバージョンを返却。
# 2001.06.09	1.41b		1.40bで応答がコメントのみの場合にコメントを返して
#							しまっていたのを修正。
# 2001.06.09	1.40b		get_news.plに対応。
# 2001.06.06	1.30		wordsの扱いを修正。バージョンを非表示。
#							忘却処理を修正。自動学習機能を追加。
#							キーから単語の取得{inword*}を追加。
# 2001.06.04	1.29		教育機能が動作していなかったのを修正。
# 2001.06.01	1.28		キャッシュの有効期間を１日に変更。
# 2001.06.01	1.27		Initでエラーメッセージを返却。
# 2001.05.31	1.26		無限ループ防止措置追加。
# 2001.05.31	1.25		{1to100}等の数値変換が無効になっていたのを修正。
#							著作権表示からリンクするよう修正。
#							キャッシュ処理を修正。
#							外部列挙データの再読込関数を追加。
#							その他バグ修正。
#							データファイル内の外部ファイル指定で
#							<datadir>を指定可能に。
# 2001.05.30	1.22		単語列挙ファイルのインクルードで、
#							同一キーへの複数ファイルインクルードを可能に。
# 2001.05.30	1.21beta	クッキーとキャッシュの両方を検索。
# 2001.05.29	1.20beta	前回発言のクッキー対応。
#							教育機能を追加。
#							正規表現に対応。
# 2001.05.24	1.00beta	人工無能カツオVer.2.30をリライト
#----------------------------------------------------------------------------
#  by くわ
#  kuwaperl@sea.plala.or.jp
#  http://www9.plala.or.jp/ulbperl/
#############################################################################
#使用方法
#	呼び出し元で、
#	require 'jcode.pl';
#	require '../masuo/masuo/masuo.pl';
#	のようにjcode.plが使用できる状態にしてください。
#	以下、各関数を呼び出します。
#	●著作権
#	$copy = &masuocopy([copymode,code]);
#	●初期化
#	masuo::init(code,datafile[,fmtfile,terms,ainame,cache,cookie,autofile,auto,dbg]);
#	●応答取得
#	$res = masuo::getRes(request[,name,words,ainame,autooff]);
#	●単語教育
#	$res = masuo::studyWord(key,word[,term]);
#	●最終教育忘却
#	$res = masuo::deleteLast();
#	●外部列挙データ再読込
#	$res = masuo::Reload(reloadKey);
#
#	code=sjis|euc|jis
#		Initを含む各関数への全てのパラメータは
#		ここで指定したコードである必要があります。
#		各関数から返却される文字列もここで指定したコードになります。
#	datafile=データファイル名※
#	fmtfile=フォーマットファイル名※
#	terms=条件文字列("|"で区切って複数指定可)
#	ainame=人工無能名
#	autooff=自動学習機能OFF
#		1=自動学習機能OFF
#	cache=キャッシュファイル名※
#	cookie=0|1
#		1=クッキー使用
#	autofile=自動学習先ファイルパス(res.dat等の単語列挙ファイル)
#	auto=自動学習確率(0~100)
#	dbg=0|1
#		1=デバッグモード
#	request=元文字列
#	name=名前文字列
#	words=動的追加データ（カンマ区切り）
#	key=追加対象キー
#	word=追加単語
#	term=条件文字列(複数指定不可)
#	reloadKey=再読込対象キー
#	copymode=(0|1)
#		1=リンクなし
#
#	※各ファイル名は、masuo.plの呼び出し元スクリプトから見た
#	相対パスもしくは絶対パスで指定してください。
#
#例)
#	require 'jcode.pl';
#	require 'masuo.pl';
#	masuo::init('sjis','../masuo/masuo.dat','','','わかめ','cache.dat',1);
#	$res = masuo::getRes($comment,$name);
#	$res = masuo::studyWord($key,$word);
#	$res = masuo::deleteLast();
#	$cpy = masuo::Copy();
#
#############################################################################
$masuocopy = '人工無能マスオ';
#	●著作権
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
$keyinp=100;				#キー内単語を展開して検索する確率（0-100）
						#キー内単語検索は負荷が高いので小さ目に。
sub Copy{
	return main::masuocopy($_[0],$_[1]);
}
#############################################################################
#Init()
#
# 1:出力日本語コード
# 2:データファイル名
#   データファイルのパスを指定してください。
#   指定しない場合は、同じディレクトリのmasuo.datを使用します。
# 3:フォーマットファイル名
#   指定方法はデータファイルと同様です。これが指定されているときは、
#   1:元の文章を無視して、フォーマットファイルから元の文章を読み込んで
#   応答をします。
# 4:条件
#	条件に含む文字列を指定します。
# 5:AI名
#	人工無能のキャラクター名を指定します。
# 6:キャッシュ
#	キャッシュファイル名を指定します。
# 7:クッキー使用
#	1=クッキー使用
# 8:自動学習ファイル
#	自動学習先のファイル名を指定します。
#	データファイル中に自動学習ファイルの指定がある場合は
#	そちらを優先します。
# 9:自動学習確率(%)
#	getResが呼び出された際に、この確率で自動学習ファイルに元発言を追加します。
# 最終:モード
#	1=デバッグ
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
	#キー配列（キーの長い順）
	@KEY = sort {length($b)-length($a)} keys(%WORD);
}

#########################################
#getRes()
#
# 1:元の文章（きっかけ）
#	「元の文章」の中からデータのキーを検索します。
# 2:名前
#   データ中に{name}とある場合に、「名前」に置き換えます。
#	主に、発言者名として使用します。
# 3:追加単語カンマ区切りリスト
#   キー{words}に設定します。
#	主に、参加者名として使用します。
# 4:AI名
#   データ中に{wname}とある場合に、「AI名」に置き換えます。
#	主に人工無能のキャラクター名として使用します。
# 例）
# masuo::getRes("こんにちは","くわ");
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

	#無限ループ抑止
	$req =~ s/\{?msg\}?//g;

	#キャッシュの読み込み
	if ($cachefile && -e $cachefile && open(CA,$cachefile)){
		$WORD{'cache2'} = $cache2 = <CA>;
		close(CA);
	}
	$use_cook and &get_cook;
&dbgout("cache(cookie)=$cache");
&dbgout("cache(file)=$cache2");

	#キャッシュの再利用
	my $i=1;
	my $hsc=($cache)?'cache':'cache2';
	while(${$hsc}=~s/#(\d*)\(([^#]+)\)/$2/){
		my $hs=($1)?"reply$1":"reply$i";
		$WORD{$hs}=$2;
		$i++;
	}

	if($fmtfile && -e $fmtfile){
		#フォーマットファイルが指定されている場合は
		#ランダムな１行をきっかけとする。
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

####反応キーを取得
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

		#キー内単語取得
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

##### デコード
sub decode{
	my($org, $tag) = @_;
	$org =~ tr/+/ /;
	$org =~ s/%([a-fA-F0-9][a-fA-F0-9])/pack("C", hex($1))/eg;
	$org =~ s/\t//g;
	$org =~ s/\cM//g;
	$org;
}

#######################
#データ読み込み
#	1:データファイル名
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
		#条件を満たさないデータを読み飛ばす
		if ($line =~ /^\@\/([^\/]+)\/\{/){
			my $term=$1;
			my $hit=0;
			(!$jk) && (next);
			foreach $tjk (split(/\|/,$jk)){
				(",$term," =~ /,$tjk,/) && (($hit=1) || (last));
			}
			(!$hit) && (next);
		}
		#改行除去
		$line=~s/,?\x0d?\x0a?$//;
		#@{file=data.dat}
		if($line =~ /^\@[^\{]*\{(.*)file=(.+)\}/){			# インクルード
			my $cap = $1;
			my $f = $2;
			$f =~ s/<datadir>\/*/$datadir/i;
&dbgout("file=$f");
			(-e $f) && &loadData($f);
			($cap) && ($FILE{$cap}=$f);
		}
		elsif($line =~ /^\*{([^=]+)=(.+)\}/){				# ファイル名
			$FILE{$1}=$2;
			$FILE{$1}=~s/<datadir>\/*/$datadir/i;
		}
		#@{key},a,b,c...
		elsif($line =~ /^(!?)\@[^\{]*\{([^\}]*)\},(.*)/){	# データ(@)読み取り、保存
			($1 && !$get_news_required) && next;
			my($w) = $3;
			(my $key = $2) =~ s/^(\d+)://;		# ここでは:識別子(固定)は外す
			($WORD{$key} .= $w.',') &&  next;
		}
		#@{key}=data.dat		外部列挙データ(@)読み取り、保存
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
#外部列挙データの再読込
#	1:キー
#	注１）外部列挙データ以外のキーが指定された場合は無効
#	注２）同一キーに対して複数のファイルが読み込まれている場合、
#		最後に読みこまれた確率が設定されていないファイルが対象になる
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
#単語教育
#	1:キー
#	2:単語
#	[3:条件]
#	以下のようなデータが追加される。
#	@/条件/{キー},単語
#	条件を指定しない場合は以下。
#	@{キー},単語
#######################
sub studyWord{
	my($key,$word,$term) = @_;

	if ($key eq ''){
		return &result('KEYが入力されていません。KEYを入力してください');
	}
	if ($word eq ''){
		return &result('単語が入力されていません。単語を入力してください');
	}

	my($outstr);

	($term) && ($term = '/'.$term.'/');
	$outstr = "\@$term\{$key\},$word";
	jcode::convert(\$outstr, 'euc');
	if (open(DATA,'>>'.$FILE{'study'})){
		print DATA "$outstr\n";
		close(DATA);
		return &result("「$key」に「$word」を追加しました");
	} else {
		return &result('教育ができません。管理者に連絡してください。');
	}
}

sub autoStudy{
	my($file,$p,$wd)=@_;
	(!-e $file) && (return);
	(int(rand(100)) > $p) && (return);
	($wd=~/^\{[^\}]+\}$/) && (return);
	my $wdtail;
	if ($wd =~ /.+(>|＞).+/){
		my @wrdlist = split(/,/,$WORD{'words'});    # データを欄に分解(欄数)
		my($tmp);
		foreach $tmp (@wrdlist){
			if ($wd =~ /(.+)(>|＞)$tmp$/){
				$wd=$1;
				$wdtail="＞{words}";
				last;
			}
		}
	}
#	$wd =($wd =~ /(.+)(>|＞).+/)?"$1＞{words}":$wd;
	if ($WORD{'T一人称'}){
		my $from=$WORD{'wname'};
		my @TO = split(/,/,$WORD{'T一人称'});
		my $to= @TO[int(rand(@TO))];
		$wd=~s/$from/$to/g;
		if (-e $FILE{'replace'} && open(REP,$FILE{'replace'})){
			while (<REP>){
				#改行除去
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
#最終教育忘却
#	一番最近教育されたデータを削除
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
		return &result("「$v1」から「$v2」を忘れました。");
	} else {
		return &result('忘れられません。');
	}
}

#############################################
#以下、pr_inet.plから引用して修正
#############################################

sub rndint{                             # 注・$i < $j のチェック無し
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

#応答が存在しない場合は空で返す
	(!defined($WORD{$key})) && (return '');

	($NEWS{$key}) && ($WORD{$key}=&getNews_socket($WORD{$key})) || ($NEWS{$key}=0);
  my @wrdlist = split(/,/,$WORD{$key});    # データを欄に分解(欄数)
#&dbgout("wrdlist=@wrdlist");
  $ret     = @wrdlist[int(rand(@wrdlist))];
#&dbgout("ret=$ret");
  if(defined($keyno)){
    (defined($retword{$key.$keyno})) && ($ret = $retword{$key.$keyno})
                                     || ($retword{$key.$keyno} = $ret);
  }

#無限ループ抑止
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
#####クッキーを取得
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

#####クッキーを設定
sub set_cook{
	#世界標準の日付と時刻を取得し、クッキーの有効期限を
	#最終書き込み日より１日に設定する
	my($c_sec,$c_min,$c_hour,$c_mday,$c_mon,$c_year,$c_wday,$c_yday,$c_isdst) = gmtime(time + 86400);
	#クッキーの日付、時刻を２桁に統一
	($c_year < 2000) && ($c_year+=($c_year>60)?1900:2000);
	$c_sec  = sprintf("%02d",$c_sec);
	$c_min  = sprintf("%02d",$c_min);
	$c_hour = sprintf("%02d",$c_hour);
	$c_mday = sprintf("%02d",$c_mday);
	$youbi = ('Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday') [$c_wday];
	$month = ('Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec') [$c_mon];
	$date_gmt = "$youbi, $c_mday\-$month\-$c_year $c_hour:$c_min:$c_sec GMT";

	my $cook=$_[0];
	jcode::tr(\$cook,';,:','；，：');

	$cook="cache\:$cook";
	jcode::convert(\$cook, $outCode,'euc');
	#クッキーに書き込み
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
