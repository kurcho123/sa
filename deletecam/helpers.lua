--[[
private static void DrawEdgeMatrix(Vector3[][] linesCollection, int r, int g, int b, int a)
{
	foreach (var line in linesCollection)
	{
		float x1 = line[0].X;
		float y1 = line[0].Y;
		float z1 = line[0].Z;

		float x2 = line[1].X;
		float y2 = line[1].Y;
		float z2 = line[1].Z;

		DrawLine(x1, y1, z1, x2, y2, z2, r, g, b, a);
	}
}
]]
local function DrawEdgeMatrix(linesCollection, r, g, b, a)
	for _, line in ipairs(linesCollection) do
		DrawLine(line[1], line[2], r, g, b, a)
	end
end

--[[
private static void DrawPolyMatrix(Vector3[][] polyCollection, int r, int g, int b, int a)
{
	foreach (var poly in polyCollection)
	{
		float x1 = poly[0].X;
		float y1 = poly[0].Y;
		float z1 = poly[0].Z;

		float x2 = poly[1].X;
		float y2 = poly[1].Y;
		float z2 = poly[1].Z;

		float x3 = poly[2].X;
		float y3 = poly[2].Y;
		float z3 = poly[2].Z;
		DrawPoly(x1, y1, z1, x2, y2, z2, x3, y3, z3, r, g, b, a);
	}
}
]]
local function DrawPolyMatrix(polyCollection, r, g, b, a)
	for _, poly in ipairs(polyCollection) do
		DrawPoly(poly[1], poly[2], poly[3], r, g, b, a)
	end
end

--[[
private static Vector3[][] GetBoundingBoxEdgeMatrix(Vector3[] box)
{
	return new Vector3[12][]
	{
		new Vector3[2] { box[0], box[1] },
		new Vector3[2] { box[1], box[2] },
		new Vector3[2] { box[2], box[3] },
		new Vector3[2] { box[3], box[0] },

		new Vector3[2] { box[4], box[5] },
		new Vector3[2] { box[5], box[6] },
		new Vector3[2] { box[6], box[7] },
		new Vector3[2] { box[7], box[4] },

		new Vector3[2] { box[0], box[4] },
		new Vector3[2] { box[1], box[5] },
		new Vector3[2] { box[2], box[6] },
		new Vector3[2] { box[3], box[7] }
	};
}
]]
local function GetBoundingBoxEdgeMatrix(box)
	return {
		{box[1], box[2]},
		{box[2], box[3]},
		{box[3], box[4]},
		{box[4], box[1]},

		{box[5], box[6]},
		{box[6], box[7]},
		{box[7], box[8]},
		{box[8], box[5]},

		{box[1], box[5]},
		{box[2], box[6]},
		{box[3], box[7]},
		{box[4], box[8]},
	}
end

--[[
private static Vector3[][] GetBoundingBoxPolyMatrix(Vector3[] box)
{
	return new Vector3[12][]
	{
	new Vector3[3] { box[2], box[1], box[0] },
	new Vector3[3] { box[3], box[2], box[0] },

	new Vector3[3] { box[4], box[5], box[6] },
	new Vector3[3] { box[4], box[6], box[7] },

	new Vector3[3] { box[2], box[3], box[6] },
	new Vector3[3] { box[7], box[6], box[3] },

	new Vector3[3] { box[0], box[1], box[4] },
	new Vector3[3] { box[5], box[4], box[1] },

	new Vector3[3] { box[1], box[2], box[5] },
	new Vector3[3] { box[2], box[6], box[5] },

	new Vector3[3] { box[4], box[7], box[3] },
	new Vector3[3] { box[4], box[3], box[0] }
	};
}
]]
local function GetBoundingBoxPolyMatrix(box)
	return {
		{box[3], box[2], box[1]},
		{box[4], box[3], box[1]},
		
		{box[5], box[6], box[7]},
		{box[5], box[7], box[8]},

		{box[3], box[4], box[7]},
		{box[8], box[7], box[4]},

		{box[1], box[2], box[5]},
		{box[6], box[5], box[2]},

		{box[2], box[3], box[6]},
		{box[3], box[7], box[6]},

		{box[5], box[8], box[4]},
		{box[5], box[4], box[1]}
	}
end

--[[
private static void DrawBoundingBox(Vector3[] box, int r, int g, int b, int a)
{
	var polyMatrix = GetBoundingBoxPolyMatrix(box);
	var edgeMatrix = GetBoundingBoxEdgeMatrix(box);

	DrawPolyMatrix(polyMatrix, r, g, b, a);
	DrawEdgeMatrix(edgeMatrix, 255, 255, 255, 255);
}
]]
local function DrawBoundingBox(box, r, g, b, a)
	DrawPolyMatrix(GetBoundingBoxPolyMatrix(box), r, g, b, a)
	DrawEdgeMatrix(GetBoundingBoxEdgeMatrix(box), 255, 255, 255, 255)
end

