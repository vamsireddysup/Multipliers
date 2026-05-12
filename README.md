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
