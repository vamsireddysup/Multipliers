# Array multiplier (8-bit)

## Overview

An array multiplier computes the product of two unsigned binary numbers
by generating all partial products with an array of AND gates, then
summing them using a grid of full adders. It is the most direct
hardware implementation of the standard long multiplication algorithm.

## Architecture

For two 8-bit operands a and b, the multiplier generates an 8x8 grid of
partial products:

```
p[i][j] = a[j] AND b[i]
```

Each row i of this grid represents b[i] times a, shifted left by i bit
positions. The 64 partial product bits are then summed using 56 full
adders arranged in a ripple pattern. Each full adder takes two partial
product bits (or sums from the previous row) plus a carry-in, and
produces a sum bit and a carry-out. The carry-out from each adder
propagates to the adjacent adder in the same row, and the sum output
feeds into the next row down.

The final 16-bit product is assembled from the sum outputs of each row
and the final carry chain.

## Critical path

Because carries ripple both across each row and down through the rows,
the worst-case delay path runs from the first partial product bit
through roughly 2N-1 full adders for an N-bit multiplier. For N=8 this
means up to 15 full adder delays on the critical path, which is why
array multipliers do not scale well to wider operands compared to
tree-based structures like Wallace or Dadda multipliers.

## Implementation

The current implementation (array_multiplier_8bit.v) is a single
behavioral line:

```verilog
assign prod = a * b;
```

This is functionally equivalent to the gate-level array structure
described above. The original structural version, built from 56
instances of a full adder module and an explicit 8x8 partial product
array, is preserved in git history for reference.
