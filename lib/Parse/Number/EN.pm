package Parse::Number::EN;

# TODO: make it OO and customize thousand sep & decimal point

use 5.010;
use strict;
use warnings;

# VERSION

use Exporter::Lite;
our @EXPORT_OK = qw($Pat parse_number_en);

our %SPEC;

our $Pat = qr/(?:
                  [+-]?
                  (?:
                      (?:\d{1,3}(?:[,]\d{3})+ | \d+) (?:[.]\d*)? | # english
                      [.]\d+
                  )
                  (?:[Ee][+-]?\d+)?
              )/x;

$SPEC{parse_number_en} = {
    summary => 'Parse number from English text',
    args    => {
        text => ['str*' => {
            summary => 'The input text that contains number',
        }],
    },
    result_naked => 1,
};
sub parse_number_en {
    my %args = @_;
    my $text = $args{text};

    return undef unless $text =~ s/^\s*($Pat)//s;
    my $n = $1;
    $n =~ s/,//g;
    $n+0;
}

1;
# ABSTRACT: Pattern to match number
__END__

=head1 SYNOPSIS

 use Parse::Number::EN qw(parse_number_en $Pat);

 my @a = map {parse_number_id(text=>$_)}
     ("12,345.67", "-1.2e3", "x123", "1.23", "1,23");
 # @a = (12345.67, -1200, undef, 1.23, 1)

 my @b = map {/^$Pat$/ ? 1:0}
     ("12,345.67", "-1.2e3", "x123", "1,23");
 # @b = (1, 1, 0, 0)


=head1 DESCRIPTION

This module provides $Pat and parse_number_en().


=head1 VARIABLES

None are exported by default, but they are exportable.

=head2 $Pat (REGEX)

A regex for quickly matching/extracting number from text. It's not 100% perfect
(the extracted number might not be valid), but it's simple and fast.


=head1 FUNCTIONS

None are exported by default, but they are exportable.


=head1 SEE ALSO

L<Lingua::EN::Words2Nums>

Other Parse::Number::* modules.

=cut