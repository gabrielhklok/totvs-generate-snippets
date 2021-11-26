#INCLUDE "protheus.ch"
#INCLUDE "fwmvcdef.ch"


User Function ${1:name}()
    Local oBrowse := Nil

    oBrowse := FwMBrowse():New()
    oBrowse:SetAlias("${2:alias1}")
    oBrowse:SetDescription("")
    oBrowse:SetMenuDef("${1:name}")
    oBrowse:ForceQuitButton()
    oBrowse:DisableDetails()
    oBrowse:Activate()
Return


Static Function MenuDef()
Return FwMvcMenu("${1:name}")


Static Function ModelDef()
    Local oStru${2:alias1} := FwFormStruct(1, "${2:alias1}")
    Local oStru$${3:alias2} := FwFormStruct(1, "$${3:alias2}")
    Local oModel := Nil

    oModel := MpFormModel():New("")

    oModel:AddFields("${2:alias1}MASTER",, oStru${2:alias1})
    oModel:AddGrid("${3:alias2}DETAIL", "${2:alias1}MASTER", oStru${3:alias2})

    oModel:SetRelation("${3:alias2}DETAIL", { ;
        {"FIELD_${2:alias1}", "FIELD_${3:alias2}"} ;
    }, ${3:alias2}->(IndexKey(1)))

    oModel:SetPrimaryKey({})

    oModel:SetDescription("")
    oModel:GetModel("${2:alias1}MASTER"):SetDescription("")
Return oModel


Static Function ViewDef()
    Local oStru${2:alias1} := FwFormStruct(2, "${2:alias1}")
    Local oStru${3:alias2} := FwFormStruct(2, "${3:alias2}")
    Local oModel := FwLoadModel("${1:name}")
    Local oView := Nil

    oView := FwFormView():New()
    oView:SetModel(oModel)

    oView:AddField("VIEW_${2:alias1}", oStru${2:alias1}, "${2:alias1}MASTER")
    oView:AddGrid("VIEW_${3:alias2}", oStru${3:alias2}, "${3:alias2}DETAIL")

    oView:CreateHorizontalBox("CABEC", 50)
    oView:CreateHorizontalBox("GRID", 50)

    oView:SetOwnerView("VIEW_${2:alias1}", "CABEC")
    oView:SetOwnerView("VIEW_${3:alias2}", "GRID")
Return oView
