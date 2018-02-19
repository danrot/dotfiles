function fish_right_prompt
    set -l is_git_repository (git rev-parse --is-inside-work-tree ^/dev/null)

    if [ -n "$is_git_repository" ]
        set_color -o brmagenta
        echo (git rev-parse --abbrev-ref HEAD)
        set_color normal
    end
end
