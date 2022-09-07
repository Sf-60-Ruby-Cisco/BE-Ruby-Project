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