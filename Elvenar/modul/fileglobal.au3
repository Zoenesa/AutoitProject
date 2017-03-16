#include-once

Global $imgPathResc = @ScriptDir & "\img\01Resource\"
Global $imgPathDoJob = @ScriptDir & "\img\02PilihJob\"
Global $imgPathMain = @ScriptDir & "\img\03Main\"
Global $imgPathMetal = @ScriptDir & "\img\04metal\"
Global $imgPathPlank = @ScriptDir & "\img\05plank\"
Global $imgPathMarble = @ScriptDir & "\img\06marble\"
Global $imgPathCrystal = @ScriptDir & "\img\07crystal\"
Global $imgPathGold = @ScriptDir & "\img\08Gold\"
Global $imgPathElixir = @ScriptDir & "\img\09Elixir\"
Global $imgPathGems = @ScriptDir & "\img\10Gems\"

Global $imgSrcBarrack = $imgPathMain & "Barracks.bmp"

Global $imgsrc1 = $imgPathResc & "resl.bmp"
Global $imgsrc2 = $imgPathResc & "resm.bmp"
Global $imgsrc3 = $imgPathResc & "ress.bmp"
Global $imgsrc4 = $imgPathResc & "resvar.bmp"

Global $imgsrc5 = $imgPathDoJob & "Beverage.bmp"
Global $imgsrc6 = $imgPathDoJob & "SimpleTool.bmp"
Global $imgsrc7 = $imgPathDoJob & "Bread.bmp"
Global $imgsrc8 = $imgPathDoJob & "advance.bmp"
Global $imgsrc9 = $imgPathDoJob & "Grocr.bmp"
Global $imgsrc10 = $imgPathDoJob & "toolbox.bmp"
Global $imgsrc11 = $imgPathDoJob & "3h.bmp"

Global $ArrayImgResc[4] = [$imgsrc1, $imgsrc2, $imgsrc3, $imgsrc4]

Global $ArrayPilihJob[7] = [$imgsrc5, $imgsrc6, $imgsrc7, $imgsrc8, $imgsrc9, $imgsrc10, $imgsrc11]

Global $imgsrc12 = $imgPathMain & "Zzl.bmp"
Global $imgsrc13 = $imgPathMain & "Zzm.bmp"
Global $imgsrc14 = $imgPathMain & "Zzs.bmp"
Global $imgsrc15 = $imgPathMain & "Zzvar.bmp"
Global $imgTutupWindow = $imgPathMain & "close.bmp"

Global $ArrayImgReadyJob[4] = [$imgsrc12, $imgsrc13, $imgsrc14, $imgsrc15]

Global $imgsrc16 = $imgPathGold & "goldl.bmp"
Global $imgsrc17 = $imgPathGold & "goldm.bmp"
Global $imgsrc18 = $imgPathGold & "golds.bmp"
Global $imgsrc19 = $imgPathGold & "goldvar.bmp"

Global $ArrayImgFindGold[4] = [$imgsrc16, $imgsrc17, $imgsrc18, $imgsrc19]

Global $imgsrc20 = $imgPathMetal & "metall.bmp"
Global $imgsrc21 = $imgPathMetal & "metalm.bmp"
Global $imgsrc22 = $imgPathMetal & "metals.bmp"
Global $imgsrc23 = $imgPathMetal & "metalvar.bmp"

Global $ArrayImgFindMetal[4] = [$imgsrc20, $imgsrc21, $imgsrc22, $imgsrc23]

Global $imgsrc24 = $imgPathPlank & "plankl.bmp"
Global $imgsrc25 = $imgPathPlank & "plankm.bmp"
Global $imgsrc26 = $imgPathPlank & "planks.bmp"
Global $imgsrc27 = $imgPathPlank & "plankvar.bmp"

Global $ArrayImgFindPlank[4] = [$imgsrc24, $imgsrc25, $imgsrc26, $imgsrc27]

Global $imgsrc28 = $imgPathMarble & "marblel.bmp"
Global $imgsrc29 = $imgPathMarble & "marblem.bmp"
Global $imgsrc30 = $imgPathMarble & "marbles.bmp"
Global $imgsrc31 = $imgPathMarble & "marblevar.bmp"

Global $ArrayImgFindMarble[4] = [$imgsrc28, $imgsrc29, $imgsrc30, $imgsrc31]

