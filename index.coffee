SimpleNumber = require './lib/SimpleNumber'
Operation = require './lib/Operation'

opRegexpNormal = '(\\d+|\\(.*\\))([\\+\\-])(\\d+|\\(.*\\))'
opRegexpAll = '(\\d+|\\(.*\\))([\\+\\-\\*\\/])(\\d+|\\(.*\\))'
opRegexpPriorized = '(\\d+|\\(.*\\))([\\*\\/])(\\d+|\\(.*\\))'

getMemberValue = (str) ->
	if SimpleNumber.testStr(str)
		return new SimpleNumber(str).getValue()
	else
		return parseComplexOperation(Operation.decapsulateOp(str))

parseSimpleOperation = (str) ->
	match = new RegExp(opRegexpAll).exec(str)
	m1 = getMemberValue(match[1])
	m2 = getMemberValue(match[3])
	return new Operation(m1, m2, match[2]).getValue()

parseComplexOperation = (str) ->
	# replace parenthesis first
	str = str.replace /\((.*?)\)/g, (m...)-> parseComplexOperation m[1]
	# replace '*'' and '/'' operations
	while (m = new RegExp(opRegexpPriorized).exec(str))?
		str = str.replace(m[0], parseSimpleOperation(m[0]))
	# replace '+' and '-'
	while (m = new RegExp(opRegexpNormal).exec(str))?
		val = parseSimpleOperation(str)
		str = str.replace(m[0], val)
	return str

str = process.argv[2] || '1+(2+3)'
console.log "Result of parsing #{str} --> ", parseComplexOperation(str)