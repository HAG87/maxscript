filein "assetManagerDef.ms"

/*
####### struct assetCreationClass 
maj:	
	/- refaire marcher la cr�ation d'asset
	
	-- supprimer la m�thode creationcheck
	-- updater la methode pour cr�er un asset � partir de la selection dansla scene
	-- unifier les m�thodes d'init du publish dans le rollout, ca devrait deprecier des methodes d'init danas la structure
	
	x- refaire fonctionner la cr�ation d'asset par selection sur le mod�le de la creation et du publish
	
	/- enregistrer des nouvelles version avec le publish (remplace "save in wip", force le remplacement)
		-- �a a l'air de marcher rajouter un avertissement (messagebox) quand on ecrase un ficchier existant
	
	/- distinguer ou unifier les variables "version" et "lastversion"

	-- trier les methodes de d�coupage et de reconstruction des pathname et les variables inutiles
		-- verifier qu'elles ne sont pas utiliser dans assetopener au merge ou � l'affichage ou dans l'assetupdater
		
	/- compar� les "assetname" et les "version" obtenus � partir des fichier ini et � partir des filename et folder
	
	/- rebuild des methodes d'enregistrements:
		-- respecter la forme suivante: basename.task.publish version.wip.wipversion
		
	--  proposer un rename en fonction du nom de l'asset au merge
	
	-- commencer le versionnig � 1 et pas � zero
	
	x- fusionner methode publish et create en modifiant la methode get assetfolder pour qu'lle retourne toujours l'assetfolder et pas le pathname du file .ini
	
	-- updater la fonction merge pour rendre le choix de la version � merger possible
		-- la methode est prete, il faut la faire fonctionner avec l'UI
	
####### AssetCreation  Rollout:
debug;
	-- a l'ouverture du rollout, caler le menu des taches sur la derni�re tache cr��e 

maj:
	-- rendre la creation de tache operationnelle  (modelisation, setup, animation)
		-- prendre en charge le choix de la version publi� (pour �craser existant)
			-- proposer la nouvelle version dans la liste "#[NEW]"
			-- updater la liste de versions au changement de tache
			-- toujours pr�senter la derni�re version dans la liste
			-- commencer les versions des tache � 1
			
	--  � la cr�ation du wip tester les versions pr�existante et incrementer
	
	-- blinder le choix de la version d'enregistrement:
		-- prendre en compte la version de max utiliser
		-- proposer des version d'enregistremnt possible(pr�c�dente)
		-- prendre en compte l'exception de max 2017 qui ne supporte pas la saveasversion: 2017
			
	/- proposer un clean des calques et des materiaux avant publish
	-- porposer un rename des calques et des materiaux avant publish
		
	-- re rendre le status editable
	

debug:
 	x- on ne peut pas r�er une nouvelle version � partir d'un wip qui n'est pas dans le dossier wip
	-- au fail de creation d'asset, supprimer le dossier cr��

rebuild:
	-- initialiser la creation d'asset � partir d'un fichier ini virtuel
	-- distinguer la methode de creation et de publish  d'asset en fonction de la version cr��e: 000 == creation , > 0 == publish
	-- developper les trois methode de build de l'asset existant:
		-- � partir des information du fichier ini
		-- � partir du d�coupage du filename ini
		-- � partir du scan du dossier du fichier ini

	/- fuse  "fn checkCreationSanity", "fn refreshPublishRlt" et "completeparam"
		-- la methode "checkCreationSanity" sert pour la creation d'asset, la methode "refreshPublishRlt" sert pour le publish, complete param complete le rollout
		-- move asset sanity check in the structure
		-- distinguer le sanity check de l'update de l'ui

doc:
	-- � la creationd'asset, l'asset folder est determin� par le basefolder + asset name
	-- au publish d'asset on r�cup�re directement l'asset folder � partir du pathname du fichier max

*/ 

global taskList  = #("without", "modelisation", "setup", "animation")
 
