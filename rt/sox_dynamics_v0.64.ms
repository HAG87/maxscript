--������ : �̻��

-- �޸� $.params.btnPickPos.enabled = false

SoxLiveCrawlerCrossCa = attributes SoxLiveCrawlerCross
(
	parameters main rollout:params
	(
		vPairNodeIndex type:#integer animatable:false -- ���� ����Ű��  possible dependency loop �߻��ϹǷ� ��� ��� handle ��ȣ�� ����Ŵ
	)
		
	rollout params "Live Crawler"
	(
		button btnSelectPairObject "Select Pair OBJ" width:150
		
		on btnSelectPairObject pressed do
		(
			try (select (maxOps.getNodeByHandle vPairNodeIndex)) catch ()
		)
	)
)

SoxLiveCrawlerBoxCa = attributes SoxLiveCrawlerBox
(
	parameters main rollout:params
	(
		vPairNode type:#node
		vGroundNode type:#node ui:pickGroundObj
	)
		
	rollout params "Live Crawler"
	(
		button btnSelectPairObject "Select Pair OBJ" width:150
		group "Ground Object"
		(pickButton pickGroundObj "Pick Ground" width:150 autoDisplay:on)
		
		on pickGroundObj picked obj do
		(
			vPairNode.transform.controller.SetNode "Ground" obj
			vPairNode.transform.controller.Update()
		)
		
		on btnSelectPairObject pressed do
		(
			try (select vPairNode) catch ()
		)
	)
)

SoxHDTrackerUICa = attributes SoxHDTrackerUI
(
	parameters main rollout:params
	(
		vExecute type:#string
		vRangeOption type:#integer default:1 ui:radioRangeOption animatable:false
		vActionOption type:#integer default:1 ui:radioActionOption animatable:false
		vDelayThreshold type:#float default:0.001
		vTimeFrom type:#integer default:0 ui:spnTimeFrom animatable:false
		vTimeTo type:#integer default:100 ui:spnTimeTo animatable:false
		vPairNode type:#node
	)
		
	rollout params "HD. Tracker"
	(
		button btnSelectPairObject "Select Pair OBJ" width:150
		
		group "Option" (
		radiobuttons radioActionOption "Action Type" labels:#("Drag", "Delay") default:1 align:#left columns:2 offset:[0, -4]
		spinner spnDelayThreshold "Delay Threshold" range:[0.0, 1, 0.001] type:#float scale:0.0001 align:#left
		radiobuttons radioRangeOption "Time Range Option" labels:#("Slider Time", "Custom") default:1 align:#left columns:2 offset:[0, 4]
		spinner spnTimeFrom "From" range:[-99999, 99999, 0] type:#integer width:80 offset:[-8, 0] across:2
		spinner spnTimeTo "To" range:[-99999, 99999, 100] type:#integer width:70 offset:[-2, 0]
		)
		button btnRefresh "Refresh" width:150
		
		on btnSelectPairObject pressed do
		(
			try (select vPairNode) catch ()
		)
		
		on btnRefresh pressed do
		(
			$.vPairNode.transform = $.vPairNode.transform -- �̺�Ʈ �ڵ鷯�� Master ������ �ϴ� ����Ʈ ���۸� ���ڸ� �̵��ؼ� ������ �̺�Ʈ�� �߻���Ų��.
		)
		
		on radioActionOption changed var do
		(
			$.vPairNode.transform = $.vPairNode.transform -- �̺�Ʈ �ڵ鷯�� Master ������ �ϴ� ����Ʈ ���۸� ���ڸ� �̵��ؼ� ������ �̺�Ʈ�� �߻���Ų��.
		)
		
		on spnDelayThreshold changed var do
		(
			$.vPairNode.transform = $.vPairNode.transform -- �̺�Ʈ �ڵ鷯�� Master ������ �ϴ� ����Ʈ ���۸� ���ڸ� �̵��ؼ� ������ �̺�Ʈ�� �߻���Ų��.
		)
		
		on radioRangeOption changed var do
		(
			$.vPairNode.transform = $.vPairNode.transform -- �̺�Ʈ �ڵ鷯�� Master ������ �ϴ� ����Ʈ ���۸� ���ڸ� �̵��ؼ� ������ �̺�Ʈ�� �߻���Ų��.
		)
		
		on spnTimeFrom changed var do
		(
			$.vPairNode.transform = $.vPairNode.transform -- �̺�Ʈ �ڵ鷯�� Master ������ �ϴ� ����Ʈ ���۸� ���ڸ� �̵��ؼ� ������ �̺�Ʈ�� �߻���Ų��.
		)
		
		on spnTimeTo changed var do
		(
			$.vPairNode.transform = $.vPairNode.transform -- �̺�Ʈ �ڵ鷯�� Master ������ �ϴ� ����Ʈ ���۸� ���ڸ� �̵��ؼ� ������ �̺�Ʈ�� �߻���Ų��.
		)
	)
)

SoxHDTrackerCrossUICa = attributes SoxHDTrackerCrossUI
(
	parameters main rollout:params
	(
		vPairNodeIndex type:#integer animatable:false -- ���� ����Ű��  possible dependency loop �߻��ϹǷ� ��� ��� handle ��ȣ�� ����Ŵ
	)
		
	rollout params "HD. Tracker"
	(
		button btnSelectPairObject "Select Pair OBJ" width:150
		
		on btnSelectPairObject pressed do
		(
			try (select (maxOps.getNodeByHandle vPairNodeIndex)) catch ()
		)
	)
)


SoxRealtimeSpringCA = attributes SoxRealtimeSpring  -- ������ ���� ������Ʈ�� UI �Ķ����
(
	parameters main rollout:params
		(
			Tension type:#float ui:spnTension default:0.5
			Damping type:#float ui:spnDamping default:0.2
			vPairNode type:#node
		)

	rollout params "Live Spring"
		(
			button btnSelectPairObject "Select Pair OBJ" width:150
			spinner spnTension "Tension" type:#float scale:0.01 range:[0.0, 1.0, 0.5]
			spinner spnDamping "Damping" type:#float scale:0.01 range:[0.0, 1.0, 0.2]
			
			on btnSelectPairObject pressed do
			(
				try (select vPairNode) catch ()
			)
		)
)

