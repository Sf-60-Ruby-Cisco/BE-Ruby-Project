if (addChargingBtn === undefined) {
    const addChargingBtn = document.getElementById("addChargingBtn");
    const showChargingsBtn = document.getElementById("showChargingsBtn");
    const chargingForm = document.getElementById("chargingForm");
    const chargingsContainer = document.getElementById("chargingsContainer");
}

/// Show Add Charging Form ///
addChargingBtn.addEventListener("click", (ev) => {
    ev.preventDefault();

    if (chargingForm.style.display == 'none') {
        chargingForm.style.display = 'block';
        chargingsContainer.style.display = 'none';
    } else {
        chargingForm.style.display = 'none';
    }
});

/// Show Chargings Table ///
showChargingsBtn.addEventListener("click", (ev) => {
    ev.preventDefault();

    if (chargingsContainer.style.display == 'none') {
        chargingsContainer.style.display = 'block';
        chargingForm.style.display = 'none';
    } else {
        chargingsContainer.style.display = 'none';
    }
})

if (addRepairBtn === undefined) {
  const addRepairBtn = document.getElementById("addRepairBtn");
  const showRepairsBtn = document.getElementById("showRepairsBtn");
  const repairForm = document.getElementById("repairForm");
  const repairsContainer = document.getElementById("repairsContainer");
}

/// Show Add Repair Form ///
addRepairBtn.addEventListener("click", (ev) => {
  ev.preventDefault();

  if (repairForm.style.display == "none") {
    repairForm.style.display = "block";
    repairsContainer.style.display = "none";
  } else {
    repairForm.style.display = "none";
  }
});

/// Show Repairs Table ///
showRepairsBtn.addEventListener("click", (ev) => {
  ev.preventDefault();

  if (repairsContainer.style.display == "none") {
    repairsContainer.style.display = "block";
    repairForm.style.display = "none";
  } else {
    repairsContainer.style.display = "none";
  }
});
