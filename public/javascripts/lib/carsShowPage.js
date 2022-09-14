var formButtonsArr = [...document.getElementsByClassName("form_button")];
var tableHeadingsArr = [...document.getElementsByClassName("tableHeading")];
var arrowDown = "<span>&#8595;</span>";
var arrowUp = "<span>&#8593;</span>";


/************  Toggle Tables  *************/
tableHeadingsArr.forEach(heading => {
    heading.addEventListener('click', (event) => {
        event.preventDefault();
        let tbody = heading.parentNode.parentNode.querySelector("tbody");
        let tablePagination = heading.parentNode.parentNode.querySelector('div .tablePagination');

        heading.parentNode.querySelector("span").remove();
        if (tbody.classList.contains("collapse")) {
            tbody.classList.remove("collapse");
            tablePagination.classList.remove("collapse");
            heading.parentNode.insertAdjacentHTML("beforeend", arrowUp);
        } else {
            tbody.classList.add("collapse");
            tablePagination.classList.add("collapse");
            heading.parentNode.insertAdjacentHTML("beforeend", arrowDown);
        }

    });
})

/************   Show/Hide Forms   *************/
formButtonsArr.forEach(button => {
    button.addEventListener("click", (event) => {
        event.preventDefault();
        let buttonId = button.id;
        let targetedFormContainer = document.querySelector(`div[id="${buttonId}"]`);

        if (targetedFormContainer.classList.contains("collapse")) {
            let formContainersArr = [...document.getElementsByClassName('formContainer')];
            formContainersArr.forEach(formContainer => {
                if (formContainer.id == targetedFormContainer.id) { return };
                if (formContainer.classList.contains("collapse")) { return };
                formContainer.classList.add("collapse");
            });

            targetedFormContainer.classList.remove("collapse");
        } else {
            targetedFormContainer.classList.add("collapse");
        }

    })
})

