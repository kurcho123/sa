local Ran = false
RegisterNetEvent("prdx_loading:disableLoading")
AddEventHandler("prdx_loading:disableLoading", function()
	if not Ran then
		ShutdownLoadingScreenNui()
		Ran = true
	end
end)