Global $imgsrc32 = $imgPathCrystal & "crysl.bmp"
Global $imgsrc33 = $imgPathCrystal & "crysm.bmp"
Global $imgsrc34 = $imgPathCrystal & "cryss.bmp"
Global $imgsrc35 = $imgPathCrystal & "crysvar.bmp"

Global $ArrayImgFindCrystal[4] = [$imgsrc32, $imgsrc33, $imgsrc34, $imgsrc35]

Global $imgsrc36 = $imgPathDoJob & "1h.bmp"
Global $imgsrc37 = $imgPathDoJob & "3h.bmp"
Global $imgsrc38 = $imgPathDoJob & "9h.bmp"
Global $imgsrc39 = $imgPathDoJob & "1d.bmp"

Global $ArrayImgAllResource[20] = [$imgsrc1, $imgsrc2, $imgsrc3, $imgsrc4, $imgsrc20, $imgsrc21, $imgsrc22, $imgsrc23, $imgsrc24, $imgsrc25, $imgsrc26, $imgsrc27, $imgsrc28, $imgsrc29, $imgsrc30, $imgsrc31, $imgsrc32, $imgsrc33, $imgsrc34, $imgsrc35]

Global $ArrayCariBarang[16] = [$imgsrc20, $imgsrc21, $imgsrc22, $imgsrc23, _
$imgsrc24, $imgsrc25, $imgsrc26, $imgsrc27, _
$imgsrc28, $imgsrc29, $imgsrc30, $imgsrc31, _
$imgsrc32, $imgsrc33, $imgsrc34, $imgsrc35]

Global $imgsrc40 = $imgPathCrystal & "Scroll.bmp"
Global $imgsrc41 = $imgPathCrystal & "Scroll2.bmp"
Global $imgsrc42 = $imgPathCrystal & "Scrollvar.bmp"
Global $imgsrc43 = $imgPathCrystal & "Scrollw.bmp"
Global $imgsrc44 = $imgPathCrystal & "Silk.bmp"
Global $imgsrc45 = $imgPathCrystal & "Silk2.bmp"
Global $imgsrc46 = $imgPathCrystal & "Silksm.bmp"
Global $imgsrc47 = $imgPathCrystal & "Silkvar.bmp"

Global $ArrayImgScroll[4] = [$imgsrc40, $imgsrc41, $imgsrc42, $imgsrc43]
Global $ArrayImgSilks[4] = [$imgsrc44, $imgsrc45, $imgsrc46, $imgsrc47]

Global $imgsrc48 = $imgPathElixir & "Elixirh.bmp"
Global $imgsrc49 = $imgPathElixir & "Elixirl.bmp"
Global $imgsrc50 = $imgPathElixir & "Elixirw.bmp"
Global $imgsrc51 = $imgPathElixir & "Elixirvar.bmp"

Global $ArrayImgElixir[4] = [$imgsrc48, $imgsrc49, $imgsrc50, $imgsrc51]

Global $imgsrc52 = $imgPathGems & "GemH.bmp"
Global $imgsrc53 = $imgPathGems & "GemH.bmp"
Global $imgsrc54 = $imgPathGems & "GemH.bmp"
Global $imgsrc55 = $imgPathGems & "GemH.bmp"

Global $ArrayImgGems[4] = [$imgsrc52, $imgsrc53, $imgsrc54, $imgsrc55]

Global $imgCity1 = @ScriptDir & "\img\03Main\World.bmp"
Global $imgCity2 = @ScriptDir & "\img\03Main\World2.bmp"
Global $imgCity3 = @ScriptDir & "\img\03Main\WorldTour.bmp"
Global $imgCity4 = @ScriptDir & "\img\03Main\WorldTour2.bmp"
Global $imgHome1 = @ScriptDir & "\img\03Main\Home.bmp"
Global $imgHome2 = @ScriptDir & "\img\03Main\Home2.bmp"
Global $imgHome3 = @ScriptDir & "\img\03Main\City.bmp"
Global $imgHome4 = @ScriptDir & "\img\03Main\City2.bmp"

Global $imgServer1 = $imgPathMain & "Arendyll.bmp"
Global $imgServer2 = $imgPathMain & "Felyndral.bmp"
Global $imgServer3 = $imgPathMain & "Winyandor.bmp"

Global $imgTVhwnd = $imgPathMain & "tvOK.bmp"
