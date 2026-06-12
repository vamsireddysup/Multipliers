# Baugh-Wooley multiplier (8-bit, signed)

## Overview

The Baugh-Wooley algorithm multiplies two signed (two's complement)
numbers using essentially the same AND-gate partial product grid as an
unsigned array multiplier, with a small modification to the sign bits
and a fixed correction constant. This avoids the extra sign-extension
and correction logic that naive signed multiplication would otherwise
require.

## Decomposition

Each 8-bit two's complement operand can be written as its lower 7 bits
(unsigned) minus 128 times its sign bit:

```
a = a[6:0] - 128 * a[7]
b = b[6:0] - 128 * b[7]
```

Expanding a*b produces four groups of terms: the inner 7x7 grid of
a[i]&b[j] for i,j = 0..6, two groups of negative cross terms involving
each operand's sign bit, and a positive a[7]&b[7] term.

## The inversion and correction

Using the identity that for a single bit x, -x = ~x - 1, the negative
cross terms can be rewritten as inverted AND terms plus constant
offsets. After combining all the constant offsets and reducing modulo
2^16 (since the output is 16 bits), the result is:

- The inner 7x7 grid sums normally, positions 0 through 12.
- The row a[7] & b[i] for i = 0..6 is inverted (~) and placed at bit
  positions 7 through 13.
- The column a[i] & b[7] for i = 0..6 is inverted (~) and placed at bit
  positions 7 through 13.
- The corner term a[7] & b[7] is placed at bit position 14, not
  inverted.
- A fixed constant 0x8100 (bits 15 and 8 set) is added to account for
  the inversions.

This was verified by hand for a=1,b=1; a=-1,b=1; and a=-1,b=-1
(the last case exercises both inversions and the corner term
together), all producing the correct signed result modulo 2^16.

## Implementation

The implementation (baugh_wooley_multiplier_8bit.v) builds the inner
grid, the inverted sign row and column, and the corner term using
generate loops, then sums them with the correction constant in a
single addition. The original structural version, built from 56 full
adder instances with inverted partial products on the boundary row and
column, is preserved in git history for reference.
