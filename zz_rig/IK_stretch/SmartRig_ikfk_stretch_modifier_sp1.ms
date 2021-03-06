-- maj: pr�voir le switch des influences
-- 	local stack_relais = $.modifiers["Attribute Holder"].stack_relais
-- faire un retour d'�tat sur le slider ik/fk
-- rajouter un snap ik>fk

	
-- getThisScriptFilename() 

	def = attributes transfertMod
	(
		parameters one 
		(
			stack_relais type:#nodetab tabSizeVariable:true 
-- 			stack_ikfk type:#stringtab tabSizeVariable: true
		)

		rollout tranfertFKIK "Animate FK/IK" 
		(
			
		-- 	UI
			
			slider transfertSL "Transfert FK/IK"  type:#float  ticks:5 range: [0,100,10]
			button selBT "Show Keys"

		-- 	events
			on tranfertFKIK open do
			(
				if stack_relais.count > 0 then
				(
					transfertSL.value = stack_relais[1].position.controller.weight[1]
				)
			)
			
			on transfertSL changed val do
			(
				for o in stack_relais do
				(
					o.position.controller.weight[1]  = val
					o.position.controller.weight[2]  = 100 - val
					
					o.rotation.controller.weight[1]  = val
					o.rotation.controller.weight[2]  = 100 - val
					
					if o.position.controller.weight[1] == 0 then  (o.position.controller.getnode 1).parent.ishidden = false  else  (o.position.controller.getnode 1).parent.ishidden = false
					if o.position.controller.weight[2] == 0 then  (o.position.controller.getnode 2).parent.ishidden = false else   (o.position.controller.getnode 2).parent.ishidden = false 
				)
			)
			
			on selBT  pressed do
			(
				selAr = for o in  $.modifiers[1].stack_relais collect o
				select selAr
			)

		)
		
		rollout manageFKIK "Debug FK/IK"
		(
			local curSel
			
			group "Gestion Liste"
			(
				listbox objToTransLB "Objets a transf�rer"
				pickbutton addObjBT "add" across: 2
				button delObjBT "del" 
	-- 			button printValBT "print value"
				button selObjBT "Sel" enabled: true across: 2
				button highLight "Hi" 
				
				pickbutton recupStackPB "r�cup�rer un stack_relais"
			)
			
			group "Gestion Contraintes"
			(
				listbox posConstLB "position IK/FK :" height: 3
				
				button delConstBT "del" across: 2 enabled: true
				button selConstBT "sel" enabled: true
				pickbutton addConstBT "add" across: 2 enabled: true
				button switchPosBT "switch"
				
				
				listbox rotConstLB "rotation IK/FK :" height: 3
				
				button delRotBT "del" across: 2 enabled: true
				button selRotBT "sel" enabled: true
				pickbutton addRotBT "add" across: 2 enabled: true
				button switchRotBT "switch"
				
				button snapRotBT "snap IK>FK" enabled: true

			)
			
			fn upConstListFN elt =
			(
				numPos =   stack_relais[elt].position.controller.getNumTargets () 
				posConstLB.items = for i = 1 to  numPos collect (stack_relais[elt].position.controller.getnode i).name
				
				numRot =   stack_relais[elt].rotation.controller.getNumTargets () 
				rotConstLB.items = for i = 1 to  numRot collect (stack_relais[elt].rotation.controller.getnode i).name
			)
			
	-- 	events
			on manageFKIK open do
			(
				if stack_relais.count > 0 then
				(
					objToTransLB.items = for o in stack_relais collect o.name
				)
			)
			
			on objToTransLB selected elt do
			(
				curSel = stack_relais[objToTransLB.selection]
-- 				print curSel
				upConstListFN elt

-- 				print s.position.controller.getNumTargets ()
			)
			
			on addObjBT picked obj do
			(
				append stack_relais obj
				objToTransLB.items = for o in stack_relais collect o.name
			)
			
			on delObjBT pressed do
			(
				deleteitem stack_relais objToTransLB.selection
				objToTransLB.items = for o in stack_relais collect o.name
			)
			
			on selObjBT pressed do 
			(
				select stack_relais[objToTransLB.selection]
			)
			
			on highLight pressed do
			(
				bakNode = $
				
				select stack_relais[objToTransLB.selection]
				redrawviews ()
				sleep 0.25
				select baknode
			)
			
			/*
			on printValBT pressed do
			(
				if stack_relais.count > 0 then
				(
					print stack_relais[1].position.controller.weight[1]
					transfertSL.value = stack_relais[1].position.controller.weight[1]
				)
			)		
			*/
			on recupStackPB picked obj do
			(
				stack_relais = obj.modifiers[1].stack_relais
				objToTransLB.items = for o in stack_relais collect o.name
			)
			
-- 			UI position constraint
			
			on  addConstBT picked obj do
			(
-- 				sel = stack_relais[objToTransLB.selection]
				nodePlus = obj
				
				curSel.position.controller.appendTarget  nodePlus 50
				
				upConstListFN objToTransLB.selection
			)
			
			on delConstBT pressed do
			(
-- 				sel = stack_relais[objToTransLB.selection]
				curSel.position.controller.deleteTarget posConstLB.selection
				
				upConstListFN objToTransLB.selection
			)
			
			on selConstBT pressed do
			(
-- 				sel = stack_relais[objToTransLB.selection]
				select (curSel.position.controller.getnode posConstLB.selection)
			)
			
			on switchPosBT pressed do
			(
-- 				sel = stack_relais[objToTransLB.selection]
				nodeOne = curSel.position.controller.getnode 1

				curSel.position.controller.deleteTarget 1

				curSel.position.controller.appendTarget  nodeOne 50
				
				upConstListFN objToTransLB.selection
			)
			
-- 			UI rotation constraint
			
			on addRotBT picked obj do
			(
				nodePlus = obj
				
				curSel.rotation.controller.appendTarget  nodePlus 50
				
				upConstListFN objToTransLB.selection
			)
			
			on delRotBT pressed do
			(
				curSel.rotation.controller.deleteTarget posConstLB.selection
				
				upConstListFN objToTransLB.selection
			)

			on selRotBT pressed do
			(
				select (curSel.position.controller.getnode posConstLB.selection)
			)
			
			on switchRotBT pressed do
			(
-- 				sel = stack_relais[objToTransLB.selection]
				nodeOne = curSel.rotation.controller.getnode 1

				curSel.rotation.controller.deleteTarget 1

				curSel.rotation.controller.appendTarget  nodeOne 50
				upConstListFN objToTransLB.selection
			)
			
			on snapRotBT pressed do
			(
				print (curSel.rotation.controller.getnode 1).rotation
				print (curSel.rotation.controller.getnode 2).rotation
				(curSel.rotation.controller.getnode 1).rotation = print (curSel.rotation.controller.getnode 2).rotation
				(curSel.rotation.controller.getnode 1).position = print (curSel.rotation.controller.getnode 2).position
			)

		)
		
		/*
		rollout manageRIGRLT "Manage Rig"
		(
			
			multilistbox ikfkMLB "IKFK liste:"
			button selEntityBT "Select" enabled: false
			
			on manageRIGRLT open do
			(
-- 				ikfkMLB.items = for o in stack_IKFK collect o
			)
			
			on selEntityBT pressed do
			(
				selAr = #()
				selAr = for o in  stack_IKFK do
				(
					append selAr ( execute "$" +  o)
				) 
				for o in selAr do print o
-- 				select selAr
-- 				print selAr
			)
		)
		*/
	)

myMod = emptymodifier name: "ikfk_transfert_bak"
custAttributes.add myMod def


try	
(
	try
	(
		bakStack = $.modifiers[1].stack_relais

		addmodifier $ myMod
		$.modifiers[1].stack_relais = bakStack
		
		try
		(
-- 			bakStackNodes = 
-- 			addmodifier $ myMod
			$.modifiers[1].stack_ikfk = $.modifiers[2].stack_ikfk
		)
		catch
		(
			print "pas de stack_ikfk"
		)
	)
	catch
	(
		addmodifier $ myMod
	)
	

)catch("erreur de selection")

-- ajout des parametres au modifier vide
-- select ctrPoint


-- $.modifiers[1].stack_ikfk

-- $.modifiers["Attribute Holder"].stack_relais
