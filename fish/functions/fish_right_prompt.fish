function fish_right_prompt
    set -l is_git_repository (git rev-parse --is-inside-work-tree 2>/dev/null)

    if [ -n "$is_git_repository" ]
        set_color -o brmagenta
        echo (git rev-parse --abbrev-ref HEAD 2>/dev/null)
        set_color normal
    end
end
