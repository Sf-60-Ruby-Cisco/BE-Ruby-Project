function forRepairs() {
    if (addRepairBtn === undefined) {
        const addRepairBtn = document.getElementById("addRepairBtn");
        const showRepairsBtn = document.getElementById("showRepairsBtn");
        const repairForm = document.getElementById("repairForm");
        const repairsContainer = document.getElementById("repairsContainer");
    }
    
    var editRepairActionButtons = [...document.getElementsByClassName("editRepairAction")];

    /// Show Edit Repair  Form  ?///
    editRepairActionButtons.forEach(editBtn => {
        editBtn.addEventListener("click", (ev) => {
            ev.preventDefault();
            let repairId = ev.target.id;
            let [description, amount, date, actions] = [...ev.target.parentNode.parentNode.children]
            let invoiceImgLink = actions.querySelector('a[id="invoiceImgLink"]');

            repairForm.querySelector('p[id="repairFormHeader"]').textContent = "Editing Repair"

            params=[
                description.textContent, 
                amount.textContent.replace('$', ''), 
                date.textContent, 
                repairId
            ]

            if (invoiceImgLink) {
                // Push the link two times to match fields_arr.length and params.length in setFormFields
                params.push(invoiceImgLink.href, invoiceImgLink.href);

                repairForm.querySelector('#invoiceContainer').style.display = 'block';
            } else {
                repairForm.querySelector('#invoiceContainer').style.display = 'none';
            }
            
            // Reset the file field 
            repairForm.querySelector('input[id="repairFileField"]').value = '';

            setFormFields(getRepairFormFields(repairForm), params=params);
            repairForm.querySelector('button[id="createBtn"]').style.display = 'none';
            repairForm.querySelector('button[id="updateBtn"]').style.display = 'block';
            
            hideTables(ev);
            chargingForm.style.display = 'none';
            repairForm.style.display = 'block';
        })
    })

    /// Show Add Repair Form ///
    addRepairBtn.addEventListener("click", (ev) => {
        ev.preventDefault();
        let repairFormHeader = repairForm.querySelector('p[id="repairFormHeader"]')

        if (repairForm.style.display == 'none' || repairFormHeader.textContent == 'Editing Repair') {
            if (repairFormHeader.textContent == 'Editing Repair') {
                repairFormHeader.textContent = 'Add Repair';
                setFormFields(getRepairFormFields(repairForm));
                repairForm.querySelector('button[id="createBtn"]').style.display = 'block';
                repairForm.querySelector('button[id="updateBtn"]').style.display = 'none';
                repairForm.querySelector('#invoiceContainer').style.display = 'none';
            }
            // Reset the file field 
            repairForm.querySelector('input[id="repairFileField"]').value = '';

            chargingForm.style.display = 'none';
            hideTables(ev);
            repairForm.style.display = 'block';
        } else {
            repairForm.style.display = 'none';
        }
    });    

}


function forChargings() {
    if (addChargingBtn === undefined) {
        const addChargingBtn = document.getElementById("addChargingBtn");
        const showChargingsBtn = document.getElementById("showChargingsBtn");
        const chargingForm = document.getElementById("chargingForm");
        const chargingsContainer = document.getElementById("chargingsContainer");
    }
    
    var editActionButtons = [...document.getElementsByClassName("editAction")];

    /// Show Edit Charging Form ///
    editActionButtons.forEach(editBtn => {
        editBtn.addEventListener("click", (ev) => {
            ev.preventDefault();
            let chargingId = ev.target.id;
            let [brand_station, amount, date] = [...ev.target.parentNode.parentNode.children];

            chargingForm.querySelector('p[id="chargingFormHeader"]').textContent = "Editing Charging";
            setFormFields(getChargingFormFields(chargingForm), params=[
                brand_station.textContent, amount.textContent.replace('$', ''), date.textContent, chargingId
            ])

            chargingForm.querySelector('button[id="createBtn"]').style.display = 'none';
            chargingForm.querySelector('button[id="updateBtn"]').style.display = 'block';

            hideTables(ev);
            repairForm.style.display = 'none';
            chargingForm.style.display = 'block';

        })
    })

    /// Show Add Charging Form ///
    addChargingBtn.addEventListener("click", (ev) => {
        ev.preventDefault();
        let chargingFormHeader = chargingForm.querySelector('p[id="chargingFormHeader"]')

        if (chargingForm.style.display == 'none' || chargingFormHeader.textContent == 'Editing Charging') {
            if (chargingFormHeader.textContent == 'Editing Charging') {
                chargingFormHeader.textContent = 'Add Charging';
                setFormFields(getChargingFormFields(chargingForm));
                chargingForm.querySelector('button[id="createBtn"]').style.display = 'block';
                chargingForm.querySelector('button[id="updateBtn"]').style.display = 'none';
            }
            chargingForm.style.display = 'block';
            repairForm.style.display = 'none';
            hideTables(ev);
            
        } else {
            chargingForm.style.display = 'none';
        }
    });
}

/// Hide Tables ///
function hideTables(ev) {
    ev.preventDefault();
    chargingsContainer.style.display = 'none';
    repairsContainer.style.display = 'none';
}

/// Get repairForm Fields ///
function getRepairFormFields(repairForm) {
    return [
        repairForm.querySelector('textarea[name="description"]'),
        repairForm.querySelector('input[name="amount"]'),
        repairForm.querySelector('input[name="date"]'),
        repairForm.querySelector('input[name="id"]'),
        repairForm.querySelector('a[id="linkToCurrentInvoice"]'),
        repairForm.querySelector('img[id="currentInvoiceImg"]')
    ]
}

/// Get chargingForm Fields ///
function getChargingFormFields(chargingForm) {
    return [
            chargingForm.querySelector('input[name="brand_station"]'),
            chargingForm.querySelector('input[name="amount"]'),
            chargingForm.querySelector('input[name="date"]'),
            chargingForm.querySelector('input[name="id"]'),
        ]
}

/// Set form fields ///
function setFormFields(fields_arr, params=[]) {
    fields_arr.forEach(function (field, idx) {
        if (params[idx]) {
            valueToSet = params[idx]
        } else {
            valueToSet = '';
        }

        if (field.tagName === 'A') {
            field.href = valueToSet;
        } else if (field.tagName === 'IMG') {
            field.src = valueToSet;
        } else {
            field.value = valueToSet;
        }
    })
}

/// Init EventListeners ///
forRepairs();
forChargings();
showChargingsBtn.addEventListener("click", (ev) => {
    // Taxes and others Btn
    ev.preventDefault();

    if (chargingsContainer.style.display == 'none') {
        chargingsContainer.style.display = 'block';
        repairsContainer.style.display = 'block';
        chargingForm.style.display = 'none';
        repairForm.style.display = 'none';
    } else {
        hideTables(ev);
    }
})
