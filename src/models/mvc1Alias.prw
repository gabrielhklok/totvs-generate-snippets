#INCLUDE "protheus.ch"
#INCLUDE "fwmvcdef.ch"


User Function ${1:name}()
    Local oBrowse := Nil

    oBrowse := FwMBrowse():New()
    oBrowse:SetAlias("${2:alias}")
    oBrowse:SetDescription("")
    oBrowse:SetMenuDef("${1:name}")
    oBrowse:ForceQuitButton()
    oBrowse:DisableDetails()
    oBrowse:Activate()
Return


Static Function MenuDef()
Return FwMvcMenu("${1:name}")


Static Function ModelDef()
    Local oStru${2:alias} := FwFormStruct(1, "${2:alias}")
    Local oModel := Nil

    oModel := MpFormModel():New("")
    oModel:AddFields("${2:alias}MASTER",, oStru${2:alias})
    oModel:SetPrimaryKey({})
    oModel:GetModel("${2:alias}MASTER"):SetDescription("")
Return oModel


Static Function ViewDef()
    Local oStru${2:alias} := FwFormStruct(2, "${2:alias}")
    Local oModel := FwLoadModel("${1:name}")
    Local oView := Nil

    oView := FwFormView():New()
    oView:SetModel(oModel)
    oView:AddField("VIEW_${2:alias}", oStru${2:alias}, "${2:alias}MASTER")
    oView:CreateHorizontalBox("FULL", 100)
    oView:SetOwnerView("VIEW_${2:alias}", "FULL")
Return oView