SoxRealtimeSpringUICon = attributes SoxRealtimeSpringUICon -- ������ �ڽ� ������Ʈ�� UI
(
	parameters main rollout:params
	(
		vPairNodeIndex type:#integer animatable:false -- ���� ����Ű��  possible dependency loop �߻��ϹǷ� ��� ��� handle ��ȣ�� ����Ŵ
	)
	
	rollout params "Live Spring"
	(
		button btnSelectPairObject "Select Pair OBJ" width:150
		
		on btnSelectPairObject pressed do
		(
			try (select (maxOps.getNodeByHandle vPairNodeIndex)) catch ()
		)
	)
)

SoxRealtimeSpringCACon = attributes SoxRealtimeSpringCon -- ������ �ڽ� ������Ʈ ��Ʈ�ѷ��� �Ķ����
(
	parameters main
		(
			vPos type:#point3 default:[0, 0, 0] animatable:false
			vVec type:#point3 default:[0, 0, 0] animatable:false
			vTime type:#float default:0.0 animatable:false
		)
)

SoxTrackerCa = attributes SoxTracker
(
	parameters main
		(
			vPos type:#point3 default:[0, 0, 0] animatable:false
			vDist type:#float default:20.0
			vPairNode type:#node
			initPos type:#point3 default:[0, 0, 0] animatable:false
			initOnOff type:#boolean animatable:false
		)
)

SoxTrackerUiCa = attributes SoxTrackerUi
(
	parameters main rollout:params
	(
		Dist type:#float ui:spnDist default:20.0
-- 		pairNode type:#node
		initOnOff type:#boolean ui:chkbtnOnOff animatable:false
	)
	
	rollout params "Live Tracker"
		(
			local scriptTracker = "try (
if (normTime 0 == currentTime and this.SoxTracker.initOnOff == true)
then (tPos = (this.SoxTracker.initPos + this.SoxTracker.vPairNode.transform.pos);this.SoxTracker.vDist = length this.SoxTracker.initPos)
else (tPos = ((normalize (this.SoxTracker.vPos - TP.transform.pos)) * this.SoxTracker.vDist) + TP.transform.pos)
this.SoxTracker.vPos = tPos
tPos
) catch this.vPos"
			
			button btnSelectPairObject "Select Pair OBJ" width:150
			spinner spnDist "Distance" type:#float scale:0.1 range:[0.0, 999999.0, 20.0]
			pickbutton btnPickPos "Pick Position OBJ"
			group "Initial Position"
			(
				button btnSave "Save" width:60 toolTip:"Save current position as Initial Position" across:2
				checkbutton chkbtnOnOff "Activate" width:60 tooltip:"Activate Initial Position at Animation start"
			)
			
			on btnSelectPairObject pressed do
			(
				try (select $.pos.controller.vPairNode) catch ()
			)
			
			on btnSave pressed do
			(
				$.position.controller.initPos = $.pos - $.position.controller.vPairNode.transform.pos -- ��� ���κ��� ������� ��ġ�� ����ϵ��� �Ѵ�.
			)
			
			on chkbtnOnOff changed var do
			(
				$.position.controller.initOnOff = var -- UI���� ��ư ���¸� �ִϸ��̼� ��Ʈ�ѷ��� OnOff ������ ����ȭ ���ش�.
				-- ������ ��ũ��Ʈ ��Ʈ�ѷ������� �ڱ� �ڽ��� �����ϸ� ������� ������ �ɸ��Ƿ� this ��� �ڱ� �ڽ��� �ǹ��ϴ� ���� ���� �ڱ� �ڽ� ��Ʈ�ѷ��� ������ ����� Ŀ���� �Ķ���Ϳ��� ������ �����ϱ� ����
				if var then $.params.btnPickPos.enabled = false else $.params.btnPickPos.enabled = true
			)
			
			on spnDist changed var do
			(
				$.pos.controller.script  = scriptTracker
				
				$.position.controller.vDist = var -- Dist �� ����ȭ
				
			)
			
			on params open do
			(
				$.position.controller.vDist = Dist -- Dist �� ����ȭ
				if initOnOff then $.params.btnPickPos.enabled = false else $.params.btnPickPos.enabled = true
			)
			
			on btnPickPos picked obj do
			(
				$.pos.controller.SoxTracker.vPos = obj.transform.pos
				tDist = distance $.position.controller.vPairNode.transform.pos obj.transform.pos
				$.baseobject.Dist = tDist
				$.pos.controller.SoxTracker.vDist = tDist
				$.pos.controller.script  = scriptTracker
			)
		)
)

SoxDynamicsWheelCrossUiCa = attributes SoxDynamicsWheelCrossUi
(
	parameters main rollout:params
	(
		vPairNodeIndex type:#integer animatable:false -- ���� ����Ű��  possible dependency loop �߻��ϹǷ� ��� ��� handle ��ȣ�� ����Ŵ
	)
		
	rollout params "HD. Wheel"
	(
		button btnSelectPairObject "Select Pair OBJ" width:150
		
		on btnSelectPairObject pressed do
		(
			try (select (maxOps.getNodeByHandle vPairNodeIndex)) catch ()
		)
	)
)

