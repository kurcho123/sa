(() => {
  // client/utils.ts
  var Delay = (ms) => new Promise((res) => setTimeout(res, ms));
  var playerId = PlayerId();
  var stateBagWrapper = async (bagKey, handler) => {
    return AddStateBagChangeHandler(bagKey, null, async (bagName, _key, value, _, replicated) => {
      const entNet = Number(bagName.replace("entity:", ""));
      const timeout = GetGameTimer() + 1500;
      while (!NetworkDoesEntityExistWithNetworkId(entNet)) {
        await Delay(0);
        if (timeout < GetGameTimer())
          return;
      }
      const veh = NetToVeh(entNet);
      const amOwner = NetworkGetEntityOwner(veh) == playerId;
      if (!amOwner && replicated || amOwner && !replicated)
        return;
      handler(NetToVeh(entNet), value);
    });
  };

  // shared/shared.ts
  var joaat = (key) => {
    const keyLowered = key.toLowerCase();
    const length = keyLowered.length;
    let hash, i;
    for (hash = i = 0; i < length; i++) {
      hash += keyLowered.charCodeAt(i);
      hash += hash << 10;
      hash ^= hash >>> 6;
    }
    hash += hash << 3;
    hash ^= hash >>> 11;
    hash += hash << 15;
    return Math.floor(hash << 0);
  };
  var debugLog = (msg) => {
    if (!Debug)
      return;
    console.log(msg);
  };
  var HornOverride = (/* @__PURE__ */ new Map()).set(joaat("firetruk"), "VEHICLES_HORNS_FIRETRUCK_WARNING");
  var PrimarySirenOverride = (/* @__PURE__ */ new Map()).set(joaat("firetruk"), "");
  var AddonAudioBanks = (/* @__PURE__ */ new Map()).set("dlcpack", "dlcsoundname");
  var Debug = true;

  // client/main.ts
  var curSirenSound = /* @__PURE__ */ new Map();
  var curSiren2Sound = /* @__PURE__ */ new Map();
  var curHornSound = /* @__PURE__ */ new Map();
  var exp = global.exports;
  exp("getAddonAudioBanks", () => AddonAudioBanks);
  exp("getCurSirenSound", () => curSirenSound);
  exp("getCurSiren2Sound", () => curSiren2Sound);
  exp("getCurHornSound", () => curHornSound);
  exp("getDebug", () => Debug);
  var getSoundBankForSound = (sound) => {
    for (const [key, value] of AddonAudioBanks) {
      if (typeof value === "string") {
        if (value === sound) {
          return key;
        }
      } else {
        for (let i = 1; i < value.length; i++) {
          if (value[i] === sound) {
            return key;
          }
        }
      }
    }
    return "";
  };
  var isAllowedSirens = (veh, ped) => GetPedInVehicleSeat(veh, -1) === ped && GetVehicleClass(veh) === 18 && !IsPedInAnyHeli(ped) && !IsPedInAnyPlane(ped);
  exp("isAllowedSirens", isAllowedSirens);
  var releaseSirenSound = (veh, soundId, isCleanup = false) => {
    if (isCleanup && (DoesEntityExist(veh) && !IsEntityDead(veh)))
      return;
    StopSound(soundId);
    ReleaseSoundId(soundId);
    curSirenSound.delete(veh);
  };
  exp("releaseSirenSound", releaseSirenSound);
  var releaseSiren2Sound = (veh, soundId, isCleanup = false) => {
    if (isCleanup && (DoesEntityExist(veh) && !IsEntityDead(veh)))
      return;
    StopSound(soundId);
    ReleaseSoundId(soundId);
    curSiren2Sound.delete(veh);
  };
  exp("releaseSiren2Sound", releaseSiren2Sound);
  var releaseHornSound = (veh, soundId, isCleanup = false) => {
    if (isCleanup && (DoesEntityExist(veh) && !IsEntityDead(veh)))
      return;
    StopSound(soundId);
    ReleaseSoundId(soundId);
    curHornSound.delete(veh);
  };
  exp("releaseHornSound", releaseHornSound);
  var restoreSiren = 0;
  RegisterCommand("+sirenModeHold", () => {
    const ped = PlayerPedId();
    const veh = GetVehiclePedIsIn(ped, false);
    if (!isAllowedSirens(veh, ped))
      return;
    const ent = Entity(veh).state;
    if ((ent.sirenOn || ent.siren2On) && ent.lightsOn)
      return;
    ent.set("sirenMode", 1, true);
  }, false);
  RegisterCommand("-sirenModeHold", () => {
    const ped = PlayerPedId();
    const veh = GetVehiclePedIsIn(ped, false);
    if (!isAllowedSirens(veh, ped))
      return;
    const ent = Entity(veh).state;
    ent.set("sirenMode", 0, true);
  }, false);
  RegisterKeyMapping("+sirenModeHold", "Hold this button to sound your emergency vehicle's siren", "keyboard", "R");
  RegisterCommand("sirenSoundCycle", () => {
    const ped = PlayerPedId();
    const veh = GetVehiclePedIsIn(ped, false);
    if (!isAllowedSirens(veh, ped))
      return;
    const ent = Entity(veh).state;
    if (!ent.lightsOn)
      return;
    let newSirenMode = (ent.sirenMode || 0) + 1;
    if (newSirenMode > 3) {
      newSirenMode = 1;
    }
    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true);
    ent.set("sirenOn", true, true);
    ent.set("sirenMode", newSirenMode, true);
  }, false);
  RegisterKeyMapping("sirenSoundCycle", "Cycle through your emergency vehicle's siren sounds whilst your emergency lights are on", "keyboard", "COMMA");
  RegisterCommand("sirenSoundOff", () => {
    const ped = PlayerPedId();
    const veh = GetVehiclePedIsIn(ped, false);
    if (!isAllowedSirens(veh, ped))
      return;
    const ent = Entity(veh).state;
    ent.set("sirenOn", false, true);
    ent.set("siren2On", false, true);
    ent.set("sirenMode", 0, true);
    ent.set("siren2Mode", 0, true);
  }, false);
  RegisterKeyMapping("sirenSoundOff", "Turn off your sirens after being toggled", "keyboard", "PERIOD");
  RegisterCommand("+hornHold", () => {
    const ped = PlayerPedId();
    const veh = GetVehiclePedIsIn(ped, false);
    if (!isAllowedSirens(veh, ped))
      return;
    const ent = Entity(veh).state;
    if (ent.horn)
      return;
    ent.set("horn", true, true);
    restoreSiren = ent.sirenMode;
    ent.set("sirenMode", 0, true);
  }, false);
  RegisterCommand("-hornHold", () => {
    const ped = PlayerPedId();
    const veh = GetVehiclePedIsIn(ped, false);
    if (!isAllowedSirens(veh, ped))
      return;
    const ent = Entity(veh).state;
    if (!ent.horn)
      return;
    ent.set("horn", false, true);
    ent.set("sirenMode", ent.lightsOn ? restoreSiren : 0, true);
    restoreSiren = 0;
  }, false);
  RegisterKeyMapping("+hornHold", "Hold this button to sound your vehicle's horn", "keyboard", "E");
  RegisterCommand("sirenSound2Cycle", () => {
    const ped = PlayerPedId();
    const veh = GetVehiclePedIsIn(ped, false);
    if (!isAllowedSirens(veh, ped))
      return;
    const ent = Entity(veh).state;
    let newSirenMode = (ent.siren2Mode || 0) + 1;
    const sounds = PrimarySirenOverride.get(GetEntityModel(veh)) || "";
    if (sounds === "string") {
      newSirenMode = 1;
    } else {
      if (newSirenMode > sounds.length) {
        newSirenMode = 1;
      }
    }
    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true);
    ent.set("siren2On", true, true);
    ent.set("siren2Mode", newSirenMode, true);
  }, false);
  RegisterKeyMapping("sirenSound2Cycle", "Cycle through your emergency vehicle's secondary siren sounds, this doesn't require your emergency lights to be on", "keyboard", "UP");
  RegisterCommand("sirenLightsToggle", () => {
    const ped = PlayerPedId();
    const veh = GetVehiclePedIsIn(ped, false);
    if (!isAllowedSirens(veh, ped))
      return;
    const ent = Entity(veh).state;
    PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", true);
    const curMode = ent.lightsOn;
    ent.set("lightsOn", !curMode, true);
    if (!curMode)
      return;
    ent.set("siren2On", false, true);
    ent.set("sirenOn", false, true);
    ent.set("sirenMode", 0, true);
  }, false);
  RegisterKeyMapping("sirenLightsToggle", "Toggle your emergency vehicle's siren lights", "keyboard", "Q");
  stateBagWrapper("horn", (ent, value) => {
    const relHornId = curHornSound.get(ent);
    if (relHornId !== void 0) {
      releaseHornSound(ent, relHornId);
      debugLog(`[horn] ${ent} has sound, releasing sound id ${relHornId}`);
    }
    ;
    if (!value)
      return;
    const soundId = GetSoundId();
    debugLog(`[horn] Setting sound id ${soundId} for ${ent}`);
    curHornSound.set(ent, soundId);
    const soundName = HornOverride.get(GetEntityModel(ent)) || "SIRENS_AIRHORN";
    PlaySoundFromEntity(soundId, soundName, ent, 0, false, 0);
  });
  stateBagWrapper("lightsOn", (ent, value) => {
    SetVehicleHasMutedSirens(ent, true);
    SetVehicleSiren(ent, value);
    debugLog(`[lights] ${ent} has sirens ${value ? "on" : "off"}`);
  });
  stateBagWrapper("sirenMode", (ent, soundMode) => {
    const relSoundId = curSirenSound.get(ent);
    if (relSoundId !== void 0) {
      releaseSirenSound(ent, relSoundId);
      debugLog(`[sirenMode] ${ent} has sound, releasing sound id ${relSoundId}`);
    }
    ;
    if (soundMode === 0)
      return;
    const soundId = GetSoundId();
    curSirenSound.set(ent, soundId);
    debugLog(`[sirenMode] Setting sound id ${soundId} for ${ent}`);
    switch (soundMode) {
      case 1: {
        PlaySoundFromEntity(soundId, "VEHICLES_HORNS_SIREN_1", ent, 0, false, 0);
        debugLog(`[sirenMode] playing sound 1 for ${ent} with sound id ${soundId}`);
        break;
      }
      case 2: {
        PlaySoundFromEntity(soundId, "VEHICLES_HORNS_SIREN_2", ent, 0, false, 0);
        debugLog(`[sirenMode] playing sound 2 for ${ent} with sound id ${soundId}`);
        break;
      }
      case 3: {
        PlaySoundFromEntity(soundId, "VEHICLES_HORNS_POLICE_WARNING", ent, 0, false, 0);
        debugLog(`[sirenMode] playing sound 3 for ${ent} with sound id ${soundId}`);
        break;
      }
      default: {
        releaseSirenSound(ent, soundId);
        debugLog(`[sirenMode] invalid soundMode sent to ${ent} with sound id ${soundId}, releasing sound`);
      }
    }
  });
  stateBagWrapper("siren2Mode", (ent, soundMode) => {
    const relSoundId = curSiren2Sound.get(ent);
    if (relSoundId !== void 0) {
      releaseSiren2Sound(ent, relSoundId);
      debugLog(`[siren2Mode] ${ent} has sound, releasing sound id ${relSoundId}`);
    }
    ;
    if (soundMode === 0)
      return;
    const soundId = GetSoundId();
    curSiren2Sound.set(ent, soundId);
    debugLog(`[siren2Mode] Setting sound id ${soundId} for ${ent}`);
    const sounds = PrimarySirenOverride.get(GetEntityModel(ent)) || "VEHICLES_HORNS_SIREN_1";
    if (typeof sounds === "string") {
      const soundBank = getSoundBankForSound(sounds);
      PlaySoundFromEntity(soundId, sounds, ent, soundBank !== "" ? soundBank : 0, false, 0);
      debugLog(`[siren2Mode] playing sound 1 for ${ent} with sound id ${soundId}`);
    } else {
      for (let i = 0; i < sounds.length; i++) {
        if (soundMode - 1 === i) {
          const soundBank = getSoundBankForSound(sounds[i]);
          PlaySoundFromEntity(soundId, sounds[i], ent, soundBank !== "" ? soundBank : 0, false, 0);
          debugLog(`[siren2Mode] playing sound ${i + 1} for ${ent} with sound id ${soundId}`);
          return;
        }
      }
      releaseSirenSound(ent, soundId);
      debugLog(`[siren2Mode] invalid soundMode sent to ${ent} with sound id ${soundId}, releasing sound`);
    }
  });
})();
