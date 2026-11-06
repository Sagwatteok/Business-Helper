const expenseCsv = document.getElementById("expense-csv");
const selectedFile = document.getElementById("expense-selected-file");
const fileName = document.getElementById("expense-file-name");
const fileSize = document.getElementById("expense-file-size");
const removeFile = document.getElementById("expense-remove-file");
const uploadError = document.getElementById("expense-csv-error");
const previewButton = document.getElementById("expense-preview-button");

const allowedExtensions = [".csv", ".xls", ".xlsx"];
const maxFileSize = 10 * 1024 * 1024;

function hideFileDetails() {
    selectedFile.hidden = true;
    fileName.textContent = "";
    fileSize.textContent = "";
    previewButton.disabled = true;
}

function showFileError(message) {
    expenseCsv.value = "";
    uploadError.textContent = message;
    uploadError.hidden = false;
}

expenseCsv.addEventListener("change", function () {
    hideFileDetails();
    uploadError.hidden = true;

    const file = expenseCsv.files[0];

    if (!file) {
        return;
    }

    const lowerCaseName = file.name.toLowerCase();

    // 허용된 확장자 중 하나로 끝나는지 확인합니다.
    const isAllowed = allowedExtensions.some(function (extension) {
        return lowerCaseName.endsWith(extension);
    });

    if (!isAllowed) {
        showFileError("CSV, XLS, XLSX 파일만 선택할 수 있습니다.");
        return;
    }

    if (file.size > maxFileSize) {
        showFileError("파일 크기는 10MB 이하여야 합니다.");
        return;
    }

    fileName.textContent = file.name;
    fileSize.textContent = (file.size / 1024).toFixed(1) + " KB";
    selectedFile.hidden = false;
    previewButton.disabled = false;
});

removeFile.addEventListener("click", function () {
    expenseCsv.value = "";
    hideFileDetails();
    uploadError.hidden = true;
});

previewButton.addEventListener("click", function () {
    window.location.href = "expense_preview.jsp";
});