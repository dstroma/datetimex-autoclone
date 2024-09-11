package DateTimeX::AutoClone;
use strict;
use warnings;

use DateTime ();
use parent 'DateTime';

sub mutator_method_list {
  qw(
    add_duration
    subtract_duration
    add
    subtract
    set
    set_year
    set_month
    set_day
    set_hour
    set_minute
    set_second
    set_nanosecond
    truncate
    set_time_zone
    set_locale
    set_formatter
  );
}

foreach my $name (mutator_method_list) {
  no strict 'refs';
  *{$name} = sub {
    my $clone  = $_[0]->clone;
    $_[0] = *{"DateTime::$name"}->($clone, @_[1..$#_]);
  };
}

1;
