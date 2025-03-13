function ac --wraps='git add -A && git commit -m'
    git add -A
    git commit -m $argv
end
