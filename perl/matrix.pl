#!/usr/bin/perl

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


sub matrix_add_row_to_row {
  my ($rm, $src_row, $dest_row) = @_;
  
  my $ncols = matrix_ncols($rm);

  for (my $col = 0; $col < $ncols; $col++) {
    my $src_val = matrix_elem_get($rm, $src_row, $col);
    my $dest_val = matrix_elem_get($rm, $dest_row, $col);
    matrix_elem_set($rm, $dest_row, $col, ($src_val + $dest_val));
  }
}


sub matrix_clean {
  my $rm = shift;
  my $nrows = matrix_nrows($rm);

  # Test that pivot values are non-zero. 
  # If found, find a row whose value in the pivot column is non-zero, 
  # and add the row to the pivot row.
  for (my $pivot = 0; $pivot < $nrows; $pivot++) {
    my $value = matrix_elem_get($rm, $pivot, $pivot);
    if ($value == 0) {
      for (my $row = 0; $row < $nrows; $row++) {
        my $x = matrix_elem_get($rm, $row, $row);
        if ($x != 0) {
          matrix_add_row_to_row($rm, $row, $pivot);
          last;
        }
      }
    }
  }
}  


sub matrix_convert_to_reduced_row_echelon_form {
  my $rm = shift;
  my $nrows = matrix_nrows($rm);

  matrix_convert_to_row_echelon_form($rm);

  for (my $pivot = ($nrows - 1); $pivot > 0; $pivot--) {
    my $pivot_value = matrix_elem_get($rm, $pivot, $pivot);

    for (my $row = ($pivot - 1); $row >= 0; $row--) {
      my $row_value = matrix_elem_get($rm, $row, $pivot);
      my $scale = (-1 * $pivot_value) / $row_value;
      matrix_scale_row($rm, $row, $scale);
      matrix_add_row_to_row($rm, $pivot, $row);
      matrix_print($rm);
    }
    matrix_print($rm);
  }


  # Convert to reduced row echelon form:
  for (my $pivot = 0; $pivot < $nrows; $pivot++) { 
    my $pivot_value = matrix_elem_get($rm, $pivot, $pivot);
    my $scale = 1 / $pivot_value;
    matrix_scale_row($rm, $pivot, $scale);
  }

  # matrix_print($rm);
}


sub matrix_convert_to_row_echelon_form {
  my $rm = shift;
  my $nrows = matrix_nrows($rm);
  my $ncols = matrix_ncols($rm);

  matrix_print($rm);

  matrix_clean($rm);

  matrix_print($rm);

  # Start at the top, and apply scale and addition to rows below to clear left column:
  for (my $pivot = 0; $pivot < $nrows; $pivot++) { 
    my $pivot_value = matrix_elem_get($rm, $pivot, $pivot);
    
    for (my $current_row = $pivot + 1; $current_row < $nrows; $current_row++)  {
      my $current_value = matrix_elem_get($rm, $current_row, $pivot);
      
      if (($pivot_value != 0) && ($current_value != 0)) {
        # Scale the row to have -1 in the left column:
        my $scale = -1 * $pivot_value / $current_value;
        matrix_scale_row($rm, $current_row, $scale);
        
        # Add the pivot row to the row to get a 0 in ($current_row, $pivot), which is 
        # the row below the pivot row.
        matrix_add_row_to_row($rm, $pivot, $current_row);
      }

      matrix_print($rm);
    }
  }
}


sub matrix_elem_get {
  my ($rm, $row, $col) = @_;
  my $idx = matrix_index($rm, $row, $col);
  my $rdata = $rm->{'rdata'};
  my $elem = $rdata->[$idx];
  return $elem;
}  


sub matrix_elem_set {
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
  my ($rm, $rowa, $rowb) = @_;

  my $ncols = matrix_ncols($rm);
  my @buf = (0) * $ncols;

  # Copy row a to buf:
  for (my $col = 0; $col < $ncols; $col++) {
    my $value = matrix_elem_get($rm, $rowa, $col);
    push(@buf, $value);
  }

  # Copy row b to row a:
  for (my $col = 0; $col < $ncols; $col++) {
    my $value = matrix_elem_get($rm, $rowb, $col);
    matrix_elem_set($rm, $rowa, $col);
  }

  # Copy buf to row b:
  for (my $col = 0; $col < $ncols; $col++) {
    matrix_elem_set($rm, $rowb, $col, $buf[$col]);
  }
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

  print "\n---\n";

  for (my $row = 0; $row < $nrows; $row++) {
    $str = '';
    for (my $col = 0; $col < $ncols; $col++) {
      my $value = matrix_elem_get($rm, $row, $col);
      $str .= "$space$value";
    }
    print "$str\n";
  }

  print "---\n";
}


sub matrix_scale_row {
  my ($rm, $row, $scale) = @_;

  if ($scale != 0) {
    my $ncols = matrix_ncols($rm);

    for (my $col = 0; $col < $ncols; $col++) {
      my $value = matrix_elem_get($rm, $row, $col);
      matrix_elem_set($rm, $row, $col, ($value * $scale));
    }
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

matrix_elem_set($rm, 0, 0, 0);
matrix_elem_set($rm, 0, 1, 5);
matrix_elem_set($rm, 0, 2, 1);
matrix_elem_set($rm, 0, 3, 26);

matrix_elem_set($rm, 1, 0, 1);
matrix_elem_set($rm, 1, 1, 1);
matrix_elem_set($rm, 1, 2, 1);
matrix_elem_set($rm, 1, 3, 16);


matrix_elem_set($rm, 2, 0, 2);
matrix_elem_set($rm, 2, 1, 3);
matrix_elem_set($rm, 2, 2, 4);
matrix_elem_set($rm, 2, 3, 39);

matrix_print($rm);

# matrix_convert_to_row_echelon_form($rm);
matrix_convert_to_reduced_row_echelon_form($rm);

matrix_print($rm);

