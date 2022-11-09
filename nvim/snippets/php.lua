return {
	s('vd', {
		t('var_dump('), i(1), t(');')
	}),
	s('vdd', {
		t('var_dump('), i(1), t(');die();')
	}),
}
