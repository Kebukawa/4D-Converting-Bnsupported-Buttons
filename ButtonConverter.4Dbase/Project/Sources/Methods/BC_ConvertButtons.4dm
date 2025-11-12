//%attributes = {"shared":true}

//mark: ホストデータベースのファイルパスを取得

//ソースのパス
var $sourcesPath : Text
$sourcesPath:=Folder:C1567(Get 4D folder:C485(Database folder:K5:14; *); fk platform path:K87:2).path+"Project/Sources/"

//Resourcesフォルダーのパス
var $resourcesPath : Text
$resourcesPath:=Folder:C1567(Get 4D folder:C485(Current resources folder:K5:16; *); fk platform path:K87:2).path

//変換ログファイル（最後の変換ログファイル）
var $logFile : 4D:C1709.File
$logFile:=Folder:C1567(Get 4D folder:C485(Logs folder:K5:19; *); fk platform path:K87:2).files().query("name = :1"; "Conversion @").orderBy("creationDate desc, creationTime desc").at(0)

If ($logFile=Null:C1517)
	ALERT:C41("変換ログファイルが見つかりませんでした")
	
	
	//mark:-
Else 
	
	//対象となるボタンを探すためのマップ
	$classInfo:=[\
		{name: "button-highlight"; properties: [{name: "customBackgroundPicture"}; {name: "focusable"}; {name: "imageHugsTitle"}; {name: "style"}; {name: "iconFrames"}; {name: "display"}]}; \
		{name: "button-offset"; properties: [{name: "customBackgroundPicture"}; {name: "focusable"}; {name: "imageHugsTitle"}; {name: "style"}; {name: "iconFrames"}; {name: "display"}; {name: "text"; value: ""}; {name: "borderStyle"; value: "solid"}]}\
		]
	$types:=[\
		"Highlight buttons are unsupported and converted as invisible buttons. You may consider using 3D buttons instead."; \
		"'Background offset' 3D button style is not supported."\
		]
	
	//mark: ボタン用CSS定義を準備
	
	var $cssFile : 4D:C1709.File
	$cssFile:=File:C1566($sourcesPath+"styleSheets.css")
	
	If ($cssFile.exists)
		
		//ホストのCSSをチェックする
		$cssText:=$cssFile.getText()
		$contain:=False:C215
		For each ($item; $classInfo)
			If ($cssText=("@"+$item.name+"@"))
				$contain:=True:C214
				break
			End if 
		End for each 
		If ($contain=False:C215)
			//ホストのCSSに必要なクラスがなかったとき
			$cssText:=File:C1566("/SOURCES/styleSheets.css").getText()
			var $fhandle : 4D:C1709.FileHandle
			$fhandle:=$cssFile.open("append")
			$fhandle.writeText($cssText)
		End if 
		
	Else 
		
		//ホストのCSSファイルが無いとき
		$cssText:=File:C1566("/SOURCES/styleSheets.css").getText()
		$cssFile.setText($cssText)
		
	End if 
	
	//mark: ボタン用SVGの準備
	
	var $resources : 4D:C1709.Folder
	$resources:=Folder:C1567($resourcesPath+"Images/ButtonSVGs/")
	If (Folder:C1567($resourcesPath+"Images/ButtonSVGs/").exists=False:C215)
		
		var $folder : 4D:C1709.Folder
		$folder:=Folder:C1567($resourcesPath+"Images/")
		If ($folder.exists=False:C215)
			$result:=$folder.create()
		End if 
		
		$result:=Folder:C1567("/RESOURCES/Images/ButtonSVGs/").copyTo(Folder:C1567($resourcesPath+"Images/"))
		
	End if 
	
	
	If ($logFile.exists)
		
		//ログファイルの内容をオブジェクトとして$logに読み込む
		$log:=JSON Parse:C1218($logFile.getText(); Is object:K8:27)
		
		//mark: 対象のボタンを探してリストにする
		var $list : Collection  //ボタンのリスト
		$list:=[]
		For each ($message; $log.messages.filter(Formula:C1597($types.includes($1.value.message))))
			$item:={}
			$item.type:=$types.indexOf($message.message)
			$item.formName:=$message.form
			$item.objectName:=$message.object
			$item.path:=Choose:C955($message.table#Null:C1517; $sourcesPath+"TableForms/"+String:C10($message.table)+"/"+$message.form+"/form.4DForm"; $sourcesPath+"Forms/"+$message.form+"/form.4DForm")
			$list.push($item)
		End for each 
		
		//mark: リストに基づいて変換
		For each ($item; $list)
			$formFile:=File:C1566($item.path)
			//フォームのソースをオブジェクトとして取り出す
			$form:=JSON Parse:C1218($formFile.getText(); Is object:K8:27)
			For each ($page; $form.pages)
				Case of 
					: ($page=Null:C1517)
						continue
					: ($page.objects[$item.objectName]=Null:C1517)
						continue
					Else 
						$object:=$page.objects[$item.objectName]
						//クラスの名前をセット
						$object.class:=$classInfo[$item.type].name
						//オブジェクトプロパティ設定
						For each ($property; $classInfo[$item.type].properties)
							If ($property.value=Null:C1517)
								OB REMOVE:C1226($object; $property.name)
							Else 
								$object[$property.name]:=$property.value
							End if 
						End for each 
						break
				End case 
			End for each 
			$formFile.setText(JSON Stringify:C1217($form; *))
		End for each 
	End if 
	
	ALERT:C41("変換終了しました。\r対象となったオブジェクトは"+String:C10($list.length)+"個ありました。")
	
End if 

