function fish_prompt
    set -l command_status $status

    echo -n (set_color -b cyan)(set_color black)$USER@(prompt_hostname)" "(set_color -b normal)
    echo -n (set_color -b green)(set_color black)(prompt_pwd)(set_color -b normal)

    if [ $command_status -ne 0 ]
        set_color red
    end

    echo -n " \$ "
    set_color normal
end
