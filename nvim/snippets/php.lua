function Concat(array1, array2)
	for _, v in ipairs(array2) do
		table.insert(array1, v)
	end

	return array1
end

function Mirror(jump_index)
	return f(
		function (arguments)
			return arguments[1][1]
		end,
		{jump_index},
		{}
	)
end

function MirrorCapitalized(jump_index)
	return f(
		function (arguments)
			return arguments[1][1]:gsub("^%l", string.upper)
		end,
		{jump_index},
		{}
	)
end

function VisibilityChoice(jump_index)
	return c(
		jump_index,
		{
			t('public'),
			t('protected'),
			t('private'),
		}
	)
end

function Setter(visibility_jump_index, name_jump_index, type_jump_index, insert_name, insert_type)
	visibility_jump_index = visibility_jump_index or 1
	name_jump_index = name_jump_index or 2
	type_jump_index = type_jump_index or 3

	if insert_name == nil then
		insert_name = true
	end

	if insert_type == nil then
		insert_type = true
	end

	return {
		VisibilityChoice(visibility_jump_index),
		t(' function set'),
		MirrorCapitalized(name_jump_index),
		t('('),
		insert_type and i(type_jump_index) or Mirror(type_jump_index),
		t(' $'),
		Mirror(name_jump_index),
		t({')', '{', '	$this->'}),
		insert_name and i(name_jump_index) or Mirror(name_jump_index),
		t(' = $'),
		Mirror(name_jump_index),
		t({';', '}'}),
	}
end

function Getter(visibility_jump_index, name_jump_index, type_jump_index, insert_name, insert_type)
	visibility_jump_index = visibility_jump_index or 1
	name_jump_index = name_jump_index or 2
	type_jump_index = type_jump_index or 3

	if insert_name == nil then
		insert_name = true
	end

	if insert_type == nil then
		insert_type = true
	end

	return {
		VisibilityChoice(visibility_jump_index),
		t(' function get'),
		MirrorCapitalized(name_jump_index),
		t({'(): '}),
		insert_type and i(type_jump_index) or Mirror(type_jump_index),
		t({'', '{', '	return $this->'}),
		insert_name and i(name_jump_index) or Mirror(name_jump_index),
		t({';', '}'}),
	}
end

return {
	s('c', {
		t('public function __construct('), i(1), t(')'),
		t({'', '{', ''}),
		t('	'), i(2),
		t({'', '}'}),
	}),
	s('dt', t('declare(strict_types=1);')),
	s('vd', {
		t('var_dump('), i(1), t(');')
	}),
	s('vdd', {
		t('var_dump('), i(1), t(');die();')
	}),
	s('ca', {
		t('$this->'),
		i(1),
		t(' = $'),
		Mirror(1),
		t(';'),
	}),
	s('g', Getter()),
	s('s', Setter()),
	s('gs', Concat(Concat(Getter(1, 2, 3), {t({'', ''})}), Setter(4, 2, 3, false, false))),
}
