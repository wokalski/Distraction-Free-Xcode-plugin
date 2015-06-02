def dumpHeaders(directory, outputDirectory)
	if directory.split('.').last == "framework"
		directory << "/Versions/A/"
	else
		directory << "/Contents/MacOS/"
	end

		Dir.foreach(directory) do |x|
			next if x == '.' or x == '..'
			tempOutputDirectory = outputDirectory.dup
			tempOutputDirectory << "/#{x}"
			directoryCopy = directory.dup
			directoryCopy << x
			next if !File.file?(directoryCopy)
			puts File.file?(directoryCopy)
			%x[mkdir #{tempOutputDirectory}]
			%x[class-dump -H -o #{tempOutputDirectory} #{directoryCopy}]
		end
end

def dumpFilesInDirectory(directory, outputDirectory)
	newDir = "#{outputDirectory}/#{directory.split('/').last}"
	%x[mkdir #{newDir}]
	Dir.foreach(directory) do |x|
		next if x == '.' or x == '..'
		dumpHeaders(x, newDir)
	end
end

dumpFilesInDirectory(Dir.pwd, "/Users/wczekalski/Documents/Work/Projekty/Xcode-Plugin-Template/Project\\ Templates/Application\\ Plug-in/Xcode\\ Plugin.xctemplate/Headers")