--[[
internal static Vector3[] GetEntityBoundingBox(int entity)
{
	Vector3 min = Vector3.Zero;
	Vector3 max = Vector3.Zero;

	GetModelDimensions((uint)GetEntityModel(entity), ref min, ref max);
	//const float pad = 0f;
	const float pad = 0.001f;
	var retval = new Vector3[8]
	{
		// Bottom
		GetOffsetFromEntityInWorldCoords(entity, min.X - pad, min.Y - pad, min.Z - pad),
		GetOffsetFromEntityInWorldCoords(entity, max.X + pad, min.Y - pad, min.Z - pad),
		GetOffsetFromEntityInWorldCoords(entity, max.X + pad, max.Y + pad, min.Z - pad),
		GetOffsetFromEntityInWorldCoords(entity, min.X - pad, max.Y + pad, min.Z - pad),

		// Top
		GetOffsetFromEntityInWorldCoords(entity, min.X - pad, min.Y - pad, max.Z + pad),
		GetOffsetFromEntityInWorldCoords(entity, max.X + pad, min.Y - pad, max.Z + pad),
		GetOffsetFromEntityInWorldCoords(entity, max.X + pad, max.Y + pad, max.Z + pad),
		GetOffsetFromEntityInWorldCoords(entity, min.X - pad, max.Y + pad, max.Z + pad)
	};
	return retval;
}
]]
local function GetEntityBoundingBox(entity)
	local mMin = vec(0,0,0)
	local mMax = vec(0,0,0)
	
	mMin, mMax = GetModelDimensions(GetEntityModel(entity))
	local pad = 0.001
	return {
		-- Bottom
		GetOffsetFromEntityInWorldCoords(entity, mMin.x - pad, mMin.y - pad, mMin.z - pad),
		GetOffsetFromEntityInWorldCoords(entity, mMax.x + pad, mMin.y - pad, mMin.z - pad),
		GetOffsetFromEntityInWorldCoords(entity, mMax.x + pad, mMax.y + pad, mMin.z - pad),
		GetOffsetFromEntityInWorldCoords(entity, mMin.x - pad, mMax.y + pad, mMin.z - pad),

		-- Top
		GetOffsetFromEntityInWorldCoords(entity, mMin.x - pad, mMin.y - pad, mMax.z + pad),
		GetOffsetFromEntityInWorldCoords(entity, mMax.x + pad, mMin.y - pad, mMax.z + pad),
		GetOffsetFromEntityInWorldCoords(entity, mMax.x + pad, mMax.y + pad, mMax.z + pad),
		GetOffsetFromEntityInWorldCoords(entity, mMin.x - pad, mMax.y + pad, mMax.z + pad)
	} 
end

--[[
/// <summary>
/// Draws the bounding box for the entity with the provided rgba color.
/// </summary>
/// <param name="ent"></param>
/// <param name="r"></param>
/// <param name="g"></param>
/// <param name="b"></param>
/// <param name="a"></param>
public static void DrawEntityBoundingBox(Entity ent, int r, int g, int b, int a)
{
	var box = GetEntityBoundingBox(ent.Handle);
	DrawBoundingBox(box, r, g, b, a);
}
]]
function DrawEntityBoundingBox(ent, r, g, b, a)
	DrawBoundingBox(GetEntityBoundingBox(ent), r, g, b, a)
end

--[[
Active Entity control
Handles functions for selecting entities
]]
do
	local activeEntity = false
	local colors = {
		cannotTarget = {255, 0, 0, 70},
		ped = {255, 0, 255, 70},
		vehicle = {255, 255, 0, 70},
		object = {0, 255, 255, 70},
	}
	local activeColour = colors.object

	function setActiveEntity(entity)
		-- Skip if the entity is the same
		if activeEntity == tonumber(entity) then return end

		-- Change the colour dependant on the entity's type (if it's not an object)
		local entityType = GetEntityType(entity)
		if entityType == 1 then
			activeColour = colors.ped

			-- Show that a player's ped cannot be deleted
			if IsPedAPlayer(entity) then
				activeColour = colors.cannotTarget
			end
		elseif entityType == 2 then
			activeColour = colors.vehicle
		else
			-- Set the default entity colour
			activeColour = colors.object
		end
		
		-- Set the active entity
		activeEntity = tonumber(entity)
	end

	function clearActiveEntity()
		-- Clear the active colour and entity
		activeColour = colors.object
		activeEntity = false
	end

	function getActiveEntity()
		return activeEntity
	end

	function doEntityDraw()
		if activeEntity and activeEntity > 0 then
			--print(string.format("drawing entity %s of type %s", activeEntity, GetEntityType(activeEntity)))
			DrawEntityBoundingBox(activeEntity, activeColour[1], activeColour[2], activeColour[3], activeColour[4])
		end
	end
end

--[[
What am I looking at?
]]
function WhatAmILookingAt(dist)
    local camPos = GetGameplayCamCoords()
    local camRot = GetGameplayCamRot_2()
    local retz = camRot.z * 0.0174532924
    local retx = camRot.x * 0.0174532924
    local absx = math.abs(math.cos(retx))
    local rayEnd = (camPos + (vec((math.sin(retz) * absx) * -1, math.cos(retz) * absx, math.sin(retx)) * dist))

    local rayHandle = StartShapeTestRay(camPos.x, camPos.y, camPos.z, rayEnd.x, rayEnd.y, rayEnd.z, -1, PlayerPedId(), 7)
    return GetShapeTestResult(rayHandle)
end
