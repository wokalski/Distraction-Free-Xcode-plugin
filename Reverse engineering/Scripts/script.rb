
# This (ugly) script dumps all framework/plugin headers from a given directory. It's nothing future-safe. Interesting places to run it are ~/Applications/Xcode/Contents/[PlugIns | Frameworks | Other Frameworks | Shared Frameworks].


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

# Change this to your output directory
outputDir = nil

dumpFilesInDirectory(Dir.pwd, nil)
