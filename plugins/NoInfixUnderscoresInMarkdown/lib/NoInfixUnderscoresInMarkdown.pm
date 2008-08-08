
package NoInfixUnderscoresInMarkdown;

use strict;
use warnings;

sub setup {
    return if !MT->component('Markdown/Markdown.pl');

    my $original_ebse = \&Markdown::_EncodeBackslashEscapes;

    my $new_ebse = sub {
        my $ret = $original_ebse->(@_);
        # Escape punctuation the way Markdown.pl does: MD5 encoding. Seriously.
        $ret =~ s/ (?<= \w ) _ (?= \w ) /b14a7b8059d9c055954c92674ce60032/xmsg;
        return $ret;
    };

    no strict 'refs';
    *{Markdown::_EncodeBackslashEscapes} = $new_ebse;
}

1;

