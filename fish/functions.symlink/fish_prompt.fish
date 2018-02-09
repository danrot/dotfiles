function fish_prompt
    set -l command_status $status

    echo -n $USER@(prompt_hostname)
    echo -n " "(set_color $fish_color_cwd)(prompt_pwd)(set_color normal)

    if [ $command_status -ne 0 ]
        set_color red
    end

    echo -n " \$ "
    set_color normal
end