SoxDynamicsWheelUiCa = attributes SoxDynamicsWheelUi
(
	parameters main rollout:params
	(
		vRangeOption type:#integer default:1 ui:radioRangeOption animatable:false
		vTimeFrom type:#integer default:0 ui:spnTimeFrom animatable:false
		vTimeTo type:#integer default:100 ui:spnTimeTo animatable:false
		vNode type:#node
		vPairNode  type:#node
		vRadius1 type:#float default:8.0 ui:spnRadius1
		vRadius2 type:#float default:10.0 ui:spnRadius2
	)
	
	rollout params "HD. Wheel"
	(
		button btnSelectPairObject "Select Pair OBJ" width:150
		
		spinner spnRadius1 "Radius 1:" range:[0.001, 99999.0, 8.0] type:#float
		spinner spnRadius2 "Radius 2:" range:[0.001, 99999.0, 8.0] type:#float
		
		radiobuttons radioRangeOption "Time Range Option" labels:#("Slider Time", "Custom") default:1
		spinner spnTimeFrom "From" range:[-99999, 99999, 0] type:#integer width:80 offset:[-8, 0] across:2
		spinner spnTimeTo "To" range:[-99999, 99999, 100] type:#integer width:70 offset:[-2, 0]
		button btnRefresh "Refresh" width:150
		
		on btnSelectPairObject pressed do
		(
			try (select vPairNode) catch ()
		)
		
		on btnRefresh pressed do
		(
			$.vPairNode.transform = $.vPairNode.transform -- �̺�Ʈ �ڵ鷯�� Master ������ �ϴ� ����Ʈ ���۸� ���ڸ� �̵��ؼ� ������ �̺�Ʈ�� �߻���Ų��.
		)
		
		on radioRangeOption changed var do
		(
			$.vPairNode.transform = $.vPairNode.transform -- �̺�Ʈ �ڵ鷯�� Master ������ �ϴ� ����Ʈ ���۸� ���ڸ� �̵��ؼ� ������ �̺�Ʈ�� �߻���Ų��.
		)
		
		on spnRadius1 changed var do
		(
			$.radius1 = var
			$.vPairNode.transform = $.vPairNode.transform -- �̺�Ʈ �ڵ鷯�� Master ������ �ϴ� ����Ʈ ���۸� ���ڸ� �̵��ؼ� ������ �̺�Ʈ�� �߻���Ų��.
		)
		
		on spnRadius2 changed var do
		(
			$.radius2 = var
			$.vPairNode.transform = $.vPairNode.transform -- �̺�Ʈ �ڵ鷯�� Master ������ �ϴ� ����Ʈ ���۸� ���ڸ� �̵��ؼ� ������ �̺�Ʈ�� �߻���Ų��.
		)
		
		on spnTimeFrom changed var do
		(
			$.vPairNode.transform = $.vPairNode.transform -- �̺�Ʈ �ڵ鷯�� Master ������ �ϴ� ����Ʈ ���۸� ���ڸ� �̵��ؼ� ������ �̺�Ʈ�� �߻���Ų��.
		)
		
		on spnTimeTo changed var do
		(
			$.vPairNode.transform = $.vPairNode.transform -- �̺�Ʈ �ڵ鷯�� Master ������ �ϴ� ����Ʈ ���۸� ���ڸ� �̵��ؼ� ������ �̺�Ʈ�� �߻���Ų��.
		)
	)
		
)

SoxDynamicsSusCrossUiCa = attributes SoxDynamicsSusCrossUi
(
	parameters main rollout:params
	(
		vPairNodeIndex type:#integer animatable:false -- ���� ����Ű��  possible dependency loop �߻��ϹǷ� ��� ��� handle ��ȣ�� ����Ŵ
	)
		
	rollout params "HD. Suspension"
	(
		button btnSelectPairObject "Select Pair OBJ" width:150
		
		on btnSelectPairObject pressed do
		(
			try (select (maxOps.getNodeByHandle vPairNodeIndex)) catch ()
		)
	)
)

SoxDynamicsSusUiCa = attributes SoxDynamicsSusUi
(
	parameters main rollout:params
	(
		vRangeOption type:#integer default:1 ui:radioRangeOption animatable:false
		vTimeFrom type:#integer default:0 ui:spnTimeFrom animatable:false
		vTimeTo type:#integer default:100 ui:spnTimeTo animatable:false
		vNode type:#node
		vPairNode  type:#node
		
		vHeight type:#float default:8.0 ui:spnHeight
		vTension type:#float default:0.5 ui:spnTension
		vDamping type:#float default:0.7 ui:spnDamping
		vGravity type:#float default:-0.2 ui:spnGravity
		vFlying type:#boolean default:true ui:chkFlying
	)
	
	rollout params "HD. Suspension"
	(
		button btnSelectPairObject "Select Pair OBJ" width:150
		
		spinner spnHeight "Height:" range:[0.001, 99999.0, 10.0] type:#float
		spinner spnTension "Tension:" range:[0.0, 5.0, 0.5] type:#float
		spinner spnDamping "Damping:" range:[0.0, 0.99999, 0.7] type:#float
		spinner spnGravity "Gravity:" range:[-99999.0, 0.0, -0.2] type:#float
		
		radiobuttons radioRangeOption "Time Range Option" labels:#("Slider Time", "Custom") default:1
		spinner spnTimeFrom "From" range:[-99999, 99999, 0] type:#integer width:80 offset:[-8, 0] across:2
		spinner spnTimeTo "To" range:[-99999, 99999, 100] type:#integer width:70 offset:[-2, 0]
		checkbutton chkFlying "Flying" width:150 enabled:false
		
		button btnRefresh "Refresh" width:150
		
		on btnSelectPairObject pressed do
		(
			try (select vPairNode) catch ()
		)
		
		on btnRefresh pressed do
		(
			$.vPairNode.transform = $.vPairNode.transform -- �̺�Ʈ �ڵ鷯�� Master ������ �ϴ� ����Ʈ ���۸� ���ڸ� �̵��ؼ� ������ �̺�Ʈ�� �߻���Ų��.
		)
		
		on radioRangeOption changed var do
		(
			$.vPairNode.transform = $.vPairNode.transform -- �̺�Ʈ �ڵ鷯�� Master ������ �ϴ� ����Ʈ ���۸� ���ڸ� �̵��ؼ� ������ �̺�Ʈ�� �߻���Ų��.
		)
		
		on spnHeight changed var do
		(
			$.height = var
			animate off ($.radius1 = var * 0.15;$.radius2 = var * 0.15)
			$.vPairNode.transform = $.vPairNode.transform -- �̺�Ʈ �ڵ鷯�� Master ������ �ϴ� ����Ʈ ���۸� ���ڸ� �̵��ؼ� ������ �̺�Ʈ�� �߻���Ų��.
		)
		
		on spnTension changed var do
		(
			$.vPairNode.transform = $.vPairNode.transform -- �̺�Ʈ �ڵ鷯�� Master ������ �ϴ� ����Ʈ ���۸� ���ڸ� �̵��ؼ� ������ �̺�Ʈ�� �߻���Ų��.
		)
		
		on spnDamping changed var do
		(
			$.vPairNode.transform = $.vPairNode.transform -- �̺�Ʈ �ڵ鷯�� Master ������ �ϴ� ����Ʈ ���۸� ���ڸ� �̵��ؼ� ������ �̺�Ʈ�� �߻���Ų��.
		)
		
		on spnGravity changed var do
		(
			$.vPairNode.transform = $.vPairNode.transform -- �̺�Ʈ �ڵ鷯�� Master ������ �ϴ� ����Ʈ ���۸� ���ڸ� �̵��ؼ� ������ �̺�Ʈ�� �߻���Ų��.
		)
		
		on spnTimeFrom changed var do
		(
			$.vPairNode.transform = $.vPairNode.transform -- �̺�Ʈ �ڵ鷯�� Master ������ �ϴ� ����Ʈ ���۸� ���ڸ� �̵��ؼ� ������ �̺�Ʈ�� �߻���Ų��.
		)
		
		on spnTimeTo changed var do
		(
			$.vPairNode.transform = $.vPairNode.transform -- �̺�Ʈ �ڵ鷯�� Master ������ �ϴ� ����Ʈ ���۸� ���ڸ� �̵��ؼ� ������ �̺�Ʈ�� �߻���Ų��.
		)
	)
		
)


