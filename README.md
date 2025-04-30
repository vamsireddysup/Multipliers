# Multipliers

This repository _Multipliers_ collects a variety of high-performance, parameterized multiplier and adder architectures implemented in SystemVerilog. Each design includes a structural implementation, a randomized self-checking testbench, and functional coverage metrics. After completing and verifying each module, its architecture and usage details will be documented here.

## Contents

- **Array Multiplier**
- **Baugh–Wooley Multiplier**
- **Dadda Multiplier**
- **Radix-4 Booth Multiplier**
- **Approximate Radix-4 Booth Multiplier**
- **Wallace Tree Multiplier**

- **Adder Architectures:**
  - Brent–Kung Adder
  - Carry Propagate Adder (Ripple-Carry)
  - Carry Save Adder
  - Carry Select Adder
  - Carry Skip Adder
  - Kogge–Stone Adder
  - Exact Compressor Adders

---

## Array Multiplier

The **Array Multiplier** is a straightforward, bit‐parallel multiplier that uses an N×N grid of AND gates to form partial products and a cascade of adders to accumulate them. It has:

1. **Partial‐Product Generation:** For each bit of the multiplier, an AND operation with the entire multiplicand generates a row of partial products.
2. **Shifted Summation:** Each partial row is shifted according to its bit position.
3. **Ripple‐Addition:** An array of full‐adders (or carry‐save adders in optimized versions) summing column by column.

### Key Characteristics

- **Regular structure:** Easy to lay out and pipeline
- **Area Complexity:** O(N²) gates
- **Latency:** O(N) adder stages

### Simple Example (4 × 4)

Multiply `A = 0b1011 (11)` by `B = 0b0110 (6)`:  

| Bit Position | Partial Products        | Shifted                      |
|--------------|-------------------------|------------------------------|
| B[0] = 0     | 0b1011 & 0 → 0000       | 0000                         |
| B[1] = 1     | 0b1011 & 1 → 1011       | 1011 << 1 → 10110            |
| B[2] = 1     | 0b1011 & 1 → 1011       | 1011 << 2 → 101100           |
| B[3] = 0     | 0b1011 & 0 → 0000       | 0000 << 3 → 0000000          |
| **Sum**      |                         | 0000 + 10110 + 101100 = 1000010 (66)

Result: `11 × 6 = 66 (0b01000010)`.

---

*Next up: Baugh–Wooley Multiplier.*

