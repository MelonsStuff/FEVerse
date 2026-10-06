-- hi
local FEManager = {}
local makefolder = makefolder
local isfolder = isfolder
local isfile = isfile
local writefile = writefile

FEManager.EnsureFolder = function(path)
	if not isfolder(path) then
		makefolder(path)
		return print(path.." doesn't exist, making it now.")
	else
		print(path.." already exists.")
	end
end

FEManager.DownloadFile = function(Directory, FileName, Link)
	if not isfile(Directory..FileName) then
		writefile(Directory..FileName, game:HttpGet(Link))
		return print(FileName.." is not downloaded, downloading.")
	else
		print(FileName.." already exists.")
	end
end

return FEManager