-- 	structure
struct assetCreationClass 
(
-- 	taskList = #("without", "modelisation", "setup", "animation"),
	
	objs,
	basefolder,
	assetName,
	version,
	
	assetInfo,
	assetFolder, 

	lastVersion,
	
-- 	root,
-- 	wipFolder,
	
	versionInfo,
	lastVersionFile,
	
-- 	relVersPath,
	
	status = "wip",
	
	task,
	
	maxVers,
	
	fn publishInfo =
	(
		format "\nassetName: %\nobjs: %\nbasefolder:%\nversion: %\nassetInfo: %\nassetFolder: %\nlastVersion: %\nroot: %\nwipFolder:%\nversionInfo: %\nlastVersionFile: %\nrelVersPath: %\nstatus: %\nmaxVers: %\n" \
		assetName objs basefolder version assetInfo assetFolder lastVersion root wipFolder versionInfo lastVersionFile relVersPath status maxVers
	),

	fn initFromScene assetRepo =
	(
		assetInfo = undefined
		basefolder = assetRepo + "\\"
		assetName = getFilenameFile maxFileName
		assetFolder = basefolder + assetName
		version = 0
		lastVersion = 0
		
		publishInfo()
	),
	
	fn initFromSel sel assetRepo =
	(
		assetInfo = undefined
		objs = sel
		basefolder = assetRepo + "\\"
		assetName = sel[1].name
		assetFolder = basefolder + assetName
		version = 0
		lastVersion = 0
		
	),
	/*
	fn getAssetFolder = 
	(
		local assetFolderRC
		
		if  assetInfo != undefined then  assetFolderRC = cleanFilename (getFilenamePath assetInfo)
		else assetFolderRC = assetFolder
		
		assetFolderRC
	),
	*/

	fn initFromIni iniFile  =
	(
		assetInfo = iniFile

		assetFolder = cleanFilename (getFilenamePath assetInfo)	
		basefolder = getupperfolder (assetFolder) + "\\"
		
		-- get asset name from file ini
		assetName = getINISetting iniFile "assetProperties" "name"
		if assetName.count == 0 then assetName = getINISetting iniFile "assetProperties" "assetName"
		
		-- get last version from file ini
		lastVersion = (getINISetting iniFile "assetProperties" "version") as integer
		version = lastVersion
	),
	
	fn getAssetFolder = assetFolder,

	fn getMaxFilesCount2 =
	(
-- 		local taskList = #("without", "modelisation", "setup", "animation")
		local taskVersionList = for t in taskList collect #()
		
		local assetFolder = getAssetFolder ()
		
		-- collecte des version "without task" � partir des dossier et fichiers
		local dirArr = GetDirectories (assetFolder + "\\*")
-- 		format "req: %, dirArr: %\n" (assetFolder + "\\*") dirArr		
		
		for f in dirArr do
		(
			local pathAr = filterString  f "\\"
			local versTest = (pathAr[pathAr.count] as integer)
			if  versTest != undefined  then 
			(
-- 				if versTest >= taskVersionList[1] then taskVersionList[1] = versTest + 1
				appendifunique taskVersionList[1] versTest
			)
		)
		
		-- collecte des version "modelisation"		
		local filesArr = getFiles (assetFolder + "\\*.max")
		
		for f in filesArr do
		(
			local fArr = filterString  f "."
			for i = 1 to  taskList.count do
			(				
				if fArr[2] == taskList[i] then
				(
					local versTest = (fArr[3] as integer)
					if  versTest != undefined  then
					(
-- 						if versTest > taskVersionList[i] then taskVersionList[i] = versTest
						appendifunique taskVersionList[i] versTest
					)else()
				)
				else()
			)
		)
		
		for t in taskVersionList do sort t
-- 		format "req: %, filesArr: %\n" (assetFolder + "\\*.max") filesArr
-- 		format "taskList: %\ntaskVersionList: %\n" taskList taskVersionList
		taskVersionList
	),
	
	
	fn getWipFolder = assetFolder + "\\" + "wip",	
	fn getVersionFolder = assetfolder + "\\" + (returnDigit version), 	
-- 	fn getWipFile = cleanFilename(getWipFolder() + "\\" + assetName +"." + (returnDigit version) + ".wip.001.max"),
	
	fn getLastVersionFile = 
	(
		cleanFilename(assetFolder + "\\" + (returnDigit version) + "\\" + assetName + ".max")
	),
	
	fn getLastVersionFile2 = 
	(
		local lastFilename
		local taskVersionList = getMaxFilesCount2()
		local maxTask
		local maxTaskVers
		-- r�cup�rer la tache la plus avanc�e
-- 		format "taskVersionList: %\n" taskVersionList
		
		for i = 1  to taskList.count do
		(
			if taskVersionList[i].count > 0 then
			(
				maxTask = taskList[i]
				maxTaskVers = amax taskVersionList[i]
			)
		)
-- 		format "maxTask: % maxTaskVers: %\n"  maxTask maxTaskVers
		
-- 		format "maxTask:% maxTaskVers:%\n" maxTask maxTaskVers
		
		if maxTask == "without" then
		(
			lastFilename = cleanFilename(assetFolder + "\\" + (returnDigit maxTaskVers) + "\\" + assetName + ".max")
		)
		else
		(
			lastFilename = cleanFilename(assetFolder + "\\" + assetName + "." + maxTask + "." + (returnDigit maxTaskVers)  + ".max")
		)
		
		lastFilename
-- 		format "lastFilename:% \n" lastFilename 
		
	),
	
	
	fn getNextPublishFilename oneTask oneVers =
	(
		local nextPublishFilename
		
		if oneTask == "without" then
		(
			nextPublishFilename = cleanFilename((getAssetFolder ()) + "\\" + (returnDigit oneVers) + "\\" + assetName + ".max")
		)
		else
		(
			nextPublishFilename  =  cleanFilename((getAssetFolder ()) + "\\" + assetName + "." + oneTask + "." + (returnDigit oneVers) + ".max")
		)
		
		nextPublishFilename
	),
	/*
	fn getWipFilename  oneTask oneVers = 
	(
		local wipFile
		if oneTask == "without" then
		(
			wipFile = getWipFile()
		)
		else
		(
			wipFile = cleanFilename((getAssetFolder ()) + "\\" + assetName + "." + oneTask + "." + (returnDigit oneVers) + ".wip.001.max")
		)
		wipFile
	),
	*/
	
	fn getNextWipFilename  oneTask oneVers = 
	(
		local nextWipFileName
		
		if oneTask == "without" then
		(
			--
			local wipVers = 1
			local search = cleanFilename((getAssetFolder ()) + "\\" + "wip" + "\\" + assetName +"." + (returnDigit oneVers) + ".wip.*.max")
			local existantsFiles = getfiles search
			-- decompte du nombre de fichiers existants
				
			-- decompte du nombre maximum
				-- recuperer le nom de filename
				-- filter ".wip."
				-- le deuxieme membre de l'asset est la version de wip
			
			nextWipFileName = cleanFilename((getAssetFolder ()) +  "\\" + assetName +"." + (returnDigit oneVers) + ".wip." + (returnDigit wipVers) + ".max")

		)
		else
		(
			nextWipFileName = cleanFilename((getAssetFolder ()) + "\\" + assetName + "." + oneTask + "." + (returnDigit oneVers) + ".wip.001.max")
		)
		
		if doesfileexist nextWipFileName then
		(
			-- decompte le nombre de fichier wip ou increment et test?
		)
		nextWipFileName
	),
	
	fn getLastWipFilename =
	(
		-- collecte des dossiers
		local dirArr = GetDirectories (assetFolder + "\\*")
		
		for d in dirArr do
		(
			join dirArr (getDirectories (d + "\\*"))
		)
		
		append dirArr (assetFolder + "\\")
		
		-- collecte des fichier max
		local maxVal = 0
		local lastestMax
		
		for dir in dirArr do
		(
			local fileArr = getFiles (dir + "*wip*.max")
-- 			format "fileArr: %\n" fileArr
			if fileArr.count > 0 do
			(
				for f in fileArr do
				(
-- 					format "f: % , filetime:%\n" f (filetime f)
					if (fileTime f) > maxVal then
					(
						lastestMax = f
						maxVal = fileTime f  
					)
				)
			)
		)
		
		format "latest wip file: %\n" lastestMax
		lastestMax
		
	),
	
	
	fn getEditableFileSelected oneTask oneVers =
	(
		local editFileRC 
		local assetFolder = getAssetFolder ()
		
		if oneTask == "without" then
		(
			editFileRC = cleanFilename((getAssetFolder ()) + "\\" + (returnDigit oneVers) + "\\" + assetName + ".max")
		)
		else
		(
			editFileRC = cleanFilename((getAssetFolder ()) + "\\" + assetName + "." + oneTask + "." + (returnDigit oneVers) + ".max")
		)
		
		if doesfileexist editFileRC then editFileRC else undefined
	),
	
	fn getLatestFile =
	(
		-- collecte des dossiers
		local dirArr = GetDirectories (assetFolder + "\\*")
		
		for d in dirArr do
		(
			join dirArr (getDirectories (d + "\\*"))
		)
		
		append dirArr (assetFolder + "\\")
-- 		for d in dirArr do format "dirArr: %\n" d

		-- collecte des fichier max
-- 		local maxFilesAr = #()
		local maxVal = 0
		local lastestMax
		
		for dir in dirArr do
		(
			local fileArr = getFiles (dir + "*.max")
			if fileArr.count> 0 do
			(
				for f in fileArr do
				(
-- 					format "f: % , filetime:%\n" f (filetime f)
					if (fileTime f) > maxVal then
					(
						lastestMax = f
						maxVal = fileTime f  
					)
				)
			)
		)
		lastestMax
	),
	
	fn createFolders =
	(
		versionFolder = makedir (getVersionFolder()) all: true
		format "version folder: %\n " versionFolder
		/*
		folderCreated = makedir (getWipFolder())
		format "wip folder: %\n" folderCreated
		
		folderCreated
			*/
		versionFolder
	),
	
	fn createAssetFileInfo =
	(
-- 		assetInfoIniFile = getAssetFolder() + "\\assetInfo.ini"
		local assetInfoIniFile = assetFolder + "\\assetInfo.ini"
		
		setINISetting assetInfoIniFile "assetProperties" "assetName" assetName
		setINISetting assetInfoIniFile "assetProperties" "version" (version as string)
	),
	
	/*
	fn createVersionFileInfo =
	(
		versionInfoIniFile =  assetFolder +  "\\" + (returnDigit version) + "\\versionInfo.ini"
		
		setINISetting versionInfoIniFile "assetProperties" "name" assetName
		setINISetting versionInfoIniFile "assetProperties" "lastVersion" (version as string)
		setINISetting versionInfoIniFile "assetProperties" "status" status
	),
	*/
	
	fn updateAssetFileInfo =
	(
		setINIsetting assetInfo "assetProperties" "version" (lastVersion as string)
	),
	
	fn createAssetFromScene maxVers task: "without" taskVersion: 0 =
	(
		local newfilename = getNextPublishFilename task taskversion
		makedir  (getFilenamePath newfilename) all: true
			
		local saved = saveMaxFile newfilename useNewFile: false saveAsVersion: maxVers
		
		if saved then createAssetFileInfo()
		format "file saved: %\n" newfilename
		newfilename
	),
	
	fn createAssetFromSel task: "without" taskversion: 0 =
	(
		local newfilename = getNextPublishFilename task taskversion
		makedir  (getFilenamePath newfilename) all: true
		
		saveNodes objs newfilename 
		
		if doesfileexist newfilename then createAssetFileInfo()
		format "file saved: %\n" newfilename
		newfilename
		
		/*
		res = createFolders()
		if res == true then
		(
			newFile = getLastVersionFile()
-- 			print newFile
			saveNodes objs newFile
			if doesfileexist newFile then
			(
				createAssetFileInfo()
-- 				createVersionFileInfo()
				format "New Asset Created: %\n"	newFile	
			)
		)
		else format "folders are not existing\n"
		*/
	),
	
	fn publishNewVersion maxVers task: "without" taskversion: 0 =
	(
		local newfilename = getNextPublishFilename task taskversion
		makedir  (getFilenamePath newfilename) all: true
			
		local saved = saveMaxFile newfilename useNewFile: false saveAsVersion: maxVers
		
		if saved then createAssetFileInfo()
		format "file saved: %\n" newfilename

		if saved then
		(
-- 			format "lastVersion: %, version: %\n" lastVersion version
			lastVersion +=  1
-- 			format "lastVersion: %, version: %\n" lastVersion version
-- 			print "check1"
			-- update asset info file
-- 			updateAssetFileInfo()
			createAssetFileInfo()
-- 			print "check1.5"
		)
		else
		(
-- 			delete folder si echec
		)

		newfilename
		
	),
	
	fn createWipFile2 oneTask oneVers =
	(		
		local sourceTmp = getEditableFileSelected oneTask oneVers
		local destTmp
		
		if doesfileexist sourceTmp then
		(
			destTmp = getNextWipFilename oneTask oneVers
		)
		
		copyFile sourceTmp destTmp
		
		destTmp
	),
		
	fn getMaxFileVersion = 
	(
		local maxVers
		res = getMaxFileVersionData (getLastVersionFile2())
		
		if res[1] == 14000 then maxVers = "2012"
		else if res[1] == 15000 then maxVers = "2013"
		else if res[1] == 16000 then maxVers = "2014"
		else if res[1] == 17000 then maxVers = "2015"
		else if res[1] == 18000 then maxVers = "2016"
		else if res[1] == 19000 then maxVers = "2017"
		else maxVers = "unknow"
-- 		format "maxVers: %\n" maxVers
		maxVers
	),
	
	fn countInstNumInScene =
	(
		local instanceNumAr = #()
		local instanceCount = 0
		local maxNum = 0
		
		for h in helpers where getUserProp h "assetName" == assetName do
		(
			instanceCount +=1
			if instanceCount > maxNum then maxNum = instanceCount
	-- 		format "instanceCount: % \n"  instanceCount
			
			numTmp = getUserProp h "instanceNum" --  as integer
			
			if (classof numTmp) == integer then
			(
				if numTmp > maxNum then maxNum = numTmp
			)
		)
		format "maxNum: %\n" (maxNum)
		maxNum
	),
	
	fn mergeAsset3 mergeAsAsset: true ignoreVrSet: false ignoreCacheLay: false objsNameConflict: #AutoRenameDups \
	updateMaterials: #useSceneMtlDups instNum: 1 task: "without" taskversion: 0 =
	(
		
		local assetCtrl
		-- create asset point
		if mergeAsAsset then 
		(
			LM = layermanager
			local ctrlName = assetName + "_"+  (instNum as string) + "_CTRL"
			assetCtrl = point name: ctrlName size: 200
			assetsLayer = LM.getLayerFromName "assets_layer"
			
			if assetsLayer == undefined do assetsLayer = LM.newLayerFromName "assets_layer"
			
			assetsLayer.addnode assetCtrl
			
			-- tag de l'asset point
			setUserProp assetCtrl "asset" true
			
			setUserProp assetCtrl "assetfolder" assetFolder
			
			setUserProp assetCtrl "assetName"  assetName
			setUserProp assetCtrl "assetVersion" lastVersion
			
			setUserProp assetCtrl "instanceNum" instNum
			
			setUserProp assetCtrl "task" task
			setUserProp assetCtrl "taskVersion" taskversion
			
			format "instNum merge:%\n" instNum
		)
		
		local objsCountBef = objects.count
		--import
-- 		format "task: %, taskversion: %\n" task taskversion
		local f = getEditableFileSelected task taskVersion
		format "merge: %\n" f
-- 		f = getLastVersionFile2()
		mergeMAXFile f  updateMaterials  objsNameConflict -- #AutoRenameDups  -- #mergeDups -- #select
		
	--	collect objects import
		objsImpAr = #()
		if objects.count > objsCountBef do
		(
			objsImpAr = for i = (objsCountBef + 1) to objects.count collect objects[i]
		)
		
	-- actions sur les objets import�s
		for o in objsImpAr do
		(
			if not isValidNode o do continue
				
			-- rename des objets de l'asset
			o.name = substitutestring o.name (assetName + "_") ""
			o.name = substitutestring o.name ((instNum as string) + "_") ""
			
			o.name = assetName + "_" + (instNum as string) + "_" + o.name
			
			-- rename des layer
			
	-- 		o = getnodebyname str
			local deletion = false
			
			-- suppresion des elemets vray
			local belongToVrSet = false
			if classof o == vraysun or classof o == vrayplane or  classof o == targetcamera then belongToVrSet = true
			if ignoreVrSet and belongToVrSet  then deletion = true

			-- suppression des elements caches
			belongToCachLay = matchpattern o.layer.name pattern: "*cache_layer*"	
			if ignoreCacheLay and belongToCachLay then deletion = true
			
			-- parenter au ctrl asset
			if mergeAsAsset and  o.parent == undefined and not isGroupMember o then o.parent = assetCtrl
			else if mergeAsAsset and o.parent == undefined and isGroupHead o then o.parent = assetCtrl
			
			format "obj: %, deletion:%, parent:%\n" o.name deletion o.parent
			
			if deletion == true then delete o
		)
		assetCtrl		
	)
)


