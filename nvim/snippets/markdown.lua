function Codeblock(language)
	return {
		t({'```' .. (language or ''), ''}),
		i(0),
		t({'', '```'})
	}
end

return {
	s('c', Codeblock()),
	s('cbash', Codeblock('bash')),
	s('ccss', Codeblock('css')),
	s('chtml', Codeblock('html')),
	s('cjs', Codeblock('javascript')),
	s('cjson', Codeblock('json')),
	s('cphp', Codeblock('php')),
}
