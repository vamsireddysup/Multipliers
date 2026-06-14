# Dadda multiplier (8-bit)

## Overview

A Dadda multiplier reduces the 8x8 partial product matrix to two rows
using the minimum number of half adder (HA) and full adder (FA)
compressors needed to hit a sequence of target column heights, then
adds the final two rows with a carry-propagate adder. It generally
uses fewer compressors than a Wallace tree for the same operand width,
at the cost of a slightly less regular wiring pattern.

## Column heights

For an 8x8 partial product matrix, pp[i][j] = a[j] & b[i] has weight
i+j. The number of bits at each weight (0 through 14) is:

```
weight:  0  1  2  3  4  5  6  7  8  9 10 11 12 13 14
height:  1  2  3  4  5  6  7  8  7  6  5  4  3  2  1
```

The peak height is 8, at weight 7.

## Reduction stages

The Dadda target sequence is 2, 3, 4, 6, 9, 13, ... (each term is
floor(1.5 times the previous term)). For a peak height of 8, the
stages reduce column heights to:

```
8 -> 6 -> 4 -> 3 -> 2
```

At each stage, every column whose height exceeds the target is reduced
using the minimum number of HA (2 inputs -> 1 sum + 1 carry, reduces
height by 1) and FA (3 inputs -> 1 sum + 1 carry, reduces height by 2)
compressors, processed from the least significant column upward so
that carries generated within a stage are accounted for in the column
they land on.

Stage compressor usage:

| Stage | Target | HA used | FA used |
|---|---|---|---|
| 1 | 6 | 1 | 5 |
| 2 | 4 | 0 | 14 |
| 3 | 3 | 5 | 5 |
| 4 | 2 | 1 | 11 |
| Final addition | - | 1 | 13 |

Total: 8 HA + 48 FA = 56 compressors, matching the number of adder
instances in the original structural implementation.

## Final addition

After stage 4, every column from weight 1 to 14 has exactly two bits,
and weight 0 has a single bit (pp[0][0], which becomes prod[0]
directly with no addition). The remaining two rows are added with a
14-stage carry-propagate addition (1 HA for the column with no
incoming carry, 13 FA for the rest), producing prod[1] through
prod[14], with the final carry-out becoming prod[15].

## Implementation

The implementation (dadda_multiplier_8bit.v) follows the stage
structure above directly: the partial product matrix is generated with
a nested generate loop, and each compressor in stages 1 through 4 and
the final addition is instantiated explicitly, grouped and commented by
stage and column. This preserves the actual Dadda reduction structure
rather than collapsing to a behavioral multiply, since the compressor
scheduling is the point of this design.

The compressor count (8 HA + 48 FA) matches the original structural
file exactly, which is a strong indication the reduction structure is
equivalent, though bit-exact verification against the original
testbench has not been run.
