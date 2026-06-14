# Wallace tree multiplier (8-bit)

## Overview

A Wallace tree multiplier reduces the 8x8 partial product matrix to
two rows using the minimum number of reduction stages, by applying
compressors as aggressively as possible at every stage. Any column
with 3 or more bits gets a full adder (FA), any column with exactly
2 bits gets a half adder (HA), regardless of whether a less aggressive
reduction would still meet the target. The result is fewer stages than
Dadda reduction, which means a shorter critical path, at the cost of
more total compressor instances.

## Column heights

For an 8x8 partial product matrix, pp[i][j] = a[j] & b[i] has weight
i+j. The number of bits at each weight (0 through 14) is:

```
weight:  0  1  2  3  4  5  6  7  8  9 10 11 12 13 14
height:  1  2  3  4  5  6  7  8  7  6  5  4  3  2  1
```

Peak height is 8 at weight 7.

## Reduction stages

Wallace reduction applies FAs and HAs to every column that exceeds
height 2 at each stage. Carries from a stage feed into the next
column at the same stage level, so the effective column height after
adding incoming carries must be tracked per column.

```
Stage 0 (raw pp): peak height 8
Stage 1:          peak height 5 (weights 7,8)
Stage 2:          peak height 3 (weights 6,7,8)
Stage 3:          peak height 2 (all columns)
Final addition:   ripple carry across 15 columns
```

Compare to Dadda which requires the same four reduction stages for
this operand size but uses fewer total compressors by applying the
minimum needed per column rather than the maximum possible.

## Wallace vs Dadda tradeoff

| Property | Wallace | Dadda |
|---|---|---|
| Reduction stages | 3 | 3 |
| Total compressors | More | Fewer |
| Critical path | Shorter | Slightly longer |
| Wiring regularity | Less regular | More regular |

For an 8x8 multiplier, both require the same number of stages since
the peak height (8) falls in the same Dadda bracket, so the critical
path advantage of Wallace is less pronounced here than for wider
operands.

## Implementation

The implementation (wallace_tree_multiplier.v) tracks column bits
through a 2D wire array at each stage, applying FAs and HAs
column-by-column with incoming carries from the previous column
accounted for explicitly. This preserves the actual Wallace reduction
structure rather than collapsing to a behavioral multiply. The
original gate-level structural version is preserved in git history
for reference.