try (destroydialog SOX_RealtimeSpring) catch()

rollout SOX_RealtimeSpring "SOX Dynamics v0.64" width:180
(
	button AboutButton "About" width:80 offset:[-5,0] height:14 across:2
	button site "Site" width:80 offset:[5,0] height:14
	progressBar dummyBar1 width:170 height:4 offset:[-8,0]
	
	button btnCreateSpring "Live Spring" width:80 offset:[-5,-2] across:2
	button btnCreateCrawler "Live Crawler" width:80 offset:[5, -2]
	
	button btnCreateTracker "Live Tracker" width:80 offset:[-5,0] across:2
	spinner spnTrackDist "Dist." range:[0.0, 999999.0, 20.0] width:80 offset:[-4,2]
	
	button btnCreateHDTracker "HD. Tracker" width:80 offset:[-5,0] across:2
	spinner spnHDTrackDist "Dist." range:[0.0, 999999.0, 20.0] width:80 offset:[-4,2]
	
	button btnCreateHDWheel "HD. Wheel" width:80 offset:[-5,0] across:2
	spinner spnHDWheelRad "Rad." range:[0.0001, 999999.0, 10.0] width:80 offset:[-4,2]
	
	button btnCreateHDSus "HD. Sus." width:80 offset:[-5,0] toolTip:"HD. Suspension with Gravity" across:2
	spinner spnHDSusHeight "Height" range:[0.0001, 999999.0, 10.0] width:88 offset:[-4,2]
	
	on btnCreateHDSus pressed do
	(
		if selection.count == 0 do return ()
		tObj = selection as array
		for o = 1 to tObj.count do
		(
			-- Wheel�� �����̼� Ʈ������ Ű�� �������� ������ �ߺ��ؼ� �ݹ��� �߻����� �ʵ��� �̵� ���ÿ� �ݹ� �߻��� ���� ����Ʈ ���۸� ���ؼ� ������
			tPointCross = Point pos:tObj[o].transform.pos isSelected:off Box:off cross:on axistripod:off centermarker:off size:((distance tObj[o].min tObj[o].max) * 0.6)
			tPointCross.wirecolor = color 216 255 0
			tPointCross.pos.controller = Position_Constraint ()
			tPointCross.pos.controller.appendTarget tObj[o] 50.0
			
			tSus = Helix radius1:(spnHDSusHeight.value * 0.15) radius2:(spnHDSusHeight.value * 0.15) height:(spnHDSusHeight.value * -1) turns:8 bias:0 direction:0 pos:tObj[o].transform.pos isSelected:on
			tSus.wirecolor = color 216 255 0
			tSus.pos.controller = Position_XYZ ()
			tSus.baseObject.height.controller = bezier_float () -- ������ �ִϸ��̼ǿ� height ���� ����Ʈ ��Ʈ�ѷ��� �����Ǿ����� ���� ���·� helix�� �����ȴ�.
			tSus.pos = (at time 0 tObj[o].transform.pos) + [0, 0, spnHDSusHeight.value]
			
			tCrossHandle = tPointCross.inode.handle
			tSusHandle = tSus.inode.handle
			
			CustAttributes.add tPointCross.baseObject SoxDynamicsSusCrossUiCa
			tPointCross.baseObject.vPairNodeIndex = tSus.inode.handle
			CustAttributes.add tSus.baseObject SoxDynamicsSusUiCa
			tSus.baseObject.vPairNode = tPointCross
			tSus.baseObject.vNode = tObj[o]
			tSus.baseObject.vFlying.controller = boolean_float()
			
			-- �ݹ��� ����Ǹ鼭 ���� Position Constraint �θ� ������ Ȯ���� ��������Ѵ�. �ȱ׷��� �ݹ鿡 ���� �� �ݹ��� �߻��ϴ� ��Ƣ�� ���ɼ��� �����.
			-- �ݹ鿡 ���� Ű�� �������� ���ȿ��� ��� ������Ʈ�� ������ �ִ� ��Ұ� ���ٴ� �������� �����ϴ°� �ٶ�����
			tStringDo = "(if mouse.buttonStates[1] == false do (\ntNodeSus = maxOps.getNodeByHandle " + (tSusHandle as string)
			tStringDo += "\ntNodeCross = maxOps.getNodeByHandle " + (tCrossHandle as string)
			tStringDo += "\ndisableSceneRedraw()
	local tFrom
	local tTo
	
	tNodeSus.parent = undefined
	
	if tNodeSus.vRangeOption == 1 then (tFrom = ((normTime 0) as integer) / ticksPerFrame;tTo = ((normTime 1) as integer) / ticksPerFrame)
	else (tFrom = tNodeSus.vTimeFrom;tTo = tNodeSus.vTimeTo)

	if (tTo - tFrom) <= 0 do (tTo = tFrom + 1)

	deleteKeys tNodeSus.transform.controller.position.controller.keys #allKeys
	deleteKeys tNodeSus.baseObject.height.controller.keys #allKeys
	tPos = at time tFrom tNodeCross.transform.position
	tPos.z += tNodeSus.baseObject.vHeight
	animate on (
		at time tFrom (tNodeSus.transform.controller.position = tPos)
		at time tFrom (tNodeSus.baseObject.height = tNodeSus.baseObject.vHeight * -1)
	)
	
	local beforeForceZ = 0.0
	local beforePosZ = (at time tFrom tNodeCross.transform.position.z) + tNodeSus.baseObject.vHeight
	for o = (tFrom + 1) to tTo do
	(
		local tensionForce = ((at time (o - 1) (tNodeSus.transform.position.z - tNodeSus.baseObject.vHeight)) - (at time o tNodeCross.transform.position.z)) * -1 -- ������ ź��
		tensionForce = amax 0.0 tensionForce -- ���� ����ϴ� ���� �ɷ����� ����
		local newPosZ = (tensionForce * tNodeSus.baseObject.vTension) + beforePosZ + beforeForceZ + tNodeSus.baseObject.vGravity
		if newPosZ < (at time o tNodeCross.transform.position.z) do -- ��������� ������ �İ���ٸ� ������ ����ø��� �ø� ��ŭ ���͸� ���������
		(
			tKick = (at time o tNodeCross.transform.position.z) - newPosZ
			newPosZ += tKick
			tensionForce += tKick * tNodeSus.baseObject.vTension
		)
		
		local tPress = newPosZ - (at time o tNodeCross.transform.position.z)
		local finalHeight = (amin tPress tNodeSus.baseObject.vHeight) * -1
		
		animate on (
			at time o (tNodeSus.transform.controller.position = [tNodeCross.transform.pos.x, tNodeCross.transform.pos.y, newPosZ])
			at time o (tNodeSus.baseObject.height = finalHeight)
		)
		
		tDist = at time o (tNodeSus.transform.position.z - tNodeCross.transform.position.z)
		local stateFlying = if tDist > tNodeSus.baseObject.vHeight then true else false
		animate on (at time o tNodeSus.baseObject.vFlying = stateFlying)
		
		newDamping = amin tNodeSus.baseObject.vDamping (tNodeSus.baseObject.vDamping * (tensionForce / tNodeSus.baseObject.vHeight))
		-- �ټ��� �ִ� ��츸 ������ �۵��ϵ��� �ϱ� ���ؼ� ������ ���̰����� �븻������ �� �ټ� �ۼ�Ʈ�� �����ش�. �ᱹ �ټ��� ���� ���� ���� ���� ��ġ�� ��Ÿ���� �Ǵ� ����
		-- ������ ���� �հ� ���� ���� ��쿡�� �ټ� ������ ������ ���̸� �ξ� �پ�Ѵ� ���������� �ټ� ���� ���� �� �����Ƿ�
		-- tensionForce / tHeight �� ������ 1���� ū ��찡 ���� �� �ְ� ��������� ������ Kick �Ǵ� ���� ���Ŀ� ������������ ���� Damping ���� ������ ��찡 �ִ�.
		-- �̷� ���ܻ�Ȳ�� ����å���� � ��쿡�� newDamping ���� ���� tDamping ������ ���� ������ �ʵ��� ������ġ�� ������.

		beforeForceZ = (newPosZ - beforePosZ) * (1 - (amin 1.0 newDamping))
		beforePosZ = newPosZ
	)
		
	if tNodeSus.position.controller.keys[1].time != (tFrom as time) do (tNodeSus.position.controller.keys[1].selected = true;deleteKeys tNodeSus.position.controller.keys #selection)
	enableSceneRedraw()
))"
			tString = "when transform (maxOps.getNodeByHandle " + (tCrossHandle as string) + ") changes id:#SOXHDSus do " + tStringDo
			execute tString
			
-- 			print tString
			
			tPointCross.transform = tPointCross.transform -- �̺�Ʈ �ڵ鷯�� Master ������ �ϴ� ����Ʈ ���ۿ� ���ڸ� �������� �־ ������ �̺�Ʈ�� �ѹ� �߻���Ų��.
		)
	)
	
	on btnCreateHDWheel pressed do
	(
		if selection.count == 0 do return ()
		tObj = selection as array
		for o = 1 to tObj.count do
		(
			-- Wheel�� �����̼� Ʈ������ Ű�� �������� ������ �ߺ��ؼ� �ݹ��� �߻����� �ʵ��� �̵� ���ÿ� �ݹ� �߻��� ���� ����Ʈ ���۸� ���ؼ� ������
			tPointCross = Point pos:tObj[o].transform.pos isSelected:off Box:off cross:on axistripod:off centermarker:off size:((distance tObj[o].min tObj[o].max) * 0.8)
			tPointCross.wirecolor = color 28 149 177
			tPointCross.pos.controller = Position_Constraint ()
			tPointCross.pos.controller.appendTarget tObj[o] 50.0
			
			tStar = Star radius1:(spnHDWheelRad.value * 0.8) radius2:spnHDWheelRad.value fillet1:0 fillet2:0 numPoints:6 distort:0 pos:tObj[o].transform.pos isSelected:on
			tStar.wirecolor = color 28 149 177
			tStar.pos.controller = Position_Constraint ()
			tStar.pos.controller.appendTarget tObj[o] 50.0
			
			tCrossHandle = tPointCross.inode.handle
			tStarHandle = tStar.inode.handle
			
-- 			tPointBox.baseObject.vPairNode = tPointCross
-- 			tPointCross.baseObject.vPairNodeIndex = tPointBox.inode.handle
			
			CustAttributes.add tPointCross.baseObject SoxDynamicsWheelCrossUiCa
			tPointCross.baseObject.vPairNodeIndex = tStar.inode.handle
			CustAttributes.add tStar.baseObject SoxDynamicsWheelUiCa
			tStar.baseObject.vPairNode = tPointCross
			tStar.baseObject.vNode = tObj[o]
			
			-- �ݹ��� ����Ǹ鼭 ���� Position Constraint �θ� ������ Ȯ���� ��������Ѵ�. �ȱ׷��� �ݹ鿡 ���� �� �ݹ��� �߻��ϴ� ��Ƣ�� ���ɼ��� �����.
			-- �ݹ鿡 ���� Ű�� �������� ���ȿ��� ��� ������Ʈ�� ������ �ִ� ��Ұ� ���ٴ� �������� �����ϴ°� �ٶ�����
			tStringDo = "(if mouse.buttonStates[1] == false do (try(\ntNodeStar = maxOps.getNodeByHandle " + (tStarHandle as string)
			tStringDo += "\ntNodeCross = maxOps.getNodeByHandle " + (tCrossHandle as string)
			tStringDo += "\ndisableSceneRedraw()
	local tFrom
	local tTo
	
	tNodeStar.parent = undefined
	try (tNodeStar.pos.controller.deleteTarget 1) catch ()
	
	if tNodeStar.vRangeOption == 1 then (tFrom = ((normTime 0) as integer) / ticksPerFrame;tTo = ((normTime 1) as integer) / ticksPerFrame)
	else (tFrom = tNodeStar.vTimeFrom;tTo = tNodeStar.vTimeTo)

	if (tTo - tFrom) <= 0 do (tTo = tFrom + 1)

	tRot = at time tFrom tNodeCross.transform.controller.rotation.controller.z_rotation
	deleteKeys tNodeStar.transform.controller.rotation.controller.z_rotation.keys #allKeys
	animate on (at time tFrom (tNodeStar.transform.controller.rotation.controller.z_rotation = tRot))
	for o = (tFrom + 1) to tTo do
	(
		tPosBefore = at time (o - 1) tNodeCross.transform.position
		tPosNow = at time o tNodeCross.transform.position
		tRot += radToDeg ((distance tPosBefore tPosNow) / (amax (amax (at time o tNodeStar.baseObject.vRadius1) (at time o tNodeStar.baseObject.vRadius2)) 0.00001)) -- Avoid divide by Zero
		animate on (at time o (tNodeStar.transform.controller.rotation.controller.z_rotation = tRot))
	)
	if tNodeStar.transform.controller.rotation.controller.z_rotation.keys[1].time != (tFrom as time) do (tNodeStar.transform.controller.rotation.controller.z_rotation.keys[1].selected = true;deleteKeys tNodeStar.transform.controller.rotation.controller.z_rotation.keys #selection)
	tNodeStar.pos.controller.appendTarget tNodeStar.baseObject.vNode 50.0
	enableSceneRedraw()
) catch ()))"
			tString = "when transform (maxOps.getNodeByHandle " + (tCrossHandle as string) + ") changes id:#SOXHDWheel do " + tStringDo
			execute tString
			
			tPointCross.transform = tPointCross.transform -- �̺�Ʈ �ڵ鷯�� Master ������ �ϴ� ����Ʈ ���ۿ� ���ڸ� �������� �־ ������ �̺�Ʈ�� �ѹ� �߻���Ų��.
			select tStar
		)
	)

	on btnCreateHDTracker pressed do
	(
		if selection.count == 0 do return ()
		tObj = selection as array
		for o = 1 to tObj.count do
		(
			tPointCross = Point pos:tObj[o].transform.pos isSelected:off Box:off cross:on axistripod:off centermarker:off size:((distance tObj[o].min tObj[o].max) * 0.8)
			tPointCross.wirecolor = blue
			tPointCross.pos.controller = Position_Constraint ()
			tPointCross.pos.controller.appendTarget tObj[o] 50.0
			
			tPointBox = Point pos:tObj[o].transform.pos isSelected:off Box:on cross:off axistripod:off centermarker:off size:((distance tObj[o].min tObj[o].max) * 0.6)
			tPointBox.wirecolor = blue
			tPointBox.pos.controller = Position_XYZ () -- ����Ʈ ��Ʈ�ѷ��� ����Ǿ��������� �𸣹Ƿ� ������ XYZ�� Ȯ�λ��
			tPointBox.pos = (at time 0 tObj[o].transform.pos) + [spnHDTrackDist.value, 0, 0]
			
			tHandleCross = tPointCross.inode.handle -- execute�� ����� ��ũ��Ʈ �ؽ�Ʈ ��Ʈ���� ���Ե� ID ��ȣ
			tHandleBox = tPointBox.inode.handle -- execute�� ����� ��ũ��Ʈ �ؽ�Ʈ ��Ʈ���� ���Ե� ID ��ȣ
			
			CustAttributes.add tPointBox.baseobject SoxHDTrackerUICa
			tPointBox.baseObject.vPairNode = tPointCross
			
			CustAttributes.add tPointCross.baseobject SoxHDTrackerCrossUICa
			tPointCross.baseObject.vPairNodeIndex = tPointBox.inode.handle
			

			tStringDo = "(if mouse.buttonStates[1] == false do (try(\nlocal tNodeTP = maxOps.getNodeByHandle " + (tHandleCross as string)
			tStringDo += "\nlocal tNodeBox = maxOps.getNodeByHandle " + (tHandleBox as string)
			tStringDo += "\ndisableSceneRedraw()
	local tFrom
	local tTo
	tNodeBox.parent = undefined
	if tNodeBox.vRangeOption == 1 then (tFrom = ((normTime 0) as integer) / ticksPerFrame;tTo = ((normTime 1) as integer) / ticksPerFrame)
	else (tFrom = tNodeBox.vTimeFrom;tTo = tNodeBox.vTimeTo)
	if (tTo - tFrom) <= 0 do (tTo = tFrom + 1)
	
	case of
	(
		((tNodeBox.vActionOption) == 1):(
			local beforeVec = at time tFrom tNodeBox.transform.pos
			local tDist = distance beforeVec (at time tFrom tNodeTP.transform.pos)
			tPos = at time tFrom tNodeBox.transform.pos
			deleteKeys tNodeBox.position.controller.keys #allKeys
			tNodeBox.transform.controller.position = tPos
			animate on (at time tFrom (tNodeBox.transform.controller.position = tPos))
			for o = (tFrom + 1) to tTo do
			(
				tTPVec = at time o tNodeTP.transform.position
				tNewVec = ((normalize (beforeVec - tTPVec)) * tDist) + tTPVec
				animate on (at time o (tNodeBox.transform.controller.position = tNewVec))
				beforeVec = tNewVec
			)
		) -- case1 end
		((tNodeBox.vActionOption) == 2):(
				local tBeforeVec = at time tFrom tNodeTP.transform.pos
				for o = tFrom to tTo do
				(
					if tBeforeVec != (at time o tNodeTP.transform.pos) do (tFrom = o - 1; exit)
				)
				
				if tFrom >= tTo do tFrom = tTo - 1
				
				tPos = at time tFrom tNodeBox.transform.pos
				deleteKeys tNodeBox.position.controller.keys #allKeys
				tNodeBox.transform.controller.position = tPos
				animate on (at time tFrom tNodeBox.pos = ((at time tFrom tNodeTP.transform.pos) * 2) - (at time (tFrom + 1) tNodeTP.transform.pos))
				tBeforeVec = at time tFrom tNodeTP.transform.pos
				for o = (tFrom + 1) to tTo do
				(
					animate on (
						if (distance (at time o tNodeTP.transform.pos) (at time (o - 1) tNodeTP.transform.pos)) >= tNodeBox.vDelayThreshold then -- ���� ������ ��ġ�� ���� ��ġ�� �ٸ���, �� ��ȭ�� ������
						(
							at time o (tNodeBox.pos = (at time (o - 1) tNodeTP.transform.pos)) -- �� ������ ���� tNodeTP ��ġ�� ������
							tBeforeVec = at time (o - 1) tNodeTP.transform.pos -- ���������Ƿ� ���� ������ ����� ���� tBeforeVec�� ���� ��ġ�� ����
						)
						else -- ��ġ�� ���ų� ���� ����ؼ� ��ȭ�� ������
						(
							at time o (tNodeBox.pos = tBeforeVec)
						)
					)
				)
		) -- case2 end
	) -- case end
	if tNodeBox.position.controller.keys[1].time != (tFrom as time) do (tNodeBox.position.controller.keys[1].selected = true;deleteKeys tNodeBox.position.controller.keys #selection)
	enableSceneRedraw()
	) catch ()))"
			tString = "when transform (maxOps.getNodeByHandle " + (tHandleCross as string) + ") changes id:#SOXHDTracker do " + tStringDo
			execute tString
			
			tPointCross.transform = tPointCross.transform -- �̺�Ʈ �ڵ鷯�� Master ������ �ϴ� ����Ʈ ���ۿ� ���ڸ� �������� �־ ������ �̺�Ʈ�� �ѹ� �߻���Ų��.
			select tPointBox
		)
	)
	
	on btnCreateTracker pressed do
	(
		if selection.count == 0 do return ()
		tObj = selection as array
		for o = 1 to tObj.count do
		(
			tPointCross = Point pos:tObj[o].transform.pos isSelected:off Box:off cross:on axistripod:off centermarker:off size:((distance tObj[o].min tObj[o].max) * 0.8)
			tPointCross.pos += [spnTrackDist.value, 0, 0]
			tPointCross.wirecolor = red
			tPointCross.pos.controller = position_script ()
			
			CustAttributes.add tPointCross.pos.controller SoxTrackerCa
			CustAttributes.add tPointCross.baseobject SoxTrackerUiCa
			
			tPointCross.pos.controller.SoxTracker.vPos = tPointCross.pos
			tPointCross.pos.controller.AddNode "TP" tObj[o]
			
			local scriptTracker = "try (
if (normTime 0 == currentTime and this.SoxTracker.initOnOff == true)
then (tPos = (this.SoxTracker.initPos + this.SoxTracker.vPairNode.transform.pos);this.SoxTracker.vDist = length this.SoxTracker.initPos)
else (tPos = ((normalize (this.SoxTracker.vPos - TP.transform.pos)) * this.SoxTracker.vDist) + TP.transform.pos)
this.SoxTracker.vPos = tPos
tPos
) catch this.vPos"
			tPointCross.pos.controller.script  = scriptTracker
			tPointCross.baseobject.Dist = spnTrackDist.value
-- 			tPointCross.baseobject.pairNode = tObj[o] -- ¦�� ������Ʈ�� ����ϴ� �Ķ����
			tPointCross.position.controller.vPairNode = tObj[o] -- ¦�� ������Ʈ�� ��Ʈ�ѷ����� ����ϴ� �Ķ����
			
			select tPointCross
		)
	)
	
	on btnCreateCrawler pressed do
	(
		if selection.count == 0 do return ()
		
		local scriptSpring = "try(
	tRay = ray PBox.transform.pos (normalize (((transMatrix [0, 0, -1]) * PBox.transform).pos - PBox.transform.pos))
	tIntersect = intersectRay Ground tRay
	tPos = tIntersect.position
	tNorm = tIntersect.dir
) catch (
	try (
		tVecA = [-PBox.dir.x, -PBox.dir.y, -PBox.dir.z]
		tArc = acos(dot tVecA [0, 0, -1])
		tDist = (PBox.pos.z / sin (90.0 - tArc)) -- �밢�� ����
		tPos = (tVecA * tDist) + PBox.pos
		tNorm = [0, 0, 1]
		) catch (tPos = [0, 0, 0];tNorm = [0, 0, 1])
	)
