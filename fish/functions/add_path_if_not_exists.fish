function add_path_if_not_exists
	set -l path $argv[1]
	contains $path $PATH; or set -a PATH $path
end
