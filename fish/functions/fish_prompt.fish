function fish_prompt
    set -l command_status $status

    echo -n (set_color cyan)$USER@(prompt_hostname)" "(set_color green)(prompt_pwd)(set_color normal)

    if [ $command_status -ne 0 ]
        set_color red
    end

    echo -n " \$ "
    set_color normal
end
