# ojj – AtCoder Local Test & Submit Helper

`ojj` は、**AtCoder 向け競技プログラミング用の Bash ヘルパー関数**です。  
ローカルテスト・実行時間計測・提出（acc）・クリップボードコピーを  
**単一コマンドで一貫して行う**ことを目的としています。

本ツールは、個人の競技プログラミング環境を前提に設計されています。

---

## Features

- すべてのローカルテストケースを自動実行
- 各テストケースの実行時間を計測
- 1つでも不正解があれば提出をブロック
- **All AC 時の挙動を選択可能**
  - `y` / `Y` → `acc` による提出
  - その他 → ソースコードをクリップボードへコピー

---

## Requirements

### Environment

- Linux
- Bash
- Python 3
- g++ (C++20)
- `bc`
- `xclip`

### External Tools

- [online-judge-tools (oj)](https://github.com/online-judge-tools/oj)
- [atcoder-cli (acc)](https://github.com/Tatamo/atcoder-cli)

---

## Installation

### 1. online-judge-tools のインストール

```bash
pip3 install online-judge-tools
2. atcoder-cli のインストールとログイン
npm install -g atcoder-cli
acc login
Directory Structure
以下のディレクトリ構成を前提としています。


.
├── A.cpp
├── B.cpp
└── testcases/
    └── A/
        ├── sample1.in
        ├── sample1.out
        └── sample2.in
テストケースは oj を用いて取得します。


oj d https://atcoder.jp/contests/xxx/tasks/xxx_a
Usage
ojj A.cpp
Behavior
テスト失敗時
いずれかのテストケースで不正解が出た時点で即座に終了

提出処理は行われません

全テスト通過時（All AC）

Submit? [y/N]:
y または Y を入力
→ acc を用いて提出

それ以外の入力
→ ソースコードをクリップボードへコピー

クリップボードコピーは、以下の用途を想定しています。

ブラウザからの手動提出

提出言語の切り替え

提出前の微調整・コメントアウト

Notes
testcases/<Problem> ディレクトリが存在する必要があります

_problem_from_file および _atcoder_contest 関数は
外部で定義されている前提です

AtCoder 向けの 個人ワークフロー最適化を目的としたツールです

License
This project is intended for personal use.
Feel free to modify it for your own workflow.
