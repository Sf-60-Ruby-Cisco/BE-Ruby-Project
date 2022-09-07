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
