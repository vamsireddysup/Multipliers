# Hardware Multipliers

SystemVerilog implementations of hardware multiplier architectures, exploring different design trade-offs in area, speed, and power consumption.

## Repository Structure

```
multipliers/
├── Array_Multiplier/    # Array multiplier RTL implementation and testbench
└── README.md
```

## Implemented Architectures

### Array Multiplier
A combinational multiplier using a two-dimensional array of AND gates and adders.

| Attribute  | Value                          |
|------------|--------------------------------|
| Type       | Combinational                  |
| Complexity | O(n²) gates                   |
| Delay      | O(n) carry propagation stages  |
| Area       | O(n²)                         |

**How it works:**
1. Generate partial products: each bit of multiplier ANDed with multiplicand
2. Sum all partial product rows using a carry-save adder tree
3. Final addition with ripple-carry or carry-lookahead adder

## Design Comparison (Planned)

| Architecture      | Gate Count | Critical Path | Notes              |
|-------------------|------------|---------------|--------------------|
| Array Multiplier  | O(n²)      | O(n)          | Simple, slow       |
| Booth Multiplier  | O(n²/2)    | O(n)          | Fewer partial prods|
| Wallace Tree      | O(n²)      | O(log n)      | Fast, complex      |

## Tools

- **SystemVerilog**: RTL implementation
- **QuestaSim / ModelSim**: Simulation and verification
- **Synopsys Design Compiler**: Synthesis and area/timing analysis

## Simulation

```bash
# Compile and simulate
vlog Array_Multiplier/*.sv
vsim -do "run -all" tb_multiplier
```

## Conversion and documentation status

Tracking table for the rewrite-to-behavioral and README documentation
effort across all folders. Status values: Pending, Done.

| Folder | Category | Status |
|---|---|---|
| array_multiplier_8bit | Multiplier | Done |
| Array_Multiplier | Multiplier | Pending |
| baugh_wooley_multiplier_8bit | Multiplier | Pending |
| dadda_multiplier_8bit | Multiplier | Pending |
| kulkarni_multiplier | Multiplier | Pending |
| ma_x_fa | Multiplier | Pending |
| radix_4_4bit_multiplier | Multiplier | Pending |
| radix4_8bit_mulltiplier | Multiplier | Pending |
| radix4_16bit_multiplier | Multiplier | Pending |
| radix4_32bit_multiplier | Multiplier | Pending |
| radix4_16bit_approx1 | Multiplier | Pending |
| radix4_16bit_approx2 | Multiplier | Pending |
| radix4_16bit_approx3 | Multiplier | Pending |
| radix4_16bit_approx4 | Multiplier | Pending |
| radix4_16bit_approx5 | Multiplier | Pending |
| radix4_16bit_approx6 | Multiplier | Pending |
| radix4_8bit_approx1 | Multiplier | Pending |
| radix4_8bit_approx2 | Multiplier | Pending |
| radix4_8bit_approx3 | Multiplier | Pending |
| radix4_8bit_approx4 | Multiplier | Pending |
| radix4_8bit_approx5 | Multiplier | Pending |
| radix4_8bit_approx6 | Multiplier | Pending |
| radix4_8bit_approx7 | Multiplier | Pending |
| radix8_8bit_multiplier | Multiplier | Pending |
| radix8_16bit_multiplier | Multiplier | Pending |
| radix8_32bit_multiplier | Multiplier | Pending |
| radix8_8bit_structmul | Multiplier | Pending |
| shift_and_add_multiplier_8bit | Multiplier | Pending |
| wallace_tree_multiplier | Multiplier | Pending |
| radix4_8bit_compres | Multiplier (unconfirmed) | Pending |
| brent_kung_adder_8bit | Adder | Pending |
| carry_propagate | Adder | Pending |
| carry_save_adder | Adder | Pending |
| carry_save_adder_8bit | Adder | Pending |
| carry_save_adder_8op_32bit | Adder | Pending |
| carry_select_adder | Adder | Pending |
| carry_select_adder_8bit_uniform | Adder | Pending |
| carry_skip_adder | Adder | Pending |
| carry_skip_adder_8bit | Adder | Pending |
| kogge_stone_adder | Adder | Pending |
| kogge_stone_adder_8bit | Adder | Pending |
| ACSA1 | Adder | Pending |
| AMLA | Adder | Pending |
| radix4_8bit_acsa | Adder (unconfirmed) | Pending |
| radix4_8bit_csa | Adder (unconfirmed) | Pending |
| radix8_8bit_csa | Adder (unconfirmed) | Pending |
| project_2 | Adder (needs rename to ripple_carry_adder_4bit) | Pending |
| image_process1 | Image processing | Pending |
| image_processing | Image processing | Pending |
| project_4 | Image processing (needs dedup check) | Pending |
| sample_project | Unresolved (needs dedup check) | Pending |
| example | Unresolved (xor_4, category TBD) | Pending |
