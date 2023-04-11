Citizen.CreateThread(function()


RequestIpl("bam_vespmech_off_milo_")

	interiorID = GetInteriorAtCoords(-1589.1, -848.7, 11.38)
	
	
	if IsValidInterior(interiorID) then
	--EnableInteriorProp(interiorID, "bam_vespmech_office_01")		
	EnableInteriorProp(interiorID, "bam_vespmech_office_02")

	RefreshInterior(interiorID)
	
	end
	
end)