pUp = [0, 1, 0]
pAt = tNorm + tPos
pEye = tPos
zaxis = normalize (pAt - pEye)
xaxis = normalize (cross pUp zaxis)
yaxis = cross zaxis xaxis
inverse (matrix3 [xaxis.x, yaxis.x, zaxis.x] [xaxis.y, yaxis.y, zaxis.y] [xaxis.z, yaxis.z, zaxis.z] [((dot xaxis pEye) * -1), ((dot yaxis pEye) * -1), ((dot zaxis pEye) * -1)])"
		
		tObj = selection as array
		for o = 1 to tObj.count do
		(
			tHelperSize = distance tObj[o].min tObj[o].max
			tPointCross = Point pos:tObj[o].transform.pos isSelected:off Box:off cross:on axistripod:off centermarker:off size:(tHelperSize * 0.1)
			tPointCross.wirecolor = color 245 0 255 -- pink
			tPointCross.transform.controller = transform_script ()
			
			tPointBox = Point pos:tObj[o].transform.pos isSelected:off Box:on cross:off axistripod:off centermarker:off size:(tHelperSize * 0.1)
			tPointBox.wirecolor = color 245 0 255 -- pink
			tPointBox.pos += [0, 0, (tObj[o].max.z + (tHelperSize * 0.2))]
			
			tPointCross.transform.controller.AddNode "PBox" tPointBox
			tPointCross.transform.controller.AddNode "Ground" tObj[o]
			tPointCross.transform.controller.script  = scriptSpring
				
			CustAttributes.add tPointCross.baseObject SoxLiveCrawlerCrossCa
			CustAttributes.add tPointBox.baseObject SoxLiveCrawlerBoxCa
			tPointBox.baseObject.vPairNode = tPointCross
			tPointBox.baseObject.vGroundNode = tObj[o]
			tPointCross.baseObject.vPairNodeIndex = tPointBox.inode.handle
			
			select tPointBox
		)
	)
	
	on btnCreateSpring pressed do
	(
		if selection.count == 0 do return ()
		
		local scriptSpring = "try (
tTime = timeStamp () / 30
diff = abs (tTime - this.vTime)
if diff >= 1 then (
this.vTime = tTime

tVec = (P.transform.pos - this.vPos) * PCross.Tension

tPos = this.vPos + tVec + this.vVec
this.vPos = tPos
this.vVec = (tVec + this.vVec) * (1.0 - PCross.Damping)

tPos
)
else this.vPos
) catch this.vPos"
		
		tObj = selection as array
		for o = 1 to tObj.count do
		(
			tPointCross = Point pos:tObj[o].transform.pos isSelected:off Box:off cross:on axistripod:off centermarker:off size:((distance tObj[o].min tObj[o].max) * 0.8)
			tPointCross.wirecolor = yellow
			tPointCross.pos.controller = Position_Constraint ()
			tPointCross.pos.controller.appendTarget tObj[o] 50.0
			
			CustAttributes.add tPointCross SoxRealtimeSpringCA
			
			tPointBox = Point pos:tObj[o].transform.pos isSelected:off Box:on cross:off axistripod:off centermarker:off size:((distance tObj[o].min tObj[o].max) * 0.6)
			tPointBox.wirecolor = yellow
			tPointBox.pos.controller = position_script ()

			CustAttributes.add tPointBox.pos.controller SoxRealtimeSpringCACon
			CustAttributes.add tPointBox.baseObject SoxRealtimeSpringUICon
			tPointBox.pos.controller.vPos = tObj[o].transform.pos
			tPointBox.pos.controller.AddNode "P" tObj[o]
			tPointBox.pos.controller.AddNode "PCross" tPointCross
			tPointBox.pos.controller.script  = scriptSpring
			
			tPointCross.baseObject.vPairNode = tPointBox -- ���� ���� ��带 ����Ų��.
			tPointBox.baseObject.vPairNodeIndex = tPointCross.inode.handle -- ���� ���� ��带 ����Ų��.
			
		)
	)
	
	on SOX_RealtimeSpring close do
	(

	)
	
	on SOX_RealtimeSpring open do
	(

	)
	
	on AboutButton pressed do
	(
		aboutText ="������ : �̻��

�� ���� ������ ������ �����ӽ��ϴ�.
������ ������� �������� �Ǹ��� �� ������ ������ ���� �ݵ�� �����ڸ� ǥ���ؾ� �մϴ�.

���� :
�����̴� ������Ʈ�� ������ ���¿��� Live Spring ��ư�� Ŭ���ϸ� ��� ���� ���� ���ۿ� �ڽ� ���۰� �����˴ϴ�. ���� ���۴� �ټǰ� ���� ���� �����ϴ� �����̰� �ڽ� ���۴� ������ �������� ����Ǵ� �����Դϴ�.

���� ������Ʈ�� ���õ� ���¿���Live Crawler ��ư�� ������ ������ �ڵ����� ���󰡴� ����Ʈ ���۰� �����˴ϴ�. �ڽ� ������ Crawler�� ���콺�� ������������.

Live Tracker ��ư�� Ư�� �Ÿ��� ������ �����ϴ� ���� ���� ����Ʈ ���۸� �����մϴ�.

HD. Tracker ��ư�� Ư�� �Ÿ��� ������ �����ϴ� ���� ���� ����Ʈ ���۸� �����ϴµ� History Dependant ������� �۵��˴ϴ�.

HD. Wheel ��ư�� �ڵ����� ���� ȸ���� ������ִ� ������Ʈ�� �����մϴ�. ������ Star ������Ʈ�� Z�� ȸ���� ���ϴ� ���� Wire Parameter�� �����غ�����.
Star ������Ʈ�� Radius1, Radius2 ���� �ڵ����� �� ū ���� �ν��մϴ�. ���� Radius ũ�⸦ �ִϸ��̼� �ص� �˴ϴ�(�������鼭 ������ ���� Ŀ���� ��).

��� ���̳��ͽ� ������Ʈ���� �ٸ� ������Ʈ�� �ڽ����� ��ũ�ϸ� �ȵ˴ϴ�(Live Crawler ����).

�ڼ��� ������ Site ��ư�� Ŭ���ؼ� ������ Ȩ�������� ������ Ʃ�͸����� �����ϼ���"
		messagebox aboutText
	)

	on site pressed do
	(
		shellLaunch "http://cafe.naver.com/pinksox/3470" ""
	)
)

createDialog SOX_RealtimeSpring style:#(#style_titlebar, #style_toolwindow, #style_sysmenu) lockWidth:true