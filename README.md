# MIPS-64bit-IEEE754-Divider

**Engineers:** Nahom Solomon & Jaskaran Mann  
**Tools:** LogicWorks (Schematic Design) | MIPS Assembly (Verification)  
**Standard:** IEEE-754 Double-Precision  

---

## Project Overview
This project is a hardware implementation of a **64-bit Double-Precision Floating-Point Divider** designed for the MIPS architecture. The unit processes a 1-bit sign, 11-bit exponent, and 52-bit mantissa (plus a hidden bit) to perform high-precision division compliant with IEEE-754 standards.

The design utilizes a multi-stage datapath to handle complex arithmetic, including gradual underflow (denormalization) and hardware exception flagging.

## Technical Architecture
### 1. Exponent Processing Pipeline (6 Stages)
* **Stage 2a/b**: Performs exponent subtraction ($A_{exp} - B_{exp}$) and bias adjustment (1023).
* **Stage 4 (Clip Logic)**: Detects overflow and underflow conditions, asserting flags to manage result integrity.
* **Stage 5 (Denormalization)**: Implements "Gradual Underflow" by forcing the exponent to zero and right-shifting the mantissa to preserve precision for tiny numbers.

### 2. Mantissa & Rounding Logic
* **Digit-by-Digit Division**: Executes the core mantissa division over sequential clock cycles.
* **Rounding PLA**: Implements "Round-to-Nearest, Ties-to-Even" logic using **Guard, Round, and Sticky (GRS) bits** to maintain numerical accuracy.

### 3. Exception Handling (PLA Based)
A custom **Programmable Logic Array (PLA)** detects and manages 16 distinct cases, including:
* **Invalid (V)**: NaN (Not a Number) inputs.
* **Div0 (Z)**: Division by zero detection.
* **Overflow (O) / Underflow (U)**: Triggered by the Clip logic stage.
* **Inexact (I)**: Flagged during rounding or denormalization.

## Verification & Testing
The hardware was validated using a comprehensive **MIPS Assembly Suite** (`div.d.test.asm`). The testbench covers 16 critical cases, including:
* **Case 0**: Standard division (3.0 / 1.375).
* **Case 1**: Division by zero (1.0 / 0.0 → inf).
* **Case 4**: Invalid operations (0.0 / 0.0 → NaN).
* **Case 8/9**: Extreme precision tests ($1.2345e^{-307}$) to verify denormalization logic.

---
*Developed as a core component for Advanced Computer Architecture (Arch 2) to demonstrate the internal mechanics of a MIPS Floating-Point Unit.*
