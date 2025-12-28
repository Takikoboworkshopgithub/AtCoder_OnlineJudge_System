ojj() {
    # ===== colors =====
    C_RESET='\033[0m'
    C_INFO='\033[1;34m'
    C_OK='\033[1;32m'
    C_NG='\033[1;31m'
    C_ERR='\033[1;31m'
    C_DIM='\033[2m'

    file=$1

    [[ -f "$file" ]] || {
        echo -e "${C_ERR}[ERROR] file not found${C_RESET}"
        return 1
    }

    command -v acc >/dev/null 2>&1 || {
        echo -e "${C_ERR}[ERROR] acc not found${C_RESET}"
        return 1
    }

    prob=$(_problem_from_file "$file")
    tcdir="testcases/$prob"

    [[ -d "$tcdir" ]] || {
        echo -e "${C_ERR}[ERROR] no testcases for $prob${C_RESET}"
        return 1
    }

    # ===== build / run =====
    case "$file" in
        *.cpp)
            g++ -std=gnu++20 "$file" -O2 -o .ojj.out || return 1
            run="./.ojj.out"
            ;;
        *.py)
            run="python3 $file"
            ;;
        *)
            echo -e "${C_ERR}[ERROR] unsupported file type${C_RESET}"
            return 1
            ;;
    esac

    echo -e "${C_INFO}[INFO] problem:${C_RESET} $prob"
    echo -e "${C_INFO}[INFO] testing:${C_RESET} $file"
    echo

    all_ac=1
    slowest=0

    for infile in "$tcdir"/*.in; do
        name=$(basename "$infile" .in)
        outfile="$tcdir/$name.out"

        echo -e "${C_INFO}[INFO]${C_RESET} $name"

        start=$(date +%s.%N)
        output=$($run < "$infile")
        end=$(date +%s.%N)
        time=$(echo "$end - $start" | bc)

        if diff -q <(echo "$output") "$outfile" >/dev/null; then
            echo -e "${C_OK}[SUCCESS] AC${C_RESET}"
        else
            echo -e "${C_NG}[FAILED] WA${C_RESET}"
            diff -u "$outfile" <(echo "$output")
            all_ac=0
        fi

        echo -e "${C_DIM}[INFO] time:${C_RESET} $time sec"
        echo

        (( $(echo "$time > $slowest" | bc -l) )) && slowest=$time
    done

    [[ $all_ac -eq 1 ]] || {
        echo -e "${C_ERR}[ERROR] some test failed${C_RESET}"
        return 1
    }

    echo -e "${C_OK}[SUCCESS] all tests passed${C_RESET}"
    echo -e "${C_INFO}[INFO] slowest:${C_RESET} $slowest sec"
    echo

    read -p "Submit? [y/N]: " ans

    if [[ "$ans" =~ ^[yY]$ ]]; then
        contest=$(_atcoder_contest)
        prob_lc=$(echo "$prob" | tr 'A-Z' 'a-z')
        task="${contest}_${prob_lc}"
        url="https://atcoder.jp/contests/$contest/tasks/$task"

        echo -e "${C_INFO}[INFO] submit via acc (${contest}, ${task})${C_RESET}"

        log=$(mktemp)
        acc submit -c "$contest" -t "$task" "$file" >"$log" 2>&1

        if grep -qiE "cannot find|error|failed" "$log"; then
            echo -e "${C_ERR}[ERROR] submit failed${C_RESET}"
            cat "$log"
            echo "$url" | xclip -selection clipboard
            xdg-open "$url" >/dev/null 2>&1
            rm -f "$log"
            return 1
        fi

        echo -e "${C_OK}[SUCCESS] submit success${C_RESET}"
        rm -f "$log"
    else
        cat "$file" | xclip -selection clipboard
        echo -e "${C_OK}[SUCCESS] code copied to clipboard${C_RESET}"
    fi
}
