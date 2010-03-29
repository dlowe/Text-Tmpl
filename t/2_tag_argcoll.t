use strict;
use Test;

BEGIN { plan tests => 1 }

use IO::File;
use Text::Tmpl;

use constant TEMPLATE => 't/2_tag_argcoll.tmpl';
use constant COMPARE  => 't/2_tag_argcoll.comp';

my($compare, $output);

my $context = new Text::Tmpl;
if (! defined $context) {
    ok(0);
    exit(0);
}
my $comp_fh = new IO::File COMPARE, 'r';
if (! defined $comp_fh) {
    ok(0);
    exit(0);
}

{
    local $/ = undef;
    $compare = <$comp_fh>;
}

$comp_fh->close;

$context->set_strip(0);
$context->set_value('var1', 'value1');
$context->set_value('var2', 'value2');
$context->set_value('var3', 'value3');

$output = $context->parse_file(TEMPLATE);

ok($output, $compare);
