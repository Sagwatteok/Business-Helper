const mappingList = document.getElementById("expense-mapping-list");
const requiredFields = mappingList.querySelectorAll("select[required]");
const nextButton = document.getElementById("expense-mapping-next");

function updateNextButton() {
    const hasEmptyField = Array.from(requiredFields).some(function (field) {
        return field.value === "";
    });

    nextButton.disabled = hasEmptyField;
}

mappingList.addEventListener("change", updateNextButton);
updateNextButton();