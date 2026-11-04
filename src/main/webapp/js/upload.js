const salesFile = document.getElementById("salesFile");
const selectedFile = document.getElementById("selectedFile");
const fileName = document.getElementById("fileName");
const fileSize = document.getElementById("fileSize");
const removeFile = document.getElementById("removeFile");
const nextButton = document.getElementById("nextButton");
const uploadError = document.getElementById("uploadError");

const allowedExtensions = ["csv", "xls", "xlsx"];
const maxFileSize = 10 * 1024 * 1024;

salesFile.addEventListener("change", function () {
    const file = salesFile.files[0]; //첫번째 파일의 정보

    if (!file) {
        return;
    }

    const extension = file.name.split(".").pop().toLowerCase();

    if (!allowedExtensions.includes(extension)) {
        showError("CSV, XLS, XLSX 파일만 선택할 수 있습니다.");
        resetFile();
        return;
    }

    if (file.size > maxFileSize) {
        showError("파일 크기는 10MB 이하여야 합니다.");
        resetFile();
        return;
    }

    uploadError.hidden = true;

    fileName.textContent = file.name;
    fileSize.textContent = formatFileSize(file.size);

    selectedFile.hidden = false;
    nextButton.disabled = false;
});


removeFile.addEventListener("click", function () {
    resetFile();
});



function resetFile() { //파일 선택 상태 초기화
    salesFile.value = "";
    selectedFile.hidden = true;
    nextButton.disabled = true;
}

function showError(message) {
    uploadError.textContent = message;
    uploadError.hidden = false;
}

function formatFileSize(size) { //바이트 단위 -> MB 단위로 변환 (1MB = 1024 × 1024byte)
    const sizeInMb = size / (1024 * 1024);

    return sizeInMb.toFixed(2) + "MB"; //소수점 아래 두 자리까지 표시
}