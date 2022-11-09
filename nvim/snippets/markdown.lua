function Codeblock(language)
	return {
		t({'```' .. (language or ''), ''}),
		i(0),
		t({'', '```'})
	}
end

return {
	s('c', Codeblock()),
	s('cjs', Codeblock('javascript')),
	s('cjson', Codeblock('json')),
	s('ccss', Codeblock('css')),
	s('chtml', Codeblock('html')),
	s('cbash', Codeblock('bash')),
}
