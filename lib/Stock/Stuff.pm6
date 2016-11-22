use v6.c;
use Stats;
unit class Stock::Stuff;

class Cost is export {
    has Date $.date;
    has Num $.time;
    has Num $.open;
    has Num $.high;
    has Num $.low;
    has Num $.close; 
    has Num $.earnings;
    multi method new($date, $time, $open, $high, $low, $close, $earnings) {
        self.bless(:$date, :$time, :$open, :$high, :$low, :$close, :$earnings);
    }
}

sub load($f) is export {
    return gather for $f.IO.lines {
        my @w = .split(',');
        @w[0] ~~ m/(\d**4)(\d**2)(\d**2)/;
        my $d = Date.new($/[0].Int,$/[1].Int,$/[2].Int);
        my $c = Cost.new($d, |@w[1..*]».Num);
        $c.take;
    }
}
multi mean(@a) is export { [+](@a)/@a;}

#= True for rising, False for falling
sub analyze(@costs) is export {
    my $fm = mean @costs[0..*/2].map: *.close;
    my $sm = mean @costs[*/2..*].map: *.close;
    return  $sm - $fm > 0;
}

sub find-anomaly(@costs) is export {
    my $sl-size = $*sl-size;
    my @indexes = 0,$sl-size/2 ... @costs.elems - $sl-size;
    my @l = @costs.map: *.close;
        my $sd = sd @l;
    for @indexes -> $i {
        my @window = @costs[$i..$i+$*sl-size];
        my @l = @window.map: *.close;
        my $more-than = any(@l) > mean(@l)+3*$sd;
        my $less-than = any(@l) < mean(@l)-3*$sd;
        if $more-than or $less-than {
            "Anomaly between {@window[0].date} — {@window[*-1].date}".say;
            "\tMean: {mean @l}, sd: $sd\n\tmax: {max @l}, min: {min @l}".say
        }
    }
}

sub prefix:<Σ> { [+]($^a);}
sub Σ(@a) { [+](@a); }

sub correlate(@c1, @c2) is export {
    my $cov = 1 / @c1 * Σ((@c1 »-» mean(@c1)) Z* (@c2 »-» mean(@c2)));
    return $cov / (sd(@c1) * sd(@c2));
}

=begin pod

=head1 NAME

Stock::Stuff - well it's my homework

=head1 SYNOPSIS

Install deps with e.g.:

  zef --depsonly install .

To use plot, need to install matplotlib for python2, e.g.:

  pip2 install matplotlib

Run script for given csv file

  perl6 -Ilib/ bin/analyze-single <csv-file>

You might want to plot values between some dates

  perl6 -Ilib/ bin/plot --start='2000-01-01' --stop='2003-01-01' <csv-file>

Check correlation coefficents between 2 companies

  perl6 -Ilib/ bin/correlate <csv-file1> <csv-file2>

=head1 AUTHOR

Paweł Szulc <pawel_szulc@onet.pl>

=head1 COPYRIGHT AND LICENSE

Copyright 2016 Paweł Szulc

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
