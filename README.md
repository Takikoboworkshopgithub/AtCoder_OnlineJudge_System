# ojj – AtCoder Local Test & Submit Helper

`ojj` is a Bash helper function for competitive programming on **AtCoder**.  
It integrates **local testing**, **execution time measurement**, **submission via acc**, and **clipboard copy** into a single command.

---

## Features

- Run all local testcases automatically
- Measure execution time for each testcase
- Block submission if any test fails
- After All AC:
  - `y` / `Y` → submit via `acc`
  - otherwise → copy source code to clipboard

---

## Requirements

### Environment

- Linux
- Bash
- Python 3
- g++ (C++20)
- `bc`
- `xclip`

### Tools

- [online-judge-tools (oj)](https://github.com/online-judge-tools/oj)
- [atcoder-cli (acc)](https://github.com/Tatamo/atcoder-cli)

---

## Installation

### 1. Install online-judge-tools

```bash
pip3 install online-judge-tools
2. Install atcoder-cli
bash
コードをコピーする
npm install -g atcoder-cli
acc login
Directory Structure
The following directory structure is assumed:

text
コードをコピーする
.
├── A.cpp
├── B.cpp
└── testcases/
    └── A/
        ├── sample1.in
        ├── sample1.out
        └── sample2.in
Testcases are generated using oj:

bash
コードをコピーする
oj d https://atcoder.jp/contests/xxx/tasks/xxx_a
Usage
bash
コードをコピーする
ojj A.cpp
Behavior
If any testcase fails
→ execution stops immediately

If all testcases pass (All AC):

text
コードをコピーする
Submit? [y/N]:
y or Y
→ submit the source code via acc

otherwise
→ copy the source code to clipboard

Clipboard copy is useful for:

Browser-based submission

Language switching

Manual edits before submission

Notes
testcases/<Problem> directory must exist

_problem_from_file and _atcoder_contest are assumed to be defined externally

Designed for a personal competitive programming workflow on AtCoder