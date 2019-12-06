#!/usr/bin/env perl6

use v6;

say 1 + 2;		   # OUTPUT: 3
say 1/3 + 2/3;		   # OUTPUT: 1
say 1/3 + 0.6666666666666; # OUTPUT: 0.999999999999933

# No floating point noise:
say 0.1 + 0.2 == 0.3;        # OUTPUT: True
say (1/13 + 3/7 + 3/8);      # OUTPUT: 0.880495
say (1/13 + 3/7 + 3/8).perl; # OUTPUT:  <641/728>

