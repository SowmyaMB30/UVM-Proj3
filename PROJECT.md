# UVM Project 3 - Analysis and Requirements Checklist

## Project Requirements Summary

###### Required Interface Packages (Responder Agents)
- [ ] `imem_pkg` - Instruction memory package (RESPONDER)
- [ ] `dmem_pkg` - Data memory package (RESPONDER)

###### Required Interface Packages (Passive/Monitoring Only)
- [ ] `fetch_in_pkg` - Fetch interface input
- [ ] `fetch_out_pkg` - Fetch interface output
- [ ] `execute_in_pkg` - Fetch interface input
- [ ] `execute_out_pkg` - Fetch interface output
- [ ] `decode_in_pkg` - Decode interface input
- [ ] `decode_out_pkg` - Decode interface output
- [ ] `writeback_in_pkg` - Writeback interface input
- [ ] `writeback_out_pkg` - Writeback interface output
- [ ] `memaccess_in_pkg` - Memaccess interface input
- [ ] `memaccess_out_pkg` - Memaccess interface output
- [ ] `control_in_pkg` - Control interface input
- [ ] `control_out_pkg` - Control interface output
- [ ] `execute_in_pkg` - Execute interface input
- [ ] `execute_out_pkg` - Execute interface output

###### Required Environment Packages
- [ ] `fetch_env_pkg` - Fetch environment
- [ ] `decode_env_pkg` - Decode environment
- [ ] `execute_env_pkg` - Decode environment
- [ ] `writeback_env_pkg` - Writeback environment
- [ ] `memaccess_env_pkg` - Memaccess environment
- [ ] `control_env_pkg` - Control environment
- [ ] `execute_env_pkg` - Execute environment
- [ ] `lc3_env_pkg` - Top-level LC3 environment (includes all stage sub-environments + imem/dmem agents)

###### Required Test Bench Components
- [ ] `project_benches/lc3/tb/tests/lc3_test_pkg` - Test package
- [ ] `project_benches/lc3/tb/sequences/lc3_sequence_pkg` - Top-level sequence package
- [ ] `project_benches/lc3/sim/testlist.yaml` - Test list file (REQUIRED per project requirements)
- [ ] `project_benches/lc3/rtl` - LC3 RTL location

###### Required Documentation/Deliverables
- [ ] Simulation transcripts
- [ ] Test plan showing instruction coverage groups, coverpoints, etc.
- [ ] Merged coverage UCDB file
- [ ] Coverage report (text or PDF)
- [ ] `sim/testlist.yaml` with test names and seed numbers for full coverage

---

## Current Project Status (UVM-Proj3)

###### ✅ What have been done
- `Execution stage interface and environment package establishment`
- `project_benches/lc3/rtl/`
- `UVMF_2023.4_2/`

###### To do
1. **Interface Packages**
   - `fetch_in_pkg`, `fetch_out_pkg`
   - `decode_in_pkg`, `decode_out_pkg`
   - `execution_in_pkg`, `execution_out_pkg`
   - `writeback_in_pkg`, `writeback_out_pkg`
   - `memaccess_in_pkg`, `memaccess_out_pkg`
   - `control_in_pkg`, `control_out_pkg`
   - `imem_pkg`, `dmem_pkg`

2. **Environment Packages**
   - `fetch_env_pkg`
   - `decode_env_pkg`
   - `writeback_env_pkg`
   - `memaccess_env_pkg`
   - `control_env_pkg`
   - `lc3_env_pkg` (top-level environment)
   - `lc3_prediction_pkg` (likely needed for predictors)

3. **Issues now exist (list your issue here)**
   

4. **Test Bench Structure:**
   - `project_benches/lc3/tb/` directory structure
   - `project_benches/lc3/tb/tests/lc3_test_pkg/`
   - `project_benches/lc3/tb/sequences/lc3_sequence_pkg/`
   - `project_benches/lc3/sim/` directory with Makefile
   - `project_benches/lc3/sim/testlist.yaml` (REQUIRED)

5. **Test Infrastructure:**
   - Test cases with instruction constraints
   - Instruction memory transaction class extensions
   - Factory type overrides
   - Coverage collection setup

---

## Recommended Action Plan

###### Phase 1: Generate Interface Packages
1. Use UVMF interface generator to create all missing interface packages:
   - `fetch_in_pkg`, `fetch_out_pkg`
   - `decode_in_pkg`, `decode_out_pkg`
   - `execute_in_pkg`, `execute_out_pkg`
   - `writeback_in_pkg`, `writeback_out_pkg`
   - `memaccess_in_pkg`, `memaccess_out_pkg`
   - `control_in_pkg`, `control_out_pkg`
   - `imem_pkg` (RESPONDER agent)
   - `dmem_pkg` (RESPONDER agent)

###### Phase 2: Generate Environment Packages
1. Use UVMF environment generator to create:
   - `fetch_env_pkg` (with predictor and scoreboard)
   - `decode_env_pkg` (with predictor and scoreboard)
   - `execute_env_pkg` (with predictor and scoreboard)
   - `writeback_env_pkg` (with predictor and scoreboard)
   - `memaccess_env_pkg` (with predictor and scoreboard)
   - `control_env_pkg` (with predictor and scoreboard)
   - `lc3_env_pkg` (top-level, includes all sub-environments + imem/dmem agents)
   - `lc3_prediction_pkg` (if not auto-generated)

###### Phase 3: Create Test Bench Structure
1. Use UVMF bench generator to create LC3 test bench
2. Add LC3 RTL to the bench
3. Create `project_benches/lc3/tb/tests/lc3_test_pkg/`
4. Create `project_benches/lc3/tb/sequences/lc3_sequence_pkg/`
5. Create `project_benches/lc3/sim/testlist.yaml` with test/seed combinations

###### Phase 4: Implement Tests and Coverage
1. Create test cases that constrain instruction generation
2. Extend instruction memory transaction class with constraints
3. Use factory type override for extended transaction classes
4. Set up instruction coverage collection
5. Create test plan document
6. Run simulations and collect coverage
7. Merge coverage results
8. Generate coverage report

###### Phase 5: Documentation
1. Create test plan showing coverage groups and coverpoints
2. Document simulation results with transcripts
3. Ensure `testlist.yaml` contains all test/seed combinations for full coverage
4. Generate final coverage report

---

## Notes

- All environments must include predictor and scoreboard components
- Instruction coverage can be placed in:
  - `decode_in` agent coverage component, OR
  - Instruction memory agent coverage component
- Use `uvmf_bcr.py` to run simulations (as specified in requirements)
- Remove compiled libraries from sim directory before submission
- File submission format: `group##_p3.zip`