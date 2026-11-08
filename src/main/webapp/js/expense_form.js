const expenseForm = document.getElementById("expense-form");
const descriptionInput = document.getElementById("expense-description");

function validateDescription() {
    descriptionInput.setCustomValidity(
        descriptionInput.value.trim() === ""
            ? "지출 내용을 입력해 주세요."
            : ""
    );
}

descriptionInput.addEventListener("input", validateDescription);
validateDescription();

expenseForm.addEventListener("submit", function (event) {
    event.preventDefault();
    validateDescription();

    if (!expenseForm.reportValidity()) {
        return;
    }

    alert("저장되었습니다.");
    window.location.href = "expense_list.jsp";
});