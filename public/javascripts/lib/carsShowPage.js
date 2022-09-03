if (addChargingBtn === undefined) {
    const addChargingBtn = document.getElementById("addChargingBtn");
    const showChargingsBtn = document.getElementById("showChargingsBtn");
    const chargingForm = document.getElementById("chargingForm");
    const chargingsContainer = document.getElementById("chargingsContainer");
}

var editActionButtons = [...document.getElementsByClassName("editAction")];

// 2 
if (addRepairBtn === undefined) {
    const addRepairBtn = document.getElementById("addRepairBtn");
    const showRepairsBtn = document.getElementById("showRepairsBtn");
    const repairsForm = document.getElementById("repairsForm");
    const repairsContainer = document.getElementById("repairsContainer");
}

var editRepairActionButtons = [...document.getElementsByClassName("editRepairAction")];

/// Show Edit Charging Form ///
editActionButtons.forEach(editBtn => {
    editBtn.addEventListener("click", (ev) => {
        ev.preventDefault();
        let chargingId = ev.target.id;
        let [brand_station, amount, date] = [...ev.target.parentNode.parentNode.children];

        chargingForm.querySelector('p[id="chargingFormHeader"]').textContent = "Editing Charging";
        setChargingFormFields(getChargingFormFields(chargingForm), params=[
            brand_station.textContent, amount.textContent, date.textContent, chargingId
        ])

        chargingForm.querySelector('button[id="createBtn"]').style.display = 'none';
        chargingForm.querySelector('button[id="updateBtn"]').style.display = 'block';
        chargingsContainer.style.display = 'none';
        chargingForm.style.display = 'block';

    })
})
/// Show Edit Repair  Form  ?///



/// Show Add Charging Form ///
addChargingBtn.addEventListener("click", (ev) => {
    ev.preventDefault();
    let chargingFormHeader = chargingForm.querySelector('p[id="chargingFormHeader"]')

    if (chargingForm.style.display == 'none' || chargingFormHeader.textContent == 'Editing Charging') {
        if (chargingFormHeader.textContent == 'Editing Charging') {
            chargingFormHeader.textContent = 'Add Charging';
            setChargingFormFields(getChargingFormFields(chargingForm));
            chargingForm.querySelector('button[id="createBtn"]').style.display = 'block';
            chargingForm.querySelector('button[id="updateBtn"]').style.display = 'none';
        }
        chargingForm.style.display = 'block';
        chargingsContainer.style.display = 'none';
        
    } else {
        chargingForm.style.display = 'none';
    }
});

/// Show Add Repair Form ///

addRepairBtn.addEventListener("click", (ev) => {
    ev.preventDefault();
    let repairFormHeader = repairForm.querySelector('p[id="repairFormHeader"]')

    if (repairForm.style.display == 'none' || repairFormHeader.textContent == 'Editing Repair') {
        if (repairFormHeader.textContent == 'Editing Repair') {
            repairFormHeader.textContent = 'Add Repair';
            setRepairFormFields(getRepairFormFields(repairForm));
            repairForm.querySelector('button[id="createrBtn"]').style.display = 'block';
            repairForm.querySelector('button[id="updaterBtn"]').style.display = 'none';
        }
        repairForm.style.display = 'block';
        repairsContainer.style.display = 'none';
        
    } else {
        repairForm.style.display = 'none';
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


/// Get&Set chargingForm Fields ///
function getChargingFormFields(chargingForm) {
    return [
            chargingForm.querySelector('input[name="brand_station"]'),
            chargingForm.querySelector('input[name="amount"]'),
            chargingForm.querySelector('input[name="date"]'),
            chargingForm.querySelector('input[name="id"]'),
        ]
}

function setChargingFormFields(fields_arr, params=[]) {
    console.log(fields_arr);
    if (params.length > 0) {
        fields_arr.forEach(function (field, idx) {
            field.value = params[idx];
        })
    } else {
        fields_arr.forEach(field => {
            field.value = '';
        })
    }
}
