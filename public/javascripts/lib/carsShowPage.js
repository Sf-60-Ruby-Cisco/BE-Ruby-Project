if (addChargingBtn === undefined) {
    const addChargingBtn = document.getElementById("addChargingBtn");
    const showTablesBtn = document.getElementById("showTablesBtn");
    const chargingForm = document.getElementById("chargingForm");
    const chargingsContainer = document.getElementById("chargingsContainer");
    const addRepairBtn = document.getElementById("addRepairBtn");
    const repairForm = document.getElementById("repairForm");
    const repairsContainer = document.getElementById("repairsContainer");
}

/// Show/Hide Tables ///
showTablesBtn.addEventListener("click", (ev) => {
    ev.preventDefault();

    if (chargingsContainer.style.display == 'none') {
        chargingsContainer.style.display = 'block';
        repairsContainer.style.display = 'block';
        hideForms();
    } else {
        hideTables();
    }
})

/// Show Add Repair Form ///
addRepairBtn.addEventListener("click", (ev) => {
  ev.preventDefault();

  if (repairForm.style.display == "none") {
    repairForm.style.display = "block";
    chargingForm.style.display = "none";
    hideTables();
  } else {
    repairForm.style.display = "none";
  }
});


/// Show Add Charging Form ///
addChargingBtn.addEventListener("click", (ev) => {
    ev.preventDefault();

    if (chargingForm.style.display == 'none') {
        chargingForm.style.display = 'block';
        repairForm.style.display = 'none';
    } else {
        chargingForm.style.display = 'none';
    }
});


function hideTables() {
    repairsContainer.style.display = "none";
    chargingsContainer.style.display = "none";
}

function hideForms() {
    repairForm.style.display = "none";
    chargingForm.style.display = "none";
}
