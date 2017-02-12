$get_news_required = 1;
# get_news
#			Ver.1.01	2001.06.10
# 			Ver.1.00	2001.06.09
use Socket;

sub getNews{
	my ($host,$uri,$port,$begin,$end,$datb,$date,$max,$code)=@_;
	$port or ($port=80);
	$datb or ($datb='>');
	$date or ($date='<');
	my $f=0;
	my $news;
	my $i=1;
	($max==0) && ($max=10);

	foreach( &get_content( $host, $uri, $port ) ){
		jcode::convert(\$_, 'euc',$code);
#		$_=&delTag($_);
		s/\x0d?\x0a?$//;
		if ($f==0 && /\Q$begin\E/){
			$f=1;
			next;
		}
		elsif (/\Q$end\E/){
			last;
		}
		elsif ($f){
			(/\Q$datb\E(.+)\Q$date\E/) && ($news.=$1.',' || $i++);
			($i>$max) && (last);
		}
	}
	close(S);
	$news=~s/,$//;
	return $news;
}

sub delTag{
	my $in = $_[0];
	my $tag_regex_ = q{[^"'>]*(?:"[^"]*"[^"'>]*|'[^']*'[^"'>]*)*}; #'}}}}
	my $comment_tag_regex =
    	'<!(?:--[^-]*(?:(?!--)-[^-]*)*--(?:(?!--)[^>])*)*(?:>|(?!\n)$|--.*$)';
	my $tag_regex = qq{$comment_tag_regex|<$tag_regex_>};
	$in =~ s/$tag_regex//g;
	return $in;
}
##############################
sub get_content{
    my ($host,$uri,$port) = @_;
	$port or ($port = 80);

    socket(S, PF_INET, SOCK_STREAM, getprotobyname('tcp'));
	my $sin  = pack("S n a4 x8", 2, $port, (gethostbyname($host))[4]);
	if (connect(S, $sin)){
		select(S); $| = 1; select(STDOUT);
	    print S <<"_EOM_";
GET $uri HTTP/1.0
Host: $host
User-Agent: get_news/1.0 ( http://www2.famille.ne.jp/~kuwa/perl/\; $ENV{OSTYPE}\; $ENV{HOSTTYPE})

_EOM_
	    return <S>;
	}
	return;
}
##############################
1;
