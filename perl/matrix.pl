use strict;

my $NROWS = 3;
my $NCOLS = 4;


sub matrix_new {
  my ($nrows, $ncols) = @_;

  my @data = (0) x ($nrows * $ncols);
  my $nelem = scalar @data;
  
  print "$nrows rows, $ncols cols\n";
  print "$nelem data elements\n";

  my %m = ( nrows => $nrows, ncols => $ncols, rdata => \@data ); 

  return \%m;
}


sub matrix_elem_get
{
  my ($rm, $row, $col) = @_;
  my $idx = matrix_index($rm, $row, $col);
  my $rdata = $rm->{'rdata'};
  my $elem = $rdata->[$idx];
  return $elem;
}  


sub matrix_elem_set
{
  my ($rm, $row, $col, $value) = @_;
  my $idx = matrix_index($rm, $row, $col);
  my $rdata = $rm->{'rdata'};
  $rdata->[$idx] = $value;
}  


sub matrix_index {
  my ($rm, $row, $col) = @_;
  my $nrows = matrix_nrows($rm);
  my $ncols = matrix_ncols($rm);

  my $idx = ($row * $ncols) + $col;

  return $idx;
}


sub matrix_interchange_rows {
  my ($rm, $a, $b) = @_;

  my $ncols = matrix_ncols($rm);
  my @buf = (0) * $ncols;

}


sub matrix_ncols {
  my $rm = shift;
  return $rm->{"ncols"};
}


sub matrix_nrows {
  my $rm = shift;
  return $rm->{"nrows"};
}


sub matrix_print {
  my $rm = shift;
  my $nrows = matrix_nrows($rm);
  my $ncols = matrix_ncols($rm);

  my $space = '  ';
  my $str = '';

  for (my $row = 0; $row < $nrows; $row++) {
    $str = '';
    for (my $col = 0; $col < $ncols; $col++) {
      my $value = matrix_elem_get($rm, $row, $col);
      $str .= "$space$value";
    }
    print "$str\n";
  }
}


sub matrix_reduce {
  my $rm = shift;
  my $nrows = matrix_nrows($rm);
  my $ncols = matrix_ncols($rm);
 
  matrix_print($rm);

  for (my $pivot = 0; $pivot < $nrows; $pivot++) {
    my $next = $pivot + 1;
    # START HERE
  }

}


sub matrix_scale_row {
  my ($rm, $row, $scale) = @_;

  my $ncols = matrix_ncols($rm);

  for (my $col = 0; $col < $ncols; $col++) {
    my $value = matrix_elem_get($rm, $row, $col);
    matrix_elem_set($rm, $row, $col, ($value * $scale));
  }
}


#---main-----------------------------------------------------------------------
my $rm = matrix_new($NROWS, $NCOLS);

my $ncols = matrix_ncols($rm);
print "ncols: $ncols\n";

my $nrows = matrix_nrows($rm);
print "nrows: $nrows\n";

for (my $row = 0; $row < $NROWS; $row++) {
  for (my $col = 0; $col < $NCOLS; $col++) {
    my $idx = matrix_index($rm, $row, $col);
    print "row: $row, col: $col, index: $idx\n";
  }
}

matrix_elem_set($rm, 0, 0, 10);
matrix_elem_set($rm, 0, 1, 5);
matrix_elem_set($rm, 0, 2, 1);
matrix_elem_set($rm, 0, 3, 126);

matrix_elem_set($rm, 1, 0, 1);
matrix_elem_set($rm, 1, 1, 1);
matrix_elem_set($rm, 1, 2, 1);
matrix_elem_set($rm, 1, 3, 16);


matrix_elem_set($rm, 2, 0, 2);
matrix_elem_set($rm, 2, 1, 3);
matrix_elem_set($rm, 2, 2, 4);
matrix_elem_set($rm, 2, 3, 39);

matrix_print($rm);
