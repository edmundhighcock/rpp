require 'helper'

class TestRpp < Test::Unit::TestCase
	def test_all
		Rpp.run('test/testfile.rpp.tex')
	end
end
