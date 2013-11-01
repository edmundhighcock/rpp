require 'rubyhacks'

module Rpp
	class << self
		def run(file)
			raise ArgumentError.new("Expecting a file ending in .rpp.<ext>") unless file =~ /\.rpp\.\w+$/ 
		  text = File.read(file)
			outfile = File.open(file.sub(/\.rpp(\.\w+)$/, '\1'), 'w')
			regex = Regexp.new("(?<all>RPPEVAL#{Regexp.properly_nested('{', '}').verbatim})")
			#p regex
			eval_text = eval("<<EOFRPP\n" + text.gsub(regex){ a = "#{$~[:all]}";  a = a.universal_escape('RPPPPPPPPPPPPPXXXX');  a}.inspect.universal_unescape('RPPPPPPPPPPPPPXXXX').gsub(/RPPEVAL\{/, '#{') + "\nEOFRPP\n")
			outfile.puts eval_text[1...eval_text.length-2]
			outfile.close
		end
	end
end