try(destroyDialog createAssetRLT)catch()
rollout createAssetRLT "create asset v3" 
(
	local armadasScriptsIni = (GetDir #maxData) + "armadasScriptsIni.ini"
-- 	vars
	local allAssetsFolder
	local root
	
	local rltAssetFolder
	local rltAssetName
	
	
-- 	local assetPath = @"\\ELVIS\_svn\zz_ressources3D"
	local newAsset
	
	local mode
	
	local creationSanity = false
	local publishSanity = false
	
	local taskVersionList
	
	local changeAsset = true
	local changeTask = false
	
	group "parameters"
	(
		edittext pathET "base path:" readonly: true
		
		edittext nameET "name:" enabled: true
	
		
-- 		edittext statusET "status:" enabled: false across: 3
-- 		edittext commentET "comment:"  enabled: false
		dropdownlist maxVersDL "3ds max version:" items: #( "2015", "2017") selection: 2  across: 4
		dropdownlist taskDL "tasks:" items: taskList selection: 1 
		edittext versionET "next version:" enabled: false readonly: true
		dropdownlist taskVersionDL "task versions:" selection: 1 
		
	)
	
	group "asset sanity checking from scene:"
	(
-- 		button checkCreationBT "sanity check" 
		
		edittext correctNameET "correct name:" readonly: true across: 3
		edittext assetFolderCheckET "asset folder exists:" readonly: true
		edittext versionFolderCheckET "version folder exists:" readonly: true 
		edittext wipFolderCheckET "wip folder exists:" readonly: true across: 3
		edittext fileCheckET "file exists:" readonly: true 
		edittext assetFileInfoCheckET "asset info exists:" readonly: true
		edittext versionFileInfoCheckET "version info exists:" readonly: true
	)
	
	group "sanity diagnostic:"
	(
		edittext versResET"version file result:" readonly: true
		edittext wipResET"wip file result:" readonly: true
		edittext creationSanityET "creation ready" readonly: true across: 2
		edittext publishingSanityET "publishing ready" readonly: true
	)
	
	group "asset creation :"
	(
		checkbox useWipCB "use wip asset created" state: false across: 3 enabled: false
		button createAssetBT2 "create version" enabled: false 
	)
	
	-- functions ui dependant 
	-- check avant la creation d'assset
	fn checkCreationSanity newAsset =
	(
-- 		local creationSanity = false
		-- check name
		local correctName = false
		if newAsset.assetName.count > 0 then correctName = true else correctName = false
			
		-- check asset folder exists
		local assetFolderExists = doesfileexist (newAsset.assetFolder)
			
		-- check version folder exists
		local versionFolderExists = doesfileexist (newAsset.getVersionFolder())
				
		-- check version file exists
-- 		local versionFileExists = doesfileexist  (newAsset.getLastVersionFile())
			
		-- check asset info file exists
		local assetFileInfoExists = doesfileexist  (newAsset.assetFolder + "\\assetInfo.ini" )
		
		-- check version info file exists
		
		-- checking ui result
		correctNameET.text = correctName as string
		assetFolderCheckET.text = assetFolderExists as string
		versionFolderCheckET.text = versionFolderExists as string
		
		assetFileInfoCheckET.text = assetFileInfoExists as string
		fileCheckET.text = versionFileExists as string
		
		
		if correctName == true and assetFolderExists == false and versionFolderExists == false and assetFileInfoExists == false then
		(
			creationSanity = true
-- 			publishSanity = false
		)
		else 
		(
-- 			creationSanity = false
			creationSanity = true
-- 			publishSanity = true
		)		
	)
	
	-- check avant le publish
	fn refreshPublishRlt asset =
	(
		format "start publishing refresh\n"
		-- test if asset folder ready
		local nameOk = False
		local nextVersionPossible = true
		
		taskVersionList = asset.getMaxFilesCount2 ()
		format "taskVersionList: %\n" taskVersionList
		if taskVersionList == undefined then taskVersionList = for t in taskList collect #()
		format "taskVersionList: %\n" taskVersionList
		
		-- check asset info file exists
-- 		local assetFileInfoExists = doesfileexist (asset.assetInfo)
		local assetFileInfoExists = doesfileexist (asset.assetfolder +"//"+ "assetinfo.ini")
		
		-- COMPARE NOM	
		-- tester le nom de l'asset dans le pathname
		local pathAr = filterString  maxFilePath "\\"
		local assetNameID = finditem pathAr asset.assetName
		if assetNameID > 0 then nameOk = true	else ()
		
		-- COMPARE VERSION
		--  d�termine le nombre de version en comptant les dossiers
		local lastVersion = 0
		local folderVersion = False
		local assetFolders = getDirectories (asset.assetFolder + "\*")
		
		for f in assetFolders do
		(
			pathAr = filterString  f "\\"
			local versTest = (pathAr[pathAr.count] as integer)
			if  versTest != undefined  then 
			(
				folderVersion = True
				if versTest > lastVersion then lastVersion = versTest
			)
		)
		
		-- compare la version de l'asset determin� � partir du comptage des dossier asset la version d�termin� � partir du fichier ini	
		
		if folderVersion == true do
		(
			if asset.lastVersion == lastVersion then
			(
-- 				versionText = returnDigit (lastVersion + 1)
				nextVersionPossible = true
			)
		)
		
		format "assetFileInfoExists: % nameOk: % nextVersionPossible: %\n" assetFileInfoExists nameOk nextVersionPossible
		-- update du rollout
		if  assetFileInfoExists == true and	nameOk == true  and nextVersionPossible == true then
		(
			publishSanity = true
		)
		else publishSanity = false

		format "end publishing refresh\n"
	)
	
-- 	fn completeParam asset =
	fn RefreshUI =
	(
-- 		pathET.text = asset.basefolder
		pathET.text = newAsset.basefolder
		pathET.enabled = true
		
		nameET.text = newAsset.assetName
		nameET.enabled = true

		versionET.text = returnDigit newAsset.version
		versionET.enabled = true
		
		creationSanityET.text = creationSanity as string
		publishingSanityET.text = publishSanity as string
				
-- 		if publishSanity then nameET.readonly = true else nameET.readonly = false
		if creationSanity or publishSanity then
		(
			createAssetBT2.enabled = true
			useWipCB.enabled = true
		)
		else
		(
			createAssetBT2.enabled = true
			useWipCB.enabled = true
		)
		
	-- placer la version de task sur la derni�re version de tache publi� la plus haute
		
		if changeAsset then
		(
			for i = 1  to taskList.count do
			(
				if taskVersionList[i].count > 0 then
				(
					taskDL.selection = i
				)
			)
			changeAsset = false
		)
		
	-- 	refresh task version drop list number
		local id = finditem taskList taskDL.selected
		local newVersion
		
			
		-- init de la taskversionlist pour la creation d'asset	
		if taskVersionList != undefined then
		(			
			if taskVersionList[id].count == 0 then 
			(
				newVersion = 1
				newVersionStr = "1[NEW]"
			)
			else if taskVersionList[id].count > 0 then 
			(
				newVersion = (amax taskVersionList[id]) + 1
				newVersionStr = (newVersion as string) + "[NEW]"
			)
			else()
-- 			format "new version: %\n" newVersion
			
			local itemsList = #(newVersionStr)
			for i = taskVersionList[id].count to 1 by - 1 do append itemsList (taskVersionList[id][i] as string)
			taskVersionDL.items = itemsList
		)
		
		-- toujours afficher la derni�re version de tache au changement de tache
 		if changetask then 
		(
			taskVersionDL.selection = 1
			changetask = false
		)
		
		
		-- filenames
		
		if taskVersionDL.selection == 1 then 
		(
			versResET.text = newAsset.getNextPublishFilename  (taskDL.selected) (newVersion)
			wipResET.text = newAsset.getNextWipFilename (taskDL.selected) (newVersion)
		)
		else
		(
			versResET.text = newAsset.getNextPublishFilename  (taskDL.selected) (taskVersionDL.selected as integer)
			wipResET.text = newAsset.getNextWipFilename (taskDL.selected) (taskVersionDL.selected as integer)
		)
	)
	
	fn initForScene =
	(
		mode = 1
		createAssetBT2.caption = "create asset from scene"
		createAssetRLT.title = "create asset from scene"
		nameET.readonly = false
		
		local rootIni = getINISetting armadasScriptsIni "assetManager" "repositoryPath"
		
		if rootIni.count > 0 then
		(
			if doesfileexist rootIni == true then root = rootIni + "\\"
				
			newAsset = assetCreationClass()
			newAsset.initFromScene root
				
-- 			checkCreationSanity newAsset
			refreshPublishRlt newAsset
			RefreshUI()	
			format "newAsset: % \n" newAsset
		)
	)
	
	fn initForSelection =
	(
		mode = 2
		sel = selection as array
		
		-- UI
		createAssetBT2.caption = "create asset from selection"
		createAssetRLT.title = "create asset from selection"
		nameET.readonly = false
		
		local rootIni = getINISetting armadasScriptsIni "assetManager" "repositoryPath"
		
		if rootIni.count > 0 and sel.count > 0 then
		(
-- 			print "youpi!"
			if doesfileexist rootIni == true then root = rootIni + "\\"
			
			newAsset = assetCreationClass()
			newAsset.initFromSel sel root
-- 			print newAsset
			
			refreshPublishRlt newAsset
-- 			checkCreationSanity newAsset
			RefreshUI()	
			format "newAsset: % \n" newAsset
		)
	)
	
	fn initForPublishing =
	(
		mode = 3
		createAssetBT2.caption = "publish new asset version"
		createAssetRLT.title = "publish new asset version"
-- 		nameET.readonly = true
		
		-- check if we are in asset
		local infoTest = (getUpperFolder maxFilePath) + "assetInfo.ini"
		
		-- find assetInfo.ini file
		local res = doesfileexist infoTest 
		
		if not res then
		(
			infoTest = maxFilePath + "assetInfo.ini"
			res = doesfileexist infoTest 
		)
			
		local rootIni = getINISetting armadasScriptsIni "assetManager" "repositoryPath"
		
		if rootIni.count > 0 and res then
		(
-- 			if doesfileexist rootIni == true then root = rootIni + "\\"
				
			newAsset = assetCreationClass()
			newAsset.initFromIni infoTest --root
-- 			newAsset.version += 1
			
			refreshPublishRlt newAsset
			RefreshUI()		
-- 			checkCreationSanity newAsset
		)
		else 
		(
			if doesfileexist rootIni == true then root = rootIni + "\\"
			
			newAsset = assetCreationClass()
			newAsset.initFromScene root
				
-- 			checkCreationSanity newAsset
			refreshPublishRlt newAsset
			RefreshUI()	
		)
-- 		else (print "this is not an asset")
	)
	-- Actions
	
	fn initForPublishing2 =
	(
		-- methode d'initilisation globale
		mode = 0
		createAssetBT2.caption = "publish new asset version"
		createAssetRLT.title = "publish new asset version"
		
		newAsset = assetCreationClass()
		
		-- recherche du root (basefolder)
		local assetRepo
		local assetRepoRC = getINISetting armadasScriptsIni "assetManager" "repositoryPath"
		if doesfileexist assetRepoRC then assetRepo = assetRepoRC + "\\"
				
		-- recherche du fichier ini
		local assetInfo = (getUpperFolder maxFilePath) + "assetInfo.ini"
		if not (doesfileexist assetInfo) then assetInfo = maxFilePath + "assetInfo.ini"
		if not (doesfileexist assetInfo) then assetInfo = undefined
		
		-- 
		newAsset.objs =  selection as array
		
		if asseinfo != undefined then
		(
	--		get asset name from file ini
			local assetName = getINISetting iniFile "assetProperties" "name"
			if assetName.count == 0 then assetName = getINISetting iniFile "assetProperties" "assetName"
			
			newAsset.assetName = assetName
			newAsset.assetFolder = cleanFilename (getFilenamePath assetInfo)	
			newAsset.basefolder = getupperfolder (assetFolder) + "\\"
		)
		else
		(
			newAsset.basefolder = assetRepo + "\\"
			newAsset.assetName = getFilenameFile maxFileName
			newAsset.assetFolder = basefolder + assetName
		)
	)
	
	on createAssetRLT open do
	(
		if not assetEditorRLT.assetOp == undefined then
		(
			format "asset op: %\n" assetEditorRLT.assetOp
			if assetEditorRLT.assetOp == 1 then
			(
				initForScene()
			)
			else if assetEditorRLT.assetOp == 2 then
			(
				initForSelection ()
			)
			else if assetEditorRLT.assetOp == 3 then
			(
				initForPublishing ()
			)
			else()
		)
		else
		(
			format "assetOp error\n"
			try(destroyDialog createAssetRLT)catch()
		)
	)
	
	on nameET entered str do
	(
				
		local rootIni = getINISetting armadasScriptsIni "assetManager" "repositoryPath"
		
		if rootIni.count > 0 then 
		(
			if doesfileexist rootIni then root = rootIni + "\\"
		)
		
	
		if newAsset != undefined then
		(
			format "asset re-init start\n"
			newAsset.assetName =  str
			newAsset.basefolder =  root + "\\"
			newAsset.assetFolder =  newAsset.basefolder + newAsset.assetName
			
			-- tester le assetfile.ini
			local assetinfoFile = newAsset.assetFolder + "\\" + "assetInfo.ini"
			format "assetinfo.ini: % exist: %\n" assetinfoFile (doesfileexist assetinfoFile)
			if doesfileexist assetinfoFile then  newAsset.assetInfo = assetinfoFile else newAsset.assetInfo = undefined
			newAsset.publishInfo()
			
			changeAsset = true
			refreshPublishRlt newAsset
-- 			checkCreationSanity newAsset
			RefreshUI()
-- 			newAsset.publishInfo()
			format "asset re-init end\n"
		)
		format "newAsset: %\n" newAsset
	)
	
	on taskDL selected  val do
	(
		format "TAskDL.val: %\n" val
		format "taskVersionList[id]: %\n" taskVersionList[val]
		changeTask = true
		RefreshUI()
	)
	
	on taskVersionDL selected val do
	(
		RefreshUI()
	)
	
	on createAssetBT2 pressed do
	(
		-- recup�ration de la version de max
		local maxVers
		maxVers = maxVersDL.selected  as integer
		if maxVers == 2017 then maxVers = 0
		
		-- recup�ration de la version de la tache
		local taskVersionSelStr = taskVersionDL.selected
		taskVersionSelStr = substitutestring taskVersionSelStr "[NEW]" ""
		taskVersionSel = taskVersionSelStr as integer
		
		-- cr�ation du fichier
		if mode == 1 then
		(		
			newfile = newAsset.createAssetFromScene maxVers task: (taskDL.selected) taskVersion: taskVersionSel
		)
		else if mode == 2 then
		(
			newAsset.createAssetFromSel()
		)
		else if mode == 3 then 
		(
-- 			local maxVers			
			newfile = newAsset.publishNewVersion maxVers task: (taskDL.selected) taskVersion: taskVersionSel
		)
		
		if useWipCB.state then
		(
-- 			local wipFile = newAsset.createWipFile()
-- 			local wipFile = newAsset.createWipFile2 (taskDL.selected) (versionET.text as integer)
			local wipFile = newAsset.createWipFile2 (taskDL.selected) taskVersionSel
			if checkForSave() do loadMaxFile wipFile useFileUnits: true
		)
		
		format "asset creation done: %\n" newAsset.assetName
-- 		try rof.rollouts[2].refreshFromOutside() catch(format "*** % ***\n" (getCurrentException()))
		destroydialog createAssetRLT
	)
)
-- createdialog createAssetRLT width: 800

